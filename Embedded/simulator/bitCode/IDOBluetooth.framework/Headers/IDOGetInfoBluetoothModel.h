//
//  IDOGetInfoBluetoothModel.h
//  VeryfitSDK
//
//  Created by apple on 2018/7/20.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "IDOBluetoothBaseModel.h"

#pragma mark ==== 获取版本信息model ====
@interface IDOGetVersionInfoBluetoothModel:IDOBluetoothBaseModel

/**
 SDK版本 数值为x10,11表示1.1的版本
 */
@property (nonatomic,assign) NSInteger sdkVersion;

/**
 心率算法版本 数值为x10,11表示1.1的版本
 */
@property (nonatomic,assign) NSInteger hrAlgorithmVersion;

/**
 睡眠算法版本 数值为x10,11表示1.1的版本
 */
@property (nonatomic,assign) NSInteger sleepAlgorithmVersion;

/**
 计步算法版本 数值为x10,11表示1.1的版本
 */
@property (nonatomic,assign) NSInteger stepAlgorithmVersion;

/**
 手势识别算法 数值为x10,11表示1.1的版本
 */
@property (nonatomic,assign) NSInteger gestureRecognitionVersion;

/**
 PCB 版本 数值为x10,11表示1.1的版本
 */
@property (nonatomic,assign) NSInteger pcbVersion;

/**
 * @brief 版本信息结构体转model (内部使用) | Version information  structure body model (internal use)
 * @param data  结构体指针 | Structure pointer
 * @return IDOGetVersionInfoBluetoothModel
 */
+ (__kindof IDOGetVersionInfoBluetoothModel *)versionInfoStatusStructToModel:(void *)data;


/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetVersionInfoBluetoothModel
 */
+ (__kindof IDOGetVersionInfoBluetoothModel *)currentModel;

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

/**
 * @brief GPS状态结构体转model (内部使用) | GPS status structure body model (internal use)
 * @param data  结构体指针 | Structure pointer
 * @return IDOGetGpsStatusBluetoothModel
 */
+ (__kindof IDOGetGpsStatusBluetoothModel *)gpsStatusStructToModel:(void *)data;

@end


#pragma mark ==== 获取热启动参数model ====
@interface IDOGetHotStartParamBluetoothModel:IDOBluetoothBaseModel
/**
 晶振偏移 默认 200 |  crystals offset default 200
 */
@property (nonatomic,assign) NSInteger tcxoOffset;

/**
 * 当前位置的经度 当前经度 x 10^6 , 去掉小数,注意西经为负数 默认 0
 * The current position of the longitude of the current longitude x 10 ^ 6,
 * remove the decimal, pay attention to the scriptures is negative. default 0
 */
@property (nonatomic,assign) NSInteger longitude;

/**
 * 当前位置的纬度, x10^6 ,去掉小数,注意南纬为负数 默认 0
 * The current position of latitude, x10 ^ 6, remove the decimal,
 * pay attention to the south of the equator is negative. default 0
 */
@property (nonatomic,assign) NSInteger latitude;

/**
 当前位置的海拔高度 x10, 去掉小数 默认 0
 The altitude of the current position x10, get rid of the decimal. default 0
 */
@property (nonatomic,assign) NSInteger altitude;

/**
 * @brief  GPS热启动参数结构体转model (内部使用) | GPS hot start parameter structure body model (internal use)
 * @param data  结构体指针 | Structure pointer
 * @return IDOGetHotStartParamBluetoothModel
 */
+ (__kindof IDOGetHotStartParamBluetoothModel *)hotStartParamStructToModel:(void *)data;

/**
 * @brief GPS热启动参数model转结构体 (内部使用) |  GPS hot start parameter model to structure (internal use)
 * @param data 结构体指针 | Structure pointer
 */
- (void)hotStartParamModelToStruct:(void *)data;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetHotStartParamBluetoothModel
 */
+ (__kindof IDOGetHotStartParamBluetoothModel *)currentModel;

@end

#pragma mark ==== 获取GPS信息model ====
@interface IDOGetGpsInfoBluetoothModel:IDOBluetoothBaseModel

/**
 错误码 | error code
 */
@property (nonatomic,assign) NSInteger errorCode;

/**
 固件版本 | Firmware version
 */
@property (nonatomic,assign) NSInteger fwVersion;

/**
 GPS信息 |  GPS information
 */
@property (nonatomic,assign) NSInteger agpsInfo;

/**
 GPS错误码 | GPS error code
 */
@property (nonatomic,assign) NSInteger agpsErrCode;

/**
 * @brief GPS信息结构体转model (内部使用) | GPS information structure to model (internal use)
 * @param data 结构体指针 | Structure pointer
 * @return IDOGetGpsInfoBluetoothModel
 */
+ (__kindof IDOGetGpsInfoBluetoothModel *)gpsInfoStructToModel:(void *)data;

/**
 * @brief  查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetGpsInfoBluetoothModel
 */
+ (__kindof IDOGetGpsInfoBluetoothModel *)currentModel;

@end

#pragma mark ==== 获取hid信息model ====
@interface IDOGetHidInfoBluetoothModel:IDOBluetoothBaseModel

/**
 是否开启 | Whether to open
 */
@property (nonatomic,assign) BOOL isStart;

/**
 * @brief Hid信息结构体转model (内部使用) | Hid information structure to model (internal use)
 * @param data 结构体指针 |  Structure pointer
 * @return IDOGetHidInfoBluetoothModel
 */
+ (__kindof IDOGetHidInfoBluetoothModel *)hidInfoStructToModel:(void *)data;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象  (暂停使用,无效)
 * Query the database, if the query does not initialize a new model object (suspended, invalid)
 * @return IDOGetHidInfoBluetoothModel
 */
+ (__kindof IDOGetHidInfoBluetoothModel *)currentModel;

@end

#pragma mark ==== 获取活动和GPS个数信息model ====
@interface IDOGetActivityCountBluetoothModel:IDOBluetoothBaseModel

/**
 活动个数 | Number of activities
 */
@property (nonatomic,assign) NSInteger activityCount;

/**
 活动包数 | Number of active packages
 */
@property (nonatomic,assign) NSInteger activityPacketCount;

/**
 GPS个数 | Number of GPS data
 */
@property (nonatomic,assign) NSInteger gpsCount;

/**
 GPS包数 | Number of GPS packets
 */
@property (nonatomic,assign) NSInteger gpsPacketCount;

/**
 * @brief 活动和GPS个数信息结构体转model (内部使用)
 * Activity and GPS number information structure to model (internal use)
 * @param data 结构体指针 | Structure pointer
 * @return IDOGetActivityCountBluetoothModel
 */
+ (__kindof IDOGetActivityCountBluetoothModel *)activityCountStructToModel:(void *)data;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象 (未作存储处理，只会初始化新对象)
 * Query the database, if the query does not initialize a new model object (not stored for processing, only the new object will be initialized)
 * @return IDOGetActivityCountBluetoothModel
 */
+ (__kindof IDOGetActivityCountBluetoothModel *)currentModel;

@end

#pragma mark ==== 获取加速度传感器参数信息model ====
@interface IDOGetGsensorParamBluetoothModel:IDOBluetoothBaseModel

/**
 率 |  rate
 */
@property (nonatomic,assign) NSInteger rate;

/**
 间隔 | range
 */
@property (nonatomic,assign) NSInteger range;

/**
 阀值 |  Threshold
 */
@property (nonatomic,assign) NSInteger threshold;

/**
 * @brief 加速度传感器参数结构体转model (内部使用)
 * Acceleration sensor parameter structure body model (internal use)
 * @param data 结构体指针 | Structure pointer
 * @return IDOGetGsensorParamBluetoothModel
 */
+ (__kindof IDOGetGsensorParamBluetoothModel *)gsensorParamStructToModel:(void *)data;

/**
 * @brief 加速度传感器参数model转结构体 (内部使用)
 * Acceleration sensor parameter model to structure (internal use)
 * @param data 结构体指针
 */
- (void)gsensorParamModelToStruct:(void *)data;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象 (暂停使用,无效)
 * Query the database, if the query does not initialize a new model object (suspended, invalid)
 * @return IDOGetHrSensorParamBluetoothModel
 */
+ (__kindof IDOGetGsensorParamBluetoothModel *)currentModel;
@end

#pragma mark ==== 获取心率传感器参数信息model ====
@interface IDOGetHrSensorParamBluetoothModel:IDOBluetoothBaseModel

/**
 心率值 | Heart rate value
 */
@property (nonatomic,assign) NSInteger rate;

/**
 (未知参数) | (unknown parameter)
 */
@property (nonatomic,assign) NSInteger ledSelect;

/**
 * @brief 心率传感器参数结构体转model (内部使用)
 * Heart rate sensor parameter structure body model (internal use)
 * @param data 结构体指针 | Structure pointer
 * @return IDOGetHrSensorParamBluetoothModel
 */
+ (__kindof IDOGetHrSensorParamBluetoothModel *)hrSensorParamStructToModel:(void *)data;

/**
 * @brief 心率传感器参数model转结构体 (内部使用)
 * Heart rate sensor parameter model to structure (internal use)
 * @param data 结构体指针  | Structure pointer
 */
- (void)hrSensorParamModelToStruct:(void *)data;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象 *(暂停使用,无效)
 * Query the database, if the query does not initialize a new model object (suspended, invalid)
 * @return IDOGetHrSensorParamBluetoothModel
 */
+ (__kindof IDOGetHrSensorParamBluetoothModel *)currentModel;

@end

#pragma mark ==== 获取设备时间信息model ====
@interface IDOGetDeviceTimeBluetoothModel:IDOBluetoothBaseModel

/**
 * 年 | year
 *
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
 分 | Minute
 */
@property (nonatomic,assign) NSInteger minute;

/**
 秒 | second
 */
@property (nonatomic,assign) NSInteger second;

/**
 周 | week
 */
@property (nonatomic,assign) NSInteger week;

/**
 * @brief 设备时间结构体转model (内部使用) |  Device time structure body model (internal use)
 * @param data 结构体指针 | Structure pointer
 * @return return IDOGetDeviceTimeBluetoothModel
 */
+ (__kindof IDOGetDeviceTimeBluetoothModel *)deviceTimeStructToModel:(void *)data;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象 *(暂停使用,无效)
 * Query the database, if the query does not initialize a new model object (suspended, invalid)
 * @return IDOGetDeviceTimeBluetoothModel
 */
+ (__kindof IDOGetDeviceTimeBluetoothModel *)currentModel;
@end

#pragma mark ==== 获取实时数据信息model ====
@interface IDOGetLiveDataBluetoothModel:IDOBluetoothBaseModel

/**
 步数 | Step count
 */
@property (nonatomic,assign) NSInteger step;

/**
 卡路里 | Calorie
 */
@property (nonatomic,assign) NSInteger calories;

/**
 距离 | distance
 */
@property (nonatomic,assign) NSInteger distances;

/**
 活动时长 | Duration of activity
 */
@property (nonatomic,assign) NSInteger activeTime;

/**
 心率 | Heart rate
 */
@property (nonatomic,assign) NSInteger heartRate;

/**
 * @brief 实时数据结构体转model (内部使用) | Real-time data structure body model (internal use)
 * @param data 结构体指针
 * @return IDOGetLiveDataBluetoothModel
 */

+ (__kindof IDOGetLiveDataBluetoothModel *)liveDataStructToModel:(void *)data;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetLiveDataBluetoothModel
 */
+ (__kindof IDOGetLiveDataBluetoothModel *)currentModel;

@end

#pragma mark ==== 获取新增消息提醒model ====
@interface IDOGetExNotify4BluetoothModel:IDOBluetoothBaseModel
/**
 聊天工作 | chatwork
 */
@property (nonatomic,assign) BOOL chatwork;

/**
 松弛 | slack
 */
@property (nonatomic,assign) BOOL slack;

/**
 * @brief 根据扩展消息提醒功能表结构体转换model (内部使用)
 * Conversion model according to extended function notify 4 structure (internal use)
 * @param data 结构体指针 | Structure pointer
 * @return IDOGetExNotify4BluetoothModel
 */
+ (__kindof IDOGetExNotify4BluetoothModel *)funcNotify4StructToModel:(void *)data;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetExNotify4BluetoothModel
 */
+ (__kindof IDOGetExNotify4BluetoothModel *)currentModel;
@end

#pragma mark ==== 获取扩展功能2列表信息model ====
@interface IDOGetFuncExtend2BluetoothModel:IDOBluetoothBaseModel

/**
 女性生理周期 | Female physiological cycle
 */
@property (nonatomic,assign) BOOL menstruation;

/**
 卡路里目标 | Calorie goal
 */
@property (nonatomic,assign) BOOL calorieGoal;

/**
 距离目标 | Distance target
 */
@property (nonatomic,assign) BOOL distanceGoal;

/**
 血氧数据 | Blood oxygen
 */
@property (nonatomic,assign) BOOL spo2Data;

/**
 压力数据 | pressure data
 */
@property (nonatomic,assign) BOOL pressureData;

/**
 获取勿扰模式 | get do not disturb
 */
@property (nonatomic,assign) BOOL getNoDisturb;

/**
 运动模式排序 | sport mode sort
 */
@property (nonatomic,assign) BOOL sportModeSort;

/**
 通知消息字节250 | notice message 250 byte
 */
@property (nonatomic,assign) BOOL noticeByte;

/**
 * @brief 根据扩展功能2列表结构体转换model (内部使用)
 * Conversion model according to extended function 2 list structure (internal use)
 * @param data 结构体指针 | Structure pointer
 * @return IDOGetFuncExtend2BluetoothModel
 */

+ (__kindof IDOGetFuncExtend2BluetoothModel *)funcExtend2StructToModel:(void *)data;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetFuncExtend2BluetoothModel
 */
+ (__kindof IDOGetFuncExtend2BluetoothModel *)currentModel;

@end

#pragma mark ==== 获取扩展功能列表信息model ====
@interface IDOGetFuncExtendBluetoothModel:IDOBluetoothBaseModel

/**
 gps
 */
@property (nonatomic,assign) BOOL gps;

/**
 睡眠时间段 | Sleep period
 */
@property (nonatomic,assign) BOOL sleepPeriod;

/**
 屏幕亮度调节 |  Screen brightness adjustment
 */
@property (nonatomic,assign) BOOL screenBrightness;

/**
 id107l 表盘 |  Id107l dial
 */
@property (nonatomic,assign) BOOL id107Dial;

/**
 未知 属性 | Unknown attribute
 */
@property (nonatomic,assign) BOOL dhNewAppNotice;

/**
 128字节通知 | 128 byte notification
 */
@property (nonatomic,assign) BOOL noitice128Byte;

/**
 获取时间同步 | Get time synchronization
 */
@property (nonatomic,assign) BOOL activityTimeSync;

/**
 v3 收集 | Collection log
 */
@property (nonatomic,assign) BOOL v3Log;

/**
 * @brief 根据扩展功能列表结构体转换model (内部使用)
 * Convert model according to extended function list structure (internal use)
 * @param data 结构体指针 | Structure pointer
 * @return IDOGetFuncExtendBluetoothModel
 */
+ (__kindof IDOGetFuncExtendBluetoothModel *)funcExtendStructToModel:(void *)data;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetFuncExtendBluetoothModel
 */
+ (__kindof IDOGetFuncExtendBluetoothModel *)currentModel;

@end

#pragma mark ==== 获取主功能1列表信息model ====
@interface IDOGetMainFunc1BluetoothModel:IDOBluetoothBaseModel

/**
 登陆 | login
 */
@property (nonatomic,assign) BOOL logIn;

/**
 手环自带相机拍照 | Bracelet comes with a camera to take pictures
 */
@property (nonatomic,assign) BOOL hidPhoto;

/**
 表盘 | dial
 */
@property (nonatomic,assign) BOOL watchDial;

/**
 快捷方式 | Shortcut
 */
@property (nonatomic,assign) BOOL shortcut;

/**
 单位分开设置 |  Units are set separately
 */
@property (nonatomic,assign) BOOL unitSet;

/**
 血压 | blood pressure
 */
@property (nonatomic,assign) BOOL bloodPressure;

/**
 微信运动 |  WeChat Sport
 */
@property (nonatomic,assign) BOOL wechatSport;

/**
 精细的时间段控制 | Fine time period control
 */
@property (nonatomic,assign) BOOL fineTimeControl;

/**
 * @brief 主功能表2结构体转model (内部使用) | Main function table 2 structure body model (internal use)
 * @param data 结构体指针 | Structure pointer
 * @return IDOGetMainFunc1BluetoothModel
 */
+ (__kindof IDOGetMainFunc1BluetoothModel *)mainFunc1StructToModel:(void *)data;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetMainFunc1BluetoothModel
 */
+ (__kindof IDOGetMainFunc1BluetoothModel *)currentModel;

@end

#pragma mark ==== 获取运动类型3功能列表信息model ====
@interface IDOGetSportType3BluetoothModel:IDOBluetoothBaseModel

/**
 高尔夫 | Golf
 */
@property (nonatomic,assign) BOOL golf;

/**
 棒球 | baseball
 */
@property (nonatomic,assign) BOOL baseball;

/**
 滑雪 | ski
 */
@property (nonatomic,assign) BOOL skiing;

/**
 轮滑 | Roller
 */
@property (nonatomic,assign) BOOL rollerSkating;

/**
 跳舞 | dancing
 */
@property (nonatomic,assign) BOOL dance;

/**
 * @brief 运动模式3结构体转model (内部使用) | Sports mode 3 structure body model (internal use)
 * @param data 结构体指针 | Structure pointer
 * @return IDOGetSportType3BluetoothModel
 */
+ (__kindof IDOGetSportType3BluetoothModel *)sportType3StructToModel:(void *)data;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetSportType3BluetoothModel
 */
+ (__kindof IDOGetSportType3BluetoothModel *)currentModel;

@end

#pragma mark ==== 获取运动类型2功能列表信息model ====
@interface IDOGetSportType2BluetoothModel:IDOBluetoothBaseModel

/**
 健身操  |  Aerobics
 */
@property (nonatomic,assign) BOOL bodybuildingExercise;

/**
 瑜伽 |  Yoga
 */
@property (nonatomic,assign) BOOL yoga;

/**
 跳绳 |  rope skipping
 */
@property (nonatomic,assign) BOOL ropeSkipping;
/**
 乒乓球 |  pingpong
 */
@property (nonatomic,assign) BOOL tableTennis;

/**
 篮球  | basketball
 */
@property (nonatomic,assign) BOOL basketball;

/**
 足球  | football
 */
@property (nonatomic,assign) BOOL football;

/**
 排球  | volleyball
 */
@property (nonatomic,assign) BOOL volleyball;

/**
 网球 |  tennis
 */
@property (nonatomic,assign) BOOL tennis;

/**
 * @brief 运动模式2结构体转model (内部使用) |  Sports mode 2 structure to model (internal use)
 * @param data 结构体指针 | Structure pointer
 * @return IDOGetSportType2BluetoothModel
 */
+ (__kindof IDOGetSportType2BluetoothModel *)sportType2StructToModel:(void *)data;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetSportType2BluetoothModel
 */
+ (__kindof IDOGetSportType2BluetoothModel *)currentModel;

@end

#pragma mark ==== 获取运动类型1功能列表信息model ====
@interface IDOGetSportType1BluetoothModel:IDOBluetoothBaseModel

/**
 健身 | Fitness
 */
@property (nonatomic,assign) BOOL fitness;

/**
 动感单车 |  Spinning bike
 */
@property (nonatomic,assign) BOOL spinning;

/**
 椭圆球 | Oval ball
 */
@property (nonatomic,assign) BOOL ellipsoid;

/**
 跑步机 | Treadmill
 */
@property (nonatomic,assign) BOOL treadmill;

/**
 仰卧起坐 |  Sit-ups
 */
@property (nonatomic,assign) BOOL sitUp;

/**
 俯卧撑 | push ups
 */
@property (nonatomic,assign) BOOL pushUp;

/**
 哑铃 | Dumbbell
 */
@property (nonatomic,assign) BOOL dumbbell;

/**
 举重 | weightlifting
 */
@property (nonatomic,assign) BOOL weightlifting;

/**
 * @brief 运动模式1结构体转model (内部使用) | Sports mode 1 structure to model (internal use)
 * @param data 结构体指针 | Structure pointer
 * @return IDOGetSportType1BluetoothModel
 */
+ (__kindof IDOGetSportType1BluetoothModel *)sportType1StructToModel:(void *)data;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetSportType1BluetoothModel
 */

+ (__kindof IDOGetSportType1BluetoothModel *)currentModel;
@end

#pragma mark ==== 获取运动类型0功能列表信息model ====
@interface IDOGetSportType0BluetoothModel:IDOBluetoothBaseModel

/**
 走路 | walk
 */
@property (nonatomic,assign) BOOL walk;

/**
 跑步 |  Run
 */
@property (nonatomic,assign) BOOL run;

/**
 骑行 | Riding
 */
@property (nonatomic,assign) BOOL byBike;

/**
 徒步 | on foot
 */
@property (nonatomic,assign) BOOL onFoot;

/**
 游泳 | Swim
 */
@property (nonatomic,assign) BOOL swim;

/**
 爬山 | Mountain climbing
 */
@property (nonatomic,assign) BOOL mountainClimbing;

/**
 羽毛球 | badminton
 */
@property (nonatomic,assign) BOOL badminton;

/**
 其他 | other
 */
@property (nonatomic,assign) BOOL other;

/**
 * @brief 运动模式0结构体转model (内部使用) | Sports mode 0 structure to model (internal use)
 * @param data 结构体指针 | Structure pointer
 * @return IDOGetSportType0BluetoothModel
 */
+ (__kindof IDOGetSportType0BluetoothModel *)sportType0StructToModel:(void *)data;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetSportType0BluetoothModel
 */
+ (__kindof IDOGetSportType0BluetoothModel *)currentModel;

@end

#pragma mark ==== 获取其他扩展功能列表信息model ====
@interface IDOGetOtherFuncExtendBluetoothModel:IDOBluetoothBaseModel

/**
 静态心率 |  Static heart rate
 */
@property (nonatomic,assign) BOOL staticHr;

/**
 防打扰 | Anti-disturbance
 */
@property (nonatomic,assign) BOOL doNotDisturb;

/**
 显示模式 | Display mode
 */
@property (nonatomic,assign) BOOL displayMode;

/**
 心率监测 | Heart rate monitoring
 */
@property (nonatomic,assign) BOOL heartRateMonitor;

/**
 双向防丢 | Two-way anti-lost
 */
@property (nonatomic,assign) BOOL bilateralAntiLost;

/**
 所有通知提醒 | All notification reminders
 */
@property (nonatomic,assign) BOOL allAppNotice;

/**
 不显示心率区间 | Does not show heart rate interval
 */
@property (nonatomic,assign) BOOL noShowHrInterval;

/**
 翻转屏幕 | Flip the screen
 */
@property (nonatomic,assign) BOOL flipScreen;

/**
 *@brief其他扩展功能列表结构体转model (内部使用)
 * Other extended function list structure to model (internal use)
 *@param data 结构体指针 | Structure pointer
 *@return IDOGetOtherFuncExtendBluetoothModel
 */
+ (__kindof IDOGetOtherFuncExtendBluetoothModel *)otherFuncExtendStructToModel:(void *)data;

/**
 *@brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 *@return IDOGetOtherFuncExtendBluetoothModel
 */
+ (__kindof IDOGetOtherFuncExtendBluetoothModel *)currentModel;

@end

#pragma mark ==== 获取信息提醒配置功能列表信息model ====
@interface IDOGetSmsTableBluetoothModel:IDOBluetoothBaseModel

/**
 提示信息联系人 | Tips Contact
 */
@property (nonatomic,assign) BOOL tipInfoContact;

/**
 提示信息号码 | Message number
 */
@property (nonatomic,assign) BOOL tipInfoNum;

/**
 提醒信息内容 | Reminder content
 */
@property (nonatomic,assign) BOOL tipInfoContent;

/**
 * @brief 信息提醒配置功能列表结构体转model (内部使用)
 * Information Reminder Configuration Function List Structure Transfer Model (internal use)
 * @param data 结构体指针 | Structure pointer
 * @return IDOGetSMSTableBluetoothModel
 */
+ (__kindof IDOGetSmsTableBluetoothModel *)smsTableStructToModel:(void *)data;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetSmsTableBluetoothModel
 */
+ (__kindof IDOGetSmsTableBluetoothModel *)currentModel;

@end

#pragma mark ==== 获取其他功能列表信息model ====
@interface IDOGetOtherFuncBluetoothModel:IDOBluetoothBaseModel

/**
 久坐提醒 | Sedentary reminder
 */
@property (nonatomic,assign) BOOL sedentariness;

/**
 防丢提醒 | Anti-lost reminder
 */
@property (nonatomic,assign) BOOL antilost;

/**
 一键呼叫 | One-click calling
 */
@property (nonatomic,assign) BOOL onetouchCalling;

/**
 寻找手机 | Looking for a mobile phone
 */
@property (nonatomic,assign) BOOL findPhone;

/**
 寻找手环 | Looking for a bracelet
 */
@property (nonatomic,assign) BOOL findDevice;

/**
 默认模式 | Default mode
 */
@property (nonatomic,assign) BOOL configDefault;

/**
 手势 | Gestures
 */
@property (nonatomic,assign) BOOL upHandGesture;

/**
 天气预报 | Weather forecast
 */
@property (nonatomic,assign) BOOL weather;

/**
 * @brief 其他功能列表结构体转model (内部使用)
 * Other function list structure to model (internal use)
 * @param data 结构体指针 | Structure pointer
 * @return IDOGetOtherFuncBluetoothModel
 */
+ (__kindof IDOGetOtherFuncBluetoothModel *)otherFuncStructToModel:(void *)data;

/**
  * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
  * @return IDOGetOtherFuncBluetoothModel
 */
+ (__kindof IDOGetOtherFuncBluetoothModel *)currentModel;

@end

#pragma mark ==== 获取信息2提醒功能列表信息model ====
@interface IDOGetNotify2BluetoothModel:IDOBluetoothBaseModel

/**
 vkontakte
 */
@property (nonatomic,assign) BOOL vkontakte;

/**
 line
 */
@property (nonatomic,assign) BOOL line;

/**
 viber
 */
@property (nonatomic,assign) BOOL viber;

/**
 kakaoTalk
 */
@property (nonatomic,assign) BOOL kakaoTalk;

/**
 gmail
 */
@property (nonatomic,assign) BOOL gmail;

/**
 outlook
 */
@property (nonatomic,assign) BOOL outlook;

/**
 snapchat
 */
@property (nonatomic,assign) BOOL snapchat;

/**
 telegram
 */
@property (nonatomic,assign) BOOL telegram;

/**
 * @brief 信息2提醒功能列表结构体转model (内部使用)
 * Information 2 reminder function list structure body model (internal use)
 * @param data 结构体指针 | Structure pointer
 * @return IDOGetNotify2BluetoothModel
 */
+ (__kindof IDOGetNotify2BluetoothModel *)notify2StructToModel:(void *)data;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetNotify2BluetoothModel
 */
+ (__kindof IDOGetNotify2BluetoothModel *)currentModel;

@end

#pragma mark ==== 获取信息1提醒功能列表信息model ====
@interface IDOGetNotify1BluetoothModel:IDOBluetoothBaseModel

/**
 whatsapp
 */
@property (nonatomic,assign) BOOL whatsapp;

/**
 messengre
 */
@property (nonatomic,assign) BOOL messengre;

/**
 instagram
 */
@property (nonatomic,assign) BOOL instagram;

/**
 linkedIn
 */
@property (nonatomic,assign) BOOL linkedIn;

/**
 calendar
 */
@property (nonatomic,assign) BOOL calendar;

/**
 skype
 */
@property (nonatomic,assign) BOOL skype;

/**
 alarmClock
 */
@property (nonatomic,assign) BOOL alarmClock;

/**
 * @brief 信息1提醒功能列表结构体转model (内部使用)
 * Information 1 Reminder function list structure body model (internal use)
 * @param data 结构体指针 | Structure pointer
 * @return IDOGetNotify1BluetoothModel
 */
+ (__kindof IDOGetNotify1BluetoothModel *)notify1StructToModel:(void *)data;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetNotify1BluetoothModel
 */
+ (__kindof IDOGetNotify1BluetoothModel *)currentModel;

@end

#pragma mark ==== 获取信息0提醒功能列表信息model ====
@interface IDOGetNotify0BluetoothModel:IDOBluetoothBaseModel

/**
 短信 | SMS
 */
@property (nonatomic,assign) BOOL message;

/**
 邮件 | Mail
 */
@property (nonatomic,assign) BOOL email;

/**
 qq
 */
@property (nonatomic,assign) BOOL qq;

/**
 微信 | WeChat
 */
@property (nonatomic,assign) BOOL weixin;

/**
 新浪 | Sina
 */
@property (nonatomic,assign) BOOL sinaWeibo;

/**
 facebook
 */
@property (nonatomic,assign) BOOL facebook;

/**
 twitter
 */
@property (nonatomic,assign) BOOL twitter;

/**
 * @brief 信息0提醒功能列表结构体转model (内部使用)
 * Information 0 reminder function list structure body model (internal use)
 * @param data 结构体指针 | Structure pointer
 * @return IDOGetNotify0BluetoothModel
 */
+ (__kindof IDOGetNotify0BluetoothModel *)notify0StructToModel:(void *)data;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetNotify0BluetoothModel
 */
+ (__kindof IDOGetNotify0BluetoothModel *)currentModel;
@end

#pragma mark ==== 获取来电提醒功能列表信息model ====
@interface IDOGetTableCallBluetoothModel:IDOBluetoothBaseModel

/**
 来电提醒 | Call reminder
 */
@property (nonatomic,assign) BOOL calling;

/**
 来电联系人 | Caller contact
 */
@property (nonatomic,assign) BOOL callingContact;

/**
 来电号码 | Caller ID
 */
@property (nonatomic,assign) BOOL callingNum;

/**
 * @brief 来电提醒功能列表结构体转model (内部使用)
 * Call alert feature list structure to model (internal use)
 * @param data 结构体指针 | Structure pointer
 * @return IDOGetTableCallBluetoothModel
 */
+ (__kindof IDOGetTableCallBluetoothModel *)tableCallStructToModel:(void *)data;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetTableCallBluetoothModel
 */
+ (__kindof IDOGetTableCallBluetoothModel *)currentModel;
@end

#pragma mark ==== 获取闹钟功能列表信息model ====
@interface IDOGetAlarmFuncBluetoothModel:IDOBluetoothBaseModel

/**
 起床 | Get up
 */
@property (nonatomic,assign) BOOL wakeUp;

/**
 睡觉 | Sleeping
 */
@property (nonatomic,assign) BOOL sleep;

/**
 锻炼 | Exercise
 */
@property (nonatomic,assign) BOOL sport;

/**
 吃药 | Taking medicine
 */
@property (nonatomic,assign) BOOL medicine;

/**
 约会 | Dating
 */
@property (nonatomic,assign) BOOL dating;

/**
 聚会 | Party
 */
@property (nonatomic,assign) BOOL party;

/**
 会议 | Meeting
 */
@property (nonatomic,assign) BOOL metting;

/**
 自定义 | Customization
 */
@property (nonatomic,assign) BOOL custom;

/**
 * @brief 闹钟功能列表结构体转model (内部使用)
 * Alarm function list structure structure model (internal use)
 * @param data 结构体指针 | Structure pointer
 * @return IDOGetAlarmBluetoothModel
 */
+ (__kindof IDOGetAlarmFuncBluetoothModel *)alarmStructToModel:(void *)data;

/**
 * @brief  查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetAlarmFuncBluetoothModel
 */
+ (__kindof IDOGetAlarmFuncBluetoothModel *)currentModel;
@end

#pragma mark ==== 获取控制功能列表信息model ====
@interface IDOGetTableControlBluetoothModel:IDOBluetoothBaseModel

/**
 拍照 | taking pictures
 */
@property (nonatomic,assign) BOOL takePhoto;

/**
 音乐 | Music
 */
@property (nonatomic,assign) BOOL music;

/**
 控制拍照 | Control photo
 */
@property (nonatomic,assign) BOOL hidPhoto;

/**
 5个心率区间 | 5 heart rate intervals
 */
@property (nonatomic,assign) BOOL fiveHrInterval;

/**
 绑定授权 | Binding Authorization
 */
@property (nonatomic,assign) BOOL bindAuth;

/**
 快速同步 | Quick sync
 */
@property (nonatomic,assign) BOOL fastSync;

/**
 扩展功能 | Extended Features
 */
@property (nonatomic,assign) BOOL exFuncTable;

/**
 绑定码授权 | Binding Code Authorization
 */
@property (nonatomic,assign) BOOL bindCodeAuth;

/**
 * @brief  控制功能列表结构体转model (内部使用)
 * Control function list structure body model (internal use)
 * @param data 结构体指针 | Structure pointer
 * @return IDOGetTableControlBluetoothModel
 */
+ (__kindof IDOGetTableControlBluetoothModel *)tableControlStructToModel:(void *)data;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetTableControlBluetoothModel
 */
+ (__kindof IDOGetTableControlBluetoothModel *)currentModel;
@end

#pragma mark ==== 获取主功能列表信息model ====
@interface IDOGetMainFuncBluetoothModel:IDOBluetoothBaseModel

/**
 步数 | Number of steps
 */
@property (nonatomic,assign) BOOL stepCalculation;

/**
 睡眠检测 | Sleep detection
 */
@property (nonatomic,assign) BOOL sleepMonitor;

/**
 单次运动 | Single movement
 */
@property (nonatomic,assign) BOOL singleSport;

/**
 实时数据 | Real-time data
 */
@property (nonatomic,assign) BOOL realtimeData;

/**
 设备更新 | Equipment Update
 */
@property (nonatomic,assign) BOOL deviceUpdate;

/**
 心率功能 | Heart rate function
 */
@property (nonatomic,assign) BOOL heartRate;

/**
 通知中心 | Notification Center
 */
@property (nonatomic,assign) BOOL ancs;

/**
 时间线 | Timeline
 */
@property (nonatomic,assign) BOOL timeLine;

/**
 * @brief 主功能列表结构体转model (内部使用)
 * Main function list structure to model (internal use)
 * @param data 结构体指针 | Structure pointer
 * @return IDOGetMainFuncBluetoothModel
 */
+ (__kindof IDOGetMainFuncBluetoothModel *)mainFuncStructToModel:(void *)data;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetMainFuncBluetoothModel
 */
+ (__kindof IDOGetMainFuncBluetoothModel *)currentModel;

@end

#pragma mark ==== 获取语言扩展功能2列表信息model ====
@interface IDOGetLangExtend2SupportBluetoothModel:IDOBluetoothBaseModel

/**
 斯洛伐克语 | Slovak
 */
@property (nonatomic,assign) BOOL slovak;

/**
 丹麦语 | Danish
 */
@property (nonatomic,assign) BOOL danish;

/**
 克罗地亚语 | Croatian
 */
@property (nonatomic,assign) BOOL croatian;

/**
 * @brief 根据语言扩展2结构体初始化model (内部使用)
 * Initialize model according to language extension 2 structure (internal use)
 * @param data 结构体指针 | Structure pointer
 * @return IDOGetLangExtend2SupportBluetoothModel
 */
+ (__kindof IDOGetLangExtend2SupportBluetoothModel *)langExtend2SupportStructToModel:(void *)data;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetLangExtend2SupportBluetoothModel
 */
+ (__kindof IDOGetLangExtend2SupportBluetoothModel *)currentModel;

@end


#pragma mark ==== 获取语言扩展功能列表信息model ====
@interface IDOGetLangExtendSupportBluetoothModel:IDOBluetoothBaseModel

/**
 罗马尼亚文 | Romanian
 */
@property (nonatomic,assign) BOOL romanian;

/**
 立陶宛文 | Lithuanian
 */
@property (nonatomic,assign) BOOL lithuanian;

/**
 荷兰文 | Dutch
 */
@property (nonatomic,assign) BOOL dutch;

/**
 斯洛文尼亚文 | Slovenian
 */
@property (nonatomic,assign) BOOL slovenian;

/**
 匈牙利文 | Hungarian
 */
@property (nonatomic,assign) BOOL hungarian;

/**
 波兰文 | Polish
 */
@property (nonatomic,assign) BOOL polish;

/**
 俄罗斯文 | Russian
 */
@property (nonatomic,assign) BOOL russian;

/**
 乌克兰文 | Ukrainian
 */
@property (nonatomic,assign) BOOL ukrainian;

/**
 * @brief 根据语言扩展结构体初始化model (内部使用)
 * Initialize model according to language extension structure (internal use)
 * @param data 结构体指针 | Structure pointer
 * @return IDOGetLangExtendSupportBluetoothModel
 */
+ (__kindof IDOGetLangExtendSupportBluetoothModel *)langExtendSupportStructToModel:(void *)data;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetLangExtendSupportBluetoothModel
 */
+ (__kindof IDOGetLangExtendSupportBluetoothModel *)currentModel;
@end

#pragma mark ==== 获取语言功能列表信息model ====
@interface IDOGetLangSupportBluetoothModel:IDOBluetoothBaseModel

/**
 中文 | Chinese
 */
@property (nonatomic,assign) BOOL ch;

/**
 英文 | English
 */
@property (nonatomic,assign) BOOL eng;

/**
 法文 | French
 */
@property (nonatomic,assign) BOOL french;

/**
 德文 | German
 */
@property (nonatomic,assign) BOOL german;

/**
 意大利文 | Italian
 */
@property (nonatomic,assign) BOOL italian;

/**
 西班牙文 | Spanish
 */
@property (nonatomic,assign) BOOL spanish;

/**
 日文 | Japanese
 */
@property (nonatomic,assign) BOOL japanese;

/**
 捷克文 | Czech
 */
@property (nonatomic,assign) BOOL czech;
/**
 * @brief 根据语言结构体初始化model (内部使用)
 * Initialize model according to language structure (internal use)
 * @param data 结构体指针 | Structure pointer
 * @return IDOGetLangSupportBluetoothModel
 */
+ (__kindof IDOGetLangSupportBluetoothModel *)langSupportStructToModel:(void *)data;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetLangSupportBluetoothModel
 */
+ (__kindof IDOGetLangSupportBluetoothModel *)currentModel;
@end

#pragma mark ==== 获取功能列表信息model ====
@interface IDOGetDeviceFuncBluetoothModel:IDOBluetoothBaseModel

/**
 语言功能列表 | Language feature list
 */
@property (nonatomic,strong) IDOGetLangSupportBluetoothModel       * langModel;

/**
 语言扩展功能列表 | List of language extensions
 */
@property (nonatomic,strong) IDOGetLangExtendSupportBluetoothModel * langExtendModel;

/**
 语言扩展2功能列表 | Language Extension 2 Feature List
 */
@property (nonatomic,strong) IDOGetLangExtend2SupportBluetoothModel * langExtend2Model;

/**
 主功能列表 | Main function list
 */
@property (nonatomic,strong) IDOGetMainFuncBluetoothModel         * mainFuncModel;

/**
 控制功能列表 | Control function list
 */
@property (nonatomic,strong) IDOGetTableControlBluetoothModel     * tableControlModel;

/**
 闹钟功能列表 | Alarm clock function list
 */
@property (nonatomic,strong) IDOGetAlarmFuncBluetoothModel        * alarmModel;

/**
 来电提醒功能列表 | Call alert feature list
 */
@property (nonatomic,strong) IDOGetTableCallBluetoothModel        * tableCallModel;

/**
 信息0提醒功能列表 | Information 0 reminder function list
 */
@property (nonatomic,strong) IDOGetNotify0BluetoothModel          * notify0Model;

/**
 信息1提醒功能列表 | Information 1 reminder function list
 */
@property (nonatomic,strong) IDOGetNotify1BluetoothModel          * notify1Model;

/**
 信息2提醒功能列表 | Information 2 reminder function list
 */
@property (nonatomic,strong) IDOGetNotify2BluetoothModel          * notify2Model;

/**
 其他功能列表 | Other features list
 */
@property (nonatomic,strong) IDOGetOtherFuncBluetoothModel        * otherFuncModel;

/**
 信息提醒配置功能列表 | Information Reminder Configuration List
 */
@property (nonatomic,strong) IDOGetSmsTableBluetoothModel         * smsTableModel;

/**
 其他扩展功能列表 | Other extended features list
 */
@property (nonatomic,strong) IDOGetOtherFuncExtendBluetoothModel  * otherFuncExtendModel;

/**
 运动类型0功能列表 | Sports Type 0 Function List
 */
@property (nonatomic,strong) IDOGetSportType0BluetoothModel       * sportType0Model;

/**
 运动类型1功能列表 | Sports Type 1 Feature List
 */
@property (nonatomic,strong) IDOGetSportType1BluetoothModel       * sportType1Model;

/**
 运动类型2功能列表 | Sports Type 2 Feature List
 */
@property (nonatomic,strong) IDOGetSportType2BluetoothModel       * sportType2Model;

/**
 运动类型3功能列表 | Sports Type 3 Feature List
 */
@property (nonatomic,strong) IDOGetSportType3BluetoothModel       * sportType3Model;

/**
 主功能1列表 | Main function 1 list
 */
@property (nonatomic,strong) IDOGetMainFunc1BluetoothModel        * mainFunc1Model;

/**
 扩展功能列表 | Extended Features List
 */
@property (nonatomic,strong) IDOGetFuncExtendBluetoothModel       * funcExtendModel;

/**
 扩展功能列表2 | Extended Features List 2
 */
@property (nonatomic,strong) IDOGetFuncExtend2BluetoothModel      * funcExtend2Model;

/**
 扩展提醒功能4 | Extended Notify 4
 */
@property (nonatomic,strong) IDOGetExNotify4BluetoothModel        * exNotify4Model;

/**
 是否支持版本信息 | version information is supported
 */
@property (nonatomic,assign) BOOL versionInfo;

/**
 闹钟个数 | Number of alarms
 */
@property (nonatomic,assign) NSInteger alarmCount;

/**
 运动显示个数 | Number of sports displays
 */
@property (nonatomic,assign) NSInteger sportShowCount;

/**
 * @brief 设备功能列表结构体转model (内部使用)
 * Device function list structure body model (internal use)
 * @param data 结构体指针 | Structure pointer
 * @return IDOGetDeviceFuncBluetoothModel
 */
+ (__kindof IDOGetDeviceFuncBluetoothModel *)deviceFuncStructToModel:(void *)data;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetDeviceFuncBluetoothModel
 */
+ (__kindof IDOGetDeviceFuncBluetoothModel *)currentModel;
@end

#pragma mark ==== 获取设备信息model ====
@interface IDOGetDeviceInfoBluetoothModel:IDOBluetoothBaseModel

/**
 设备模式 | Device mode
 */
@property (nonatomic,assign) NSUInteger mode;

/**
 * 电量状态 （0x0:正常,0x01:正在充电,0x02:充满,0x03:电量低）
 * Battery status (0x0: normal,0x01: charging,0x02: full,0x03: low power)
 */
@property (nonatomic,assign) NSUInteger battStatus;

/**
 电量级别 （0～100）| Battery level
 */
@property (nonatomic,assign) NSUInteger battLevel;

/**
 是否重启 | Whether to restart
 */
@property (nonatomic,assign) NSUInteger rebootFlag;

/**
 绑定时间戳 | Binding timestamp
 */
@property (nonatomic,copy) NSString * bindTimeStr;

/**
 绑定状态 | Binding status
 */
@property (nonatomic,assign) NSInteger bindState;

/**
 * 绑定类型 | Binding type
 * 0x00默认(注意以前ID号定制),超时时间无效,
 * 0x01(单击[按键在下面]),
 * 0x02(为长按[按键在下面]),
 * 0x03(屏幕点击 横向确认和取消,确认在左边),
 * 0x04(屏幕点击 横向确认和取消,确认在右边)，
 * 0x05(屏幕点击 竖向确认和取消,确认在上边)，
 * 0x06(屏幕点击 竖向确认和取消,确认在下边),
 * 0x07点击(右边一个按键))
 */
@property (nonatomic,assign) NSInteger bindType;

/**
 * 绑定超时 | Binding timeout
 * 最长为15秒,0表示不超时
 */
@property (nonatomic,assign) NSInteger bindTimeout;

/**
 * @brief 设备信息结构体转model (内部使用) | Device information structure to model (internal use)
 * @param data 结构体指针 | Structure pointer
 * @return IDOGetDeviceInfoBluetoothModel
 */
+ (__kindof IDOGetDeviceInfoBluetoothModel *)deviceStructToModel:(void *)data;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetDeviceInfoBluetoothModel
 */
+ (__kindof IDOGetDeviceInfoBluetoothModel *)currentModel;

/**
 * @brief 查询本地所有设备信息（不包括Mac地址不存在的设备）
 * Query all local device information (excluding devices where Mac addresses do not exist)
 * @return IDOGetDeviceInfoBluetoothModel array
 */
+ (NSArray <__kindof IDOGetDeviceInfoBluetoothModel *>*)queryAllDeviceModels;

@end

#pragma mark ==== 获取mac地址model ====
@interface IDOGetMacAddrInfoBluetoothModel:IDOBluetoothBaseModel

/**
 * @brief Mac 地址结构体转model (内部使用) | Mac address structure to model (internal use)
 * @param data 结构体指针 | Structure pointer
 * @return IDOGetMacAddrInfoBluetoothModel
 */
+ (__kindof IDOGetMacAddrInfoBluetoothModel *)macAddrStructToModel:(void *)data;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetMacAddrInfoBluetoothModel
 */
+ (__kindof IDOGetMacAddrInfoBluetoothModel *)currentModel;
@end

@interface IDOGetInfoBluetoothModel : IDOBluetoothBaseModel

@end
