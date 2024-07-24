//
//  IDORunPlanManager.m
//  IDOVFHome
//
//  Created by mac2019 on 2022/5/20.
//

#import "IDORunPlanManager.h"
#import "YYModel.h"
/**
 运动相关类型
 
 //操作：0x01 ：开始计划 ， 0x02：计划数据下发  ， 0x03结束计划 ， 0x04查询跑步计划
 */
typedef NS_OPTIONS(NSUInteger, IDORunPlanActionType)
{
    IDORunPlanActionTypeStart = 1, //开始计划
    IDORunPlanActionTypeSendPlan = 2, //计划数据下发
    IDORunPlanActionTypeEnd = 3, //结束计划
    IDORunPlanActionTypeQueryPlan = 4, //查询跑步计划
};



/**
 运动状态类型
 */
typedef NS_OPTIONS(NSUInteger, IDOHomeRuningPlanConnectingDeviceStatus)
{
    IDOHomeRuningPlanConnectingDeviceStatusNone = 0, //表示不做任何操作
    IDOHomeRuningPlanConnectingDeviceStatusSamePlan = 1,//表示连接设备成功，支持跑步计划,且跑步计划相同
    IDOHomeRuningPlanConnectingDeviceStatusNonePlan = 2,//表示连接设备成功，支持跑步计划,且跑步计划为空
    IDOHomeRuningPlanConnectingDeviceStatusOtherPlan = 3,//表示连接设备成功，支持跑步计划,且设备跑步计划与用户计划不一致
    IDOHomeRuningPlanConnectingDeviceStatusGetPower = 4,//表示连接设备成功，支持跑步计划,且设备在充电中
    IDOHomeRuningPlanConnectingDeviceStatusRunning = 5,//表示连接设备成功，支持跑步计划,且设备正在运动模式
};

@interface IDORunPlanManager ()<IDOSportPlanManagerDelegate>

/**
 开启音效
 */
@property (nonatomic,assign) BOOL openSound;

/**
 是否为原生app直接查询跑步计划
 */
@property (nonatomic,assign) BOOL checkRunPlanFromNative;

/**
 是否为原生app直接设置跑步计划
 */
@property (nonatomic,assign) BOOL setPlanFromNative;

@end

@implementation IDORunPlanManager

static IDORunPlanManager *_mgr = nil;

+ (IDORunPlanManager *)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _mgr = [[IDORunPlanManager alloc] init];
    });
    return _mgr;
}

- (instancetype)init{
    if (self = [super init]) {
        self.openSound = YES;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bluetoothConnectErrorNotify:) name:IDOBluetoothConnectErrorNotifyName object:nil];
    }
    return self;
}

+ (instancetype)alloc{
    if (_mgr) {
        NSException *exception = [NSException exceptionWithName:@"重复创建IDORunPlanManager单例对象异常" reason:@"请使用[IDORunPlanManager shareInstance]的单例方法." userInfo:nil];
        [exception raise];
    }
    return [super alloc];
}

#pragma mark - 通知
- (void)bluetoothConnectErrorNotify:(NSNotification *)noti{
    
    NSLog(@"Home --- 跑步计划设置失败,蓝牙异常，未连接");
    
    if (self.setPlanFromNative &&  self.setRunPlanDetailBlock) {
        IDOSportPlanDataModel *m = [[IDOSportPlanDataModel alloc] init];
        m.errorCode = -1;
        self.setRunPlanDetailBlock(m);
        self.setPlanFromNative = NO;
    }
    
    if (self.checkRunPlanFromNative &&  self.runPlanDetailBlock) {
        IDOSportPlanDataModel *m = [[IDOSportPlanDataModel alloc] init];
        m.errorCode = -1;
        self.runPlanDetailBlock(m);
        self.checkRunPlanFromNative = NO;
    }
}

#pragma mark - 对外方法

//h5查询用户信息
- (void)h5QueryUserInfoWithVC:(IDOSleepManagerVC *)vc{
    
    //制定跑步计划,h5 传递完整的跑步计划给 APP
    [IDOH5Manager shareInstance].runningPlanSetPlanBlock = ^(NSDictionary * _Nonnull dic) {
        [self planActWithDic:dic];
    };
    
    
    [IDOH5Manager shareInstance].runningPlanAllDeviceStatusBlock = ^(void) {
        //查询计划
        [self queryDeviceRunPlan];
    };
    
    [IDOH5Manager shareInstance].runningPlanToggleTrainingBlock = ^(NSDictionary * _Nonnull dic) {
        [self startTrainingParams:dic];
    };
    
    //监听返回
    [IDOH5Manager shareInstance].clickBackBlock = ^{
        if (self.clickBackBlock) {
            self.clickBackBlock();
        }
    };
    
    //注册对应的回调
    [[IDOH5Manager shareInstance] h5QueryUserInfoWithVC:vc];
    
}

- (void)sendToH5State:(IDOHomeRuningPlanType)planType data:(id)data{
    [[IDOH5Manager shareInstance] sendToH5State:planType data:data];
}

- (void)sendToH5State:(IDOHomeRuningPlanType)planType vc:(IDOSleepManagerVC *)vc data:(id)data{
    [[IDOH5Manager shareInstance] sendToH5State:planType vc:vc data:data];
}

#pragma mark - 与固件相关的操作


/**
 操作运动相关
 */
- (void)startTrainingParams:(NSDictionary *)param{
    
    //数据交互的block
    [IDOTranningManager shareInstance].tranningExeModelResultBlock = ^(NSDictionary * _Nonnull dic) {
        [[IDOH5Manager shareInstance] sendDataToH5:dic param:@"runningPlanSendTrainingDataToWeb"];
    };

    
    NSInteger operate = [param[@"operate"] integerValue];
    if (operate == 0x01) {//开始运动
        NSLog(@"home_run_plan 开始获取设备信息:%@",__IDO_MAC_ADDR__);
        
        BOOL flashStatu = [IDORecordDeviceLog getFlashLogState];
        if (flashStatu) {
            BOOL flashStop = [IDORecordDeviceLog stopFlashLogRecord];
            NSLog(@"startTrainingParams 现在正在进行flash同步:%d ，需要停止同步flash  flashStop:%d",flashStatu,flashStop);
        }
        
        [self performSelector:@selector(getDeviceInfoCommandTimeOut) withObject:nil afterDelay:15];
        
        [IDOFoundationCommand getDeviceInfoCommand:^(int errorCode, IDOGetDeviceInfoBluetoothModel * _Nullable data) {
            NSLog(@"home_run_plan---获取设备信息 errorCode:%d  %@",errorCode,data.yy_modelToJSONString);
            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(getDeviceInfoCommandTimeOut) object:nil];
            if (errorCode != 0) {
                [[IDOH5Manager shareInstance] sendToH5State:IDOHomeRuningPlanTypeStartTrainingFail data:@""];
                return;
            }
            if (data.battStatus == 1 || data.battStatus == 2 || data.battStatus == 3 || data.battLevel <= 10) {
                [[IDOH5Manager shareInstance] sendToH5State:IDOHomeRuningPlanTypeStartTrainingFail data:@"4"];
                return;
            }
            
            [[IDOTranningManager shareInstance] startPlanTranningWithDic:param];
        }];
        
        return;
    }
    
    if (operate == 0x02) {//暂停运动
        [[IDOTranningManager shareInstance] pancePlanTranning];
        return;
    }
    
    if (operate == 0x03) {//恢复运动
        [[IDOTranningManager shareInstance] restorePlanTranning];
        return;
    }
    
    if (operate == 0x04 || operate == 0x05) {//结束运动
        NSLog(@"h5 回调 结束训练 %@",__IDO_MAC_ADDR__);
        [[IDOTranningManager shareInstance] stopPlanTranning];
        return;
    }
}

- (void)getDeviceInfoCommandTimeOut{
    NSLog(@"计划发起开始超时");
    [[IDOH5Manager shareInstance] sendToH5State:IDOHomeRuningPlanTypeStartTrainingFail data:@""];
}

//查询设备中的跑步计划
- (void)queryDeviceRunPlan{
    self.checkRunPlanFromNative = NO;
    [IDOSportPlanManager shareInstance].delegate = self;
    BOOL result = [IDOSportPlanManager querySportPlan];
    NSLog(@"查询当前设备的计划 queryDeviceRunPlan:%@  result:%d __IDO_CONNECTED__:%d __IDO_FUNCTABLE__.funcTable34Model.supportSportPlan:%d",__IDO_MAC_ADDR__,result,__IDO_CONNECTED__,__IDO_FUNCTABLE__.funcTable34Model.supportSportPlan);
}


//下发计划
- (void)setRunPlanWithDic:(NSDictionary *)paramDic{
    
    //操作：0x01 ：下发计划 ， 0x02：同步计划 ， 0x03 结束计划
    NSInteger operate = [paramDic[@"operate"] integerValue];
    NSInteger type = [paramDic[@"type"] integerValue];
    
    IDOSportPlanSetDataModel *planModel = [self newPlanWithDic:paramDic];
    planModel.operate = operate;
    planModel.type = type;
    if (planModel) {
        self.currentPlanTimeStr = [self timeStrWithDic:paramDic];
        NSLog(@"下发计划：self.currentPlanTimeStr：%@  是否为原生:%d",self.currentPlanTimeStr,self.setPlanFromNative);
        [IDOSportPlanManager setSportPlan:planModel];
    }else{
        NSLog(@"不存在计划：%@ paramDic:%@",__IDO_MAC_ADDR__,paramDic);
        if (self.setPlanFromNative && self.setRunPlanDetailBlock) {
            IDOSportPlanDataModel *m = [[IDOSportPlanDataModel alloc] init];
            m.errorCode = -1;
            self.setRunPlanDetailBlock(m);
            self.setPlanFromNative = NO;
            self.currentPlanTimeStr = @"";
        }
    }
}

//h5相关相关与固件的设备
- (void)planActWithDic:(NSDictionary *)paramDic{
    
    BOOL flashStatu = [IDORecordDeviceLog getFlashLogState];
    if (flashStatu) {
        BOOL flashStop = [IDORecordDeviceLog stopFlashLogRecord];
        NSLog(@"planActWithDic 现在正在进行flash同步:%d ，需要停止同步flash  flashStop:%d",flashStatu,flashStop);
    }
    
    //操作：0x01 ：下发计划 ， 0x02：同步计划 ， 0x03 结束计划
    NSInteger operate = [paramDic[@"operate"] integerValue];
    NSInteger type = [paramDic[@"type"] integerValue];
    //下发计划
    if (operate == 1) {
        self.setPlanFromNative = YES;
        [self setRunPlanWithDic:paramDic];
        return;
    }
    
    //同步计划
    if (operate == 2) {
        self.currentPlanTimeStr = [self timeStrWithDic:paramDic];
        return;
    }
    
    //结束计划
    if (operate == 3) {
        IDOSportPlanDataModel *planModel = [self endPlanModelWithDic:paramDic];
        planModel.operate = operate;
        planModel.type = type;
        if (planModel) {
            [IDOSportPlanManager endSportPlan:planModel];
        }
        return;
    }
    
}

- (NSString *)timeStrWithDic:(NSDictionary *)paramDic{
    if (paramDic.allKeys.count == 0) {
        return nil;
    }
    
    NSInteger year = [paramDic[@"year"] integerValue];
    NSInteger month = [paramDic[@"month"] integerValue];
    NSInteger day = [paramDic[@"day"] integerValue];
    NSInteger type = [paramDic[@"type"] integerValue];
    
    NSInteger hour = [paramDic[@"hour"] integerValue];;
    NSInteger minute = [paramDic[@"minute"] integerValue];;
    NSInteger second = [paramDic[@"second"] integerValue];;
    
    return  year > 0 ? [NSString stringWithFormat:@"%04ld%02ld%02ld%02ld%02ld%02ld_%ld",year,month,day,hour,minute,second,type] : nil;
}

- (NSString *)timeStrWithPlanModel:(IDOSportPlanDataModel *)model{
    if (!model) {
        return nil;
    }
    NSInteger year = model.year;
    NSInteger month = model.month;
    NSInteger day = model.day;
    NSInteger type = model.type;
    NSInteger hour = model.hour;
    NSInteger minute = model.minute;
    NSInteger second = model.second;
    
    return  year > 0 ? [NSString stringWithFormat:@"%04ld%02ld%02ld%02ld%02ld%02ld_%ld",year,month,day,hour,minute,second,type] : nil;
    
//    return  year > 0 ? [NSString stringWithFormat:@"%04ld%02ld%02ld_%ld",year,month,day,type] : nil;
}

/**
 配置停止计划的模型
 */
- (IDOSportPlanDataModel *)endPlanModelWithDic:(NSDictionary *)paramDic{
    if (paramDic.allKeys.count == 0) {
        return nil;
    }
    
    NSString *version = paramDic[@"version"];
    NSInteger year = [paramDic[@"year"] integerValue];
    NSInteger month = [paramDic[@"month"] integerValue];
    NSInteger day = [paramDic[@"day"] integerValue];
    NSInteger hour = [paramDic[@"hour"] integerValue];
    NSInteger minute = [paramDic[@"minute"] integerValue];
    NSInteger second = [paramDic[@"second"] integerValue];
    
    NSInteger operate = [paramDic[@"operate"] integerValue];

    
    IDOSportPlanDataModel *planModel = [[IDOSportPlanDataModel alloc] init];
    planModel.planVersion = [version integerValue];
    planModel.year = year;
    planModel.month = month;
    planModel.day = day;
    planModel.hour = hour;
    planModel.minute = minute;
    planModel.second = second;
    planModel.operate = operate;
    planModel.version = version;
    
    return planModel;
}

/**
 配置下发计划的模型
 */
- (IDOSportPlanSetDataModel *)newPlanWithDic:(NSDictionary *)paramDic{
    
    if (paramDic.allKeys.count == 0) {
        return nil;
    }

    NSInteger day_num = [paramDic[@"dayNum"] integerValue];
    NSArray *day_plan_contents = paramDic[@"dayPlanContent"];
    
    if (![day_plan_contents isKindOfClass:[NSArray class]]) {
        return nil;
    }
    
    if (day_plan_contents.count == 0) {
        return nil;
    }
    
    NSMutableArray *items = [NSMutableArray array];
    for (NSDictionary *pDic in day_plan_contents) {
        IDOSportContentDataModel *dModel = [[IDOSportContentDataModel alloc] init];
        NSInteger type = [pDic[@"type"] integerValue];
        NSInteger num = [pDic[@"num"] integerValue];
        dModel.type = type;
        dModel.num = num;
        
        NSArray *action_contents = pDic[@"actionContent"];
        NSMutableArray *subItems = [NSMutableArray array];
        
        if ([action_contents isKindOfClass:[NSArray class]]) {
            for (NSDictionary *sDic in action_contents) {
                
                NSInteger type = [sDic[@"type"] integerValue];
                NSInteger time = [sDic[@"time"] integerValue];
                NSInteger low_heart = [sDic[@"lowHeart"] integerValue];
                NSInteger height_heart = [sDic[@"heightHeart"] integerValue];
                
                IDOSportActionDataModel *aModel = [[IDOSportActionDataModel alloc] init];
                aModel.type = type;
                aModel.time = time;
                aModel.lowHeart = low_heart;
                aModel.heightHeart = height_heart;
                
                [subItems addObject:aModel];
            }
        }
        
        dModel.items = subItems;
        [items addObject:dModel];
    }
    
    IDOSportPlanDataModel *pModel = [self endPlanModelWithDic:paramDic];
    
    IDOSportPlanSetDataModel *planModel = [[IDOSportPlanSetDataModel alloc] init];
    planModel.dayNum = day_num;
    planModel.items = items;
    planModel.year = pModel.year;
    planModel.month = pModel.month;
    planModel.day = pModel.day;
    planModel.hour = pModel.hour;
    planModel.minute = pModel.minute;
    planModel.second = pModel.second;
    planModel.version = pModel.version;
    
    
    return planModel;
}



#pragma mark - 根据固件返回的数据做处理

//处理查询计划的数据模型
- (void)handleQueryPlan:(IDOSportPlanDataModel *)model{
    
    NSString *devicePlan = [self timeStrWithPlanModel:model];
    NSLog(@"self.currentPlanTimeStr:%@  devicePlan:%@ checkRunPlanFromNative表示为是否原生查询:%d",self.currentPlanTimeStr,devicePlan,self.checkRunPlanFromNative);
    //如果当前的计划是相等的
    NSString *stateStr = @"";
    if ([devicePlan isEqualToString:self.currentPlanTimeStr]) {
        stateStr = @"1";
    }else{
        if (devicePlan.length > 0 && model.year > 0) {
            stateStr = @"3";
        }else{
            stateStr = @"2";
        }
    }
    
    [self sendToH5State:IDOHomeRuningPlanTypeConnectingDeviceStatus data:stateStr];
    
}

#pragma mark - IDOSportPlanManagerDelegate
//运动计划操作完成回调
- (void)sportPlanOperateComplete:(int)errorCode
                       planModel:(IDOSportPlanDataModel *)model{
    
    NSLog(@"跑步计划 回调结果errorCode:%d  model:%@  %@",errorCode,model.yy_modelToJSONString,__IDO_MAC_ADDR__);
    
//    UIViewController *vc = [IDOUIHelp currentViewController];
//    if (![vc isKindOfClass:[IDOSleepManagerVC class]]) {
//        return;
//    }
    
    //操作成功
    if (errorCode == 0) {
        if (model.operate == IDORunPlanActionTypeQueryPlan) {//查询设备中的计划
            [self handleQueryPlan:model];
            
            //回调给外面查询时候当前设备上的计划
            if (self.checkRunPlanFromNative && self.runPlanDetailBlock) {
                self.checkRunPlanFromNative = NO;
                self.runPlanDetailBlock(model);
            }
            
        }else if (model.operate == IDORunPlanActionTypeSendPlan){//计划数据下发
            [self sendToH5State:IDOHomeRuningPlanTypeIsSetPlanSuccess data:@""];
            [IDOSportPlanManager shareInstance].delegate = self;
            [IDOSportPlanManager startSportPlan:model];
        }else if (model.operate == IDORunPlanActionTypeEnd){//结束计划
            [self sendToH5State:IDOHomeRuningPlanTypeIsEndPlanSuccess data:@""];
            //发送通知，通知首页进行更新
            [self notiHomeMainRefresh:@"stopPlan"];
        }else if (model.operate == IDORunPlanActionTypeStart){//开始计划
            [self sendToH5State:IDOHomeRuningPlanTypeIsSynchroPlanSuccess data:@""];
            //发送通知，通知首页进行更新
            [self notiHomeMainRefresh:@"startPlan"];
            
            //回调给外面查询时候当前设备上的计划
            if (self.setPlanFromNative && self.setRunPlanDetailBlock) {
                self.setPlanFromNative = NO;
                self.setRunPlanDetailBlock(model);
            }
        }
    }else{//查询失败
        if (model.operate == IDORunPlanActionTypeQueryPlan) {//查询设备中的计划
            [self sendToH5State:IDOHomeRuningPlanTypeConnectingDeviceStatus data:@"2"];
            //回调给外面查询时候当前设备上的计划
            if (self.checkRunPlanFromNative && self.runPlanDetailBlock) {
                self.checkRunPlanFromNative = NO;
                self.runPlanDetailBlock(model);
            }
        }else if (model.operate == IDORunPlanActionTypeSendPlan){//计划数据下发
            [self sendToH5State:IDOHomeRuningPlanTypeIsSetPlanFail data:@""];
            
            //回调给外面查询时候当前设备上的计划
            if (self.setPlanFromNative && self.setRunPlanDetailBlock) {
                self.setRunPlanDetailBlock(model);
            }
        }else if (model.operate == IDORunPlanActionTypeEnd){//结束计划
            [self sendToH5State:IDOHomeRuningPlanTypeIsEndPlanFail data:@""];
        }else if (model.operate == IDORunPlanActionTypeStart){//开始计划
            [self sendToH5State:IDOHomeRuningPlanTypeIsSynchroPlanFail data:@""];
            
            //回调给外面查询时候当前设备上的计划
            if (self.setPlanFromNative && self.setRunPlanDetailBlock) {
                self.setPlanFromNative = NO;
                self.setRunPlanDetailBlock(model);
            }
        }
    }
}


- (void)notiHomeMainRefresh:(NSString *)actStr{
    
    NSDictionary *dic = @{
        @"actStr" :  actStr ? actStr : @"",
        @"valueStr" : kUpdateRunPlan
    };
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kUpdateSleepScheduleNoticeKey" object:dic];
}

- (void)checkDeviceRunPlan{
    
    self.checkRunPlanFromNative = YES;
    [IDOSportPlanManager shareInstance].delegate = self;
    BOOL result = [IDOSportPlanManager querySportPlan];
    
    NSLog(@"checkDeviceRunPlan __IDO_MAC_ADDR__: %@  result:%d",__IDO_MAC_ADDR__,result);
}

- (void)setRunPlanToDeviceWithDic:(NSDictionary *)dic{
    
    NSLog(@"setRunPlanToDeviceWithDic  __IDO_MAC_ADDR__: %@ ",__IDO_MAC_ADDR__);
    
    self.setPlanFromNative = YES;
    [self setRunPlanWithDic:dic];
}

@end
