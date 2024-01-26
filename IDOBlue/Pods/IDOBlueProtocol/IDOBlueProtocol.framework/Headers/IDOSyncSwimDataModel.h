//
//  IDOSyncSwimDataModel.h
//  IDOBluetoothInternal
//
//  Created by 何东阳 on 2019/8/6.
//  Copyright © 2019 何东阳. All rights reserved.
//

#import <Foundation/Foundation.h>

#if __has_include(<IDOBlueProtocol/IDOBlueProtocol.h>)
#else
#import "IDOBluetoothBaseModel.h"
#endif

@interface IDOSyncSwimItemDataInfoBluetoothModel : IDOBluetoothBaseModel
/**
 开始时间 精确到秒 | start time interval since 1970 (eg 14442361933)
 */
@property (nonatomic,copy) NSString * timeStr;

/**
 持续时间 (单位:秒) | duration (unit:second)
 */
@property (nonatomic,assign) NSInteger duration;

/**
 划水次数 | strokes number
 */
@property (nonatomic,assign) NSInteger strokesNumber;

/**
 评分 | swolf
 */
@property (nonatomic,assign) NSInteger swolf;

/**
 序列号 | Serial number
 */
@property (nonatomic,assign) NSInteger  serialNumber;

/**
 * 每一趟的泳姿 | swimming posture
 * 0x00 : 混合泳; 0x01 : 自由泳; 0x02 : 蛙泳; 0x03 : 仰泳; 0x04 : 蝶泳;
 * 0x00: medley; 0x01: freestyle; 0x02: breaststroke; 0x03: backstroke; 0x04: butterfly stroke;
 */
@property (nonatomic,assign) NSInteger  swimmingPosture;

/**
 每一趟的距离 (单位:米) | distance (unit:m)
 */
@property (nonatomic,assign) NSInteger  distance;

/**
 频率 | frequency
 */
@property (nonatomic,assign) NSInteger frequency;

/**
配速 | speed
*/
@property (nonatomic,assign) NSInteger speed;

/**
 结束时间 | stop time
 */
@property (nonatomic,assign) NSInteger stopTime;

/**
 2趟之间的休息时间
 difference time
 */
@property (nonatomic,assign) NSInteger differenceTime;
 
@end

@interface IDOSyncSwimmingDataInfoBluetoothModel : IDOBluetoothBaseModel
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
 日期 精确到日期 date interval since 1970 (如:1444361933) | Date time interval since 1970 (eg 14442361933)
 */
@property (nonatomic,copy) NSString * dateStr;

/**
 开始时间 精确到秒 | start time interval since 1970 (eg 14442361933)
 */
@property (nonatomic,copy) NSString * timeStr;

/**
 游泳类型 0x00:无效,0x01:室内游泳,0x02:开阔水域游泳 | 0x00:invalid,0x01:Indoor swimming,0x02:Open water swimming
 */
@property (nonatomic,assign) NSInteger type;

/**
 卡路里(单 位:大卡) | Calories (Unit: Big Card)
 */
@property (nonatomic,assign) NSInteger calories;

/**
 距离(单位: 米) | Distance (in meters)
 */
@property (nonatomic,assign) NSInteger distance;

/**
 游泳趟数 | Swimming train number
 */
@property (nonatomic,assign) NSInteger trips;

/**
 平均 swolf | average swolf
 */
@property (nonatomic,assign) NSInteger averageSwolf;

/**
 总划水次数 | total strokes number
 */
@property (nonatomic,assign) NSInteger totalStrokesNumber;

/**
 * 主泳姿 | swimming posture
 * 0x00 : 混合泳; 0x01 : 自由泳; 0x02 : 蛙泳; 0x03 : 仰泳; 0x04 : 蝶泳;
 * 0x00: medley; 0x01: freestyle; 0x02: breaststroke; 0x03: backstroke; 0x04: butterfly stroke;
 */
@property (nonatomic,assign) NSInteger swimmingPosture;

/**
 泳池距离 (单位:m) | pool distance (unit:m)
 */
@property (nonatomic,assign) NSInteger poolDistance;

/**
 游泳数据包量 | swimming data package
 */
@property (nonatomic,assign) NSInteger itemsCount;

/**
 * @brief 游泳集合 只有定义好的查询方法才能转成model集合，自定义的查询方法无法直接转成model集合，需要再查询itemModel赋给当前属性
 * swimming collection Only defined query methods can be converted into model collections. Custom query methods cannot be directly converted
 * into model collections. You need to query itemModel to assign current attributes.
 */
@property (nonatomic,copy) NSArray <IDOSyncSwimItemDataInfoBluetoothModel *>* swimmingItems;

/**
 用户确认的距离 | confirm distance
 */
@property (nonatomic,assign) NSInteger confirmDistance;

/**
 游泳持续时长 单位:分钟 | duration unit:minute
 */
@property (nonatomic,assign) NSInteger duration;

/**
 平均配速 | avg speed
 */
@property (nonatomic,assign) NSInteger avgSpeed;

/**
平均划水频率 | avg frequency
*/
@property (nonatomic,assign) NSInteger avgFrequency;

/**
 游泳数据版本号
 swim data version
 */
@property (nonatomic,assign) NSInteger swimVersion;

/**
 总游泳时长  (单位:s),  若是0，有可能是固件不支持 | Total swimming time (unit:s) ，If it is 0, it is possible that the firmware does not support it
 */
@property (nonatomic,assign) NSInteger totalDuration;

/**
 总休息时长 (单位:s) ，若是0，有可能是固件不支持  | Total rest time (unit:s)，If it is 0, it is possible that the firmware does not support it
 */
@property (nonatomic,assign) NSInteger totalRestTime;

/**
 泳池距离 (单位:m), 小数点（放大10000倍） | Swimming pool distance (in meters), decimal point (magnified by 10000 times)
 */
@property (nonatomic,assign) NSInteger poolDistanceDecimal;

@end


@interface IDOSyncSwimDataModel : NSObject
/**
 * @brief 当前设备根据游泳开始时间查询某个游泳详情
 * The current device queries an swim details based on the event start time
 * @param macAddr  mac地址 | Mac address
 * @param timeStr 游泳开始时间 | swim start time
 * @return model IDOSyncSwimmingDataInfoBluetoothModel
 */
+ (IDOSyncSwimmingDataInfoBluetoothModel *)querySwimDataWithTimeStr:(NSString *)timeStr
                                                            macAddr:(NSString *)macAddr;

/**
 * @brief 当前设备查询一天所有游泳数据
 * The current device queries an swim details based on the event start time
 * @param macAddr  mac地址 | Mac address
 * @param dateStr 日期时间戳 | Date time stamp
 * @return 一天游泳数据的集合 | Collection of day swim data
 */
+ (NSArray <IDOSyncSwimmingDataInfoBluetoothModel *>*)querySwimDataWithDateStr:(NSString *)dateStr
                                                                       macAddr:(NSString *)macAddr;

/**
 * 查询所有游泳数据
 * @param macAddr  mac地址 | Mac address
 */
+ (NSArray <IDOSyncSwimmingDataInfoBluetoothModel *>*)queryAllSwimDataWithMacAddr:(NSString *)macAddr;

/**
 * 将json数据转模型数据 | Convert json data to model data
 * @param jsonString  数据
 */
+(IDOSyncSwimmingDataInfoBluetoothModel*)swimmingDataJsonStringToObjectModel:(NSString*)jsonString;

@end

