//
//  IDOSyncBodyPowerDataModel.h
//  IDOBlueProtocol
//
//  Created by hedongyang on 2022/6/9.
//  Copyright © 2022 何东阳. All rights reserved.
//

#import <IDOBlueProtocol/IDOBlueProtocol.h>

@interface IDOSyncBodyPowerDataModel : IDOBluetoothBaseModel
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
 起始时间 单位秒，基于0点的偏移
 */
@property (nonatomic,assign) NSInteger startTime;
/**
 身体电量个数
 */
@property (nonatomic,assign) NSInteger itemCount;
/**
 * 身体电量集合 @[{@"offset":@(0),@"value":@(0),@"type":@(0),@"diff_value":@(0)}...]
 * value：实际产生值  有小数 固件返回值应将实际值乘以100
 * offset ：基于前一个数据点时间偏移量 (秒钟)
 * type : 标签类型  0x01：睡眠   0x02：放松   0x03：锻炼  0x04活动  0x05：压力
 * diff_value : 相对于上一个值的差值
 */
@property (nonatomic,copy) NSArray <NSDictionary *>* bodyPowers;

/**
 * @brief 查询当前设备某年12个月所有数据 (如果查询当月无数据,会创建空的数据对象,大于当月的数据不累加)
 * Query all data of the current device for 12 months in a certain year (If there is no data in the current month, an empty data object will be created,
 * and the data larger than the current month will not be accumulated)
 * @param year 年 (如 : 2018) | Year (eg: 2018)
 * @param macAddr mac 地址 | mac address
 * @return 一年12个月的身体电量数据集合，其中IDOSyncBodyPowerDataModel对象是一天身体电量数据模型
 * A 12-month body power data collection, where the IDOSyncBodyPowerDataModel object is a total day body power data model
 */
+ (NSArray <NSArray<IDOSyncBodyPowerDataModel *>*> *)queryOneYearBodyPowerWithYear:(NSInteger)year
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
 * @return 一个月的身体电量数据集合,其中IDOSyncBodyPowerDataModel对象是一天身体电量数据模型
 * One month of body power data collection, where the IDOSyncBodyPowerDataModel object is the total day body power data model
 */
+ (NSArray <IDOSyncBodyPowerDataModel *>*)queryOneMonthBodyPowerWithYear:(NSInteger)year
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
 * @return 一周的身体电量数据集合,其中IDOSyncBodyPowerDataModel对象是一天身体电量数据模型
 * A week of body power data collection, where the IDOSyncBodyPowerDataModel object is the total day body power data model
 */
+ (NSArray <IDOSyncBodyPowerDataModel *>*)queryOneWeekBodyPowerWithWeekIndex:(NSInteger)weekIndex
                                                               weekStartDay:(NSInteger)weekStartDay
                                                                    macAddr:(NSString *)macAddr
                                                                datesOfWeek:(NSArray <NSString *>**)dates;


/**
 * @brief 查询当前设备某天身体电量数据并有详情数据 | Query the current device's breath rate data and have detailed data
 * @param macAddr mac 地址 | mac address
 * @param year  年份 | year
 * @param month 月份 | month
 * @param day   日期 | day
 * @return 一天身体电量数据的集合和详情数据集合 | Collection of daily body power data and detailed data
 */
+ (NSArray <IDOSyncBodyPowerDataModel *>*)queryOneDayBodyPowerDetailWithMac:(NSString *)macAddr
                                                                      year:(NSInteger)year
                                                                     month:(NSInteger)month
                                                                       day:(NSInteger)day;

/**
 * @brief 查询所有身体电量数据 平均的身体电量大于0 | Query all body power data The average body power is greater than 0
 * @param macAddr mac 地址 | mac address
 * @return 所有身体电量数据的集合 | Collection of all the body power data
 */
+ (NSArray <IDOSyncBodyPowerDataModel *>*)queryAllBodyPowerWithMac:(NSString *)macAddr;

/**
 * 将json数据转模型数据 | Convert json data to model data
 * @param jsonString  数据
 */
+(IDOSyncBodyPowerDataModel*)bodyPowerDataJsonStringToObjectModel:(NSString*)jsonString;

@end

