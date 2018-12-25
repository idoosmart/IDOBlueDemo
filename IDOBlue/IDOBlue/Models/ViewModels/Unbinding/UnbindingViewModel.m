//
//  UnbindingViewModel.m
//  IDOBlue
//
//  Created by hedongyang on 2018/10/10.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "UnbindingViewModel.h"
#import "FuncCellModel.h"
#import "OneButtonTableViewCell.h"
#import "FuncViewController.h"
#import "ComLogViewModel.h"
#import "RestartLogViewModel.h"
#import "ScanViewController.h"

@interface UnbindingViewModel()
@property (nonatomic,strong) NSArray * buttonTitles;
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation UnbindingViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getButtonCallback];
        [self getCellModels];
    }
    return self;
}

- (NSArray *)buttonTitles
{
    if (!_buttonTitles) {
        _buttonTitles = @[@[@"设备解绑"],@[@"强制解绑"]];
    }
    return _buttonTitles;
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    for (int i = 0; i < self.buttonTitles.count; i++) {
        NSArray * data = [self.buttonTitles objectAtIndex:i];
        FuncCellModel * model = [[FuncCellModel alloc]init];
        model.typeStr = @"oneButton";
        model.data    = data;
        model.cellHeight = 70.0f;
        model.cellClass  = [OneButtonTableViewCell class];
        model.modelClass = [NSNull class];
        model.buttconCallback = self.buttconCallback;
        [cellModels addObject:model];
    }
    self.cellModels = cellModels;
}

- (void)getButtonCallback
{
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __block FuncViewController * funcVc = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVc.tableView indexPathForCell:tableViewCell];
        if (indexPath.row == 0) {
            [funcVc showLoadingWithMessage:@"设备解绑..."];
            [IDOFoundationCommand unbindingCommand:^(int errorCode) {
                if (errorCode == 0) {
                    [funcVc showToastWithText:@"解绑设备成功"];
                    UINavigationController * rootvc =  (UINavigationController *)[UIApplication sharedApplication].delegate.window.rootViewController;
                    UIViewController * firstvc = [rootvc.viewControllers firstObject];
                    if ([firstvc isKindOfClass:[ScanViewController class]]) {
                        [funcVc dismissViewControllerAnimated:YES completion:nil];
                    }else {
                        [funcVc.navigationController popToRootViewControllerAnimated:NO];
                        ScanViewController * scanVC  = [[ScanViewController alloc]init];
                        UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:scanVC];
                        [firstvc presentViewController:nav animated:YES completion:nil];
                    }
                    [IDOBluetoothManager startScan];
                }else {
                    [funcVc showToastWithText:@"解绑设备失败"];
                }
            }];
        }else {
            [funcVc showLoadingWithMessage:@"设备解绑..."];
            [IDOFoundationCommand mandatoryUnbindingCommand:^(int errorCode) {
                if (errorCode == 0) {
                    [funcVc showToastWithText:@"解绑设备成功"];
                    UINavigationController * rootvc =  (UINavigationController *)[UIApplication sharedApplication].delegate.window.rootViewController;
                    UIViewController * firstvc = [rootvc.viewControllers firstObject];
                    if ([firstvc isKindOfClass:[ScanViewController class]]) {
                        [funcVc dismissViewControllerAnimated:YES completion:nil];
                    }else {
                        [funcVc.navigationController popToRootViewControllerAnimated:NO];
                        ScanViewController * scanVC  = [[ScanViewController alloc]init];
                        UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:scanVC];
                        [firstvc presentViewController:nav animated:YES completion:nil];
                    }
                    [IDOBluetoothManager startScan];
                }else {
                    [funcVc showToastWithText:@"强制解绑失败"];
                }
            }];
        }
    };
}
@end
