//
//  IDOAllOrder.h
//  VeryfitSDK
//
//  Created by hedongyang on 2018/6/12.
//  Copyright © 2018年 hedongyang. All rights reserved.
//



#import <Foundation/Foundation.h>
#import <IDOBluetooth/IDOEnum.h>
#import <IDOBluetooth/IDOGetInfoBluetoothModel.h>
#import <IDOBluetooth/IDOSetInfoBluetoothModel.h>
#import <IDOBluetooth/IDODataExchangeModel.h>

@interface IDOFoundationCommand : NSObject
#pragma mark ======= control Command =======
/**
 连接发送通知
 */
+ (void)didConnect;

/**
 断开发送通知
 */
+ (void)disConnect;

/**
 音乐开始
 
 @param callback 执行后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)musicStartCommand:(void(^_Nullable)(int errorCode))callback;

/**
 音乐结束
 
 @param callback 执行后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)musicStopCommand:(void(^_Nullable)(int errorCode))callback;

/**
 相机开始
 
 @param callback 执行后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)cameraStartCommand:(void(^_Nullable)(int errorCode))callback;

/**
 相机结束
 
 @param callback 执行后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)cameraStopCommand:(void(^_Nullable)(int errorCode))callback;

/**
 开始寻找设备
 
 @param callback 执行后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)findDeviceStartCommand:(void(^_Nullable)(int errorCode))callback;

/**
 结束寻找设备
 
 @param callback 执行后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)findDeviceStopCommand:(void(^_Nullable)(int errorCode))callback;

/**
 打开ANCS(苹果通知中心)
 
 @param callback 执行后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)belOpenAncsCommand:(void(^_Nullable)(int errorCode))callback;

/**
 关闭ANCS(苹果通知中心)
 
 @param callback 执行后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)belCloseAncsCommand:(void(^_Nullable)(int errorCode))callback;

/**
 设备绑定
 @param bindModel 绑定 model (IDOSetBindingInfoBluetoothModel) (只有在授权绑定才会存储数据)
 @param callback 执行后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)bindingCommand:(IDOSetBindingInfoBluetoothModel * _Nullable)bindModel
              callback:(void (^_Nullable)(IDO_BIND_STATUS status, int errorCode))callback;

/**
 设备解绑
 
 @param callback 执行后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)unbindingCommand:(void(^_Nullable)(int errorCode))callback;

/**
 设备强制解绑
 
 @param callback 执行后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)mandatoryUnbindingCommand:(void(^_Nullable)(int errorCode))callback;

/**
 设备配置复位
 
 @param callback 执行后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)setDefaultConfigCommand:(void(^_Nullable)(int errorCode))callback;

/**
 控制设备重启
 
 @param callback 执行后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)setAppRebootCommand:(void(^_Nullable)(int errorCode))callback;

/**
 获取扩展功能列表
 
 @param callback 执行回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)getFuncTableExCommand:(void(^_Nullable)(int errorCode))callback;

/**
 设备进入ota升级模式
 
 @param callback 执行回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)setOtaCommand:(void(^_Nullable)(int state , int errorCode))callback;

#pragma mark ======= set Command =======


/**
 设置授权码绑定

 @param bindModel 绑定 model (IDOSetBindingInfoBluetoothModel)
 @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)setAuthCodeCommand:(IDOSetBindingInfoBluetoothModel * _Nullable)bindModel callback:(void(^_Nullable)(int errorCode))callback;

/**
 设置当前时间

 @param timeModel 时间 model (IDOSetTimeInfoBluetoothModel)
 @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)setCurrentTimeCommand:(IDOSetTimeInfoBluetoothModel * _Nullable)timeModel callback:(void(^_Nullable)(int errorCode))callback;

/**
 设置闹钟

 @param alarmModel 闹钟 model (IDOSetAlarmInfoBluetoothModel)
 @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)setAlarmCommand:(IDOSetAlarmInfoBluetoothModel * _Nullable)alarmModel callback:(void(^_Nullable)(int errorCode))callback;

/**
 批量设置闹钟
 
 @param alarmModels 闹钟集合 model (IDOSetAlarmInfoBluetoothModel)
 @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)setAllAlarmsCommand:(NSArray <IDOSetAlarmInfoBluetoothModel *> * _Nullable)alarmModels callback:(void(^_Nullable)(int errorCode))callback;

/**
 设置用户信息

 @param userModel 用户信息 model (IDOSetUserInfoBuletoothModel)
 @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)setUserInfoCommand:(IDOSetUserInfoBuletoothModel * _Nullable)userModel callback:(void(^_Nullable)(int errorCode))callback;

/**
 设置卡路里和距离目标
 
 @param userModel 用户信息 model (IDOSetUserInfoBuletoothModel)
 @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)setCalorieAndDistanceGoalCommand:(IDOSetUserInfoBuletoothModel * _Nullable)userModel callback:(void (^ _Nullable)(int errorCode))callback;

/**
 设置目标

 @param targetModel 目标信息 model (IDOSetUserInfoBuletoothModel)
 @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)setTargetInfoCommand:(IDOSetUserInfoBuletoothModel * _Nullable)targetModel callback:(void(^_Nullable)(int errorCode))callback;

/**
 设置通知中心、来电提醒开关

 @param noticModel 通知开关信息 model (IDOSetNoticeInfoBuletoothModel)
 @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)setSwitchNoticeCommand:(IDOSetNoticeInfoBuletoothModel * _Nullable)noticModel callback:(void (^_Nullable)(int errorCode))callback;

/**
 设置蓝牙配对 (不可重复设置,会引起无法再连接设备.只要配对成功,就不需要再设置,只有获取到系统配对设备被忽略,才可设置配对)

 @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)setBluetoothPairingCommandWithCallback:(void (^_Nullable)(int errorCode))callback;

/**
 设置寻找手机

 @param findModel 寻找手机信息 model (IDOSetFindPhoneInfoBuletoothModel)
 @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)setFindPhoneCommand:(IDOSetFindPhoneInfoBuletoothModel * _Nullable)findModel callback:(void (^ _Nullable)(int errorCode))callback;

/**
 设置抬腕

 @param handUpmodel 抬腕信息 model (IDOSetHandUpInfoBuletoothModel)
 @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)setHandUpCommand:(IDOSetHandUpInfoBuletoothModel * _Nullable)handUpmodel callback:(void (^ _Nullable)(int errorCode))callback;

/**
 设置左右手佩戴

 @param handModel 左右手佩戴 model (IDOSetLeftOrRightInfoBuletoothModel)
 @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)setLeftRightHandCommand:(IDOSetLeftOrRightInfoBuletoothModel *_Nullable)handModel callback:(void (^ _Nullable)(int errorCode))callback;

/**
 设置音乐开关

 @param openMusicModel 音乐开关 model (IDOSetMusicOpenInfoBuletoothModel)
 @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)setOpenMusicCommand:(IDOSetMusicOpenInfoBuletoothModel * _Nullable)openMusicModel callback:(void (^ _Nullable)(int errorCode))callback;

/**
 设置预防丢失

 @param lostModel 预防丢失 model (IDOSetPreventLostInfoBuletoothModel)
 @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)setPreventLostCommand:(IDOSetPreventLostInfoBuletoothModel * _Nullable)lostModel callback:(void (^ _Nullable)(int errorCode))callback;

/**
 设置显示模式

 @param displaModel 显示模式 model (IDOSetDisplayModeInfoBluetoothModel)
 @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)setDisplayModeCommand:(IDOSetDisplayModeInfoBluetoothModel * _Nullable)displaModel callback:(void (^ _Nullable)(int errorCode))callback;

/**
 设置久坐

 @param longSitModel 久坐 model (IDOSetLongSitInfoBuletoothModel)
 @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)setLongSitCommand:(IDOSetLongSitInfoBuletoothModel * _Nullable)longSitModel callback:(void (^ _Nullable)(int errorCode))callback;

/**
 设置天气预报开关

 @param weatherModel 天气预报开关 model (IDOSetWeatherSwitchInfoBluetoothModel)
 @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)setWeatherCommand:(IDOSetWeatherSwitchInfoBluetoothModel * _Nullable)weatherModel callback:(void (^ _Nullable)(int errorCode))callback;

/**
 设置心率模式

 @param hrModeModel 心率模式 model (IDOSetHRModeInfoBluetoothModel)
 @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)setHrModeCommand:(IDOSetHrModeInfoBluetoothModel * _Nullable)hrModeModel callback:(void(^_Nullable)(int errorCode))callback;

/**
 设置防打扰模式

 @param noDisturbModeModel 防打扰模式 model (IDOSetNoDisturbModeInfoBluetoothModel)
 @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)setNoDisturbModeCommand:(IDOSetNoDisturbModeInfoBluetoothModel * _Nullable)noDisturbModeModel callback:(void(^_Nullable)(int errorCode))callback;

/**
 设置心率间隔

 @param hrIntervalModel 心率间隔 model (IDOSetHrIntervalInfoBluetoothModel)
 @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)setHrIntervalCommand:(IDOSetHrIntervalInfoBluetoothModel * _Nullable)hrIntervalModel callback:(void(^_Nullable)(int errorCode))callback;

/**
 设置单位

 @param unitModel 单位 model (IDOSetUnitInfoBluetoothModel)
 @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)setUnitCommand:(IDOSetUnitInfoBluetoothModel * _Nullable)unitModel callback:(void(^_Nullable)(int errorCode))callback;

/**
 设置一键呼叫

 @param oneKeySOSModel 一键呼叫 model (IDOSetOneKeySosInfoBuletoothModel)
 @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)setOneKeySosCommand:(IDOSetOneKeySosInfoBuletoothModel * _Nullable)oneKeySOSModel callback:(void(^_Nullable)(int errorCode))callback;

/**
 设置快捷方式

 @param shortcutModel 快捷方式 model (IDOSetShortcutInfoBluetoothModel)
 @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)setShortcutCommand:(IDOSetShortcutInfoBluetoothModel * _Nullable)shortcutModel callback:(void(^_Nullable)(int errorCode))callback;

/**
 设置血压舒张、收缩

 @param calModel 血压舒张、收缩 model (IDOSetBloodPressureInfoBluetoothModel)
 @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str ; model包含校准状态值)
 */
+ (void)setBpCalCommand:(IDOSetBloodPressureInfoBluetoothModel * _Nullable)calModel
               callback:(void(^_Nullable)(int errorCode,IDOSetBloodPressureInfoBluetoothModel * _Nullable model))callback;

/**
 设置运动快捷方式

 @param sportSelectModel 运动快捷方式 model (IDOSetSportShortcutInfoBluetoothModel)
 @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)setSportModeSelectCommand:(IDOSetSportShortcutInfoBluetoothModel * _Nullable)sportSelectModel callback:(void(^_Nullable)(int errorCode))callback;

/**
 设置天气预报数据

 @param weatherDataModel 天气预报数据 model (IDOSetWeatherDataInfoBluetoothModel)
 @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)setWeatherDataCommand:(IDOSetWeatherDataInfoBluetoothModel *_Nullable)weatherDataModel callback:(void (^ _Nullable)(int errorCode))callback;

/**
 设置屏幕亮度

 @param screenBrightnessModel 屏幕亮度 model (IDOSetScreenBrightnessInfoBluetoothModel)
 @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)setScreenBrightnessCommand:(IDOSetScreenBrightnessInfoBluetoothModel * _Nullable)screenBrightnessModel callback:(void (^ _Nullable)(int errorCode))callback;

/**
 设置GPS信息

 @param gpsInfoModel GPS信息 model (IDOSetGpsConfigInfoBluetoothModel)
 @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)setGpsInfoCommand:(IDOSetGpsConfigInfoBluetoothModel * _Nullable)gpsInfoModel callback:(void (^ _Nullable)(int errorCode))callback;

/**
 设置GPS控制信息

 @param gpsControlModel GPS控制信息 model (IDOSetGpsControlInfoBluetoothModel)
 @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) (status 0 : 写入失败 , 1 : 正在写入 , 2 : 写入完成)
 */
+ (void)setGpsControlCommand:(IDOSetGpsControlInfoBluetoothModel * _Nullable)gpsControlModel
                    callback:(void (^ _Nullable)(int status,int errorCode))callback;

/**
 设置控制连接参数

 @param connParamModel 控制连接参数 model (IDOSetConnParamInfoBluetoothModel)
 @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)setConnParamCommand:(IDOSetConnParamInfoBluetoothModel * _Nullable)connParamModel callback:(void (^ _Nullable)(int errorCode))callback;

/**
 设置热启动参数
 
 @param hotStartParamModel 热启动参数 model (IDOGetHotStartParamBluetoothModel)
 @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)setHotStartParamCommand:(IDOGetHotStartParamBluetoothModel * _Nullable)hotStartParamModel callback:(void (^ _Nullable)(int errorCode))callback;

/**
 设置传感器实时数据

 @param realTimeModel 传感器实时数据 model (IDOSetRealTimeSensorDataInfoBluetoothModel)
 @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)setRealTimeSensorDataCommand:(IDOSetRealTimeSensorDataInfoBluetoothModel * _Nullable)realTimeModel callback:(void (^ _Nullable)(int errorCode))callback;

/**
 设置马达参数

 @param startMotorModel 马达参数 model (IDOSetStartMotorInfoBluetoothModel)
 @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)setStartMotorCommand:(IDOSetStartMotorInfoBluetoothModel * _Nullable)startMotorModel callback:(void (^ _Nullable)(int errorCode))callback;


/**
 设置表盘参数

 @param watchDiaModel 表盘参数 model (IDOSetWatchDiaInfoBluetoothModel)
 @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)setWatchDiaCommand:(IDOSetWatchDiaInfoBluetoothModel * _Nullable)watchDiaModel callback:(void (^ _Nullable)(int errorCode))callback;


/**
 设置血压测量参数

 @param bpMeasureModel 血压测量参数 model (IDOSetBpMeasureInfoBluetoothModel)
 @param callback 设置回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str ; model实时血压数据和状态)
 */
+ (void)setBpMeasureCommand:(IDOSetBpMeasureInfoBluetoothModel * _Nullable)bpMeasureModel
                   callback:(void (^ _Nullable)(int errorCode,IDOSetBpMeasureInfoBluetoothModel * _Nullable model))callback;;


/**
 设置睡眠时间段

 @param sleepPeriodModel 睡眠时间段 model (IDOSetSleepPeriodInfoBluetoothModel)
 @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)setSleepPeriodCommand:(IDOSetSleepPeriodInfoBluetoothModel * _Nullable)sleepPeriodModel callback:(void (^ _Nullable)(int errorCode))callback;

/**
 设置女性生理周期 (id205)
 
 @param menstrualModel 女性生理周期 model (IDOSetMenstruationInfoBluetoothModel)
 @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)setMenstrualCommand:(IDOSetMenstruationInfoBluetoothModel * _Nullable)menstrualModel callback:(void (^ _Nullable)(int errorCode))callback;


/**
 设置女性生理周期提醒 (id205)
 
 @param remindModel 女性生理周期提醒 model (IDOSetMenstruationRemindBluetoothModel)
 @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)setMenstrualRemindCommand:(IDOSetMenstruationRemindBluetoothModel * _Nullable)remindModel callback:(void (^ _Nullable)(int errorCode))callback;

#pragma mark ======= get Command =======

/**
 获取mac地址

 @param callback 执行后回调 data (IDOGetMacAddrInfoBluetoothModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)getMacAddrCommand:(void(^_Nullable)(int errorCode,IDOGetMacAddrInfoBluetoothModel * _Nullable data))callback;

/**
 获取设备信息

 @param callback 执行后回调 data (IDOGetDeviceInfoBluetoothModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)getDeviceInfoCommand:(void(^_Nullable)(int errorCode,IDOGetDeviceInfoBluetoothModel * _Nullable data))callback;

/**
 获取功能列表

 @param callback 执行后回调 data (IDOGetDeviceFuncBluetoothModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)getFuncTableCommand:(void(^_Nullable)(int errorCode,IDOGetDeviceFuncBluetoothModel * _Nullable data))callback;

/**
 获得实时数据

 @param callback 执行后回调 data (IDOGetLiveDataBluetoothModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)getLiveDataCommand:(void(^_Nullable)(int errorCode,IDOGetLiveDataBluetoothModel * _Nullable data))callback;

/**
 获取设备当前时间

 @param callback 执行后回调 data (IDOGetDeviceTimeBluetoothModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)getDeviceTimeCommand:(void(^_Nullable)(int errorCode,IDOGetDeviceTimeBluetoothModel * _Nullable data))callback;

/**
 获取通知中心的状态

 @param callback 执行后回调 data (IDOSetNoticeInfoBuletoothModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)getNoticeStatusCommand:(void(^_Nullable)(int errorCode,IDOSetNoticeInfoBuletoothModel * _Nullable data))callback;

/**
 获取心率传感器参数

 @param callback 执行后回调 data (IDOGetHrSensorParamBluetoothModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)getHrSensorParamCommand:(void(^_Nullable)(int errorCode,IDOGetHrSensorParamBluetoothModel * _Nullable data))callback;

/**
 获取加速度传感器参数

 @param callback 执行后回调 data (IDOGetGsensorParamBluetoothModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)getGsensorParamCommand:(void(^_Nullable)(int errorCode,IDOGetGsensorParamBluetoothModel * _Nullable data))callback;

/**
 获取活动数量

 @param callback 执行后回调 data (IDOGetActivityCountBluetoothModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)getActivityCountCommand:(void(^_Nullable)(int errorCode,IDOGetActivityCountBluetoothModel * _Nullable data))callback;

/**
 获取hid信息

 @param callback 执行后回调 data (IDOGetHidInfoBluetoothModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)getHidInfoCommand:(void(^_Nullable)(int errorCode,IDOGetHidInfoBluetoothModel * _Nullable data))callback;

/**
 获取gps信息

 @param callback 执行后回调 data (IDOGetGpsInfoBluetoothModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)getGpsInfoCommand:(void(^_Nullable)(int errorCode,IDOGetGpsInfoBluetoothModel * _Nullable data))callback;

/**
 获取热启动参数

 @param callback 执行后回调 data (IDOGetHotStartParamBluetoothModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)getHotStartParamCommand:(void(^_Nullable)(int errorCode,IDOGetHotStartParamBluetoothModel * _Nullable data))callback;

/**
 获取GPS状态
 
 @param callback 执行后回调 data (IDOGetGpsStatusBluetoothModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)getGpsStatusCommand:(void(^_Nullable)(int errorCode,IDOGetGpsStatusBluetoothModel * _Nullable data))callback;

#pragma mark ======= listen Command =======

/**
 音乐开始
 
 @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)listenMusicStartCommand:(void(^_Nullable)(int errorCode))callback;

/**
 音乐暂停
 
 @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)listenMusicPauseCommand:(void(^_Nullable)(int errorCode))callback;

/**
 音乐结束
 
 @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)listenMusicStopCommand:(void(^_Nullable)(int errorCode))callback;

/**
 音乐上一首
 
 @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)listenMusicLastCommand:(void(^_Nullable)(int errorCode))callback;

/**
 音乐下一首
 
 @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)listenMusicNextCommand:(void(^_Nullable)(int errorCode))callback;

/**
 单次拍照
 
 @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)listenPhotoSingleShotCommand:(void(^_Nullable)(int errorCode))callback;

/**
 连续拍照
 
 @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)listenPhotoBurstCommand:(void(^_Nullable)(int errorCode))callback;

/**
 拍照开始
 
 @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)listenPhotoStartCommand:(void(^_Nullable)(int errorCode))callback;

/**
 拍照结束
 
 @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)listenPhotoEndCommand:(void(^_Nullable)(int errorCode))callback;

/**
 音量+
 
 @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)listenVolumeUpCommand:(void(^_Nullable)(int errorCode))callback;

/**
 音量-
 
 @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)listenVolumeDownCommand:(void(^_Nullable)(int errorCode))callback;

/**
 寻找手机开始
 
 @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)listenFindPhoneStartCommand:(void(^_Nullable)(int errorCode))callback;

/**
 寻找手机结束
 
 @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)listenFindPhoneStopCommand:(void(^_Nullable)(int errorCode))callback;

/**
 防丢启动
 
 @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)listenLostStartCommand:(void(^_Nullable)(int errorCode))callback;

/**
 防丢结束
 
 @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)listenLostStopCommand:(void(^_Nullable)(int errorCode))callback;

/**
 一键求救
 
 @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)listenSosStartCommand:(void(^_Nullable)(int errorCode))callback;

/**
 闹钟同步完成
 
 @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)listenAlarmSyncCompleteCommand:(void(^_Nullable)(int errorCode))callback;

/**
 配置同步完成
 
 @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)listenConfigSyncCompleteCommand:(void(^_Nullable)(int errorCode))callback;

/**
 健康同步完成
 
 @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)listenHealthSyncCompleteCommand:(void(^_Nullable)(int errorCode))callback;

/**
 数据传输完成
 
 @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)listenDataTranCompleteCommand:(void(^_Nullable)(int errorCode))callback;

/**
 配置快速同步完成
 
 @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)listenConfigFastSyncCompleteCommand:(void(^_Nullable)(int errorCode))callback;

/**
 GPS数据同步完成
 
 @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)listenGpsSyncCompleteCommand:(void(^_Nullable)(int errorCode))callback;

/**
 活动数据同步完成
 
 @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)listenActivitySyncCompleteCommand:(void(^_Nullable)(int errorCode))callback;

#pragma mark ======= progress Command =======

/**
 健康数据同步进度
 
 @param callback 健康数据同步进度回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)healthSyncProgressCommand:(void(^_Nullable)(int progress,int errorCode))callback;

/**
 闹钟数据同步进度
 
 @param callback 闹钟数据同步进度回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)alarmSyncProgressCommand:(void(^_Nullable)(int progress,int errorCode))callback;

/**
 活动数据同步进度
 
 @param callback 活动数据同步进度回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)activitySyncProgressCommand:(void(^_Nullable)(int progress,int errorCode))callback;

/**
 数据交换进度 手环->app
 
 @param callback 数据交换进度回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)dataTranProgressCommand:(void(^_Nullable)(int progress,int errorCode))callback;

/**
 gps数据同步进度
 
 @param callback  gps数据同步进度回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)gpsProgressCommand:(void(^_Nullable)(int progress,int errorCode))callback;

/**
 数据交换进度 app->手环
 
 @param callback  数据交换进度回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)appDataTranProgressCommand:(void(^_Nullable)(int progress,int errorCode))callback;

/**
 配置同步进度
 
 @param callback 配置同步进度回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)configSyncProgressCommand:(void(^_Nullable)(int progress,int errorCode))callback;

#pragma mark ======= data exchange Command =======

/**
 app 发起运动开始

 @param model IDODataExchangeModel (数据交换model, day|hour|minute|second|sportType|targetType|targetValue|forceStart 这些属性需要赋值)
 @param startCallback 运动发起回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)appStartSportCommand:(IDODataExchangeModel * _Nullable)model
               startCallback:(void (^_Nullable)(IDODataExchangeModel * _Nullable model,int errorCode))startCallback;

/**
 app 发起运动结束

 @param model IDODataExchangeModel 活动时间需要保持一致,才能停止活动不然无效,当前model对象为全局时,只要开始活动记录开始时间,
              结束时不需要再次给时间赋值,只需要给 durations|calories|distance|sportType|isSave 这些属性需要赋值
 @param appEndCallback 运动停止回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)appEndSportCommand:(IDODataExchangeModel *_Nullable)model
            appEndcallback:(void (^_Nullable)(IDODataExchangeModel *  _Nullable model,int errorCode))appEndCallback;

/**
 app发起的运动 手环主动结束
 
 @param model IDODataExchangeModel 手环主动发起结束 APP需要给手环发送运动数据, durations|calories|distance|errorCode 这些属性需要赋值
 @param appBleEndCallback 手环发起停止回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)appBleEndReplyCommand:(IDODataExchangeModel *_Nullable)model
            appBleEndCallback:(void (^_Nullable)(IDODataExchangeModel *  _Nullable model,int errorCode))appBleEndCallback;


/**
 app发起运动暂停

 @param model IDODataExchangeModel 活动时间需要保持一致,才能暂停活动不然无效,当前model对象为全局时,
              只要开始活动记录开始时间,暂停时不需要再次给时间赋值,直接传入当前model
 @param pauseCallback 运动暂停回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)appPauseSportCommand:(IDODataExchangeModel *_Nullable)model
               pauseCallback:(void (^_Nullable)(IDODataExchangeModel *  _Nullable model,int errorCode))pauseCallback;



/**
 app发起的运动 手环主动暂停
 
 @param model IDODataExchangeModel 手环主动发起暂停 APP需要给手环发送运动数据, errorCode 这个属性需要赋值
 @param appBlePauseCallback 手环发起暂停回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)appBlePauseReplyCommand:(IDODataExchangeModel *_Nullable)model
            appBlePauseCallback:(void (^_Nullable)(IDODataExchangeModel *  _Nullable model,int errorCode))appBlePauseCallback;


/**
 app 发起运动恢复

 @param model IDODataExchangeModel 活动时间需要保持一致,才能恢复活动不然无效,当前model对象为全局时,
              只要开始活动记录开始时间,恢复时不需要再次给时间赋值,直接传入当前model
 @param appRestoreCallback 运动恢复回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)appRestoreSportCommand:(IDODataExchangeModel * _Nullable)model
            appRestoreCallback:(void (^_Nullable)(IDODataExchangeModel *  _Nullable model,int errorCode))appRestoreCallback;

/**
 app发起的运动 手环主动恢复
 
 @param model IDODataExchangeModel 手环主动发起恢复 APP需要给手环发送运动数据, errorCode 这个属性需要赋值
 @param appBleRestoreCallback 手环发起恢复回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)appBleRestoreReplyCommand:(IDODataExchangeModel *_Nullable)model
            appBleRestoreCallback:(void (^_Nullable)(IDODataExchangeModel *  _Nullable model,int errorCode))appBleRestoreCallback;

/**
 app发起数据交换过程

 @param model IDODataExchangeModel 活动时间需要保持一致,才能发送活动数据不然无效,当前model对象为全局时,
              只要开始活动记录开始时间,发送活动数据时不需要再次给时间赋值,只需要给 status|duration|calories|distance 这些属性需要赋值
 @param appIngCallback 运动发送数据回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)appIngSportCommand:(IDODataExchangeModel *_Nullable)model
            appIngCallback:(void (^_Nullable)(IDODataExchangeModel * _Nullable model,int errorCode))appIngCallback;

/**
 手环发起运动开始
 
 @param model IDODataExchangeModel 只需要给 retCode 这个属性需要赋值
 @param bleStartCallback 手环发起运动开始回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)bleStartSportCommand:(IDODataExchangeModel *_Nullable)model
            bleStartCallback:(void (^_Nullable)(IDODataExchangeModel * _Nullable model,int errorCode))bleStartCallback;

/**
 手环发起运动暂停
 
 @param model IDODataExchangeModel 只需要给 retCode 这个属性需要赋值
 @param blePauseCallback 手环发起运动暂停回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)blePauseSportCommand:(IDODataExchangeModel *_Nullable)model
            blePauseCallback:(void (^_Nullable)(IDODataExchangeModel * _Nullable model,int errorCode))blePauseCallback;

/**
 手环发起运动恢复

 @param model IDODataExchangeModel 只需要给 retCode 这个属性需要赋值
 @param bleRestoreCallback 手环发起运动恢复回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)bleRestoreSportCommand:(IDODataExchangeModel *_Nullable)model
            bleRestoreCallback:(void (^_Nullable)(IDODataExchangeModel * _Nullable model,int errorCode))bleRestoreCallback;

/**
 手环发起运动结束

 @param model IDODataExchangeModel 只需要给 retCode 这个属性需要赋值
 @param bleEndCallback 手环发起运动结束回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)bleEndSportCommand:(IDODataExchangeModel *_Nullable)model
            bleEndCallback:(void (^_Nullable)(IDODataExchangeModel * _Nullable model,int errorCode))bleEndCallback;

/**
 手环发起运动发送数据
 
 @param model IDODataExchangeModel 只需要给 distance 这个属性需要赋值
 @param bleIngCallback 手环发起运动发送数据 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)bleIngSportCommand:(IDODataExchangeModel *_Nullable)model
            bleIngCallback:(void (^_Nullable)(IDODataExchangeModel * _Nullable model,int errorCode))bleIngCallback;

@end
