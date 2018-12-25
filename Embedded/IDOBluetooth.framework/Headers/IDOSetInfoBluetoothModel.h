//
//  IDOSetBuletoothModel.h
//  VeryfitSDK
//
//  Created by hedongyang on 2018/6/13.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "IDOBluetoothBaseModel.h"

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

- (void)menstruationRemindModelToStructure:(void *)data;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象 | Query the database, if the query does not initialize a new model object
 * @return IDOSetMenstruationRemindBluetoothModel
 */
+ (__kindof IDOSetMenstruationRemindBluetoothModel *)currentModel;

@end

#pragma mark ====  设置经期 model ====
@interface IDOSetMenstruationInfoBluetoothModel:IDOBluetoothBaseModel
/**
 开关 0xAA开,0x55关闭 | Switch 0xAA on, 0x55 off
 */
@property (nonatomic,assign) NSInteger onOff;
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
 经期长度 | length of menstruation
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

- (void)menstruationModelToStructure:(void *)data;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象 | Query the database, if the query does not initialize a new model object
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
 * @brief 绑定model 转结构体数据 (内部使用) | Binding model to structure data (internal use)
 * @param data 结构体指针 | Structure pointer
 */
- (void)bindingModelToStructure:(void *)data;

/**
 * @brief 授权绑定model 转结构体数据 (内部使用) | Authorization binding model to structure data (internal use)
 * @param data 结构体指针 | Structure pointer
 */
- (void)authCodeModelToStructure:(void *)data;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象 (只有在授权绑定才会存储数据) | Query the database, if the query does not initialize the new model object (only the authorization binding will store the data)
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
 * @brief 睡眠设置model 转结构体数据 (内部使用) | Sleep settings model to structure data (internal use)
 * @param data 结构体指针 | Structure pointer
 */
- (void)sleepPeriodModelToStructure:(void *)data;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象 | Query the database, if the query does not initialize a new model object
 * @return IDOSetSleepPeriodInfoBluetoothModel
 */
+ (__kindof IDOSetSleepPeriodInfoBluetoothModel *)currentModel;
@end

#pragma mark ==== 设置血压测量指令model ====
@interface IDOSetBpMeasureInfoBluetoothModel:IDOBluetoothBaseModel

/**
 参数标志 0x01:开始测量，0x02:结束测量，0x03:获得血压数据 | Parameter flag 0x01: Start measurement, 0x02: End measurement, 0x03: Obtain blood pressure data
 */
@property (nonatomic,assign) NSInteger flag;

/**
 返回状态 0x00:不支持，0x01:正 在测量，0x02:测量成功 0x03:测量失败 0x04:设备正在运动模式 | Return status 0x00: Not supported, 0x01: Positive measurement, 0x02: Measurement success 0x03: Measurement failure 0x04: Device is in motion mode
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
 * @brief 血压测量指令model 转结构体数据 (内部使用) | Blood pressure measurement instruction model to structure data (internal use)
 * @param data 结构体指针 | Structure pointer
 */
- (void)bpMeasureModelToStructure:(void *)data;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象 | Query the database, if the query does not initialize a new model object
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
 * @brief 表盘参数model 转结构体数据 (内部使用) | Dial parameter model to structure data (internal use)
 * @param data 结构体指针 | Structure pointer
 */
- (void)watchDiaModelToStructure:(void *)data;

/**
 * @brief  查询数据库,如果查询不到初始化新的model对象 | Query the database, if the query does not initialize a new model object
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
 * @brief 马达参数model 转结构体数据 (内部使用) | Motor parameter model to structure data (internal use)
 * @param data 结构体指针 | Structure pointer
 */
- (void)startMotorInfoModelToStructure:(void *)data;

/**
 查询数据库,如果查询不到初始化新的model对象
 
 @return IDOSetStartMotorInfoBluetoothModel
 */
+ (__kindof IDOSetStartMotorInfoBluetoothModel *)currentModel;
@end

#pragma mark ==== 设置传感器实时数据model ====
@interface IDOSetRealTimeSensorDataInfoBluetoothModel:IDOBluetoothBaseModel

/**
  未知传感器状态
 */
@property (nonatomic,assign) NSInteger gsensorStatus;

/**
 心率传感器状态
 */
@property (nonatomic,assign) NSInteger heartRateSensorStatus;

/**
 传感器实时参数 model 转结构体数据 (内部使用)
 
 @param data 结构体指针
 */
- (void)realTimeSensorDataInfoModelToStructure:(void *)data;

/**
 查询数据库,如果查询不到初始化新的model对象
 
 @return IDOSetRealTimeSensorDataInfoBluetoothModel
 */
+ (__kindof IDOSetRealTimeSensorDataInfoBluetoothModel *)currentModel;
@end

#pragma mark ==== 设置连接参数信息model ====
@interface IDOSetConnParamInfoBluetoothModel:IDOBluetoothBaseModel

/**
 连接模式
 */
@property (nonatomic,assign) NSInteger mode;

/**
 修改快速模式连接间隔
 */
@property (nonatomic,assign) NSInteger modifConnParam;

/**
 最大间隔
 */
@property (nonatomic,assign) NSInteger maxInterval;

/**
 最小间隔
 */
@property (nonatomic,assign) NSInteger minInterval;

/**
 延迟
 */
@property (nonatomic,assign) NSInteger slaveLatency;

/**
 连接超时
 */
@property (nonatomic,assign) NSInteger connTimeout;

/**
 连接参数 model 转结构体数据 (内部使用)
 
 @param data 结构体指针
 */
- (void)connParamInfoModelToStructure:(void *)data;
/**
 查询数据库,如果查询不到初始化新的model对象
 
 @return IDOSetConnParamInfoBluetoothModel
 */
+ (__kindof IDOSetConnParamInfoBluetoothModel *)currentModel;
@end

#pragma mark ==== 设置GPS控制信息model ====
@interface IDOSetGpsControlInfoBluetoothModel:IDOBluetoothBaseModel

/**
 1: 控制 , 2: 查询
 */
@property (nonatomic,assign) NSInteger operate;

/**
 0x01 开启log,0x02 关闭log,0x03 agps写入,0x04 agps 擦除,0x05 gps_fw 写入
 */
@property (nonatomic,assign) NSInteger type;
/**
 GPS控制 model 转结构体数据 (内部使用)
 
 @param data 结构体指针
 */
- (void)gpsControlInfoModelToStructure:(void *)data;
/**
 查询数据库,如果查询不到初始化新的model对象
 
 @return IDOSetGpsControlInfoBluetoothModel
 */
+ (__kindof IDOSetGpsControlInfoBluetoothModel *)currentModel;
@end

#pragma mark ==== 设置GPS信息model ====
@interface IDOSetGpsConfigInfoBluetoothModel:IDOBluetoothBaseModel

/**
 0x01 冷启动,0x02 热启动  默认2
 */
@property (nonatomic,assign) NSInteger startMode;

/**
 操作模式,1为正常;2为低功耗;4为Balance,5为1PPS 默认1
 */
@property (nonatomic,assign) NSInteger gsopOperationMode;

/**
 定位周期,默认1000 1s
 */
@property (nonatomic,assign) NSInteger gsopCycleMs;

/**
 定位星mode,1为GPS,2为GLONASS,3为1为GPS + GLONASS 默认1
 */
@property (nonatomic,assign) NSInteger gnsValue;

/**
 年
 */
@property (nonatomic,assign) NSInteger year;

/**
 月
 */
@property (nonatomic,assign) NSInteger month;

/**
 日
 */
@property (nonatomic,assign) NSInteger day;

/**
 时
 */
@property (nonatomic,assign) NSInteger hour;

/**
 分
 */
@property (nonatomic,assign) NSInteger minute;

/**
 秒
 */
@property (nonatomic,assign) NSInteger second;
/**
 GPS信息 model 转结构体数据 (内部使用)
 
 @param data 结构体指针
 */
- (void)gpsInfoModelToStructure:(void *)data;
/**
 查询数据库,如果查询不到初始化新的model对象
 
 @return IDOSetGpsConfigInfoBluetoothModel
 */
+ (__kindof IDOSetGpsConfigInfoBluetoothModel *)currentModel;
@end

#pragma mark ==== 设置屏幕亮度model ====
@interface IDOSetScreenBrightnessInfoBluetoothModel:IDOBluetoothBaseModel

/**
 屏幕亮度级别 (0-100)
 */
@property (nonatomic,assign) NSInteger levelValue;
/**
 屏幕亮度 model 转结构体数据 (内部使用)
 
 @param data 结构体指针
 */
- (void)screenBrightnessModelToStructure:(void *)data;
/**
 查询数据库,如果查询不到初始化新的model对象
 
 @return IDOSetScreenBrightnessInfoBluetoothModel
 */
+ (__kindof IDOSetScreenBrightnessInfoBluetoothModel *)currentModel;
@end

#pragma mark ==== 设置天气数据model ====
@interface IDOSetWeatherDataInfoBluetoothModel:IDOBluetoothBaseModel

/**
 天气预报更新的时间戳 time interval since 1970 (如:1444361933)
 */
@property (nonatomic,copy) NSString * timeStr;

/**
 今天平均温度
 */
@property (nonatomic,assign) NSInteger todayTemp;

/**
 天气类型
 */
@property (nonatomic,assign) NSInteger todayType;

/**
 今天最高温度
 */
@property (nonatomic,assign) NSInteger todayMaxTemp;

/**
 今天最小温度
 */
@property (nonatomic,assign) NSInteger todayMinTemp;

/**
 湿度
 */
@property (nonatomic,assign) NSInteger humidity;

/**
 紫外线强度
 */
@property (nonatomic,assign) NSInteger todayUvIntensity;

/**
 空气污染指数
 */
@property (nonatomic,assign) NSInteger todayAqi;

/**
 后两天的天气集合  @{@"type":@(0),@"maxTemp":@(0),@"minTemp":@(0)}
 */
@property (nonatomic,strong)   NSArray<NSDictionary*>* future;

/**
 天气数据 model 转结构体数据 (内部使用)
 
 @param data 结构体指针
 */
- (void)weatherDataModelToStructure:(void *)data;
/**
 查询数据库,如果查询不到初始化新的model对象
 
 @return IDOSetWeatherDataInfoBluetoothModel
 */
+ (__kindof IDOSetWeatherDataInfoBluetoothModel *)currentModel;
@end
#pragma mark ==== 设置运动快捷模式model ====
@interface IDOSetSportShortcutInfoBluetoothModel:IDOBluetoothBaseModel

/**
 走路
 */
@property (nonatomic,assign) BOOL isWalk;

/**
 跑步
 */
@property (nonatomic,assign) BOOL isRun;

/**
 骑自行车
 */
@property (nonatomic,assign) BOOL isByBike;

/**
 步行
 */
@property (nonatomic,assign) BOOL isOnFoot;

/**
 游泳
 */
@property (nonatomic,assign) BOOL isSwim;

/**
 爬山
 */
@property (nonatomic,assign) BOOL isMountainClimbing;

/**
 羽毛球
 */
@property (nonatomic,assign) BOOL isBadminton;

/**
 其他
 */
@property (nonatomic,assign) BOOL isOther;

/**
 健身
 */
@property (nonatomic,assign) BOOL isFitness;

/**
 动感单车
 */
@property (nonatomic,assign) BOOL isSpinning;

/**
 橄榄球
 */
@property (nonatomic,assign) BOOL isEllipsoid;

/**
 跑步机
 */
@property (nonatomic,assign) BOOL isTreadmill;

/**
 仰卧起坐
 */
@property (nonatomic,assign) BOOL isSitUp;

/**
 俯卧撑
 */
@property (nonatomic,assign) BOOL isPushUp;

/**
 哑铃
 */
@property (nonatomic,assign) BOOL isDumbbell;

/**
 举重
 */
@property (nonatomic,assign) BOOL isWeightlifting;

/**
 体操
 */
@property (nonatomic,assign) BOOL isBodybuildingExercise;

/**
 瑜伽
 */
@property (nonatomic,assign) BOOL isYoga;

/**
 跳绳
 */
@property (nonatomic,assign) BOOL isRopeSkipping;

/**
 乒乓球
 */
@property (nonatomic,assign) BOOL isTableTennis;

/**
 篮球
 */
@property (nonatomic,assign) BOOL isBasketball;

/**
 足球
 */
@property (nonatomic,assign) BOOL isFootball;

/**
 排球
 */
@property (nonatomic,assign) BOOL isVolleyball;

/**
 网球
 */
@property (nonatomic,assign) BOOL isTennis;

/**
 高尔夫
 */
@property (nonatomic,assign) BOOL isGolf;

/**
 棒球
 */
@property (nonatomic,assign) BOOL isBaseball;

/**
 滑雪
 */
@property (nonatomic,assign) BOOL isSkiing;

/**
 滑旱冰
 */
@property (nonatomic,assign) BOOL isRollerSkating;

/**
 跳舞
 */
@property (nonatomic,assign) BOOL isDance;
/**
 运动快捷方式 model 转结构体数据 (内部使用)
 
 @param data 结构体指针
 */
- (void)sportShortcutModelToStructure:(void *)data;
/**
 查询数据库,如果查询不到初始化新的model对象
 
 @return IDOSetSportShortcutInfoBluetoothModel
 */
+ (__kindof IDOSetSportShortcutInfoBluetoothModel *)currentModel;
@end

#pragma mark ==== 设置血压校准model ====
@interface IDOSetBloodPressureInfoBluetoothModel:IDOBluetoothBaseModel

/**
 舒张压
 */
@property (nonatomic,assign) NSInteger diastolic;

/**
 收缩压
 */
@property (nonatomic,assign) NSInteger shrinkage;

/**
 返回校准状态  0x01.成功进入校准模式，正在校准 0x02.在运动模式, 0x03.设备忙碌 0x04.无效的状态 0x06.校准失败 0x00.校准成功
 */
@property (nonatomic,assign) NSInteger statusCode;

/**
 血压校准控制  0x01 血压校准开始 0x02 血压校准查询
 */
@property (nonatomic,assign) NSInteger flag;

/**
 血压校准 model 转结构体数据 (内部使用)
 
 @param data 结构体指针
 */
- (void)bloodPressureModelToStructure:(void *)data;
/**
 查询数据库,如果查询不到初始化新的model对象
 
 @return IDOSetBloodPressureInfoBluetoothModel
 */
+ (__kindof IDOSetBloodPressureInfoBluetoothModel *)currentModel;
@end

#pragma mark ==== 设置快捷方式model ====
@interface IDOSetShortcutInfoBluetoothModel:IDOBluetoothBaseModel

/**
 快捷方式类型
 */
@property (nonatomic,assign) NSInteger shortcutType;
/**
 快捷方式 model 转结构体数据 (内部使用)
 
 @param data 结构体指针
 */
- (void)shortcutModelToStructure:(void *)data;
/**
 查询数据库,如果查询不到初始化新的model对象
 
 @return IDOSetShortcutInfoBluetoothModel
 */
+ (__kindof IDOSetShortcutInfoBluetoothModel *)currentModel;
@end

#pragma mark ==== 设置闹钟model ====
@interface IDOSetAlarmInfoBluetoothModel:IDOBluetoothBaseModel

/**
 开关
 */
@property (nonatomic,assign) BOOL isOpen;

/**
 是否同步
 */
@property (nonatomic,assign) BOOL isSync;

/**
 是否删除
 */
@property (nonatomic,assign) BOOL isDelete;

/**
 类型
 */
@property (nonatomic,assign) NSInteger type;

/**
 时
 */
@property (nonatomic,assign) NSInteger hour;

/**
 分
 */
@property (nonatomic,assign) NSInteger minute;

/**
 重复
 */
@property (nonatomic,strong)   NSArray * repeat;

/**
 贪睡时长
 */
@property (nonatomic,assign) NSInteger tsnoozeDuration;

/**
 闹钟ID
 */
@property (nonatomic,assign) NSInteger alarmId;

/**
 初始化闹钟集合

 @return 闹钟集合
 */
+ (NSArray <IDOSetAlarmInfoBluetoothModel *>*)queryAllAlarms;

/**
 查询没有被开启的闹钟集合

 @return 闹钟集合
 */
+ (NSArray <IDOSetAlarmInfoBluetoothModel *>*)queryAllNoOpenAlarms;
/**
 闹钟 model 转结构体 (内部使用)
 
 @param data 结构体指针
 */
- (void)alarmModelToStructure:(void *)data;
@end

#pragma mark ==== 设置时间model ====
@interface IDOSetTimeInfoBluetoothModel:IDOBluetoothBaseModel

/**
 年
 */
@property (nonatomic,assign) NSInteger year;

/**
 月
 */
@property (nonatomic,assign) NSInteger month;

/**
 日
 */
@property (nonatomic,assign) NSInteger day;

/**
 时
 */
@property (nonatomic,assign) NSInteger hour;

/**
 分
 */
@property (nonatomic,assign) NSInteger minute;

/**
 秒
 */
@property (nonatomic,assign) NSInteger second;

/**
 星期
 */
@property (nonatomic,assign) NSInteger weekDay;

/**
 当前时间 model 转结构体 (内部使用)
 
 @param data 结构体指针
 */
- (void)timeModelToStructure:(void *)data;
/**
 查询数据库,如果查询不到初始化新的model对象
 
 @return IDOSetTimeInfoBluetoothModel
 */
+ (__kindof IDOSetTimeInfoBluetoothModel *)currentModel;
@end

#pragma mark ==== 设置单位model ====
@interface IDOSetUnitInfoBluetoothModel:IDOBluetoothBaseModel

/**
 距离单位 0x00:无效， 0x01:km，0x02:mi
 */
@property (nonatomic,assign) NSInteger distanceUnit;

/**
 重量单位 0x00: 无效，0x01:kg， 0x02:lb， 0x03: 英石
 */
@property (nonatomic,assign) NSInteger weightUnit;

/**
 温度单位 0x00:无效， 0x01:°C， 0x02:°F
 */
@property (nonatomic,assign) NSInteger tempUnit;

/**
 语言单位 无效:0,中文:1,英文:2,法语:3,德语:4,意大利语:5,西班牙语:6,日语:7,
         波兰语:8,捷克语:9,罗马尼亚:10,立陶宛语:11,荷兰语:12,斯洛文尼亚:13,
         匈牙利语:14,俄罗斯语:15,乌克兰语:16,斯洛伐克语:17,丹麦语:18,克罗地亚:19
 */
@property (nonatomic,assign) NSInteger languageUnit;

/**
 走路步伐 根据男性换算 默认值 90 （单位 ：cm）
 */
@property (nonatomic,assign) NSInteger strideWalk;

/**
 跑步步伐 根据男性换算 默认值 72 （单位 ：cm）
 */
@property (nonatomic,assign) NSInteger strideRun;

/**
 gps校准步长 0x00:无效， 0x01:开， 0x02: 关
 */
@property (nonatomic,assign) NSInteger strideGps;

/**
 时间单位 0x00:无效， 0x01:24 小时制，0x02: 12 小时制
 */
@property (nonatomic,assign) NSInteger timeUnit;

/**
 星期的开始日 星期日：0 ，星期一 ：1 ，星期二 ： 2，星期三 ：3 ，星期四 ：4 ，星期五 ：5，星期六 ：6
 */
@property (nonatomic,assign) NSInteger weekStart;

/**
 单位 model 转结构体 (内部使用)
 
 @param data 结构体指针
 */
- (void)unitModelToStructure:(void *)data;
/**
 查询数据库,如果查询不到初始化新的model对象
 
 @return IDOSetUnitInfoBluetoothModel
 */
+ (__kindof IDOSetUnitInfoBluetoothModel *)currentModel;
@end

#pragma mark ==== 设置心率区间model ====
@interface IDOSetHrIntervalInfoBluetoothModel:IDOBluetoothBaseModel

/**
 燃烧脂肪的阈值
 */
@property (nonatomic,assign) NSInteger burnFat;

/**
 有氧运动阈值
 */
@property (nonatomic,assign) NSInteger aerobic;

/**
 限制阈值
 */
@property (nonatomic,assign) NSInteger limitValue;

/**
 最大心率
 */
@property (nonatomic,assign) NSInteger userMaxHr;
/**
 心率区间 model 转结构体 (内部使用)
 
 @param data 结构体指针
 */
- (void)hrIntervalModelToStructure:(void *)data;
/**
 查询数据库,如果查询不到初始化新的model对象
 
 @return IDOSetHrIntervalInfoBluetoothModel
 */
+ (__kindof IDOSetHrIntervalInfoBluetoothModel *)currentModel;
@end

#pragma mark ==== 设置勿扰模式model ====
@interface IDOSetNoDisturbModeInfoBluetoothModel:IDOBluetoothBaseModel

/**
 开关
 */
@property (nonatomic,assign) BOOL isOpen;

/**
 开始 (时)
 */
@property (nonatomic,assign) NSInteger  startHour;

/**
 开始 (分)
 */
@property (nonatomic,assign) NSInteger  startMinute;

/**
 结束 (时)
 */
@property (nonatomic,assign) NSInteger  endHour;

/**
 结束 (分)
 */
@property (nonatomic,assign) NSInteger  endMinute;
/**
 勿扰模式 model 转结构体 (内部使用)
 
 @param data 结构体指针
 */
- (void)noDisturbModelToStructure:(void *)data;
/**
 查询数据库,如果查询不到初始化新的model对象
 
 @return IDOSetNoDisturbModeInfoBluetoothModel
 */
+ (__kindof IDOSetNoDisturbModeInfoBluetoothModel *)currentModel;
@end

#pragma mark ==== 设置心率模式model ====
@interface IDOSetHrModeInfoBluetoothModel:IDOBluetoothBaseModel

/**
 心率模式 0:关闭心率监测功能 1:手动模式 2:自动模式 （默认：自动模式）
 */
@property (nonatomic,assign) NSInteger modeType;

/**
 是否有相隔时间
 */
@property (nonatomic,assign) BOOL isHasTimeRange;

/**
 开始 (时)
 */
@property (nonatomic,assign) NSInteger  startHour;

/**
 开始 (分)
 */
@property (nonatomic,assign) NSInteger  startMinute;

/**
 结束 (时)
 */
@property (nonatomic,assign) NSInteger  endHour;

/**
 结束 (分)
 */
@property (nonatomic,assign) NSInteger  endMinute;
/**
 心率模式 model 转结构体 (内部使用)
 
 @param data 结构体指针
 */
- (void)hrModeModelToStructure:(void *)data;
/**
 查询数据库,如果查询不到初始化新的model对象
 
 @return IDOSetHRModeInfoBluetoothModel
 */
+ (__kindof IDOSetHrModeInfoBluetoothModel *)currentModel;
@end

#pragma mark ==== 设置手环横竖屏model ====
@interface IDOSetDisplayModeInfoBluetoothModel:IDOBluetoothBaseModel

/**
 显示模式
 */
@property (nonatomic,assign) NSInteger modeType;
/**
 手环横竖屏 model 转结构体 (内部使用)
 
 @param data 结构体指针
 */
- (void)displayModeModelToStructure:(void *)data;
/**
 查询数据库,如果查询不到初始化新的model对象
 
 @return IDOSetDisplayModeInfoBluetoothModel
 */
+ (__kindof IDOSetDisplayModeInfoBluetoothModel *)currentModel;
@end

#pragma mark ==== 设置抬腕手势model ====
@interface IDOSetHandUpInfoBuletoothModel : IDOBluetoothBaseModel

/**
 开关
 */
@property (nonatomic,assign) BOOL isOpen;

/**
 是否有相隔时间
 */
@property (nonatomic,assign) BOOL isHasTimeRange;

/**
 显示时长
 */
@property (nonatomic,assign) NSInteger  showSecond;

/**
 开始 (时)
 */
@property (nonatomic,assign) NSInteger  startHour;

/**
 开始 (分)
 */
@property (nonatomic,assign) NSInteger  startMinute;

/**
 结束 (时)
 */
@property (nonatomic,assign) NSInteger  endHour;

/**
 结束 (分)
 */
@property (nonatomic,assign) NSInteger  endMinute;

/**
 抬腕手势 model 转结构体 (内部使用)
 
 @param data 结构体指针
 */
- (void)handUpModelToStructure:(void *)data;

/**
 查询数据库,如果查询不到初始化新的model对象
 
 @return IDOSetHandUpInfoBuletoothModel
 */
+ (__kindof IDOSetHandUpInfoBuletoothModel *)currentModel;
@end

#pragma mark ==== 设置久坐提醒model ====
@interface IDOSetLongSitInfoBuletoothModel : IDOBluetoothBaseModel

/**
 开始 (时)
 */
@property (nonatomic,assign) NSInteger  startHour;

/**
 开始 (分)
 */
@property (nonatomic,assign) NSInteger  startMinute;

/**
 结束 (时)
 */
@property (nonatomic,assign) NSInteger  endHour;

/**
 结束 (分)
 */
@property (nonatomic,assign) NSInteger  endMinute;

/**
 间隔
 */
@property (nonatomic,assign) NSInteger  interval;

/**
 开关
 */
@property (nonatomic,assign) BOOL isOpen;

/**
 重复集合 
 */
@property (nonatomic,strong) NSArray <NSNumber *>* selectWeeks;
/**
 久坐提醒 model 转结构体 (内部使用)
 
 @param data 结构体指针
 */
- (void)longSitModelToStructure:(void *)data;
/**
 查询数据库,如果查询不到初始化新的model对象
 
 @return IDOSetLongSitInfoBuletoothModel
 */
+ (__kindof IDOSetLongSitInfoBuletoothModel *)currentModel;
@end

#pragma mark ==== 设置天气预报开关model ====
@interface IDOSetWeatherSwitchInfoBluetoothModel:IDOBluetoothBaseModel

/**
 天气预报开关
 */
@property (nonatomic,assign) BOOL isOpen;
/**
 天气预报 model 转结构体 (内部使用)
 
 @param data 结构体指针
 */
- (void)weatherModelToStructure:(void *)data;
/**
 查询数据库,如果查询不到初始化新的model对象
 
 @return IDOSetWeatherSwitchInfoBluetoothModel
 */
+ (__kindof IDOSetWeatherSwitchInfoBluetoothModel *)currentModel;
@end

#pragma mark ==== 设置相机开关model ====
@interface IDOSetCameraInfoBluetoothModel:IDOBluetoothBaseModel

/**
 相机开关
 */
@property (nonatomic,assign) BOOL isOpen;

@end

#pragma mark ==== 设置音乐开关model ====
@interface IDOSetMusicOpenInfoBuletoothModel : IDOBluetoothBaseModel

/**
 音乐开关
 */
@property (nonatomic,assign) BOOL isOpen;

/**
 是否开始
 */
@property (nonatomic,assign) BOOL isStart;

/**
 音乐开关 model 转结构体 (内部使用)
 
 @param data 结构体指针
 */
- (void)musicOpenModelToStructure:(void *)data;

/**
 查询数据库,如果查询不到初始化新的model对象
 
 @return IDOSetMusicOpenInfoBuletoothModel
 */
+ (__kindof IDOSetMusicOpenInfoBuletoothModel *)currentModel;
@end

#pragma mark ==== 设置防止丢失model ====
@interface IDOSetPreventLostInfoBuletoothModel : IDOBluetoothBaseModel

/**
 防丢失级别
 */
@property (nonatomic,assign) NSInteger levelType;

/**
 防止丢失 model 转结构体 (内部使用)
 
 @param data 结构体指针
 */
- (void)preventLostModelToStructure:(void *)data;

/**
 查询数据库,如果查询不到初始化新的model对象
 
 @return IDOSetPreventLostInfoBuletoothModel
 */
+ (__kindof IDOSetPreventLostInfoBuletoothModel *)currentModel;
@end

#pragma mark ==== 设置左右手穿戴model ====
@interface IDOSetLeftOrRightInfoBuletoothModel : IDOBluetoothBaseModel

/**
 是否右手佩戴
 */
@property (nonatomic,assign) BOOL isRight;

/**
 左右手穿戴 model 转结构体 (内部使用)
 
 @param data 结构体指针
 */
- (void)leftOrRightModelToStructure:(void *)data;

/**
 查询数据库,如果查询不到初始化新的model对象
 
 @return IDOSetLeftOrRightInfoBuletoothModel
 */
+ (__kindof IDOSetLeftOrRightInfoBuletoothModel *)currentModel;
@end

#pragma mark ==== 设置寻找手机model ====
@interface IDOSetFindPhoneInfoBuletoothModel : IDOBluetoothBaseModel

/**
 寻找手机开关
 */
@property (nonatomic,assign) BOOL isOpen;

/**
 寻找手机 model 转结构体 (内部使用)
 
 @param data 结构体指针
 */
- (void)findPhoneModelToStructure:(void *)data;

/**
 查询数据库,如果查询不到初始化新的model对象
 
 @return IDOSetFindPhoneInfoBuletoothModel
 */
+ (__kindof IDOSetFindPhoneInfoBuletoothModel *)currentModel;
@end

#pragma mark ==== 设置一键呼叫model ====
@interface IDOSetOneKeySosInfoBuletoothModel : IDOBluetoothBaseModel

/**
 一键呼叫开关
 */
@property (nonatomic,assign) BOOL isOpen;

/**
 一键呼叫 model 转结构体 (内部使用)
 
 @param data 结构体指针
 */
- (void)oneKeySosModelToStructure:(void *)data;

/**
 查询数据库,如果查询不到初始化新的model对象
 
 @return IDOSetOneKeySosInfoBuletoothModel
 */
+ (__kindof IDOSetOneKeySosInfoBuletoothModel *)currentModel;
@end

#pragma mark ==== 设置开启蓝牙配对model ====
@interface IDOSetPairingInfoBuletoothModel : IDOBluetoothBaseModel

/**
 配对时间戳 time interval since 1970 (如:1444361933)
 */
@property (nonatomic,copy) NSString * pairingTimeStr;

/**
 是否配对
 */
@property (nonatomic,assign) BOOL isPairing;

/**
 蓝牙配对 model 转结构体 (内部使用)
 
 @param data 结构体指针
 */
- (void)switchPairingModelToStructure:(void *)data;

/**
 蓝牙配对 结构体转 model

 @param data 结构体指针
 @return IDOSetPairingInfoBuletoothModel
 */
+ (__kindof IDOSetPairingInfoBuletoothModel *)switchPairingStructToModel:(void *)data;

/**
 查询数据库,如果查询不到初始化新的model对象
 
 @return IDOSetPairingInfoBuletoothModel
 */
+ (__kindof IDOSetPairingInfoBuletoothModel *)currentModel;

@end

#pragma mark ==== 设置智能提醒model ====
@interface IDOSetNoticeInfoBuletoothModel : IDOBluetoothBaseModel

/**
 是否配对
 */
@property (nonatomic,assign) BOOL isPairing;

/**
 来电延迟
 */
@property (nonatomic,assign) NSInteger  callDelay;

/**
 是否开启子开关 (只对智能提醒有效,对来电提醒无效)
 */
@property (nonatomic,assign) BOOL isOnChild;

/**
 来电提醒
 */
@property (nonatomic,assign) BOOL isOnCall;

/**
 短信提醒
 */
@property (nonatomic,assign) BOOL isOnSms;

/**
 邮件提醒
 */
@property (nonatomic,assign) BOOL isOnEmail;

/**
 微信提醒
 */
@property (nonatomic,assign) BOOL isOnWeChat;

/**
 qq提醒
 */
@property (nonatomic,assign) BOOL isOnQq;

/**
 微博提醒
 */
@property (nonatomic,assign) BOOL isOnWeibo;

/**
 FaceBook 提醒
 */
@property (nonatomic,assign) BOOL isOnFaceBook;

/**
 Twitter 提醒
 */
@property (nonatomic,assign) BOOL isOnTwitter;

/**
 Whatsapp 提醒
 */
@property (nonatomic,assign) BOOL isOnWhatsapp;

/**
 Messenger 提醒
 */
@property (nonatomic,assign) BOOL isOnMessenger;

/**
 Instagram 提醒
 */
@property (nonatomic,assign) BOOL isOnInstagram;

/**
 LinkedIn 提醒
 */
@property (nonatomic,assign) BOOL isOnLinkedIn;

/**
 Calendar 提醒
 */
@property (nonatomic,assign) BOOL isOnCalendar;

/**
 Skype 提醒
 */
@property (nonatomic,assign) BOOL isOnSkype;

/**
 Alarm 提醒
 */
@property (nonatomic,assign) BOOL isOnAlarm;

/**
 Pokeman 提醒
 */
@property (nonatomic,assign) BOOL isOnPokeman;

/**
 Vkontakte 提醒
 */
@property (nonatomic,assign) BOOL isOnVkontakte;

/**
 Line 提醒
 */
@property (nonatomic,assign) BOOL isOnLine;

/**
 Viber 提醒
 */
@property (nonatomic,assign) BOOL isOnViber;

/**
 KakaoTalk 提醒
 */
@property (nonatomic,assign) BOOL isOnKakaoTalk;

/**
 Gmail 提醒
 */
@property (nonatomic,assign) BOOL isOnGmail;

/**
 Outlook 提醒
 */
@property (nonatomic,assign) BOOL isOnOutlook;

/**
 Snapchat 提醒
 */
@property (nonatomic,assign) BOOL isOnSnapchat;

/**
 Telegram 提醒
 */
@property (nonatomic,assign) BOOL isOnTelegram;

/**
 智能提醒 model 转结构体 (内部使用)
 
 @param data 结构体指针
 */
- (void)switchChildModelToStructure:(void *)data;

/**
 查询数据库,如果查询不到初始化新的model对象
 
 @return IDOSetNoticeInfoBuletoothModel
 */
+ (__kindof IDOSetNoticeInfoBuletoothModel *)currentModel;

/**
 通知提醒开关状态结构体转model (内部使用)

 @param data 通知提醒开关状态结构体
 @return IDOSetNoticeInfoBuletoothModel
 */
+ (__kindof IDOSetNoticeInfoBuletoothModel *)switchNoticeStructToModel:(void *)data;

@end

#pragma mark ==== 设置用户信息model ====
@interface IDOSetUserInfoBuletoothModel : IDOBluetoothBaseModel

/**
 身高
 */
@property (nonatomic,assign) NSInteger height;

/**
 当前体重
 */
@property (nonatomic,assign) NSInteger weight;

/**
 性别 1: 男 2 ：女
 */
@property (nonatomic,assign) NSInteger gender;

/**
 年
 */
@property (nonatomic,assign) NSInteger year;

/**
 月
 */
@property (nonatomic,assign) NSInteger month;

/**
 日
 */
@property (nonatomic,assign) NSInteger day;

/**
 目标睡眠 (时)
 */
@property (nonatomic,assign) NSInteger goalSleepDataHour;

/**
 目标睡眠 (分)
 */
@property (nonatomic,assign) NSInteger goalSleepDataMinute;

/**
 目标步数
 */
@property (nonatomic,assign) NSInteger goalStepData;

/**
 目标卡路里
 */
@property (nonatomic,assign) NSInteger goalCalorieData;

/**
 目标距离
 */
@property (nonatomic,assign) NSInteger goalDistanceData;

/**
 目标体重
 */
@property (nonatomic,assign) NSInteger goalWeightData;

/**
 目标类型 (类型 : 0 : 步数  1 : 卡路里  2 : 距离) 设置一种类型的目标需要执行一次命令
 */
@property (nonatomic,assign) NSInteger goalType;

/**
 是否登陆
 */
@property (nonatomic,assign) BOOL isLogin;

/**
 绑定状态
 */
@property (nonatomic,assign) NSInteger bindState;

/**
 用户信息 model 转结构体 (内部使用)

 @param data 结构体指针
 */
- (void)userInfoModelToStructure:(void *)data;

/**
 步数目标 model 转结构体 (内部使用)
 
 @param data 结构体指针
 */
- (void)targetModelToStructure:(void *)data;

/**
 卡路里和距离目标 model 转结构体 (内部使用)
 
 @param data 结构体指针
 */
- (void)calorieAndDistanceModelToStructure:(void *)data;

/**
 查询数据库,如果查询不到初始化新的model对象
 
 @return IDOSetUserInfoBuletoothModel
 */
+ (__kindof IDOSetUserInfoBuletoothModel *)currentModel;


@end

@interface IDOSetInfoBluetoothModel : IDOBluetoothBaseModel

@end

