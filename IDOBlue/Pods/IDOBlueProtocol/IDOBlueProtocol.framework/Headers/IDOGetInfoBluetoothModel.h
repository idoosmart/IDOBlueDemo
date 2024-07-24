//
//  IDOGetInfoBluetoothModel.h
//  VeryfitSDK
//
//  Created by apple on 2018/7/20.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#if __has_include(<IDOBlueProtocol/IDOBlueProtocol.h>)
#else
#import "IDOBluetoothBaseModel.h"
#endif

#pragma mark ==== 获取消息通知包名信息的状态 ====
@interface IDOGetAppPackNameStateModel:IDOBluetoothBaseModel
/**
 * 收到 07 40 0C , 固件包名需要更新
 */
@property (nonatomic,assign) BOOL isDeviceNeedUpdate;

/**
 * 失败次数
 */
@property (nonatomic,assign) int failTimes;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetAppPackNameStateModel
 */
+ (IDOGetAppPackNameStateModel *)currentModel;

@end


#pragma mark ==== 获取消息通知包名信息 ====
@interface IDOGetAppPackNameListItemModel:IDOBluetoothBaseModel
/**
 * 每个包名给一个id，累加，后续用来拿增量数据，由0开始
 */
@property (nonatomic,assign) NSInteger itemId;
/**
 *  需要更新图标数据 0：不需要更新 1：更新
 */
@property (nonatomic,assign) NSInteger needSyncIcon;
/**
 *  该条消息收到次数 ios
 */
@property (nonatomic,assign) NSInteger msgCout;
/**
 *  事件类型;参考 通消息通知
 */
@property (nonatomic,assign) NSInteger evtType;
/**
 *  包名长度
 */
@property (nonatomic,assign) NSInteger packNameLen;
/**
 * 应用包名
 */
@property (nonatomic,copy) NSString * packName;
/**
 应用名称
 */
@property (nonatomic,copy) NSString * appName;
/**
 icon 云端地址
 */
@property (nonatomic,copy) NSString *imageCloudPath;
/**
 icon本地地址
 */
@property (nonatomic,copy) NSString * imageLocalPath;
/**
 icon 大图标地址
 */
@property (nonatomic,copy) NSString * imageLocalPath100;
/**
 是否下载APP信息
 */
@property (nonatomic,assign) BOOL isDownloadAppInfo;
/**
 是否更新应用名称
 */
@property (nonatomic,assign) BOOL isUpdateAppName;
/**
 是否更新应用图标
 */
@property (nonatomic,assign) BOOL isUpdateAppIcon;
/**
 国家编码
 */
@property (nonatomic,copy) NSString * countryCode;

@end

@interface IDOGetAppPackNameModel:IDOBluetoothBaseModel
/**
 * 版本
 */
@property (nonatomic,assign) NSInteger infoVersion;
/**
 * icon 宽度
 */
@property (nonatomic,assign) NSInteger iconWidth;
/**
 * icon 高度
 */
@property (nonatomic,assign) NSInteger iconHeight;
/**
 * 颜色格式
 */
@property (nonatomic,assign) NSInteger format;
/**
 * 压缩块大小
 */
@property (nonatomic,assign) NSInteger blockSize;
/**
 * 当前获取累加个数
 */
@property (nonatomic,assign) NSInteger itemNum;

/**
 *所有个数
 */
@property (nonatomic,assign) NSInteger allItemNum;

/**
 包名集合
 */
@property (nonatomic,copy) NSArray<IDOGetAppPackNameListItemModel *> *items;
/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetHealthSwitchStateModel
 */
+ (IDOGetAppPackNameModel *)currentModel;

@end

#pragma mark ==== 获取健康监测开关 model ====
@interface IDOGetHealthSwitchStateModel : IDOBluetoothBaseModel
/**
 连续测量心率开关
 */
@property (nonatomic,assign) BOOL heartMode;
/**
 压力自动检测开关
 */
@property (nonatomic,assign) BOOL pressureMode;
/**
 血氧自动检测开关
 */
@property (nonatomic,assign) BOOL spo2Mode;
/**
 科学睡眠开关
 */
@property (nonatomic,assign) BOOL scienceMode;
/**
 夜间体温开关
 */
@property (nonatomic,assign) BOOL temperatureMode;
/**
 噪声开关
 */
@property (nonatomic,assign) BOOL noiseMode;
/**
 生理周期开关
 */
@property (nonatomic,assign) BOOL menstrualMode;
/**
 走动提醒开关
 */
@property (nonatomic,assign) BOOL walkMode;
/**
 洗手提醒开关
 */
@property (nonatomic,assign) BOOL handWashingMode;
/**
 喝水提醒开关
 */
@property (nonatomic,assign) BOOL drinkWaterMode;
/**
 呼吸率开关
 __IDO_FUNCTABLE__.funcTable30Model.getSwithAppend 功能表判断
 */
@property (nonatomic,assign) BOOL breathRateMode;
/**
 身体电量开关
 __IDO_FUNCTABLE__.funcTable30Model.getSwithAppend 功能表判断
 */
@property (nonatomic,assign) BOOL bodyPowerMode;
/**
 心率通知状态类型 ： 0无效 ； 1：允许通知； 2：静默通知； 3：关闭通知
 */
@property (nonatomic,assign) NSInteger heartModeNotifyFlag;
/**
 压力通知状态类型 ： 0无效 ； 1：允许通知； 2：静默通知； 3：关闭通知
 */
@property (nonatomic,assign) NSInteger pressureNotifyFlag;
/**
 血氧通知状态类型 ： 0无效 ； 1：允许通知； 2：静默通知； 3：关闭通知
 */
@property (nonatomic,assign) NSInteger spo2NotifyFlag;
/**
 生理周期通知状态类型 ： 0无效 ； 1：允许通知； 2：静默通知； 3：关闭通知
 */
@property (nonatomic,assign) NSInteger menstrualNotifyFlag;
/**
 健身指导通知状态类型 ： 0无效 ； 1：允许通知； 2：静默通知； 3：关闭通知
 */
@property (nonatomic,assign) NSInteger guidanceNotifyFlag;
/**
 提醒事项通知状态类型 ： 0无效 ； 1：允许通知； 2：静默通知； 3：关闭通知
 */
@property (nonatomic,assign) NSInteger reminderNotifyFlag;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetHealthSwitchStateModel
 */
+ (IDOGetHealthSwitchStateModel *)currentModel;

@end

#pragma mark ==== 获取v3设备字库列表 ====
@interface IDOGetV3LangLibListModel : IDOBluetoothBaseModel
/**
   语言版本
   lang version
 */
@property (nonatomic,assign) NSInteger langVersion;
/**
 * 当前使用的语言 | use lang
 * 语言单位 , 具体类型查看 IDO_LANGUAGE_TYPE
 * Language units, specific types can be found in IDO_ LANGUAGE_ TYPE
 */
@property (nonatomic,assign) IDO_LANGUAGE_TYPE useLang;
/**
   默认的语言
   default lang
 */
@property (nonatomic,assign) NSInteger defaultLang;
/**
   固定存储语言个数
   fixed lang count
 */
@property (nonatomic,assign) NSInteger fixedLang;
/**
   最大存储语言数
   max storage lang count
 */
@property (nonatomic,assign) NSInteger maxStorageLang;
/**
   固件目前支持的个数,可能没有对应的字库文件
   items support count
 */
@property (nonatomic,assign) NSInteger itemsSupportCount;

/**
   目前已经有语言的个数
   items storage count
 */
@property (nonatomic,assign) NSInteger itemsStorageCount;

/**
   已经支持语言 @[@{@"type":@(type),@"version":@(version)}...]
   lang support items
 */
@property (nonatomic,copy) NSArray * langSupportItems;
/**
   已经存储语言 @[@{@"type":@(type),@"version":@(version)}...]
   lang storage items
 */
@property (nonatomic,copy) NSArray * langStorageItems;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetV3LangLibListModel
 */
+ (IDOGetV3LangLibListModel *)currentModel;

@end

#pragma mark ==== 获取过热日志 model ====
@interface IDOGetOverHeatLogModel : IDOBluetoothBaseModel
/**
  该报文的版本号
  version number
 */
@property (nonatomic,assign) NSInteger verionNum;
/**
 设备运行总时间(单位秒)
 device run time (unit:second)
 */
@property (nonatomic,assign) NSInteger devRunTime;
/**
ppg传感器工作时间(单位秒)
ppg run time (unit:second)
*/
@property (nonatomic,assign) NSInteger ppgRunTime;
/**
充电次数
charging times
*/
@property (nonatomic,assign) NSInteger chargingTimes;
/**
发生异常的原因位集合:多个错误可以叠加
1 电压下降过快
2 ppg 传感器通讯失败
4 ppg 传感器返回数据异常
error flag
*/
@property (nonatomic,strong) NSArray * errFlag;

/**
 年份 | Year
 */
@property (nonatomic,assign) NSInteger year;
/**
 月份 | Month
 */
@property (nonatomic,assign) NSInteger month;
/**
 日期 | Date
 */
@property (nonatomic,assign) NSInteger day;
/**
 时 | hour
 */
@property (nonatomic,assign) NSInteger hour;
/**
 分 | minutes
 */
@property (nonatomic,assign) NSInteger minute;
/**
 秒 | seconds
 */
@property (nonatomic,assign) NSInteger second;

/**
 查询所有过热日志
 */
+ (NSArray <IDOGetOverHeatLogModel *>*)queryAllOverHeatLog;

/**
 删除所有过热日志
 */
+ (BOOL)deleteAllOverHeatLog;


@end


#pragma mark ==== 获取菜单列表 model ====
@interface IDOGetMenuListInfoBluetoothModel : IDOBluetoothBaseModel
/**
 菜单最小显示个数
 只是获取命令返回的字段，设置命令不需要赋值
 */
@property (nonatomic,assign) NSInteger minShowNum;
/**
 菜单最大显示个数
 只是获取命令返回的字段，设置命令不需要赋值
*/
@property (nonatomic,assign) NSInteger maxShowNum;
/**
 支持最大个数
 只是获取命令返回的字段，设置命令不需要赋值
 */
@property (nonatomic,assign) NSInteger maxNum;
/**
 菜单排序当前显示集合
 0 =>无效 1 =>步数 2 =>心率 3=> 睡眠 4=> 拍照 5=> 闹钟 6=> 音乐 7=> 秒表 8=> 计时器
 9=> 运动模式 10=> 天气 11=> 呼吸锻炼 12=> 查找手机 13=> 压力 14=> 数据三环 15=> 时间界面 16=> 最近一次活动
 17=> 健康数据 18=> 血氧 19 =>菜单设置 20=>alexa语音提示 21=> X屏（gt01pro-X新增）22=> 卡路里 （Doro Watch新增）
 23=>距离（Doro Watch新增）24=> 一键测量 (IDW05新增) 25=> renpho health(润丰健康)(IDW12新增) 26=> 指南针 (mp01新增)
 27=> 气压高度计(mp01新增)   28=> 通话列表(蓝牙通话)(IDW13新增)
 0 => invalid 1 => steps 2 => heart rate 3=> sleep 4=> picture 5=> alarm clock 6=> music 7=> stopwatch 8=> timer
 9=> exercise mode 10=> weather 11=> breathing exercise 12=> find mobile phone 13=> pressure 14=> data tricycle 15=> time interface
 16=> Last activity 17=> Health data 18=> Blood oxygen 19 => Menu setting 20=> Alexa voice prompt 21=> X screen 22=> Calories
 23=> Distance 24=> One-key measurement  25=> renpho health 26=> compass 27=> barometric_altimeter  28=>Call list
*/
@property (nonatomic,strong) NSArray<NSNumber *> * itemList;
/**
 菜单排序最大显示集合
 只是获取命令返回的字段，设置命令不需要赋值
 0 =>无效 1 =>步数 2 =>心率 3=> 睡眠 4=> 拍照 5=> 闹钟 6=> 音乐 7=> 秒表 8=> 计时器
 9=> 运动模式 10=> 天气 11=> 呼吸锻炼 12=> 查找手机 13=> 压力 14=> 数据三环 15=> 时间界面 16=> 最近一次活动
 17=> 健康数据 18=> 血氧 19 =>菜单设置 20=>alexa语音提示 21=> X屏（gt01pro-X新增）22=> 卡路里 （Doro Watch新增）
 23=>距离（Doro Watch新增）24=> 一键测量 (IDW05新增)  25=> renpho health(润丰健康)(IDW12新增) 26=> 指南针 (mp01新增)
 27=> 气压高度计(mp01新增)   28=> 通话列表(蓝牙通话)(IDW13新增)
 0 => invalid 1 => steps 2 => heart rate 3=> sleep 4=> picture 5=> alarm clock 6=> music 7=> stopwatch 8=> timer
 9=> exercise mode 10=> weather 11=> breathing exercise 12=> find mobile phone 13=> pressure 14=> data tricycle 15=> time interface
 16=> Last activity 17=> Health data 18=> Blood oxygen 19 => Menu setting 20=> Alexa voice prompt 21=> X screen 22=> Calories
 23=> Distance 24=> One-key measurement 25=> renpho health 26=> compass 27=> barometric_altimeter  28=>Call list
 */
@property (nonatomic,strong) NSArray<NSNumber *> * maxItemList;
/**
 设备当前显示列表个数
 只是获取命令返回的字段，设置命令不需要赋值
 */
@property (nonatomic,assign) NSInteger currentShowNum;
/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetMenuListInfoBluetoothModel
 */
+ (IDOGetMenuListInfoBluetoothModel *)currentModel;

@end

#pragma mark ==== 获取不可删除的快捷应用列表 model ====
@interface IDOGetUndeleMenuListInfoBluetoothModel : IDOBluetoothBaseModel
/**
 支持最大个数
 */
@property (nonatomic,assign) NSInteger num;
/**
 菜单排序当前显示集合
 0 =>无效 1 =>步数 2 =>心率 3=> 睡眠 4=> 拍照 5=> 闹钟 6=> 音乐 7=> 秒表 8=> 计时器
 9=> 运动模式 10=> 天气 11=> 呼吸锻炼 12=> 查找手机 13=> 压力 14=> 数据三环 15=> 时间界面 16=> 最近一次活动
 17=> 健康数据 18=> 血氧 19 =>菜单设置 20=>alexa语音提示 21=> X屏（gt01pro-X新增）22=> 卡路里 （Doro Watch新增）
 23=>距离（Doro Watch新增）24=> 一键测量 (IDW05新增) 25=> renpho health(润丰健康)(IDW12新增) 26=> 指南针 (mp01新增)
 27=> 气压高度计(mp01新增)
 0 => invalid 1 => steps 2 => heart rate 3=> sleep 4=> picture 5=> alarm clock 6=> music 7=> stopwatch 8=> timer
 9=> exercise mode 10=> weather 11=> breathing exercise 12=> find mobile phone 13=> pressure 14=> data tricycle 15=> time interface
 16=> Last activity 17=> Health data 18=> Blood oxygen 19 => Menu setting 20=> Alexa voice prompt 21=> X screen 22=> Calories
 23=> Distance 24=> One-key measurement  25=> renpho health 26=> compass 27=> barometric_altimeter
*/
@property (nonatomic,strong) NSArray<NSNumber *> * itemList;
/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetMenuListInfoBluetoothModel
 */
+ (IDOGetUndeleMenuListInfoBluetoothModel *)currentModel;

@end


#pragma mark ====  获取下载语言 model ====
@interface IDOGetDownLanguageBluetoothModel:IDOBluetoothBaseModel
/**
 * 当前使用的语言 | use lang
 * 语言单位 , 具体类型查看 IDO_LANGUAGE_TYPE
 * Language units, specific types can be found in IDO_ LANGUAGE_ TYPE
 */
@property (nonatomic,assign) IDO_LANGUAGE_TYPE useLang;
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
@property (nonatomic,strong) NSArray * languageValues;
/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetDownLanguageBluetoothModel
 */
+ (IDOGetDownLanguageBluetoothModel *)currentModel;

@end

#pragma mark ====  默认运动类型值 model ====
@interface IDOGetDefaultSportTypeBluetoothModel:IDOBluetoothBaseModel
/**
 * 默认运动类型的个数 | sport type count
 */
@property (nonatomic,assign) NSInteger sportTypeCount;

/**
 *最小支持的数量 | min show num
 */
@property (nonatomic,assign) NSInteger minShowNum;

/**
 *最大支持的数量 | max show num
 */
@property (nonatomic,assign) NSInteger maxShowNum;

/**
 *是否支持默认排序 | is supports sort
 */
@property (nonatomic,assign) BOOL isSupportSort;

/**
 运动类型值集合,集合排序就是运动类型排序 | set of motion type values, and set sort is motion type sort
 参照 IDO_SPORT_TYPE 枚举类型
 */
@property (nonatomic,strong) NSArray * sportTypes;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetDefaultSportTypeBluetoothModel
 */
+ (IDOGetDefaultSportTypeBluetoothModel *)currentModel;

@end

#pragma mark ==== 获取软硬件版本信息model ====
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

//血氧算法版本
@property (nonatomic,assign) NSInteger spo2Version;

//压力算法版本
@property (nonatomic,assign) NSInteger stressVersion;

//卡路里算法版本
@property (nonatomic,assign) NSInteger kcalVersion;

//距离算法版本
@property (nonatomic,assign) NSInteger disVersion;

//三轴传感器游泳算法版本
@property (nonatomic,assign) NSInteger axle3SwimVersion;

//六轴传感器游泳算法版本
@property (nonatomic,assign) NSInteger axle6SwimVersion;

//运动自识别算法版本
@property (nonatomic,assign) NSInteger actModeTypeVersion;

//全天心率算法版本
@property (nonatomic,assign) NSInteger allDayHrVersion;

//gps算法版本
@property (nonatomic,assign) NSInteger gpsVersion;

//外设版本 206项目外设版本
@property (nonatomic,assign) NSInteger peripheralsVersion;

/**
 固件版本version1
 */
@property (nonatomic,assign) NSInteger firmwareVersion1;

/**
 固件版本version2
 */
@property (nonatomic,assign) NSInteger firmwareVersion2;

/**
 固件版本version3
 */
@property (nonatomic,assign) NSInteger firmwareVersion3;

/**
 BT版本生效标志位; 0：无效，1：说明固件有对应的BT固件
 */
@property (nonatomic,assign) NSInteger btFlag;

/**
 BT的版本version1
 */
@property (nonatomic,assign) NSInteger btVersion1;

/**
 BT的版本version2
 */
@property (nonatomic,assign) NSInteger btVersion2;

/**
 BT的版本version3
 */
@property (nonatomic,assign) NSInteger btVersion3;

/**
 BT的所需要匹配的版本version1
 */
@property (nonatomic,assign) NSInteger btMatchVersion1;

/**
 BT的所需要匹配的版本version2
 */
@property (nonatomic,assign) NSInteger btMatchVersion2;

/**
 BT的所需要匹配的版本version3
 */
@property (nonatomic,assign) NSInteger btMatchVersion3;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetVersionInfoBluetoothModel
 */
+ (IDOGetVersionInfoBluetoothModel *)currentModel;

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
+ (IDOGetHotStartParamBluetoothModel *)currentModel;

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
+ (IDOGetGpsInfoBluetoothModel *)currentModel;

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
+ (IDOGetHidInfoBluetoothModel *)currentModel;

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
+ (IDOGetActivityCountBluetoothModel *)currentModel;

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
+ (IDOGetGsensorParamBluetoothModel *)currentModel;
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
+ (IDOGetHrSensorParamBluetoothModel *)currentModel;

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
+ (IDOGetDeviceTimeBluetoothModel *)currentModel;
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
+ (IDOGetLiveDataBluetoothModel *)currentModel;

@end

#pragma mark ==== 获取第39个功能表model ====

@interface IDOGetFuncTable39BluetoothModel : IDOBluetoothBaseModel

/**
 运动自识别暂停开关不展示，设置开关状态0xff
 */
@property (nonatomic,assign) BOOL autoActivityPauseSwitchNotDisplay;
/**
 运动自识别结束开关不展示，设置开关状态0xff
 */
@property (nonatomic,assign) BOOL autoActivityEndSwitchNotDisplay;

/**
 运动自识别获取和设置指令使用新的版本与固件交互，重定义开关字段
 */
@property (nonatomic,assign) BOOL autoActivitySetGetUseNewStructExchange;
/**
 GTX03/05定制，hamaAPP，功能表开启后，运动列表不支持增删，支持排序
 */
@property (nonatomic,assign) BOOL notSupportDeleteAddSportSort;
/**
 ks02，标准化APP，功能表开启后，支持获取sn信息，预留位
 */
@property (nonatomic,assign) BOOL supportGetSnInfo;
/**
 支持设置关闭alexa功能，MP02定制需求
 */
@property (nonatomic,assign) BOOL supportSetAlexaFunctionOnOff;
/**
 经期历史数据下发使用version2版本下发
 */
@property (nonatomic,assign) BOOL supportSetHistoricalMenstruationUseV2;
/**
 支持泰坦定制，通知支持Titan Smart World，type：0x61，titan16，gtx08
 */
@property (nonatomic,assign) BOOL supporTitanSmartWorld;
/**
 泰坦定制，固件不开放APP下发跑步计划的功能，app屏蔽跑步计划入口，gtx06
 */
@property (nonatomic,assign) BOOL notSupportAppSendRunPlan;

/**
 ks02，标准化APP，功能表开启后，V3设置获取消息应用状态使用version0x20版本下发
 */
@property (nonatomic,assign) BOOL supportSetNoticeMessageStateUseVersion0x20;
/**
 支持获取单位
 */
@property (nonatomic,assign) BOOL supportGetUnit;
/**
 支持设置来电快捷回复开关
 */
@property (nonatomic,assign) BOOL supportSetCallQuickReplyOnOff;
/**
 RYZE定制新增, 消息应用类型
 */
@property (nonatomic,assign) BOOL supportRyzeConnect;

/**
 通知支持LOOPS FIT
 */
@property (nonatomic,assign) BOOL supportLoopsFit;
/**
 通知支持LOOPS FIT
 */
@property (nonatomic,assign) BOOL supportTasSmart;

/**
 支持血压模型文件更新
 */
@property (nonatomic,assign) BOOL supportBpModelFileUpdate;

/**
 支持app游戏时间设置
 */
@property (nonatomic,assign) BOOL supportGameTimeReminder;

/**
 踏步机运动新增展示步数的功能表
 */
@property (nonatomic,assign) BOOL supportActivityTypeTreadmillsShowStep;

/**
 支持全天步数目标达成提醒开关
 */
@property (nonatomic,assign) BOOL supportAchievedRemindOnOff;

/**
 支持喝水计划
 */
@property (nonatomic,assign) BOOL supportDrinkPlan;

/**
 支持睡眠计划
 */
@property (nonatomic,assign) BOOL supportSleepPlan;

/**
 支持获取运动是否自动暂停结束
 */
@property (nonatomic,assign) BOOL supportSportGetAutoPauseEnd;

/**
 环境音量支持设置通知类型
 */
@property (nonatomic,assign) BOOL supportSetNoiseNotify;

/**
 环境音量支持设置过高提醒
 */
@property (nonatomic,assign) BOOL supportSetNoiseOverwarning;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetFuncTable37BluetoothModel
 */
+ (IDOGetFuncTable39BluetoothModel *)currentModel;

@end

#pragma mark ==== 获取第38个功能表model ====

@interface IDOGetFuncTable38BluetoothModel : IDOBluetoothBaseModel
/**
 走动提醒增加通知类型
 */
@property (nonatomic,assign) BOOL walkReminderAddNotify;
/**
 支持健身指导开关下发
 */
@property (nonatomic,assign) BOOL setFitnessGuidance;
/**
 支持联系人同步
 */
@property (nonatomic,assign) BOOL syncContact;
/**
 支持天气推送增加日落日出时间
 */
@property (nonatomic,assign) BOOL setWeatherSunTime;
/**
 支持V3天气
 */
@property (nonatomic,assign) BOOL setV3Weather;

/**
 支持3天日落日出天气设置
 */
@property (nonatomic,assign) BOOL setV3WeatherSunrise;

/**
 gt01pro 支持V3天气 下发空气质量等级
 */
@property (nonatomic,assign) BOOL setV3WeatherAddAirGrade;

/**
 支持世界时间设置
 */
@property (nonatomic,assign) BOOL setV3WorldTime;
/**
 消息提醒增加8国语言app名字新的协议
 */
@property (nonatomic,assign) BOOL setNotifyAddAppName;
/**
 支持固件音乐传输
 */
@property (nonatomic,assign) BOOL transferMusicFile;
/**
 支持运动模式识别开关获取
 */
@property (nonatomic,assign) BOOL getActivitySwitch;
/**
 支持经期的历史数据下发
 */
@property (nonatomic,assign) BOOL historyMenstrual;
/**
 获得固件三级版本和BT的三级版本
 */
@property (nonatomic,assign) BOOL bleAndBtVersion;
/**
 音乐添加歌手名
 */
@property (nonatomic,assign) BOOL musicAddSingerName;
/**
 v2经期提醒设置 增加易孕期和结束时间设置
 menstrual remind add pregnancy
 */
@property (nonatomic,assign) BOOL menstrualAddPregnancy;
/**
 alexa100种运动新增功能表
 ui controll 100 sports
 */
@property (nonatomic,assign) BOOL alexaControll100sports;
/**
 207a定制   走动实时提醒
 */
@property (nonatomic,assign) BOOL walkTimeReminder DEPRECATED_MSG_ATTRIBUTE("this attribute is discarded");
/**
 未读信息红点提示开关
 set unread app reminder
 */
@property (nonatomic,assign) BOOL setUnreadAppReminder;
/**
 100级亮度判断
 set alexa operation 100brightness
 */
@property (nonatomic,assign) BOOL alexaControll100brightness;
/**
 获取bt蓝牙地址（gt01 pro）
 get bt addr
 */
@property (nonatomic,assign) BOOL getBleMacAddr;
/**
 通知应用状态设置
 set notification status
 */
@property (nonatomic,assign) BOOL setNotificationStatus;
/**
 同步V3的多运动增加新的参数
 set notification status
 */
@property (nonatomic,assign) BOOL syncV3ActivityAddParam;
/**
 压力开关阀值设置
 */
@property (nonatomic,assign) BOOL stressCalibrationThreshold;

/**
 realme wear  默认为显示，有此功能表就不支持支持来电提醒页面的“延迟三秒”开关设置项显示
 */
@property (nonatomic,assign) BOOL notSurportCalling3SDelay;

/**
 alexa跳转运动界面支持100种运动类型字段
 */
@property (nonatomic,assign) BOOL uiControllSports;

/**
 gt01_pro app新增需求 未读信息红点提示开关
 */
@property (nonatomic,assign) BOOL v2SetUnreadAppReminder;

/**
 以快速模式开始启动同步配置/同步健康数据
 */
@property (nonatomic,assign) BOOL supportSetFastModeWhenSyncConfig;

/**
 app新增需求 运动模式自动识别开关设置获取 新增类型骑行
 */
@property (nonatomic,assign) BOOL supportActivitySwitchAddBicycle;

/**
 功能表开启后，同步v3睡眠数据中不对睡眠类型进行限制，使用固件回复的睡眠类型直接上报SDK
 */
@property (nonatomic,assign) BOOL supportV3HealthSleepDataTypeNotLimit;

/**
 固件支持使用表盘框架使用argb6666/abrg6666 编码格式
 */
@property (nonatomic,assign) BOOL supportDialFrameEncodeFormatArgb6666;
/**
 固件管理切换快/慢速模式，APP不下发设置链接参数(快慢速）
 */
@property (nonatomic,assign) BOOL supportDeviceControlFastModeAlone;
/**
 固件支持app下发手机操作系统信息
 */
@property (nonatomic,assign) BOOL supportAppSendPhoneSystemInfo;
/**
 设备支持一键双连，区分配对时APP展示引导页还是直接下发配对指令
 */
@property (nonatomic,assign) BOOL supportOnekeyDoubleContact;
/**
 表盘框架douivv5&v6使用偶数对齐(奇数宽度的图片会宽度+1)
 */
@property (nonatomic,assign) BOOL supportdialFrameEncodeWidthUseEvenNumberAligning;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetFuncTable37BluetoothModel
 */
+ (IDOGetFuncTable38BluetoothModel *)currentModel;

@end

#pragma mark ==== 获取第37个功能表model ====
@interface IDOGetFuncTable37BluetoothModel : IDOBluetoothBaseModel
/**
 增加骑行的单位设置
 */
@property (nonatomic,assign) BOOL supportCyclingUnit;
/**
 增加步行跑步的单位设置
 */
@property (nonatomic,assign) BOOL supportWalkRunUnit;
/**
 设置目标增加中高运动时长
 */
@property (nonatomic,assign) BOOL midHighTimeGoal;
/**
 设置走动提醒中的目标时间
 */
@property (nonatomic,assign) BOOL walkReminderTimeGoal;
/**
 v3的运动数据数据交换增加实时的配速字段
 */
@property (nonatomic,assign) BOOL exchangeDataRealTimePace;
/**
 设置支持系统配对，每次连接的时候app不清除配对设备
 */
@property (nonatomic,assign) BOOL supportPairEachConnect;
/**
 支持app下发压缩的sbc语言文件给ble
 */
@property (nonatomic,assign) BOOL supportAppSendVoiceToBle;
/**
 设置血氧过低阈值
 */
@property (nonatomic,assign) BOOL setSpo2LowValue;
/**
 支持app设置全天的血氧开关数据
 */
@property (nonatomic,assign) BOOL spo2AllDayOnOff;
/**
 支持app设置智能心率
 */
@property (nonatomic,assign) BOOL smartHeartRate;
/**
 alexa语音提醒增加对应的s钟传输字段
 */
@property (nonatomic,assign) BOOL alexaReminderAddSecond;
/**
 同步噪音
 */
@property (nonatomic,assign) BOOL syncNoise;
/**
 同步温度
 */
@property (nonatomic,assign) BOOL syncTemperature;
/**
 100种运动数据排序
 */
@property (nonatomic,assign) BOOL set100SportSort;
/**
 100种运动需要的中图功能表
 */
@property (nonatomic,assign) BOOL sportMediumIcon;
/**
 20种基础运动数据子参数排序
 */
@property (nonatomic,assign) BOOL set20SportParamSort;
/**
 主界面ui控件排列
 */
@property (nonatomic,assign) BOOL setMainUiSort;
/**
 日程提醒
 */
@property (nonatomic,assign) BOOL scheduleReminder;
/**
 运动模式自动识别开关设置
 */
@property (nonatomic,assign) BOOL autoActivitySwitch;
/**
 运动三环目标获取
 */
@property (nonatomic,assign) BOOL getCalorieDistanceGoal;
/**
 206新增压力校准设置
 */
@property (nonatomic,assign) BOOL setStressCalibration;
/**
 支持显示表盘容量
 */
@property (nonatomic,assign) BOOL watchCapacitySizeDisplay;
/**
 支持壁纸表盘时间位置移动、控件图标颜色修改、控件功能选择
 */
@property (nonatomic,assign) BOOL watchPhotoPositionMove;

/**
 固件升级方式区分
 */
@property (nonatomic,assign) BOOL chooseOtherOtaMode;

/**
 支持新固件app删除设备不删除数据
 */
@property (nonatomic,assign) BOOL surpportNewRetainData;

/**
 固件支持每小时目标步数设置和获取
 */
@property (nonatomic,assign) BOOL supportWalkGoalSteps;

/**
 固件支持解绑不清除设备上的数据
 */
@property (nonatomic,assign) BOOL newRetainData;
/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetFuncTable37BluetoothModel
 */
+ (IDOGetFuncTable37BluetoothModel *)currentModel;

@end

#pragma mark ==== 获取第36个功能表model ====

@interface IDOGetFuncTable36BluetoothModel : IDOBluetoothBaseModel
/**
 Alexa 设置天气
 scientific sleep
 */
@property (nonatomic,assign) BOOL alexaSetWeather;
/**
 alexa 跳转运动界面
 Alexa jump sport UI
 */
@property (nonatomic,assign) BOOL alexaJumpSportUi;
/**
 alexa 跳转界面
 Alexa jump UI
 */
@property (nonatomic,assign) BOOL alexaJumpUi;
/**
 alexa 简单操作
 scientific sleep
 */
@property (nonatomic,assign) BOOL alexaEasyOperate;
/**
 alexa 获取闹钟
 alexa get alarm
 */
@property (nonatomic,assign) BOOL alexaGetAlarm;
/**
 alexa app设置开关命令
 alexa set on off
 */
@property (nonatomic,assign) BOOL alexaSetOnOff;
/**
 走动提醒目标获取
 */
@property (nonatomic,assign) BOOL getWalkReminder;
/**
 音乐名称设置
 */
@property (nonatomic,assign) BOOL setMusicName;
/**
 长包城市名称
 */
@property (nonatomic,assign) BOOL longCityName;
/**
 算法的最大摄氧量
 */
@property (nonatomic,assign) BOOL maxBloodOxygen;
/**
 支持系统拍照
 */
@property (nonatomic,assign) BOOL systemTakePictures;
/**
 207a定制   走动实时提醒(c库功能表废弃了)
 */
@property (nonatomic,assign) BOOL walkTimeReminder;
/**
 支持获取心率过高过低提醒时的心率数据
 */
@property (nonatomic,assign) BOOL getHeartRateReminder;
/**
 一分钟间隔步数
 */
@property (nonatomic,assign) BOOL stepsOneMinute;
/**
 206boat新增 心率检测模式支持展示检测时段
 */
@property (nonatomic,assign) BOOL showDetectionTime;
/**
 支持世界时钟设备在有此功能表的情况下时间设置中 time_zone为浮点型小数点后有两位，
 app此时的时区设定值为实际时区值的扩大一百倍 ，无此功能表则按实际时区值下发
 */
@property (nonatomic,assign) BOOL timeZoneFloat;
/**
 kr01定制   支持v3闹钟设置获取指定类型和名称
 */
@property (nonatomic,assign) BOOL setAlarmSpecifyType;
/**
 支持身体电量数据同步
 */
@property (nonatomic,assign) BOOL v3BodyPower;
/**
 v3天气设置增加下发48小时天气数据
 */
@property (nonatomic,assign) BOOL supportSetV3Add48HourWeatherData;
/**
 支持ai表盘
 */
@property (nonatomic,assign) BOOL aiWatchDial;
/**
 支持ai语音
 */
@property (nonatomic,assign) BOOL aiVoice;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetFuncTable36BluetoothModel
 */
+ (IDOGetFuncTable36BluetoothModel *)currentModel;

@end

#pragma mark ==== 获取第35个功能表model ====

@interface IDOGetFuncTable35BluetoothModel : IDOBluetoothBaseModel
/**
 支持科学睡眠
 scientific sleep
 */
@property (nonatomic,assign) BOOL scientificSleep;
/**
 支持获取电池日志
 get battery log
 */
@property (nonatomic,assign) BOOL getBatteryLog;
/**
 支持获取表盘列表的接口
 get new watch list
 */
@property (nonatomic,assign) BOOL getNewWatchList;
/**
 支持多个定时器
 Multiple timers
 */
@property (nonatomic,assign) BOOL multipleTimers;
/**
 获取设备列表
 get menu list
 */
@property (nonatomic,assign) BOOL getMenuList;
/**
 v3健康数据同步，半个小时自动同步
 auto sync v3 health data
 */
@property (nonatomic,assign) BOOL autoSyncV3HealthData;
/**
 app获取重启日志错误码和标志位
 get device log state
 */
@property (nonatomic,assign) BOOL getDeviceLogState;
/**
 支持断点续传
 */
@property (nonatomic,assign) BOOL dataTranContinue;
/**
 消息提醒图标自适应
 */
@property (nonatomic,assign) BOOL notifyIconAdaptive;
/**
 科学睡眠开关
 */
@property (nonatomic,assign) BOOL setScientificSleepSwitch;
/**
 压力开关增加通知类型和全天压力模式设置
 */
@property (nonatomic,assign) BOOL pressureNotifyFlagMode;
/**
 血氧开关增加通知类型
 */
@property (nonatomic,assign) BOOL spo2NotifyFlag;
/**
 月经开关增加通知类型
 */
@property (nonatomic,assign) BOOL menstrualNotifyFlag;
/**
 喝水开关增加通知类型
 */
@property (nonatomic,assign) BOOL drinkWaterNotifyFlag;
/**
 获取所有的健康监测开关
 */
@property (nonatomic,assign) BOOL getHealthSwitchState;
/**
 设置夜间体温开关
 */
@property (nonatomic,assign) BOOL setTemperatureSwitch;
/**
 泰坦定制 支持结束寻找手机功能表
 */
@property (nonatomic,assign) BOOL findPhoneStop;
/**
 泰坦定制 支持app被禁用、开启权限通知固件
 */
@property (nonatomic,assign) BOOL permissionsState;

/**
 沃尔新增 亮度设置支持夜间亮度等级设置
 */
@property (nonatomic,assign) BOOL supportAddNightLevel;
/**
 沃尔新增 亮度设置支持夜间亮度等级设置
 */
@property (nonatomic,assign) BOOL supportSmartCompetitor;
/**
 GTX0305&MP02定制 支持设置经期开关
 */
@property (nonatomic,assign) BOOL supportSetMenstrualOnOff;
/**
 泰坦10定制 支持下发语音助手开关状态
 */
@property (nonatomic,assign) BOOL supportSetVoiceAssistantStatus;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetFuncTable35BluetoothModel
 */
+ (IDOGetFuncTable35BluetoothModel *)currentModel;

@end

#pragma mark ==== 获取第34个功能表model ====

@interface IDOGetFuncTable34BluetoothModel : IDOBluetoothBaseModel
/**
 吃药提醒
 taking medicine
 */
@property (nonatomic,assign) BOOL takingMedicine;

/**
 app支持本地表盘改 云端表盘图片下载
 local dial
 */
@property (nonatomic,assign) BOOL localDial;

/**
 压力过高提醒
 pressure too high reminder
 */
@property (nonatomic,assign) BOOL pressureHighReminder;

/**
 V3的心率过高不支持
 配置了这个，app的UI心率过高告警不显示，固件对应设置心率过高告警的不起作用
 */
@property (nonatomic,assign) BOOL notSupportHrHighAlarm;

/**
 V3的心率 -- 208BT过高过低提醒功能表
 */
@property (nonatomic,assign) BOOL supportHrHighOrLowBtAlarm;

/**
 208BT定制 支持发送解压前的文件大小命令 文件传输-->表盘使用
 */
@property (nonatomic,assign) BOOL supportSendOriginalSizeD1;

/**
 BIT1 k6项目不需要对应的壁纸表盘，veryFit默认的都是支持的，新加一个不支持的功能表，不需要的配置这个
 no support photo wallpaper
 */
@property (nonatomic,assign) BOOL notSupportPhotoWallpaper;

/**
 设置单位的增加卡路里设置
 */
@property (nonatomic,assign) BOOL supportCalorieUnit;

/**
 设置单位的增加泳池的单位设置
 */
@property (nonatomic,assign) BOOL supportSwimPoolUnit;

/**
 app端用V3的获取运动排序协议中的最大最少默认字段，
 gt01以前app都没有用到最大最少默认字段，适配k6项目需要配置对应的数据字段，添加功能表兼容
 */
@property (nonatomic,assign) BOOL v3GetSportSortField;

/**
 获取alexa的默认语言
 */
@property (nonatomic,assign) BOOL getAlexaDefaultLanguage;

/**
 v3壁纸表盘颜色设置
 */
@property (nonatomic,assign) BOOL setWallpaperColor;

/**
 获取每个小时的佩戴标志位，在当天的运动数据同步中获取
 */
@property (nonatomic,assign) BOOL supportWearFlag;

/**
 设置表盘顺序
 */
@property (nonatomic,assign) BOOL watchDialSort;

/**
 支持ping回调
 */
@property (nonatomic,assign) BOOL suppportPing;

/**
 205L血压 v3健康数据同步支持
 */
@property (nonatomic,assign) BOOL supportV3Bp;

/**
 血压校准与设置
 */
@property (nonatomic,assign) BOOL v2BpSetOrMeasurement;

/**
 206lite   壁纸表盘只支持移动时间、日期和修改颜色
 */
@property (nonatomic,assign) BOOL wallpaperOnlyTimeColor;

/**
 固件支持呼吸率开关设置 ，以及呼吸率数据同步返回
 */
@property (nonatomic,assign) BOOL supportBreathRate;
/**
 多运动同步数据支持摄氧量等级数据
 */
@property (nonatomic,assign) BOOL supportGrade;
/**
 支持跑步计划协议以及跑步课程功能表
 */
@property (nonatomic,assign) BOOL supportSportPlan;

/**
 app设置来电快速短信的命令
 */
@property (nonatomic,assign) BOOL supportMsgCallingQuick;

/**
 支持设置获取消息应用总开关字段
 */
@property (nonatomic,assign) BOOL supportMsgAllSwitch;

/**
 支持airoha芯片采gps数据功能表
 */
@property (nonatomic,assign) BOOL supportAirohaGpsChip;


/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetFuncTable34BluetoothModel
 */
+ (IDOGetFuncTable34BluetoothModel *)currentModel;

@end

#pragma mark ==== 获取第33个功能表model ====

@interface IDOGetFuncTable33BluetoothModel : IDOBluetoothBaseModel
/**
 * prime
 * prime
*/
@property (nonatomic,assign) BOOL prime;
/**
 * netflix
 * netflix
*/
@property (nonatomic,assign) BOOL netflix;
/**
 * gpay
 * gpay
*/
@property (nonatomic,assign) BOOL gpay;
/**
 * phonpe
 * phonpe
*/
@property (nonatomic,assign) BOOL phonpe;
/**
 * swiggy
 * swiggy
*/
@property (nonatomic,assign) BOOL swiggy;
/**
 * zomato
 * zomato
*/
@property (nonatomic,assign) BOOL zomato;
/**
 * make my trip
 * make my trip
*/
@property (nonatomic,assign) BOOL makeMyTrip;
/**
 * jio tv
 * jio tv
*/
@property (nonatomic,assign) BOOL jioTv;
/**
 Microsoft
 */
@property (nonatomic,assign) BOOL microsoft;
/**
 whatsapp Business
 */
@property (nonatomic,assign) BOOL whatsappBusiness;
/**
 nioseFit
 */
@property (nonatomic,assign) BOOL nioseFit;
/**
 未接来电提醒 missed call
 */
@property (nonatomic,assign) BOOL missedCall;
/**
 事项提醒的功能表
 */
@property (nonatomic,assign) BOOL mattersRemind;
/**
 YTmusic
 */
@property (nonatomic,assign) BOOL ytmusic;
/**
 Uber
 */
@property (nonatomic,assign) BOOL uber;
/**
 ola
 */
@property (nonatomic,assign) BOOL ola;
/**
 google meet
 */
@property (nonatomic,assign) BOOL googleMeet;
/**
 通知支持Mormaii Smartwatch的功能
 */
@property (nonatomic,assign) BOOL mormaiiSmartwatch;
/**
 通知支持Technos Connect的功能
 */
@property (nonatomic,assign) BOOL technosConnect;
/**
 通知支持 enioei 功能
 */
@property (nonatomic,assign) BOOL enioei;
/**
 通知支持 aliexpress 功能
 */
@property (nonatomic,assign) BOOL aliexpress;
/**
 通知支持 shopee 功能
 */
@property (nonatomic,assign) BOOL shopee;
/**
 通知支持 teams 功能
 */
@property (nonatomic,assign) BOOL teams;
/**
 通知支持 99Taxi 功能
 */
@property (nonatomic,assign) BOOL support99Taxi;
/**
 通知支持 uberEats 功能
 */
@property (nonatomic,assign) BOOL uberEats;
/**
 通知支持 lFood 功能
 */
@property (nonatomic,assign) BOOL lFood;
/**
 通知支持 rappi 功能
 */
@property (nonatomic,assign) BOOL rappi;
/**
 通知支持 mercado Livre 功能
 */
@property (nonatomic,assign) BOOL mercadoLivre;
/**
 通知支持 Magalu 功能
 */
@property (nonatomic,assign) BOOL magalu;
/**
 通知支持 Americanas  功能
 */
@property (nonatomic,assign) BOOL americanas;
/**
 通知支持 Yahoo 功能
 */
@property (nonatomic,assign) BOOL yahoo;

/**
 定向越野
 */
@property (nonatomic,assign) BOOL orienteering;
/**
 山地骑行
 */
@property (nonatomic,assign) BOOL mountainBiking;
/**
 沙滩网球
 */
@property (nonatomic,assign) BOOL beachTennis;

/**
 智能跳绳
 */
@property (nonatomic,assign) BOOL smartRope;

/**
 gto1pro 固件支持app获取联系人本地文件修改时间或者上传全部通讯录联系人
 */
@property (nonatomic,assign) BOOL v2SupportGetAllContact;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetFuncTable31BluetoothModel
 */
+ (IDOGetFuncTable33BluetoothModel *)currentModel;

@end


#pragma mark ==== 获取第32个功能表model ====

@interface IDOGetFuncTable32BluetoothModel : IDOBluetoothBaseModel
/**
 * tiktok
 * tikTok
*/
@property (nonatomic,assign) BOOL tiktok;
/**
 * redbus
 * redbus
*/
@property (nonatomic,assign) BOOL redbus;
/**
 * dailyhunt
 * dailyhunt
*/
@property (nonatomic,assign) BOOL dailyhunt;
/**
 * hotstar
 * hotstar
*/
@property (nonatomic,assign) BOOL hotstar;
/**
 * inshorts
 * inshorts
*/
@property (nonatomic,assign) BOOL inshorts;
/**
 * paytm
 * paytm
*/
@property (nonatomic,assign) BOOL paytm;
/**
 * amazon
 * amazon
*/
@property (nonatomic,assign) BOOL amazon;
/**
 * flipkart
 * flipkart
*/
@property (nonatomic,assign) BOOL flipkart;
/**
 * 单独提醒雅虎邮箱
 */
@property (nonatomic,assign) BOOL onlyYahooEmail;
/**
 * 单独提醒outlook邮箱
 */
@property (nonatomic,assign) BOOL onlyOutlookEmail;
/**
 通知支持instantemail的功能表 (邮箱独立出来通知)
 */
@property (nonatomic,assign) BOOL onlyInstantemail;
/**
 通知支持nhnemail的功能表 (邮箱独立出来通知)
 */
@property (nonatomic,assign) BOOL onlyNhnemail;
/**
 通知支持zohoemail的功能表 (邮箱独立出来通知)
 */
@property (nonatomic,assign) BOOL onlyZohoemail;
/**
 通知支持exchangeemail的功能表 (邮箱独立出来通知)
 */
@property (nonatomic,assign) BOOL onlyExchangeemail;
/**
 通知支持189email的功能表 (邮箱独立出来通知)
 */
@property (nonatomic,assign) BOOL only189email;
/**
 * 单独提醒gmail邮箱 (邮箱独立出来通知)
 */
@property (nonatomic,assign) BOOL onlyGoogleGmail;
/**
 通知支持veryfit的功能表
 */
@property (nonatomic,assign) BOOL veryFitNotice;
/**
 通知支持general的功能表 | 通知支持通用的功能表
 */
@property (nonatomic,assign) BOOL general;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetFuncTable31BluetoothModel
 */
+ (IDOGetFuncTable32BluetoothModel *)currentModel;

@end

#pragma mark ==== 获取第31个功能表model ====

@interface IDOGetFuncTable31BluetoothModel : IDOBluetoothBaseModel

/**
 * v3 语言字库列表
 * v3 get lang lib list
*/
@property (nonatomic,assign) BOOL v3GetLangLib;

/**
 * 设置手机音量
 * set phone voice
*/
@property (nonatomic,assign) BOOL setPhoneVoice;

/**
 * 获取表盘ID
 * set phone voice
*/
@property (nonatomic,assign) BOOL getWatchId;

/**
 * 洗手提醒
 * hand wash reminder
*/
@property (nonatomic,assign) BOOL handWashReminder;

/**
 * 清除手环缓存
 * clear bluetooth cache
*/
@property (nonatomic,assign) BOOL clearBleCache;

/**
 * v3的语音文本回复
 * v3 voice reply txt
*/
@property (nonatomic,assign) BOOL v3VoiceReplyTxt;

/**
 * 获取设备名称
 * get device name
*/
@property (nonatomic,assign) BOOL getDevName;

/**
 * 亮屏时长
 */
@property (nonatomic,assign) BOOL brightScreenTime;
/**
 获取用户行为数据
 */
@property (nonatomic,assign) BOOL getHabitData;
/**
 固件支持游泳六轴传感器，app用来区分显示泳姿，
 有该传感器app游泳界面需显示所有泳姿及其距离，否则只显示主泳姿机器距离
 */
@property (nonatomic,assign) BOOL sixAxisSensor;
/**
 勿扰模式设置获取新增全天勿扰开关和只能开关
 */
@property (nonatomic,assign) BOOL noDisturbAllDayOnOff;

/** //注：之前的全天勿扰开关与智能勿扰开关使用的同一个功能表noDisturbAllDayOnOff支持,
    后续为了方便开发,新固件不需要开启前者,转用以下两个功能表去支持 2022-11-7
 支持设置全天勿扰开关
 */
@property (nonatomic,assign) BOOL v2NoDisturbAllDaySwitch;
/**
 支持设置智能勿扰开关
 */
@property (nonatomic,assign) BOOL v2NoDisturbSmartSwitch;

/**
 支持获取固件电池模式
 */
@property (nonatomic,assign) BOOL getBatteryMode;
/**
 v3多运动同步支持实时速度显示
 */
@property (nonatomic,assign) BOOL activitySyncRealTime;

/**
 文件传输最后传输完成等待固件发送d1 02校验完后app在发送d1 03
 */
@property (nonatomic,assign) BOOL dataTranOverWaitBle;
/**
 支持v3协议获取热启动参数
 */
@property (nonatomic,assign) BOOL supportSetHotStartParam;
/**
 支持获取固件本地提示音文件信息
 */
@property (nonatomic,assign) BOOL supportGetBleBeep;
/**
 v3支持运动最小图标传输设置
 */
@property (nonatomic,assign) BOOL supporSportIconMinSmall DEPRECATED_MSG_ATTRIBUTE("this attribute is discarded");
/**
 支持第二套运动图标功能表    目前仅idw05支持
 */
@property (nonatomic,assign) BOOL secondSportIcon;

/**
 支持v3天气协议下发积雪厚度
 */
@property (nonatomic,assign) BOOL v3WeatcherAddSnowDepth;
/**
 支持v3天气协议下发降雪量
 */
@property (nonatomic,assign) BOOL v3WeatcherAddSnowfall;
/**
 支持v3天气协议下发大气压强
 */
@property (nonatomic,assign) BOOL v3WeatcherAddAtmosphericpressure;
/**
 支持v3天气协议下发协议版本0x4版本
 v3天气包含月相
 */
@property (nonatomic,assign) BOOL v3WeatcherSendStructVersion04;

/**
 支持多运动数据同步及交互支持获取3d距离、平均3d速度、平均垂直速度数据
 */
@property (nonatomic,assign) BOOL supportActivityData3dDistanceSpeed;

/**
 支持多运动数据同步及交互支持获取海拔高度相关信息数据
 */
@property (nonatomic,assign) BOOL supportActivityDataAltitudeInfo;

/**
 支持多运动数据同步及交互支持获取平均坡度数据
 */
@property (nonatomic,assign) BOOL supportActivityDataAvgSlope;
/**
 固件支持制作表盘使用lz4压缩
 */
@property (nonatomic,assign) BOOL supportDailCompressModelz4;

/**
 支持同步数据及多运动交互获取负荷
 */
@property (nonatomic,assign) BOOL supportSyncActivityGetLoad;
/**
 支持同步数据及多运动交互获取无氧训练效果
 */
@property (nonatomic,assign) BOOL supportSyncActivityGetAnaerobicTrainingEffect;
/**
 支持同步数据及多运动交互获取跑步功率及跑力指数
 */
@property (nonatomic,assign) BOOL supportSyncActivityGetRunningPowerInfo;
/**
 支持同步数据及多运动交互获取实时体力
 */
@property (nonatomic,assign) BOOL supportSyncActivityGetRealTimePhysicalExertion;
/**
 支持同步数据及多运动交互获取实时摄氧量
 */
@property (nonatomic,assign) BOOL supportSyncActivityGetRealTimeOxygenConsumption;

/**
 支持固件快速定位，APP下发GPS权限及经纬度给固件
 */
@property (nonatomic,assign) BOOL supportSendGpsLongitudeAndLatitude;

/**
 支持APP多运动交互中，获取海拔上升海拔下降指标
 */
@property (nonatomic,assign) BOOL supportExchangeActivityGetAltitudeRiseLoss;

/**
 支持APP多运动交互中，获取GPS状态指标
 */
@property (nonatomic,assign) BOOL supportExchangeActivityGetGpsStatus;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetFuncTable31BluetoothModel
 */
+ (IDOGetFuncTable31BluetoothModel *)currentModel;

@end

#pragma mark ==== 获取第30个功能表model ====

@interface IDOGetFuncTable30BluetoothModel : IDOBluetoothBaseModel
/**
 * 恢复出厂设置
 * restore factory
*/
@property (nonatomic,assign) BOOL restoreFactory;
/**
 * 屏幕亮度获取
 * get screen brightness
*/
@property (nonatomic,assign) BOOL getScreenBrightness;
/**
 * 抬腕亮屏数据获取
 * get up hand gesture
*/
@property (nonatomic,assign) BOOL getUpHandGesture;
/**
 * 勿擾模式获取
 * get not disturb
*/
@property (nonatomic,assign) BOOL getNotDisturb DEPRECATED_MSG_ATTRIBUTE("this attribute is discarded");
/**
 * 快速短信获取
 * fast msg data
*/
@property (nonatomic,assign) BOOL fastMsgData;

/**
 * 获取手环的升级状态
 * get device update state
*/
@property (nonatomic,assign) BOOL getDeviceUpdateState;

/**
 * v3多运动同步
 * v3 sports
*/
@property (nonatomic,assign) BOOL v3Sports;

/**
 * v3多运动同步数据交换
 * v3 activity exchange data
 */
@property (nonatomic,assign) BOOL v3ActivityExchangeData;
/**
 v3血压校准
 */
@property (nonatomic,assign) BOOL v3BPCalibration;
/**
 获取呼吸率、身体电量开关
 */
@property (nonatomic,assign) BOOL getSwithAppend;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetFuncTable30BluetoothModel
 */
+ (IDOGetFuncTable30BluetoothModel *)currentModel;
@end

#pragma mark ==== 获取第29个功能表model ====

@interface IDOGetFuncTable29BluetoothModel : IDOBluetoothBaseModel
/**
 * v3的闹钟的同步
 * v3 sync alarm
 */
@property (nonatomic,assign) BOOL v3SyncAlarm;
/**
 *支持ublox模块
 *ublox model
 */
@property (nonatomic,assign) BOOL ubloxModel;
/**
 *v3多运动同步数据,洪堡APP定制
 *v3 sync activity custom made
*/
@property (nonatomic,assign) BOOL v3SyncActivity;
/**
 *获取过热日志
 *get heat log
*/
@property (nonatomic,assign) BOOL getHeatLog;
/**
 *V3血氧数据 偏移按照分钟偏移功能表位
 *v3 spo2 offset change
*/
@property (nonatomic,assign) BOOL v3Spo2OffsetChange;
/**
 *3级亮度调节 默认是5级别，手表app显示，手表不显示
 *screen brightness 3 level
*/
@property (nonatomic,assign) BOOL screenBrightness3Level;
/**
 *绑定授权码，授权绑定
 *encrypted auth
*/
@property (nonatomic,assign) BOOL encryptedAuth;
/**
 *v3睡眠眼动数据同步
 *v3 sleep
*/
@property (nonatomic,assign) BOOL v3Sleep;

/**
 kr01定制    支持v3闹钟设置获取指定名称闹钟
 */
@property (nonatomic,assign) BOOL alarmSpecifyType;

/**
 IDW05新增需求快捷应用添加类型一键测量
 */
@property (nonatomic,assign) BOOL menuListTypeMeasure;

/**
 支持v3血压校准
 */
@property (nonatomic,assign) BOOL bpCalibrationV3;

/**
 支持app下发获取所有健康开关上添加身体电量开关和呼吸率开关
 */
@property (nonatomic,assign) BOOL switchStatusAppend;

/**
 支持app下发v2获取心率监测模式
 */
@property (nonatomic,assign) BOOL heartRateModeV2;

/**
 支持阿里巴巴邮箱
 */
@property (nonatomic,assign) BOOL alibabaEmail;

/**
 通知支持Calendario(谷歌日历)
 */
@property (nonatomic,assign) BOOL calendario;
/**
 支持app设置获取运动三环周目标
 */
@property (nonatomic,assign) BOOL timeGoalType;

/**
 支持同步hrv(心率变异性水平)数据
 */
@property (nonatomic,assign) BOOL supportHrv;

/**
 支持gps文件升级
 */
@property (nonatomic,assign) BOOL supportUpdateGps;

/**
 支持支持跑前热身
 */
@property (nonatomic,assign) BOOL supportWarmUpBeforeRun;

/**
 支持设置紧急联系人
 */
@property (nonatomic,assign) BOOL supportV3SetEmergencyConnact;
/**
 支持喝水提醒设置免提醒时间段
 */
@property (nonatomic,assign) BOOL supportSetDrinkNoReminder;
/**
 支持走动提醒设置免提醒时间段
 */
@property (nonatomic,assign) BOOL supportSetWalkNoReminder;
/**
 支持v3日程提醒中重复提醒类型设置(0:无效 1:仅一次 2:每天 3:每周 4:每月 5:每年）
 */
@property (nonatomic,assign) BOOL supportV3RepScheduleReminder;
/**
 支持v3天气协议未来48小时温度详情内发送单个小时的降水概率
 */
@property (nonatomic,assign) BOOL supportV3HourPrecipitation DEPRECATED_MSG_ATTRIBUTE("this attribute is discarded");
/**
 支持app设置目标步数类型为周目标
 */
@property (nonatomic,assign) BOOL supportStepWeekTarget;

/**
 支持操作小程序
 */
@property (nonatomic,assign) BOOL supportMiniProgram;
/**
 润丰 支持获取固件外设信息
 */
@property (nonatomic,assign) BOOL supportRFGetPeripheralsInfo;
/**
 润丰 支持app下发外设信息
 */
@property (nonatomic,assign) BOOL supportRFSetPeripheralsInfo;
/**
 润丰 支持app下发体脂秤model映射表
 */
@property (nonatomic,assign) BOOL supportRFScalesModelMapTable;
/**
 润丰 支持app下发绑定设备列表
 */
@property (nonatomic,assign) BOOL supportRFBindDeviceTable;

/**
 gtx02 支持亮度设置日落后开启
 */
@property (nonatomic,assign) BOOL supportV2NightTurnOnAfterSunset;

/**
 支持v3常用联系人设置回复结构体使用协议版本号0x10
 */
@property (nonatomic,assign) BOOL supportV3SetContactVersion;

/**
 支持通话列表
 */
@property (nonatomic,assign) BOOL supportCallList;
/**
 支持v3同步睡眠数据睡眠阶段的心率平均值有效
 */
@property (nonatomic,assign) BOOL supportV3SleepAvgHr;

/**
 同步v3多运动活动数据结束时间原字段(end_month&end_day&end_hour&end_minute)收回,使用时间戳点形式上报app
 */
@property (nonatomic,assign) BOOL v3ActivityEndTimeUseUtc;

/**
 支持控制设备重启蓝牙
 */
@property (nonatomic,assign) BOOL reseDeviceBluetooth;

/**
 支持文件传输(d108&d101)中文件类型字段使用新的code对应不同的传输文件
 */
@property (nonatomic,assign) BOOL dataTypeUseNewCode;
/**
 功能表开启后,科学睡眠开关默认下发关闭 IDW13-PLUS新增需求
 */
@property (nonatomic,assign) BOOL scientificSleepSwitchOffByDefault;
/**
 功能表开启后,心率开关默认下发关闭 IDW13-PLUS新增需求
 */
@property (nonatomic,assign) BOOL heartRateOffByDefault;

/**
 功能表开启后,女性经期不支持设置排卵日提醒
 */
@property (nonatomic,assign) BOOL notSupportSetOvulation;

/**
 功能表开启后,室内跑步不支持获取最大摄氧量,app室内跑步不展示此数据
 */
@property (nonatomic,assign) BOOL notSupportIndoorRunGetVo2max;

/**
 功能表开启后,v3同步健康游泳数据verison2结构体固件支持返回平均划水频率,app可以展示该数据
 */
@property (nonatomic,assign) BOOL syncHealthSwimGetAvgFrequency;

/**
 功能表开启后,v3同步健康游泳数据verison2结构体固件支持返回平均划水频率,app可以展示该数据
 */
@property (nonatomic,assign) BOOL syncHealthSwimGetAvgSpeed;

/**
 支持v3同步睡眠数据睡眠阶段的血氧平均值有效
 */
@property (nonatomic,assign) BOOL syncAddSleepAvgSpo2;

/**
 针对DOUIv6版本表盘框架的动画像素进行fastlz压缩,优化固件存储大小
 */
@property (nonatomic,assign) BOOL supportDouiv6WatchDialAnimaCompress;

/**
 支持v3同步睡眠数据睡眠阶段的呼吸率平均值有效
 */
@property (nonatomic,assign) BOOL syncAddSleepAvgRespirRate;

/**
 支持获取v3固件算法版本号信息
 */
@property (nonatomic,assign) BOOL getV3DeviceAlgorithmVersion;

/**
 通知支持Fastrack Reflex World
 */
@property (nonatomic,assign) BOOL supportFastrackReflexWorld;
/**
 通知支持Hama Fit Move
 */
@property (nonatomic,assign) BOOL supportHamaFitMove;

/**
 通知支持淘宝
 */
@property (nonatomic,assign) BOOL supportTaobao;
/**
 通知支持钉钉
 */
@property (nonatomic,assign) BOOL supportDingtalk;
/**
 通知支持支付宝
 */
@property (nonatomic,assign) BOOL supportAlipay;
/**
 支持今日头条
 */
@property (nonatomic,assign) BOOL supportToutiao;

/**
 通知支持天猫的功能表
 */
@property (nonatomic,assign) BOOL supportTmail;
/**
 通知支持京东
 */
@property (nonatomic,assign) BOOL supportJD;
/**
 通知支持拼多多
 */
@property (nonatomic,assign) BOOL supportPinduoduo;
/**
 通知支持百度
 */
@property (nonatomic,assign) BOOL supportBaidu;
/**
 通知支持美团
 */
@property (nonatomic,assign) BOOL supportMeituan;
/**
 通知支持饿了么
 */
@property (nonatomic,assign) BOOL supportEleme;
/**
 设备支持喇叭
 */
@property (nonatomic,assign) BOOL supportLoudspeaker;
/**
 app新增需求 运动模式自动识别开关设置获取 新增类型智能跳绳
 */
@property (nonatomic,assign) BOOL autoActivitySwitchAddSmartRope;
/**
 app新增需求 运动模式自动识别开关设置获取 新增类型智能跳绳
 */
@property (nonatomic,assign) BOOL supportSyncActivityGetRopeInfo;

/**
 通知支持抖音国内版
 */
@property (nonatomic,assign) BOOL supportDouyin;

/**
 通知支持新浪微博国内版
 */
@property (nonatomic,assign) BOOL supportHomeWeibo;

/**
 v3天气设置支持各item指针项动态配置，app会按照所有项目最大数量下发，项目根据需要取前面的item项。
 */
@property (nonatomic,assign) BOOL supportSetV3WeatherDynamicConfig;
/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetFuncTable29BluetoothModel
 */
+ (IDOGetFuncTable29BluetoothModel *)currentModel;
@end

#pragma mark ==== 获取第28个功能表model ====

@interface IDOGetFuncTable28BluetoothModel : IDOBluetoothBaseModel

/**
 * 充电时间
 * charging time
 */
@property (nonatomic,assign) BOOL chargingTime;
/**
 *菜单设置
 *menu list
 */
@property (nonatomic,assign) BOOL menuList;
/**
 *背景照片
 *photo wallpaper
*/
@property (nonatomic,assign) BOOL photoWallpaper;
/**
 *语音功能
 *voice transmission
*/
@property (nonatomic,assign) BOOL voiceTransmission;
/**
 *utc 时间
 *utc time zone
*/
@property (nonatomic,assign) BOOL utcTimeZone;
/**
 *新的4选2功能
 *New 4 choose 2 feature
*/
@property (nonatomic,assign) BOOL choiceUse;
/**
 *支持心率区间设置
 *heart rate interval
*/
@property (nonatomic,assign) BOOL heartRateInterval;
/**
 *v3的运动类型设置和获取
 *heart rate interval
*/
@property (nonatomic,assign) BOOL v3SportsType;
/**
 *v2支持设置歌曲信息展示开关
 *Show Music Info Switch
*/
@property (nonatomic,assign) BOOL v2SetShowMusicInfoSwitch;
/**
 *支持指南针
 *support Compass
*/
@property (nonatomic,assign) BOOL supportCompass;
/**
 *支持气压高度计
 *barometric altimeter
*/
@property (nonatomic,assign) BOOL supportBarometricAltimeter;
/**
 *支持固件支持app下发详情的最大数量 （常用联系人，日程提醒）
 *barometric altimeter
*/
@property (nonatomic,assign) BOOL supportGetSetMaxItemsNum;

/**
 *支持v3日程提醒中重复提醒类型设置星期重复 bit1-bit7 周一到周日 bit 0是总开关位（开关）
 *Support the recurring reminder type setting in v3 agenda reminders. Weekly recurring bit1-bit7.
 *Monday to Sunday bit 0 is the main switch position (switch)
*/
@property (nonatomic,assign) BOOL supportV3RepeatWeekTypeSeting;
/**
 *支持获取不可删除的快捷应用列表
 *Support to obtain the list of non deletable shortcut applications
*/
@property (nonatomic,assign) BOOL supportV2GetUnDeleMeun;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetFuncTable28BluetoothModel
 */
+ (IDOGetFuncTable28BluetoothModel *)currentModel;
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
 *繁体中文
 *traditional chinese
 */
@property (nonatomic,assign) BOOL traditionalChinese;
/**
 *希腊语
 *greek
 */
@property (nonatomic,assign) BOOL greek;
/**
 *阿拉伯语
 *arabic
 */
@property (nonatomic,assign) BOOL arabic;
/**
 瑞典语
 sweden
 */
@property (nonatomic,assign) BOOL sweden;
/**
 芬兰语
 finland
 */
@property (nonatomic,assign) BOOL finland;
/**
 波斯语
 persia
 */
@property (nonatomic,assign) BOOL persia;
/**
 挪威语
 norwegian
 */
@property (nonatomic,assign) BOOL norwegian;
/**
 马来语
 norwegian
 */
@property (nonatomic,assign) BOOL malay;
/**
 巴西葡语
 norwegian
 */
@property (nonatomic,assign) BOOL brazilianPortuguese;
/**
 孟加拉语
 bengali
 */
@property (nonatomic,assign) BOOL bengali;
/**
 高棉语
 khmer
 */
@property (nonatomic,assign) BOOL khmer;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetFuncTable27BluetoothModel
 */
+ (IDOGetFuncTable27BluetoothModel *)currentModel;
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
 日志功能
 */
@property (nonatomic,assign) BOOL flashLog;
/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetFuncTable26BluetoothModel
 */
+ (IDOGetFuncTable26BluetoothModel *)currentModel;
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
 普拉提 | pilates
 */
@property (nonatomic,assign) BOOL pilates;
/**
 户外玩耍(定制 kr01) | outdoor play
 */
@property (nonatomic,assign) BOOL outdoorPlay;
/**
 其他运动(定制 kr01) | other activity
 */
@property (nonatomic,assign) BOOL otherActivity;
/**
 尊巴舞 206Lite项目要求新增功能表
 */
@property (nonatomic,assign) BOOL zumba;
/**
 冲浪 运动类型170 ID205G-H(7613)定制
 */
@property (nonatomic,assign) BOOL surfing;
/**
 足排球 运动类型187  ID205G-H(7613)定制
 */
@property (nonatomic,assign) BOOL footvolley;
/**
 站立滑水 运动类型188 ID205G-H(7613)定制
 */
@property (nonatomic,assign) BOOL standWaterSkling;

/**
 站绳 运动类型198  ID205G-H(7613)定制
 */
@property (nonatomic,assign) BOOL battlingRope;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetFuncTable25BluetoothModel
 */
+ (IDOGetFuncTable25BluetoothModel *)currentModel;

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
+ (IDOGetFuncTable24BluetoothModel *)currentModel;

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
+ (IDOGetFuncTable23BluetoothModel *)currentModel;

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
+ (IDOGetFuncTable22BluetoothModel *)currentModel;
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
 keep
 */
@property (nonatomic,assign) BOOL keep;

/**
 踏步机 | stepper
 */
@property (nonatomic,assign) BOOL stepper;


/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetFuncTable21BluetoothModel
 */
+ (IDOGetFuncTable21BluetoothModel *)currentModel;
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
+ (IDOGetFuncTable20BluetoothModel *)currentModel;

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
+ (IDOGetFuncTable19BluetoothModel *)currentModel;

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
+ (IDOGetFuncTable18BluetoothModel *)currentModel;

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
 功能性训练 | functional training or  strength_training
 */
@property (nonatomic,assign) BOOL functionalTraining;

/**
 核心训练 | core training
 */
@property (nonatomic,assign) BOOL  coreTraining;

/**
 整体放松 | tidy up relax
 */
@property (nonatomic,assign) BOOL  tidyUpRelax;
/**
 传统的力量训练
 traditional strength training
 */
@property (nonatomic,assign) BOOL traditionalStrengthTraining;
/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetFuncTable17BluetoothModel
 */
+ (IDOGetFuncTable17BluetoothModel *)currentModel;

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
 滑板 | skateboard
 */
@property (nonatomic,assign) BOOL skateboard;

/**
 登山
 */
@property (nonatomic,assign) BOOL mountaineering;

/**
 深蹲
 */
@property (nonatomic,assign) BOOL squat;

/**
 匹克球
 */
@property (nonatomic,assign) BOOL pickleball;

/**
 有氧健身操
 */
@property (nonatomic,assign) BOOL aerobicsBodybuildingExercise;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetFuncTable16BluetoothModel
 */
+ (IDOGetFuncTable16BluetoothModel *)currentModel;

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

+ (IDOGetFuncTable15BluetoothModel *)currentModel;
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
+ (IDOGetFuncTable14BluetoothModel *)currentModel;

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
+ (IDOGetFuncTable13BluetoothModel *)currentModel;

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
 设置v3心率的间隔 | set v3 heart rate interval
 */
@property (nonatomic,assign) BOOL setV3HeartInterval;

/**
 默认是支持agps online升级 | default support agps online
 */
@property (nonatomic,assign) BOOL agpsOnLine;

/**
 默认是支持agps off升级 | default support agps off online
 */
@property (nonatomic,assign) BOOL agpsOffLine;

/**
 天气城市 | weather city
 */
@property (nonatomic,assign) BOOL weatherCity;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetFuncTable12BluetoothModel
 */
+ (IDOGetFuncTable12BluetoothModel *)currentModel;

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
+ (IDOGetFuncTable11BluetoothModel *)currentModel;

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
+ (IDOGetFuncTable10BluetoothModel *)currentModel;

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
 其他提醒
 */
@property (nonatomic,assign) BOOL otherReminder;
/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetFuncTable9BluetoothModel
 */
+ (IDOGetFuncTable9BluetoothModel *)currentModel;

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
+ (IDOGetFuncTable8BluetoothModel *)currentModel;
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
 设置单位支持华氏度 | support fahrenheit
 */
@property (nonatomic,assign) BOOL supportFahrenheit;

/**
 V3功能表 | v3 function table
 */
@property (nonatomic,assign) BOOL v3FunctionTable;

/**
 支持app设置屏幕亮度显示间隔 | set screen bright interval
 */
@property (nonatomic,assign) BOOL screenBrightInterval;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetFuncTable7BluetoothModel
 */
+ (IDOGetFuncTable7BluetoothModel *)currentModel;
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
 吃饭 | dinner
 */
@property (nonatomic,assign) BOOL dinner;

/**
 刷牙 | brush teeth
 */
@property (nonatomic,assign) BOOL brushTeeth;

/**
 休息 | rest
 */
@property (nonatomic,assign) BOOL rest;

/**
 课程 | course
 */
@property (nonatomic,assign) BOOL course;
/**
 洗澡 | shower
 */
@property (nonatomic,assign) BOOL shower;
/**
 学习 | learning
 */
@property (nonatomic,assign) BOOL learning;

/**
 玩耍时间
 */
@property (nonatomic,assign) BOOL playTime;

/**
 * @brief  查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetFuncTable6BluetoothModel
 */
+ (IDOGetFuncTable6BluetoothModel *)currentModel;
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
+ (IDOGetFuncTable5BluetoothModel *)currentModel;
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
+ (IDOGetFuncTable4BluetoothModel *)currentModel;

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
+ (IDOGetFuncTable3BluetoothModel *)currentModel;

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
+ (IDOGetFuncTable2BluetoothModel *)currentModel;
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
+ (IDOGetFuncTable1BluetoothModel *)currentModel;
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
 28功能列表 充电时间 | 28 func table
 */
@property (nonatomic,strong) IDOGetFuncTable28BluetoothModel      * funcTable28Model;

/**
 29功能列表 同步v3闹钟 | 29 func table
 */
@property (nonatomic,strong) IDOGetFuncTable29BluetoothModel      * funcTable29Model;

/**
 30功能列表 恢复出厂设置 | 30 func table
 */
@property (nonatomic,strong) IDOGetFuncTable30BluetoothModel      * funcTable30Model;

/**
 31功能列表 v3 语言字库列表 | 31 func table
 */
@property (nonatomic,strong) IDOGetFuncTable31BluetoothModel      * funcTable31Model;

/**
 32功能列表 TikTok notify | 32 func table
 */
@property (nonatomic,strong) IDOGetFuncTable32BluetoothModel      * funcTable32Model;

/**
 33功能列表 Prime notify | 33 func table
 */
@property (nonatomic,strong) IDOGetFuncTable33BluetoothModel      * funcTable33Model;

/**
 34功能列表 taking medicine | 34 func table
 */
@property (nonatomic,strong) IDOGetFuncTable34BluetoothModel      * funcTable34Model;

/**
 35功能列表 scientific sleep | 35 func table
 */
@property (nonatomic,strong) IDOGetFuncTable35BluetoothModel      * funcTable35Model;

/**
 36功能列表 alexa control | 36 func table
 */
@property (nonatomic,strong) IDOGetFuncTable36BluetoothModel      * funcTable36Model;

/**
 37功能列表 unit goal | 37 func table
 */
@property (nonatomic,strong) IDOGetFuncTable37BluetoothModel      * funcTable37Model;

/**
 38功能列表 weather sun time | 38 func table
 */
@property (nonatomic,strong) IDOGetFuncTable38BluetoothModel      * funcTable38Model;

/**
 39功能列表 weather sun time | 39 func table
 */
@property (nonatomic,strong) IDOGetFuncTable39BluetoothModel      * funcTable39Model;

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
  是否需要同步v2数据 ｜ is need sync v2 data
 */
@property (nonatomic,assign) BOOL isNeedSyncV2;
/**
 事项提醒支持数量为0 则默认是30
 */
@property (nonatomic,assign) NSInteger scheduleReminderCount DEPRECATED_MSG_ATTRIBUTE("this attribute is discarded");
/**
 常用联系人支持同步的最大数量  0的话最大个数默认是10
 */
@property (nonatomic,assign) NSInteger contactPhoneCount DEPRECATED_MSG_ATTRIBUTE("this attribute is discarded");

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetDeviceFuncBluetoothModel
 */
+ (IDOGetDeviceFuncBluetoothModel *)currentModel;

/**
 * @brief 判断是否有运动模式 | Determine if there are movement patterns
 */
+ (BOOL)isHaveMovment;

@end

#pragma mark ==== 获取设备信息model ====
@interface IDOGetDeviceInfoBluetoothModel:IDOBluetoothBaseModel

/**
 设备模式 0x00：运动模式， 0x01：睡眠模式 | Device mode
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
 * 0:nordic,10:realtek 8762x ,20:cypress psoc6,30:Apollo3,40:汇顶,50:nordic+泰凌微,
 * 60:泰凌微+5340+no nand flash,70:汇顶+富瑞坤;80:5340;90:炬心; 99:思澈; 98:思澈(芯语物)
 */
@property (nonatomic,assign) NSInteger platform;

/**
 * 手环是否同步过配置 | is sync config
 *
 */
@property (nonatomic,assign) BOOL isSyncConfig;

/**
 * 绑定加密授权码错误 ｜ auth code error
 *
 */
@property (nonatomic,assign) BOOL authCodeError;

/**
 * 设备形状类型 0：无效；1：圆形；2：方形的； 3：椭圆
 * device shape type 0: Invalid; 1: Round; 2: Square; 3: the elliptical
 */
@property (nonatomic,assign) NSInteger deviceShapeType;

/**
 * 设备类型 0：无效；1：手表；2：手环；
 * device shape type 0: Invalid; 1:Watch ; 2: Bracelet
 */
@property (nonatomic,assign) NSInteger deviceType;

/**
 * 自定义表盘主版本 从1开始 0:不支持对应的自定义表盘功能
 * dial main version
 */
@property (nonatomic,assign) NSInteger dialMainVersion;

/**
 * 自定义表盘子版本 从0开始 主版本号如果是0，子版本无效
 * dial sub version
 */
@property (nonatomic,assign) NSInteger dialSubVersion;

/**
 * 固件绑定时候显示勾ui界面 0:不需要 1:需要
 * show bind choice UI
 */
@property (nonatomic,assign) NSInteger showBindChoiceUi;

/**
 * nodic平台固件版本
 * nodic bootloadVersion
 */
@property (nonatomic,assign) NSInteger bootloadVersion;
/**
 * 主账号设备 :  1  子账号设备  :  2
 */
@property (nonatomic,assign) NSInteger masterDevice;

/**
 设备bt名字
 */
@property (nonatomic,copy) NSString * deviceBtName;

/**
 GPS芯片平台
   0：无效
   1：索尼 sony
   2：洛达 Airoh
   3：芯与物 icoe
 */
@property (nonatomic,assign) NSInteger gpsPlatform;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetDeviceInfoBluetoothModel
 */
+ (IDOGetDeviceInfoBluetoothModel *)currentModel;

/**
 * @brief 查询本地所有设备信息（不包括Mac地址不存在的设备）
 * Query all local device information (excluding devices where Mac addresses do not exist)
 * @return IDOGetDeviceInfoBluetoothModel array
 */
+ (NSArray <IDOGetDeviceInfoBluetoothModel *>*)queryAllDeviceModels;

@end

#pragma mark ==== 获取mac地址model ====
@interface IDOGetMacAddrInfoBluetoothModel:IDOBluetoothBaseModel
/**
 BT  Mac 地址
 */
@property (nonatomic,copy) NSString * btMacAddr;
/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetMacAddrInfoBluetoothModel
 */
+ (IDOGetMacAddrInfoBluetoothModel *)currentModel;
@end


@interface IDOGetInfoBluetoothModel : IDOBluetoothBaseModel

@end

#pragma mark ==== 获取固件本地提示音 model ====
@interface IDOGetBeepFileListBluetoothModel : IDOBluetoothBaseModel
/**
 从1开始
 */
@property (nonatomic,assign) NSInteger beepVersion;
/**
 00 成功  非0失败
*/
@property (nonatomic,assign) NSInteger errCode;
/**
 item(提示音)个数
 */
@property (nonatomic,assign) NSInteger itemCount;
/**
 提示音文件名列表
 */
@property (nonatomic,strong) NSArray<NSString *> * item;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetBeepFileListBluetoothModel
 */
+ (IDOGetBeepFileListBluetoothModel *)currentModel;

@end


#pragma mark ==== 获取固件支持app下发的详情的最大数量 model ====
@interface IDOGetSettingMaxItemsNumBluetoothModel : IDOBluetoothBaseModel
/**
 常用联系人 固件支持app下发最大设置数量 0默认10个
 */
@property (nonatomic,assign) NSInteger contactMaxSetNum;
/**
 日程提醒 固件支持app下发最大设置数量 预留
*/
@property (nonatomic,assign) NSInteger reminderMaxSetNum;
/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetSettingMaxItemsNumBluetoothModel
 */
+ (IDOGetSettingMaxItemsNumBluetoothModel *)currentModel;

@end


#pragma mark ==== 获取算法版本 model ====
@interface IDOGetAlgVersionItemBluetoothModel : IDOBluetoothBaseModel
/**
 算法版本类型 0:睡眠 1:计步 2:心率 3:全天心率 4:血氧 5:卡路里 6:距离 7:GPS 8:手势识别 9:游泳 10:运动自识别
 */
@property (nonatomic,assign) NSInteger type;
/**
 版本号级别 默认三级版本 字段预留方便扩展
*/
@property (nonatomic,assign) NSInteger versionLevel;

/**
 三级版本号拼接:version1.version2.version3
*/
@property (nonatomic,assign) NSInteger version1;

/**
 三级版本号拼接:version1.version2.version3
*/
@property (nonatomic,assign) NSInteger version2;

/**
 三级版本号拼接:version1.version2.version3
*/
@property (nonatomic,assign) NSInteger version3;

@end

@interface IDOGetAlgVersionBluetoothModel : IDOBluetoothBaseModel
/**
 协议版本 默认0
 */
@property (nonatomic,assign) NSInteger algVersion;
/**
 算法版本详情个数
*/
@property (nonatomic,assign) NSInteger itemNum;
/**
 算法版本详情
 */
@property (nonatomic,strong) NSArray<IDOGetAlgVersionItemBluetoothModel *> * item;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetAlgVersionBluetoothModel
 */
+ (IDOGetAlgVersionBluetoothModel *)currentModel;

@end


#pragma mark ==== 获取全天目标步数 | Get the daily target steps model  ====
@interface IDOGetStepGoalBluetoothModel : IDOBluetoothBaseModel
/**
 全天日目标步数
 Full day target steps
 */
@property (nonatomic,assign) NSInteger stepDayGoal;
/**
 全天周目标步数
 Full week target steps
 */
@property (nonatomic,assign) NSInteger stepWeekGoal;
/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetStepGoalBluetoothModel
 */
+ (IDOGetStepGoalBluetoothModel *)currentModel;

@end


@interface IDOGetBpVersionBluetoothModel : IDOBluetoothBaseModel

/**
 固件血压算法版本version1
 */
@property (nonatomic,assign) NSInteger bpVersion1;
/**
 固件血压算法版本version2
 */
@property (nonatomic,assign) NSInteger bpVersion2;
/**
 固件血压算法版本version3
 */
@property (nonatomic,assign) NSInteger bpVersion3;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOGetBpVersionBluetoothModel
 */
+ (IDOGetBpVersionBluetoothModel *)currentModel;


@end
