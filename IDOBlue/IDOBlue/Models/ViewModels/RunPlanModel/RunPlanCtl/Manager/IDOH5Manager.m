//
//  IDOH5Manager.m
//  IDOVFHome
//
//  Created by mac2019 on 2022/5/27.
//

#import "IDOH5Manager.h"
#import "IDOHomeHealthManager.h"
#import <IDOBluetooth/IDOBluetooth.h>
#import <IDOBlueUpdate/IDOBlueUpdate.h>
#import <IDOBlueProtocol/IDOBlueProtocol.h>
#import <AudioToolbox/AudioToolbox.h>

// 判断是否是iPhone X系列
#define IDO_IS_iPhoneX      ([UIScreen instancesRespondToSelector:@selector(currentMode)] ?\
(\
CGSizeEqualToSize(CGSizeMake(375, 812),[UIScreen mainScreen].bounds.size)\
||\
CGSizeEqualToSize(CGSizeMake(812, 375),[UIScreen mainScreen].bounds.size)\
||\
CGSizeEqualToSize(CGSizeMake(414, 896),[UIScreen mainScreen].bounds.size)\
||\
CGSizeEqualToSize(CGSizeMake(390, 844),[UIScreen mainScreen].bounds.size)\
||\
CGSizeEqualToSize(CGSizeMake(320, 693),[UIScreen mainScreen].bounds.size)\
||\
CGSizeEqualToSize(CGSizeMake(693, 320),[UIScreen mainScreen].bounds.size)\
||\
CGSizeEqualToSize(CGSizeMake(844, 390),[UIScreen mainScreen].bounds.size)\
||\
CGSizeEqualToSize(CGSizeMake(428, 926),[UIScreen mainScreen].bounds.size)\
||\
CGSizeEqualToSize(CGSizeMake(926, 428),[UIScreen mainScreen].bounds.size)\
||\
CGSizeEqualToSize(CGSizeMake(430, 932),[UIScreen mainScreen].bounds.size)\
||\
CGSizeEqualToSize(CGSizeMake(932, 430),[UIScreen mainScreen].bounds.size)\
||\
CGSizeEqualToSize(CGSizeMake(852, 393),[UIScreen mainScreen].bounds.size)\
||\
CGSizeEqualToSize(CGSizeMake(393, 852),[UIScreen mainScreen].bounds.size)\
||\
CGSizeEqualToSize(CGSizeMake(896, 414),[UIScreen mainScreen].bounds.size))\
:\
NO)
#define URL_APP_KEY  @"9ee5f0aed15e4641818c098376b82241"

@interface IDOH5Manager ()
/**
 开启音效
 */
@property (nonatomic,assign) BOOL openSound;

@property (nonatomic,assign) NSInteger lastActTimestamp;

@property (nonatomic,strong) IDOH5FailView *failView;

@property (nonatomic,weak) IDOSleepManagerVC *mgrVc;

@end

@implementation IDOH5Manager


static IDOH5Manager *_mgr = nil;

+ (IDOH5Manager *)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _mgr = [[IDOH5Manager alloc] init];
    });
    return _mgr;
}

- (instancetype)init{
    if (self = [super init]) {
        self.openSound = YES;
    }
    return self;
}

+ (instancetype)alloc{
    if (_mgr) {
        NSException *exception = [NSException exceptionWithName:@"重复创建IDOH5Manager单例对象异常" reason:@"请使用[IDOH5Manager shareInstance]的单例方法." userInfo:nil];
        [exception raise];
    }
    return [super alloc];
}

- (IDOH5FailView *)failView{
    if (!_failView) {
        _failView = [[IDOH5FailView alloc] initWithFrame:self.mgrVc.view.bounds];
        [self.mgrVc.view addSubview:_failView];
        [self.mgrVc.view bringSubviewToFront:_failView];
        
        __weak typeof(self) weakSelf = self;
        _failView.clickBackBlock = ^{
            [weakSelf.mgrVc.navigationController popViewControllerAnimated:YES];
            [weakSelf performSelector:@selector(dismissView) withObject:nil afterDelay:0.3];
        };
        
        NSInteger second = 45 ;
        
        _failView.clickRestartBlock =  ^{
            [weakSelf performSelector:@selector(loadHtTimeOut) withObject:nil afterDelay:second];
            [weakSelf.mgrVc loadHTML];
            [weakSelf.failView loading:YES];
        };
        
        [_failView loading:NO];
        // 这里会引起重复注册，导致循环调用didLoadHtml ，在h5QueryUserInfoWithVC 方法已经注册了通知，这里就屏蔽处理
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didLoadHtml) name:kDidFinishLoadHtml5NotificationKey object:nil];
    }
    return _failView;
}

/**
 获取当前服务器的名称
 */
- (NSString *)serverSite{
    NSString *site = @"cn";
    return site;
}

//当前设备的版本号
- (NSString *)deviceVersion{

    NSString *versionStr = [NSString stringWithFormat:@"%ld.%02ld.%02ld",IDO_BLUE_ENGINE.managerEngine.versionModel.firmwareVersion1,IDO_BLUE_ENGINE.managerEngine.versionModel.firmwareVersion2,IDO_BLUE_ENGINE.managerEngine.versionModel.firmwareVersion3];
    return versionStr;
    
}

//获取用户与设备的信息
- (void)userInfoDicBlock:(void (^)(NSDictionary * dic))block{
   
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        IDOGetDeviceInfoBluetoothModel *currentDevice = nil;
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSString *deviceVerson = [self deviceVersion];
            
            NSString *boundNoConnectDeviceStatus =  @"YES";
            //是否支持心率
            NSString *isSupportHeartRate = (currentDevice && (__IDO_FUNCTABLE__.funcTable4Model.heartRate || __IDO_FUNCTABLE__.funcTable22Model.v3HrData)) ? @"YES" : @"NO";
            //是否支持跑步运动
            NSString *isSupportRunningPlan = (currentDevice && __IDO_FUNCTABLE__.funcTable34Model.supportSportPlan) ? @"YES" : @"NO";
            
            //是否有绑定的设备
            NSString *equipmentBindingStatus = currentDevice ? @"YES" : @"NO";
            
            NSString *bluetoothStatus = IDO_BLUE_ENGINE.managerEngine.poweredOn ? @"YES" : @"NO";
            //是否在同步中
            NSString *synchronizationStatus = (currentDevice && ([initSyncManager() isSyncHealthRun] || [initSyncManager() isSyncConfigRun])) ? @"YES" : @"NO";;
            
            NSString *isSyncHealthInfo =  @"YES";
            
            //时间制式
            NSString *clockStyleStr = [self isHasAMPMTimeSystem] ? @"HOUR_CLOCK_12" : @"HOUR_CLOCK_24";
            
            //卡路里的单位
            NSString *caloriseUnit = @"KCAL";
            
            //体重的单位
            NSString *weightUnit = @(1).stringValue;
            
            //身高的单位
            NSString *heightUnit = @(1).stringValue;
            
            NSString *weekStart = @"SUNDAY";
            
            NSString *gender =  @"1";//"1":man 2:woman
            
            NSDictionary *params = @{
                @"color": @"0",
                @"appKey": URL_APP_KEY,
                @"token": [IDOHomeHealthManager shareInstance].tokenStr,
                @"userId": @"603312866979876864",
                @"iPhoneXOrLater": @(IDO_IS_iPhoneX),
                @"isSyncHealthInfo": isSyncHealthInfo,
                @"language": @"en",
                @"serverSite" : [self serverSite],
                @"deviceVersion" : deviceVerson,
                @"bluetoothStatus" : bluetoothStatus,
                @"boundNoConnectDeviceStatus" : boundNoConnectDeviceStatus,
                @"equipmentBindingStatus" : equipmentBindingStatus,
                @"isSupportHeartRate" : isSupportHeartRate,
                @"isSupportRunningPlan" : isSupportRunningPlan,
                @"synchronizationStatus" : synchronizationStatus,
                @"timestamp" : clockStyleStr,
                @"caloriseUnit" : caloriseUnit,
                @"weightUnit" : weightUnit,
                @"heightUnit" : heightUnit,
                @"weekStart" : weekStart,
                @"gender" : gender,
                @"appName" : @"mentech wear",
                @"deviceName" : __IDO_NAME__
                
            };
            
            if (block) {
                block(params);
            }
        });
    });
}

- (void)sendDataToH5:(id)data param:(NSString *)param{
    UIViewController *currentVc = [self currentViewController];
    if([currentVc isKindOfClass:[IDOSleepManagerVC class]]){
        IDOSleepManagerVC *mgrVC = (IDOSleepManagerVC *)currentVc;
        [mgrVC callHandler:param data:data];
    }
}
- (UIViewController *)currentViewController
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    return currentVC;
}

- (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    if ([rootVC presentedViewController]) {
        rootVC = [rootVC presentedViewController];
    }
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    } else {
        currentVC = rootVC;
    }
    return currentVC;
}
- (BOOL)isHasAMPMTimeSystem {
    // 获取系统是24小时制或者12小时制
    NSString *formatStringForHours = [NSDateFormatter dateFormatFromTemplate:@"j" options:0 locale:[NSLocale currentLocale]];
    NSRange containsA = [formatStringForHours rangeOfString:@"a"];
    BOOL hasAMPM = (containsA.location != NSNotFound);
    return hasAMPM;
}

//跟进h5返回的一些数据进行想对应的操作
- (void)sendNotificationToAPP:(NSString *)handlerName{

    if([handlerName isEqualToString:@"runningPlanOpenVibration"]){//表示整栋加提示语
        [self voice:self.openSound vibrate:YES changeAct:YES];
    }else if([handlerName isEqualToString:@"runningPlanOpenVibrationTwo"]){//表示整栋加提示语
        [self voice:self.openSound vibrate:YES changeAct:NO];
    }else if ([handlerName isEqualToString:@"bluetoothDeviceList"]){//获取主账号的设备情况
        [self appSendDevicesToH5];
    }else if ([handlerName isEqualToString:@"backToBoundDevice"]){//push to bind controller
        
    }else if ([handlerName isEqualToString:@"closeSound"]){//关闭音效
        self.openSound = NO;
    }else if ([handlerName isEqualToString:@"openSound"]){//开启音效
        self.openSound = YES;
    }else if ([handlerName isEqualToString:@"runningPlanAllDeviceStatus"]){
        if (!__IDO_CONNECTED__ || !__IDO_FUNCTABLE__.funcTable34Model.supportSportPlan) {
            [self sendToH5State:IDOHomeRuningPlanTypeAllDeviceStatus data:[self runningPlanAllDeviceStatus]];
            return;
        }
        
        if (self.runningPlanAllDeviceStatusBlock) {
            self.runningPlanAllDeviceStatusBlock();
        }
    }else if ([handlerName isEqualToString:@"backToApp"]){
        if (self.clickBackBlock) {
            self.clickBackBlock();
        }
        
        [self performSelector:@selector(dismissView) withObject:nil afterDelay:0.3];
    }
    
}

///当前app权限是否打开,ios9以下暂不处理
- (BOOL)isAppBlueToothAuthStateEnabled{
    
    __block BOOL flag = YES;
    if (@available(iOS 10.0, *)) {
        if (([IDOBluetoothEngine shareInstance].managerEngine.centralManager.state==CBManagerStateUnknown)||
            ([IDOBluetoothEngine shareInstance].managerEngine.centralManager.state==CBManagerStateUnsupported)||
            ([IDOBluetoothEngine shareInstance].managerEngine.centralManager.state==CBManagerStateUnauthorized)
            ) {
            
            flag = NO;
        }
    }
    
    return flag;
}


/**
 是否开启音乐和整栋
 */
- (void)voice:(BOOL)open vibrate:(BOOL)vibrate changeAct:(BOOL)changeAct{
    
    NSBundle *bundle = [NSBundle bundleForClass:NSClassFromString(@"AppDelegate")];
    NSURL *fileUrl = nil;
    if (changeAct) {
        fileUrl = [bundle URLForResource:@"running_plan.mp3" withExtension:nil];
    }else{
        fileUrl = [bundle URLForResource:@"hr_high_alarm.mp3" withExtension:nil];
    }
    
    SystemSoundID sound = kSystemSoundID_Vibrate;
    OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)fileUrl,&sound);
    if (error != kAudioServicesNoError) {
        sound = 0;
    }
    
    if(open){
        AudioServicesPlaySystemSound(sound);//播放声音
    }else{
        AudioServicesDisposeSystemSoundID(sound);//停止播放
    }
    
    if(vibrate){
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);//静音模式下震动
    }
}


//连接设备
- (void)connectDeviceWithDic:(NSDictionary *)dic{
    
    //蓝牙为连接
    if (!IDO_BLUE_ENGINE.managerEngine.isPoweredOn || ![self isAppBlueToothAuthStateEnabled]) {
        [self sendToH5State:IDOHomeRuningPlanTypeConnectingBluetoothFail data:nil];
        return;
    }
    
    //设置同步中
    if ([initSyncManager() isSyncHealthRun] || [initSyncManager() isSyncConfigRun]) {
        [self sendToH5State:IDOHomeRuningPlanTypeSyncDeviceData data:nil];
        return;
    }
    
    NSString *mac = dic[@"mac"];
    if (mac.length < 12) {
        [self sendToH5State:IDOHomeRuningPlanTypeConnectingDeviceFail data:nil];
        return;
    }
    
    [self performSelector:@selector(appConnectWatchTimeout:) withObject:mac afterDelay:32.0];
    if ([mac isEqualToString:__IDO_MAC_ADDR__]){//点击的连接设备为当前的设备
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(appConnectWatchTimeout:) object:mac];
        //如果已经连接成功
        if (__IDO_CONNECTED__) {
            [self sendToH5State:IDOHomeRuningPlanTypeConnectingDeviceSuccess data:nil];
            return;
        }
        
        if (__IDO_BIND__) {//如果当前的设备就是当前正常绑定的设备
            if (!__IDO_CONNECTING__ && !IDO_BLUE_ENGINE.managerEngine.isScanning) {
                [IDOBluetoothManager shareInstance].isReconnect = YES;
                [IDOBluetoothManager startScan];
            }
        }
    }else{
        [IDOFoundationCommand switchDeviceCommand:mac isMandatory:YES callback:^(int errorCode) {
            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(appConnectWatchTimeout:) object:mac];
            if (errorCode == 0) {
                
                [self sendToH5State:IDOHomeRuningPlanTypeConnectingDeviceSuccess data:nil];
            }else if (errorCode == 35){
                //没有绑定
            }else{
                [self appConnectWatchTimeout:mac];
            }
        }];
    }
}
    
- (void)appConnectWatchTimeout:(NSString *)mac{
    [IDOBluetoothManager stopScan];
    [self sendToH5State:IDOHomeRuningPlanTypeConnectingDeviceFail data:nil];
}


/**
 把设备列表传给5
 */
- (void)appSendDevicesToH5{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
    
        NSMutableArray *items = [NSMutableArray array]; //绑定过的设备列表
        
        
        if(items.count > 0){
            dispatch_async(dispatch_get_main_queue(), ^{
                [self sendDataToH5:@{@"bluetoothDeviceList" : items} param:@"getBluetoothDeviceListToWeb"];
            });
        }
    });
}

#pragma mark - 对外方法
//h5查询用户信息
- (void)h5QueryUserInfoWithVC:(IDOSleepManagerVC *)vc{
    
    self.mgrVc = vc;
    
    [vc registerHandler:@"getUserInfoAPP" handler:^(id data, WVJBResponseCallback responseCallback) {
        [[IDOH5Manager shareInstance] userInfoDicBlock:^(NSDictionary * _Nonnull dic) {
            responseCallback(dic);
        }];
    }];
    
    
    
    //h5回调原生的回调
    vc.h5NotiActivityBlock = ^(id  _Nonnull data) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [data objectForKey:@"message"]) {
            [self sendNotificationToAPP:data[@"message"]];
            return;
        }
        //音乐数据相关
        if ([data isKindOfClass:[NSDictionary class]] &&
            [data objectForKey:@"val"]) {
            
            [self handleMusicWithData:data[@"val"]];
        }
    };
    
    //h5回调训练计划  操作：0x01 ：下发计划 ， 0x02：同步计划 ， 0x03 结束计划
    [vc registerHandler:@"runningPlanSetPlan" handler:^(id data, WVJBResponseCallback responseCallback) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [data objectForKey:@"runningPlanObj"]) {
            if (self.runningPlanSetPlanBlock) {
                self.runningPlanSetPlanBlock(data[@"runningPlanObj"]);
            }
        }
    }];
    
    //h5回调连接设备
    [vc registerHandler:@"connectBluetoothDeviceToApp" handler:^(id data, WVJBResponseCallback responseCallback) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [data objectForKey:@"BluetoothDevice"]) {
            [self connectDeviceWithDic:data[@"BluetoothDevice"]];
        }
    }];
    
    
    //h5 点击开始，暂停，恢复，结束运动
    [vc registerHandler:@"runningPlanToggleTraining" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        NSInteger currentTimeStamp = [[NSDate date] timeIntervalSince1970];
        if (currentTimeStamp - self.lastActTimestamp < 0.3) {
            NSLog(@"检测到进行了连续点击");
            return;
        }
        self.lastActTimestamp = currentTimeStamp;
        
        if ([data isKindOfClass:[NSDictionary class]] &&
            [data objectForKey:@"message"]) {
            if (self.runningPlanToggleTrainingBlock) {
                self.runningPlanToggleTrainingBlock(data[@"message"]);
            }
        }
    }];
    
    vc.userNewShare = YES;

    dispatch_async(dispatch_get_main_queue(), ^{
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didLoadHtml) name:kDidFinishLoadHtml5NotificationKey object:nil];
        NSInteger second = 45 ;
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(loadHtTimeOut) object:nil];
        [self performSelector:@selector(loadHtTimeOut) withObject:nil afterDelay:second];
        
        
        //禁止右滑返回
        id traget = self.mgrVc.navigationController.interactivePopGestureRecognizer.delegate;
        UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:traget action:nil];
        [self.mgrVc.view addGestureRecognizer:pan];
    });
}

- (void)dismissView{
    [self.failView removeFromSuperview];
    self.failView = nil;
}

- (void)loadHtTimeOut{
    self.failView.hidden = NO;
    [self.failView loading:NO];
    if (@available(iOS 13.0, *)) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDarkContent;
    } else {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    }
}


- (void)handleMusicWithData:(id)data{
    

}

/**
 状态发生变化，通知h5
 */
- (void)sendToH5State:(IDOHomeRuningPlanType)planType vc:(IDOSleepManagerVC *)vc data:(nonnull id)data{
    id stateObj = nil;
    switch (planType) {
        case IDOHomeRuningPlanTypeStartTraining:
            stateObj = @{
                @"data" : @"runningPlanStartTraining"
            };
            break;
        case IDOHomeRuningPlanTypeSuspendTraining:
            stateObj = @{
                @"data" : @"runningPlanSuspendTraining"
            };
            break;
        case IDOHomeRuningPlanTypeRenewTraining:
            stateObj = @{
                @"data" : @"runningPlanRenewTraining"
            };
            break;
        case IDOHomeRuningPlanTypeStopTraining:
            stateObj = @{
                @"data" : @"runningPlanStopTraining"
            };
            break;
        case IDOHomeRuningPlanTypeStartTrainingFail:
            stateObj = @{
                @"data" : @"runningPlanStartTrainingFail"
            };
            break;
        case IDOHomeRuningPlanTypeSuspendTrainingFail:
            stateObj = @{
                @"data" : @"runningPlanSuspendTrainingFail"
            };
            break;
        case IDOHomeRuningPlanTypeRenewTrainingFail:
            stateObj = @{
                @"data" : @"runningPlanRenewTrainingFail"
            };
            break;
        case IDOHomeRuningPlanTypeStopTrainingFail:
            stateObj = @{
                @"data" : @"runningPlanStopTrainingFail"
            };
            break;
        case IDOHomeRuningPlanTypeSyncDeviceData:
            stateObj = @{
                @"data" : @"runningPlanSyncDeviceData"
            };
            break;
        case IDOHomeRuningPlanTypeIsSetPlanSuccess:
            stateObj = @{
                @"data" : @"runningPlanIsSetPlanSuccess"
            };
            break;
        case IDOHomeRuningPlanTypeIsSetPlanFail:
            stateObj = @{
                @"data" : @"runningPlanIsSetPlanFail"
            };
            break;
        case IDOHomeRuningPlanTypeIsSynchroPlanSuccess:
            stateObj = @{
                @"data" : @"runningPlanIsSynchroPlanSuccess"
            };
            break;
        case IDOHomeRuningPlanTypeIsSynchroPlanFail:
            stateObj = @{
                @"data" : @"runningPlanIsSynchroPlanFail"
            };
            break;
        case IDOHomeRuningPlanTypeIsEndPlanSuccess:
            stateObj = @{
                @"data" : @"runningPlanIsEndPlanSuccess"
            };
            break;
        case IDOHomeRuningPlanTypeIsEndPlanFail:
            stateObj = @{
                @"data" : @"runningPlanIsEndPlanFail"
            };
            break;
        case IDOHomeRuningPlanTypeConnectingDeviceSuccess:
            stateObj = @{
                @"data" : @"runningPlanConnectingDeviceSuccess"
            };
            break;
        case IDOHomeRuningPlanTypeConnectingDeviceFail:
            stateObj = @{
                @"data" : @"runningPlanConnectingDeviceFail"
            };
            break;
        case IDOHomeRuningPlanTypeConnectingBluetoothSuccess:
            stateObj = @{
                @"data" : @"runningPlanConnectingBluetoothSuccess"
            };
            break;
        case IDOHomeRuningPlanTypeConnectingBluetoothFail:
            stateObj = @{
                @"data" : @"runningPlanConnectingBluetoothFail"
            };
            break;
        case IDOHomeRuningPlanTypeAllDeviceStatus:
            stateObj = @{
                @"runningPlanAllDeviceStatus" : [self runningPlanAllDeviceStatus]
            };
            break;
        case IDOHomeRuningPlanTypeConnectingDeviceStatus:
        {
            NSString *stateStr = @"";
            if([data isKindOfClass:[NSString class]]){
                stateStr = data;
            }
            stateObj = @{
                @"runningPlanConnectingDeviceStatus" : stateStr
            };
        }
            break;
        default:
            break;
    }

    NSLog(@"send to h5 stateObj:%@",stateObj);

    //发送数据到h5
    if (stateObj) {
        [vc callHandler:@"sendNotificationToWeb" data:stateObj];
    }
}

- (void)sendToH5State:(IDOHomeRuningPlanType)planType data:(id)data{
    UIViewController *vc = [self currentViewController];
    if([vc isKindOfClass:[IDOSleepManagerVC class]]){
        IDOSleepManagerVC *mgrVC = (IDOSleepManagerVC *)vc;
        [self sendToH5State:planType vc:mgrVC data:data];
    }
}

- (NSDictionary *)runningPlanAllDeviceStatus{

    NSString *boundNoConnectDeviceStatus = __IDO_CONNECTED__ ? @"YES" : @"NO";
    //是否支持心率
    NSString *isSupportHeartRate = (__IDO_FUNCTABLE__.funcTable4Model.heartRate || __IDO_FUNCTABLE__.funcTable22Model.v3HrData) ? @"YES" : @"NO";
    //是否支持跑步运动
    NSString *isSupportRunningPlan =  __IDO_FUNCTABLE__.funcTable34Model.supportSportPlan ? @"YES" : @"NO";

    NSString *bluetoothStatus = IDO_BLUE_ENGINE.managerEngine.poweredOn ? @"YES" : @"NO";
    //是否在同步中
    NSString *synchronizationStatus = ([initSyncManager() isSyncHealthRun] || [initSyncManager() isSyncConfigRun]) ? @"YES" : @"NO";
    
    NSString *equipmentBindingStatus = __IDO_BIND__ ? @"YES" : @"NO";

    NSDictionary *runningPlanAllDeviceStatusDic = @{
        @"bluetoothStatus" : bluetoothStatus,
        @"boundNoConnectDeviceStatus" : boundNoConnectDeviceStatus,
        @"equipmentBindingStatus" : equipmentBindingStatus,
        @"isSupportRunningPlan" : isSupportRunningPlan,
        @"isSupportHeartRate" : isSupportHeartRate,
        @"synchronizationStatus" : synchronizationStatus,
    };
    return runningPlanAllDeviceStatusDic;
}

- (void)panDisableBack{
    UIViewController *vc = [self currentViewController];
    if([vc isKindOfClass:[IDOSleepManagerVC class]]){
        IDOSleepManagerVC *mgrVC = (IDOSleepManagerVC *)vc;
        //禁止右滑返回
        id traget = mgrVC.navigationController.interactivePopGestureRecognizer.delegate;
        UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:traget action:nil];
        [mgrVC.view addGestureRecognizer:pan];
    }
}

#pragma mark - 通知

- (void)didLoadHtml{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(loadHtTimeOut) object:nil];
        if (self.failView) {
            [self.failView removeFromSuperview];
            self.failView = nil;
        }
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    });
}


@end
