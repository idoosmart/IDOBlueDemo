//
//  IDOSyncSportDataModel.h
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

@interface IDOSyncSportDataItemInfoBluetoothModel : IDOBluetoothBaseModel

/**
 运动模式 | Sports mode (unit: number of steps)
 */
@property (nonatomic,assign) NSInteger mode;

/**
 运动步数 | Number of steps
 */
@property (nonatomic,assign) NSInteger sportCount;

/**
 活跃时间 (秒) | Active time (seconds)
 */
@property (nonatomic,assign) NSInteger activeTime;

/**
 卡路里（大卡） | Calories (unit: big card)
 */
@property (nonatomic,assign) NSInteger calories;

/**
 运动距离（米） | Sport distance (unit: m)
 */
@property (nonatomic,assign) NSInteger distance;

/**
 运动时间日期 精确到日期 | Sports time and date
 */
@property (nonatomic,copy) NSString * dateStr;

/**
 序列号 | Serial number
 */
@property (nonatomic,assign) NSInteger serialNumber;

@end

@interface IDOSyncSportDataInfoBluetoothModel : IDOBluetoothBaseModel

/**
 运动数据包数量 | Number of sports packets
 */
@property (nonatomic,assign) NSInteger itemsCount;

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
 * 运动数据集合 只有定义好的查询方法才能转成model集合，自定义的查询方法无法直接转成model集合，需要再查询itemModel赋给当前属性
 * Motion data collection Only defined query methods can be converted into model collections. Custom query methods cannot be directly
 * converted into model collections. You need to query itemModel to assign current attributes.
 */
@property (nonatomic,copy) NSArray  <IDOSyncSportDataItemInfoBluetoothModel *>* sportItems;

/**
 运动总步数(单位 ：步数) | Total number of steps in sports (unit: number of steps)
 */
@property (nonatomic,assign) NSInteger totalStep;

/**
 运动总消耗卡路里(单位 ：大卡) | Total calories burned by exercise (unit: big card)
 */
@property (nonatomic,assign) NSInteger totalCalories;

/**
 运动总距离(单位 ：米) | Total distance of movement (unit: m)
 */
@property (nonatomic,assign) NSInteger totalDistances;

/**
 运动总时长 (秒) | Total length of exercise (seconds)
 */
@property (nonatomic,assign) NSInteger totalActiveTime;

/**
 开始偏移量 | Start offset
 */
@property (nonatomic,assign) NSInteger minuteOffset;

/**
 产生数据间隔 | Generate data interval
 */
@property (nonatomic,assign) NSInteger perMinute;

/**
 目标运动数量 | Number of target sports
 */
@property (nonatomic,assign) NSInteger goalSportData;

/**
 一天步数items个数 | one day total items count
 */
@property (nonatomic,assign) NSInteger totalCount;

/**
 只有用于 Donha app | Only for the Donha app
 关键字 0:无效;1:超;2:浪;3:稳;4:慢;5:懒;6:香;7:安;8:困;9:燃;10:暖;11:动;12:佛;13:秀;14:拼;15:惯;16:凉;
 */
@property (nonatomic,assign) NSInteger keyWord;

@end


@interface IDOSyncSportDataModel : NSObject
/**
 * @brief 查询当前设备某年12个月所有数据 (如果查询当月无数据,会创建空的数据对象,大于当月的数据不累加)
 * Query all data of the current device for 12 months in a certain year (If there is no data in the current month, an empty data object will be created,
 * and the data larger than the current month will not be accumulated)
 * @param year 年 (如 : 2018) | Year (eg: 2018)
 * @param macAddr mac 地址 | mac address
 * @param isQuery 是否查询items | is query items
 * @return 一年12个月的运动数据集合，其中IDOSyncSportDataInfoBluetoothModel对象是一天总运动数据模型
 * A 12-month sports data collection, where the IDOSyncSportDataInfoBluetoothModel object is a total day motion data model
 */
+ (NSArray <NSArray <__kindof IDOSyncSportDataInfoBluetoothModel *> *>*)queryOneYearSportsWithYear:(NSInteger)year
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
 * @return 一个月的运动数据集合,其中IDOSyncSportDataInfoBluetoothModel对象是一天总运动数据模型
 * One month of motion data collection, where the IDOSyncSportDataInfoBluetoothModel object is the total day motion data model
 */
+ (NSArray <__kindof IDOSyncSportDataInfoBluetoothModel *>*)queryOneMonthSportsWithYear:(NSInteger)year
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
 * @return 一周的运动数据集合,其中IDOSyncSportDataInfoBluetoothModel对象是一天总运动数据模型
 * A week of motion data collection, where the IDOSyncSportDataInfoBluetoothModel object is the total day motion data model
 */
+ (NSArray <__kindof IDOSyncSportDataInfoBluetoothModel *>*)queryOneWeekSportsWithWeekIndex:(NSInteger)weekIndex
                                                                               weekStartDay:(NSInteger)weekStartDay
                                                                                    macAddr:(NSString *)macAddr
                                                                                datesOfWeek:(NSArray <NSString *>**)dates
                                                                               isQueryItems:(BOOL)isQuery;


/**
 * @brief 查询当前设备某天运动据并有详情数据 | Query the current device's mobile data and have detailed data
 * @param macAddr mac 地址 | mac address
 * @param year  年份 | year
 * @param month 月份 | month
 * @param day   日期 | day
 * @return 一天运动数据的集合和详情数据集合 | Collection of daily exercise data and detailed data
 */
+ (NSArray <__kindof IDOSyncSportDataInfoBluetoothModel *>*)queryOneDaySportDetailWithMac:(NSString *)macAddr
                                                                                      year:(NSInteger)year
                                                                                     month:(NSInteger)month
                                                                                       day:(NSInteger)day;

/**
 * @brief 查询所有运动数据 步数大于0 | Query all motion data Steps greater than 0
 * @param macAddr mac 地址 | mac address
 * @return 所有运动数据的集合 | Collection of all the motion data
 */
+ (NSArray <__kindof IDOSyncSportDataInfoBluetoothModel *>*)queryAllSportsWithMac:(NSString *)macAddr;

/**
 * @brief 查询所有运动数据 步数大于0 只包含总步数和日期时间戳
 * Query all motion data Steps greater than 0 ; Contains only the total number of steps and the date and time stamp
 * @param macAddr mac 地址 | mac address
 * @return 所有运动数据的集合 | Collection of all the motion data
 */
+ (NSArray <__kindof IDOSyncSportDataInfoBluetoothModel *>*)queryAllContractedSportsWithMac:(NSString *)macAddr;

@end

