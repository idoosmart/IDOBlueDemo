//
//  IDOSyncBreathRateDataModel.h
//  IDOBlueProtocol
//
//  Created by hedongyang on 2022/4/26.
//  Copyright © 2022 何东阳. All rights reserved.
//

#import <IDOBlueProtocol/IDOBlueProtocol.h>

@interface IDOSyncBreathRateDataModel : IDOBluetoothBaseModel
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
@property (nonatomic,copy)   NSString * dateStr;

/**
 详情的个数
 */
@property (nonatomic,assign) NSInteger itemCount;

/**
 * 呼吸率集合 @[{@"offset":@(0),@"value":@(0)}...]
 * value：呼吸率
 * offset ：每一个都基于0点偏移量 (秒钟)
 */
@property (nonatomic,copy) NSArray <NSDictionary *>* breathRates;

/**
 * @brief 查询当前设备某年12个月所有数据 (如果查询当月无数据,会创建空的数据对象,大于当月的数据不累加)
 * Query all data of the current device for 12 months in a certain year (If there is no data in the current month, an empty data object will be created,
 * and the data larger than the current month will not be accumulated)
 * @param year 年 (如 : 2018) | Year (eg: 2018)
 * @param macAddr mac 地址 | mac address
 * @return 一年12个月的呼吸率数据集合，其中IDOSyncBreathRateDataModel对象是一天呼吸率数据模型
 * A 12-month breath rate data collection, where the IDOSyncBreathRateDataModel object is a total day breath rate data model
 */
+ (NSArray <NSArray<IDOSyncBreathRateDataModel *>*> *)queryOneYearBreathRateWithYear:(NSInteger)year
                                                                             macAddr:(NSString *)macAddr;

/**
 * @brief 查询当前设备某月份的所有数据 (如果查询当天无数据,会创建空的数据对象,大于当天的数据不累加)
 * Query all data of the current device for a certain month (If there is no data on the query day, an empty data object will be created,
 * which is larger than the data of the day)
 * @param year 年 (如 : 2018) | Year (eg: 2018)
 * @param month 月 (如 : 9) | Month (eg: 9)
 * @param macAddr mac 地址 | mac address
 * @param dates 当前查询月份的所有日期集合的指针 (格式 ：[10/01...10/31])
 * Pointer to all date collections for the current query month (format: [10/01...10/31])
 * @return 一个月的呼吸率数据集合,其中IDOSyncBreathRateDataModel对象是一天呼吸率数据模型
 * One month of breath rate data collection, where the IDOSyncBreathRateDataModel object is the total day breath rate data model
 */
+ (NSArray <IDOSyncBreathRateDataModel *>*)queryOneMonthBreathRateWithYear:(NSInteger)year
                                                                  month:(NSInteger)month
                                                                macAddr:(NSString *)macAddr
                                                           datesOfMonth:(NSArray <NSString *>**)dates;

/**
 * @brief 查询当前设备某周的所有数据 (如果查询当天无数据,会创建空的数据对象,大于当天的数据不累加)
 * Query all data of the current device for a certain week (If there is no data on the day of the query, an empty data object will be created,
 * and the data larger than the current day will not be accumulated)
 * @param weekIndex 周的查询索引 (0 : 当周, 1 : 上一周, 2 : 上两周 ...) | Week's query index (0: week, 1 : last week, 2 : last two weeks...)
 * @param weekStartDay 星期的开始日 (0 : 星期日, 1 : 星期一, 2 : 星期二 ...) | Start of the week (0: Sunday, 1 : Monday, 2 : Tuesday ...)
 * @param macAddr mac 地址 | mac address
 * @param dates 当前查询周的所有日期集合的指针 (格式 ：[10/01...10/07])
 * Pointer to all date collections for the current query week (format: [10/01...10/07])
 * @return 一周的呼吸率数据集合,其中IDOSyncBreathRateDataModel对象是一天呼吸率数据模型
 * A week of breath rate data collection, where the IDOSyncBreathRateDataModel object is the total day breath rate data model
 */
+ (NSArray <IDOSyncBreathRateDataModel *>*)queryOneWeekBreathRateWithWeekIndex:(NSInteger)weekIndex
                                                               weekStartDay:(NSInteger)weekStartDay
                                                                    macAddr:(NSString *)macAddr
                                                                datesOfWeek:(NSArray <NSString *>**)dates;


/**
 * @brief 查询当前设备某天呼吸率数据并有详情数据 | Query the current device's breath rate data and have detailed data
 * @param macAddr mac 地址 | mac address
 * @param year  年份 | year
 * @param month 月份 | month
 * @param day   日期 | day
 * @return 一天呼吸率数据的集合和详情数据集合 | Collection of daily breath rate data and detailed data
 */
+ (NSArray <IDOSyncBreathRateDataModel *>*)queryOneDayBreathRateDetailWithMac:(NSString *)macAddr
                                                                      year:(NSInteger)year
                                                                     month:(NSInteger)month
                                                                       day:(NSInteger)day;

/**
 * @brief 查询所有呼吸率数据 平均的呼吸率大于0 | Query all breath rate data The average breath rate is greater than 0
 * @param macAddr mac 地址 | mac address
 * @return 所有呼吸率数据的集合 | Collection of all the breath rate data
 */
+ (NSArray <IDOSyncBreathRateDataModel *>*)queryAllBreathRateWithMac:(NSString *)macAddr;

@end

