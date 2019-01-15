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
 连接发送通知 | Connection to send notifications
 */
+ (void)didConnect;

/**
 断开发送通知 | Disconnect notification
 */
+ (void)disConnect;

/**
 * @brief 音乐开始 | Music begins
 * @param callback 执行后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Post-execution callback (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)musicStartCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 音乐结束 | End of music
 * @param callback 执行后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Post-execution callback (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)musicStopCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 相机开始 | Camera starts
 * @param callback 执行后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Post-execution callback (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)cameraStartCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 相机结束 | Camera ends
 * @param callback 执行后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Post-execution callback (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)cameraStopCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 开始寻找设备 | Start looking for equipment
 * @param callback 执行后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Post-execution callback (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)findDeviceStartCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 结束寻找设备 | End finding equipment
 * @param callback 执行后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Post-execution callback (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)findDeviceStopCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 打开ANCS(苹果通知中心) | Open ANCS (Apple Notification Center)
 * @param callback 执行后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Post-execution callback (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)belOpenAncsCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 关闭ANCS(苹果通知中心) | Close ANCS (Apple Notification Center)
 * @param callback 执行后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Post-execution callback (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)belCloseAncsCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 设备绑定 | Device Binding
 * @param bindModel 绑定 model (IDOSetBindingInfoBluetoothModel) (只有在授权绑定才会存储数据) | Binding model (IDOSetBindingInfoBluetoothModel) (Data will only be stored if the binding is authorized)
 * @param callback 执行后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Post-execution callback (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)bindingCommand:(IDOSetBindingInfoBluetoothModel * _Nullable)bindModel
              callback:(void (^_Nullable)(IDO_BIND_STATUS status, int errorCode))callback;

/**
 * @brief 设备解绑 | Unbundling equipment
 * @param callback 执行后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Post-execution callback (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)unbindingCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 设备强制解绑 | Device forced unbundling
 * @param callback 执行后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Post-execution callback (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)mandatoryUnbindingCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 设备配置复位 | Device Configuration Reset
 * @param callback 执行后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Post-execution callback (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)setDefaultConfigCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 控制设备重启 | Control device restart
 * @param callback 执行后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Post-execution callback (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)setAppRebootCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 获取扩展功能列表 | Get the list of extended features
 * @param callback 执行回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Execute callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)getFuncTableExCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 设备进入ota升级模式 | The device enters the ota upgrade mode.
 * @param callback 执行回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Execute callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setOtaCommand:(void(^_Nullable)(int state , int errorCode))callback;

#pragma mark ======= set Command =======


/**
 * @brief  设置授权码绑定 | Set Authorization Code Binding
 * @param bindModel 绑定 model (IDOSetBindingInfoBluetoothModel) | binding model
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setAuthCodeCommand:(IDOSetBindingInfoBluetoothModel * _Nullable)bindModel callback:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 设置当前时间 | Set current time
 * @param timeModel 时间 model (IDOSetTimeInfoBluetoothModel) | time model (IDOSetTimeInfoBluetoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setCurrentTimeCommand:(IDOSetTimeInfoBluetoothModel * _Nullable)timeModel callback:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 设置闹钟 | Set an alarm
 * @param alarmModel 闹钟 model (IDOSetAlarmInfoBluetoothModel) | Alarm clock model (IDOSetAlarmInfoBluetoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)| Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setAlarmCommand:(IDOSetAlarmInfoBluetoothModel * _Nullable)alarmModel callback:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 批量设置闹钟 | Set alarms in batches
 * @param alarmModels 闹钟集合 model (IDOSetAlarmInfoBluetoothModel) | Alarm clock collection model (IDOSetAlarmInfoBluetoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)| Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setAllAlarmsCommand:(NSArray <IDOSetAlarmInfoBluetoothModel *> * _Nullable)alarmModels callback:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 设置用户信息 | Setting user information
 * @param userModel 用户信息 model (IDOSetUserInfoBuletoothModel) | User Information model (IDOSetUserInfoBuletoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)| Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setUserInfoCommand:(IDOSetUserInfoBuletoothModel * _Nullable)userModel callback:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 设置卡路里和距离目标 | Set calories and distance targets
 * @param userModel 用户信息 model (IDOSetUserInfoBuletoothModel) | User Information model (IDOSetUserInfoBuletoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)| Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setCalorieAndDistanceGoalCommand:(IDOSetUserInfoBuletoothModel * _Nullable)userModel callback:(void (^ _Nullable)(int errorCode))callback;

/**
 * @brief 设置目标 | Setting goals

 * @param targetModel 目标信息 model (IDOSetUserInfoBuletoothModel) | targetModel target information model (IDOSetUserInfoBuletoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)| Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setTargetInfoCommand:(IDOSetUserInfoBuletoothModel * _Nullable)targetModel callback:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 设置通知中心、来电提醒开关 ⚠️在配对过程中不要执行其他命令。 | Set up notification center, call alert switch.⚠️Do not execute other commands during pairing.

 * @param noticModel 通知开关信息 model (IDOSetNoticeInfoBuletoothModel) | Notification switch information model (IDOSetNoticeInfoBuletoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)| Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setSwitchNoticeCommand:(IDOSetNoticeInfoBuletoothModel * _Nullable)noticModel callback:(void (^_Nullable)(int errorCode))callback;

/**
 * @brief 设置蓝牙配对 (不可重复设置,会引起无法再连接设备.只要配对成功,就不需要再设置,只有获取到系统配对设备被忽略,才可设置配对。⚠️在配对过程中不要执行其他命令。) | Set up Bluetooth pairing (cannot be set repeatedly, it will cause the device to be connected again. As long as the pairing is successful, you don't need to set it again. Only when the system pairing device is ignored, the pairing can be set.⚠️Do not execute other commands during pairing.)

 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)| Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setBluetoothPairingCommandWithCallback:(void (^_Nullable)(int errorCode))callback;

/**
 * @brief 设置寻找手机 | Set looking for a mobile phone

 * @param findModel 寻找手机信息 model (IDOSetFindPhoneInfoBuletoothModel) | Find mobile information model (IDOSetFindPhoneInfoBuletoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setFindPhoneCommand:(IDOSetFindPhoneInfoBuletoothModel * _Nullable)findModel callback:(void (^ _Nullable)(int errorCode))callback;

/**
 * @brief 设置抬腕 | Set the wrist

 * @param handUpmodel 抬腕信息 model (IDOSetHandUpInfoBuletoothModel) | Wrist information model (IDOSetHandUpInfoBuletoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setHandUpCommand:(IDOSetHandUpInfoBuletoothModel * _Nullable)handUpmodel callback:(void (^ _Nullable)(int errorCode))callback;

/**
 * @brief 设置左右手佩戴 | Set the left and right hand to wear

 * @param handModel 左右手佩戴 model (IDOSetLeftOrRightInfoBuletoothModel) | Left and right hand wearing model (IDOSetLeftOrRightInfoBuletoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setLeftRightHandCommand:(IDOSetLeftOrRightInfoBuletoothModel *_Nullable)handModel callback:(void (^ _Nullable)(int errorCode))callback;

/**
 * @brief 设置音乐开关 | Set music switch

 * @param openMusicModel 音乐开关 model (IDOSetMusicOpenInfoBuletoothModel) | Music Switch model (IDOSetMusicOpenInfoBuletoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setOpenMusicCommand:(IDOSetMusicOpenInfoBuletoothModel * _Nullable)openMusicModel callback:(void (^ _Nullable)(int errorCode))callback;

/**
 * @brief 设置预防丢失 | Set to prevent loss

 * @param lostModel 预防丢失 model (IDOSetPreventLostInfoBuletoothModel) | Prevent loss model (IDOSetPreventLostInfoBuletoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setPreventLostCommand:(IDOSetPreventLostInfoBuletoothModel * _Nullable)lostModel callback:(void (^ _Nullable)(int errorCode))callback;

/**
 * @brief 设置显示模式 | Setting the display mode
 * @param displaModel 显示模式 model (IDOSetDisplayModeInfoBluetoothModel) | Display mode model (IDOSetDisplayModeInfoBluetoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setDisplayModeCommand:(IDOSetDisplayModeInfoBluetoothModel * _Nullable)displaModel callback:(void (^ _Nullable)(int errorCode))callback;

/**
 * @brief 设置久坐 | Set sedentary

 * @param longSitModel 久坐 model (IDOSetLongSitInfoBuletoothModel) | Sedentary model (IDOSetLongSitInfoBuletoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setLongSitCommand:(IDOSetLongSitInfoBuletoothModel * _Nullable)longSitModel callback:(void (^ _Nullable)(int errorCode))callback;

/**
 * @brief 设置天气预报开关 | Set the weather forecast switch
 * @param weatherModel 天气预报开关 model (IDOSetWeatherSwitchInfoBluetoothModel) | Weather Forecast Switch model (IDOSetWeatherSwitchInfoBluetoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setWeatherCommand:(IDOSetWeatherSwitchInfoBluetoothModel * _Nullable)weatherModel callback:(void (^ _Nullable)(int errorCode))callback;

/**
 * @brief 设置心率模式 | Set heart rate mode

 * @param hrModeModel 心率模式 model (IDOSetHRModeInfoBluetoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setHrModeCommand:(IDOSetHrModeInfoBluetoothModel * _Nullable)hrModeModel callback:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 设置防打扰模式 | Set the anti-disturb mode

 * @param noDisturbModeModel 防打扰模式 model (IDOSetNoDisturbModeInfoBluetoothModel) | Anti-disturbance mode model (IDOSetNoDisturbModeInfoBluetoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setNoDisturbModeCommand:(IDOSetNoDisturbModeInfoBluetoothModel * _Nullable)noDisturbModeModel callback:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 设置心率间隔 | Set heart rate interval

 * @param hrIntervalModel 心率间隔 model (IDOSetHrIntervalInfoBluetoothModel) | Heart Rate Interval model (IDOSetHrIntervalInfoBluetoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setHrIntervalCommand:(IDOSetHrIntervalInfoBluetoothModel * _Nullable)hrIntervalModel callback:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 设置单位 | Setting unit

 * @param unitModel 单位 model (IDOSetUnitInfoBluetoothModel) | unit model (IDOSetUnitInfoBluetoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setUnitCommand:(IDOSetUnitInfoBluetoothModel * _Nullable)unitModel callback:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 设置一键呼叫 | Set up a one-click call

 * @param oneKeySOSModel 一键呼叫 model (IDOSetOneKeySosInfoBuletoothModel) | One-click calling model (IDOSetOneKeySosInfoBuletoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setOneKeySosCommand:(IDOSetOneKeySosInfoBuletoothModel * _Nullable)oneKeySOSModel callback:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 设置快捷方式 | Setting shortcuts

 * @param shortcutModel 快捷方式 model (IDOSetShortcutInfoBluetoothModel) | Shortcut model (IDOSetShortcutInfoBluetoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setShortcutCommand:(IDOSetShortcutInfoBluetoothModel * _Nullable)shortcutModel callback:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 设置血压舒张、收缩 | Set blood pressure to relax and contract

 * @param calModel 血压舒张、收缩 model (IDOSetBloodPressureInfoBluetoothModel) | Blood pressure diastolic, contraction model (IDOSetBloodPressureInfoBluetoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str ; model包含校准状态值) | Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setBpCalCommand:(IDOSetBloodPressureInfoBluetoothModel * _Nullable)calModel
               callback:(void(^_Nullable)(int errorCode,IDOSetBloodPressureInfoBluetoothModel * _Nullable model))callback;

/**
 * @brief 设置运动快捷方式 | Set motion shortcuts

 * @param sportSelectModel 运动快捷方式 model (IDOSetSportShortcutInfoBluetoothModel) | Sports shortcut model (IDOSetSportShortcutInfoBluetoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setSportModeSelectCommand:(IDOSetSportShortcutInfoBluetoothModel * _Nullable)sportSelectModel callback:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 设置天气预报数据 | Set weather forecast data

 * @param weatherDataModel 天气预报数据 model (IDOSetWeatherDataInfoBluetoothModel) | Weather Forecast Data model (IDOSetWeatherDataInfoBluetoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setWeatherDataCommand:(IDOSetWeatherDataInfoBluetoothModel *_Nullable)weatherDataModel callback:(void (^ _Nullable)(int errorCode))callback;

/**
 * @brief 设置屏幕亮度 | Set screen brightness

 * @param screenBrightnessModel 屏幕亮度 model (IDOSetScreenBrightnessInfoBluetoothModel) | Screen Brightness model (IDOSetScreenBrightnessInfoBluetoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setScreenBrightnessCommand:(IDOSetScreenBrightnessInfoBluetoothModel * _Nullable)screenBrightnessModel callback:(void (^ _Nullable)(int errorCode))callback;

/**
 * @brief  设置GPS信息 | Set GPS information

 * @param gpsInfoModel GPS信息 model (IDOSetGpsConfigInfoBluetoothModel) | GPS information model (IDOSetGpsConfigInfoBluetoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setGpsInfoCommand:(IDOSetGpsConfigInfoBluetoothModel * _Nullable)gpsInfoModel callback:(void (^ _Nullable)(int errorCode))callback;

/**
 * @brief 设置GPS控制信息 | Set GPS Control Information

 * @param gpsControlModel GPS控制信息 model (IDOSetGpsControlInfoBluetoothModel) | GPS Control Information model (IDOSetGpsControlInfoBluetoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) (status 0 : 写入失败 , 1 : 正在写入 , 2 : 写入完成)
 */
+ (void)setGpsControlCommand:(IDOSetGpsControlInfoBluetoothModel * _Nullable)gpsControlModel
                    callback:(void (^ _Nullable)(int status,int errorCode))callback;

/**
 * @brief 设置控制连接参数 | Setting Control Connection Parameters

 * @param connParamModel 控制连接参数 model (IDOSetConnParamInfoBluetoothModel) | Control connection parameters model (IDOSetConnParamInfoBluetoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setConnParamCommand:(IDOSetConnParamInfoBluetoothModel * _Nullable)connParamModel callback:(void (^ _Nullable)(int errorCode))callback;

/**
 * @brief  设置热启动参数 | Setting hot start parameters
 
 * @param hotStartParamModel 热启动参数 model (IDOGetHotStartParamBluetoothModel) | Hot Start Parameters model (IDOGetHotStartParamBluetoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setHotStartParamCommand:(IDOGetHotStartParamBluetoothModel * _Nullable)hotStartParamModel callback:(void (^ _Nullable)(int errorCode))callback;

/**
 * @brief   设置传感器实时数据 | Set sensor real-time data

 * @param realTimeModel 传感器实时数据 model (IDOSetRealTimeSensorDataInfoBluetoothModel) | Sensor real-time data model (IDOSetRealTimeSensorDataInfoBluetoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setRealTimeSensorDataCommand:(IDOSetRealTimeSensorDataInfoBluetoothModel * _Nullable)realTimeModel callback:(void (^ _Nullable)(int errorCode))callback;

/**
 * @brief 设置马达参数 | Setting the motor parameters

 * @param startMotorModel 马达参数 model (IDOSetStartMotorInfoBluetoothModel) | Motor Parameter model (IDOSetStartMotorInfoBluetoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setStartMotorCommand:(IDOSetStartMotorInfoBluetoothModel * _Nullable)startMotorModel callback:(void (^ _Nullable)(int errorCode))callback;


/**
 * @brief 设置表盘参数 | Setting the dial parameters

 * @param watchDiaModel 表盘参数 model (IDOSetWatchDiaInfoBluetoothModel) | Dial Parameters model (IDOSetWatchDiaInfoBluetoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setWatchDiaCommand:(IDOSetWatchDiaInfoBluetoothModel * _Nullable)watchDiaModel callback:(void (^ _Nullable)(int errorCode))callback;


/**
 * @brief 设置血压测量参数 | Setting blood pressure measurement parameters

 * @param bpMeasureModel 血压测量参数 model (IDOSetBpMeasureInfoBluetoothModel) | Blood pressure measurement parameters model (IDOSetBpMeasureInfoBluetoothModel)
 * @param callback 设置回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str ; model实时血压数据和状态) | Set callback (errorCode: 0 transmission succeeded, other values are wrong, error code str can be obtained according to IDOErrorCodeToStr; model real-time blood pressure data and status)
 */
+ (void)setBpMeasureCommand:(IDOSetBpMeasureInfoBluetoothModel * _Nullable)bpMeasureModel
                   callback:(void (^ _Nullable)(int errorCode,IDOSetBpMeasureInfoBluetoothModel * _Nullable model))callback;;


/**
 * @brief 设置睡眠时间段 | Setting the sleep period

 * @param sleepPeriodModel 睡眠时间段 model (IDOSetSleepPeriodInfoBluetoothModel) | Sleep time period model (IDOSetSleepPeriodInfoBluetoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setSleepPeriodCommand:(IDOSetSleepPeriodInfoBluetoothModel * _Nullable)sleepPeriodModel callback:(void (^ _Nullable)(int errorCode))callback;

/**
 * @brief 设置女性生理周期 (id205) | Setting the female physiological cycle (id205)
 
 * @param menstrualModel 女性生理周期 model (IDOSetMenstruationInfoBluetoothModel) | Female Physiological Cycle model (IDOSetMenstruationInfoBluetoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setMenstrualCommand:(IDOSetMenstruationInfoBluetoothModel * _Nullable)menstrualModel callback:(void (^ _Nullable)(int errorCode))callback;


/**
 * @brief 设置女性生理周期提醒 (id205) | Set Women's Physiological Cycle Reminder (id205)
 
 * @param remindModel 女性生理周期提醒 model (IDOSetMenstruationRemindBluetoothModel) | Female Physiological Cycle Reminder model (IDOSetMenstruationRemindBluetoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setMenstrualRemindCommand:(IDOSetMenstruationRemindBluetoothModel * _Nullable)remindModel callback:(void (^ _Nullable)(int errorCode))callback;

#pragma mark ======= get Command =======

/**
 * @brief 获取mac地址 | Get mac address

 * @param callback 执行后回调 data (IDOGetMacAddrInfoBluetoothModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Post-execution callback data (IDOGetMacAddrInfoBluetoothModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)getMacAddrCommand:(void(^_Nullable)(int errorCode,IDOGetMacAddrInfoBluetoothModel * _Nullable data))callback;

/**
 * @brief  获取设备信息 | Get device information

 * @param callback 执行后回调 data (IDOGetDeviceInfoBluetoothModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Post-execution callback data (IDOGetDeviceInfoBluetoothModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)getDeviceInfoCommand:(void(^_Nullable)(int errorCode,IDOGetDeviceInfoBluetoothModel * _Nullable data))callback;

/**
 * @brief  获取功能列表 | Get the list of features

 * @param callback 执行后回调 data (IDOGetDeviceFuncBluetoothModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Post-execution callback data (IDOGetDeviceFuncBluetoothModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)getFuncTableCommand:(void(^_Nullable)(int errorCode,IDOGetDeviceFuncBluetoothModel * _Nullable data))callback;

/**
 * @brief  获得实时数据 | Get real-time data

 * @param callback 执行后回调 data (IDOGetLiveDataBluetoothModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Post-execution callback data (IDOGetLiveDataBluetoothModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)getLiveDataCommand:(void(^_Nullable)(int errorCode,IDOGetLiveDataBluetoothModel * _Nullable data))callback;

/**
 * @brief 获取设备当前时间 | Get the current time of the device

 * @param callback 执行后回调 data (IDOGetDeviceTimeBluetoothModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Post-execution callback data (IDOGetDeviceTimeBluetoothModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)getDeviceTimeCommand:(void(^_Nullable)(int errorCode,IDOGetDeviceTimeBluetoothModel * _Nullable data))callback;

/**
 * @brief 获取通知中心的状态 | Get the status of the notification center

 * @param callback 执行后回调 data (IDOSetNoticeInfoBuletoothModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Post-execution callback data (IDOSetNoticeInfoBuletoothModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)getNoticeStatusCommand:(void(^_Nullable)(int errorCode,IDOSetNoticeInfoBuletoothModel * _Nullable data))callback;

/**
 * @brief 获取心率传感器参数 | Get Heart Rate Sensor Parameters

 * @param callback 执行后回调 data (IDOGetHrSensorParamBluetoothModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Post-execution callback data (IDOGetHrSensorParamBluetoothModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)getHrSensorParamCommand:(void(^_Nullable)(int errorCode,IDOGetHrSensorParamBluetoothModel * _Nullable data))callback;

/**
 * @brief 获取加速度传感器参数 | Acquire acceleration sensor parameters

 * @param callback 执行后回调 data (IDOGetGsensorParamBluetoothModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Post-execution callback data (IDOGetGsensorParamBluetoothModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)getGsensorParamCommand:(void(^_Nullable)(int errorCode,IDOGetGsensorParamBluetoothModel * _Nullable data))callback;

/**
 * @brief 获取活动数量 | Get the number of events

 * @param callback 执行后回调 data (IDOGetActivityCountBluetoothModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Post-execution callback data (IDOGetActivityCountBluetoothModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)getActivityCountCommand:(void(^_Nullable)(int errorCode,IDOGetActivityCountBluetoothModel * _Nullable data))callback;

/**
 * @brief  获取hid信息 | Get hid information

 * @param callback 执行后回调 data (IDOGetHidInfoBluetoothModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Post-execution callback data (IDOGetHidInfoBluetoothModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)getHidInfoCommand:(void(^_Nullable)(int errorCode,IDOGetHidInfoBluetoothModel * _Nullable data))callback;

/**
 * @brief  获取gps信息 | Get gps information

 * @param callback 执行后回调 data (IDOGetGpsInfoBluetoothModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Post-execution callback data (IDOGetGpsInfoBluetoothModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)getGpsInfoCommand:(void(^_Nullable)(int errorCode,IDOGetGpsInfoBluetoothModel * _Nullable data))callback;

/**
 * @brief  获取热启动参数 | Get hot start parameters

 * @param callback 执行后回调 data (IDOGetHotStartParamBluetoothModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Post-execution callback data (IDOGetHotStartParamBluetoothModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)getHotStartParamCommand:(void(^_Nullable)(int errorCode,IDOGetHotStartParamBluetoothModel * _Nullable data))callback;

/**
 * @brief  获取GPS状态 | Get GPS status
 
 * @param callback 执行后回调 data (IDOGetGpsStatusBluetoothModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Post-execution callback data (IDOGetGpsStatusBluetoothModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)getGpsStatusCommand:(void(^_Nullable)(int errorCode,IDOGetGpsStatusBluetoothModel * _Nullable data))callback;

/**
 * @brief  获取版本信息 | Get version information
 
 * @param callback 执行后回调 data (IDOGetVersionInfoBluetoothModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Post-execution callback data (IDOGetVersionInfoBluetoothModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)getVersionInfoCommand:(void(^_Nullable)(int errorCode,IDOGetVersionInfoBluetoothModel * _Nullable data))callback;

#pragma mark ======= listen Command =======

/**
 * @brief 音乐开始 | Music begins
 
 * @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Listening callback (errorCode : 0 is successful, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)listenMusicStartCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 音乐暂停 | Music pause
 
 * @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Listening callback (errorCode : 0 is successful, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)listenMusicPauseCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 音乐结束 | End of music
 
 * @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)| Listening callback (errorCode : 0 is successful, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)listenMusicStopCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 音乐上一首 | Music on the first
 
 * @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Listening callback (errorCode : 0 is successful, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)listenMusicLastCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 音乐下一首 | Music next
 
 * @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Listening callback (errorCode : 0 is successful, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)listenMusicNextCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 单次拍照 | Single photo
 
 * @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Listening callback (errorCode : 0 is successful, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)listenPhotoSingleShotCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 连续拍照 | Taking photos continuously
 
 * @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Listening callback (errorCode : 0 is successful, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)listenPhotoBurstCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 拍照开始 | Take a photo
 
 * @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Listening callback (errorCode : 0 is successful, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)listenPhotoStartCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 拍照结束 | End of photo
 
 * @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Listening callback (errorCode : 0 is successful, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)listenPhotoEndCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 音量+ | Volume +
 
 * @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Listening callback (errorCode : 0 is successful, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)listenVolumeUpCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 音量- | Volume -
 
 * @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Listening callback (errorCode : 0 is successful, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)listenVolumeDownCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 寻找手机开始 | Looking for a mobile phone to start
 
 * @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Listening callback (errorCode : 0 is successful, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)listenFindPhoneStartCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 寻找手机结束 | Looking for the end of the phone
 
 * @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Listening callback (errorCode : 0 is successful, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)listenFindPhoneStopCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 防丢启动 | Anti-lost start
 
 * @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Listening callback (errorCode : 0 is successful, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)listenLostStartCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 防丢结束 | Anti-lost end
 
 * @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Listening callback (errorCode : 0 is successful, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)listenLostStopCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 一键求救 | One button for help
 
 * @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Listening callback (errorCode : 0 is successful, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)listenSosStartCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 闹钟同步完成 | Alarm clock synchronization completed
 
 * @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Listening callback (errorCode : 0 is successful, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)listenAlarmSyncCompleteCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 配置同步完成 | Configure synchronization completion
 
 * @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Listening callback (errorCode : 0 is successful, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)listenConfigSyncCompleteCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 健康同步完成 | Health sync completed
 
 * @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Listening callback (errorCode : 0 is successful, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)listenHealthSyncCompleteCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 数据传输完成 | Data transfer completed
 
 * @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Listening callback (errorCode : 0 is successful, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)listenDataTranCompleteCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 配置快速同步完成 | Configuring Fast Sync Complete
 
 *  @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Listening callback (errorCode : 0 is successful, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)listenConfigFastSyncCompleteCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief GPS数据同步完成 | GPS data synchronization completed
 
 * @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Listening callback (errorCode : 0 is successful, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)listenGpsSyncCompleteCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 活动数据同步完成 | Activity data synchronization completed
 
 * @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Listening callback (errorCode : 0 is successful, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)listenActivitySyncCompleteCommand:(void(^_Nullable)(int errorCode))callback;

#pragma mark ======= progress Command =======

/**
 * @brief 健康数据同步进度 | Health data synchronization progress
 
 * @param callback 健康数据同步进度回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Health data synchronization progress callback (errorCode : 0 transmission success, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)healthSyncProgressCommand:(void(^_Nullable)(int progress,int errorCode))callback;

/**
 * @brief 闹钟数据同步进度 | Alarm data synchronization progress
 
 * @param callback 闹钟数据同步进度回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Alarm data synchronization progress callback (errorCode : 0 transmission success, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)alarmSyncProgressCommand:(void(^_Nullable)(int progress,int errorCode))callback;

/**
 * @brief 活动数据同步进度 | Activity data synchronization progress
 
 * @param callback 活动数据同步进度回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Activity data synchronization progress callback (errorCode : 0 transmission success, other values are errors, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)activitySyncProgressCommand:(void(^_Nullable)(int progress,int errorCode))callback;

/**
 * @brief 数据交换进度 手环->app | Data Exchange Progress Bracelet -> app
 
 * @param callback 数据交换进度回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Data exchange progress callback (errorCode: 0 transmission succeeded, other values are errors, error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)dataTranProgressCommand:(void(^_Nullable)(int progress,int errorCode))callback;

/**
 * @brief gps数据同步进度 | gps data synchronization progress
 
 @param callback  gps数据同步进度回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | gps data synchronization progress callback (errorCode: 0 transmission success, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)gpsProgressCommand:(void(^_Nullable)(int progress,int errorCode))callback;

/**
 * @brief 数据交换进度 app->手环 | Data Exchange Progress app->Bracelet
 * @param callback  数据交换进度回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Data exchange progress callback (errorCode: 0 transmission succeeded, other values are errors, error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)appDataTranProgressCommand:(void(^_Nullable)(int progress,int errorCode))callback;

/**
 * @brief  配置同步进度 | Configure synchronization progress
 
 * @param callback 配置同步进度回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Configure synchronization progress callback (errorCode : 0 transmission succeeded, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)configSyncProgressCommand:(void(^_Nullable)(int progress,int errorCode))callback;

#pragma mark ======= data exchange Command =======

/**
 * @brief app 发起运动开始 | app starts the campaign

 * @param model IDODataExchangeModel (数据交换model, day|hour|minute|second|sportType|targetType|targetValue|forceStart 这些属性需要赋值) | IDODataExchangeModel (data exchange model, day|hour|minute|second|sportType|targetType|targetValue|forceStart These attributes need to be assigned)
 * @param startCallback 运动发起回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Motion initiated callback (errorCode : 0 transmission succeeded, other values are errors, error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)appStartSportCommand:(IDODataExchangeModel * _Nullable)model
               startCallback:(void (^_Nullable)(IDODataExchangeModel * _Nullable model,int errorCode))startCallback;

/**
 * @brief app 发起运动结束 | app initiates the end of the campaign

 * @param model IDODataExchangeModel 活动时间需要保持一致,才能停止活动不然无效,当前model对象为全局时,只要开始活动记录开始时间,
 结束时不需要再次给时间赋值,只需要给 durations|calories|distance|sportType|isSave 这些属性需要赋值
 ---------------------------------------------->>>>>-------------------------------------------------------
 IDODataExchangeModel activity time needs to be consistent in order to stop the activity or it will be invalid. When the current model object is global, just start the activity record start time.
                You don't need to assign values to the time at the end, just give durations|calories|distance|sportType|isSave these properties need to be assigned
 
 * @param appEndCallback 运动停止回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Motion stop callback (errorCode : 0 transfer succeeded, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)appEndSportCommand:(IDODataExchangeModel *_Nullable)model
            appEndcallback:(void (^_Nullable)(IDODataExchangeModel *  _Nullable model,int errorCode))appEndCallback;

/**
 * @brief app发起的运动 手环主动结束 | App-initiated sports bracelet ends actively
 
 * @param model IDODataExchangeModel 手环主动发起结束 APP需要给手环发送运动数据, durations|calories|distance|errorCode 这些属性需要赋值 | IDODataExchangeModel The bracelet is actively launched. The APP needs to send motion data to the bracelet. durations|calories|distance|errorCode These attributes need to be assigned.
 * @param appBleEndCallback 手环发起停止回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | The bracelet initiates a stop callback (errorCode: 0 is successfully transmitted, other values are incorrect, and error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)appBleEndReplyCommand:(IDODataExchangeModel *_Nullable)model
            appBleEndCallback:(void (^_Nullable)(IDODataExchangeModel *  _Nullable model,int errorCode))appBleEndCallback;


/**
 * @brief app发起运动暂停 | app initiates a motion pause

 * @param model IDODataExchangeModel 活动时间需要保持一致,才能暂停活动不然无效,当前model对象为全局时,
              只要开始活动记录开始时间,暂停时不需要再次给时间赋值,直接传入当前model | IDODataExchangeModel activity time needs to be consistent in order to pause activity or not, when the current model object is global,  As soon as you start the activity record start time, you don't need to assign time to the timeout when you pause, you can directly pass in the current model.
 * @param pauseCallback 运动暂停回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Motion pause callback (errorCode : 0 transmission success, other values are errors, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)appPauseSportCommand:(IDODataExchangeModel *_Nullable)model
               pauseCallback:(void (^_Nullable)(IDODataExchangeModel *  _Nullable model,int errorCode))pauseCallback;



/**
 * @brief app发起的运动 手环主动暂停 | App-initiated sports bracelet active suspension
 
 * @param model IDODataExchangeModel 手环主动发起暂停 APP需要给手环发送运动数据, errorCode 这个属性需要赋值 | IDODataExchangeModel The bracelet initiates a pause. The APP needs to send motion data to the bracelet. The errorCode attribute needs to be assigned.
 * @param appBlePauseCallback 手环发起暂停回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | The bracelet initiates a pause callback (errorCode: 0 is successfully transmitted, other values are errors, and error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)appBlePauseReplyCommand:(IDODataExchangeModel *_Nullable)model
            appBlePauseCallback:(void (^_Nullable)(IDODataExchangeModel *  _Nullable model,int errorCode))appBlePauseCallback;


/**
 * @brief app 发起运动恢复 | app initiates motion recovery

 * @param model IDODataExchangeModel 活动时间需要保持一致,才能恢复活动不然无效,当前model对象为全局时,只要开始活动记录开始时间,恢复时不需要再次给时间赋值,直接传入当前model | IDODataExchangeModel activity time needs to be consistent in order to restore activity or not, when the current model object is global,As soon as you start the activity record start time, you don't need to assign time to the time when restoring, you can directly pass in the current model.
 * @param appRestoreCallback 运动恢复回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Motion recovery callback (errorCode : 0 transmission succeeded, other values are wrong, error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)appRestoreSportCommand:(IDODataExchangeModel * _Nullable)model
            appRestoreCallback:(void (^_Nullable)(IDODataExchangeModel *  _Nullable model,int errorCode))appRestoreCallback;

/**
 * @brief app发起的运动 手环主动恢复 | app-initiated sports bracelet active recovery
 
 * @param model IDODataExchangeModel 手环主动发起恢复 APP需要给手环发送运动数据, errorCode 这个属性需要赋值 | IDODataExchangeModel The bracelet initiates recovery. The APP needs to send motion data to the bracelet. The errorCode attribute needs to be assigned.
 * @param appBleRestoreCallback 手环发起恢复回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | The bracelet initiates a recovery callback (errorCode : 0 is successfully transmitted, other values are incorrect, and error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)appBleRestoreReplyCommand:(IDODataExchangeModel *_Nullable)model
            appBleRestoreCallback:(void (^_Nullable)(IDODataExchangeModel *  _Nullable model,int errorCode))appBleRestoreCallback;

/**
 * @brief app发起数据交换过程 | app initiates the data exchange process

 * @param model IDODataExchangeModel 活动时间需要保持一致,才能发送活动数据不然无效,当前model对象为全局时,只要开始活动记录开始时间,发送活动数据时不需要再次给时间赋值,只需要给 status|duration|calories|distance 这些属性需要赋值 | IDODataExchangeModel Activity time needs to be consistent in order to send active data or it is invalid. When the current model object is global, as long as the activity record start time is started, it is not necessary to assign time to the event when sending the activity data, just to status|duration|calories|distance These attributes need to be assigned
 * @param appIngCallback 运动发送数据回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | Motion sends data callback (errorCode : 0 transmission succeeded, other values are errors, error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)appIngSportCommand:(IDODataExchangeModel *_Nullable)model
            appIngCallback:(void (^_Nullable)(IDODataExchangeModel * _Nullable model,int errorCode))appIngCallback;

/**
 * @brief 手环发起运动开始 | The bracelet starts the campaign
 
 * @param model IDODataExchangeModel 只需要给 retCode 这个属性需要赋值 | IDODataExchangeModel only needs to assign value to retCode property
 * @param bleStartCallback 手环发起运动开始回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | The bracelet initiates a motion start callback (errorCode : 0 is successfully transmitted, other values are wrong, and error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)bleStartSportCommand:(IDODataExchangeModel *_Nullable)model
            bleStartCallback:(void (^_Nullable)(IDODataExchangeModel * _Nullable model,int errorCode))bleStartCallback;

/**
 * @brief 手环发起运动暂停 | The bracelet initiates a motion pause
 
 * @param model IDODataExchangeModel 只需要给 retCode 这个属性需要赋值 | IDODataExchangeModel only needs to assign value to retCode property
 * @param blePauseCallback 手环发起运动暂停回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | The bracelet initiates a motion pause callback (errorCode : 0 is successfully transmitted, other values are incorrect, and error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)blePauseSportCommand:(IDODataExchangeModel *_Nullable)model
            blePauseCallback:(void (^_Nullable)(IDODataExchangeModel * _Nullable model,int errorCode))blePauseCallback;

/**
 * @brief 手环发起运动恢复 | Bracelet initiates sports recovery

 * @param model IDODataExchangeModel 只需要给 retCode 这个属性需要赋值 | IDODataExchangeModel only needs to assign value to retCode property
 * @param bleRestoreCallback 手环发起运动恢复回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | The bracelet initiates a motion recovery callback (errorCode : 0 is successfully transmitted, other values are wrong, and error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)bleRestoreSportCommand:(IDODataExchangeModel *_Nullable)model
            bleRestoreCallback:(void (^_Nullable)(IDODataExchangeModel * _Nullable model,int errorCode))bleRestoreCallback;

/**
 * @brief 手环发起运动结束 | The bracelet starts the campaign

 * @param model IDODataExchangeModel 只需要给 retCode 这个属性需要赋值 | IDODataExchangeModel only needs to assign value to retCode property
 * @param bleEndCallback 手环发起运动结束回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) | The bracelet initiates a motion end callback (errorCode : 0 is successfully transmitted, other values are errors, and error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)bleEndSportCommand:(IDODataExchangeModel *_Nullable)model
            bleEndCallback:(void (^_Nullable)(IDODataExchangeModel * _Nullable model,int errorCode))bleEndCallback;

/**
 * @brief 手环发起运动发送数据 | The bracelet initiates a motion to send data
 * @param model IDODataExchangeModel 只需要给 distance 这个属性需要赋值
 * @param bleIngCallback 手环发起运动发送数据 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)bleIngSportCommand:(IDODataExchangeModel *_Nullable)model
            bleIngCallback:(void (^_Nullable)(IDODataExchangeModel * _Nullable model,int errorCode))bleIngCallback;

@end
