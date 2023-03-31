//
//  IDOSyncV3BpDataModel.h
//  IDOBlueProtocol
//
//  Created by hedongyang on 2022/1/6.
//  Copyright © 2022 何东阳. All rights reserved.
//

#import <IDOBlueProtocol/IDOBlueProtocol.h>

@interface IDOSyncV3BpDataModel : IDOBluetoothBaseModel
/**
 血压数据包量 | Blood pressure data package
 */
@property (nonatomic,assign) NSInteger itemsCount;

/**
 睡眠平均血压 | Average blood pressure in sleep
 */
@property (nonatomic,assign) NSInteger sleepAvgBp;

/**
 最大血压值 | Maximum blood pressure value
 */
@property (nonatomic,assign) NSInteger maxBp;

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
 * 血压集合 @[{@"sys_blood":@(0),@"dias_blood":@(0),@"offset":@(0)}...]
 * sys_blood ：收缩压
 * dias_blood ：舒张压
 * offset ：偏移量 (分钟)
 */
@property (nonatomic,copy) NSArray <NSDictionary *>* bloodbPressures;

/**
 时间戳 精确到日期 date interval since 1970 (如:1444361933) | Timestamp date interval since 1970 (eg: 14443361933)
 */
@property (nonatomic,copy)   NSString * dateStr;

/**
 总时间偏移量 (分钟) | Total time offset (minutes)
 */
@property (nonatomic,assign) NSUInteger minuteOffset;

/**
 * @brief 查询当前设备某年12个月所有数据 (如果查询当月无数据,会创建空的数据对象,大于当月的数据不累加)
 * Query all data of the current device for 12 months in a certain year (If there is no data in the current month, an empty data object will be created,
 * and the data larger than the current month will not be accumulated)
 * @param year 年 (如 : 2018) | year (eg 2018)
 * @return 一年12个月的血压数据集合,其中IDOSyncV3BpDataModel对象是一天总血压数据模型
 * A 12-month blood pressure data collection, where the IDOSyncV3BpDataModel object is a total blood pressure data model for the day
 */
+ (NSArray <NSArray<IDOSyncV3BpDataModel *>*> *)queryOneYearBpWithYear:(NSInteger)year
                                                               macAddr:(NSString *)macAddr;

/**
 * @brief 查询当前设备某月份的所有数据 (如果查询当天无数据,会创建空的数据对象,大于当天的数据不累加)
 * Query all data of the current device for a certain month (If there is no data on the query day, an empty data object will be created,
 * which is larger than the data of the day)
 * @param year 年 (如 : 2018) | Year (eg: 2018)
 * @param month 月 (如 : 9) | Month (eg: 9)
 * @param dates 当前查询月份的所有日期集合的指针 (格式 ：[10/01...10/31])
 * Pointer to all date collections for the current query month (format: [10/01...10/31])
 * @return 一个月的血压数据集合,其中IDOSyncV3BpDataModel对象是一天总血压数据模型
 * One month blood pressure data set, where the IDOSyncV3BpDataModel object is the total day blood pressure data model
 */
+ (NSArray <IDOSyncV3BpDataModel *>*)queryOneMonthBpWithYear:(NSInteger)year
                                                       month:(NSInteger)month
                                                     macAddr:(NSString *)macAddr
                                                datesOfMonth:(NSArray <NSString *>**)dates;

/**
 * @brief 查询当前设备某周的所有数据 (如果查询当天无数据,会创建空的数据对象,大于当天的数据不累加)
 * Query all data of the current device for a certain week (If there is no data on the day of the query, an empty data object will be created,
 * and the data larger than the current day will not be accumulated)
 * @param weekIndex 周的查询索引 (0 : 当周, 1 : 上一周, 2 : 上两周 ...) | Week's query index (0: week, 1 : last week, 2 : last two weeks...)
 * @param weekStartDay 星期的开始日 (0 : 星期日, 1 : 星期一, 2 : 星期二 ...) | Start of the week (0: Sunday, 1 : Monday, 2 : Tuesday ...)
 * @param dates 当前查询周的所有日期集合的指针 (格式 ：[10/01...10/07])
 * Pointer to all date collections for the current query week (format: [10/01...10/07])
 * @return 一周的血压数据集合,其中IDOSyncV3BpDataModel对象是一天总血压数据模型
 * A week's blood pressure data collection, where the IDOSyncV3BpDataModel object is the total day blood pressure data model
 */
+ (NSArray <IDOSyncV3BpDataModel *>*)queryOneWeekBpWithWeekIndex:(NSInteger)weekIndex
                                                    weekStartDay:(NSInteger)weekStartDay
                                                         macAddr:(NSString *)macAddr
                                                     datesOfWeek:(NSArray <NSString *>**)dates;

/**
 * @brief 查询当前设备某天血压数据并有详情数据
 * Query current device blood pressure data for one day and have detailed data
 * @param macAddr mac 地址 | mac address
 * @param year  年份 | year
 * @param month 月份 | month
 * @param day   日期 | day
 * @return 一天血压数据的集合和详情数据集合 | Collection of day blood pressure data and detailed data
 */
+ (NSArray<IDOSyncV3BpDataModel *> *)queryOneDayBpDetailWithMac:(NSString *)macAddr
                                                           year:(NSInteger)year
                                                          month:(NSInteger)month
                                                            day:(NSInteger)day;

/**
 * @brief 查询所有血压数据 血压包数大于0
 * Query all blood pressure data The number of blood pressure packets is greater than 0
 * @param macAddr mac 地址 | mac address
 * @return 所有血压数据的集合和详情数据 | Collection and detailed data of all blood pressure data
 */
+ (NSArray <IDOSyncV3BpDataModel *>*)queryAllBpWithMac:(NSString *)macAddr;

/**
 * 将json数据转模型数据 | Convert json data to model data
 * @param jsonString  数据
 */
+(IDOSyncV3BpDataModel*)v3BloodbPressureDataJsonStringToObjectModel:(NSString*)jsonString;

@end
