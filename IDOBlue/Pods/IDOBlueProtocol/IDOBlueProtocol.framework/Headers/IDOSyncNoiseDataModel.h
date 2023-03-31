//
//  IDOSyncNoiseDataModel.h
//  IDOBlueProtocol
//
//  Created by hedongyang on 2021/7/6.
//  Copyright © 2021 何东阳. All rights reserved.
//

#if __has_include(<IDOBlueProtocol/IDOBlueProtocol.h>)
#else
#import "IDOBluetoothBaseModel.h"
#endif

@interface IDOSyncNoiseBluetoothItemDataModel : IDOBluetoothBaseModel
/**
 子时间偏移量 (单位:秒) | Total time offset (unit: second)
 */
@property (nonatomic,assign) NSInteger offset;
/**
 噪音值
 */
@property (nonatomic,assign) NSInteger value;
/**
 时间戳 精确到日期 date interval since 1970 (如:1444361933) | Timestamp date interval since 1970 (eg: 14443361933)
 */
@property (nonatomic,copy) NSString * dateStr;

@end

@interface IDOSyncNoiseBluetoothDataModel : IDOBluetoothBaseModel
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
 日期时间戳
 */
@property (nonatomic,copy) NSString * dateStr;
/**
 起始时间 单位秒
 */
@property (nonatomic,assign) NSInteger startTime;
/**
 数据的间隔 秒钟、分钟
 */
@property (nonatomic,assign) NSInteger intervalMode;
/**
 平均的噪音
 */
@property (nonatomic,assign) NSInteger avgNoise;
/**
 最大的噪音
 */
@property (nonatomic,assign) NSInteger maxNoise;
/**
 最小的噪音
 */
@property (nonatomic,assign) NSInteger minNoise;
/**
 噪音个数
 */
@property (nonatomic,assign) NSInteger itemCount;
/**
 噪音集合
 */
@property (nonatomic,strong) NSArray <IDOSyncNoiseBluetoothItemDataModel *>* items;

@end

@interface IDOSyncNoiseDataModel : IDOBluetoothBaseModel

/**
 * @brief 查询当前设备某年12个月所有数据 (如果查询当月无数据,会创建空的数据对象,大于当月的数据不累加)
 * Query all data of the current device for 12 months in a certain year (If there is no data in the current month, an empty data object will be created,
 * and the data larger than the current month will not be accumulated)
 * @param year 年 (如 : 2018) | Year (eg: 2018)
 * @param macAddr mac 地址 | mac address
 * @param isQuery 是否查询items | is query items
 * @return 一年12个月的噪音数据集合，其中IDOSyncNoiseBluetoothDataModel对象是一天噪音数据模型
 * A 12-month noise data collection, where the IDOSyncNoiseBluetoothDataModel object is a total day noise data model
 */
+ (NSArray <NSArray<IDOSyncNoiseBluetoothDataModel *>*> *)queryOneYearNoiseWithYear:(NSInteger)year
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
 * @return 一个月的噪音数据集合,其中IDOSyncNoiseBluetoothDataModel对象是一天噪音数据模型
 * One month of noise data collection, where the IDOSyncNoiseBluetoothDataModel object is the total day noise data model
 */
+ (NSArray <IDOSyncNoiseBluetoothDataModel *>*)queryOneMonthNoiseWithYear:(NSInteger)year
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
 * @return 一周的噪音数据集合,其中IDOSyncNoiseBluetoothDataModel对象是一天噪音数据模型
 * A week of noise data collection, where the IDOSyncNoiseBluetoothDataModel object is the total day noise data model
 */
+ (NSArray <IDOSyncNoiseBluetoothDataModel *>*)queryOneWeekNoiseWithWeekIndex:(NSInteger)weekIndex
                                                               weekStartDay:(NSInteger)weekStartDay
                                                                    macAddr:(NSString *)macAddr
                                                                datesOfWeek:(NSArray <NSString *>**)dates
                                                               isQueryItems:(BOOL)isQuery;


/**
 * @brief 查询当前设备某天噪音数据并有详情数据 | Query the current device's noise data and have detailed data
 * @param macAddr mac 地址 | mac address
 * @param year  年份 | year
 * @param month 月份 | month
 * @param day   日期 | day
 * @return 一天噪音数据的集合和详情数据集合 | Collection of daily noise data and detailed data
 */
+ (NSArray <IDOSyncNoiseBluetoothDataModel *>*)queryOneDayNoiseDetailWithMac:(NSString *)macAddr
                                                                        year:(NSInteger)year
                                                                       month:(NSInteger)month
                                                                         day:(NSInteger)day;

/**
 * @brief 查询所有噪音数据 平均的噪音大于0 | Query all noise data The average noise is greater than 0
 * @param macAddr mac 地址 | mac address
 * @return 所有噪音数据的集合 | Collection of all the noise data
 */
+ (NSArray <IDOSyncNoiseBluetoothDataModel *>*)queryAllNoiseWithMac:(NSString *)macAddr;

/**
 * 将json数据转模型数据 | Convert json data to model data
 * @param jsonString  数据
 */
+(IDOSyncNoiseBluetoothDataModel*)noiseDataJsonStringToObjectModel:(NSString*)jsonString;

@end

