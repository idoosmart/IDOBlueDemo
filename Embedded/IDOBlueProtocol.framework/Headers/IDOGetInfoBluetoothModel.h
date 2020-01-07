//
//  IDOGetInfoBluetoothModel.h
//  VeryfitSDK
//
//  Created by apple on 2018/7/20.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#if __has_include(<IDOBluetoothInternal/IDOBluetoothInternal.h>)
#elif __has_include(<IDOBlueProtocol/IDOBlueProtocol.h>)
#else
#import "IDOBluetoothBaseModel.h"
#endif

#pragma mark ====  获取下载语言 model ====

@interface IDOGetDownLanguageBluetoothModel:IDOBluetoothBaseModel
/**
 * 当前使用的语言 | use lang
 */
@property (nonatomic,assign) NSInteger useLang;
/**
 * 默认语言 | default lang
 */
@property (nonatomic,assign) NSInteger defaultLang;
/**
 * 固定存储语言个数 | fixed lang count
 */
@property (nonatomic,assign) NSInteger fixedLangCount;
/**
 * 最大存储语言个数 | max storage lang
 */
@property (nonatomic,assign) NSInteger maxStorageLang;
/**
 * 已经存储语言值  |  language values
 */
@property (nonatomic,assign) NSArray * languageValues;
/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetDownLanguageBluetoothModel
 */
+ (__kindof IDOGetDownLanguageBluetoothModel *)currentModel;

@end

#pragma mark ====  默认运动类型值 model ====
@interface IDOGetDefaultSportTypeBluetoothModel:IDOBluetoothBaseModel
/**
 * 默认运动类型的个数 | sport type count
 */
@property (nonatomic,assign) NSInteger sportTypeCount;

/**
 运动类型值集合,集合排序就是运动类型排序 | set of motion type values, and set sort is motion type sort
 */
@property (nonatomic,strong) NSArray * sportTypes;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetDefaultSportTypeBluetoothModel
 */
+ (__kindof IDOGetDefaultSportTypeBluetoothModel *)currentModel;

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

#pragma mark ==== 获取版本信息model ====
@interface IDOGetVersionInfoBluetoothModel:IDOBluetoothBaseModel

/**
 * SDK版本 数值为x10,11表示1.1的版本
 * SDK version number is x10, and 11 represents the 1.1 version
 */
@property (nonatomic,assign) NSInteger sdkVersion;

/**
 * 心率算法版本 数值为x10,11表示1.1的版本
 * Version value of the heart rate algorithm is x10, and 11 represents version 1.1
 */
@property (nonatomic,assign) NSInteger hrAlgorithmVersion;

/**
 * 睡眠算法版本 数值为x10,11表示1.1的版本
 * Sleep algorithm version number is x10, and 11 represents version 1.1
 */
@property (nonatomic,assign) NSInteger sleepAlgorithmVersion;

/**
 * 计步算法版本 数值为x10,11表示1.1的版本
 * Step counting algorithm version value is x10,11 represents 1.1 version
 */
@property (nonatomic,assign) NSInteger stepAlgorithmVersion;

/**
 * 手势识别算法 数值为x10,11表示1.1的版本
 * Value of gesture recognition algorithm is x10, and 11 represents version 1.1
 */
@property (nonatomic,assign) NSInteger gestureRecognitionVersion;

/**
 * PCB 版本 数值为x10,11表示1.1的版本
 * PCB version number is x10, and 11 represents version 1.1
 */
@property (nonatomic,assign) NSInteger pcbVersion;

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
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetLiveDataBluetoothModel
 */
+ (__kindof IDOGetLiveDataBluetoothModel *)currentModel;

@end

#pragma mark ==== 获取第27个功能表model ====

@interface IDOGetFuncTable27BluetoothModel : IDOBluetoothBaseModel
/**
 * 泰国语
 * thai
 */
@property (nonatomic,assign) BOOL thai;
/**
 * 越南语
 * vietnamese
 */
@property (nonatomic,assign) BOOL vietnamese;
/**
 * 缅甸语
 * burmese
 */
@property (nonatomic,assign) BOOL burmese;
/**
 * 菲律宾语
 * filipino
 */
@property (nonatomic,assign) BOOL filipino;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetFuncTable27BluetoothModel
 */
+ (__kindof IDOGetFuncTable27BluetoothModel *)currentModel;
@end

#pragma mark ==== 获取第26个功能表model ====

@interface IDOGetFuncTable26BluetoothModel : IDOBluetoothBaseModel
/**
 * 支持恢复出厂设置,用于自动解绑
 * Support to restore factory Settings for automatic untying
 */
@property (nonatomic,assign) BOOL factoryReset;
/**
 * 抬腕亮背光 命令和抬手亮屏一样,就是app显示的名字不一样,不能和other.upHandGesture共存
 * The backlight command of raising wrist light is the same as raising hand light screen,
 * except that the name displayed by app is different and cannot coexist with other.upHandGesture
 */
@property (nonatomic,assign) BOOL liftingWrisBacklight;
/**
 * 多运动不能使用app
 * No app for more exercise
 */
@property (nonatomic,assign) BOOL multiActivityNoUseApp;
/**
 * 多表盘
 * multi dial
 */
@property (nonatomic,assign) BOOL multiDial;
/**
 * 中高强度活动
 * medium to high active duration
 */
@property (nonatomic,assign) BOOL mediumToHighActiveDuration;
/**
 * 获取手环运动模式
 * default sport type
 */
@property (nonatomic,assign) BOOL defaultSportType;
/**
 * 可下载语言
 * download language
 */
@property (nonatomic,assign) BOOL downloadLanguage;
/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetFuncTable26BluetoothModel
 */
+ (__kindof IDOGetFuncTable26BluetoothModel *)currentModel;
@end

#pragma mark ==== 获取第25个功能表model ====

@interface IDOGetFuncTable25BluetoothModel:IDOBluetoothBaseModel
/**
 椭圆机 | elliptical
 */
@property (nonatomic,assign) BOOL elliptical;
/**
 划船机 | rower
 */
@property (nonatomic,assign) BOOL rower;
/**
 高强度间歇训练法 | High-intensity interval training
 */
@property (nonatomic,assign) BOOL hiit;
/**
 板球运动 | cricket
 */
@property (nonatomic,assign) BOOL cricket;
/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetFuncTable25BluetoothModel
 */
+ (__kindof IDOGetFuncTable25BluetoothModel *)currentModel;

@end

#pragma mark ==== 获取第24个功能表model ====

@interface IDOGetFuncTable24BluetoothModel:IDOBluetoothBaseModel
/**
 户外跑步 | outdoor run
 */
@property (nonatomic,assign) BOOL outdoorRun;
/**
 室内跑步 | indoor run
 */
@property (nonatomic,assign) BOOL indoorRun;
/**
 户外骑行 | outdoor cycle
 */
@property (nonatomic,assign) BOOL outdoorCycle;
/**
 室内骑行 | indoor cycle
 */
@property (nonatomic,assign) BOOL indoorCycle;
/**
 户外走路 | outdoor walk
 */
@property (nonatomic,assign) BOOL outdoorWalk;
/**
室内走路 | indoor walk
 */
@property (nonatomic,assign) BOOL indoorWalk;
/**
 泳池游泳 | pool swim
 */
@property (nonatomic,assign) BOOL poolSwim;
/**
 开放水域游泳 | open water swim
 */
@property (nonatomic,assign) BOOL openWaterSwim;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetFuncTable24BluetoothModel
 */
+ (__kindof IDOGetFuncTable24BluetoothModel *)currentModel;

@end

#pragma mark ==== 获取第23个功能表model ====
@interface IDOGetFuncTable23BluetoothModel:IDOBluetoothBaseModel
/**
 5级心率区间 | level 5 hr interval
 */
@property (nonatomic,assign) BOOL level5HrInterval;
/**
 走动提醒 | walk reminder
 */
@property (nonatomic,assign) BOOL walkReminder;
/**
 呼吸训练 | breathe train
 */
@property (nonatomic,assign) BOOL breatheTrain;

/**
 5级亮度调节 | screen brightness 5 level
 */
@property (nonatomic,assign) BOOL screenBrightness5Level;
/**
 运动模式开关 自动识别 | activity switch
 */
@property (nonatomic,assign) BOOL activitySwitch;
/**
 勿扰 支持可选时间范围和星期 | disturb have rang repeat
 */
@property (nonatomic,assign) BOOL disturbHaveRangRepeat;
/**
 夜间自动亮度 | night auto brightness
 */
@property (nonatomic,assign) BOOL nightAutoBrightness;
/**
 传输长包 | long mtu
 */
@property (nonatomic,assign) BOOL longMtu;
/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetFuncTable23BluetoothModel
 */
+ (__kindof IDOGetFuncTable23BluetoothModel *)currentModel;

@end

#pragma mark ==== 获取22功能列表信息model ====
@interface IDOGetFuncTable22BluetoothModel:IDOBluetoothBaseModel
/**
 连接后自动配对 | auto pair
 */
@property (nonatomic,assign) BOOL autoPair;

/**
 不断线配对 | no disconnect pair
 */
@property (nonatomic,assign) BOOL noDisconnectPair;

/**
 v3 心率数据 | v3 hr data
 */
@property (nonatomic,assign) BOOL v3HrData;

/**
 v3 游泳数据 | v3 swim data
 */
@property (nonatomic,assign) BOOL v3SwimData;

/**
 v3 活动数据 | v3 activity data
 */
@property (nonatomic,assign) BOOL v3ActivityData;

/**
 v3 gps 数据 | v3 gps data
 */
@property (nonatomic,assign) BOOL v3GpsData;

/**
 喝水提醒 | drink water reminder
 */
@property (nonatomic,assign) BOOL drinkWaterReminder;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetFuncTable22BluetoothModel
 */
+ (__kindof IDOGetFuncTable22BluetoothModel *)currentModel;
@end

#pragma mark ==== 获取21功能列表信息model ====
@interface IDOGetFuncTable21BluetoothModel:IDOBluetoothBaseModel
/**
 chatwork
 */
@property (nonatomic,assign) BOOL chatwork;
/**
 slack
 */
@property (nonatomic,assign) BOOL slack;
/**
 tumblr
 */
@property (nonatomic,assign) BOOL tumblr;
/**
 youtube
 */
@property (nonatomic,assign) BOOL youtube;
/**
 yahoo pinterest
 */
@property (nonatomic,assign) BOOL yahooPinterest;
/**
 yahoo mail
 */
@property (nonatomic,assign) BOOL yahooMail;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetFuncTable21BluetoothModel
 */
+ (__kindof IDOGetFuncTable21BluetoothModel *)currentModel;
@end

#pragma mark ==== 获取20功能列表信息model ====
@interface IDOGetFuncTable20BluetoothModel:IDOBluetoothBaseModel

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
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetFuncTable20BluetoothModel
 */
+ (__kindof IDOGetFuncTable20BluetoothModel *)currentModel;

@end

#pragma mark ==== 获取19功能列表信息model ====
@interface IDOGetFuncTable19BluetoothModel:IDOBluetoothBaseModel

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
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetFuncTable19BluetoothModel
 */
+ (__kindof IDOGetFuncTable19BluetoothModel *)currentModel;

@end

#pragma mark ==== 获取18列表信息model ====
@interface IDOGetFuncTable18BluetoothModel:IDOBluetoothBaseModel

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
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetFuncTable18BluetoothModel
 */
+ (__kindof IDOGetFuncTable18BluetoothModel *)currentModel;

@end

#pragma mark ==== 获取17功能列表信息model ====
@interface IDOGetFuncTable17BluetoothModel:IDOBluetoothBaseModel

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
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetFuncTable17BluetoothModel
 */
+ (__kindof IDOGetFuncTable17BluetoothModel *)currentModel;

@end

#pragma mark ==== 获取16功能列表信息model ====
@interface IDOGetFuncTable16BluetoothModel:IDOBluetoothBaseModel

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
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetFuncTable16BluetoothModel
 */
+ (__kindof IDOGetFuncTable16BluetoothModel *)currentModel;

@end

#pragma mark ==== 获取15功能列表信息model ====
@interface IDOGetFuncTable15BluetoothModel:IDOBluetoothBaseModel

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
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetFuncTable15BluetoothModel
 */

+ (__kindof IDOGetFuncTable15BluetoothModel *)currentModel;
@end

#pragma mark ==== 获取14功能列表信息model ====
@interface IDOGetFuncTable14BluetoothModel:IDOBluetoothBaseModel

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
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetFuncTable14BluetoothModel
 */
+ (__kindof IDOGetFuncTable14BluetoothModel *)currentModel;

@end

#pragma mark ==== 获取13功能列表信息model ====
@interface IDOGetFuncTable13BluetoothModel:IDOBluetoothBaseModel

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
 *@brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 *@return IDOGetFuncTable13BluetoothModel
 */
+ (__kindof IDOGetFuncTable13BluetoothModel *)currentModel;

@end

#pragma mark ==== 获取12功能列表信息model ====
@interface IDOGetFuncTable12BluetoothModel:IDOBluetoothBaseModel

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
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetFuncTable12BluetoothModel
 */
+ (__kindof IDOGetFuncTable12BluetoothModel *)currentModel;

@end

#pragma mark ==== 获取11功能列表信息model ====
@interface IDOGetFuncTable11BluetoothModel:IDOBluetoothBaseModel

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
  * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
  * @return IDOGetFuncTable11BluetoothModel
 */
+ (__kindof IDOGetFuncTable11BluetoothModel *)currentModel;

@end

#pragma mark ==== 获取10功能列表信息model ====
@interface IDOGetFuncTable10BluetoothModel:IDOBluetoothBaseModel

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
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetFuncTable10BluetoothModel
 */
+ (__kindof IDOGetFuncTable10BluetoothModel *)currentModel;

@end

#pragma mark ==== 获取9功能列表信息model ====
@interface IDOGetFuncTable9BluetoothModel:IDOBluetoothBaseModel

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
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetFuncTable9BluetoothModel
 */
+ (__kindof IDOGetFuncTable9BluetoothModel *)currentModel;

@end

#pragma mark ==== 获取8功能列表信息model ====
@interface IDOGetFuncTable8BluetoothModel:IDOBluetoothBaseModel

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
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetFuncTable8BluetoothModel
 */
+ (__kindof IDOGetFuncTable8BluetoothModel *)currentModel;
@end

#pragma mark ==== 获取7功能列表信息model ====
@interface IDOGetFuncTable7BluetoothModel:IDOBluetoothBaseModel

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
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetFuncTable7BluetoothModel
 */
+ (__kindof IDOGetFuncTable7BluetoothModel *)currentModel;
@end

#pragma mark ==== 获取6功能列表信息model ====
@interface IDOGetFuncTable6BluetoothModel:IDOBluetoothBaseModel

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
 * @brief  查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetFuncTable6BluetoothModel
 */
+ (__kindof IDOGetFuncTable6BluetoothModel *)currentModel;
@end

#pragma mark ==== 获取5功能列表信息model ====
@interface IDOGetFuncTable5BluetoothModel:IDOBluetoothBaseModel

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
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetFuncTable5BluetoothModel
 */
+ (__kindof IDOGetFuncTable5BluetoothModel *)currentModel;
@end

#pragma mark ==== 获取4功能列表信息model ====
@interface IDOGetFuncTable4BluetoothModel:IDOBluetoothBaseModel

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
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetFuncTable4BluetoothModel
 */
+ (__kindof IDOGetFuncTable4BluetoothModel *)currentModel;

@end

#pragma mark ==== 获取3功能列表信息model ====
@interface IDOGetFuncTable3BluetoothModel:IDOBluetoothBaseModel

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
 印尼语 | Indonesian
 */
@property (nonatomic,assign) BOOL indonesian;

/**
 韩语 | korean
 */
@property (nonatomic,assign) BOOL korean;

/**
 印地语 | hindi
 */
@property (nonatomic,assign) BOOL hindi;

/**
 葡萄牙语 | portuguese
 */
@property (nonatomic,assign) BOOL portuguese;

/**
 土耳其 | turkish
 */
@property (nonatomic,assign) BOOL turkish;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetFuncTable3BluetoothModel
 */
+ (__kindof IDOGetFuncTable3BluetoothModel *)currentModel;

@end


#pragma mark ==== 获取2功能列表信息model ====
@interface IDOGetFuncTable2BluetoothModel:IDOBluetoothBaseModel

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
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetFuncTable2BluetoothModel
 */
+ (__kindof IDOGetFuncTable2BluetoothModel *)currentModel;
@end

#pragma mark ==== 获取1功能列表信息model ====
@interface IDOGetFuncTable1BluetoothModel:IDOBluetoothBaseModel

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
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetFuncTable1BluetoothModel
 */
+ (__kindof IDOGetFuncTable1BluetoothModel *)currentModel;
@end

#pragma mark ==== 获取功能列表信息model ====
@interface IDOGetDeviceFuncBluetoothModel:IDOBluetoothBaseModel

/**
 1功能列表 语言1 | 1 func table
 */
@property (nonatomic,strong) IDOGetFuncTable1BluetoothModel       * funcTable1Model;

/**
 2功能列表 语言2 | 2 func table
 */
@property (nonatomic,strong) IDOGetFuncTable2BluetoothModel       * funcTable2Model;

/**
 3功能列表 语言3 | 3 func table
 */
@property (nonatomic,strong) IDOGetFuncTable3BluetoothModel       * funcTable3Model;

/**
 4功能列表 | 4 func table
 */
@property (nonatomic,strong) IDOGetFuncTable4BluetoothModel       * funcTable4Model;

/**
 5功能列表 | 5 func table
 */
@property (nonatomic,strong) IDOGetFuncTable5BluetoothModel       * funcTable5Model;

/**
 6功能列表 闹钟功能 | 6 func table
 */
@property (nonatomic,strong) IDOGetFuncTable6BluetoothModel       * funcTable6Model;

/**
 7功能列表 来电提醒 | 7 func table
 */
@property (nonatomic,strong) IDOGetFuncTable7BluetoothModel       * funcTable7Model;

/**
 8功能列表 智能提醒1 | 8 func table
 */
@property (nonatomic,strong) IDOGetFuncTable8BluetoothModel       * funcTable8Model;

/**
 9功能列表 智能提醒2 | 9 func table
 */
@property (nonatomic,strong) IDOGetFuncTable9BluetoothModel       * funcTable9Model;

/**
 10功能列表 智能提醒3 | 10 func table
 */
@property (nonatomic,strong) IDOGetFuncTable10BluetoothModel      * funcTable10Model;

/**
 11功能列表 久坐、防丢 | 11 func table
 */
@property (nonatomic,strong) IDOGetFuncTable11BluetoothModel      * funcTable11Model;

/**
 12功能列表 短信号码 | 12 func table
 */
@property (nonatomic,strong) IDOGetFuncTable12BluetoothModel      * funcTable12Model;

/**
 13功能列表 静态心率、显示模式 | 13 func table
 */
@property (nonatomic,strong) IDOGetFuncTable13BluetoothModel      * funcTable13Model;

/**
 14功能列表 运动模式1 | 14 func table
 */
@property (nonatomic,strong) IDOGetFuncTable14BluetoothModel      * funcTable14Model;

/**
 15功能列表 运动模式2 | 15 func table
 */
@property (nonatomic,strong) IDOGetFuncTable15BluetoothModel      * funcTable15Model;

/**
 16功能列表 运动模式3 | 16 func table
 */
@property (nonatomic,strong) IDOGetFuncTable16BluetoothModel      * funcTable16Model;

/**
 17功能列表 运动模式4 | 17 func table
 */
@property (nonatomic,strong) IDOGetFuncTable17BluetoothModel      * funcTable17Model;

/**
 18功能列表 表盘、血压 | 18 func table
 */
@property (nonatomic,strong) IDOGetFuncTable18BluetoothModel      * funcTable18Model;

/**
 19功能列表 GPS、亮度 | 19 func table
 */
@property (nonatomic,strong) IDOGetFuncTable19BluetoothModel      * funcTable19Model;

/**
 20功能列表 女性健康、运动排序 | 20 func table
 */
@property (nonatomic,strong) IDOGetFuncTable20BluetoothModel      * funcTable20Model;

/**
 21功能列表 | 21 func table
 */
@property (nonatomic,strong) IDOGetFuncTable21BluetoothModel      * funcTable21Model;

/**
 22功能列表 连接后自动配对、v3数据 | 22 func table
 */
@property (nonatomic,strong) IDOGetFuncTable22BluetoothModel      * funcTable22Model;

/**
 23功能列表 走动提醒、呼吸训练 | 23 func table
 */
@property (nonatomic,strong) IDOGetFuncTable23BluetoothModel      * funcTable23Model;

/**
 24功能列表 运动模式5 | 24 func table
 */
@property (nonatomic,strong) IDOGetFuncTable24BluetoothModel      * funcTable24Model;

/**
 25功能列表 运动模式6 | 25 func table
 */
@property (nonatomic,strong) IDOGetFuncTable25BluetoothModel      * funcTable25Model;

/**
 26功能列表 运动模式6 | 26 func table
 */
@property (nonatomic,strong) IDOGetFuncTable26BluetoothModel      * funcTable26Model;

/**
 27功能列表 语言4 | 27 func table
 */
@property (nonatomic,strong) IDOGetFuncTable27BluetoothModel      * funcTable27Model;

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
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetDeviceFuncBluetoothModel
 */
+ (__kindof IDOGetDeviceFuncBluetoothModel *)currentModel;

/**
 * @brief 判断是否有运动模式 | Determine if there are movement patterns
 */
+ (BOOL)isHaveMovment;

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
 * 手环的平台 | platform for bracelet
 * 0:nordic, 10:realtek 8762x ,20:cypress psoc6,30:Apollo3
 */
@property (nonatomic,assign) NSInteger platform;

/**
 * 手环是否同步过配置 | is sync config
 *
 */
@property (nonatomic,assign) BOOL isSyncConfig;

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
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetMacAddrInfoBluetoothModel
 */
+ (__kindof IDOGetMacAddrInfoBluetoothModel *)currentModel;
@end

@interface IDOGetInfoBluetoothModel : IDOBluetoothBaseModel

@end
