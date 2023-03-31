//
//  IDOBasicBlueDataModel.h
//  IDOBlueProtocol
//
//  Created by hedongyang on 2020/5/13.
//  Copyright © 2020 何东阳. All rights reserved.
//

#if __has_include(<IDOBlueProtocol/IDOBlueProtocol.h>)
#else
#import "IDOBluetoothBaseModel.h"
#endif

@interface IDOBasicBlueDataModel : IDOBluetoothBaseModel

@end

#pragma mark ====  设置设备权限状态 model ====
@interface IDOSetPermissionsModel : IDOBluetoothBaseModel
/**
 0:相机权限
 */
@property (nonatomic,assign) NSInteger type;
/**
 是否开启
 */
@property (nonatomic,assign) BOOL isOpen;

@end

#pragma mark ====  获取BT配对开关状态 model ====
@interface IDOGetBtPairStateModel : IDOBluetoothBaseModel
/**
 bt连接状态
 */
@property (nonatomic,assign) BOOL btConnectState;
/**
 bt配对状态
 */
@property (nonatomic,assign) BOOL btPairState;
/**
  a2dp连接状态
 */
@property (nonatomic,assign) BOOL a2dpConnectState;
/**
 hfp连接状态
 */
@property (nonatomic,assign) BOOL hfpConnectState;

@end

#pragma mark ====  设置压力校准 model ====
@interface IDOSetStressCalibrationModel : IDOBluetoothBaseModel
/**
 压力分数(1~100)
 */
@property (nonatomic,assign) NSInteger stressScore;
/**
 0:开始校准设置 1：取消校准设置
 */
@property (nonatomic,assign) NSInteger status;
/**
  压力值 （设置不需要赋值，只为获取赋值）
 */
@property (nonatomic,assign) NSInteger stressValue;
/**
 阀值 （设置不需要赋值，只为获取赋值）
 */
@property (nonatomic,assign) NSInteger threshold;

@end

#pragma mark ==== 设置经期历史数据 item model ====
@interface IDOMenstrualHistoryDataItemModel : IDOBluetoothBaseModel
/**
 经期开始的年
 */
@property (nonatomic,assign) NSInteger year;
/**
 经期开始的月
 */
@property (nonatomic,assign) NSInteger month;
/**
 经期开始的日
 */
@property (nonatomic,assign) NSInteger day;
/**
 经期长度 单位天
 */
@property (nonatomic,assign) NSInteger menstrualDay;
/**
 周期长度 单位天
 */
@property (nonatomic,assign) NSInteger cycleDay;

@end

#pragma mark ==== 设置经期历史数据 model ====
@interface IDOMenstrualHistoryDataModel : IDOBluetoothBaseModel
/**
 平均经期长度
 */
@property (nonatomic,assign) NSInteger avgMenstrualDay;
/**
 平均周期长度
 */
@property (nonatomic,assign) NSInteger avgCycleDay;
/**
 个数 最多5个
 */
@property (nonatomic,assign) NSInteger itemsCount;
/**
 经期的历史数据集合
 */
@property (nonatomic,copy) NSArray <IDOMenstrualHistoryDataItemModel *>* items;

@end

#pragma mark ==== 设置alexa天气预报 item model ====
@interface IDOSetAlexaWeatherDataItemModel : IDOBluetoothBaseModel
/**
 日期
 */
@property (nonatomic,strong) NSString * dateStr;
/**
 天气状态
 */
@property (nonatomic,strong) NSString * weatherState;
/**
最小温度 (需要带单位)
 */
@property (nonatomic,copy) NSString * minTemperature;
/**
 最大温度 (需要带单位)
 */
@property (nonatomic,copy) NSString * maxTemperature;

@end

#pragma mark ==== 设置alexa天气预报 model ====
@interface IDOSetAlexaWeatherDataModel : IDOBluetoothBaseModel
/**
 当前温度
 */
@property (nonatomic,strong) NSString * currentTemperature;
/**
 当前地点名称
 */
@property (nonatomic,strong) NSString * locationName;
/**
 今天天气状态
 */
@property (nonatomic,strong) NSString * todayWeatherState;
/**
 今天最小温度 (需要带单位)
 */
@property (nonatomic,copy) NSString * minTemperature;
/**
 今天最大温度 (需要带单位)
 */
@property (nonatomic,copy) NSString * maxTemperature;
/**
 后七天的天气情况
 */
@property (nonatomic,copy) NSArray <IDOSetAlexaWeatherDataItemModel *>* futureWeathers;

@end

#pragma mark ==== 设置语音提醒 model ====
@interface IDOSetVoiceReminderItemModel : IDOBluetoothBaseModel
/**
 开关 | Switch
 */
@property (nonatomic,assign) BOOL isOpen;

/**
 年 | year
 */
@property (nonatomic,assign) NSInteger year;

/**
 月 | month
 */
@property (nonatomic,assign) NSInteger month;

/**
 日 | day
 */
@property (nonatomic,assign) NSInteger day;
/**
 时 | hour
 */
@property (nonatomic,assign) NSInteger hour;
/**
 分 | minute
 */
@property (nonatomic,assign) NSInteger minute;
/**
 秒 | second
 */
@property (nonatomic,assign) NSInteger second;
/**
 * 提醒ID  设置范围1-10
 * remind ID   Set the range to 1-10
 */
@property (nonatomic,assign) NSInteger remindId;
/**
 * 提醒消息 支持128字节
 * reminder message support 128 byte
 */
@property (nonatomic,strong) NSString * reminderStr;

@end

#pragma mark ==== 获取设备升级 model ====
@interface IDOGetDeviceUpdateStateModel : IDOBluetoothBaseModel
/**
 固件版本号
 firmware version
 */
@property (nonatomic,assign) NSInteger firmwareVersion;
/**
 升级状态，0是正常状态，1是升级状态
 upgrade status, 0 is the normal status, 1 is the upgrade status
 */
@property (nonatomic,assign) NSInteger updateState;

@end

#pragma mark ==== 获取Mtu model ====
@interface IDOGetMtuBlueInfoModel : IDOBluetoothBaseModel
/**
  蓝牙数据发送最大长度
  send blue data mtu length
 */

@property (nonatomic,assign) NSInteger sendMtu;
/**
 蓝牙数据接收最大长度
 recive blue data mtu length
 */
@property (nonatomic,assign) NSInteger receiveMtu;
@end

#pragma mark ==== 手环控制状态 model ====
@interface IDOControlDataUpdateModel : IDOBluetoothBaseModel
/**
 解绑状态  0=> 无效 1 => 手环已经解绑
 Unbind state 0=>  invalid 1 => bracelet has been unbound
 */
@property (nonatomic,assign) NSInteger unbindState;
/**
 心率模式状态  0=> 无效 1 => 心率模式改变
 Heart rate mode status 0=> invalid 1 => heart rate mode change
 */
@property (nonatomic,assign) NSInteger hrModeState;
/**
 血氧状态  0=> 无效 1 => 血氧产生数据改变
 spo2 status 0=> invalid 1 => spo2 data  change
 */
@property (nonatomic,assign) NSInteger spo2State;
/**
 压力状态  0=> 无效 1 => 压力产生数据改变
 pressure status 0=> invalid 1 => pressure data  change
 */
@property (nonatomic,assign) NSInteger pressureState;
/**
 Alexa识别状态 0=> 无效 1 => Alexa识别过程中退出
 Alexa status 0=> invalid 1 => Exit during Alexa recognition process
 */
@property (nonatomic,assign) NSInteger alexaState;
/**
 恢复出厂设置状态 0=> 无效 1 => 固件恢复出厂设置
 reset status 0=> invalid 1 => reset change
 */
@property (nonatomic,assign) NSInteger resetState;
/**
app需要进入相机界面  0=>  无效 1=>  app进入相机
 App needs to enter the camera interface 0=> invalid 1=> app enters the camera
*/
@property (nonatomic,assign) NSInteger intoCamera;
/**
 sos事件通知  0=>  无效 1=>  发起sos请求
 sos event notification 0=> invalid 1=> initiate a sos request
*/
@property (nonatomic,assign) NSInteger callForHelp;
/**
 alexa闹钟状态  0=>  无效 1=>  alexa闹钟已修改
 alexa Alarm state  0=>  invalid 1 => alexa alarm has been modified
 */
@property (nonatomic,assign) NSInteger alexaAlarmState;
/**
 闹钟状态  0=>  无效 1=>  闹钟已修改
 Alarm state  0=>  invalid 1 => alarm has been modified
 */
@property (nonatomic,assign) NSInteger alarmState;
/**
固件过热异常告警  0=>  无效 1=>  过热警告
Alarm state  0=>  invalid 1 => alarm has been modified
*/
@property (nonatomic,assign) NSInteger overHeat;
/**
 亮屏参数有修改  0=>  无效 1=>  亮屏修改
 Bright screen parameters have been modified 0=> invalid 1=> bright screen modification
*/
@property (nonatomic,assign) NSInteger brightScreenState;
/**
 抬腕参数有修改  0=>  无效 1=>  抬腕修改
 Wrist lift parameters have been modified 0=> Invalid 1=> Wrist lift modification
*/
@property (nonatomic,assign) NSInteger handUpState;
/**
 勿擾模式获取  0=>  无效 1=>  勿擾模式修改
 Get Do Not Disturb Mode 0=> Invalid 1=> Modify Do Not Disturb Mode
*/
@property (nonatomic,assign) NSInteger noDisturbState;
/**
 手机音量下调  0=>  无效 1=>  手机音量下调修改
 Phone volume down 0=> invalid 1=> phone volume down to modify
*/
@property (nonatomic,assign) NSInteger volumeDownState;
/**
 固件错误码返回
 01: ACC  加速度、02: PPG  心率 、03: TP   触摸 、04: FLASH 、05: 过热（PPG）、06: 气压 、07: GPS、08: 地磁
 01: ACC acceleration, 02: PPG heart rate, 03: TP touch, 04: FLASH, 05: overheating (PPG), 06: air pressure, 07: GPS, 08: geomagnetism
 */
@property (nonatomic,assign) NSInteger errorIndex;
/**
 固件主动通知类型 | Firmware Proactive Notification Type
 具体类型，直接查看 IDO_LISTEN_TYPE
 */
@property (nonatomic,assign) IDO_LISTEN_TYPE dataType;
/**
 1  闹钟已经修改
 2  固件过热异常告警
 4  亮屏参数有修改（02 b0）
 8  抬腕参数有修改（02 b1）
 16 勿擾模式获取（02 30）
 32 手机音量的下发（03  0xE3）（删除），app音量修改，直接下发
 */
@property (nonatomic,assign) NSInteger notifyType;

@end

#pragma mark ==== alexa状态 model ====
@interface IDOControlAlexaDataUpdateModel : IDOBluetoothBaseModel
@property (nonatomic,assign) NSInteger notifyType;
@property (nonatomic,assign) NSInteger value;
@end

#pragma mark ==== 获取电池信息 model ====
@interface IDOGetDeviceBattInfoBluetoothModel : IDOBluetoothBaseModel
/**
 1:正常模式（非省电模式） 2：省电模式
 __IDO_FUNCTABLE__.funcTable31Model.getBatteryMode 功能表支持才有效
 */
@property (nonatomic,assign) NSInteger mode;
/**
 电压，毫伏
 voltage
 */
@property (nonatomic,assign) NSInteger voltage;
/**
状态,0 未充电,1正在充电，2充满
status 0 uncharged,1 being charged, 2 full
*/
@property (nonatomic,assign) NSInteger status;
/**
 电量等级0-100
 level 0-100
 */
@property (nonatomic,assign) NSInteger level;
/**
上次充电时间 年
Last charging time year
*/
@property (nonatomic,assign) NSInteger lastChargingYear;
/**
上次充电时间 月
Last charging time month
*/
@property (nonatomic,assign) NSInteger lastChargingMonth;
/**
上次充电时间 天
Last charging time day
*/
@property (nonatomic,assign) NSInteger lastChargingDay;
/**
上次充电时间 时
Last charging time  hour
*/
@property (nonatomic,assign) NSInteger lastChargingHour;
/**
上次充电时间 分
Last charging time minute
*/
@property (nonatomic,assign) NSInteger lastChargingMinute;
/**
上次充电时间 秒
Last charging time second
*/
@property (nonatomic,assign) NSInteger lastChargingSecond;

@end

#pragma mark ==== 获取字库版本信息 model ====
@interface IDOGetFlashBinInfoBluetoothModel : IDOBluetoothBaseModel
/**
 状态 0x00正常,0x01 字库无效 校验错误,0x02 版本不匹配
 Status 0x00 is normal,0x01 byte library invalid check error,0x02 version does not match
 */
@property (nonatomic,assign) NSInteger status;
/**
  字库版本
  flash version
 */
@property (nonatomic,assign) NSInteger flashVersion;
/**
 匹配版本号,固件需要的字库版本号
 Match the version number, the version number of the font required by the firmware
 */
@property (nonatomic,assign) NSInteger matchVersion;
/**
 字库校验码
 check code 
 */
@property (nonatomic,assign) NSInteger checkCode;

@end

#pragma mark ==== 获取错误日志记录 model ====
@interface IDOGetErrorLogBluetoothModel : IDOBluetoothBaseModel
/**
 操作类型 ：0x00 查询 , 0x01 清除记录
 Operation type: 0x00 query , 0x01 to clear the record
 */
@property (nonatomic,assign) NSInteger type;
/**
 0x0 正常, 0x01 硬错误(Hard Faul), 0x02 看门狗服务, 0x03 断言复位, 0x04 掉电服务, 0x05 其他异常
 0x0 normal, 0x01 Hard error (Hard Faul), 0x02 watchdog service, 0x03 assertion reset, 0x04 power down service, 0x05 other exceptions
 */
@property (nonatomic,assign) NSInteger resetFlag;
/**
 硬件错误码 0x00正常, 0x01 加速度错误, 0x02 心率错误, 0x03 TP错误, 0x04 flash错误
 Hardware error code 0x00 normal, 0x01 acceleration error, 0x02 heart rate error, 0x03 TP error, 0x04 flash error
 */
@property (nonatomic,assign) NSInteger hwError;

@end

#pragma mark ====  手环检查版本号 model ====
@interface IDOCheckUpdateBluetoothModel:IDOBluetoothBaseModel
/**
 * app 响应状态 | flag code
 * 0x00 : 已经是最新版本；0x01 ：有新版本；0x02 ：网络错误；0x03 ：其他错误
 * 0x00 : it is the latest version; 0x01: there are new versions; 0x02: network error; 0x03: other errors
 */
@property (nonatomic,assign) NSInteger flagCode;

/**
 固件最新版本号 | new version
 */
@property (nonatomic,assign) NSInteger newVersion;

@end

#pragma mark ==== 获取5个心率区间交换数据 ====
@interface IDOGetFiveHrReplyInfoBluetoothModel:IDOBluetoothBaseModel
/**
 燃烧脂肪 | Threshold for burning fat
 */
@property (nonatomic,assign) NSInteger burnFat;

/**
 有氧运动 | Aerobic threshold
 */
@property (nonatomic,assign) NSInteger aerobic;

/**
 极限运动 | Limit threshold
 */
@property (nonatomic,assign) NSInteger limitValue;

/**
 热身运动 | Warm-up
 */
@property (nonatomic,assign) NSInteger warmUp;

/**
 无氧运动 | Anaerobic exercise
 */
@property (nonatomic,assign) NSInteger anaerobic;

@end

#pragma mark ==== 获取GPS状态model ====
@interface IDOGetGpsStatusBluetoothModel:IDOBluetoothBaseModel
/**
 * GPS 运行状态 0 没有运行,1 正在搜星,2 为正在跟踪
 * GPS running status 0 No running, 1 is searching for stars, 2 is tracking
 */
@property (nonatomic,assign) NSInteger gpsRunStatus;

/**
 * AGPS 是否有效,有效期剩余小时,非0为有效,
 * AGPS is valid, the remaining period is valid, non-zero is valid,
 */
@property (nonatomic,assign) NSInteger isAgpsVaild;

@end

#pragma mark ==== 常用联系人的模型 ====
@interface IDOSetAllContactItemModel:IDOBluetoothBaseModel
//电话号码
@property (nonatomic,copy)   NSString * phone;
//名字
@property (nonatomic,copy)   NSString * name;

@end

#pragma mark ==== 同步协议蓝牙通话常用联系人 ====
@interface IDOSetSyncAllContactModel:IDOBluetoothBaseModel
//年份
@property (nonatomic,assign) NSInteger year;
//月份
@property (nonatomic,assign) NSInteger month;
//日
@property (nonatomic,assign) NSInteger day;
//时
@property (nonatomic,assign) NSInteger hour;
//分
@property (nonatomic,assign) NSInteger minute;
//秒
@property (nonatomic,assign) NSInteger second;
//联系人个数
@property (nonatomic,assign) NSInteger contactItemNum;
//联系人集合 ｜ alarm items
@property (nonatomic,copy) NSArray <IDOSetAllContactItemModel *>* items;

@end

#pragma mark ==== 重启 ====
@interface IDOSetRebootModel:IDOBluetoothBaseModel
/*
 0x00:默认 整个设备重启
 0x01:设备蓝牙重启 需要功能表支持(__IDO_FUNCTABLE__.funcTable29Model.reseDeviceBluetooth)
 */
@property (nonatomic,assign) NSInteger type;

@end
