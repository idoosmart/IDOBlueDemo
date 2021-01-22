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
 闹钟状态  0=>  无效 1=>  闹钟已修改
 Alarm state  0=>  invalid 1 => alarm has been modified
 */
@property (nonatomic,assign) NSInteger alarmState;
/**
固件过热异常告警  0=>  无效 1=>  过热警告
Alarm state  0=>  invalid 1 => alarm has been modified
*/
@property (nonatomic,assign) NSInteger overHeat;

@end

#pragma mark ==== 获取电池信息 model ====
@interface IDOGetDeviceBattInfoBluetoothModel : IDOBluetoothBaseModel
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
