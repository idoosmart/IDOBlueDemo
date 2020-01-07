//
//  IDOSyncActivityDataModel.h
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

@interface IDOSyncActivityDataInfoBluetoothModel : IDOBluetoothBaseModel

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
 数据长度 | Data length
 */
@property (nonatomic,assign) NSInteger  dataLength;

/**
 心率数据产生间隔 (单位 : s) | Heart rate data generation interval (unit: s)
 */
@property (nonatomic,assign) NSInteger hrInterval;

/**
 心率项数据个数 | Heart rate item data
 */
@property (nonatomic,assign) NSInteger  hrItemCount;

/**
 包的总数 | Total number of packages
 */
@property (nonatomic,assign) NSInteger  packetCount;

/*
 * 类型:0x01:走路, 0x02:跑步， 0x03:骑行 0x04:徒步 这些类型才有轨迹运动
 * Type: 0x01: Walk, 0x02: Running, 0x03: Cycling 0x04: Walking These types have track motion
 */
@property (nonatomic,assign) NSInteger type;

/**
 步数(骑行 时，步数为 0) | Number of steps (when riding, the number of steps is 0)
 */
@property (nonatomic,assign) NSInteger step;

/**
 持续时长 (单位:s) | Duration (unit: s)
 */
@property (nonatomic,assign) NSInteger durations;

/**
 卡路里(单 位:大卡) | Calories (Unit: Big Card)
 */
@property (nonatomic,assign) NSInteger calories;

/**
 距离(单位: 米) | Distance (in meters)
 */
@property (nonatomic,assign) NSInteger distance;

/**
 平均心率 | Average heart rate
 */
@property (nonatomic,assign) NSInteger  avgHrValue;

/**
 最大心率 | Maximum heart rate
 */
@property (nonatomic,assign) NSInteger  maxHrValue;

/**
 脂肪燃烧时长 | Fat burning time
 */
@property (nonatomic,assign) NSInteger burnFatMins;

/**
 心肺锻炼时长 [有氧运动时长] (分钟) | Cardio workout time (minutes)
 */
@property (nonatomic,assign) NSInteger aerobicMins;

/**
 极限锻炼时长 (分钟) | Extreme workout time (minutes)
 */
@property (nonatomic,assign) NSInteger limitMins;

/**
 无氧锻炼时长 (分钟) | Anaerobic workout time (minutes)
 */
@property (nonatomic,assign) NSInteger anaerobicMins;

/**
 热身锻炼时长 (分钟) | Warm up workout time (minutes)
 */
@property (nonatomic,assign) NSInteger warmUpMins;

/**
 有序列号的心率集合 json字符串 | Heart rate collection with serial number json string
 */
@property (nonatomic,copy) NSString  * hrValuesStr;

/**
 是否需要保存数据 (用于数据交换) | Do you need to save data (for data exchange)
 */
@property (nonatomic,assign) BOOL isSave;

/**
 * 运动发起端 (1 : 手环发起 0 : app发起)
 * Sports Initiator (1 : Bracelet Initiation  0 : app initiated)
 */
@property (nonatomic,assign) NSInteger startFrom;

@end

@interface IDOSyncActivityDataModel : NSObject
/**
 * @brief 当前设备根据活动开始时间查询某个活动详情
 * The current device queries an event details based on the event start time
 * @param macAddr  mac地址 | Mac address
 * @param timeStr 活动开始时间 | Event start time
 * @return model IDOSyncActivityDataInfoBluetoothModel
 */
+ (__kindof IDOSyncActivityDataInfoBluetoothModel *)queryOneActivityDataWithTimeStr:(NSString *)timeStr
                                                                            macAddr:(NSString *)macAddr;

/**
 * @brief 当前设备根据日期查询某天的活动集合
 * The current device queries the collection of events for a certain day based on the date
 * @param macAddr  mac地址 | Mac address
 * @param year  年份 | year
 * @param month 月份 | month
 * @param day   日期 | day
 * @return 活动集合 | Activity collection
 */
+ (NSArray <__kindof IDOSyncActivityDataInfoBluetoothModel *>*)queryOneDayActivityDataWithMacAddr:(NSString *)macAddr
                                                                                             year:(NSInteger)year
                                                                                            month:(NSInteger)month
                                                                                              day:(NSInteger)day;


/**
 * @brief 当前设备活动分页查询活动集合 | Current Device Activity Paging Query Activity Collection
 * @param pageIndex 页码 第几页 (如 : 0,1,2,3,4,...) | Page Number of pages (eg : 0,1,2,3,4,...)
 * @param numOfPage 每页的数据个数 (如 : 10,20,30...) | The number of data per page (eg: 10, 20, 30...)
 * @param macAddr  mac地址 | Mac address
 * @return 活动集合
 */
+ (NSArray <__kindof IDOSyncActivityDataInfoBluetoothModel *>*)queryOnePageActivityDataWithPageIndex:(NSInteger)pageIndex
                                                                                           numOfPage:(NSInteger)numOfPage
                                                                                             macAddr:(NSString *)macAddr;

/**
 * @brief 当前设备所有轨迹运动 | Current track motion of all devices
 * @param macAddr mac 地址 | mac address
 * @return 活动集合 | Activity collection
 */
+ (NSArray <__kindof IDOSyncActivityDataInfoBluetoothModel *>*)queryAllTrajectorySportActivitysWithMac:(NSString *)macAddr;

/**
 * @brief 当前设备所有轻运动 | Current equipment all light sports
 * @param macAddr mac 地址 | mac address
 * @return 活动集合 | Activity collection
 */
+ (NSArray <__kindof IDOSyncActivityDataInfoBluetoothModel *>*)queryAllLightSportActivitysWithMac:(NSString *)macAddr;
@end
