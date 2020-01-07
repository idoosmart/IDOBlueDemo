//
//  IDOSyncSleepDataModel.h
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

@interface IDOSyncSleepDataItemInfoBluetoothModel : IDOBluetoothBaseModel

/**
 * 睡眠状态 睡眠状态(0x01: 醒着， 0x02:浅睡， 0x03:深睡)
 * Sleep state Sleep state (0x01: awake, 0x02: light sleep, 0x03: deep sleep)
 */
@property (nonatomic,assign) NSInteger  sleepStatus;

/**
 持续时间 | Duration
 */
@property (nonatomic,assign) NSInteger  durations;

/**
 时间戳 精确到日期 date interval since 1970 (如:1444361933) | Timestamp date interval since 1970 (eg: 14443361933)
 */
@property (nonatomic,copy) NSString * dateStr;

/**
 时间戳 精确到分钟 start time interval since 1970 (如:1444361933) | Timestamp minute interval since 1970 (eg: 14443361933)
 */
@property (nonatomic,copy) NSString * startTimeStr;

/**
 序列号 | Serial number
 */
@property (nonatomic,assign) NSInteger serialNumber;

@end

@interface IDOSyncSleepDataInfoBluetoothModel : IDOBluetoothBaseModel

/**
 睡眠数据包数量 | Number of sleep packets
 */
@property (nonatomic,assign) NSInteger itemsCount;

/**
 睡眠结束时钟 | End of sleep clock
 */
@property (nonatomic,assign) NSInteger endHour;

/**
 睡眠结束分钟 | End of sleep minutes
 */
@property (nonatomic,assign) NSInteger endMinute;

/**
 总睡眠时长 (单位 ：分钟) | Total sleep duration (unit: minute)
 */
@property (nonatomic,assign) NSInteger totalMinute;

/**
 浅睡眠次数 | Light sleep times
 */
@property (nonatomic,assign) NSInteger lightSleepCount;

/**
 深睡眠次数 | Deep sleep times
 */
@property (nonatomic,assign) NSInteger deepSleepCount;

/**
 醒来次数 | Wake up times
 */
@property (nonatomic,assign) NSInteger wakeCount;

/**
 醒来时长 | Wake up Duration
 */
@property (nonatomic,assign) NSInteger wakeMinute;

/**
 浅睡眠时长 | Light sleep duration
 */
@property (nonatomic,assign) NSInteger lightSleepMinute;

/**
 深睡眠时长 | Deep sleep duration
 */
@property (nonatomic,assign) NSInteger deepSleepMinute;

/**
 目标睡眠时长 (单位 : 分钟) | Target sleep duration (unit: minute)
 */
@property (nonatomic,assign) NSInteger goalSleepData;

/**
 * 睡眠数据集合 只有定义好的查询方法才能转成model集合，自定义的查询方法无法直接转成model集合，需要再查询itemModel赋给当前属性
 * Sleep data collection Only defined query methods can be converted into model collections. Custom query methods cannot be directly converted
 * into model collections. You need to query itemModel to assign current attributes.
 */
@property (nonatomic,copy) NSArray <IDOSyncSleepDataItemInfoBluetoothModel *> * sleepItems;

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
 时间戳 精确到日期 date interval since 1970 (如:1444361933) | Timestamp date interval since 1970 (eg: 14443361933)
 */
@property (nonatomic,copy) NSString * dateStr;

/**
 时间戳 精确到分钟 start time interval since 1970 (如:1444361933) | Timestamp minute interval since 1970 (eg: 14443361933)
 */
@property (nonatomic,copy) NSString * startTimeStr;

/**
 睡眠评分 | sleep score (1-100)
 */
@property (nonatomic,assign) NSInteger sleepScore;

@end

@interface IDOSyncSleepDataModel : NSObject
/**
 * @brief 查询当前设备某年12个月所有数据 (如果查询当月无数据,会创建空的数据对象,大于当月的数据不累加)
 * Query all data of the current device for 12 months in a certain year (If there is no data in the current month, an empty data object will be created,
 * and the data larger than the current month will not be accumulated)
 * @param year 年 (如 : 2018) | Year (eg: 2018)
 * @param macAddr mac 地址 | mac address
 * @param isQuery 是否查询items | is query items
 * @return 一年12个月的睡眠数据集合,其中IDOSyncSleepDataInfoBluetoothModel对象是一天总睡眠数据模型
 * 12 months of sleep data collection, IDOSyncSleepDataInfoBluetoothModel object is the total day sleep data model
 */
+ (NSArray <NSArray <__kindof IDOSyncSleepDataInfoBluetoothModel *>*>*)queryOneYearSleepsWithYear:(NSInteger)year
                                                                                          macAddr:(NSString *)macAddr
                                                                                     isQueryItems:(BOOL)isQuery;

/**
 * @brief 查询当前设备某月份的所有数据 (如果查询当天无数据,会创建空的数据对象,大于当天的数据不累加)
 * Query all data of the current device for a certain month (If there is no data on the query day, an empty data object will be created,
 * which is larger than the data of the day)
 * @param year 年 (如 : 2018) | year year (eg 2018)
 * @param month 月 (如 : 9) | Month (eg: 9)
 * @param macAddr mac 地址 | mac address
 * @param dates 当前查询月份的所有日期集合的指针 (格式 ：[10/01...10/31])
 * Pointer to all date collections for the current query month (format: [10/01...10/31])
 * @param isQuery 是否查询items | is query items
 * @return 一个月的睡眠数据集合,其中IDOSyncSleepDataInfoBluetoothModel对象是一天总睡眠数据模型
 * A one-month sleep data collection, where the IDOSyncSleepDataInfoBluetoothModel object is the total day sleep data model
 */
+ (NSArray <__kindof IDOSyncSleepDataInfoBluetoothModel *>*)queryOneMonthSleepsWithYear:(NSInteger)year
                                                                                  month:(NSInteger)month
                                                                                macAddr:(NSString *)macAddr
                                                                           datesOfMonth:(NSArray <NSString *>**)dates
                                                                           isQueryItems:(BOOL)isQuery;

/**
 * @brief 查询当前设备某周的所有数据 (如果查询当天无数据,会创建空的数据对象,大于当天的数据不累加)
 * Query all data of the current device for a certain week (If there is no data on the day of the query, an empty data object will be created,
 * and the data larger than the current day will not be accumulated)
 * @param weekIndex 周的查询索引 (0 : 当周, 1 : 上一周, 2 : 上两周 ...) | Week's query index (0: week, 1 : last week, 2 : last two weeks...)
 * @param weekStartDay 星期的开始日 (0 : 星期日, 1 : 星期一, 2 : 星期二 ...) | Start of the week (0: Sunday, 1 : Monday, 2 : Tuesday ...)
 * @param macAddr mac 地址 | mac address
 * @param dates 当前查询周的所有日期集合的指针 (格式 ：[10/01...10/07]) | Pointer to all date collections for the current query week (format: [10/01...10/07])
 * @param isQuery 是否查询items | is query items
 * @return 一周的睡眠数据集合,其中IDOSyncSleepDataInfoBluetoothModel对象是一天总睡眠数据模型
 * A week's sleep data collection, where the IDOSyncSleepDataInfoBluetoothModel object is the total day sleep data model
 */
+ (NSArray <__kindof IDOSyncSleepDataInfoBluetoothModel *>*)queryOneWeekSleepsWithWeekIndex:(NSInteger)weekIndex
                                                                               weekStartDay:(NSInteger)weekStartDay
                                                                                    macAddr:(NSString *)macAddr
                                                                                datesOfWeek:(NSArray <NSString *>**)dates
                                                                               isQueryItems:(BOOL)isQuery;

/**
 * @brief 查询当前设备某天睡眠数据并有详情数据 | Query the current device's sleep data and have detailed data
 * @param macAddr mac 地址 | mac address
 * @param year  年份 | year
 * @param month 月份 |  month
 * @param day   日期 |  day
 * @return 一天睡眠数据的集合和详情数据集合 | Collection of daily sleep data and detailed data
 */
+ (NSArray <__kindof IDOSyncSleepDataInfoBluetoothModel *>*)queryOneDaySleepsDetailWithMac:(NSString *)macAddr
                                                                                       year:(NSInteger)year
                                                                                      month:(NSInteger)month
                                                                                        day:(NSInteger)day;

/**
 * @brief 查询所有睡眠数据 睡眠时长大于0 | Query all sleep data Sleep duration is greater than 0
 * @param macAddr mac 地址 | mac address
 * @return 所有睡眠数据的集合 | Collection and details of all sleep data
 */
+ (NSArray <__kindof IDOSyncSleepDataInfoBluetoothModel *>*)queryAllSleepsWithMac:(NSString *)macAddr;


/**
 * @brief 查询所有睡眠数据 睡眠时长大于0 只包含睡眠总时长和日期时间戳
 * Query all sleep data Sleep duration is greater than 0 Just the total amount of sleep and the date and timestamp
 * @param macAddr mac 地址 | mac address
 * @return 所有睡眠数据的集合 | Collection of all sleep data
 */
+ (NSArray <__kindof IDOSyncSleepDataInfoBluetoothModel *>*)queryAllContractedSleepsWithMac:(NSString *)macAddr;

@end

