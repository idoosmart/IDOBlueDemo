//
//  IDOHomeHealthManager.m
//  IDOVFHome
//
//  Created by 农大浒 on 2022/1/14.
//

#import "IDOHomeHealthManager.h"
#import "IDOH5Manager.h"
#import "IDOWebViewVC.h"
#import "IDORunPlanManager.h"
#import <IDOBlueProtocol/IDOBlueProtocol.h>
@interface IDOHomeHealthManager ()

/**
 是否正在加载总
 */
@property (nonatomic, assign) BOOL loading;


@property (nonatomic,strong) NSDictionary *runPlanDic;

/**
 查询的队列
 */
@property (nonatomic, strong) dispatch_queue_t queue;

@end

@implementation IDOHomeHealthManager

static IDOHomeHealthManager *_mgr = nil;

+ (IDOHomeHealthManager *)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _mgr = [[IDOHomeHealthManager alloc] init];
    });
    return _mgr;
}
- (instancetype)init{
    if(self = [super init]){
        self.queue = dispatch_queue_create("IDOHomeHealthManager.queue", DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}
+ (instancetype)alloc{
    if (_mgr) {
        NSException *exception = [NSException exceptionWithName:@"重复创建IDOVFDownloadManager单例对象异常" reason:@"请使用[IDOVFDownloadManager shareInstance]的单例方法." userInfo:nil];
        [exception raise];
    }
    return [super alloc];
}

- (void)loadRunWithhUserId:(NSString *)userId updateData:(BOOL)updateData block:(void (^)(BOOL result, id obj))block{
    //目前只有一个，所以直接使用
    if (!self.runPlanModel || updateData) {
        [self loadRunPlanManagerDataWithUserId:userId block:^(BOOL result, id obj) {
            if (block) {
                block(result,obj);
            }
        }];
    }else{
        if (block) {
            block(YES,nil);
        }
    }
}

#pragma mark - 加载跑步计划
- (void)loadRunplanManagerDataWithUserId:(NSString *)userId updateData:(BOOL)updateData block:(void (^)(BOOL result, id obj))block{
    
    if (self.loading) {
        return;
    }
    
    self.loading = YES;
    
    dispatch_group_t updateSDKGroup = dispatch_group_create();
    
    dispatch_group_enter(updateSDKGroup);
    __block BOOL isUpdateRun = NO;
    [self loadRunWithhUserId:userId updateData:updateData block:^(BOOL result, id obj) {
        if (!isUpdateRun) {
            isUpdateRun = YES;
            dispatch_group_leave(updateSDKGroup);
        }
    }];
    
    dispatch_group_notify(updateSDKGroup, dispatch_get_main_queue(), ^{
        self.loading = NO;

        if (block) {
            block(YES,nil);
        }
    });
    
}

- (void)loadRunPlanManagerDataWithUserId:(NSString *)userId block:(void (^)(BOOL result, id obj))block{
    IDOVFNewRunPlanNetModel *model = (IDOVFNewRunPlanNetModel *)[IDOVFNewRunPlanNetModel getRunPlan:[IDOHomeHealthManager shareInstance].tokenStr];
    __weak typeof(self) weakSelf = self;
    [IDOVFNewRunPlanNetModel postFormatWithModel:model success:^(id  _Nullable responseObject) {
        if ([IDOVFNewBaseNetModel isSucessWithRep:responseObject]){
            id result = responseObject[@"result"];
            if ([result isKindOfClass:[NSDictionary class]]) {
                NSDictionary *resultDic = result;
                NSDictionary *completeProcessDic = resultDic[@"completeProcess"];
                NSDictionary *planDetailDic = resultDic[@"planDetail"];
                
                IDORunPlanModel *runPlanModel = [[IDORunPlanModel alloc] init];
                runPlanModel.actualProcess = [completeProcessDic[@"actualProcess"] integerValue];
                runPlanModel.totalProcess = [completeProcessDic[@"totalProcess"] integerValue];
                
                runPlanModel.startDate = planDetailDic[@"startDate"];
                runPlanModel.endDate = planDetailDic[@"endDate"];
                
                runPlanModel.planId = [resultDic[@"planId"] integerValue];
                runPlanModel.targetType = [resultDic[@"targetType"] integerValue];
                runPlanModel.targetDurations = [resultDic[@"targetDurations"] integerValue];
                runPlanModel.type = [resultDic[@"type"] integerValue];
                
                NSArray *weekPlans = planDetailDic[@"weekPlans"];
                
                NSMutableArray *subItems = [NSMutableArray array];
                for (NSDictionary *dic in weekPlans) {
                    IDORunPlanWeekPlansModel *weekPlanModel = [[IDORunPlanWeekPlansModel alloc] init];
                    weekPlanModel.isTrain = [dic[@"isTrain"] integerValue];
                    weekPlanModel.isTargetType = [dic[@"targetType"] integerValue];
                    weekPlanModel.isTrainComplete = [dic[@"isTrainComplete"] integerValue];
                    weekPlanModel.weekDay = [dic[@"weekDay"] integerValue];
                    weekPlanModel.date = dic[@"date"];
                    [subItems addObject:weekPlanModel];
                }
                runPlanModel.weekPlans = subItems;
                weakSelf.runPlanModel = runPlanModel;
                
                //获取详情的计划内容
                [weakSelf getDetailPlanContents];
            }else{
                //表示跑步计划结束，需要进度计算结果
                if (weakSelf.runPlanModel) {
                    
                }
                weakSelf.runPlanModel = nil;
            }
        }else{
            weakSelf.runPlanModel = nil;
        }
        
        if (block) {
            block(YES,weakSelf.runPlanModel);
        }
    } fail:^(NSError * _Nullable error) {
        if (block) {
            block(NO,nil);
        }
    }];
}

- (void)getDetailPlanContents{
    IDOVFNewRunPlanNetModel *model = (IDOVFNewRunPlanNetModel *)[IDOVFNewRunPlanNetModel getDetailPlanExecutingIssued:[IDOHomeHealthManager shareInstance].tokenStr];
    model.param = @{@"planId":@(self.runPlanModel.planId)};
    [IDOVFNewRunPlanNetModel postFormatWithModel:model success:^(id  _Nullable responseObject) {
        
        if ([IDOVFNewBaseNetModel isSucessWithRep:responseObject]){
            
            NSDictionary *resultDic = responseObject[@"result"];
            if ([resultDic isKindOfClass:[NSDictionary class]]) {
                self.runPlanDic = resultDic;
                NSString *serverPlan = [[IDORunPlanManager shareInstance] timeStrWithDic:resultDic];
                self.runPlanStr = serverPlan;
                //检测跑步计划,间隔10min在进行检测
                [self repeatCheck];
            }
        }else{
            self.runPlanDic = nil;
            self.runPlanStr = nil;
        }
    } fail:^(NSError * _Nullable error) {
    }];
}

static BOOL checkingRunPlan = NO;
static BOOL showAlertVC = NO;
NSInteger count = 0;
-(void)repeatCheck
{
    NSLog(@"HOME ---- repeatCheck ----- isSyncConfigRun = %d -- isSyncHealthRun = %d",initSyncManager().isSyncConfigRun,initSyncManager().isSyncHealthRun);
    if(initSyncManager().isSyncConfigRun || initSyncManager().isSyncHealthRun)
    {
        if(count > 30)
        {
            return;
        }
        __weak typeof(self) weakSelf = self;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [weakSelf repeatCheck];
            count++;
        });
    }else
    {
        [self checkDeviceRunPlan];
    }
}
- (void)checkDeviceRunPlan{

    if (!__IDO_CONNECTED__ || !__IDO_FUNCTABLE__.funcTable34Model.supportSportPlan ||
        checkingRunPlan ||
        self.runPlanStr.length == 0 ||
        !self.runPlanDic ||
        self.runPlanDic.allValues.count == 0 ||
        !self.runPlanStr
        ) {
        NSLog(@"__IDO_CONNECTED__ = %d supportSportPlan = %d self.runPlanStr.length = %ld , allValues.count = %ld , self.runPlanStr = %@ , deviceID = %ld",__IDO_CONNECTED__,__IDO_FUNCTABLE__.funcTable34Model.supportSportPlan,self.runPlanStr.length,self.runPlanDic.allValues.count,self.runPlanStr,IDO_BLUE_ENGINE.peripheralEngine.deviceId.integerValue);
        return;
    }

    [IDORunPlanManager shareInstance].runPlanDetailBlock = ^(IDOSportPlanDataModel * _Nonnull model) {
        checkingRunPlan = NO;
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(checkoutRunPlanTimeOut) object:nil];
        if (!model || self.runPlanStr.length == 0 || !self.runPlanDic || self.runPlanDic.allValues.count == 0 || !self.runPlanStr) {
            return;
        }
        NSString *devicePlan = [[IDORunPlanManager shareInstance] timeStrWithPlanModel:model];
        NSLog(@"devicePlan:%@  self.runPlanStr:%@ showAlertVC：%d ",devicePlan,self.runPlanStr,showAlertVC);

        //如果当前的计划于设备的计划不一样的情况下，把服务器的计划设置到设备
        if (![self.runPlanStr isEqualToString:devicePlan]) {

            if (devicePlan.length > 0) {
                if (showAlertVC) {
                    return;
                }
                
                showAlertVC = YES;
                
                NSString *title = @"同步跑步计划";
                NSString *decs = @"当前设备的跑步计划与App的跑步计划不一致，是否将App计划同步到设备中？";
                
         
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:decs preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *act1 = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    showAlertVC = NO;
                    NSLog(@"HOME ---- 用户点击了 否 不进行跑步计划设置");
                }];
                UIAlertAction *act2 = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    NSLog(@"HOME ---- 用户点击了 是 进行跑步计划设置");
                    [self setPlanToDeviceShowHUD:YES];
                    showAlertVC = NO;
                }];
                
//                [[IDOUIHelp currentViewController] presentViewController:alert animated:YES completion:nil];
            }else{
                [self setPlanToDeviceShowHUD:NO];
            }
        }
    };

    checkingRunPlan = YES;
    
    [self performSelector:@selector(checkoutRunPlanTimeOut) withObject:nil afterDelay:33];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [[IDORunPlanManager shareInstance] checkDeviceRunPlan];
    });
}

static BOOL settingRunPlan = NO;

- (void)setPlanToDeviceShowHUD:(BOOL)show{
    [IDORunPlanManager shareInstance].setRunPlanDetailBlock = ^(IDOSportPlanDataModel * _Nonnull model) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(setRunPlanToDeviceTimeOut) object:nil];
        NSLog(@"Home ---- 同步计划回调:%ld",model.errorCode);
        settingRunPlan = NO;
        if (show) {
            if (model.errorCode == 0) {
                NSLog(@"同步成功");
            }else{
                NSLog(@"同步失败");
            }
        }else{
            
        }
    };
    
    if (settingRunPlan) {
        return;
    }
    
    settingRunPlan = YES;
    self.isSending = YES;
    if (self.runPlanDic.allValues.count == 0) {
        NSLog(@"不存在有跑步计划:%@",self.runPlanDic);
        return;
    }
    
    if (show) {
        NSLog(@"%@", [NSString stringWithFormat:@" %@ ",@"同步中"]);
    }
    [self performSelector:@selector(setRunPlanToDeviceTimeOut) withObject:nil afterDelay:33];
    __weak typeof(self) weakSelf = self;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [[IDORunPlanManager shareInstance] setRunPlanToDeviceWithDic:weakSelf.runPlanDic];
    });

}

- (void)checkoutRunPlanTimeOut{
    checkingRunPlan = NO;
}

- (void)setRunPlanToDeviceTimeOut{
    checkingRunPlan = NO;
    settingRunPlan = NO;
    self.isSending = NO;
    NSLog(@"同步失败");
}
-(void)blueToothConnectError
{
    checkingRunPlan = NO;
    settingRunPlan = NO;
    self.isSending = NO;
    NSLog(@"同步失败");
}

#pragma mark - 清除内存数据
- (void)clearMemery{
    self.runPlanModel = nil;

}


@end
