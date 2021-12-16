//
//  IDOSyncV3SleepDataModel.h
//  IDOBlueProtocol
//
//  Created by hedongyang on 2020/7/18.
//  Copyright © 2020 何东阳. All rights reserved.
//

#if __has_include(<IDOBlueProtocol/IDOBlueProtocol.h>)
#else
#import "IDOBluetoothBaseModel.h"
#endif

@interface IDOSyncV3SleepDataItemInfoBluetoothModel : IDOBluetoothBaseModel

/**
 * 阶段 0x01: 醒着, 0x02 : 浅睡, 0x03 : 深睡 ；0x04 : 眼动
 * stage
 */
@property (nonatomic,assign) NSInteger  stage;

/**
 持续时间 单位秒 | Duration unit:second
 */
@property (nonatomic,assign) NSInteger  duration;

/**
 序列号 | Serial number
 */
@property (nonatomic,assign) NSInteger serialNumber;


@end

@interface IDOSyncV3SleepDataInfoBluetoothModel : IDOBluetoothBaseModel

/**
 睡眠类型0x01 正常睡眠,0x02 午睡小憩,0x04 不支持眼动（科学睡眠） | Sleep type 0x01 Normal sleep,0x02 nap
 */
@property (nonatomic,assign) NSInteger dataType;

/**
 睡眠数据包数量 | Number of sleep packets
 */
@property (nonatomic,assign) NSInteger itemsCount;

/**
 起床日期 精确到日期 date interval since 1970 (如:1444361933) | Date time interval since 1970 (eg 14442361933)
 */
@property (nonatomic,copy) NSString * dateStr;

/**
 起床的时间戳 精确到分钟 date interval since 1970 (如:1444361933) | get up time interval since 1970 (eg 14442361933)
 */
@property (nonatomic,copy) NSString * getUpTimeStr;

/**
入睡时间 年
*/
@property (nonatomic,assign) NSInteger fallAsleepYear;
/**
入睡时间 月
*/
@property (nonatomic,assign) NSInteger fallAsleepMonth;
/**
入睡时间 日
*/
@property (nonatomic,assign) NSInteger fallAsleepDay;
/**
入睡时间 时
*/
@property (nonatomic,assign) NSInteger fallAsleepHour;
/**
入睡时间 分
*/
@property (nonatomic,assign) NSInteger fallAsleepMinutes;

/**
起床时间 年
*/
@property (nonatomic,assign) NSInteger getUpYear;
/**
起床时间 月
*/
@property (nonatomic,assign) NSInteger getUpMonth;
/**
起床时间 日
*/
@property (nonatomic,assign) NSInteger getUpDay;
/**
起床时间 时
*/
@property (nonatomic,assign) NSInteger getUpHour;
/**
起床时间 分
*/
@property (nonatomic,assign) NSInteger getUpMinutes;

/**
 总睡眠时长 (单位 ：分钟) | Total sleep duration (unit: minute)
 */
@property (nonatomic,assign) NSInteger totalMinute;

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
 眼动眠时长 | Rem sleep duration
 */
@property (nonatomic,assign) NSInteger remSleepMinute;

/**
 浅睡眠次数 | Light sleep times
 */
@property (nonatomic,assign) NSInteger lightSleepCount;

/**
 醒来次数 | Wake up times
 */
@property (nonatomic,assign) NSInteger wakeCount;

/**
 深睡眠次数 | Deep sleep times
 */
@property (nonatomic,assign) NSInteger deepSleepCount;

/**
 眼动睡眠次数 | Rem sleep times
 */
@property (nonatomic,assign) NSInteger remSleepCount;

/**
 * 睡眠items 保存数据集合
 * Sleep Items stores
 */
@property (nonatomic,copy) NSArray <IDOSyncV3SleepDataItemInfoBluetoothModel *> * sleepItems;

/**
 * 呼吸状况
 * awrr status
 */
@property (nonatomic,assign) NSInteger awrrStatus;

/**
 呼吸率=> 改名呼吸质量 0-100 无单位
 breath rate
 */
@property (nonatomic,assign) NSInteger breathRate;

/**
 睡眠评分 | sleep score (1-100)
 */
@property (nonatomic,assign) NSInteger sleepScore;

/**
 目标睡眠时长 (单位 : 分钟) | Target sleep duration (unit: minute)
 */
@property (nonatomic,assign) NSInteger goalSleepData;

@end

@interface IDOSyncV3SleepDataModel : NSObject

/**
 * @brief 查询当前设备某年12个月所有数据 (如果查询当月无数据,会创建空的数据对象,大于当月的数据不累加)
 * Query all data of the current device for 12 months in a certain year (If there is no data in the current month, an empty data object will be created,
 * and the data larger than the current month will not be accumulated)
 * @param year 年 (如 : 2018) | Year (eg: 2018)
 * @param macAddr mac 地址 | mac address
 * @param isQuery 是否查询items | is query items
 * @return 一年12个月的睡眠数据集合,其中IDOSyncV3SleepDataInfoBluetoothModel对象是一天总睡眠数据模型
 * 12 months of sleep data collection, IDOSyncV3SleepDataInfoBluetoothModel object is the total day sleep data model
 */
+ (NSArray <NSArray <IDOSyncV3SleepDataInfoBluetoothModel *>*>*)v3QueryOneYearSleepsWithYear:(NSInteger)year
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
 * @return 一个月的睡眠数据集合,其中IDOSyncV3SleepDataInfoBluetoothModel对象是一天总睡眠数据模型
 * A one-month sleep data collection, where the IDOSyncV3SleepDataInfoBluetoothModel object is the total day sleep data model
 */
+ (NSArray <IDOSyncV3SleepDataInfoBluetoothModel *>*)v3QueryOneMonthSleepsWithYear:(NSInteger)year
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
 * @return 一周的睡眠数据集合,其中IDOSyncV3SleepDataInfoBluetoothModel对象是一天总睡眠数据模型
 * A week's sleep data collection, where the IDOSyncV3SleepDataInfoBluetoothModel object is the total day sleep data model
 */
+ (NSArray <IDOSyncV3SleepDataInfoBluetoothModel *>*)v3QueryOneWeekSleepsWithWeekIndex:(NSInteger)weekIndex
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
+ (NSArray <IDOSyncV3SleepDataInfoBluetoothModel *>*)v3QueryOneDaySleepsDetailWithMac:(NSString *)macAddr
                                                                                          year:(NSInteger)year
                                                                                         month:(NSInteger)month
                                                                                           day:(NSInteger)day;

/**
 * @brief 查询所有睡眠数据 睡眠时长大于0 | Query all sleep data Sleep duration is greater than 0
 * @param macAddr mac 地址 | mac address
 * @return 所有睡眠数据的集合 | Collection and details of all sleep data
 */
+ (NSArray <IDOSyncV3SleepDataInfoBluetoothModel *>*)v3QueryAllSleepsWithMac:(NSString *)macAddr;


/**
 * @brief 查询所有睡眠数据 睡眠时长大于0 只包含睡眠总时长和日期时间戳
 * Query all sleep data Sleep duration is greater than 0 Just the total amount of sleep and the date and timestamp
 * @param macAddr mac 地址 | mac address
 * @return 所有睡眠数据的集合 | Collection of all sleep data
 */
+ (NSArray <IDOSyncV3SleepDataInfoBluetoothModel *>*)v3QueryAllContractedSleepsWithMac:(NSString *)macAddr;

@end
