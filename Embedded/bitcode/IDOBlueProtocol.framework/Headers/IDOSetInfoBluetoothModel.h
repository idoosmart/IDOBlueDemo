//
//  IDOSetBuletoothModel.h
//  VeryfitSDK
//
//  Created by hedongyang on 2018/6/13.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#if __has_include(<IDOBluetoothInternal/IDOBluetoothInternal.h>)
#elif __has_include(<IDOBlueProtocol/IDOBlueProtocol.h>)
#else
#import "IDOBluetoothBaseModel.h"
#endif

#pragma mark ====  设置喝水提醒 model ====
@interface IDOSetDrinkReminderModeBluetoothModel:IDOBluetoothBaseModel
/**
 喝水提醒开关 | drink water reminder
 */
@property (nonatomic,assign) BOOL onOff;
/**
 提醒间隔,单位分钟 | interval (unit minutes)
 */
@property (nonatomic,assign) NSInteger interval;
/**
 开始时间（时） | start time (hours)
 */
@property (nonatomic,assign) NSInteger startHour;
/**
 开始时间（分） | start time (minutes)
 */
@property (nonatomic,assign) NSInteger startMinute;
/**
 结束时间 （时） | end time (hours)
 */
@property (nonatomic,assign) NSInteger endHour;
/**
 结束时间 （分） | end time (minutes)
 */
@property (nonatomic,assign) NSInteger endMinute;
/**
 * 重复集合 [星期一、星期二、星期三、星期四、星期五、星期六、星期日]
 * Repeat collection [monday,tuesday,wednesday,thursday,friday,saturday,sunday]
 */
@property (nonatomic,strong)NSArray<NSNumber *> * repeat;
/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOSetDrinkReminderModeBluetoothModel
 */
+ (__kindof IDOSetDrinkReminderModeBluetoothModel *)currentModel;
@end

#pragma mark ====  设置心率开关同步 model ====
@interface IDOSetV3HeartRateModeBluetoothModel:IDOBluetoothBaseModel
/**
 * 心率模式 0:关闭心率监测功能 1:手动模式 2:自动模式 3:持续监测（默认：自动模式）
 * Heart Rate Mode 0: Turn off heart rate monitoring function 1: Manual mode 2: Auto mode 3:Continuously monitor(Default: Auto mode)
 */
@property (nonatomic,assign) NSInteger modeType;
/**
 * 更新时间unix 时间戳,秒级  (eg 14442361933)
 * Update time Unix timestamp, in seconds
 */
@property (nonatomic,copy) NSString * updateTime;
/**
 是否有相隔时间 | Is there a time interval?
 */
@property (nonatomic,assign) BOOL isHasTimeRange;
/**
 开始 (时) | Start (hours)
 */
@property (nonatomic,assign) NSInteger  startHour;
/**
 开始 (分) | Start (minutes)
 */
@property (nonatomic,assign) NSInteger  startMinute;
/**
 结束 (时) | End (hours)
 */
@property (nonatomic,assign) NSInteger  endHour;
/**
 结束 (分) | End (minutes)
 */
@property (nonatomic,assign) NSInteger  endMinute;
/**
 测量间隔,单位分钟 | measurement Interval,unit:minutes
 */
@property (nonatomic,assign) NSInteger  measurementInterval;
/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOSetV3HeartRateModeBluetoothModel
 */
+ (__kindof IDOSetV3HeartRateModeBluetoothModel *)currentModel;
@end

#pragma mark ====  设置运动开关 model ====
@interface IDOSetActivitySwitchBluetoothModel:IDOBluetoothBaseModel
/**
 自动识别运动类型开关 | sport type on Off
 */
@property (nonatomic,assign) BOOL sportTypeOnOff DEPRECATED_MSG_ATTRIBUTE("this attribute is discarded");
/**
 自动识别走路开关 | auto identify sport walk
 */
@property (nonatomic,assign) BOOL sportWalkOnOff;
/**
 自动识别跑步开关 | auto identify sport run
 */
@property (nonatomic,assign) BOOL sportRunOnOff;
/**
 自动识别自行车开关 | auto identify sport bicycle
 */
@property (nonatomic,assign) BOOL sportBicycleOnOff;
/**
 运动自动暂停开关 | auto pause on off
 */
@property (nonatomic,assign) BOOL autoPauseOnOff;
/**
 结束提醒开关 | end remind on off
 */
@property (nonatomic,assign) BOOL endRemindOnOff;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOSetActivitySwitchBluetoothModel
 */
+ (__kindof IDOSetActivitySwitchBluetoothModel *)currentModel;

@end


#pragma mark ====  设置血氧开关控制 model ====
@interface IDOSetSpo2SwitchBluetoothModel:IDOBluetoothBaseModel
/**
 开关 | on off
 */
@property (nonatomic,assign) BOOL onOff;

/**
 开始时间 （时） | start hour
 */
@property (nonatomic,assign) NSInteger startHour;

/**
 开始时间 （分） | start minute
 */
@property (nonatomic,assign) NSInteger startMinute;

/**
 结束时间 （时） | end hour
 */
@property (nonatomic,assign) NSInteger endHour;

/**
 结束时间 （分） | end minute
 */
@property (nonatomic,assign) NSInteger endMinute;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOSetSpo2SwitchBluetoothModel
 */
+ (__kindof IDOSetSpo2SwitchBluetoothModel *)currentModel;

@end

#pragma mark ====  设置呼吸训练 model ====
@interface IDOSetBreatheTrainBluetoothModel:IDOBluetoothBaseModel
/**
 每分钟呼吸次数 | Breaths per minute
 */
@property (nonatomic,assign) NSInteger frequency;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOSetBreatheTrainBluetoothModel
 */
+ (__kindof IDOSetBreatheTrainBluetoothModel *)currentModel;
@end

#pragma mark ====  设置走动提醒 model ====
@interface IDOSetWalkReminderBluetoothModel:IDOBluetoothBaseModel
/**
 走动提醒开关 | Walking reminder switch
 */
@property (nonatomic,assign) BOOL onOff;
/**
 目标步数 | goal step
 */
@property (nonatomic,assign) NSInteger goalStep;
/**
 开始时间（时） | start time (hours)
 */
@property (nonatomic,assign) NSInteger startHour;
/**
 开始时间（分） | start time (minutes)
 */
@property (nonatomic,assign) NSInteger startMinute;
/**
 结束时间 （时） | end time (hours)
 */
@property (nonatomic,assign) NSInteger endHour;
/**
 结束时间 （分） | end time (minutes)
 */
@property (nonatomic,assign) NSInteger endMinute;
/**
 * 重复集合 [星期一、星期二、星期三、星期四、星期五、星期六、星期日]
 * Repeat collection [monday,tuesday,wednesday,thursday,friday,saturday,sunday]
 */
@property (nonatomic,strong)NSArray<NSNumber *> * repeat;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOSetWalkReminderBluetoothModel
 */
+ (__kindof IDOSetWalkReminderBluetoothModel *)currentModel;

@end
#pragma mark ====  设置经期提醒 model ====
@interface IDOSetMenstruationRemindBluetoothModel:IDOBluetoothBaseModel
/**
 开始日提醒 提前天数 | Start Day Reminder
 */
@property (nonatomic,assign) NSInteger startDay;
/**
 排卵日提醒 提前天数 | Ovulation Day Reminder
 */
@property (nonatomic,assign) NSInteger ovulationDay;
/**
 提醒时间 （时） | Reminder time (hours)
 */
@property (nonatomic,assign) NSInteger hour;
/**
 提醒时间 （分） | Reminder time (minutes)
 */
@property (nonatomic,assign) NSInteger minute;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOSetMenstruationRemindBluetoothModel
 */
+ (__kindof IDOSetMenstruationRemindBluetoothModel *)currentModel;

@end

#pragma mark ====  设置经期 model ====
@interface IDOSetMenstruationInfoBluetoothModel:IDOBluetoothBaseModel
/**
 开关 | onoff
 */
@property (nonatomic,assign) BOOL onOff;
/**
 经期长度 | length of menstruation
 */
@property (nonatomic,assign) NSInteger menstrualLength;
/**
 经期周期 | Menstrual cycle
 */
@property (nonatomic,assign) NSInteger menstrualCycle;
/**
 最近经期年份 | Recent menstrual years
 */
@property (nonatomic,assign) NSInteger lastMenstrualYear;
/**
 最近经期月份 | Recent menstrual months
 */
@property (nonatomic,assign) NSInteger lastMenstrualMonth;
/**
 最近经期日期 | Recent menstrual date
 */
@property (nonatomic,assign) NSInteger lastMenstrualDay;
/**
 排卵日的间隔 | ovulation interval day
 */
@property (nonatomic,assign) NSInteger ovulationIntervalDay;
/**
 经期前一天 | | The day before the menstrual period
 */
@property (nonatomic,assign) NSInteger ovulationBeforeDay;
/**
 经期后一天 | | One day after menstruation
 */
@property (nonatomic,assign) NSInteger ovulationAfterDay;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOSetMenstruationInfoBluetoothModel
 */
+ (__kindof IDOSetMenstruationInfoBluetoothModel *)currentModel;

@end

#pragma mark ==== 绑定model ====
@interface IDOSetBindingInfoBluetoothModel:IDOBluetoothBaseModel
/**
 授权码长度 | Authorization code length
 */
@property (nonatomic,assign) NSUInteger authLength;

/**
 授权码 | Authorization code
 */
@property (nonatomic,copy) NSString * authCode;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象 (只有在授权绑定才会存储数据)
 * Query the database, if the query does not initialize the new model object (only the authorization binding will store the data)
 * @return IDOSetBindingInfoBluetoothModel
 */
+ (__kindof IDOSetBindingInfoBluetoothModel *)currentModel;
@end

#pragma mark ==== 设置设置睡眠时间段model ====
@interface IDOSetSleepPeriodInfoBluetoothModel:IDOBluetoothBaseModel

/**
 睡眠开关 | Sleep switch
 */
@property (nonatomic,assign) BOOL OnOff;

/**
 开始 (时) | Start (hours)
 */
@property (nonatomic,assign) NSInteger startHour;

/**
 开始 (分) | Start (minutes)
 */
@property (nonatomic,assign) NSInteger startMinute;

/**
 结束 (时) | End (hours)
 */
@property (nonatomic,assign) NSInteger endHour;

/**
 结束 (分) | End (minutes)
 */
@property (nonatomic,assign) NSInteger endMinute;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象 | Query the database, if the query does not initialize a new model object
 * @return IDOSetSleepPeriodInfoBluetoothModel
 */
+ (__kindof IDOSetSleepPeriodInfoBluetoothModel *)currentModel;
@end

#pragma mark ==== 设置血压测量指令model ====
@interface IDOSetBpMeasureInfoBluetoothModel:IDOBluetoothBaseModel

/**
 * 参数标志 0x01:开始测量，0x02:结束测量，0x03:获得血压数据
 * Parameter flag 0x01: Start measurement, 0x02: End measurement, 0x03: Obtain blood pressure data
 */
@property (nonatomic,assign) NSInteger flag;

/**
 * 返回状态 0x00:不支持，0x01:正在测量，0x02:测量成功 0x03:测量失败 0x04:设备正在运动模式
 * Return status 0x00: Not supported, 0x01: Positive measurement, 0x02: Measurement success 0x03: Measurement failure 0x04: Device is in motion mode
 */
@property (nonatomic,assign) NSInteger status;

/**
 高压(收缩压) | High pressure (systolic pressure)
 */
@property (nonatomic,assign) NSInteger systolicBp;

/**
 低压(舒张压) | Low pressure (diastolic pressure)
 */
@property (nonatomic,assign) NSInteger diastolicBp;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOSetBpMeasureInfoBluetoothModel
 */
+ (__kindof IDOSetBpMeasureInfoBluetoothModel *)currentModel;
@end

#pragma mark ==== 设置表盘参数model ====
@interface IDOSetWatchDiaInfoBluetoothModel:IDOBluetoothBaseModel

/**
 表盘ID | Dial ID
 */
@property (nonatomic,assign) NSInteger dialId;

/**
 * @brief  查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOSetWatchDiaInfoBluetoothModel
 */
+ (__kindof IDOSetWatchDiaInfoBluetoothModel *)currentModel;
@end

#pragma mark ==== 设置马达参数model ====
@interface IDOSetStartMotorInfoBluetoothModel:IDOBluetoothBaseModel

/**
 马达状态 | Motor status
 */
@property (nonatomic,assign) NSInteger status;

/**
 马达超时时长 | Motor timeout duration
 */
@property (nonatomic,assign) NSInteger timeout;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOSetStartMotorInfoBluetoothModel
 */
+ (__kindof IDOSetStartMotorInfoBluetoothModel *)currentModel;
@end

#pragma mark ==== 设置传感器实时数据model ====
@interface IDOSetRealTimeSensorDataInfoBluetoothModel:IDOBluetoothBaseModel

/**
  未知传感器状态 | Unknown sensor status
 */
@property (nonatomic,assign) NSInteger gsensorStatus;

/**
 心率传感器状态 | Heart Rate Sensor Status
 */
@property (nonatomic,assign) NSInteger heartRateSensorStatus;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOSetRealTimeSensorDataInfoBluetoothModel
 */
+ (__kindof IDOSetRealTimeSensorDataInfoBluetoothModel *)currentModel;
@end

#pragma mark ==== 设置连接参数信息model ====
@interface IDOSetConnParamInfoBluetoothModel:IDOBluetoothBaseModel

/**
 连接模式 | Connection mode
 */
@property (nonatomic,assign) NSInteger mode;

/**
 修改快速模式连接间隔 | Modify Quick Mode Connection Interval
 */
@property (nonatomic,assign) NSInteger modifConnParam;

/**
 最大间隔 | Maximum interval
 */
@property (nonatomic,assign) NSInteger maxInterval;

/**
 最小间隔 | Minimum interval
 */
@property (nonatomic,assign) NSInteger minInterval;

/**
 延迟 | Delay
 */
@property (nonatomic,assign) NSInteger slaveLatency;

/**
 连接超时 | Connection timeout
 */
@property (nonatomic,assign) NSInteger connTimeout;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOSetConnParamInfoBluetoothModel
 */
+ (__kindof IDOSetConnParamInfoBluetoothModel *)currentModel;
@end

#pragma mark ==== 设置GPS控制信息model ====
@interface IDOSetGpsControlInfoBluetoothModel:IDOBluetoothBaseModel

/**
 1: 控制 , 2: 查询 | 1: Control, 2: Query
 */
@property (nonatomic,assign) NSInteger operate;

/**
 * 0x01 开启log,0x02 关闭log,0x03 agps写入,0x04 agps 擦除,0x05 gps_fw 写入
 * 0x01 turns on log, 0x02 turns off log, 0x03 agps writes, 0x04 agps erases, 0x05 gps_fw writes
 */
@property (nonatomic,assign) NSInteger type;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOSetGpsControlInfoBluetoothModel
 */
+ (__kindof IDOSetGpsControlInfoBluetoothModel *)currentModel;
@end

#pragma mark ==== 设置GPS信息model ====
@interface IDOSetGpsConfigInfoBluetoothModel:IDOBluetoothBaseModel

/**
 0x01 冷启动,0x02 热启动  默认2 | 0x01 Cold Start, 0x02 Hot  Start Default 2
 */
@property (nonatomic,assign) NSInteger startMode;

/**
 * 操作模式,1为正常;2为低功耗;4为Balance,5为1PPS 默认1
 * Operation mode, 1 is normal; 2 is low power consumption; 4 is Balance, 5 is 1PPS   default 1
 */
@property (nonatomic,assign) NSInteger gsopOperationMode;

/**
 定位周期,默认1000 1s | Positioning period, default 1000 1s
 */
@property (nonatomic,assign) NSInteger gsopCycleMs;

/**
 * 定位星mode,1为GPS,2为GLONASS,3为1为GPS + GLONASS 默认1
 * Positioning star mode, 1 is GPS, 2 is GLONASS, 3 is 1 for GPS + GLONASS  Default 1
 */
@property (nonatomic,assign) NSInteger gnsValue;

/**
 年 | year
 */
@property (nonatomic,assign) NSInteger year;

/**
 月 | Month
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
 秒 | seconds
 */
@property (nonatomic,assign) NSInteger second;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOSetGpsConfigInfoBluetoothModel
 */
+ (__kindof IDOSetGpsConfigInfoBluetoothModel *)currentModel;
@end

#pragma mark ==== 设置屏幕亮度model ====
@interface IDOSetScreenBrightnessInfoBluetoothModel:IDOBluetoothBaseModel
/**
 屏幕亮度级别 (1-100) | Screen brightness level (1-100)
 */
@property (nonatomic,assign) NSInteger levelValue;
/**
 是否用户调节 | is manual
 */
@property (nonatomic,assign) BOOL isManual;
/**
 * 0x00关闭自动调整,0x01 使用环境光传感器,0x02,夜间自动调整亮度,0x03 夜间降亮度使用设置的时间
 * 0x00 turns off automatic adjustment,0x01 USES ambient light sensor,
 * 0x02, automatic adjustment of brightness at night,0x03 set time for reducing brightness at night
 */
@property (nonatomic,assign) NSInteger mode;
/**
 * 夜间自动亮度调整 0x00,无效,由固件定义,0x01关闭,0x02,夜间自动调整亮度,0x03 夜间降亮度使用设置的时间
 * Automatic overnight brightness adjustment 0x00, invalid, as defined by firmware,0x01 is off,0x02,
 * automatic night brightness adjustment,0x03 night brightness reduction USES the set time
 */
@property (nonatomic,assign) NSInteger autoAdjustNight;
/**
 开始 时钟 | start hour
 */
@property (nonatomic,assign) NSInteger startHour;
/**
 开始 分钟 | start minute
 */
@property (nonatomic,assign) NSInteger startMinute;
/**
 结束 时钟 | end hour
 */
@property (nonatomic,assign) NSInteger endHour;
/**
 结束 分钟 | end minute
 */
@property (nonatomic,assign) NSInteger endMinute;
/**
 夜间亮度 (realme项目) | night level
 */
@property (nonatomic,assign) NSInteger nightLevel;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOSetScreenBrightnessInfoBluetoothModel
 */
+ (__kindof IDOSetScreenBrightnessInfoBluetoothModel *)currentModel;
@end

#pragma mark ==== 设置天气数据model ====
@interface IDOSetWeatherDataInfoBluetoothModel:IDOBluetoothBaseModel

/**
 * 天气预报更新的时间戳 time interval since 1970 (如:1444361933)
 * Time stamp of weather forecast update time interval since 1970 (eg 14442361933)
 */
@property (nonatomic,copy) NSString * timeStr;

/**
 今天平均温度 | Average temperature today
 */
@property (nonatomic,assign) NSInteger todayTemp;

/**
 * 天气类型 | Weather type
 * 天气情况(0:其他， 1:晴， 2:多云， 3:阴，4:雨，5:暴雨，
 * 6:雷阵雨， 7:雪， 8:雨夹雪，9:台风， 10:沙尘暴, 11:夜 间晴，
 * 12:夜间多云， 13:热， 14:冷， 15:清风， 16:大风， 17:雾霭，18:阵雨, 19:多云转晴)
 * weather conditions (0: others, 1: sunny, 2: cloudy, 3: cloudy, 4: rain, 5: rainstorm,
 * 6: thunderstorm, 7: snow, 8: sleet, 9: typhoon, 10: sandstorm, 11: night clear,
 * 12: cloudy night, 13: hot, 14: cold, 15: breezy, 16: blustery, 17: mist, 18: showers, 19: cloudy to clear)
 */
@property (nonatomic,assign) NSInteger todayType;

/**
 今天最高温度 | Today's highest temperature
 */
@property (nonatomic,assign) NSInteger todayMaxTemp;

/**
 今天最小温度 | Today's minimum temperature
 */
@property (nonatomic,assign) NSInteger todayMinTemp;

/**
 湿度 | Humidity
 */
@property (nonatomic,assign) NSInteger humidity;

/**
 紫外线强度 | UV intensity
 */
@property (nonatomic,assign) NSInteger todayUvIntensity;

/**
 空气污染指数 | Air Pollution Index
 */
@property (nonatomic,assign) NSInteger todayAqi;

/**
 * 后三天天的天气集合  @{@"type":@(0),@"maxTemp":@(0),@"minTemp":@(0)}
 * Weather collection for the last three days @{@"type":@(0),@"maxTemp":@(0),@"minTemp":@(0)}
 */
@property (nonatomic,strong) NSArray<NSDictionary*>* future;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOSetWeatherDataInfoBluetoothModel
 */
+ (__kindof IDOSetWeatherDataInfoBluetoothModel *)currentModel;
@end

#pragma mark ==== 设置运动快捷模式排序model ====

@interface IDOSetSportSortingItemModel:NSObject

/**
 * 排序索引 index //排序,从1、2、3、4....,0:无效
 * Sort index // sort from 1, 2, 3, 4... , 0: invalid
 */
@property (nonatomic,assign) NSInteger index;

/**
 * 运动模式 | Sport mode
 * 0:无，1:走路，2:跑步，3:骑行，4:徒步，5:游泳，6:爬山，7:羽毛球，8:其他，
 * 9:健身，10:动感单车，11:椭圆机，12:跑步机，13:仰卧起坐，14:俯卧撑，15:哑铃，16:举重，
 * 17:健身操，18:瑜伽，19:跳绳，20:乒乓球，21:篮球，22:足球 ，23:排球，24:网球，
 * 25:高尔夫球，26:棒球，27:滑雪，28:轮滑，29:跳舞，48:户外跑步，49:室内跑步，50:户外骑行，51:室内骑行，
 * 52:户外走路，53:室内走路，54:泳池游泳，55:开放水域游泳，56:椭圆机，57:划船机，58:高强度间歇训练法，59:板球运动
 * 0: none, 1: walk, 2: run, 3: ride, 4: hike, 5: swim, 6: climb, 7: badminton, 8: others,
 * 9: fitness, 10: spinning, 11: elliptical, 12: treadmill, 13: sit-ups, 14: push-ups, 15: dumbbells, 16: weightlifting,
 * 17: aerobics, 18: yoga, 19: jump rope, 20: table tennis, 21: basketball, 22: football, 23: volleyball, 24: tennis,
 * 25: golf, 26: baseball, 27: skiing, 28: roller skating, 29: dancing，48: outdoor running, 49: indoor running, 50: outdoor cycling, 51: indoor cycling,
 * 52: outdoor walking, 53: indoor walking, 54: pool swimming, 55: open water swimming, 56: elliptical machine, 57: rowing machine, 58: high-intensity interval training
 * 59:cricket
 */
@property (nonatomic,assign) NSInteger type;

@end

@interface IDOSetSportSortingInfoBluetoothModel:IDOBluetoothBaseModel

/**
 运动模式排序集合最多8个 | Sports mode sort set up to 8
 */
@property (nonatomic,strong)NSArray <IDOSetSportSortingItemModel *>* sportSortingItems;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOSetSportSortingInfoBluetoothModel
 */
+ (__kindof IDOSetSportSortingInfoBluetoothModel *)currentModel;

@end

#pragma mark ==== 设置运动快捷模式model ====

@interface IDOSetSportShortcutInfoBluetoothModel:IDOBluetoothBaseModel

/**
 走路 | Walking
 */
@property (nonatomic,assign) BOOL isWalk;

/**
 跑步 | Running
 */
@property (nonatomic,assign) BOOL isRun;

/**
 骑自行车 | Cycling
 */
@property (nonatomic,assign) BOOL isByBike;

/**
 步行 | Walking
 */
@property (nonatomic,assign) BOOL isOnFoot;

/**
 游泳 | Swimming
 */
@property (nonatomic,assign) BOOL isSwim;

/**
 爬山 | Mountain climbing
 */
@property (nonatomic,assign) BOOL isMountainClimbing;

/**
 羽毛球 | Badminton
 */
@property (nonatomic,assign) BOOL isBadminton;

/**
 其他 | Other
 */
@property (nonatomic,assign) BOOL isOther;

/**
 健身 | Fitness
 */
@property (nonatomic,assign) BOOL isFitness;

/**
 动感单车 | Spinning bike
 */
@property (nonatomic,assign) BOOL isSpinning;

/**
 橄榄球 | Rugby
 */
@property (nonatomic,assign) BOOL isEllipsoid;

/**
 跑步机 | Treadmill
 */
@property (nonatomic,assign) BOOL isTreadmill;

/**
 仰卧起坐 | Sit ups
 */
@property (nonatomic,assign) BOOL isSitUp;

/**
 俯卧撑 | Push-ups
 */
@property (nonatomic,assign) BOOL isPushUp;

/**
 哑铃 | Dumbbell
 */
@property (nonatomic,assign) BOOL isDumbbell;

/**
 举重 | Weightlifting
 */
@property (nonatomic,assign) BOOL isWeightlifting;

/**
 体操 | Gymnastics
 */
@property (nonatomic,assign) BOOL isBodybuildingExercise;

/**
 瑜伽 | Yoga
 */
@property (nonatomic,assign) BOOL isYoga;

/**
 跳绳 | Jumping rope
 */
@property (nonatomic,assign) BOOL isRopeSkipping;

/**
 乒乓球 | Table tennis
 */
@property (nonatomic,assign) BOOL isTableTennis;

/**
 篮球 | Basketball
 */
@property (nonatomic,assign) BOOL isBasketball;

/**
 足球 | Football
 */
@property (nonatomic,assign) BOOL isFootball;

/**
 排球 | Volleyball
 */
@property (nonatomic,assign) BOOL isVolleyball;

/**
 网球 | Tennis
 */
@property (nonatomic,assign) BOOL isTennis;

/**
 高尔夫 | Golf
 */
@property (nonatomic,assign) BOOL isGolf;

/**
 棒球 | Baseball
 */
@property (nonatomic,assign) BOOL isBaseball;

/**
 滑雪 | Skiing
 */
@property (nonatomic,assign) BOOL isSkiing;

/**
 滑旱冰 | Roller Skating
 */
@property (nonatomic,assign) BOOL isRollerSkating;

/**
 跳舞 | Dancing
 */
@property (nonatomic,assign) BOOL isDance;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOSetSportShortcutInfoBluetoothModel
 */
+ (__kindof IDOSetSportShortcutInfoBluetoothModel *)currentModel;
@end

#pragma mark ==== 设置血压校准model ====
@interface IDOSetBloodPressureInfoBluetoothModel:IDOBluetoothBaseModel

/**
 舒张压 | Diastolic blood pressure
 */
@property (nonatomic,assign) NSInteger diastolic;

/**
 收缩压 | Systolic pressure
 */
@property (nonatomic,assign) NSInteger shrinkage;

/**
 * 返回校准状态  0x01.成功进入校准模式，正在校准 0x02.在运动模式, 0x03.设备忙碌 0x04.无效的状态 0x06.校准失败 0x00.校准成功
 * Return to calibration status: 0x01. Successfully entered calibration mode, calibration;
 * 0x02. In motion mode; 0x03. Device busy; 0x04. Invalid status; 0x06. Calibration failed; 0x00. Calibration successful
 */
@property (nonatomic,assign) NSInteger statusCode;

/**
 * 血压校准控制  0x01 血压校准开始 0x02 血压校准查询
 * Blood Pressure Calibration Control 0x01 Blood Pressure Calibration Start 0x02 Blood Pressure Calibration Query
 */
@property (nonatomic,assign) NSInteger flag;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOSetBloodPressureInfoBluetoothModel
 */
+ (__kindof IDOSetBloodPressureInfoBluetoothModel *)currentModel;
@end

#pragma mark ==== 设置快捷方式model ====
@interface IDOSetShortcutInfoBluetoothModel:IDOBluetoothBaseModel

/**
 快捷方式类型 | Shortcut Type
 */
@property (nonatomic,assign) NSInteger shortcutType;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOSetShortcutInfoBluetoothModel
 */
+ (__kindof IDOSetShortcutInfoBluetoothModel *)currentModel;
@end

#pragma mark ==== 设置闹钟model ====
@interface IDOSetAlarmInfoBluetoothModel:IDOBluetoothBaseModel

/**
 开关 | Switch
 */
@property (nonatomic,assign) BOOL isOpen;

/**
 是否同步 | Synchronization
 */
@property (nonatomic,assign) BOOL isSync;

/**
 是否删除 | Delete
 */
@property (nonatomic,assign) BOOL isDelete;

/**
 类型 | Type
 */
@property (nonatomic,assign) NSInteger type;

/**
 时 | hour
 */
@property (nonatomic,assign) NSInteger hour;

/**
 分 | minute
 */
@property (nonatomic,assign) NSInteger minute;

/**
 * 重复集合 [星期一、星期二、星期三、星期四、星期五、星期六、星期日]
 * Repeat collection [monday,tuesday,wednesday,thursday,friday,saturday,sunday]
 */
@property (nonatomic,strong)NSArray<NSNumber *> * repeat;

/**
 贪睡时长 | Sleepy time
 */
@property (nonatomic,assign) NSInteger tsnoozeDuration;

/**
 闹钟ID | Alarm ID
 */
@property (nonatomic,assign) NSInteger alarmId;

/**
 * @brief 初始化闹钟集合 | Initialize the alarm collection
 * @return 闹钟集合 | Alarm clock collection
 */
+ (NSArray <IDOSetAlarmInfoBluetoothModel *>*)queryAllAlarms;

/**
 * @brief 查询没有被开启的闹钟集合 | Querying an alarm set that is not turned on
 * @return 闹钟集合 | Alarm clock collection
 */
+ (NSArray <IDOSetAlarmInfoBluetoothModel *>*)queryAllNoOpenAlarms;

@end

#pragma mark ==== 设置时间model ====
@interface IDOSetTimeInfoBluetoothModel:IDOBluetoothBaseModel

/**
 年 | year
 */
@property (nonatomic,assign) NSInteger year;

/**
 月 | Month
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
 秒 | seconds
 */
@property (nonatomic,assign) NSInteger second;

/**
 星期 | week
 */
@property (nonatomic,assign) NSInteger weekDay;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOSetTimeInfoBluetoothModel
 */
+ (__kindof IDOSetTimeInfoBluetoothModel *)currentModel;
@end

#pragma mark ==== 设置单位model ====
@interface IDOSetUnitInfoBluetoothModel:IDOBluetoothBaseModel

/**
 距离单位 0x00:无效， 0x01:km，0x02:mi | Distance unit 0x00: Invalid, 0x01:km, 0x02:mi
 */
@property (nonatomic,assign) NSInteger distanceUnit;

/**
 重量单位 0x00: 无效，0x01:kg， 0x02:lb， 0x03: 英石 | Weight Unit 0x00: Invalid, 0x01:kg, 0x02:lb, 0x03: Stone
 */
@property (nonatomic,assign) NSInteger weightUnit;

/**
 温度单位 0x00:无效， 0x01:°C， 0x02:°F | Temperature unit 0x00: Invalid, 0x01: °C, 0x02: °F
 */
@property (nonatomic,assign) NSInteger tempUnit;

/**
 * 语言单位 无效:0,中文:1,英文:2,法语:3,德语:4,意大利语:5,西班牙语:6,日语:7,
 * 波兰语:8,捷克语:9,罗马尼亚:10,立陶宛语:11,荷兰语:12,斯洛文尼亚:13,
 * 匈牙利语:14,俄罗斯语:15,乌克兰语:16,斯洛伐克语:17,丹麦语:18,克罗地亚:19,印尼语:20,
 * 韩语:21,印地语:22,葡萄牙语:23,土耳其:24,泰国语:25,越南语:26,缅甸语:27,菲律宾语:28
 * Language unit Invalid: 0, Chinese: 1, English: 2, French: 3, German: 4, Italian: 5, Spanish: 6, Japanese: 7,
 * Polish: 8, Czech: 9, Romania: 10, Lithuanian: 11, Dutch: 12, Slovenia: 13,
 * Hungarian: 14, Russian: 15, Ukrainian: 16, Slovak: 17, Danish: 18, Croatia: 19,Indonesian: 20,korean:21,hindi:22
 * portuguese:23,turkish:24,thai:25,vietnamese:26,burmese:27,filipino:28
 */
@property (nonatomic,assign) NSInteger languageUnit;

/**
 * 走路步伐 根据男性换算 默认值 72 （单位 ：cm）
 * Walking pace According to male conversion Default value 72 (unit: cm)
 */
@property (nonatomic,assign) NSInteger strideWalk;

/**
 * 跑步步伐 根据男性换算 默认值 90 （单位 ：cm）
 * Running pace Converted by male Default 90 (Unit: cm)
 */
@property (nonatomic,assign) NSInteger strideRun;

/**
 * gps校准步长 0x00:无效， 0x01:开， 0x02: 关
 * gps calibration step size 0x00: invalid, 0x01: on, 0x02: off
 */
@property (nonatomic,assign) NSInteger strideGps;

/**
 * 时间单位 0x00:无效， 0x01:24 小时制，0x02: 12 小时制
 * Time unit 0x00: Invalid, 0x01: 24-hour clock, 0x02: 12-hour clock
 */
@property (nonatomic,assign) NSInteger timeUnit;

/**
 * 星期的开始日 星期日：0x01，星期一 ：0x00，星期六 ：0x03
 * Start of the week Sunday: 0x01, Monday: 0x00, Saturday: 0x03
 */
@property (nonatomic,assign) NSInteger weekStart;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOSetUnitInfoBluetoothModel
 */
+ (__kindof IDOSetUnitInfoBluetoothModel *)currentModel;
@end

#pragma mark ==== 设置心率区间model ====
@interface IDOSetHrIntervalInfoBluetoothModel:IDOBluetoothBaseModel

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
 最大心率 | Maximum heart rate
 */
@property (nonatomic,assign) NSInteger userMaxHr;

/**
 热身运动 | Warm-up
 */
@property (nonatomic,assign) NSInteger warmUp;

/**
 无氧运动 | Anaerobic exercise
 */
@property (nonatomic,assign) NSInteger anaerobic;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOSetHrIntervalInfoBluetoothModel
 */
+ (__kindof IDOSetHrIntervalInfoBluetoothModel *)currentModel;
@end

#pragma mark ==== 设置勿扰模式model ====
@interface IDOSetNoDisturbModeInfoBluetoothModel:IDOBluetoothBaseModel

/**
 开关 | Switch
 */
@property (nonatomic,assign) BOOL isOpen;

/**
 开始 (时) | Start (hours)
 */
@property (nonatomic,assign) NSInteger  startHour;

/**
 开始 (分) | Start (minutes)
 */
@property (nonatomic,assign) NSInteger  startMinute;

/**
 结束 (时) | End (hours)
 */
@property (nonatomic,assign) NSInteger  endHour;

/**
 结束 (分) | End (minutes)
 */
@property (nonatomic,assign) NSInteger  endMinute;

/**
 * 是否有间隔重复提醒
 * interval repeat reminder
 */
@property (nonatomic,assign) BOOL  isHaveRangRepeat;

/**
 * 重复集合 [星期一、星期二、星期三、星期四、星期五、星期六、星期日]
 * Repeat collection [monday,tuesday,wednesday,thursday,friday,saturday,sunday]
 */
@property (nonatomic,strong)NSArray<NSNumber *> * repeat;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOSetNoDisturbModeInfoBluetoothModel
 */
+ (__kindof IDOSetNoDisturbModeInfoBluetoothModel *)currentModel;
@end

#pragma mark ==== 设置心率模式model ====
@interface IDOSetHrModeInfoBluetoothModel:IDOBluetoothBaseModel

/**
 * 心率模式 0:关闭心率监测功能 1:手动模式 2:自动模式 3:持续监测（默认：自动模式）
 * Heart Rate Mode 0: Turn off heart rate monitoring function 1: Manual mode 2: Auto mode 3:Continuously monitor(Default: Auto mode)
 */
@property (nonatomic,assign) NSInteger modeType;

/**
 是否有相隔时间 | Is there a time interval?
 */
@property (nonatomic,assign) BOOL isHasTimeRange;

/**
 开始 (时) | Start (hours)
 */
@property (nonatomic,assign) NSInteger  startHour;

/**
 开始 (分) | Start (minutes)
 */
@property (nonatomic,assign) NSInteger  startMinute;

/**
 结束 (时) | End (hours)
 */
@property (nonatomic,assign) NSInteger  endHour;

/**
 结束 (分) | End (minutes)
 */
@property (nonatomic,assign) NSInteger  endMinute;

/**
 测量间隔,单位分钟 | measurement Interval,unit:minutes
 */
@property (nonatomic,assign) NSInteger  measurementInterval;
/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOSetHRModeInfoBluetoothModel
 */
+ (__kindof IDOSetHrModeInfoBluetoothModel *)currentModel;
@end

#pragma mark ==== 设置手环横竖屏model ====
@interface IDOSetDisplayModeInfoBluetoothModel:IDOBluetoothBaseModel

/**
 显示模式 | Display mode
 */
@property (nonatomic,assign) NSInteger modeType;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOSetDisplayModeInfoBluetoothModel
 */
+ (__kindof IDOSetDisplayModeInfoBluetoothModel *)currentModel;
@end

#pragma mark ==== 设置抬腕手势model ====
@interface IDOSetHandUpInfoBuletoothModel : IDOBluetoothBaseModel

/**
 开关 | Switch
 */
@property (nonatomic,assign) BOOL isOpen;

/**
 是否有相隔时间 | Is there a time interval?
 */
@property (nonatomic,assign) BOOL isHasTimeRange;

/**
 显示时长 3～10 秒 | Display time 3～10 second
 */
@property (nonatomic,assign) NSInteger  showSecond;

/**
 开始 (时) | Start (hours)
 */
@property (nonatomic,assign) NSInteger  startHour;

/**
 开始 (分) | Start (minutes)
 */
@property (nonatomic,assign) NSInteger  startMinute;

/**
 结束 (时) | End (hours)
 */
@property (nonatomic,assign) NSInteger  endHour;

/**
 结束 (分) | End (minutes)
 */
@property (nonatomic,assign) NSInteger  endMinute;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOSetHandUpInfoBuletoothModel
 */
+ (__kindof IDOSetHandUpInfoBuletoothModel *)currentModel;
@end

#pragma mark ==== 设置久坐提醒model ====
@interface IDOSetLongSitInfoBuletoothModel : IDOBluetoothBaseModel

/**
 开始 (时) | Start (hours)
 */
@property (nonatomic,assign) NSInteger  startHour;

/**
 开始 (分) | Start (minutes)
 */
@property (nonatomic,assign) NSInteger  startMinute;

/**
 结束 (时) | End (hours)
 */
@property (nonatomic,assign) NSInteger  endHour;

/**
 结束 (分) | End (minutes)
 */
@property (nonatomic,assign) NSInteger  endMinute;

/**
 间隔 | Interval
 */
@property (nonatomic,assign) NSInteger  interval;

/**
 开关 | Switch
 */
@property (nonatomic,assign) BOOL isOpen;

/**
  * 重复集合 [星期一、星期二、星期三、星期四、星期五、星期六、星期日]
  * Repeat collection [monday,tuesday,wednesday,thursday,friday,saturday,sunday]
 */
@property (nonatomic,strong) NSArray <NSNumber *>* selectWeeks;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOSetLongSitInfoBuletoothModel
 */
+ (__kindof IDOSetLongSitInfoBuletoothModel *)currentModel;
@end

#pragma mark ==== 设置天气预报开关model ====
@interface IDOSetWeatherSwitchInfoBluetoothModel:IDOBluetoothBaseModel

/**
 天气预报开关 | Weather forecast switch
 */
@property (nonatomic,assign) BOOL isOpen;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOSetWeatherSwitchInfoBluetoothModel
 */
+ (__kindof IDOSetWeatherSwitchInfoBluetoothModel *)currentModel;
@end

#pragma mark ==== 设置相机开关model ====
@interface IDOSetCameraInfoBluetoothModel:IDOBluetoothBaseModel

/**
 相机开关 | Camera switch
 */
@property (nonatomic,assign) BOOL isOpen;

@end

#pragma mark ==== 设置音乐开关model ====
@interface IDOSetMusicOpenInfoBuletoothModel : IDOBluetoothBaseModel

/**
 音乐开关 | Music switch
 */
@property (nonatomic,assign) BOOL isOpen;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOSetMusicOpenInfoBuletoothModel
 */
+ (__kindof IDOSetMusicOpenInfoBuletoothModel *)currentModel;
@end

#pragma mark ==== 设置防止丢失model ====
@interface IDOSetPreventLostInfoBuletoothModel : IDOBluetoothBaseModel

/**
 防丢失级别 | Loss prevention level
 */
@property (nonatomic,assign) NSInteger levelType;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOSetPreventLostInfoBuletoothModel
 */
+ (__kindof IDOSetPreventLostInfoBuletoothModel *)currentModel;
@end

#pragma mark ==== 设置左右手穿戴model ====
@interface IDOSetLeftOrRightInfoBuletoothModel : IDOBluetoothBaseModel

/**
 是否右手佩戴 | Is it worn on the right hand?
 */
@property (nonatomic,assign) BOOL isRight;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOSetLeftOrRightInfoBuletoothModel
 */
+ (__kindof IDOSetLeftOrRightInfoBuletoothModel *)currentModel;
@end

#pragma mark ==== 设置寻找手机model ====
@interface IDOSetFindPhoneInfoBuletoothModel : IDOBluetoothBaseModel

/**
 寻找手机开关 | Looking for a phone switch
 */
@property (nonatomic,assign) BOOL isOpen;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOSetFindPhoneInfoBuletoothModel
 */
+ (__kindof IDOSetFindPhoneInfoBuletoothModel *)currentModel;
@end

#pragma mark ==== 设置一键呼叫model ====
@interface IDOSetOneKeySosInfoBuletoothModel : IDOBluetoothBaseModel

/**
 一键呼叫开关 | One-touch call switch
 */
@property (nonatomic,assign) BOOL isOpen;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOSetOneKeySosInfoBuletoothModel
 */
+ (__kindof IDOSetOneKeySosInfoBuletoothModel *)currentModel;
@end

#pragma mark ==== 设置开启蓝牙配对model ====
@interface IDOSetPairingInfoBuletoothModel : IDOBluetoothBaseModel

/**
 配对时间戳 time interval since 1970 (如:1444361933)
 * Pairing timestamp time interval since 1970 (eg 14442361933)
 */
@property (nonatomic,copy) NSString * pairingTimeStr;

/**
 是否配对 | Pairing
 */
@property (nonatomic,assign) BOOL isPairing;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOSetPairingInfoBuletoothModel
 */
+ (__kindof IDOSetPairingInfoBuletoothModel *)currentModel;

@end

#pragma mark ==== 设置智能提醒model ====
@interface IDOSetNoticeInfoBuletoothModel : IDOBluetoothBaseModel

/**
 是否配对 | Pairing
 */
@property (nonatomic,assign) BOOL isPairing;

/**
 来电延迟 | Call delay
 */
@property (nonatomic,assign) NSInteger  callDelay;

/**
 * 是否开启子开关 (只对智能提醒有效,对来电提醒无效)
 * Whether to enable the sub-switch (only valid for smart reminders, invalid for incoming call reminders)
 */
@property (nonatomic,assign) BOOL isOnChild;

/**
 来电提醒 | Call reminder
 */
@property (nonatomic,assign) BOOL isOnCall;

/**
 短信提醒 | SMS reminder
 */
@property (nonatomic,assign) BOOL isOnSms;

/**
 邮件提醒 | Email alert
 */
@property (nonatomic,assign) BOOL isOnEmail;

/**
 微信提醒 | WeChat reminder
 */
@property (nonatomic,assign) BOOL isOnWeChat;

/**
 qq提醒 | qq reminder
 */
@property (nonatomic,assign) BOOL isOnQq;

/**
 微博提醒 | Weibo reminder
 */
@property (nonatomic,assign) BOOL isOnWeibo;

/**
 FaceBook 提醒 | FaceBook Reminder
 */
@property (nonatomic,assign) BOOL isOnFaceBook;

/**
 Twitter 提醒 | Twitter Reminder
 */
@property (nonatomic,assign) BOOL isOnTwitter;

/**
 Whatsapp 提醒 | Whatsapp Reminder
 */
@property (nonatomic,assign) BOOL isOnWhatsapp;

/**
 Messenger 提醒 | Messenger reminder
 */
@property (nonatomic,assign) BOOL isOnMessenger;

/**
 Instagram 提醒 | Instagram reminder
 */
@property (nonatomic,assign) BOOL isOnInstagram;

/**
 LinkedIn 提醒 | LinkedIn Reminder
 */
@property (nonatomic,assign) BOOL isOnLinkedIn;

/**
 Calendar 提醒 | Calendar Reminder
 */
@property (nonatomic,assign) BOOL isOnCalendar;

/**
 Skype 提醒 | Skype reminder
 */
@property (nonatomic,assign) BOOL isOnSkype;

/**
 Alarm 提醒 | Alarm Reminder
 */
@property (nonatomic,assign) BOOL isOnAlarm;

/**
 Pokeman 提醒 | Pokemon Reminder
 */
@property (nonatomic,assign) BOOL isOnPokeman;

/**
 Vkontakte 提醒 | Vkontakte Reminder
 */
@property (nonatomic,assign) BOOL isOnVkontakte;

/**
 Line 提醒 | Line reminder
 */
@property (nonatomic,assign) BOOL isOnLine;

/**
 Viber 提醒 | Viber reminder
 */
@property (nonatomic,assign) BOOL isOnViber;

/**
 KakaoTalk 提醒 | KakaoTalk Reminder
 */
@property (nonatomic,assign) BOOL isOnKakaoTalk;

/**
 Gmail 提醒 | Gmail reminder
 */
@property (nonatomic,assign) BOOL isOnGmail;

/**
 Outlook 提醒 | Outlook reminder
 */
@property (nonatomic,assign) BOOL isOnOutlook;

/**
 Snapchat 提醒 | Snapchat Reminder
 */
@property (nonatomic,assign) BOOL isOnSnapchat;

/**
 Telegram 提醒 | Telegram Reminder
 */
@property (nonatomic,assign) BOOL isOnTelegram;

/**
 Chatwork 提醒 | Chatwork
 */
@property (nonatomic,assign) BOOL isOnChatwork;

/**
 Slack 提醒 | Slack
 */
@property (nonatomic,assign) BOOL isOnSlack;

/**
 Yahoo Mail 提醒 | Yahoo Mail
 */
@property (nonatomic,assign) BOOL isOnYahooMail;

/**
 Tumblr 提醒 | Tumblr
 */
@property (nonatomic,assign) BOOL isOnTumblr;

/**
 Youtube 提醒 | Youtube
 */
@property (nonatomic,assign) BOOL isOnYoutube;

/**
 Yahoo Pinterest 提醒 | Yahoo Pinterest
 */
@property (nonatomic,assign) BOOL isOnYahooPinterest;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOSetNoticeInfoBuletoothModel
 */
+ (__kindof IDOSetNoticeInfoBuletoothModel *)currentModel;

@end

#pragma mark ==== 设置用户信息model ====
@interface IDOSetUserInfoBuletoothModel : IDOBluetoothBaseModel

/**
 身高(厘米) | Height(cm)
 */
@property (nonatomic,assign) NSInteger height;

/**
 当前体重(千克) | Current weight(kg)
 */
@property (nonatomic,assign) NSInteger weight;

/**
 性别 1: 男 2 ：女 | Gender 1: Male 2: Female
 */
@property (nonatomic,assign) NSInteger gender;

/**
 年 | year
 */
@property (nonatomic,assign) NSInteger year;

/**
 月 | Month
 */
@property (nonatomic,assign) NSInteger month;

/**
 日 | day
 */
@property (nonatomic,assign) NSInteger day;

/**
 目标睡眠 (时) | Target sleep (hours)
 */
@property (nonatomic,assign) NSInteger goalSleepDataHour;

/**
 目标睡眠 (分) | Target sleep (minutes)
 */
@property (nonatomic,assign) NSInteger goalSleepDataMinute;

/**
 目标步数 | Target steps
 */
@property (nonatomic,assign) NSInteger goalStepData;

/**
 目标卡路里 | Goal Calories
 */
@property (nonatomic,assign) NSInteger goalCalorieData;

/**
 目标距离(米) | Target distance(m)
 */
@property (nonatomic,assign) NSInteger goalDistanceData;

/**
 目标体重(千克) | Target weight(kg)
 */
@property (nonatomic,assign) NSInteger goalWeightData;

/**
 * 目标类型 (类型 : 0 : 步数  1 : 卡路里  2 : 距离) 设置一种类型的目标需要执行一次命令
 * Target type (type : 0 : step 1 : calories 2 : distance) Setting a type of target requires a command to be executed
 */
@property (nonatomic,assign) NSInteger goalType;

/**
 是否登陆 | Login
 */
@property (nonatomic,assign) BOOL isLogin;

/**
 绑定状态 | Binding status
 */
@property (nonatomic,assign) NSInteger bindState;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOSetUserInfoBuletoothModel
 */
+ (__kindof IDOSetUserInfoBuletoothModel *)currentModel;


@end


@interface IDOSetInfoBluetoothModel : IDOBluetoothBaseModel

@end
