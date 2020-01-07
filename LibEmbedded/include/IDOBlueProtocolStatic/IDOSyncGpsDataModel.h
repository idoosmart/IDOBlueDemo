//
//  IDOSyncGpsDataModel.h
//  IDOBluetoothInternal
//
//  Created by 何东阳 on 2019/8/6.
//  Copyright © 2019 何东阳. All rights reserved.
//

#import <Foundation/Foundation.h>
#if __has_include(<IDOBluetoothInternal/IDOBluetoothInternal.h>)
#elif __has_include(<IDOBlueProtocol/IDOBlueProtocol.h>)
#else
#import "IDOBluetoothBaseModel.h"
#endif

@interface IDOSyncGpsDataItemInfoBluetoothModel : IDOBluetoothBaseModel

/**
 序列号 | Serial number
 */
@property (nonatomic,assign) NSInteger serialNumber;

/**
 经度 | Longitude
 */
@property (nonatomic,copy) NSString * latitudeStr;

/**
 纬度 | Latitude
 */
@property (nonatomic,copy) NSString * longitudeStr;

/**
 * 发起运动时间 时间戳 精确到秒 time interval since 1970 (如:1444361933)
 * Initiate exercise time Timestamp time interval since 1970 (eg 14442361933)
 */
@property (nonatomic,copy) NSString * timeStr;

/**
 日期 精确到日期 date interval since 1970 (如:1444361933) | date interval since 1970 (eg: 14443361933)
 */
@property (nonatomic,copy) NSString * dateStr;

@end


@interface IDOSyncGpsDataInfoBluetoothModel : IDOBluetoothBaseModel

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
 * 发起运动时间 时间戳 精确到秒 time interval since 1970 (如:1444361933)
 * Initiate exercise time Timestamp time interval since 1970 (eg 14442361933)
 */
@property (nonatomic,copy) NSString * timeStr;

/**
 日期 精确到日期 date interval since 1970 (如:1444361933) | date interval since 1970 (eg: 14443361933)
 */
@property (nonatomic,copy) NSString * dateStr;

/**
 gps数据包数量 | gps packet number
 */
@property (nonatomic,assign) NSInteger itemsCount;

/**
 间隔时长 (单位：秒)| Interval length （unit:second）
 */
@property (nonatomic,assign) int interval;

/**
 运动发起端 (1 : 手环发起 0 : app发起) | Sports Initiator (1 : Bracelet Initiation  0 : app initiated)
 */
@property (nonatomic,assign) NSInteger startFrom;

/**
 * GPS 坐标点集合 只有定义好的查询方法才能转成model集合，自定义的查询方法无法直接转成model集合，需要再查询itemModel赋给当前属性
 * GPS coordinate point set Only defined query methods can be converted into model collections. Custom query methods cannot be directly
 * converted into model collections. You need to query itemModel to assign current attributes.
 */
@property (nonatomic,copy) NSArray <IDOSyncGpsDataItemInfoBluetoothModel *>* gpsItems;

@end

@interface IDOSyncGpsDataModel : NSObject
/**
 * @brief 根据时间戳查询某个活动的GPS信息 | Querying the GPS information of an activity based on the timestamp
 * @param timeStr 时间戳  time interval since 1970 (如:1444361933) | Timestamp time interval since 1970 (eg: 14443361933)
 * @param macAddr mac 地址 | mac address
 * @return gps信息数据 坐标item对象集合 | gps information data coordinate item object collection
 */
+ (__kindof IDOSyncGpsDataInfoBluetoothModel *)queryOneActivityCoordinatesWithTimeStr:(NSString *)timeStr
                                                                              macAddr:(NSString *)macAddr;

/**
 * @brief 根据时间戳查询某个活动是否存在轨迹 | Query whether an activity has a track based on a timestamp
 * @param timeStr 时间戳  time interval since 1970 (如:1444361933) | Timestamp time interval since 1970 (eg: 14443361933)
 * @param macAddr mac 地址 | mac address
 * @return 是否存在轨迹 yes or no | Is there a track?
 */
+ (BOOL)queryActivityHasCoordinatesWithTimeStr:(NSString *)timeStr
                                       macAddr:(NSString *)macAddr;
@end

