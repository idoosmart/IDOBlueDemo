//
//  IDOSyncHeartRateDataModel.h
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

@interface IDOSyncHrDataItemInfoBluetoothModel : IDOBluetoothBaseModel

/**
 子时间偏移量 (单位:分钟) | Total time offset (unit: minute)
 */
@property (nonatomic,assign) NSInteger offset;

/**
 心率值 | Heart rate value
 */
@property (nonatomic,assign) NSInteger data;

/**
 时间戳 精确到日期 date interval since 1970 (如:1444361933) | Timestamp date interval since 1970 (eg: 14443361933)
 */
@property (nonatomic,copy) NSString * dateStr;

/**
 序列号 | Serial number
 */
@property (nonatomic,assign) NSInteger  serialNumber;

@end

@interface IDOSyncHrDataInfoBluetoothModel : IDOBluetoothBaseModel

/**
 心率数据包数量 | Heart Rate Packets
 */
@property (nonatomic,assign) NSInteger  itemsCount;

/**
 总时间偏移量 (单位:分钟) | Total time offset (unit: minute)
 */
@property (nonatomic,assign) NSUInteger minuteOffset;

/**
 静态心率 | Static heart rate
 */
@property (nonatomic,assign) NSUInteger silentHeartRate;

/**
 燃烧脂肪阀值 | Burning fat threshold
 */
@property (nonatomic,assign) NSUInteger burnFatThreshold;

/**
 肌肉锻炼阀值 | Muscle exercise threshold
 */
@property (nonatomic,assign) NSUInteger aerobicThreshold;

/**
 极限阀值 | Limit threshold
 */
@property (nonatomic,assign) NSUInteger limitThreshold;

/**
 脂肪燃烧时长 (单位 ：分钟) | Fat burning time (unit: minute)
 */
@property (nonatomic,assign) NSUInteger burnFatMins;

/**
 肌肉锻炼时长 (单位 ：分钟) | Muscle training time (unit: minute)
 */
@property (nonatomic,assign) NSUInteger aerobicMins;

/**
 极限运动时长 (单位 ：分钟) | Extreme Sports Duration (Unit: Minutes)
 */
@property (nonatomic,assign) NSUInteger limitMins;

/**
 用户最大心率 | User maximum heart rate
 */
@property (nonatomic,assign) NSUInteger userMaxHr;

/**
 热身运动阈值 | warm up threshold
 */
@property (nonatomic,assign) NSUInteger warmUpThreshold;

/**
 热身运动时间 (单位 ：分钟) | warm up mins
 */
@property (nonatomic,assign) NSUInteger warmUpMins;

/**
 无氧运动阈值 | anaerobic threshold
 */
@property (nonatomic,assign) NSUInteger anaerobicThreshold;

/**
 无氧运动时间 (单位 ：分钟) | anaerobic mins
 */
@property (nonatomic,assign) NSUInteger anaerobicMins;

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
 * 心率集合 只有定义好的查询方法才能转成model集合，自定义的查询方法无法直接转成model集合，需要再查询itemModel赋给当前属性
 * Heart rate collection Only defined query methods can be converted into model collections. Custom query methods cannot be directly
 * converted into model collections. You need to query itemModel to assign current attributes.
 */
@property (nonatomic,copy) NSArray <IDOSyncHrDataItemInfoBluetoothModel *>* heartRates;

/**
 时间戳 精确到日期 date interval since 1970 (如:1444361933) | Timestamp date interval since 1970 (eg: 14443361933)
 */
@property (nonatomic,copy) NSString * dateStr;

@end

@interface IDOSyncSecHrDataItemInfoBluetoothModel : IDOBluetoothBaseModel
/**
 子时间偏移量 (单位:秒钟) | Total time offset (unit: second)
 */
@property (nonatomic,assign) NSInteger offset;

/**
 心率值 | Heart rate value
 */
@property (nonatomic,assign) NSInteger hrValue;

/**
 时间戳 精确到日期 date interval since 1970 (如:1444361933) | Timestamp date interval since 1970 (eg: 14443361933)
 */
@property (nonatomic,copy) NSString * dateStr;

/**
 序列号 | Serial number
 */
@property (nonatomic,assign) NSInteger  serialNumber;

@end

@interface IDOSyncSecHrDataInfoBluetoothModel : IDOBluetoothBaseModel
/**
 心率数据包数量 | Heart Rate Packets
 */
@property (nonatomic,assign) NSInteger  itemsCount;

/**
 总时间偏移量 (单位:秒钟) | Total time offset (unit: second)
 */
@property (nonatomic,assign) NSUInteger secondOffset;

/**
 静态心率 | Static heart rate
 */
@property (nonatomic,assign) NSUInteger silentHeartRate;

/**
 燃烧脂肪阀值 | Burning fat threshold
 */
@property (nonatomic,assign) NSUInteger burnFatThreshold;

/**
 肌肉锻炼阀值 | Muscle exercise threshold
 */
@property (nonatomic,assign) NSUInteger aerobicThreshold;

/**
 极限阀值 | Limit threshold
 */
@property (nonatomic,assign) NSUInteger limitThreshold;

/**
 脂肪燃烧时长 (单位 ：分钟) | Fat burning time (unit: minute)
 */
@property (nonatomic,assign) NSUInteger burnFatMins;

/**
 肌肉锻炼时长 (单位 ：分钟) | Muscle training time (unit: minute)
 */
@property (nonatomic,assign) NSUInteger aerobicMins;

/**
 极限运动时长 (单位 ：分钟) | Extreme Sports Duration (Unit: Minutes)
 */
@property (nonatomic,assign) NSUInteger limitMins;

/**
 用户最大心率 | User maximum heart rate
 */
@property (nonatomic,assign) NSUInteger userMaxHr;

/**
 热身运动阈值 | warm up threshold
 */
@property (nonatomic,assign) NSUInteger warmUpThreshold;

/**
 热身运动时间 (单位 ：分钟) | warm up mins
 */
@property (nonatomic,assign) NSUInteger warmUpMins;

/**
 无氧运动阈值 | anaerobic threshold
 */
@property (nonatomic,assign) NSUInteger anaerobicThreshold;

/**
 无氧运动阈值 (单位 ：分钟) | anaerobic mins
 */
@property (nonatomic,assign) NSUInteger anaerobicMins;

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
 * 心率集合 只有定义好的查询方法才能转成model集合，自定义的查询方法无法直接转成model集合，需要再查询itemModel赋给当前属性
 * Heart rate collection Only defined query methods can be converted into model collections. Custom query methods cannot be directly
 * converted into model collections. You need to query itemModel to assign current attributes.
 */
@property (nonatomic,copy) NSArray <IDOSyncSecHrDataItemInfoBluetoothModel *>* heartRates;

/**
 * 5分钟间隔心率集合和总心率时长 | Heart rate set at 5-minute intervals and total heart rate duration
 *  @{@"total_offset":@(0),@"heart_rates":@[@{@"offset":@(0),@"value":@(0)}...]};
 */
@property (nonatomic,copy) NSDictionary * minutesHrDic;

/**
 时间戳 精确到日期 date interval since 1970 (如:1444361933) | Timestamp date interval since 1970 (eg: 14443361933)
 */
@property (nonatomic,copy) NSString * dateStr;

@end


@interface IDOSyncHeartRateDataModel : NSObject

#pragma mark ======================== offset minunte ===============================
/**
 * @brief 查询当前设备某年12个月所有数据 (如果查询当月无数据,会创建空的数据对象,大于当月的数据不累加)
 * Query all data of the current device for 12 months in a certain year (If there is no data in the query month, an empty data object will be created,
 * and the data larger than the current month will not be accumulated)
 * @param year 年 (如 : 2018) | Year (eg: 2018)
 * @param macAddr mac 地址 | mac address
 * @param isQuery 是否查询items | is query items
 * @return 一年12个月的心率数据集合,其中IDOSyncHrDataInfoBluetoothModel对象是一天总心率数据模型
 * Heart rate data collection for 12 months a year, where the IDOSyncHrDataInfoBluetoothModel object is the total heart rate data model for the day
 */
+ (NSArray <NSArray<__kindof IDOSyncHrDataInfoBluetoothModel *>*> *)queryOneYearHearRatesWithYear:(NSInteger)year
                                                                                          macAddr:(NSString *)macAddr
                                                                                     isQueryItems:(BOOL)isQuery;

/**
 * @brief 查询当前设备某月份的所有数据 (如果查询当天无数据,会创建空的数据对象,大于当天的数据不累加)
 * Query all data of the current device for a certain month (If there is no data on the query day, an empty data object will be created,
 * which is larger than the data of the day)
 * @param year 年 (如 : 2018) | Year (eg: 2018)
 * @param month 月 (如 : 9) | Month (eg: 9)
 * @param macAddr mac 地址 | mac address
 * @param dates 当前查询月份的所有日期集合的指针 (格式 ：[10/01...10/31])
 * Pointer to all date collections for the current query month (format: [10/01...10/31])
 * @param isQuery 是否查询items | is query items
 * @return 一个月的心率数据集合,其中IDOSyncHrDataInfoBluetoothModel对象是一天总心率数据模型
 * A one-month heart rate data collection, where the IDOSyncHrDataInfoBluetoothModel object is the total heart rate data model for the day
 */
+ (NSArray <__kindof IDOSyncHrDataInfoBluetoothModel *>*)queryOneMonthHearRatesWithYear:(NSInteger)year
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
 * @param dates 当前查询周的所有日期集合的指针 (格式 ：[10/01...10/07])
 * Pointer to all date collections for the current query week (format: [10/01...10/07])
 * @param isQuery 是否查询items | is query items
 * @return 一周的心率数据集合,其中IDOSyncHrDataInfoBluetoothModel对象是一天总心率数据模型
 * A week's heart rate data collection, where the IDOSyncHrDataInfoBluetoothModel object is the total heart rate data model for the day
 */
+ (NSArray <__kindof IDOSyncHrDataInfoBluetoothModel *>*)queryOneWeekHearRatesWithWeekIndex:(NSInteger)weekIndex
                                                                               weekStartDay:(NSInteger)weekStartDay
                                                                                    macAddr:(NSString *)macAddr
                                                                                datesOfWeek:(NSArray <NSString *>**)dates
                                                                               isQueryItems:(BOOL)isQuery;

/**
 * @brief 查询当前设备某天心率数据并有详情数据 | Query current heart rate data of the current device and have detailed data
 * @param macAddr mac 地址 | mac address
 * @param year  年份  | year
 * @param month 月份  | month
 * @param day   日期  | day
 * @return 一天心率数据的集合和详情数据集合 | Collection of day heart rate data and details data
 */
+ (NSArray<__kindof IDOSyncHrDataInfoBluetoothModel *> *)queryOneDayHearRatesDetailWithMac:(NSString *)macAddr
                                                                                       year:(NSInteger)year
                                                                                      month:(NSInteger)month
                                                                                        day:(NSInteger)day;

/**
 * @brief 查询所有心率数据 心率包个数大于0 | Query all heart rate data The number of heart rate packets is greater than 0
 * @param macAddr mac 地址 | mac address
 * @return 所有心率数据的集合 | Collection of all heart rate data and details data
 */
+ (NSArray <__kindof IDOSyncHrDataInfoBluetoothModel *>*)queryAllHearRatesWithMac:(NSString *)macAddr;


/**
 * @brief 查询所有心率数据 心率包个数大于0 只包含静心心率和日期时间戳
 * Query all heart rate data The number of heart rate packets is greater than 0
 * Contains only meditation heart rate and date and time stamp
 * @param macAddr mac 地址 | mac address
 * @return 所有心率数据的集合 | Collection of all heart rate data
 */
+ (NSArray <__kindof IDOSyncHrDataInfoBluetoothModel *>*)queryAllContractedHearRatesWithMac:(NSString *)macAddr;

#pragma mark ======================== offset second ===============================

/**
 * @brief 查询当前设备某年12个月所有数据 (如果查询当月无数据,会创建空的数据对象,大于当月的数据不累加)
 * Query all data of the current device for 12 months in a certain year (If there is no data in the query month, an empty data object will be created,
 * and the data larger than the current month will not be accumulated)
 * @param year 年 (如 : 2018) | Year (eg: 2018)
 * @param macAddr mac 地址 | mac address
 * @param isQuery 是否查询items | is query items
 * @return 一年12个月的秒钟心率数据集合,其中IDOSyncSecHrDataInfoBluetoothModel对象是一天总心率数据模型
 * second heart rate data collection for 12 months a year, where the IDOSyncSecHrDataInfoBluetoothModel object is the total heart rate data model for the day
 */
+ (NSArray <NSArray<__kindof IDOSyncSecHrDataInfoBluetoothModel *>*> *)queryOneYearSecHearRatesWithYear:(NSInteger)year
                                                                                                macAddr:(NSString *)macAddr
                                                                                           isQueryItems:(BOOL)isQuery;

/**
 * @brief 查询当前设备某月份的所有数据 (如果查询当天无数据,会创建空的数据对象,大于当天的数据不累加)
 * Query all data of the current device for a certain month (If there is no data on the query day, an empty data object will be created,
 * which is larger than the data of the day)
 * @param year 年 (如 : 2018) | Year (eg: 2018)
 * @param month 月 (如 : 9) | Month (eg: 9)
 * @param macAddr mac 地址 | mac address
 * @param dates 当前查询月份的所有日期集合的指针 (格式 ：[10/01...10/31])
 * Pointer to all date collections for the current query month (format: [10/01...10/31])
 * @param isQuery 是否查询items | is query items
 * @return 一个月的秒钟心率数据集合,其中IDOSyncSecHrDataInfoBluetoothModel对象是一天总心率数据模型
 * one-month second heart rate data collection, where the IDOSyncSecHrDataInfoBluetoothModel object is the total heart rate data model for the day
 */
+ (NSArray <__kindof IDOSyncSecHrDataInfoBluetoothModel *>*)queryOneMonthSecHearRatesWithYear:(NSInteger)year
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
 * @param dates 当前查询周的所有日期集合的指针 (格式 ：[10/01...10/07])
 * Pointer to all date collections for the current query week (format: [10/01...10/07])
 * @param isQuery 是否查询items | is query items
 * @return 一周的秒钟心率数据集合,其中IDOSyncSecHrDataInfoBluetoothModel对象是一天总心率数据模型
 * one week second heart rate data collection, where the IDOSyncSecHrDataInfoBluetoothModel object is the total heart rate data model for the day
 */
+ (NSArray <__kindof IDOSyncSecHrDataInfoBluetoothModel *>*)queryOneWeekSecHearRatesWithWeekIndex:(NSInteger)weekIndex
                                                                                     weekStartDay:(NSInteger)weekStartDay
                                                                                          macAddr:(NSString *)macAddr
                                                                                      datesOfWeek:(NSArray <NSString *>**)dates
                                                                                     isQueryItems:(BOOL)isQuery;

/**
 * @brief 查询当前设备某天秒钟心率数据并有详情数据 | Query current day second heart rate data of the current device and have detailed data
 * @param macAddr mac 地址 | mac address
 * @param year  年份  | year
 * @param month 月份  | month
 * @param day   日期  | day
 * @param isQuery 是否查询items | is query items
 * @return 一天秒钟心率数据的集合和详情数据集合 | Collection of day second heart rate data and details data
 */
+ (NSArray<__kindof IDOSyncSecHrDataInfoBluetoothModel *> *)queryOneDaySecHearRatesDetailWithMac:(NSString *)macAddr
                                                                                    year:(NSInteger)year
                                                                                   month:(NSInteger)month
                                                                                     day:(NSInteger)day
                                                                            isQueryItems:(BOOL)isQuery;

/**
 * @brief 查询所有秒钟心率数据 心率包个数大于0 | Query all second heart rate data The number of heart rate packets is greater than 0
 * @param macAddr mac 地址 | mac address
 * @return 所有秒钟心率数据的集合 | Collection of all second heart rate data and details data
 */
+ (NSArray <__kindof IDOSyncSecHrDataInfoBluetoothModel *>*)queryAllSecHearRatesWithMac:(NSString *)macAddr;

/**
 * @brief 查询所有秒钟心率数据 心率包个数大于0 只包含静心心率和日期时间戳
 * Query all second heart rate data The number of heart rate packets is greater than 0
 * Contains only meditation heart rate and date and time stamp
 * @param macAddr mac 地址 | mac address
 * @return 所有心率数据的集合 | Collection of all heart rate data
 */
+ (NSArray <__kindof IDOSyncSecHrDataInfoBluetoothModel *>*)queryAllContractedSecHearRatesWithMac:(NSString *)macAddr;

@end

