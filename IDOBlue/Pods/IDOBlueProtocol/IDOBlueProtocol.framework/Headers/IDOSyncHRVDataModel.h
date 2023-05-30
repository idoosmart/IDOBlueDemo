//
//  IDOSyncHRVDataModel.h
//  IDOBlueProtocol
//
//  Created by huangkunhe on 2023/3/28.
//  Copyright © 2023 何东阳. All rights reserved.
//

#if __has_include(<IDOBlueProtocol/IDOBlueProtocol.h>)
#else
#import "IDOBluetoothBaseModel.h"
#endif

NS_ASSUME_NONNULL_BEGIN
@interface IDOSyncHRVDataItemModel : IDOBluetoothBaseModel
/**
 偏移量
 */
@property (nonatomic,assign) NSInteger minuteOffset;
/**
 数值
 */
@property (nonatomic,assign) NSInteger hrvVal;

@end

@interface IDOSyncHRVDataModel : IDOBluetoothBaseModel
/**
 年份
 */
@property (nonatomic,assign) NSInteger year;
/**
 月份
 */
@property (nonatomic,assign) NSInteger month;
/**
 日期
 */
@property (nonatomic,assign) NSInteger day;
/**
 起始时间 单位秒，基于0点的偏移
 */
@property (nonatomic,assign) NSInteger startTime;
/**
 数据量
 */
@property (nonatomic,copy) NSString * dataSize;
/**
 日期时间戳
 */
@property (nonatomic,copy) NSString * dateStr;
/**
 个数
 */
@property (nonatomic,assign) NSInteger itemsCount;

/**
 IDOSyncHRVDataItemModel items
 */
@property (nonatomic,strong) NSArray <IDOSyncHRVDataItemModel *>* items;

/**
 * @brief 查询当前设备某年12个月所有数据 (如果查询当月无数据,会创建空的数据对象,大于当月的数据不累加)
 * Query all data of the current device for 12 months in a certain year (If there is no data in the current month, an empty data object will be created,
 * and the data larger than the current month will not be accumulated)
 * @param year 年 (如 : 2018) | Year (eg: 2018)
 * @param macAddr mac 地址 | mac address
 * @return 一年12个月的hrv数据集合，其中IDOSyncHRVDataModel对象是一天hrv数据模型
 * A 12-month body power data collection, where the IDOSyncHRVDataModel object is a total day hrv data model
 */
+ (NSArray <NSArray<IDOSyncHRVDataModel *>*> *)queryOneYearHrvWithYear:(NSInteger)year
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
 * @return 一个月的hrv数据集合,其中IDOSyncHRVDataModel对象是一天hrv数据模型
 * One month of hrvr data collection, where the IDOSyncHRVDataModel object is the total day hrv data model
 */
+ (NSArray <IDOSyncHRVDataModel *>*)queryOneMonthHrvWithYear:(NSInteger)year
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
 * @return 一周的身体电量数据集合,其中IDOSyncHRVDataModel对象是一天身体电量数据模型
 * A week of hrv data collection, where the IDOSyncHRVDataModel object is the total day hrv data model
 */
+ (NSArray <IDOSyncHRVDataModel *>*)queryOneWeekHrvWithWeekIndex:(NSInteger)weekIndex
                                                               weekStartDay:(NSInteger)weekStartDay
                                                                    macAddr:(NSString *)macAddr
                                                                datesOfWeek:(NSArray <NSString *>**)dates;


/**
 * @brief 查询当前设备某天hrv数据并有详情数据 | Query the current device's hrv data and have detailed data
 * @param macAddr mac 地址 | mac address
 * @param year  年份 | year
 * @param month 月份 | month
 * @param day   日期 | day
 * @return 一天hrv数据的集合和详情数据集合 | Collection of daily hrv data and detailed data
 */
+ (NSArray <IDOSyncHRVDataModel *>*)queryOneDayHrvDetailWithMac:(NSString *)macAddr
                                                                      year:(NSInteger)year
                                                                     month:(NSInteger)month
                                                                       day:(NSInteger)day;


/**
 * 将json数据转模型数据 | Convert json data to model data
 * @param jsonString  数据
 */
+(IDOSyncHRVDataModel*)hrvDataJsonStringToObjectModel:(NSString*)jsonString;

@end

NS_ASSUME_NONNULL_END

