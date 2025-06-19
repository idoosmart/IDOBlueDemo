//
//  IDOAllOrder.h
//  VeryfitSDK
//
//  Created by hedongyang on 2018/6/12.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#if __has_include(<IDOBlueProtocol/IDOBlueProtocol.h>)
#else
#import "IDOBindEnum.h"
#import "IDOBluetoothBaseModel.h"
#import "IDOGetInfoBluetoothModel.h"
#import "IDOSetInfoBluetoothModel.h"
#import "IDODataExchangeModel.h"
#endif

@interface IDOFoundationCommand : NSObject

#pragma mark ======= control Command =======
/**
 * @brief 初始化第三方应用的消息通知状态
 */
+ (void)initMessageNoticeStateCommand:(IDOSetV3NotifyStateModel *_Nullable)notifyStateModel;
/**
 设备进入ota模式通知 |  Notification of device enter ota mode
 */
+ (void)didOta;

/**
 设备退出ota模式通知 |  Notification of device exit ota mode
 */
+ (void)disOta;

/**
 设备进入泰凌微ota模式
 */
+ (void)tlwOta;

/**
 协议库强制解绑状态 | mandatory unbind device
 */
+ (void)mandatoryUnbind;

/**
 断开发送通知 | Disconnect notification
 */
+ (void)disConnect;

/**
 * 连接失败通知 | connection failed
 */
+ (void)connectionFailed;

/**
 *检测加密授权码 ｜ detection encrypted auth code
 */
+ (void)detectionEncryptedCode;

/**
 启动bt设备广播
 */
+ (BOOL)openBtDeviceBroadcast;

/**
 * 删除手环日志 ｜ clear device log
 * type: 0x01 : 删除过热日志  0x02：电池日志  0x03：重启日志； 04：异常
 * state: 0x00成功, 0x01失败
 */
+ (void)clearLogCommandWithType:(int)type
                       callback:(void(^_Nullable)(int errorCode,int state))callback;

/**
 * 发送自定义数据
 */
+ (void)sendCustomDataInformation:(NSData*_Nullable)data;

/**
 * @brief 发送自定义数据
 * @param dataType 类型
 * @param value 数值
 */
+ (void)sendCustomDataInfoType:(IDO_CUSTOMDATA_TYPE)dataType dataValue:(int)value;

/**
 * 发送提示消息 （只用于DH项目中） | Send prompt message （used only for DH）
 */
+ (void)sendPromptInformation:(NSString*_Nullable)info;

/**
 * @brief 音乐开始 | Music begins
 * @param callback 执行后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Post-execution callback (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)musicStartCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 音乐结束 | End of music
 * @param callback 执行后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Post-execution callback (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)musicStopCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 相机开始 | Camera starts
 * @param callback 执行后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Post-execution callback (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)cameraStartCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 相机结束 | Camera ends
 * @param callback 执行后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Post-execution callback (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)cameraStopCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 开始寻找设备 | Start looking for equipment
 * @param callback 执行后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Post-execution callback (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)findDeviceStartCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 结束寻找设备 | End finding equipment
 * @param callback 执行后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Post-execution callback (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)findDeviceStopCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 结束寻找手机 | End finding phone
 * @param callback 执行后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Post-execution callback (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)findPhoneStopCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 打开ANCS(苹果通知中心) | Open ANCS (Apple Notification Center)
 * @param callback 执行后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Post-execution callback (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)belOpenAncsCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 关闭ANCS(苹果通知中心) | Close ANCS (Apple Notification Center)
 * @param callback 执行后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Post-execution callback (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)belCloseAncsCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 设备绑定 | Device Binding
 * @param bindModel 绑定 model (IDOSetBindingInfoBluetoothModel) (只有在授权绑定才会存储数据)
 * Binding model (IDOSetBindingInfoBluetoothModel) (Data will only be stored if the binding is authorized)
 * @param waitForSure 执行加密授权绑定开始等待确定回调
 * @param callback 执行后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Post-execution callback (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)bindingCommand:(IDOSetBindingInfoBluetoothModel * _Nullable)bindModel
           waitForSure:(void (^_Nullable)(void))waitForSure
              callback:(void (^_Nullable)(IDO_BIND_STATUS status, int errorCode))callback;

/**
 * @brief 在断链的情况下解绑对应设备, 只改变本地对应设备信息状态，不影响当前绑定连接的设备
 * disconnect  unbind correspond deivce,It only changes the information state of the local corresponding device,
 * and does not affect the device connected by the current binding
 * @param macAddr 设备Mac地址 ｜ device mac address
 * @return YES or NO
 */
+ (BOOL)unbindCorrespondDeviceWithMacAddr:(NSString *_Nullable)macAddr;

/**
 * @brief 在断链的情况下解绑所有设备
 * disconnect unbind all devices
 * @return YES or NO
 */
+ (BOOL)disConnectUnbindAllDevices;

/**
 * @brief 在断链的情况下，解除当前设备的绑定。这种方法只适合绑定一个设备，而不适合同时绑定多个设备
 * In the case of broken chain, unbind the current device. This method is suitable for binding only one device,
 * but not for binding multiple devices at the same time
 * @return YES or NO
 */
+ (BOOL)disConnectUnbindCurrentDevice;

/**
 * @brief 切换设备,但不删除手环和app数据 | switch device not delete the bracelet and app data
 * @param macAddr 需要切换的设备mac 地址 | mac address
 * @param mandatory 如果发现切换的设备不管是解绑状态还是绑定状态，都可以选择强制执行切换
 * If you find that the switched device is either unbound or bound, you can choose to force the switch
 * @param callback 执行后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Post-execution callback (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)switchDeviceCommand:(NSString *_Nullable)macAddr
                isMandatory:(BOOL)mandatory
                   callback:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 设置当前设备为主账号的或者子账号的设备
 * Set the current device as the device of the primary account
 * @param macAddr 设备mac 地址 | mac address
 * @param isMaster 是否主账号设备
 * @return YES or NO
 */
+ (BOOL)setCurrentMasterDeviceWithMacAddr:(NSString *_Nullable)macAddr
                           isMasterDevice:(BOOL)isMaster;

/**
 * @brief 切换设备后重连成功检测加密授权状态,只适合加密授权使用
 * After switching devices, reconnecting successfully detects the status of encryption authorization, which is only suitable for the use of encryption authorization
 * @param callback 执行后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Post-execution callback (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
*/
+ (void)switchDeviceDetectionEncryptionAuthCallback:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 普通非鉴权设备切换完成后执行
 * Execute after the switching of ordinary non-authentication equipment is completed
 */
+ (void)swithOrdinaryDeviceComplete;

/**
 * @brief 设备强制解绑,设备连接时,双方解绑,设备断开时,app单方解绑 | Device forced unbundling
 * @param callback 执行后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Post-execution callback (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)mandatoryUnbindingCommand:(void(^_Nullable)(int errorCode,NSString * _Nullable undindMacAddr))callback;

/**
 * @brief 设备强制解绑,设备连接时,双方解绑,设备断开时,app单方解绑 | Device forced unbundling
 * @param nextMacAddr 解绑当前设备后需要重连的设备Mac地址
 * @param callback 执行后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Post-execution callback (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)ido_mandatoryUnbindDevice:(NSString *_Nullable)nextMacAddr
                         callback:(void(^_Nullable)(int errorCode,NSString * _Nullable undindMacAddr))callback;

/**
 * @brief 设备配置复位 | Device Configuration Reset
 * @param callback 执行后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Post-execution callback (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)setDefaultConfigCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 控制设备重启(重启设备后手环会马上断线) | Control device restart （The bracelet disconnects immediately after restarting the device）
 * @param model | reboot model
 * @param callback 执行后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Post-execution callback (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 * state 0x00:重启成功 0x02: 失败：设备不支持  | 0x00: success; 0x02: Failed: device does not support
 */
+ (void)setAppRebootCommand:(IDOSetRebootModel*_Nullable)model
                   callback:(void(^_Nullable)(int state, int errorCode))callback;

/**
 * @brief 控制设备恢复出厂设置  | Control device restore factory
 * @param callback 执行后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Post-execution callback (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
*/
+ (void)setRestoreFactoryCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 获取扩展功能列表 | Get the list of extended features
 * @param callback 执行回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Execute callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)getFuncTableExCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 设备进入ota升级模式 | The device enters the ota upgrade mode.
 * @param callback 执行回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Execute callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 * state 0x00 : 成功；0x01 ：电量过低；0x02 ：设备不支持；0x03 ：参数不正确 | 0x00: success; 0x01: low power; 0x02: device not supported; 0x03: parameter error
 */
+ (void)setOtaCommand:(void(^_Nullable)(int state , int errorCode))callback;

/**
 * @brief 手环检查版本号 | The bracelet checks the version number.
 * @param model | check update version numbder model
 * @param callback 执行回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Execute callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 * state 0x00 : 请求成功；0x01 ：发生失败；
 * state 0x00: success; 0x01: failed;
 */
+ (void)checkUpdateReplyCommand:(IDOCheckUpdateBluetoothModel *_Nullable)model
                       callback:(void(^_Nullable)(int state , int errorCode))callback;

#pragma mark ======= voice control Command =======

/**
 * @brief 语音控制开启指定活动 | Voice control turns on the specified activity
 * @param sportType 运动类型 | sport type
 * 0:跳转运动界面列表，1:户外跑步，2:室内跑步，3:户外走路，4:室内走路，5:徒步，6:户外骑行，7:室内骑行，8:板球，
 * 9:泳池游泳，10:开放水域游泳，11:瑜伽，12:划船机，13:椭圆机，14:其他运动
 * 0: Jump Sports Interface List, 1: Outdoor Running, 2: Indoor Running, 3: Outdoor Walking, 4: Indoor Walking, 5: Hiking,
 * 6: Outdoor Riding, 7: Indoor Riding, 8: Cricket,9: pool swimming, 10: open water swimming, 11: yoga, 12: rowing machine,
 * 13: elliptical machine, 14: other sports
 * @param callback 执行回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Execute callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
*/
+ (void)voiceControlActivityWithType:(NSInteger)sportType
                            callback:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 语音控制开启指定100种新增运动 | Voice control turns on the new 100 activity
 * @param v2sportType 运动类型 | v2 sport type
 * （100种新增运动类型）eg:仰卧起坐 = 0x0D俯卧撑 = 0x0E 哑铃 = 0x0F 有氧健身操 = 0x11 跳绳 = 0x13 普拉提 = 0x20 ...
 * @param callback 执行回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Execute callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
*/
+ (void)voiceControlV2ActivityWithType:(NSInteger)v2sportType
                              callback:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 语音控制开启实时心率 | Voice control open real time heart rate
 * @param isOpen 是否开启 | is open
 * @param callback 执行回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Execute callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
*/
+ (void)voiceControlRealTimeHrWithSwitch:(BOOL)isOpen
                                callback:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 语音控制勿扰模式 | Voice control no disturb
 * @param callback 执行回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Execute callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
*/
+ (void)voiceControlNoDisturbWithSwitch:(BOOL)isOpen
                               callback:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 语音控制抬腕亮屏 | Voice control wrist bright screen
 * @param callback 执行回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Execute callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
*/
+ (void)voiceControlWristBrightScreenWithSwitch:(BOOL)isOpen
                                       callback:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 语音控制音乐 | Voice control music
 * 1  => 上一曲  2  => 下一曲 3  => 增加音量  4  => 减少音量 5  => 播放音乐 6 =>暂停音乐
 * 1 => previous 2 => next 3 => increase volume 4 => decrease volume 5 => play music 6 => pause music
 * @param callback 执行回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Execute callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
*/
+ (void)voiceControlMusicWithType:(NSInteger)controlType
                         callback:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 语音控制设置屏幕亮度 | Voice control set bright screen
 * @param brightLevel 屏幕亮度 0-100 | bright level 0-100
 * @param callback 执行回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Execute callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
*/
+ (void)voiceControlBrightScreenWithLevel:(NSInteger)brightLevel
                                 callback:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 语音控制跳转秒表界面 | Voice control jump stop watch interface
 * @param delayTime 延时 | delay time
 * @param index 最多支持3个秒表 秒钟索引 0、1、2
 * @param operate  0:增加  1:删除秒表  2:取消所有的秒表
 * @param callback 执行回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Execute callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
*/
+ (void)voiceControlToStopWatchDelay:(NSInteger)delayTime
                               index:(NSInteger)index
                             operate:(NSInteger)operate
                            callback:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 语音控制跳转倒计时界面 | Voice control jump count down interface
 * @param totalTime 总时长 | total time
 * @param callback 执行回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Execute callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
*/
+ (void)voiceControlToCountDownTotalTime:(NSInteger)totalTime
                                callback:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 语音控制跳转心率检测界面 | Voice control jump heart rate interface
 * @param callback 执行回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Execute callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
*/
+ (void)voiceControlToHeartRateCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 语音控制跳转压力检测界面 | Voice control jump pressure interface
 * @param callback 执行回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Execute callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
*/
+ (void)voiceControlToPressureCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 语音控制跳转呼吸训练界面 | Voice control jump breathing training interface
 * @param callback 执行回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Execute callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
*/
+ (void)voiceControlToBreathingCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 语音控制跳转睡眠记录界面 | Voice control jump sleep record interface
 * @param callback 执行回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Execute callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
*/
+ (void)voiceControlToSleepRecordCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 语音控制跳转运动记录界面 | Voice control jump sport record interface
 * @param callback 执行回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Execute callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
*/
+ (void)voiceControlToSportRecordCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 语音控制跳转天气界面 | Voice control jump weather interface
 * @param callback 执行回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Execute callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
*/
+ (void)voiceControlToWeatherCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 语音控制寻找手机 | Voice control find phone
 * @param callback 执行回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Execute callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
*/
+ (void)voiceControlToFindPhoneCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 语音控制灭屏 | Voice control black screen
 * @param callback 执行回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Execute callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
*/
+ (void)voiceControlToBlackScreenCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 语音控制跳转重启界面 | Voice control jump reboot interface
 * @param callback 执行回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Execute callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
*/
+ (void)voiceControlToRebootCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 语音控制跳转信息界面 | Voice control jump message interface
 * @param callback 执行回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Execute callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
*/
+ (void)voiceControlToNotifyCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 语音控制跳转UI 界面 | Voice control jump UI interface
 * @param type  UI跳转类型
 * 0:健康数据页,1:睡眠页面,2:心率检测,3:压力检测,4:血氧检测,5:打开帮助二维码界面,6:音乐控制,7:转至消息列表,8:查找手机
 * 9:运动记录页面,10:呼吸页面,11:设置页面,12:手电筒,13:查看所有已设置的闹钟,14:打开亮度设置界面,15:打开消息详情
 * 0: health data page,1: sleep page,2: heart rate detection,3: stress detection,4: blood oxygen detection,5: open the QR code interface,
 * 6: music control,7: go to the message list,8: search for mobile phone
 * 9: Motion record page,10: Breathing page,11: Setting page,12: Flashlight,13: View all the alarm clocks that have been set,
 * 14: Open the brightness setting interface,15: Open the message details
 * @param callback 执行回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Execute callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)voiceControlUiJumpWithType:(NSInteger)type
                          callback:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 简单的控制命令 | Voice control jump alarm interface
 * @param uiType  UI类型 1:亮度控制 2:勿扰控制 3:抬腕亮屏 | UI Type 1: Brightness Control 2: Do Not Disturb Control
 * @param operationType
 * 亮度控制: 0:亮度控制界面 亮度++ 1:亮度控制界面 亮度-- 2:亮度调节最大 3:亮度调节最小 4:亮度等级
 *        6:亮度控制界面 亮度++（增加10%亮度）7:亮度控制界面 亮度--（减少10%亮度）8:新增设置具体的亮度等级（百分比）
 * 勿扰控制: 0:勿扰控制开启 1:勿扰控制关闭
 * 抬腕亮屏控制: 0:抬腕亮屏开启 1:抬腕亮屏关闭
 * @param cmdNumber  0:无效设置
 * 亮度控制: 1-5或者1-3,根据功能表是3级的还是5级的,operationType == 8,亮度等级（百分比）1-100
 * Brightness control: 0: brightness control interface brightness ++ 1: brightness control interface brightness --
 * 2: brightness adjustment maximum 3: brightness adjustment minimum 4:brightness level
 * Do not disturb control : 0: Do not disturb control on 1: Do not disturb control off
 * @param callback 执行回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Execute callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
*/
+ (void)voiceControlUiType:(NSInteger)uiType
             operationType:(NSInteger)operationType
                 cmdNumber:(NSInteger)cmdNumber
                  callback:(void(^_Nullable)(int errorCode))callback;
/**
 * @brief 语音控制设置天气 | Voice control set weather data
 * @param weatherModel 天气 model (IDOSetAlexaWeatherDataModel) | weather model (IDOSetAlexaWeatherDataModel)
 * @param callback 执行回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Execute callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
*/
+ (void)voiceControlWeatherData:(IDOSetAlexaWeatherDataModel *_Nullable)weatherModel
                       callback:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 语音控制跳转闹钟界面 | Voice control jump alarm interface
 * @param alarmModel 闹钟 model (IDOSetVoiceV3AlarmInfoModel) | alarm model (IDOSetVoiceV3AlarmInfoModel)
 * @param callback 执行回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Execute callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
*/
+ (void)voiceControlToAlarm:(IDOSetVoiceV3AlarmInfoModel *_Nonnull)alarmModel
                   callback:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 语音控制设置提醒 | Voice control set reminder
 * @param reminderModels reminder model (IDOSetVoiceReminderItemModel) | reminder model (IDOSetVoiceReminderItemModel)
 * @param callback 执行回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Execute callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
*/
+ (void)voiceControlToReminder:(NSArray <IDOSetVoiceReminderItemModel *>*_Nullable)reminderModels
                      callback:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 回复语音识别失败状态 | Reply to speech recognition failure status
 * @param state  0：正常状态;  1：无法识别;  2：语音识别超时
 * 0: Normal state; 1: Unable to identify; 2: Speech recognition timeout
 * @param callback 执行回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Execute callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)voiceRecognitionFailedCommand:(NSInteger)state
                             callback:(void(^_Nullable)(int errorCode))callback;
/**
 * @brief 回复语音识别成功文字 | Reply speech recognition successful text
 * @param message | 内容 暂时只支持英文
 * @param titleText | 内容标题 (暂时不需要)
 * @param flagContinue |  是否继续语音
 * @param callback 执行回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Execute callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)voiceRecognitionSuccessCommand:(NSString *_Nullable)message
                             titleText:(NSString *_Nullable)titleText
                          flagContinue:(BOOL)flagContinue
                              callback:(void(^_Nullable)(int errorCode))callback;
/**
 * @brief 语音控制运动类型开关
 * @param isOn  是否开启
 * @param type  UI跳转类型
 *  0   sport/exercise(跳到运动列表) 1    Outdoor Run（户外跑步）2    Indoor run（室内跑步）3   Outdoor walk（户外步行）4   Indoor walk（室内步行）
 * 5   Hiking（徒步）6    Outdoor cycle（户外骑行）7   Indoor cycle（室内骑行） 8    Cricket（板球）9  Pool Swim（泳池游泳）10   Open water swim（开放式游泳）
 * 11   Yoga（瑜伽） 12   Rower（划船机）13   Elliptical（椭圆机）14   workout（健身 ）15   sleep/slept(睡眠页面) 16   stress/pressure(压力检测)
 * 17  help(打开帮助二维码界面) 18  find phone (查找手机) 19   breath training/relax（呼吸页面） 20   settings/Options（设置）21   flashlight（手电筒）
 * 22   display  setting/brightness（亮度设置）23   message/text  notifications(消息详情) 241 stopwatch(秒表) 242 event reminder(事项提醒)
 * 243 phone(打开电话) 244 noise measurement(噪音测量) 245 skin temperature(皮肤温度)
 * @param callback 执行回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Execute callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)voiceSetOnOff:(BOOL)isOn
          commandType:(NSInteger)type
             callback:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 语音停止传输
 * voice file tran stop
 */
+ (void)voiceFileTranStop;

#pragma mark ======= set Command =======

/**
 * @brief  设置授权码绑定 | Set Authorization Code Binding
 * @param bindModel 绑定 model (IDOSetBindingInfoBluetoothModel) | binding model
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setAuthCodeCommand:(IDOSetBindingInfoBluetoothModel * _Nullable)bindModel
                  callback:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 设置当前时间 | Set current time
 * @param timeModel 时间 model (IDOSetTimeInfoBluetoothModel) | time model (IDOSetTimeInfoBluetoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setCurrentTimeCommand:(IDOSetTimeInfoBluetoothModel * _Nullable)timeModel
                     callback:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 设置闹钟 | Set an alarm
 * @param alarmModel 闹钟 model (IDOSetAlarmInfoBluetoothModel) | Alarm clock model (IDOSetAlarmInfoBluetoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setAlarmCommand:(IDOSetAlarmInfoBluetoothModel * _Nullable)alarmModel
               callback:(void(^_Nullable)(int errorCode))callback DEPRECATED_MSG_ATTRIBUTE("method is deprecated");

/**
 * @brief 批量设置闹钟 | Set alarms in batches
 * @param alarmModels 闹钟集合 model (IDOSetAlarmInfoBluetoothModel) | Alarm clock collection model (IDOSetAlarmInfoBluetoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setAllAlarmsCommand:(NSArray <IDOSetAlarmInfoBluetoothModel *> * _Nullable)alarmModels
                   callback:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 设置v3闹钟 | Set v3 alarm
 * @param alarmModel v3闹钟 model (IDOSetExtensionAlarmInfoBluetoothModel) | v3 Alarm clock model (IDOSetExtensionAlarmInfoBluetoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
*/
+ (void)setV3AllAlarmsCommand:(IDOSetExtensionAlarmInfoBluetoothModel * _Nullable)alarmModel
                     callback:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 设置用户信息 | Setting user information
 * @param userModel 用户信息 model (IDOSetUserInfoBuletoothModel) | User Information model (IDOSetUserInfoBuletoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setUserInfoCommand:(IDOSetUserInfoBuletoothModel * _Nullable)userModel
                  callback:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 设置卡路里和距离目标 | Set calories and distance targets
 * @param userModel 用户信息 model (IDOSetUserInfoBuletoothModel) | User Information model (IDOSetUserInfoBuletoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setCalorieAndDistanceGoalCommand:(IDOSetUserInfoBuletoothModel * _Nullable)userModel
                                callback:(void (^ _Nullable)(int errorCode))callback;

/**
 * @brief 设置目标 | Setting goals

 * @param targetModel 目标信息 model (IDOSetUserInfoBuletoothModel) | targetModel target information model (IDOSetUserInfoBuletoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setTargetInfoCommand:(IDOSetUserInfoBuletoothModel * _Nullable)targetModel
                    callback:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 设置通知中心、来电提醒开关 ⚠️在配对过程中不要执行其他命令。如果设备没有配对，会发起配对，等配对成功后再执行设置子开关状态，需要配对耗时比较长请监听回调。
 * Set up notification center, call alert switch.⚠️Do not execute other commands during pairing.
 * If there is no pairing on the device, a pairing will be initiated, and the sub-switch state will be set after the pairing is successful.
 * If pairing takes a long time, please listen for the callback.
 * @param noticModel 通知开关信息 model (IDOSetNoticeInfoBuletoothModel)
 * Notification switch information model (IDOSetNoticeInfoBuletoothModel)
 * @param callback 设置后配对过程状态回调 stateCode:0x00为不明异常超时,0x01为系统配对成功,0x02为取消配对,isNeedDisconnect:是否需要断开重连,is need to disconnect and reconnect
 * stateCode :0x00 indicates an unknown abnormal timeout,0x01 indicates successful system pairing, and 0x02 indicates unpairing
 * @param complete 设置后完成配对回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setSwitchNoticeCommand:(IDOSetNoticeInfoBuletoothModel * _Nullable)noticModel
                      callback:(void (^_Nullable)(BOOL isNeedDisconnect,int stateCode))callback
                      complete:(void (^_Nullable)(int errorCode))complete;

/**
 * @brief 设置通知中心、来电提醒开关，此方法只设置子开关状态。
 * Set up notification center, call alert switch.method sets only the subswitch state
 * @param noticModel 通知开关信息 model (IDOSetNoticeInfoBuletoothModel)
 * Notification switch information model (IDOSetNoticeInfoBuletoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setChildSwitchNoticeStateCommand:(IDOSetNoticeInfoBuletoothModel * _Nullable)noticModel
                                callback:(void (^_Nullable)(int errorCode))callback DEPRECATED_MSG_ATTRIBUTE("Method deprecated");

/**
 * @brief 设置蓝牙配对 (不可重复设置,会引起无法再连接设备.只要配对成功,就不需要再设置,只有获取到系统配对设备被忽略,才可设置配对。⚠️在配对过程中不要执行其他命令。)
 * Set up Bluetooth pairing (cannot be set repeatedly, it will cause the device to be connected again. As long as the pairing is successful,
 * you don't need to set it again. Only when the system pairing device is ignored, the pairing can be set.⚠️Do not execute other commands during pairing.)
 * @param callback 设置后配对过程状态回调 stateCode:0x00为不明异常超时,0x01为系统配对成功,0x02为取消配对,isNeedDisconnect:是否需要断开重连,is need to disconnect and reconnect
 * stateCode :0x00 indicates an unknown abnormal timeout,0x01 indicates successful system pairing, and 0x02 indicates unpairing
 * @param complete 设置后完成配对回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setBluetoothPairingCommandWithCallback:(void (^_Nullable)(BOOL isNeedDisconnect,int stateCode))callback
                               pairingComplete:(void (^_Nullable)(int errorCode))complete DEPRECATED_MSG_ATTRIBUTE("Method deprecated");

/**
 * @brief 设置寻找手机 | Set looking for a mobile phone
 * @param findModel 寻找手机信息 model (IDOSetFindPhoneInfoBuletoothModel)
 * Find mobile information model (IDOSetFindPhoneInfoBuletoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setFindPhoneCommand:(IDOSetFindPhoneInfoBuletoothModel * _Nullable)findModel
                   callback:(void (^ _Nullable)(int errorCode))callback;

/**
 * @brief 设置抬腕 | Set the wrist
 * @param handUpmodel 抬腕信息 model (IDOSetHandUpInfoBuletoothModel)
 * Wrist information model (IDOSetHandUpInfoBuletoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setHandUpCommand:(IDOSetHandUpInfoBuletoothModel * _Nullable)handUpmodel
                callback:(void (^ _Nullable)(int errorCode))callback;

/**
 * @brief 设置左右手佩戴 | Set the left and right hand to wearfind
 * @param handModel 左右手佩戴 model (IDOSetLeftOrRightInfoBuletoothModel)
 * Left and right hand wearing model (IDOSetLeftOrRightInfoBuletoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setLeftRightHandCommand:(IDOSetLeftOrRightInfoBuletoothModel *_Nullable)handModel
                       callback:(void (^ _Nullable)(int errorCode))callback;

/**
 * @brief 设置音乐开关 | Set music switch
 * @param openMusicModel 音乐开关 model (IDOSetMusicOpenInfoBuletoothModel)
 * Music Switch model (IDOSetMusicOpenInfoBuletoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setOpenMusicCommand:(IDOSetMusicOpenInfoBuletoothModel * _Nullable)openMusicModel
                   callback:(void (^ _Nullable)(int errorCode))callback;

/**
 * @brief 设置预防丢失 | Set to prevent lost
 * @param lostModel 预防丢失 model (IDOSetPreventLostInfoBuletoothModel)
 * Prevent loss model (IDOSetPreventLostInfoBuletoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setPreventLostCommand:(IDOSetPreventLostInfoBuletoothModel * _Nullable)lostModel
                     callback:(void (^ _Nullable)(int errorCode))callback;

/**
 * @brief 设置显示模式 | Setting the display mode
 * @param displaModel 显示模式 model (IDOSetDisplayModeInfoBluetoothModel)
 * Display mode model (IDOSetDisplayModeInfoBluetoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setDisplayModeCommand:(IDOSetDisplayModeInfoBluetoothModel * _Nullable)displaModel
                     callback:(void (^ _Nullable)(int errorCode))callback;

/**
 * @brief 设置久坐 | Set sedentary
 * @param longSitModel 久坐 model (IDOSetLongSitInfoBuletoothModel)
 * Sedentary model (IDOSetLongSitInfoBuletoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setLongSitCommand:(IDOSetLongSitInfoBuletoothModel * _Nullable)longSitModel
                 callback:(void (^ _Nullable)(int errorCode))callback;

/**
 * @brief 设置天气预报开关 | Set the weather forecast switch
 * @param weatherModel 天气预报开关 model (IDOSetWeatherSwitchInfoBluetoothModel)
 * Weather Forecast Switch model (IDOSetWeatherSwitchInfoBluetoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setWeatherCommand:(IDOSetWeatherSwitchInfoBluetoothModel * _Nullable)weatherModel
                 callback:(void (^ _Nullable)(int errorCode))callback;

/**
 * @brief 设置心率模式 | Set heart rate mode
 * @param hrModeModel 心率模式 model (IDOSetHRModeInfoBluetoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setHrModeCommand:(IDOSetHrModeInfoBluetoothModel * _Nullable)hrModeModel
                callback:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 设置勿扰模式 | Set the anti-disturb mode
 * @param noDisturbModeModel 防打扰模式 model (IDOSetNoDisturbModeInfoBluetoothModel)
 * Anti-disturbance mode model (IDOSetNoDisturbModeInfoBluetoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setNoDisturbModeCommand:(IDOSetNoDisturbModeInfoBluetoothModel * _Nullable)noDisturbModeModel
                       callback:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 设置心率间隔 | Set heart rate interval
 * @param hrIntervalModel 心率间隔 model (IDOSetHrIntervalInfoBluetoothModel)
 * Heart Rate Interval model (IDOSetHrIntervalInfoBluetoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setHrIntervalCommand:(IDOSetHrIntervalInfoBluetoothModel * _Nullable)hrIntervalModel
                    callback:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 设置单位 | Setting unit
 * @param unitModel 单位 model (IDOSetUnitInfoBluetoothModel) | unit model (IDOSetUnitInfoBluetoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setUnitCommand:(IDOSetUnitInfoBluetoothModel * _Nullable)unitModel
              callback:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 设置一键呼叫 | Set up a one-click call
 * @param oneKeySOSModel 一键呼叫 model (IDOSetOneKeySosInfoBuletoothModel)
 * One-click calling model (IDOSetOneKeySosInfoBuletoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setOneKeySosCommand:(IDOSetOneKeySosInfoBuletoothModel * _Nullable)oneKeySOSModel
                   callback:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 设置快捷方式 | Setting shortcuts
 * @param shortcutModel 快捷方式 model (IDOSetShortcutInfoBluetoothModel) | Shortcut model (IDOSetShortcutInfoBluetoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setShortcutCommand:(IDOSetShortcutInfoBluetoothModel * _Nullable)shortcutModel
                  callback:(void(^_Nullable)(int errorCode))callback;


/**
 * @brief 设置血压舒张、收缩 | Set blood pressure to relax and contract
 * @param calModel 血压舒张、收缩 model (IDOSetBloodPressureInfoBluetoothModel)
 * Blood pressure diastolic, contraction model (IDOSetBloodPressureInfoBluetoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str ; model包含校准状态值)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setBpCalCommand:(IDOSetBloodPressureInfoBluetoothModel * _Nullable)calModel
               callback:(void(^_Nullable)(int errorCode,IDOSetBloodPressureInfoBluetoothModel * _Nullable model))callback;

/**
 * @brief 设置运动快捷方式 | Set motion shortcuts
 * @param sportSelectModel 运动快捷方式 model (IDOSetSportShortcutInfoBluetoothModel)
 * Sports shortcut model (IDOSetSportShortcutInfoBluetoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setSportModeSelectCommand:(IDOSetSportShortcutInfoBluetoothModel * _Nullable)sportSelectModel
                         callback:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 设置运动模式排序 | Set motion shortcuts
 * @param sportSortModel 运动模式排序 model (IDOSetSportSortingInfoBluetoothModel)
 * sport mode sort Model (IDOSetSportSortingInfoBluetoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setSportModeSortCommand:(IDOSetSportSortingInfoBluetoothModel * _Nullable)sportSortModel
                       callback:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 设置天气预报数据 | Set weather forecast data
 * @param weatherDataModel 天气预报数据 model (IDOSetWeatherDataInfoBluetoothModel)
 * Weather Forecast Data model (IDOSetWeatherDataInfoBluetoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setWeatherDataCommand:(IDOSetWeatherDataInfoBluetoothModel *_Nullable)weatherDataModel
                     callback:(void (^ _Nullable)(int errorCode))callback;

/**
 * @brief 设置天气城市名称 | Set weather city name
 * @param weatherDataModel 天气预报数据 model (IDOSetWeatherDataInfoBluetoothModel)
 * Weather Forecast Data model (IDOSetWeatherDataInfoBluetoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setWeatherCityCommand:(IDOSetWeatherDataInfoBluetoothModel *_Nullable)weatherDataModel
                     callback:(void (^ _Nullable)(int errorCode))callback;

/**
 * @brief 设置天气预报数据 (定制扩展功能数据不存储) | Set weather forecast data (Extend functionality)
 * @param weatherData 天气预报数据 @{@"today":weatherModel,@"city":@"",@"oneHourWeather":@[@{@"type":@(0),@"temp":@(0)}...]}
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
*/
+ (void)setWeatherDataExtensionCommand:(NSDictionary *_Nullable)weatherData
                              callback:(void (^ _Nullable)(int errorCode))callback;

/**
 * @brief 设置iot按钮集合 (定制扩展功能数据不存储) | Set of iot buttons (Extend functionality)
 * @param buttonNames iot按钮集合最多可以设置20个按钮 @[@{@"index":@(0),@"button":@""}...]
 * callback 设置按钮集合回调进度 (0~1)  | Set the button progress  callback (0~1)
 * @param complete 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post complete (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
*/
+ (void)setIotButtonNamesCommand:(NSArray <NSDictionary * >* _Nullable)buttonNames
                        callback:(void (^ _Nullable)(float progress))callback
                        complete:(void (^ _Nullable)(int errorCode))complete;

/**
 * @brief 设置屏幕亮度 | Set screen brightness
 * @param screenBrightnessModel 屏幕亮度 model (IDOSetScreenBrightnessInfoBluetoothModel)
 * Screen Brightness model (IDOSetScreenBrightnessInfoBluetoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setScreenBrightnessCommand:(IDOSetScreenBrightnessInfoBluetoothModel * _Nullable)screenBrightnessModel
                          callback:(void (^ _Nullable)(int errorCode))callback;

/**
 * @brief  设置GPS信息 | Set GPS information
 * @param gpsInfoModel GPS信息 model (IDOSetGpsConfigInfoBluetoothModel)
 * GPS information model (IDOSetGpsConfigInfoBluetoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setGpsInfoCommand:(IDOSetGpsConfigInfoBluetoothModel * _Nullable)gpsInfoModel
                 callback:(void (^ _Nullable)(int errorCode))callback;

/**
 * @brief 设置GPS控制信息 | Set GPS Control Information
 * @param gpsControlModel GPS控制信息 model (IDOSetGpsControlInfoBluetoothModel)
 * GPS Control Information model (IDOSetGpsControlInfoBluetoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str) (status 0 : 写入失败 , 1 : 正在写入 , 2 : 写入完成)
 */
+ (void)setGpsControlCommand:(IDOSetGpsControlInfoBluetoothModel * _Nullable)gpsControlModel
                    callback:(void (^ _Nullable)(int status,int errorCode))callback;

/**
 * @brief 设置控制连接参数 | Setting Control Connection Parameters
 * @param connParamModel 控制连接参数 model (IDOSetConnParamInfoBluetoothModel)
 * Control connection parameters model (IDOSetConnParamInfoBluetoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setConnParamCommand:(IDOSetConnParamInfoBluetoothModel * _Nullable)connParamModel
                   callback:(void (^ _Nullable)(int modeCode,int errorCode))callback;

/**
 * @brief  设置热启动参数 | Setting hot start parameters
 * @param hotStartParamModel 热启动参数 model (IDOGetHotStartParamBluetoothModel)
 * Hot Start Parameters model (IDOGetHotStartParamBluetoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setHotStartParamCommand:(IDOGetHotStartParamBluetoothModel * _Nullable)hotStartParamModel
                       callback:(void (^ _Nullable)(int errorCode))callback;

/**
 * @brief 设置传感器实时数据 | Set sensor real-time data
 * @param realTimeModel 传感器实时数据 model (IDOSetRealTimeSensorDataInfoBluetoothModel)
 * Sensor real-time data model (IDOSetRealTimeSensorDataInfoBluetoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setRealTimeSensorDataCommand:(IDOSetRealTimeSensorDataInfoBluetoothModel * _Nullable)realTimeModel
                            callback:(void (^ _Nullable)(int errorCode))callback;

/**
 * @brief 设置马达参数 | Setting the motor parameters
 * @param startMotorModel 马达参数 model (IDOSetStartMotorInfoBluetoothModel)
 * Motor Parameter model (IDOSetStartMotorInfoBluetoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setStartMotorCommand:(IDOSetStartMotorInfoBluetoothModel * _Nullable)startMotorModel
                    callback:(void (^ _Nullable)(int errorCode))callback;


/**
 * @brief 设置表盘参数 | Setting the dial parameters
 * @param watchDiaModel 表盘参数 model (IDOSetWatchDiaInfoBluetoothModel)
 * Dial Parameters model (IDOSetWatchDiaInfoBluetoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setWatchDiaCommand:(IDOSetWatchDiaInfoBluetoothModel * _Nullable)watchDiaModel
                  callback:(void (^ _Nullable)(int errorCode))callback;


/// 设置应用列表壁纸  Setting the app list wallpapers
/// @param callback app list wallpapers model (IDOSetApplicationListWallpaperModel)
/// @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
+ (void)setAppListWallpaperCommand:(IDOSetAppListWallpaperModel * _Nullable)wallpaperModel
                                  callback:(void (^ _Nullable)(int errorCode))callback;


/**
 * @brief 设置血压测量参数 | Setting blood pressure measurement parameters
 * @param bpMeasureModel 血压测量参数 model (IDOSetBpMeasureInfoBluetoothModel)
 * Blood pressure measurement parameters model (IDOSetBpMeasureInfoBluetoothModel)
 * @param callback 设置回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str ; model实时血压数据和状态)
 * Set callback (errorCode: 0 transmission succeeded, other values are wrong, error code str can be obtained according to IDOErrorCodeToStr;
 * model real-time blood pressure data and status)
 */
+ (void)setBpMeasureCommand:(IDOSetBpMeasureInfoBluetoothModel * _Nullable)bpMeasureModel
                   callback:(void (^ _Nullable)(int errorCode,IDOSetBpMeasureInfoBluetoothModel * _Nullable model))callback;


/**
 * @brief 设置心率测量参数 | Setting measurement parameters
 * @param hrMeasureModel 测量参数 model (IDOSetHrMeasureInfoBluetoothModel)
 * measurement parameters model (IDOSetHrMeasureInfoBluetoothModel)
 * @param callback 设置回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str ; model实时数据和状态)
 * Set callback (errorCode: 0 transmission succeeded, other values are wrong, error code str can be obtained according to IDOErrorCodeToStr;
 * model real-time data and status)
 */
+ (void)setHrMeasureCommand:(IDOSetHrMeasureInfoBluetoothModel * _Nullable)hrMeasureModel
                   callback:(void (^ _Nullable)(int errorCode,IDOSetHrMeasureInfoBluetoothModel * _Nullable model))callback;

/**
 * @brief 设置血氧测量参数 | Setting measurement parameters
 * @param spo2MeasureModel 测量参数 model (IDOSetSpo2MeasureInfoBluetoothModel)
 * measurement parameters model (IDOSetSpo2MeasureInfoBluetoothModel)
 * @param callback 设置回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str ; model实时数据和状态)
 * Set callback (errorCode: 0 transmission succeeded, other values are wrong, error code str can be obtained according to IDOErrorCodeToStr;
 * model real-time data and status)
 */
+ (void)setSpo2MeasureCommand:(IDOSetSpo2MeasureInfoBluetoothModel * _Nullable)spo2MeasureModel
                     callback:(void (^ _Nullable)(int errorCode,IDOSetSpo2MeasureInfoBluetoothModel * _Nullable model))callback;

/**
 * @brief 设置睡眠时间段 | Setting the sleep period
 * @param sleepPeriodModel 睡眠时间段 model (IDOSetSleepPeriodInfoBluetoothModel)
 * Sleep time period model (IDOSetSleepPeriodInfoBluetoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setSleepPeriodCommand:(IDOSetSleepPeriodInfoBluetoothModel * _Nullable)sleepPeriodModel
                     callback:(void (^ _Nullable)(int errorCode))callback;

/**
 * @brief 设置女性生理周期 (id205) | Setting the female physiological cycle (id205)
 * @param menstrualModel 女性生理周期 model (IDOSetMenstruationInfoBluetoothModel)
 * Female Physiological Cycle model (IDOSetMenstruationInfoBluetoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setMenstrualCommand:(IDOSetMenstruationInfoBluetoothModel * _Nullable)menstrualModel
                   callback:(void (^ _Nullable)(int errorCode))callback;


/**
 * @brief 设置女性生理周期提醒 (id205) | Set Women's Physiological Cycle Reminder (id205)
 * @param remindModel 女性生理周期提醒 model (IDOSetMenstruationRemindBluetoothModel)
 * Female Physiological Cycle Reminder model (IDOSetMenstruationRemindBluetoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setMenstrualRemindCommand:(IDOSetMenstruationRemindBluetoothModel * _Nullable)remindModel
                         callback:(void (^ _Nullable)(int errorCode))callback;

/**
 * @brief 设置每分钟呼吸次数 (139)  | Breaths per minute
 * @param breatheModel 每分钟呼吸次数 model (IDOSetBreatheTrainBluetoothModel)
 * Breaths per minute model (IDOSetBreatheTrainBluetoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setBreatheTrainCommand:(IDOSetBreatheTrainBluetoothModel * _Nullable)breatheModel
                      callback:(void (^ _Nullable)(int errorCode))callback;

/**
 * @brief 设置走动提醒开关 (139) | Walking reminder switch
 * @param walkModel 走动提醒开关 model (IDOSetWalkReminderBluetoothModel)
 * Walking reminder switch model (IDOSetWalkReminderBluetoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setWalkReminderCommand:(IDOSetWalkReminderBluetoothModel * _Nullable)walkModel
                      callback:(void (^ _Nullable)(int errorCode))callback;

/**
 * @brief 设置自定义时间走动提醒开关 (id207定制) | Walking reminder switch
 * @param reminderModel 走动提醒开关 model (IDOSetCustomTimeWalkReminderModel)
 * Walking reminder switch model (IDOSetCustomTimeWalkReminderModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setCustomTimeWalkReminderCommand:(IDOSetCustomTimeWalkReminderModel * _Nullable)reminderModel
                                callback:(void (^ _Nullable)(int errorCode))callback;

/**
 * @brief 设置血氧开关 (139) | blood oxygen switch
 * @param spo2Model 血氧开关 model (IDOSetSpo2SwitchBluetoothModel)
 * blood oxygen switch model (IDOSetSpo2SwitchBluetoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setSpo2SwitchCommand:(IDOSetSpo2SwitchBluetoothModel * _Nullable)spo2Model
                    callback:(void (^ _Nullable)(int errorCode))callback;

/**
 * @brief 设置运动开关 (139) | activity switch
 * @param switchModel 运动开关 model (IDOSetActivitySwitchBluetoothModel)
 * activity switch model (IDOSetActivitySwitchBluetoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setActivitySwitchCommand:(IDOSetActivitySwitchBluetoothModel * _Nullable)switchModel
                        callback:(void (^ _Nullable)(int errorCode))callback;

/**
 * @brief 设置心率开关同步 (139) | v3 heart rate
 * @param v3HrModel 心率开关 model (IDOSetV3HeartRateModeBluetoothModel)
 * v3 heart rate switch model (IDOSetV3HeartRateModeBluetoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
*/
+ (void)setV3HrModelCommand:(IDOSetV3HeartRateModeBluetoothModel * _Nullable)v3HrModel
                   callback:(void (^ _Nullable)(int errorCode))callback;

/**
 * @brief 设置喝水提醒  | drink water reminder
 * @param drinkModel 喝水提醒开关 model (IDOSetDrinkReminderModeBluetoothModel)
 * drink water reminder switch model (IDOSetDrinkReminderModeBluetoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
*/
+ (void)setDrinkReminderCommand:(IDOSetDrinkReminderModeBluetoothModel * _Nullable)drinkModel
                       callback:(void (^ _Nullable)(int errorCode))callback;

/**
 * @brief 设置菜单列表  | drink water reminder
 * @param menuModel 设置菜单列表 model (IDOGetMenuListInfoBluetoothModel)
 * set menu list model (IDOGetMenuListInfoBluetoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
*/
+ (void)setMenuListCommand:(IDOGetMenuListInfoBluetoothModel * _Nullable)menuModel
                  callback:(void (^ _Nullable)(int errorCode))callback;

/**
 * @brief 设置压力开关  | pressure switch
 * @param switchModel 设置压力开关 model (IDOSetPressureSwitchBluetoothModel)
 * set pressure switch model (IDOSetPressureSwitchBluetoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
*/
+ (void)setPressureSwitchCommand:(IDOSetPressureSwitchBluetoothModel * _Nullable)switchModel
                        callback:(void (^ _Nullable)(int errorCode))callback;

/**
 * @brief 设置吃药提醒  | taking medicine reminder
 * @param reminderModel 设置吃药提醒 model (IDOSetTakingMedicineReminderModel)
 * set taking medicine reminder model (IDOSetTakingMedicineReminderModel)
 * callback 设置吃药提醒集合回调进度 (0~1)  | Set taking medicine reminder progress  callback (0~1)
 * @param complete 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post complete (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
*/
+ (void)setTakingMedicineReminderCommand:(IDOSetTakingMedicineReminderModel * _Nullable)reminderModel
                                callback:(void (^ _Nullable)(float progress))callback
                                complete:(void (^ _Nullable)(int errorCode))complete;

/**
 * @brief 设置洗手提醒  | wash hand reminder
 * @param reminderModel 设置洗手提醒 model (IDOSetWashHandReminderModel)
 * set wash hand reminder model (IDOSetWashHandReminderModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post complete (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setWashHandReminderCommand:(IDOSetWashHandReminderModel *_Nullable)reminderModel
                          callback:(void (^ _Nullable)(int errorCode))callback;

/**
 * @brief 设置alexa 通知状态  | set alexa notify state
 * @param state 设置alexa 通知状态  0：无效值；1：有通知 （黄色）， 2:通知清除（蓝色）
 * set alexa notify state 0: Invalid value; 1: Notification (yellow); 2: Notification clearance (blue)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post complete (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setAlexaNotifyState:(NSInteger)state
                   callback:(void (^ _Nullable)(int errorCode))callback;

/**
 * @brief 设置天气日出日落的时间 | Sunrise and sunset time
 * @param sunTimeModel 天气日出日落的时间 model (IDOSetWeatherSunTimeModel)
 * set wash hand reminder model (IDOSetWeatherSunTimeModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post complete (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setWeatherSunTimeCommand:(IDOSetWeatherSunTimeModel *_Nullable)sunTimeModel
                        callback:(void (^ _Nullable)(int errorCode))callback;

/**
 * @brief 设置星星数量 数据不作存储 (锐捷) | Set the number of stars (ruijie)
 * @param startCount 星星数量 (1~5)| number of stars (1~5)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setStartCountCommand:(NSInteger)startCount
                    callback:(void (^ _Nullable)(int errorCode))callback;

/**
 * @brief 设置蓝牙短信推送 数据不作存储 (锐捷) | Set bluetooth SMS push (ruijie)
 * @param content 蓝牙短信推送内容 (最长64个字节) | push content （Up to 64 bytes）
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setContentCommand:(NSString * _Nullable)content
                 callback:(void (^ _Nullable)(int errorCode))callback;

/**
 * @brief 设置用户名字 数据不作存储 (锐捷) | Set user name (ruijie)
 * @param userName 用户名字 (最长10个字节) | user name （Up to 10 bytes）
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setUserNameCommand:(NSString * _Nullable)userName
                  callback:(void (^ _Nullable)(int errorCode))callback;

/**
 * @brief 设置用户号码 数据不作存储 (锐捷) | Set user number (ruijie)
 * @param userNumber 用户号码 (最长10个字节) | user number （Up to 10 bytes）
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setUserNumberCommand:(NSString * _Nullable)userNumber
                    callback:(void (^ _Nullable)(int errorCode))callback;

/**
 * @brief 智能心率模式设置
 * @param smartHrModel 心率模式
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setSmartHeartRateCommand:(IDOSetSmartHeartRateModel *_Nullable)smartHrModel
                        callback:(void (^ _Nullable)(int errorCode))callback;
/**
 * @brief 设置科学睡眠开关
 * @param sleepModel  科学睡眠
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setScientificSleepCommand:(IDOSetV3ScientificSleepModel *_Nullable)sleepModel
                         callback:(void (^ _Nullable)(int errorCode))callback;

/**
 * @brief 设置夜间体温开关
 * @param temperatureModel  夜间体温开关
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setTemperatureCommand:(IDOSetV3TemperatureModel *_Nullable)temperatureModel
                     callback:(void (^ _Nullable)(int errorCode))callback;
/**
 * @brief //设置环境音量的开关
 * @param noiseModel  增加环境音量的开关
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setNoiseSwitchCommand:(IDOSetV3NoiseSwitchModel *_Nullable)noiseModel
                     callback:(void (^ _Nullable)(int errorCode))callback;
/**
 * @brief //设置健身指导开关
 * @param guidanceModel  //设置健身指导开关
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setFitnessGuidanceCommand:(IDOSetFitnessGuidanceModel *_Nullable)guidanceModel
                         callback:(void (^ _Nullable)(int errorCode))callback;

/**
 * @brief //设置通话常用联系人
 * @param contactModel //设置通话常用联系人
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setSyncContactCommand:(IDOSetSyncContactModel *_Nullable)contactModel
                     callback:(void (^ _Nullable)(int errorCode))callback;

/**
 * @brief //设置通话紧急联系人
 * @param contactModel //设置通话紧急联系人
 * Function table(功能表)：__IDO_FUNCTABLE__.funcTable29Model.supportV3SetEmergencyConnact
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setSyncEmergencyContactCommand:(IDOSetSyncEmergencyContactModel *_Nullable)contactModel
                     callback:(void (^ _Nullable)(int errorCode))callback;

/**
 * @brief //设置通话常用联系人（数据量比较大）
 * @param contactModel //设置通话常用联系人
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setSyncAllContactCommand:(IDOSetSyncAllContactModel *_Nullable)contactModel
                        callback:(void (^ _Nullable)(int errorCode,NSString* _Nullable path))callback;

/**
 * @brief //设置世界时间
 * @param worldTimeModel //设置世界时间
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setWorldTimeCommand:(IDOSetV3WorldTimeModel *_Nullable)worldTimeModel
                   callback:(void (^ _Nullable)(int errorCode))callback;
/**
 * @brief //设置V3天气数据
 * @param v3WeatherModel //设置V3天气数据
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setV3WeatcherDataCommand:(IDOSetV3WeatherDataModel *_Nullable)v3WeatherModel
                        callback:(void (^ _Nullable)(int errorCode))callback;

/**
 * @brief //设置第三方应用的通知状态
 * @param stateModel //设置第三方应用的通知状态
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setMessageNoticeStateCommand:(IDOSetV3NotifyStateModel *_Nullable)stateModel
                            callback:(void (^ _Nullable)(int errorCode))callback;

/**
 * @brief //设置运动子项数据排列
 * @param sortModel //设置运动子项数据排列
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setSportParameterSortCommand:(IDOSetSportParameterSortModel *_Nullable)sortModel
                            callback:(void (^ _Nullable)(int errorCode))callback;
/**
 * @brief //设置日程提醒
 * @param reminderModel //设置日程提醒
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setScheduleReminderCommand:(IDOSetV3ScheduleReminderModel *_Nullable)reminderModel
                          callback:(void (^ _Nullable)(int errorCode))callback;
/**
 * @brief //设置主界面控件排序
 * @param sortModel //设置主界面控件排序
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setMainUiSortCommand:(IDOMainInterfaceSortModel *_Nullable)sortModel
                    callback:(void (^ _Nullable)(int errorCode))callback;

/**
 * @brief //设置经期历史数据
 * 功能表： __IDO_FUNCTABLE__.funcTable39Model.supportSetHistoricalMenstruationUseV2
 * 若功能表支持，则支持排卵期相关字段的设置
 * @param historyModel 经期历史数据模型
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setMenstrualHistoryDataCommand:(IDOMenstrualHistoryDataModel *_Nullable)historyModel
                              callback:(void (^ _Nullable)(int errorCode))callback;


/**
 * @brief //设置未读APP提醒(应用通知红点提醒)
 * @param reminderModel 设置未读APP提醒数据模型
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setUnReadAppReminderSwithCommand:(IDOSetUnReadAppReminderModel *_Nullable)reminderModel
                                callback:(void (^ _Nullable)(int errorCode))callback;

/**
 * @brief //设置事项提醒通知应用状态
 * @param statusModel 设置通事项提醒通知应用状态数据模型
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setNotificationStatusCommand:(IDOSetNotificationStatusModel *_Nullable)statusModel
                            callback:(void (^ _Nullable)(int errorCode))callback;
/**
 * @brief //设置压力校准
 * @param stressModel 设置压力校准数据模型
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * retCode（0x00:成功，0x01：失败-正在校准<br />0x02：失败-正在充电，0x03：失败-未佩戴，0x04：失败-运动场景中）
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setStressCalibrationCommand:(IDOSetStressCalibrationModel *_Nullable)stressModel
                           callback:(void (^ _Nullable)(int errorCode,int retCode))callback;
/**
 * @brief //设置呼吸率开关
 * @param switchModel 设置呼吸率开关模型
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setBreathRateSwitchCommand:(IDOSetBreathRateSwitchModel *_Nullable)switchModel
                          callback:(void (^ _Nullable)(int errorCode))callback;
/**
 * @brief //设置权限状态
 * @param stateModel 设置权限状态模型
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setPermissionsStateCommand:(IDOSetPermissionsModel *_Nullable)stateModel
                          callback:(void (^ _Nullable)(int errorCode))callback;

/**
 * @brief //设置身体电量开关
 * @param switchModel 设置身体电量开关模型
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setBodyPowerSwitchCommand:(IDOSetBodyPowerSwitchModel *_Nullable)switchModel
                         callback:(void (^ _Nullable)(int errorCode))callback;

/**
 * @brief //设置语音助手开关
 * @param switchModel 设置语音助手开关模型
 * 功能表： __IDO_FUNCTABLE__.funcTable35Model.supportSetVoiceAssistantStatus
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setVoiceAssistantStatusCommand:(IDOSetVoiceAssistantStatusModel *_Nullable)switchModel
                         callback:(void (^ _Nullable)(int errorCode))callback;

/**
 * @brief //APP下发alexa功能开关
 * @param alexaAoiceFunctionStatusModel alexa功能开关
 * 功能表： __IDO_FUNCTABLE__.funcTable39Model.supportSetAlexaFunctionOnOff
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setAlexaVoiceFunctionCommand:(IDOSetAlexaAoiceFunctionStatusModel *_Nullable)alexaAoiceFunctionStatusModel
                            callback:(void (^_Nullable)(int errorCode))callback;

/**
 * @brief //手机操作系统设置
 * 功能表： __IDO_FUNCTABLE__.funcTable38Model.supportAppSendPhoneSystemInfo
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setPhoneSystemInfoCommand:(void (^ _Nullable)(int errorCode))callback;

/**
 * @brief //设置来电快捷回复
 * 功能表： __IDO_FUNCTABLE__.funcTable39Model.supportSetCallQuickReplyOnOff
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setCallQuickStatusCommand:(IDOSetCallQuickStatusModel *_Nullable)callQuickStatusModel
                         callback:(void (^_Nullable)(int errorCode))callback;

/**
 * @brief APP控制固件屏蔽功能 VP
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setCloseDeviceFunctionCommand:(IDOSetCloseDeviceFunctionModel *_Nullable)closeDeviceFunctionModel
                         callback:(void (^_Nullable)(int errorCode))callback;

/**
 * @brief 设置喝水计划
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setDrinkPlanCommand:(IDOSetDrinkPlanDataModel *_Nullable)drinkPlanModel
                   callback:(void (^_Nullable)(int errorCode))callback;

/**
 * @brief 设置游戏时间开关
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)setGameTimeCommand:(IDOSetGameTimeReminder *_Nullable)gameTimeModel
                  callback:(void (^_Nullable)(int errorCode))callback;


/**
 * @brief APP 主动发送开始拍照预览指令
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)appSendPhotoPreviewStartCommand:(void (^_Nullable)(int))callback;

/**
 * @brief APP 主动发送拍照预览暂停指令
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)appSendPhotoPreviewPauseCommand:(void (^_Nullable)(int))callback;

/**
 * @brief APP 主动发送拍照预览退出指令
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)appSendPhotoPreviewExitCommand:(void (^_Nullable)(int))callback;



#pragma mark ======= get Command =======

/**
 * @brief 获取mac地址 | Get mac address
 * @param callback 执行后回调 data (IDOGetMacAddrInfoBluetoothModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * callback data (IDOGetMacAddrInfoBluetoothModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)getMacAddrCommand:(void(^_Nullable)(int errorCode,IDOGetMacAddrInfoBluetoothModel * _Nullable data))callback;

/**
 * @brief  获取设备信息 | Get device information
 * @param callback 执行后回调 data (IDOGetDeviceInfoBluetoothModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * callback data (IDOGetDeviceInfoBluetoothModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)getDeviceInfoCommand:(void(^_Nullable)(int errorCode,IDOGetDeviceInfoBluetoothModel * _Nullable data))callback;

/**
 * @brief  获取功能列表 | Get the list of features
 * @param callback 执行后回调 data (IDOGetDeviceFuncBluetoothModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * callback data (IDOGetDeviceFuncBluetoothModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)getFuncTableCommand:(void(^_Nullable)(int errorCode,IDOGetDeviceFuncBluetoothModel * _Nullable data))callback;

/**
 * @brief  获得实时数据 | Get real-time data
 * @param callback 执行后回调 data (IDOGetLiveDataBluetoothModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * callback data (IDOGetLiveDataBluetoothModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)getLiveDataCommand:(void(^_Nullable)(int errorCode,IDOGetLiveDataBluetoothModel * _Nullable data))callback;

/**
 * @brief 获取设备当前时间 | Get the current time of the device
 * @param callback 执行后回调 data (IDOGetDeviceTimeBluetoothModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * callback data (IDOGetDeviceTimeBluetoothModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)getDeviceTimeCommand:(void(^_Nullable)(int errorCode,IDOGetDeviceTimeBluetoothModel * _Nullable data))callback;

/**
 * @brief 获取通知中心的状态 | Get the status of the notification center
 * @param callback 执行后回调 data (IDOSetNoticeInfoBuletoothModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * callback data (IDOSetNoticeInfoBuletoothModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)getNoticeStatusCommand:(void(^_Nullable)(int errorCode,IDOSetNoticeInfoBuletoothModel * _Nullable data))callback;

/**
 * @brief 获取心率传感器参数 | Get Heart Rate Sensor Parameters
 * @param callback 执行后回调 data (IDOGetHrSensorParamBluetoothModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * callback data (IDOGetHrSensorParamBluetoothModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)getHrSensorParamCommand:(void(^_Nullable)(int errorCode,IDOGetHrSensorParamBluetoothModel * _Nullable data))callback;

/**
 * @brief 获取加速度传感器参数 | Acquire acceleration sensor parameters
 * @param callback 执行后回调 data (IDOGetGsensorParamBluetoothModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * callback data (IDOGetGsensorParamBluetoothModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)getGsensorParamCommand:(void(^_Nullable)(int errorCode,IDOGetGsensorParamBluetoothModel * _Nullable data))callback;

/**
 * @brief 获取活动数量 | Get the number of events
 * @param callback 执行后回调 data (IDOGetActivityCountBluetoothModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * callback data (IDOGetActivityCountBluetoothModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)getActivityCountCommand:(void(^_Nullable)(int errorCode,IDOGetActivityCountBluetoothModel * _Nullable data))callback;

/**
 * @brief  获取hid信息 | Get hid information
 * @param callback 执行后回调 data (IDOGetHidInfoBluetoothModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * callback data (IDOGetHidInfoBluetoothModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)getHidInfoCommand:(void(^_Nullable)(int errorCode,IDOGetHidInfoBluetoothModel * _Nullable data))callback;

/**
 * @brief  获取gps信息 | Get gps information
 * @param callback 执行后回调 data (IDOGetGpsInfoBluetoothModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * callback data (IDOGetGpsInfoBluetoothModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)getGpsInfoCommand:(void(^_Nullable)(int errorCode,IDOGetGpsInfoBluetoothModel * _Nullable data))callback;

/**
 * @brief  获取热启动参数 | Get hot start parameters
 * @param callback 执行后回调 data (IDOGetHotStartParamBluetoothModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * callback data (IDOGetHotStartParamBluetoothModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)getHotStartParamCommand:(void(^_Nullable)(int errorCode,IDOGetHotStartParamBluetoothModel * _Nullable data))callback;

/**
 * @brief  获取GPS状态 | Get GPS status
 * @param callback 执行后回调 data (IDOGetGpsStatusBluetoothModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * callback data (IDOGetGpsStatusBluetoothModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)getGpsStatusCommand:(void(^_Nullable)(int errorCode,IDOGetGpsStatusBluetoothModel * _Nullable data))callback;

/**
 * @brief  获取软硬件版本信息 | Get version information
 * @param callback 执行后回调 data (IDOGetVersionInfoBluetoothModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * callback data (IDOGetVersionInfoBluetoothModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)getVersionInfoCommand:(void(^_Nullable)(int errorCode,IDOGetVersionInfoBluetoothModel * _Nullable data))callback;

/**
 * @brief  获取固件三级版本信息 | Get level 3 version information
 * @param callback 执行后回调 data (IDOGetVersionInfoBluetoothModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * callback data (IDOGetVersionInfoBluetoothModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)get3LevelFirmwareVersionCommand:(void(^_Nullable)(int errorCode,IDOGetVersionInfoBluetoothModel * _Nullable data))callback;

/**
 * @brief  获取realtek平台 ota授权 | Obtain ota authorization of realtek platform
 * @param callback 执行后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * callback (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 * stateCode 0x00:校验成功,0x01:ID号校验失败,0x02:版本号校验失败,0x03:电量不足,0x04:其他错误
 * stateCode 0x00: verification success,0x01:ID number verification failure,0x02: version number verification failure,0x03: insufficient power,0x04: other errors
 */
+ (void)getOtaAuthInfoCommand:(void(^_Nullable)(int errorCode,int stateCode))callback;

/**
 * @brief  默认的运动类型 | get default sport type
 * @param callback 执行后回调 data (IDOGetDefaultSportTypeBluetoothModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * callback data (IDOGetDefaultSportTypeBluetoothModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
*/
+ (void)getDefaultSportTypeCommand:(void(^_Nullable)(int errorCode,IDOGetDefaultSportTypeBluetoothModel * _Nullable data))callback;

/**
 * @brief  获取默认语言 | get default language
 * @param callback 执行后回调 data (IDOGetDownLanguageBluetoothModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * callback data (IDOGetDownLanguageBluetoothModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
*/
+ (void)getDefaultLanguageCommand:(void(^_Nullable)(int errorCode,IDOGetDownLanguageBluetoothModel * _Nullable data))callback;

/**
 * @brief  获取alexa默认语音 | get alexa default language
 *  德语  1   英语(澳大利亚)  2   英语(加拿大) 3   英语(英国)  4
 *  英语(印度)   5   英语(美国)  6    西班牙语  7   西班牙语(墨西哥)  8
 *  西班牙语(美国) 9   法语(加拿大)10   法语11  意大利语 12
 *  日语 13   葡萄牙语(巴西) 14
 * @param callback 执行后回调 langCode (语言索引) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * callback langCode (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)getAlexaDefaultLanguageCommand:(void(^_Nullable)(int errorCode,NSInteger langCode))callback;

/**
 * @brief 设置错误日志记录  | set error log record
 * @param logModel 错误日志记录 model (IDOGetErrorLogBluetoothModel)
 * error log record model (IDOGetErrorLogBluetoothModel)
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str,IDOGetErrorLogBluetoothModel:错误日志记录模型)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong,
 * you can get error code str according to IDOErrorCodeToStr,IDOGetErrorLogBluetoothModel:error log record model)
 */
+ (void)getErrorLogRecordCommand:(IDOGetErrorLogBluetoothModel * _Nullable)logModel
                        callback:(void (^ _Nullable)(int errorCode,IDOGetErrorLogBluetoothModel * _Nullable model))callback;

/**
 * @brief  获取字库版本信息  | get flash bin info
 * @param callback 执行后回调 data (IDOGetFlashBinInfoBluetoothModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * callback data (IDOGetFlashBinInfoBluetoothModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)getFlashBinInfoCommand:(void(^_Nullable)(int errorCode,IDOGetFlashBinInfoBluetoothModel * _Nullable data))callback;

/**
 * @brief  获取电池信息  | get battery  info
 * @param callback 执行后回调 data (IDOGetDeviceBattInfoBluetoothModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * callback data (IDOGetDeviceBattInfoBluetoothModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
*/
+ (void)getBatteryInfoCommand:(void(^_Nullable)(int errorCode,IDOGetDeviceBattInfoBluetoothModel * _Nullable data))callback;

/**
 * @brief  获取菜单列表  | get menu list info
 * @param callback 执行后回调 data (IDOGetMenuListInfoBluetoothModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * callback data (IDOGetMenuListInfoBluetoothModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
*/
+ (void)getMenuListInfoCommand:(void(^_Nullable)(int errorCode,IDOGetMenuListInfoBluetoothModel * _Nullable data))callback;

/**
 * @brief  获取不可删除的快捷应用菜单列表  | get undele menu list info
 * 功能表 Functable:  __IDO_FUNCTABLE__.funcTable28Model.supportV2GetUnDeleMeun
 * @param callback 执行后回调 data (IDOGetUndeleMenuListInfoBluetoothModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * callback data (IDOGetUndeleMenuListInfoBluetoothModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
*/
+ (void)getUndeleMenuListInfoCommand:(void(^_Nullable)(int errorCode,IDOGetUndeleMenuListInfoBluetoothModel * _Nullable data))callback;

/**
 * @brief  获取v3闹钟  | get v3 alarms info
 * @param callback 执行后回调 data (IDOSetExtensionAlarmInfoBluetoothModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * callback data (IDOSetExtensionAlarmInfoBluetoothModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
*/
+ (void)getV3AlarmsInfoCommand:(void(^_Nullable)(int errorCode,IDOSetExtensionAlarmInfoBluetoothModel * _Nullable data))callback;

/**
 * @brief  获取alexa闹钟  | get alexa alarms info
 * @param callback 执行后回调 data (IDOSetVoiceV3AlarmInfoModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * callback data (IDOSetVoiceV3AlarmInfoModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
*/
+ (void)getAlexaAlarmsInfoCommand:(void(^_Nullable)(int errorCode,IDOSetVoiceV3AlarmInfoModel * _Nullable data))callback;

/**
 * @brief  获取v3心率模式  | get v3 heart rate mode info
 * @param callback 执行后回调 data (IDOSetV3HeartRateModeBluetoothModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * callback data (IDOSetV3HeartRateModeBluetoothModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
*/
+ (void)getV3HrModeInfoCommand:(void(^_Nullable)(int errorCode,IDOSetV3HeartRateModeBluetoothModel * _Nullable data))callback;

/**
 * @brief  获取mtu  | get mtu
 * @param callback 执行后回调 data (IDOGetMtuBlueInfoModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * callback data (IDOGetMtuBlueInfoModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
*/
+ (void)getMtuInfoCommand:(void(^_Nullable)(int errorCode,IDOGetMtuBlueInfoModel * _Nullable data))callback;

/**
 * @brief  获取过热日志  | get over heat log
 * @param callback 执行后回调 data (IDOGetOverHeatLogModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * callback data (IDOGetOverHeatLogModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
*/
+ (void)getOverHeatLogInfoCommand:(void(^_Nullable)(int errorCode,IDOGetOverHeatLogModel * _Nullable data))callback;

/**
 * @brief  获取电池日志  | get battery log
 * @param callback 执行后回调 data (NSDictionary) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * callback data (NSDictionary) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
*/
+ (void)getBatteryLogInfoCommand:(void(^_Nullable)(int errorCode,NSDictionary * _Nullable data))callback;

/**
 * @brief  获取屏幕亮度  | get screen brightness
 * @param callback 执行后回调 data (IDOSetScreenBrightnessInfoBluetoothModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * callback data (IDOSetScreenBrightnessInfoBluetoothModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
*/
+ (void)getScreenBrightnessCommand:(void(^_Nullable)(int errorCode,IDOSetScreenBrightnessInfoBluetoothModel * _Nullable data))callback;

/**
 * @brief  获取抬腕手势  | get hand up gesture
 * @param callback 执行后回调 data (IDOSetHandUpInfoBuletoothModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * callback data (IDOSetHandUpInfoBuletoothModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
*/
+ (void)getHandUpGestureCommand:(void(^_Nullable)(int errorCode,IDOSetHandUpInfoBuletoothModel * _Nullable data))callback;

/**
 * @brief  获取勿扰模式  | get not disturb mode
 * @param callback 执行后回调 data (IDOSetNoDisturbModeInfoBluetoothModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * callback data (IDOSetNoDisturbModeInfoBluetoothModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
*/
+ (void)getNotDisturbCommand:(void(^_Nullable)(int errorCode,IDOSetNoDisturbModeInfoBluetoothModel * _Nullable data))callback;

/**
 * @brief  获取设备升级状态  | get update state
 * @param callback 执行后回调 data (IDOGetDeviceUpdateStateModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * callback data (IDOGetDeviceUpdateStateModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
*/
+ (void)getDeviceUpdateStateCommand:(void(^_Nullable)(int errorCode,IDOGetDeviceUpdateStateModel * _Nullable data))callback;

/**
 * @brief  获取设备授权加密码  | get device encrypted code
 * @param callback 执行后回调 data (IDOSetBindingInfoBluetoothModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * callback data (IDOSetBindingInfoBluetoothModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
*/
+ (void)getEncryptedCodeCommand:(void(^_Nullable)(int errorCode,IDOSetBindingInfoBluetoothModel * _Nullable data))callback;

/**
 * @brief  获取v3字库列表  | get v3 lang lib list
 * @param callback 执行后回调 data (IDOGetV3LangLibListModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * callback data (IDOGetV3LangLibListModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
*/
+ (void)getV3LangLibListCommand:(void(^_Nullable)(int errorCode,IDOGetV3LangLibListModel * _Nullable data))callback;

/**
 * @brief 获取所有的健康监测开关
 * @param callback 执行后回调 data (IDOGetHealthSwitchStateModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * callback data (IDOGetHealthSwitchStateModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)getHealthSwitchStateCommand:(void (^_Nullable)(int errorCode, IDOGetHealthSwitchStateModel * _Nullable data))callback;

/**
 * @brief 获取卡路里/距离/中高运动时长的目标 | Goal of getting calories / distance / medium and high exercise duration
 * @param callback 执行后回调 data (IDOSetUserInfoBuletoothModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * callback data (IDOSetUserInfoBuletoothModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)getCalorieDistanceGoalCommand:(void (^_Nullable)(int errorCode, IDOSetUserInfoBuletoothModel * _Nullable data))callback;

/**
 * @brief 获取卡路里/距离/中高运动时长的目标 | Goal of getting calories / distance / medium and high exercise duration
 * 功能表 | Function Table :   __IDO_FUNCTABLE__.funcTable29Model.timeGoalType
 *                    支持app设置获取运动三环周目标 | Support app settings to get the goal of the three rings of sports
 * @param dateGoalModel 获取目标数据类型的model | Get the model of the target data type
 *        dateGoalModel.timeGoaltype == 1时，相当于接口 getCalorieDistanceGoalCommand
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)getCalorieDistanceDateGoalCommand:(IDOSetCalorieDistanceDateGoalModel *_Nullable)dateGoalModel
                                 callback:(void (^ _Nullable)(int errorCode))callback;

/**
 * @brief 获取全天目标步数 | Get the daily target steps
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)getStepGoalCommand:(void (^_Nullable)(int errorCode, IDOGetStepGoalBluetoothModel * _Nullable data))callback;

/**
 * @brief 获取走动提醒
 * @param callback 执行后回调 data (IDOSetWalkReminderBluetoothModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * callback data (IDOSetWalkReminderBluetoothModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)getWalkReminderCommand:(void (^_Nullable)(int errorCode, IDOSetWalkReminderBluetoothModel * _Nullable data))callback;

/**
 * @brief 获取运动模式识别开关
 * @param callback 执行后回调 data (IDOSetActivitySwitchBluetoothModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * callback data (IDOSetActivitySwitchBluetoothModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)getActivitySwitchCommand:(void (^_Nullable)(int errorCode, IDOSetActivitySwitchBluetoothModel * _Nullable data))callback;

/**
 * @brief 获取100种运动模式排序
 * @param callback 执行后回调 data (IDOSetSportSortingInfoBluetoothModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * callback data (IDOSetSportSortingInfoBluetoothModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)get100SportModeSortCommand:(void (^_Nullable)(int errorCode, IDOSetSportSortingInfoBluetoothModel * _Nullable data))callback;

/**
 * @brief 获取常用联系人
 * @param callback 执行后回调 data (IDOSetSyncContactModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * callback data (IDOSetSyncContactModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)getContactDataCommand:(void (^_Nullable)(int errorCode, IDOSetSyncContactModel * _Nullable data))callback;

/**
 * @brief 获取紧急联系人
 * Function table(功能表)：__IDO_FUNCTABLE__.funcTable29Model.supportV3SetEmergencyConnact
 * @param callback 执行后回调 data (IDOSetSyncContactModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * callback data (IDOSetSyncContactModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)getEmergencyContactDataCommand:(void (^_Nullable)(int errorCode, IDOSetSyncEmergencyContactModel * _Nullable data))callback;

/**
 * @brief 获取第三方应用的消息通知状态
 * @param callback 执行后回调 data (IDOSetV3NotifyStateModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * callback data (IDOSetV3NotifyStateModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)getMessageNoticeStateCommand:(void (^_Nullable)(int errorCode, IDOSetV3NotifyStateModel * _Nullable data))callback;

/**
 * @brief 获取运动子项数据排列
 * @param sportType 运动类型
 * @param callback 执行后回调 data (IDOSetSportParameterSortModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * callback data (IDOSetSportParameterSortModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)getSportParameterSortCommand:(int)sportType
                            callback:(void (^_Nullable)(int errorCode, IDOSetSportParameterSortModel * _Nullable data))callback;

/**
 * @brief 获取主界面控件排序
 * @param callback 执行后回调 data (IDOMainInterfaceSortModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * callback data (IDOMainInterfaceSortModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)getMainUiSortCommand:(void (^_Nullable)(int errorCode, IDOMainInterfaceSortModel * _Nullable data))callback;

/**
 * @brief 获取日程提醒
 * @param callback 执行后回调 data (IDOSetV3ScheduleReminderModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * callback data (IDOSetV3ScheduleReminderModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)getScheduleReminderCommand:(void (^_Nullable)(int errorCode, IDOSetV3ScheduleReminderModel * _Nullable data))callback;

/**
 * @brief  获取固件日志状态  | get device log state
 * @param callback 执行后回调  state 日志状态: 0:没有日志产生，1:固件重启log (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * callback state 0:no log，1:firmware restart log (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
*/
+ (void)getDeviceLogStateCommand:(void (^ _Nullable)(int errorCode,NSInteger state))callback;

/**
 * @brief 校验完压力获取压力值和阀值
 * @param callback 执行后回调 data (IDOSetStressCalibrationModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * callback data (IDOSetStressCalibrationModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)getStressThresholdCommand:(void (^ _Nullable)(int errorCode,IDOSetStressCalibrationModel * _Nullable data))callback;

/**
 * @brief 获取bt 配对连接状态
 * @param callback 执行后回调 data (IDOGetBtPairStateModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * callback data (IDOGetBtPairStateModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)getBtPairStateCommand:(void (^ _Nullable)(int errorCode,IDOGetBtPairStateModel * _Nullable data))callback;

/**
 * @brief  获取星星的数量,数据不作存储（锐捷） | Get number of stars （ruijie）
 * @param callback 执行后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)getStartCountCommand:(void (^ _Nullable)(int errorCode,NSInteger startCount))callback;

/**
 * @brief  获取通讯录更新时间状态  | get ContactReviceTime state
 * @param callback 执行后回调  state  00: 不需要下发联系人文件     0x01：需要下发联系人数据  (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * callback state 0:no log，1:firmware restart log (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
*/
+ (void)getContactReviceTimeStateCommand:(void (^ _Nullable)(int errorCode,NSInteger state))callback;


/**
 * @brief 获取V2心率监测模式
 * @param callback 执行后回调 data (IDOSetHrModeInfoBluetoothModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * callback data (IDOSetHrModeInfoBluetoothModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)getV2HrModeInfoCommand:(void (^_Nullable)(int errorCode, IDOSetHrModeInfoBluetoothModel * _Nullable data))callback;

/**
 * @brief 获取固件本地提示音
 *  * 功能表 | Function Table :   __IDO_FUNCTABLE__.funcTable31Model.supportGetBleBeep
 * @param callback 执行后回调 data (IDOGetBeepFileListBluetoothModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * callback data (IDOGetBeepFileListBluetoothModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)getBeepFileListCommand:(void (^_Nullable)(int errorCode, IDOGetBeepFileListBluetoothModel * _Nullable data))callback;

/**
 * @brief 获取固件支持app下发的详情的最大数量 | Obtain the maximum number of details issued by the firmware support app
 *  * 功能表 | Function Table :   __IDO_FUNCTABLE__.funcTable28Model.supportGetSetMaxItemsNum
 * @param callback 执行后回调 data (IDOGetSettingMaxItemsNumBluetoothModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * callback data (IDOGetSettingMaxItemsNumBluetoothModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)getSettingMaxItemsNumCommand:(void (^_Nullable)(int errorCode, IDOGetSettingMaxItemsNumBluetoothModel * _Nullable data))callback;


/**
 * @brief 获取到固件的算法版本号详情 | Obtain the algorithm version number details of the firmware
 *  * 功能表 | Function Table :   __IDO_FUNCTABLE__.funcTable29Model.getV3DeviceAlgorithmVersion
 * @param callback 执行后回调 data (IDOGetAlgVersionBluetoothModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * callback data (IDOGetAlgVersionBluetoothModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)getAlgVersionCommand:(void (^_Nullable)(int errorCode, IDOGetAlgVersionBluetoothModel * _Nullable data))callback;


/**
 * @brief  获取设备语言配置，已经适配v2和v3  | get device language list
 * @param callback 执行后回调 data (IDOGetV3LangLibListModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * callback data (IDOGetV3LangLibListModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
*/
+ (void)getDeviceLanguageCommand:(void(^_Nullable)(int errorCode,IDOGetV3LangLibListModel * _Nullable data))callback;

/**
 * @brief 获取单位  ( APP收到固件通知 type = 60 ， 固件单位切换, 获取固件单位 ) | get unit
 *  * 功能表 | Function Table :  __IDO_FUNCTABLE__.funcTable39Model.supportGetUnit
 * @param callback 执行后回调 data (IDOSetUnitInfoBluetoothModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * callback data (IDOSetUnitInfoBluetoothModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)getUnitCommand:(void(^_Nullable)(int errorCode,IDOSetUnitInfoBluetoothModel * _Nullable unitModel))callback;


/**
 * @brief 获取血压三级版本号  | get bp version
 *  * 功能表 | Function Table :  __IDO_FUNCTABLE__.funcTable29Model.bpCalibrationV3
 * @param callback 执行后回调 data (IDOGetBpVersionBluetoothModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * callback data (IDOGetBpVersionBluetoothModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)getBpVersionCommand:(void(^_Nullable)(int errorCode,IDOGetBpVersionBluetoothModel * _Nullable data))callback;


/// 查询应用列表壁纸 | Example Query wallpaper in the application list
/// @param wallpaperModel wallpaperModel
/// @param callback IDOSetAppListWallpaperResModel (errorCode : 0 is successful, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
+ (void)getAppListWallpaperCommand:(IDOSetAppListWallpaperModel * _Nullable)wallpaperModel
                          callback:(void (^ _Nullable)(int errorCode,IDOSetAppListWallpaperResModel* _Nullable model))callback;

/**
 * @brief 获取运动记录显示配置项  | Get Motion records display configuration items
 *  * 功能表 | Function Table :  __IDO_FUNCTABLE__.funcTable39Model.supportV3SportRecordShowConfig
 * @param callback 执行后回调 data (IDOSetV3SportRecordShowConfigModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * callback data (IDOSetV3SportRecordShowConfigModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)getV3SportRecordShowConfigCommad:(void (^ _Nullable)(int errorCode,IDOSetV3SportRecordShowConfigModel* _Nullable model))callback;


#pragma mark ======= listen Command =======

/**
 * @brief 打开APP相机，进入拍照预览功能 | Open the APP camera and enter the photo preview function
 * @param callback 监听回调 (errorCode : 0：成功 1：失败 2：失败，进入拍照预览失败，APP在后台 3：失败，进入拍照预览失败，APP没有拍照权限 )
 * Listening callback (errorCode : 0 is successful, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)listenOpenAppPhotoInfoPreviewStartCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 暂停拍照预览，停止传输照片流| Pause App Photo Preview ，Stop transferring photo streams
 * @param callback 监听回调 (errorCode : 0：成功 1：失败 2：失败，进入拍照预览失败，APP在后台 3：失败，进入拍照预览失败，APP没有拍照权限 )
 * Listening callback (errorCode : 0 is successful, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)listenAppPhotoPreviewPauseCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 关闭APP相机，退出拍照预览功能| Close App Photo Exit Preview
 * @param callback 监听回调 (errorCode : 0：成功 1：失败 2：失败，进入拍照预览失败，APP在后台 3：失败，进入拍照预览失败，APP没有拍照权限 )
 * Listening callback (errorCode : 0 is successful, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)listenAppPhotoPreviewCloseCommand:(void(^_Nullable)(int errorCode))callback;


/**
 * @brief 音乐开始 | Music begins
 * @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Listening callback (errorCode : 0 is successful, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)listenMusicStartCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 音乐暂停 | Music pause
 * @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Listening callback (errorCode : 0 is successful, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)listenMusicPauseCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 音乐结束 | End of music
 * @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Listening callback (errorCode : 0 is successful, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)listenMusicStopCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 音乐上一首 | Music on the first
 * @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Listening callback (errorCode : 0 is successful, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)listenMusicLastCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 音乐下一首 | Music next
 * @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Listening callback (errorCode : 0 is successful, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)listenMusicNextCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 单次拍照 | Single photo
 * @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Listening callback (errorCode : 0 is successful, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)listenPhotoSingleShotCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 连续拍照 | Taking photos continuously
 * @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Listening callback (errorCode : 0 is successful, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)listenPhotoBurstCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 拍照开始 | Take a photo
 * @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Listening callback (errorCode : 0 is successful, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)listenPhotoStartCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 拍照结束 | End of photo
 * @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Listening callback (errorCode : 0 is successful, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)listenPhotoEndCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 音量+ | Volume +
 * @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Listening callback (errorCode : 0 is successful, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)listenVolumeUpCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 音量- | Volume -
 * @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Listening callback (errorCode : 0 is successful, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)listenVolumeDownCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 寻找手机开始 | Looking for a mobile phone to start
 * @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Listening callback (errorCode : 0 is successful, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)listenFindPhoneStartCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 寻找手机结束 | Looking for the end of the phone
 * @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Listening callback (errorCode : 0 is successful, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)listenFindPhoneStopCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 防丢启动 | Anti-lost start
 * @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Listening callback (errorCode : 0 is successful, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)listenLostStartCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 防丢结束 | Anti-lost end
 * @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Listening callback (errorCode : 0 is successful, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)listenLostStopCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 一键求救 | One button for help
 * @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Listening callback (errorCode : 0 is successful, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)listenSosStartCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 闹钟同步完成 | Alarm clock synchronization completed
 * @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Listening callback (errorCode : 0 is successful, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)listenAlarmSyncCompleteCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 配置同步完成 | Configure synchronization completion
 * @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Listening callback (errorCode : 0 is successful, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)listenConfigSyncCompleteCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 健康同步完成 | Health sync completed
 * @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Listening callback (errorCode : 0 is successful, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)listenHealthSyncCompleteCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 数据传输完成 | Data transfer completed
 * @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Listening callback (errorCode : 0 is successful, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)listenDataTranCompleteCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 配置快速同步完成 | Configuring Fast Sync Complete
 *  @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Listening callback (errorCode : 0 is successful, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)listenConfigFastSyncCompleteCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief GPS数据同步完成 | GPS data synchronization completed
 * @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Listening callback (errorCode : 0 is successful, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)listenGpsSyncCompleteCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 活动数据同步完成 | Activity data synchronization completed
 * @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Listening callback (errorCode : 0 is successful, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)listenActivitySyncCompleteCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 手环检查版本号 | Bracelet checks the version number
 * @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Listening callback (errorCode : 0 is successful, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)listenCheckUpdateReplyCommand:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 手环发送iot按钮 | Bracelet send iot buttons
 * @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str,index 对应按钮索引)
 * Listening callback (errorCode : 0 is successful, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
*/
+ (void)listenIotButtonCommand:(void(^_Nullable)(int errorCode,int index))callback;

/**
 * @brief 手环分段发送返回语音数据 | Bracelet send voice data in segments
 * @param stateCallback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str,state:语音状态)
 * Listening stateCallback (errorCode : 0 is successful, other values are wrong, you can get error code str according to IDOErrorCodeToStr,data:voice state)
 * state : 0 =>空闲 1=> 开始 2=> 停止 3=>超时 4=>断线 5=>登录状态 6=>开始 7=>app发起开始失败 8=>停止状态 9=>app发起结束失败
 * 10 =>按钮退出到主界面 11=>固件修改alexa设置的闹钟
 * 0 => idle 1=> start 2=> stop 3=> timeout 4=> disconnect 5=> login status 6=> start status  7=>start failure 8=> stop status 9=>app stop
 * 10 => button to exit the main interface
 * lostCallback 监听丢包率 lostSize 丢包个数，allSize 所有包数
 * @param completeCallback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str,data:语音文件数据)
 * Listening completeCallback (errorCode : 0 is successful, other values are wrong, you can get error code str according to IDOErrorCodeToStr,data:voice data)
 */
+ (void)listenVoiceOneItemDataCommand:(void(^_Nullable)(int state,int errorCode))stateCallback
                             lostData:(void(^_Nullable)(int lostSize,int allSize))lostCallback
                             complete:(void(^_Nullable)(NSData * _Nullable data))completeCallback;

/**
 * @brief 手环语音等待APP回复状态 | The bracelet's voice waits for the APP to reply
 * @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str,index 对应按钮索引)
 * callback 返回APP的登录状态 0：正常状态；1：未登录；2:网络断连; 3：未获取状态
 * Listening callback (errorCode : 0 is successful, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 * callback  return the login status of APP 0: normal; 1: Not logged in; 2: Network outage; 3: Not getting status
 */
+ (void)listenVoiceGetStateReplyCommand:(NSInteger(^_Nullable)(int errorCode))callback;

/**
 * @brief 手环状态改变 | Bracelet state change
 * @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Listening callback (errorCode : 0 is successful, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
*/
+ (void)listenStateChangeCommand:(void(^_Nullable)(int errorCode,IDOControlDataUpdateModel *_Nullable model))callback;

/**
 * @brief Alexa手环音量变化 | Alexa Bracelet state change
 * @param callback 监听回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Listening callback (errorCode : 0 is successful, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
*/
+ (void)listenAlexaStateChangeCommand:(void(^_Nullable)(int errorCode,IDOControlAlexaDataUpdateModel *_Nullable model))callback;


#pragma mark ======= progress Command =======

/**
 * @brief 健康数据同步进度 | Health data synchronization progress
 * @param callback 健康数据同步进度回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Health data synchronization progress callback (errorCode : 0 transmission success, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)healthSyncProgressCommand:(void(^_Nullable)(int progress,int errorCode))callback;

/**
 * @brief 闹钟数据同步进度 | Alarm data synchronization progress
 * @param callback 闹钟数据同步进度回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Alarm data synchronization progress callback (errorCode : 0 transmission success, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)alarmSyncProgressCommand:(void(^_Nullable)(int progress,int errorCode))callback;

/**
 * @brief 活动数据同步进度 | Activity data synchronization progress
 * @param callback 活动数据同步进度回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Activity data synchronization progress callback (errorCode : 0 transmission success, other values are errors, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)activitySyncProgressCommand:(void(^_Nullable)(int progress,int errorCode))callback;

/**
 * @brief 数据交换进度 手环->app | Data Exchange Progress Bracelet -> app
 * @param callback 数据交换进度回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Data exchange progress callback (errorCode: 0 transmission succeeded, other values are errors, error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)dataTranProgressCommand:(void(^_Nullable)(int progress,int errorCode))callback;

/**
 * @brief gps数据同步进度 | gps data synchronization progress
 * @param callback  gps数据同步进度回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * gps data synchronization progress callback (errorCode: 0 transmission success, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)gpsProgressCommand:(void(^_Nullable)(int progress,int errorCode))callback;

/**
 * @brief 数据交换进度 app->手环 | Data Exchange Progress app->Bracelet
 * @param callback  数据交换进度回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Data exchange progress callback (errorCode: 0 transmission succeeded, other values are errors, error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)appDataTranProgressCommand:(void(^_Nullable)(int progress,int errorCode))callback;

/**
 * @brief  配置同步进度 | Configure synchronization progress
 * @param callback 配置同步进度回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Configure synchronization progress callback (errorCode : 0 transmission succeeded, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)configSyncProgressCommand:(void(^_Nullable)(int progress,int errorCode))callback;

#pragma mark ======= data exchange Command =======

/**
 * @brief app 发起运动开始 | app starts the campaign
 * @param model IDODataExchangeModel (数据交换model, day|hour|minute|second|sportType|targetType|targetValue|forceStart 这些属性需要赋值)
 * IDODataExchangeModel (data exchange model, day|hour|minute|second|sportType|targetType|targetValue|forceStart These attributes need to be assigned)
 * @param startCallback 运动发起回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Motion initiated callback (errorCode : 0 transmission succeeded, other values are errors, error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)appStartSportCommand:(IDODataExchangeModel * _Nullable)model
               startCallback:(void (^_Nullable)(IDODataExchangeModel * _Nullable model,int errorCode))startCallback DEPRECATED_MSG_ATTRIBUTE("Method deprecated, use \"IDODataExchangeManager\"");

/**
 * @brief app 发起运动结束 | app initiates the end of the campaign
 * @param model IDODataExchangeModel 活动时间需要保持一致,才能停止活动不然无效,当前model对象为全局时,只要开始活动记录开始时间,
 * 结束时不需要再次给时间赋值,只需要给 durations|calories|distance|sportType|isSave 这些属性需要赋值
 * IDODataExchangeModel activity time needs to be consistent in order to stop the activity or it will be invalid. When the current model object is global,
 * just start the activity record start time. You don't need to assign values to the time at the end, just give durations|calories|distance|sportType|isSave
 * these properties need to be assigned.
 * @param appEndCallback 运动停止回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Motion stop callback (errorCode : 0 transfer succeeded, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)appEndSportCommand:(IDODataExchangeModel *_Nullable)model
            appEndcallback:(void (^_Nullable)(IDODataExchangeModel *  _Nullable model,int errorCode))appEndCallback DEPRECATED_MSG_ATTRIBUTE("Method deprecated, use \"IDODataExchangeManager\"");

/**
 * @brief app发起的运动 手环主动结束 | App-initiated sports bracelet ends actively
 * @param model IDODataExchangeModel 手环主动发起结束 APP需要给手环发送运动数据, durations|calories|distance|errorCode 这些属性需要赋值
 * IDODataExchangeModel The bracelet is actively launched. The APP needs to send motion data to the bracelet. durations|calories|distance|errorCode
 * These attributes need to be assigned.
 * @param appBleEndCallback 手环发起停止回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * The bracelet initiates a stop callback (errorCode: 0 is successfully transmitted, other values are incorrect, and error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)appBleEndReplyCommand:(IDODataExchangeModel *_Nullable)model
            appBleEndCallback:(void (^_Nullable)(IDODataExchangeModel *  _Nullable model,int errorCode))appBleEndCallback DEPRECATED_MSG_ATTRIBUTE("Method deprecated, use \"IDODataExchangeManager\"");


/**
 * @brief app发起运动暂停 | app initiates a motion pause
 * @param model IDODataExchangeModel 活动时间需要保持一致,才能暂停活动不然无效,当前model对象为全局时,只要开始活动记录开始时间,暂停时不需要再次给时间赋值,直接传入当前model
 * IDODataExchangeModel activity time needs to be consistent in order to pause activity or not, when the current model object is global,  As soon as you start the activity
 * record start time, you don't need to assign time to the timeout when you pause, you can directly pass in the current model.
 * @param pauseCallback 运动暂停回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Motion pause callback (errorCode : 0 transmission success, other values are errors, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)appPauseSportCommand:(IDODataExchangeModel *_Nullable)model
               pauseCallback:(void (^_Nullable)(IDODataExchangeModel *  _Nullable model,int errorCode))pauseCallback DEPRECATED_MSG_ATTRIBUTE("Method deprecated, use \"IDODataExchangeManager\"");



/**
 * @brief app发起的运动 手环主动暂停 | App-initiated sports bracelet active suspension
 * @param model IDODataExchangeModel 手环主动发起暂停 APP需要给手环发送运动数据, errorCode 这个属性需要赋值
 * IDODataExchangeModel The bracelet initiates a pause. The APP needs to send motion data to the bracelet. The errorCode attribute needs to be assigned.
 * @param appBlePauseCallback 手环发起暂停回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * The bracelet initiates a pause callback (errorCode: 0 is successfully transmitted, other values are errors, and error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)appBlePauseReplyCommand:(IDODataExchangeModel *_Nullable)model
            appBlePauseCallback:(void (^_Nullable)(IDODataExchangeModel *  _Nullable model,int errorCode))appBlePauseCallback DEPRECATED_MSG_ATTRIBUTE("Method deprecated, use \"IDODataExchangeManager\"");

/**
 * @brief app 发起运动恢复 | app initiates motion recovery
 * @param model IDODataExchangeModel 活动时间需要保持一致,才能恢复活动不然无效,当前model对象为全局时,只要开始活动记录开始时间,恢复时不需要再次给时间赋值,直接传入当前model
 * IDODataExchangeModel activity time needs to be consistent in order to restore activity or not, when the current model object is global,As soon as you start the activity
 * record start time, you don't need to assign time to the time when restoring, you can directly pass in the current model.
 * @param appRestoreCallback 运动恢复回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Motion recovery callback (errorCode : 0 transmission succeeded, other values are wrong, error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)appRestoreSportCommand:(IDODataExchangeModel * _Nullable)model
            appRestoreCallback:(void (^_Nullable)(IDODataExchangeModel *  _Nullable model,int errorCode))appRestoreCallback DEPRECATED_MSG_ATTRIBUTE("Method deprecated, use \"IDODataExchangeManager\"");

/**
 * @brief app发起的运动 手环主动恢复 | app-initiated sports bracelet active recovery
 * @param model IDODataExchangeModel 手环主动发起恢复 APP需要给手环发送运动数据, errorCode 这个属性需要赋值
 * IDODataExchangeModel The bracelet initiates recovery. The APP needs to send motion data to the bracelet. The errorCode attribute needs to be assigned.
 * @param appBleRestoreCallback 手环发起恢复回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * The bracelet initiates a recovery callback (errorCode : 0 is successfully transmitted, other values are incorrect, and error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)appBleRestoreReplyCommand:(IDODataExchangeModel *_Nullable)model
            appBleRestoreCallback:(void (^_Nullable)(IDODataExchangeModel *  _Nullable model,int errorCode))appBleRestoreCallback DEPRECATED_MSG_ATTRIBUTE("Method deprecated, use \"IDODataExchangeManager\"");

/**
 * @brief app发起数据交换过程 | app initiates the data exchange process
 * @param model IDODataExchangeModel 活动时间需要保持一致,才能发送活动数据不然无效,当前model对象为全局时,只要开始活动记录开始时间,发送活动数据时不需要再次给时间赋值,
 * 只需要给 status|duration|calories|distance 这些属性需要赋值
 * IDODataExchangeModel Activity time needs to be consistent in order to send active data or it is invalid. When the current model object is global, as long as the activity
 * record start time is started, it is not necessary to assign time to the event when sending the activity data, just to status|duration|calories|distance
 * These attributes need to be assigned.
 * @param appIngCallback 运动发送数据回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Motion sends data callback (errorCode : 0 transmission succeeded, other values are errors, error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)appIngSportCommand:(IDODataExchangeModel *_Nullable)model
            appIngCallback:(void (^_Nullable)(IDODataExchangeModel * _Nullable model,int errorCode))appIngCallback DEPRECATED_MSG_ATTRIBUTE("Method deprecated, use \"IDODataExchangeManager\"");

/**
 * @brief 手环发起运动开始 | The bracelet starts the campaign
 * @param model IDODataExchangeModel 只需要给 retCode 这个属性需要赋值
 * IDODataExchangeModel only needs to assign value to retCode property
 * @param bleStartCallback 手环发起运动开始回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * The bracelet initiates a motion start callback (errorCode : 0 is successfully transmitted, other values are wrong, and error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)bleStartSportCommand:(IDODataExchangeModel *_Nullable)model
            bleStartCallback:(void (^_Nullable)(IDODataExchangeModel * _Nullable model,int errorCode))bleStartCallback DEPRECATED_MSG_ATTRIBUTE("Method deprecated, use \"IDODataExchangeManager\"");

/**
 * @brief 手环发起运动开始 | The bracelet starts the campaign
 */
+ (void)bleStartSportCommand:(void (^_Nullable)(IDODataExchangeModel * _Nullable model, int errorCode))bleStartCallback;

/**
 * @brief 手环发起运动后，需要app告诉手环相关数据，比如gps状态等 | The bracelet starts the campaign
 * @param model IDODataExchangeModel 只需要给 retCode  operate 属性需要赋值
 */
+ (void)bleStartAppReplySportStateCommand:(IDODataExchangeModel *_Nullable)model;

/**
 * @brief 手环发起运动暂停 | The bracelet initiates a motion pause
 * @param model IDODataExchangeModel 只需要给 retCode 这个属性需要赋值
 * IDODataExchangeModel only needs to assign value to retCode property
 * @param blePauseCallback 手环发起运动暂停回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * The bracelet initiates a motion pause callback (errorCode : 0 is successfully transmitted, other values are incorrect, and error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)blePauseSportCommand:(IDODataExchangeModel *_Nullable)model
            blePauseCallback:(void (^_Nullable)(IDODataExchangeModel * _Nullable model,int errorCode))blePauseCallback DEPRECATED_MSG_ATTRIBUTE("Method deprecated, use \"IDODataExchangeManager\"");
/**
 * @brief 手环发起运动恢复 | Bracelet initiates sports recovery
 * @param model IDODataExchangeModel 只需要给 retCode 这个属性需要赋值
 * IDODataExchangeModel only needs to assign value to retCode property
 * @param bleRestoreCallback 手环发起运动恢复回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * The bracelet initiates a motion recovery callback (errorCode : 0 is successfully transmitted, other values are wrong, and error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)bleRestoreSportCommand:(IDODataExchangeModel *_Nullable)model
            bleRestoreCallback:(void (^_Nullable)(IDODataExchangeModel * _Nullable model,int errorCode))bleRestoreCallback DEPRECATED_MSG_ATTRIBUTE("Method deprecated, use \"IDOdataExchangeManager\"");

/**
 * @brief 手环发起运动结束 | The bracelet starts the campaign
 * @param model IDODataExchangeModel 只需要给 retCode 这个属性需要赋值
 * IDODataExchangeModel only needs to assign value to retCode property
 * @param bleEndCallback 手环发起运动结束回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * The bracelet initiates a motion end callback (errorCode : 0 is successfully transmitted, other values are errors, and error code str can be obtained according to IDOErrorCodeToStr)
 */
+ (void)bleEndSportCommand:(IDODataExchangeModel *_Nullable)model
            bleEndCallback:(void (^_Nullable)(IDODataExchangeModel * _Nullable model,int errorCode))bleEndCallback DEPRECATED_MSG_ATTRIBUTE("Method deprecated, use \"IDODataExchangeManager\"");
/**
 * @brief 手环发起运动发送数据 | The bracelet initiates a motion to send data
 * @param model IDODataExchangeModel 只需要给 distance 这个属性需要赋值
 * @param bleIngCallback 手环发起运动发送数据回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)bleIngSportCommand:(IDODataExchangeModel *_Nullable)model
            bleIngCallback:(void (^_Nullable)(IDODataExchangeModel * _Nullable model,int errorCode))bleIngCallback DEPRECATED_MSG_ATTRIBUTE("Method deprecated, use \"IDODataExchangeManager\"");
/**
 * @brief 获取一分钟的心率  | Get  heart rate for one minute
 * @param model IDODataExchangeModel 只需要给 distance 这个属性需要赋值
 * @param callback 手环发起运动发送数据回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)getOneMinuteHeartRateCommand:(IDODataExchangeModel *_Nullable)model
                            callback:(void (^_Nullable)(IDODataExchangeModel * _Nullable model,int errorCode))callback DEPRECATED_MSG_ATTRIBUTE("Method deprecated, use \"IDODataExchangeManager\"");


/**
 * @brief 活动结束后获取详情数据  | Obtain detailed data after the event
 * @param model IDODataExchangeModel 只需要给 distance 这个属性需要赋值
 * @param callback 手环发起运动发送数据回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)getEndV3ActivityDataCommand:(IDODataExchangeModel *_Nullable)model
                           callback:(void (^_Nullable)(IDODataExchangeModel * _Nullable model,int errorCode))callback DEPRECATED_MSG_ATTRIBUTE("Method deprecated, use \"IDODataExchangeManager\"");
@end
