//
//  IDOTranningManager.m
//  IDOVFHome
//
//  Created by mac2019 on 2022/5/27.
//

#import "IDOTranningManager.h"
#import "IDOH5Manager.h"
#import "IDOSportRunModel.h"
#import "IDOSportRunLocationManager.h"
#import "IDOSportTypeModel.h"
#import "YYModel.h"
#import "AppDelegate.h"
/**
 运动计划的操作类型
 */
typedef NS_OPTIONS(NSUInteger, IDORuningOperateType)
{
    IDORuningOperateTypeStart = 1, //开始
    IDORuningOperateTypePauce = 2, //暂停
    IDORuningOperateTypeRestore = 3, //恢复
    IDORuningOperateTypeStop = 4, //停止
    IDORuningOperateTypeChangeAction = 5, //切换动作
};

/**
 计算心率平均值的类型
 */
typedef NS_OPTIONS(NSUInteger, IDORuningSendHrAvgType)
{
    IDORuningSendHrAvgTypeNone = 0, //无效状态
    IDORuningSendHrAvgTypeStart = 1, //开始
    IDORuningSendHrAvgTypeManuPauce = 2, //手动暂停
    IDORuningSendHrAvgTypeStop = 3, //停止
    IDORuningSendHrAvgTypeAutoPauce = 4, //自动暂停
};



@interface IDOTranningManager ()<IDODataExchangeManagerDelegate>
/**
 开始运动的模型
 */
@property (nonatomic,strong) IDOAppStartExchangeModel *startExchangeModel;

/**
 结束运动的模型
 */
@property (nonatomic,strong) IDOAppEndExchangeModel *endExchangeModel;

#pragma mark - 跑步计划
@property (nonatomic,strong) IDOAppOperatePlanExchangeModel *planExchangeModel;

///总运动秒数
@property (nonatomic, assign) NSInteger allTimeCount;

///每秒计时NSTimer
@property (nonatomic, strong) NSTimer *freshTimer;

@property (nonatomic,assign) BOOL running;

/**
 当前是否已经停止了训练
 */
@property (nonatomic,assign) BOOL stopRun;

/**
 心率数据的模型
 */
@property (nonatomic,strong) NSMutableArray *hrValueArray;
/**
 临时的心率数组，运动每2min后，用于与计算30秒内的平均心率
 */
@property (nonatomic,strong) NSMutableArray *tempHrArr;

@property (nonatomic,copy) NSString *time_str;

/**
 点击了停止
 */
@property (nonatomic,assign) BOOL clickStop;

@property (nonatomic,assign) BOOL sportFromApp;

/**
 用户手动点击的停止
 */
@property (nonatomic,assign) BOOL stopRunFromApp;

@end

@implementation IDOTranningManager

static IDOTranningManager *_mgr = nil;

+ (IDOTranningManager *)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _mgr = [[IDOTranningManager alloc] init];
    });
    return _mgr;
}

- (instancetype)init{
    if (self = [super init]) {
        //app回到后台
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackgroundNotification) name:UIApplicationDidEnterBackgroundNotification object:nil];
        
        //已经进入到当前页面
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActiveNotification) name:UIApplicationDidBecomeActiveNotification object:nil];
    }
    return self;
}

+ (instancetype)alloc{
    if (_mgr) {
        NSException *exception = [NSException exceptionWithName:@"重复创建IDOTranningManager单例对象异常" reason:@"请使用[IDOTranningManager shareInstance]的单例方法." userInfo:nil];
        [exception raise];
    }
    return [super alloc];
}

#pragma mark - 通知
- (void)applicationDidEnterBackgroundNotification{
    if (self.running) {
        
    }
}

- (void)applicationDidBecomeActiveNotification{
    if (self.running) {
       
    }
}



#pragma mark  懒加载

- (NSMutableArray *)tempHrArr{
    if (!_tempHrArr) {
        _tempHrArr = [NSMutableArray array];
    }
    return _tempHrArr;
}

- (NSMutableArray *)hrValueArray{
    if (!_hrValueArray) {
        _hrValueArray = [NSMutableArray array];
    }
    return _hrValueArray;
}

- (IDOAppOperatePlanExchangeModel *)planExchangeModel{
    if (!_planExchangeModel) {
        _planExchangeModel = [[IDOAppOperatePlanExchangeModel alloc] init];
    }
    return _planExchangeModel;
}

- (IDOAppStartExchangeModel *)startExchangeModel
{
    if (!_startExchangeModel) {
        _startExchangeModel = [IDOAppStartExchangeModel new];
        _startExchangeModel.forceStart = 1;
    }
    return _startExchangeModel;
}

- (IDOAppEndExchangeModel *)endExchangeModel
{
    if (!_endExchangeModel) {
        _endExchangeModel = [IDOAppEndExchangeModel new];
    }
    return _endExchangeModel;
}

#pragma mark - 内部方法
- (void)initNSTime {
    _allTimeCount = 0;
    if (_freshTimer) {
        [_freshTimer invalidate];
        _freshTimer = nil;
    }
    _freshTimer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(UpdateDateInTime:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_freshTimer forMode:NSDefaultRunLoopMode];
    
    
}

- (void)finishTimer{
    if (self.freshTimer) {
        [self.freshTimer invalidate];
        self.freshTimer = nil;
    }
}

- (void)UpdateDateInTime:(NSTimer *)timer{
    
    if (!self.running) {
        NSLog(@"发起数据交换失败,当前已经停止运动 __IDO_MAC_ADDR__：%@",__IDO_MAC_ADDR__);
        return;
    }
    _allTimeCount ++;

    if (_allTimeCount % 25 == 0) {
        [self sendV3HeartData];
    }
    /**< V2V3交换数据 2秒一次 */
    if (_allTimeCount % 2 == 0 && _allTimeCount % 25 != 0 && _allTimeCount % 40 != 0) {
        if ([IDODataExchangeManager shareInstance].isV3ActivityExchange) {
            [self sendV3Data];
        }else{
            [self sendV2Data];
        }
    }
}

//获取小节数据
- (void)sendGetEndV3Data{
    if (![IDODataExchangeManager shareInstance].isV3ActivityExchange || !__IDO_CONNECTED__) {
        NSLog(@"sendGetEndV3Data fail:%d  __IDO_CONNECTED__:%d",[IDODataExchangeManager shareInstance].isV3ActivityExchange,__IDO_CONNECTED__);
        return;
    }
    NSError *error = nil;
    NSLog(@"发起获取v3小节数据 __IDO_MAC_ADDR__：%@",__IDO_MAC_ADDR__);
    [IDODataExchangeManager v3_getActivityEndDataWithError:&error];
    if (error) {
        NSLog(@"发起获取v3小节数据失败：%@",error);
    }
}

//v3交换心率数据
- (void)sendV3HeartData{
    if (![IDODataExchangeManager shareInstance].isV3ActivityExchange || !__IDO_CONNECTED__) {
        NSLog(@"sendV3HeartData fail:%d  __IDO_CONNECTED__:%d",[IDODataExchangeManager shareInstance].isV3ActivityExchange,__IDO_CONNECTED__);
        return;
    }
    NSError *error = nil;
    NSLog(@"发起获取v3心率数据 __IDO_MAC_ADDR__：%@",__IDO_MAC_ADDR__);
    [IDODataExchangeManager v3_getActivityHrDataWithError:&error];
    if (error) {
        NSLog(@"发起v3心率数据交换失败：%@",error);
    }
}

//发起v3的交换数据
- (void)sendV3Data{
    if (![IDODataExchangeManager shareInstance].isV3ActivityExchange || !__IDO_CONNECTED__) {
        NSLog(@"sendV3Data fail:%d  __IDO_CONNECTED__:%d",[IDODataExchangeManager shareInstance].isV3ActivityExchange,__IDO_CONNECTED__);
        return;
    }
    
    IDOV3DataExchangeModel *v3Model = [IDODataExchangeManager shareInstance].v3Model;
    
    IDOV3AppIngDataExchangeModel *exchangeModel = [[IDOV3AppIngDataExchangeModel alloc] init];
    exchangeModel.durations = v3Model.durations;
    exchangeModel.calories = v3Model.calories;
    
    //在数据交换的过程中，如果signalFlag = 1，则不会从固件中获取到距离
    exchangeModel.signalFlag = [IDOSportRunLocationManager shareInstance].signalFlag;
    exchangeModel.distance = (exchangeModel.signalFlag == 0) ? v3Model.distance : [IDOSportRunLocationManager shareInstance].totalDistances;
    if (__IDO_FUNCTABLE__.funcTable34Model.supportSportPlan) {
        exchangeModel.sportType = 0;
        exchangeModel.day = self.planExchangeModel.day;
        exchangeModel.hour = self.planExchangeModel.hour;
        exchangeModel.minute = self.planExchangeModel.minute;
        exchangeModel.second = self.planExchangeModel.second;
    }else{
        exchangeModel.sportType = self.startExchangeModel.sportType;
        exchangeModel.day = self.startExchangeModel.day;
        exchangeModel.hour = self.startExchangeModel.hour;
        exchangeModel.minute = self.startExchangeModel.minute;
        exchangeModel.second = self.startExchangeModel.second;
    }
    
    NSError *error = nil;
    NSLog(@"发起v3数据交换 __IDO_MAC_ADDR__：%@  exchangeModel:%@",__IDO_MAC_ADDR__,exchangeModel.yy_modelToJSONString);
    [IDODataExchangeManager v3_appIngSportCommandWithModel:exchangeModel error:&error];
    if (error) {
        NSLog(@"发起v3数据交换失败：%@",error);
    }
}

//发起v2的数据交换
- (void)sendV2Data{
    if ([IDODataExchangeManager shareInstance].isV3ActivityExchange || !__IDO_CONNECTED__) {
        NSLog(@"sendV2Data fail:%d  __IDO_CONNECTED__:%d",[IDODataExchangeManager shareInstance].isV3ActivityExchange,__IDO_CONNECTED__);
        return;
    }

    IDOV2DataExchangeModel *v2Model = [IDODataExchangeManager shareInstance].v2Model;
    
    IDOV2AppIngDataExchangeModel *exchangeModel = [[IDOV2AppIngDataExchangeModel alloc] init];
    exchangeModel.durations = v2Model.durations;
    exchangeModel.calories = v2Model.calories;
    exchangeModel.sportType = self.planExchangeModel.planType;
    exchangeModel.distance = v2Model.distance;
    
    IDOSetTimeInfoBluetoothModel * timeModel = [IDOSetTimeInfoBluetoothModel currentModel];
    exchangeModel.day = timeModel.day;
    exchangeModel.hour = timeModel.hour;
    exchangeModel.minute = timeModel.minute;
    exchangeModel.second = timeModel.second;
    exchangeModel.sportType = self.startExchangeModel.sportType;

    NSError *error = nil;
    NSLog(@"发起v2数据交换失败 __IDO_MAC_ADDR__：%@",__IDO_MAC_ADDR__);
    [IDODataExchangeManager v2_appIngSportCommandWithModel:exchangeModel error:&error];
    if (error) {
        NSLog(@"发起v2数据交换失败：%@",error);
    }
}

/**
 结束训练
 
 结束训练之后，需要去获取最后一次的训练数据和心率
 */
- (void)endPlanTranning{
    
    //如果当前是断开了连接，则直接存储数据
    if (!__IDO_CONNECTED__ || ![IDODataExchangeManager shareInstance].isV3ActivityExchange) {
        [self sportEndAndSaveData];
        return;
    }
    
    //发起获取心率数据
    [self sendV3HeartData];
    
    //获取最后一次的数据
    [self sendGetEndV3Data];
    
}

- (void)saveV3HrDatas:(IDOHrDataExchangeModel *)hrModel{
    /**< V3 */
    if (__IDO_FUNCTABLE__.funcTable30Model.v3ActivityExchangeData && hrModel.hrValues.count > 0) {
        for (NSNumber *value in hrModel.hrValues) {
            if ([value integerValue] >= 30 && [value integerValue] <= 200) {
                [self.hrValueArray addObject:value];
            }
        }
    }
}

- (void)modelWithDic:(NSDictionary *)paramDic{
    NSInteger day = [paramDic[@"day"] integerValue];
    NSInteger hour = [paramDic[@"hour"] integerValue];
    NSInteger minute = [paramDic[@"minute"] integerValue];
    NSInteger second = [paramDic[@"second"] integerValue];
    NSInteger type = [paramDic[@"type"] integerValue];
    NSInteger trainingOffset = [paramDic[@"training_offset"] integerValue];
    
    self.planExchangeModel.trainingOffset = trainingOffset;
    self.planExchangeModel.day = day;
    self.planExchangeModel.hour = hour;
    self.planExchangeModel.minute = minute;
    self.planExchangeModel.second = second;
    self.planExchangeModel.planType = type;
    
}

#pragma mark - 对外接口

//开始运动

/**
 开始运动后，需要每间隔2s区获取一个数据交换
 */
- (void)startPlanTranningWithDic:(NSDictionary *)dic{

    [self initDefaultData];
    
    //禁止返回
    [[IDOH5Manager shareInstance] panDisableBack];
    
    NSError *error = nil;
    [IDODataExchangeManager shareInstance].delegate = self;
    
    IDOSetTimeInfoBluetoothModel * timeModel = [[IDOSetTimeInfoBluetoothModel alloc] init];
    _time_str = timeModel.timeStamp;
    
    //开始进行定位
    [[IDOSportRunLocationManager shareInstance] startUpdatingLocationWithTimestamp:[self.time_str integerValue]];

    NSLog(@"发起跑步计划训练:%@",dic);
    
    //如果是支持跑步计划的，则发起跑步计划的训练
    if (__IDO_FUNCTABLE__.funcTable34Model.supportSportPlan) {
        [self modelWithDic:dic];
        self.planExchangeModel.operate = IDORuningOperateTypeStart;
        [IDODataExchangeManager appPlanSportCommandWithModel:self.planExchangeModel error:&error];
        if (error) {
            NSLog(@"计划 发起开始失败 type:%@  error:%@",dic,error);
            [[IDOH5Manager shareInstance] sendToH5State:IDOHomeRuningPlanTypeStartTrainingFail data:@""];
        }
    }else{
        self.startExchangeModel.sportType = IDOAllSportTypeOutsideRun;
        self.startExchangeModel.day = timeModel.day;
        self.startExchangeModel.hour = timeModel.hour;
        self.startExchangeModel.minute = timeModel.minute;
        self.startExchangeModel.second = timeModel.second;
        [IDODataExchangeManager appStartSportCommandWithModel:self.startExchangeModel error:&error];
        if (error) {
            NSLog(@"旧设备 发起开始失败 startExchangeModel:%@  error:%@",self.startExchangeModel.yy_modelToJSONString,error);
            [[IDOH5Manager shareInstance] sendToH5State:IDOHomeRuningPlanTypeStartTrainingFail data:@""];
        }
    }
}


- (void)pancePlanTranning{
    
    [self.freshTimer setFireDate:[NSDate distantFuture]];
    self.running = NO;
    NSError *error = nil;
    if (__IDO_FUNCTABLE__.funcTable34Model.supportSportPlan) {
        self.planExchangeModel.operate = IDORuningOperateTypePauce;
        NSLog(@"暂停计划:%@",self.planExchangeModel.yy_modelToJSONString);
        [IDODataExchangeManager appPlanSportCommandWithModel:self.planExchangeModel error:&error];
        if (error) {
            NSLog(@"计划 发起暂停失败 planExchangeModel:%@  error:%@",self.planExchangeModel.yy_modelToJSONString,error);
            [[IDOH5Manager shareInstance] sendToH5State:IDOHomeRuningPlanTypeSuspendTrainingFail data:@""];
        }
    }else{
        NSLog(@"暂停训练:%@",self.startExchangeModel.yy_modelToJSONString);
        [IDODataExchangeManager appPauseSportCommandWithModel:self.startExchangeModel error:&error];
        if (error) {
            NSLog(@"暂停失败 error:%@",error);
            [[IDOH5Manager shareInstance] sendToH5State:IDOHomeRuningPlanTypeSuspendTrainingFail data:@""];
        }
    }
}

- (void)restorePlanTranning{
    [self.freshTimer setFireDate:[NSDate distantPast]];
    self.running = NO;
    NSError *error = nil;
    
    if (__IDO_FUNCTABLE__.funcTable34Model.supportSportPlan) {
        self.planExchangeModel.operate = IDORuningOperateTypeRestore;
        NSLog(@"恢复计划planExchangeModel：%@",self.planExchangeModel.yy_modelToJSONString);
        [IDODataExchangeManager appPlanSportCommandWithModel:self.planExchangeModel error:&error];
        if (error) {
            NSLog(@"计划 发起恢复运动失败 planExchangeModel:%@  error:%@",self.planExchangeModel.yy_modelToJSONString,error);
            [[IDOH5Manager shareInstance] sendToH5State:IDOHomeRuningPlanTypeRenewTrainingFail data:@""];
        }
    }else{
        NSLog(@"恢复训练planExchangeModel：%@",self.startExchangeModel.yy_modelToJSONString);
        [IDODataExchangeManager appRestoreSportCommandWithModel:self.startExchangeModel error:&error];
        if (error) {
            NSLog(@"恢复训练失败planExchangeModel：%@ error:%@",self.startExchangeModel.yy_modelToJSONString,error);
            [[IDOH5Manager shareInstance] sendToH5State:IDOHomeRuningPlanTypeRenewTrainingFail data:@""];
        }
    }
}


- (void)stopPlanTranning{
    [self.freshTimer setFireDate:[NSDate distantFuture]];
    self.running = NO;
    NSError *error = nil;
    [self finishTimer];
    
    self.stopRunFromApp = YES;
    
    if (__IDO_FUNCTABLE__.funcTable34Model.supportSportPlan){
        self.planExchangeModel.operate = IDORuningOperateTypeStop;
        NSLog(@"计划 发起停止训练 planExchangeModel:%@ ",self.planExchangeModel.yy_modelToJSONString);
        if (!__IDO_CONNECTED__) {
            [self stopSportSuccess];
            return;
        }
        [IDODataExchangeManager appPlanSportCommandWithModel:self.planExchangeModel error:&error];
        if (error) {
            self.clickStop = YES;
            NSLog(@"计划 发起恢复运动失败 planExchangeModel:%@  error:%@",self.planExchangeModel.yy_modelToJSONString,error);
            [[IDOH5Manager shareInstance] sendToH5State:IDOHomeRuningPlanTypeStopTrainingFail data:@""];
        }
    }else{
        self.endExchangeModel.day = self.startExchangeModel.day;
        self.endExchangeModel.hour = self.startExchangeModel.hour;
        self.endExchangeModel.minute = self.startExchangeModel.minute;
        self.endExchangeModel.second = self.startExchangeModel.second;
        self.endExchangeModel.sportType = self.startExchangeModel.sportType;
        
        NSLog(@"结束训练planExchangeModel：%@",self.endExchangeModel.yy_modelToJSONString);
        [IDODataExchangeManager appEndSportCommandWithModel:self.endExchangeModel error:&error];
        if (error) {
            self.clickStop = YES;
            NSLog(@"结束训练失败planExchangeModel：%@ error:%@",self.endExchangeModel.yy_modelToJSONString,error);
            [[IDOH5Manager shareInstance] sendToH5State:IDOHomeRuningPlanTypeStopTrainingFail data:@""];
        }
    }
}

#pragma mark - 处理训练计划相关的数据

//处理训练计划操作的成功回调
- (void)handleSuccessPlanModel:(NSInteger)operate{
    switch (operate) {
        case IDORuningOperateTypeStart:
        {
            self.running = YES;
            //开启定时器
            [self initNSTime];
            [[IDOH5Manager shareInstance] sendToH5State:IDOHomeRuningPlanTypeStartTraining data:@""];
            UIApplicationState state = [UIApplication sharedApplication].applicationState;
        

        }
            break;
        case IDORuningOperateTypePauce:
        {
            self.running = NO;
            [self.freshTimer setFireDate:[NSDate distantFuture]];
            [[IDOH5Manager shareInstance] sendToH5State:IDOHomeRuningPlanTypeSuspendTraining data:@""];
        }
            break;
        case IDORuningOperateTypeRestore:
        {
            self.running = YES;
            [self.freshTimer setFireDate:[NSDate distantPast]];
            [[IDOH5Manager shareInstance] sendToH5State:IDOHomeRuningPlanTypeRenewTraining data:@""];
        }
            break;
        case IDORuningOperateTypeStop:
        {
            
            self.running = NO;
            [self finishTimer];
            [[IDOH5Manager shareInstance] sendToH5State:IDOHomeRuningPlanTypeStopTraining data:@""];
            [self stopSportSuccess];
        }
            break;
            
        default:
            break;
    }
}

//处理训练计划操作的成功回调
- (void)handleFailPlanModel:(NSInteger)operate{
    switch (operate) {
        case IDORuningOperateTypeStart:
        {
            [[IDOH5Manager shareInstance] sendToH5State:IDOHomeRuningPlanTypeStartTrainingFail data:@""];
        }
            break;
        case IDORuningOperateTypePauce:
        {
            [[IDOH5Manager shareInstance] sendToH5State:IDOHomeRuningPlanTypeSuspendTrainingFail data:@""];
        }
            break;
        case IDORuningOperateTypeRestore:
        {
            [[IDOH5Manager shareInstance] sendToH5State:IDOHomeRuningPlanTypeRenewTrainingFail data:@""];
        }
            break;
        case IDORuningOperateTypeStop:
        {
            [[IDOH5Manager shareInstance] sendToH5State:IDOHomeRuningPlanTypeStopTrainingFail data:@""];
        }
            break;
        default:
            break;
    }
}

- (NSDictionary *)v3_exchangeDicWithModel:(IDOV3DataExchangeModel *)model{
    NSDictionary *param = @{
        @"count_hour" : @(model.countHour),
        @"count_minute" : @(model.countMinute),
        @"count_second" : @(model.countSecond),
        @"progress" : @(self.allTimeCount),
        @"distance" : @(model.distance),
        @"bluetoothStatus" : (__IDO_CONNECTED__ ? @"YES" : @"NO"),
        @"duration" : @(model.durations),
        @"real_time_speed" : @(model.realTimeSpeed),
        @"calories" : @(model.calories),
        @"steps" : @(model.step),
        @"heart_rate" : @(model.curHrValue)
    };
    
    //根据h5的要求，只有是支持跑步计划的才需要这样子
    if (__IDO_FUNCTABLE__.funcTable34Model.supportSportPlan) {
        if (self.allTimeCount % 120  >= 0) {
            NSInteger mCount = self.allTimeCount % 120;
            if (model.curHrValue >= 20 && model.curHrValue <= 250) {
                if (mCount <= 32) {
                    [self.tempHrArr addObject:@(model.curHrValue).stringValue];
                }
            }
            
            //如果是在运动过程中，取到了30秒钟的数据之后，就计算出当前的心率平均值
            if (self.tempHrArr.count >= 15) {
                [self culHrAvgValueToH5:IDORuningSendHrAvgTypeNone];
                [self.tempHrArr removeAllObjects];
            }
        }
    }
    
    NSLog(@"传入到h5的交互数据:%@",param);

    return param;
}


- (NSDictionary *)runningPlanCurrentTrainingRecordToWebDic{
    IDOV3DataExchangeModel * exchageModel = [IDODataExchangeManager shareInstance].v3Model;
    NSMutableArray *actionItems = [NSMutableArray array];
    for (NSDictionary *dic in exchageModel.actionData) {
        NSMutableDictionary *nDic = [NSMutableDictionary dictionary];
        [nDic setValue:dic[@"time"] forKey:@"actual_time"];
        [nDic setValue:dic[@"goal_time"] forKey:@"goal_time"];
        [nDic setValue:dic[@"type"] forKey:@"type"];
        [nDic setValue:dic[@"heart_con_value"] forKey:@"heart_value"];
        [actionItems addObject:nDic];
    }
    
    NSDictionary *param = @{
        @"completionRate" : @(exchageModel.completionRate),
        @"hrCompletionRate" : @(exchageModel.hrCompletionRate),
        @"inClassCalories" : @(exchageModel.inClassCalories),
        @"runningPullUp" : actionItems,
        @"distance" : @(exchageModel.distance),
        @"totalSeconds" : @(exchageModel.durations),
        @"numSteps" : @(exchageModel.step)
    };
    
    NSLog(@"训练结束之后的数据:runningPlanCurrentTrainingRecordToWebDic :%@  actionDataCount：%ld",param,exchageModel.actionDataCount);
    
    return param;
}

/**
 计算当前的平均心率到h5
 */
- (void)culHrAvgValueToH5:(IDORuningSendHrAvgType)type{
    
    if (__IDO_FUNCTABLE__.funcTable34Model.supportSportPlan) {
        NSInteger avgHr = self.tempHrArr.count > 0 ? round([[self.tempHrArr valueForKeyPath:@"@avg.floatValue"] floatValue]) : 0;
        if (avgHr == 0) {
            return;
        }
        NSDictionary *dic = @{
            @"averageHeartRate" : @(avgHr),
            @"status" : @(type)
        };
        
        [[IDOH5Manager shareInstance] sendDataToH5:dic param:@"runningPlanSendAverageHeartRateToWeb"];
    }
}

/**
 结束运动后，保存数据
 */
- (void)sportEndAndSaveData{
    
    if (!__IDO_FUNCTABLE__.funcTable34Model.supportSportPlan) {
        [[IDOSportRunLocationManager shareInstance] stopLocation];
    }
    
    if (__IDO_FUNCTABLE__.funcTable34Model.supportSportPlan) {
        NSDictionary *dic = [self runningPlanCurrentTrainingRecordToWebDic];
        NSLog(@"训练结束 runningPlanCurrentTrainingRecordToWeb : %@",dic);
        [[IDOH5Manager shareInstance] sendDataToH5:dic param:@"runningPlanCurrentTrainingRecordToWeb"];
    }
    
    //获取所有的心率数据
    if ([IDODataExchangeManager shareInstance].v3Model.durations > 60) {
        
        //如果存在有轨迹
        if ([IDOSportRunLocationManager shareInstance].railModels.count > 0) {
            NSArray *datas = [[IDOSportRunLocationManager shareInstance].railModels copy];
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
//                [IDOSRailModel saveObjects:datas];
            });
        }
        AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
//        IDOCoreSportRecordModel *recordModel = [IDOSportRunModel v3_exchangeModelToResource:[IDODataExchangeManager shareInstance].v3Model
//                                                                                  timestamp:self.time_str.integerValue
//                                                                                   hrValues:self.hrValueArray
//                                                                                 sourceType:IDOSportSourceAPPLinkageDevice
//                                                                                  railArray:[IDOSportRunLocationManager shareInstance].railModels
//                                                                                     userId:del.userID];
//        
//        [[IDOVFSportRecordDBManager shareInstance] saveModels:@[recordModel] isSDK:YES block:^(BOOL result, id  _Nonnull obj) {
//            NSLog(@"存储数据成功:发出通知");
//            /**< 通知首页去刷新 */
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"SPORT_DETAIL_SAVE_COMPLETE" object:nil];
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"kUpdateSleepScheduleNoticeKey" object:kUploadRunDataToServer];
//        }];
    }
    
    [self initDefaultData];
}





- (void)initDefaultData{
    NSLog(@"delegat 被销毁了");
    [self.tempHrArr removeAllObjects];
    [self.hrValueArray removeAllObjects];
    self.time_str = nil;
    self.running = NO;
    self.allTimeCount = 0;
    self.clickStop = NO;
    self.sportFromApp = NO;
    self.stopRun = NO;
    self.stopRunFromApp = NO;
    [IDODataExchangeManager shareInstance].delegate = nil;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"AppPlanTranningDidFinishNotification" object:nil];
    [[IDOSportRunLocationManager shareInstance] clearAllData];
}

//停止运动成功
- (void)stopSportSuccess{
    
    NSLog(@"stopSportSuccess");
    
    if (self.stopRun) {
        return;
    }
    
    //如果回到变态的时候清除本地存储

    
    [[IDOH5Manager shareInstance] sendToH5State:IDOHomeRuningPlanTypeStopTraining data:@""];
    self.running = NO;
    self.stopRun = YES;

    if ([IDODataExchangeManager shareInstance].isV3ActivityExchange) {
        self.clickStop = YES;
        [self endPlanTranning];
    }else{
        [self initDefaultData];
    }
    [self finishTimer];
}

#pragma mark - IDODataExchangeManagerDelegate


//ble停止app运动
- (void)bleEndAppSportWithModel:(IDOBleEndExchangeModel *)model errorCode:(int)errorCode{
    NSLog(@"bleEndAppSportWithModel errorCode:%d  model:%@",errorCode,model.yy_modelToJSONString);
    if (errorCode == 0) {
        if (__IDO_FUNCTABLE__.funcTable34Model.supportSportPlan) {
            [self stopSportSuccess];
        }
    }else{
        [[IDOH5Manager shareInstance] sendToH5State:IDOHomeRuningPlanTypeStopTrainingFail data:@""];
    }
}
//ble暂停app运动
- (void)blePauseAppSportWithModel:(IDONewDataExchangeModel *)model errorCode:(int)errorCode{
    NSLog(@"blePauseAppSportWithModel errorCode:%d",errorCode);
    if (errorCode == 0) {
        self.running = NO;
        [self.freshTimer setFireDate:[NSDate distantFuture]];
        [[IDOH5Manager shareInstance] sendToH5State:IDOHomeRuningPlanTypeSuspendTraining data:@""];
    }else{
        [[IDOH5Manager shareInstance] sendToH5State:IDOHomeRuningPlanTypeSuspendTrainingFail data:@""];
    }
}
//ble恢复app运动
- (void)bleRestoreAppSportWithModel:(IDONewDataExchangeModel *)model errorCode:(int)errorCode{
    NSLog(@"bleRestoreAppSportWithModel errorCode:%d ",errorCode);
    if (errorCode == 0) {
        self.running = YES;
        [self.freshTimer setFireDate:[NSDate distantPast]];
        [[IDOH5Manager shareInstance] sendToH5State:IDOHomeRuningPlanTypeRenewTraining data:@""];
    }else{
        [[IDOH5Manager shareInstance] sendToH5State:IDOHomeRuningPlanTypeRenewTrainingFail data:@""];
    }
}

//app运动开始ble回复
- (void)appStartSportReplyWithModel:(IDOAppStartReplyExchangeModel *)model errorCode:(int)errorCode{
    NSLog(@"appStartSportReplyWithModel errorCode:%d  model:%@",errorCode,model.yy_modelToJSONString);
    
    if (errorCode == 0) {
        self.running = YES;
        //开启定时器
        [self initNSTime];
        [[IDOH5Manager shareInstance] sendToH5State:IDOHomeRuningPlanTypeStartTraining data:@""];
        self.sportFromApp = YES;
        UIApplicationState state = [UIApplication sharedApplication].applicationState;
       
    }else{
        [[IDOH5Manager shareInstance] sendToH5State:IDOHomeRuningPlanTypeStartTrainingFail data:@""];
    }
}
//app运动暂停ble回复
- (void)appPauseSportReplyWithModel:(IDOAppPauseReplyExchangeModel *)model errorCode:(int)errorCode{
    NSLog(@"appPauseSportReplyWithModel errorCode:%d  model:%@",errorCode,model.yy_modelToJSONString);
    if (errorCode == 0) {
        self.running = NO;
        [self.freshTimer setFireDate:[NSDate distantFuture]];
        [[IDOH5Manager shareInstance] sendToH5State:IDOHomeRuningPlanTypeSuspendTraining data:@""];
    }else{
        [[IDOH5Manager shareInstance] sendToH5State:IDOHomeRuningPlanTypeSuspendTrainingFail data:@""];
    }
    
}
//app运动回复ble回复
- (void)appRestoreSportReplyWithModel:(IDOAppRestoreReplyExchangeModel *)model errorCode:(int)errorCode{
    NSLog(@"appRestoreSportReplyWithModel errorCode:%d  model:%@",errorCode,model.yy_modelToJSONString);
    if (errorCode == 0) {
        self.running = YES;
        [self.freshTimer setFireDate:[NSDate distantPast]];
        [[IDOH5Manager shareInstance] sendToH5State:IDOHomeRuningPlanTypeRenewTraining data:@""];
    }else{
        [[IDOH5Manager shareInstance] sendToH5State:IDOHomeRuningPlanTypeRenewTrainingFail data:@""];
    }
}
//v2 app运动结束ble回复
- (void)v2_appEndSportReplyWithModel:(IDOAppEndReplyExchangeModel *)model errorCode:(int)errorCode{
    NSLog(@"v2_appEndSportReplyWithModel errorCode:%d  model:%@",errorCode,model.yy_modelToJSONString);
    if (errorCode == 0) {
        if (!__IDO_FUNCTABLE__.funcTable34Model.supportSportPlan) {
            [self stopSportSuccess];
        }
    }else{
        [[IDOH5Manager shareInstance] sendToH5State:IDOHomeRuningPlanTypeStopTrainingFail data:@""];
    }
    
}
//v2 app运动交互中ble回复
- (void)v2_appIngSportReplyWithModel:(IDOV2AppIngReplyExchangeModel *)model errorCode:(int)errorCode{
    NSLog(@"v2_appIngSportReplyWithModel errorCode:%d  model:%@",errorCode,model.yy_modelToJSONString);
}
//v3 app运动交互中ble回复
- (void)v3_appIngSportReplyWithModel:(IDOV3AppIngReplyExchangeModel *)model errorCode:(int)errorCode{
    NSLog(@"v3_appIngSportReplyWithModel errorCode:%d",errorCode);
    
    if (errorCode == 0) {
        NSDictionary *param = [self v3_exchangeDicWithModel:[IDODataExchangeManager shareInstance].v3Model];
        if (self.tranningExeModelResultBlock) {
            self.tranningExeModelResultBlock(param);
        }
    }
}
//v3 app运动结束后获取心率数据
- (void)v3_appSportHrReplyWithModel:(IDOHrDataExchangeModel *)model errorCode:(int)errorCode{
    NSLog(@"v3_appSportHrReplyWithModel errorCode:%d  model:%@",errorCode,model.yy_modelToJSONString);
    if (errorCode == 0) {
        [self saveV3HrDatas:model];
    }
}
//v3 app运动结束后返回数据
- (void)v3_appEndSportReplyWithModel:(IDOV3SportEndDataExchangeModel *)model errorCode:(int)errorCode{
    NSLog(@"v3_appEndSportReplyWithModel errorCode:%d ",errorCode);
    //如果点击了停止
    if (self.clickStop) {
        [self sportEndAndSaveData];
    }
}

//app操作运动计划返回
- (void)appOperatePlanReplyWithModel:(IDOAppOperatePlanExchangeModel *)model errorCode:(int)errorCode{
    NSLog(@"appOperatePlanReplyWithModel : %@  errorCode:%d",model.yy_modelToJSONString,errorCode);
    
    if (errorCode == 0 && model.errorCode == 0) {
        NSInteger operate = model ? model.operate : self.planExchangeModel.operate;
        if (operate == IDORuningOperateTypeStop) {
            if (self.stopRunFromApp) {
                [self handleSuccessPlanModel:operate];
            }
        }else{
            [self handleSuccessPlanModel:operate];
        }
    }else{
        [self handleFailPlanModel:model ? model.operate : self.planExchangeModel.operate];
    }
}
//ble操作运动计划返回
- (void)bleOperatePlanWithModel:(IDOBleOperatePlanExchangeModel *)model errorCode:(int)errorCode{
    NSLog(@"bleOperatePlanWithModel : %@  errorCode:%d",model.yy_modelToJSONString,errorCode);
    if (errorCode == 0 && model.errorCode == 0) {
        NSInteger operate = model ? model.operate : self.planExchangeModel.operate;
        if (operate == IDORuningOperateTypeStop) {
            if (!self.stopRunFromApp) {
                [self handleSuccessPlanModel:operate];
            }
        }else if (operate == IDORuningOperateTypeChangeAction){
            NSDictionary *dic = @{
                @"type" : @(model.planType),
                @"action_type" : @(model.actionType),
                @"time" : @(model.time),
                @"nextActionType" : @(model.actionType),
                @"nextTime" : @(model.time),
                @"low_heart" : @(model.lowHeart),
                @"height_heart" : @(model.heightHeart),
            };
            [[IDOH5Manager shareInstance] sendDataToH5:dic param:@"runningPlanSendActionToggleDataToWeb"];
        } else{
            [self handleSuccessPlanModel:operate];
        }
    }else{
        [self handleFailPlanModel:model ? model.operate : self.planExchangeModel.operate];
    }
}

- (void)bleDidconnect {
    NSLog(@"bleDidconnect");
}


- (void)bleDisconnect {
    NSLog(@"bleDisconnect");
    if (self.running) {
        self.running = NO;
        [self.freshTimer setFireDate:[NSDate distantFuture]];
        [[IDOH5Manager shareInstance] sendToH5State:IDOHomeRuningPlanTypeConnectingDeviceFail data:@""];
        
        UIApplicationState state = [UIApplication sharedApplication].applicationState;
        
    }
}




@end
