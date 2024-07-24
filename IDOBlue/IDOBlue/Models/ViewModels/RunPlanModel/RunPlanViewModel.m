//
//  RunPlanViewModel.m
//  IDOBlue
//
//  Created by LY on 2024/7/23.
//  Copyright © 2024 hedongyang. All rights reserved.
//

#import "RunPlanViewModel.h"
#import "FuncCellModel.h"
#import "OneButtonTableViewCell.h"
#import "TextViewCellModel.h"
#import "OneTextViewTableViewCell.h"
#import "IDODemoUtility.h"
#import "FuncViewController.h"
#import "NSObject+DemoToDic.h"
#import "IDORunPlanManager.h"
#import "IDOSleepManagerVC.h"
#import "IDOHomeHealthManager.h"
#import "IDONetworkManager.h"
@interface RunPlanViewModel ()
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^loginCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);

@property (nonatomic , copy)NSString *token;
@property (nonatomic , copy)NSString *userID;
@property (nonatomic , strong)MBProgressHUD *progressHUD;
/**
 健康管理页面
 */
@property (nonatomic, weak) IDOSleepManagerVC *healthManagerVC;
@end
@implementation RunPlanViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getButtonCallback];
        [self getLoginCallback];
        [self getCellModels];
    }
    return self;
}
- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    FuncCellModel * model = [[FuncCellModel alloc]init];
    model.typeStr = @"oneButton";
    model.data = @[lang(@"get token")];
    model.cellHeight = 70.0f;
    model.cellClass = [OneButtonTableViewCell class];
    model.modelClass = [NSNull class];
    model.isShowLine = YES;
    model.buttconCallback = self.loginCallback;
    [cellModels addObject:model];
    
    FuncCellModel * model2 = [[FuncCellModel alloc]init];
    model2.typeStr = @"oneButton";
    model2.data = @[lang(@"Runing plan")];
    model2.cellHeight = 70.0f;
    model2.cellClass = [OneButtonTableViewCell class];
    model2.modelClass = [NSNull class];
    model2.isShowLine = YES;
    model2.buttconCallback = self.buttconCallback;
    [cellModels addObject:model2];
    self.cellModels = cellModels;
}
- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf startRunPlan:viewController];
    };
}
- (void)getLoginCallback
{
    __weak typeof(self) weakSelf = self;
    self.loginCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf getToken:viewController];
    };
}
-(void)getToken:(UIViewController *)ctl
{
    self.progressHUD.mode = MBProgressHUDModeIndeterminate;
    self.progressHUD.label.text = @"";
    self.progressHUD.frame = ctl.view.frame;
    [ctl.view addSubview:self.progressHUD];
    [self.progressHUD showAnimated:YES];
    
    if (self.token.length > 0) {
        self.progressHUD.label.text = lang(@"Successfully obtained");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.progressHUD hideAnimated:YES];
            self.progressHUD = nil;
        });
        return;
    }
    NSString *url = [@"https://cn-user.idoocloud.com" stringByAppendingString:@"/userapi/public/account/login"];
    NSDictionary *params = @{@"username": @"1234554321@163.com",
                             @"password": @"123456"};
    NSDictionary *header = @{@"appKey": @"9ee5f0aed15e4641818c098376b82241"};
    
    [IDONetworkManager postRequestUrl:url header:header body:params requestSerializerType:kXMRequestSerializerRAW success:^(id  _Nullable responseObject) {
        NSInteger code = [IDONetworkManager statusCode:responseObject];
        if (code == 200) {
            [IDOHomeHealthManager shareInstance].tokenStr = [responseObject objectForKey:@"result"];
            self.token = [responseObject objectForKey:@"result"];
            self.progressHUD.label.text = lang(@"Successfully obtained");
        }else{
            self.progressHUD.label.text = [responseObject objectForKey:@"message"];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.progressHUD hideAnimated:YES];
            self.progressHUD = nil;
        });
    } fail:^(NSError * _Nullable error) {
        self.progressHUD.label.text = lang(@"Acquisition failed");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.progressHUD hideAnimated:YES];
            self.progressHUD = nil;
        });
    }];
}
-(void)startRunPlan:(UIViewController *)ctl
{
    if(self.token.length <= 0)
    {
        self.progressHUD.mode = MBProgressHUDModeText;
        self.progressHUD.label.text = lang(@"Please obtain the Token first");
        self.progressHUD.frame = ctl.view.frame;
        [ctl.view addSubview:self.progressHUD];
        [self.progressHUD showAnimated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.progressHUD hideAnimated:YES];
            self.progressHUD = nil;
        });
        return;
    }
    NSString *url = [self getSleepManagerUrl:@"running"];
    
    if (url.length == 0) {
        return;
    }
    __weak typeof(self) weakSelf = self;
    [IDORunPlanManager shareInstance].clickBackBlock = ^{
        [weakSelf loadHealthManager:YES];
    };
    
    NSLog(@"跑步计划 url:%@",url);
    IDOSleepManagerVC *healthManagerVC = [[IDOSleepManagerVC alloc] init];
    self.healthManagerVC = healthManagerVC;
    self.healthManagerVC.URL = [NSURL URLWithString:url];
    self.healthManagerVC.hiddenCustomNavigationBar = YES;
    healthManagerVC.hidesBottomBarWhenPushed = YES;
    healthManagerVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [ctl presentViewController:healthManagerVC animated:YES completion:nil];

    //注册方法，方便h5主动查询用户信息
    [[IDORunPlanManager shareInstance] h5QueryUserInfoWithVC:self.healthManagerVC];
    [IDORunPlanManager shareInstance].currentPlanTimeStr = [IDOHomeHealthManager shareInstance].runPlanStr;
}
///动态获取睡眠、跑步计划的URL
- (NSString *)getSleepManagerUrl:(NSString *)cmd{

    return [NSString stringWithFormat:@"https://cn-healthmanage.idoocloud.com/%@", cmd];
}
-(void)loadHealthManager:(BOOL)update
{
    [[IDOHomeHealthManager shareInstance] loadRunplanManagerDataWithUserId:self.userID updateData:update block:^(BOOL result, id  _Nonnull obj){
        NSLog(@"Home -跑步计划 loadRunplanManagerDataWithUserId runPlan:%@",[IDOHomeHealthManager shareInstance].runPlanModel);
        
    }];
}
- (MBProgressHUD *)progressHUD
{
    if (!_progressHUD) {
        _progressHUD = [[MBProgressHUD alloc] init];
    }
    return _progressHUD;
}
@end
