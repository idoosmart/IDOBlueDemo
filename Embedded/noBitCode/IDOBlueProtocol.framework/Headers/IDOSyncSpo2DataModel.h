//
//  IDOSyncSpo2DataModel.h
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

@interface IDOSyncBloodOxygenItemInfoBluetoothModel : IDOBluetoothBaseModel

/**
 日期 time interval since 1970 (如:1444361933) | Date time interval since 1970 (eg 14442361933)
 */
@property (nonatomic,copy) NSString * dateStr;

/**
 子时间偏移量 (秒钟) | Subtime offset (second)
 */
@property (nonatomic,assign) NSUInteger offset;

/**
 血氧值 | Blood oxygen value 0 ~ 255
 */
@property (nonatomic,assign) NSInteger spo2Val;

/**
 序列号 | Serial number
 */
@property (nonatomic,assign) NSInteger  serialNumber;

@end

@interface IDOSyncBloodOxygenDataInfoBluetoothModel : IDOBluetoothBaseModel

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
 日期 精确到日期 date interval since 1970 (如:1444361933) | Date time interval since 1970 (eg 14442361933)
 */
@property (nonatomic,copy) NSString * dateStr;

/**
 总时间偏移量 (秒钟) | Total time offset (second)
 */
@property (nonatomic,assign) NSUInteger minuteOffset;

/**
 血氧数据包量 | Blood pressure data package
 */
@property (nonatomic,assign) NSInteger itemsCount;

/**
 * 血氧集合 只有定义好的查询方法才能转成model集合，自定义的查询方法无法直接转成model集合，需要再查询itemModel赋给当前属性
 * blood oxygen collection Only defined query methods can be converted into model collections. Custom query methods cannot be directly converted
 * into model collections. You need to query itemModel to assign current attributes.
 */
@property (nonatomic,copy) NSArray <IDOSyncBloodOxygenItemInfoBluetoothModel *>* bloodOxygens;

/**
 平均血氧 | Average blood oxygen
 */
@property (nonatomic,assign) NSInteger avgBloodOxygen;

/**
 最大血氧 | Maximum blood oxygen
 */
@property (nonatomic,assign) NSInteger maxBloodOxygen;

/**
 最小血氧 | Most blood oxygen
 */
@property (nonatomic,assign) NSInteger minBloodOxygen;

@end


@interface IDOSyncSpo2DataModel : NSObject
/**
 * @brief 查询当前设备某年12个月所有数据 (如果查询当月无数据,会创建空的数据对象,大于当月的数据不累加)
 * Query all data of the current device for 12 months in a certain year (If there is no data in the query month, an empty data object will be created,
 * and the data larger than the current month will not be accumulated)
 * @param year 年 (如 : 2018) | Year (eg: 2018)
 * @param macAddr  mac 地址  | mac address
 * @param isQuery 是否查询items | is query items
 * @return 一年12个月的血氧数据集合,其中IDOSyncBloodOxygenDataInfoBluetoothModel对象是一天总血氧数据模型
 * Blood oxygen data collection for 12 months a year, where the IDOSyncBloodOxygenDataInfoBluetoothModel object is the total blood oxygen data model for the day
 */
+ (NSArray <NSArray<__kindof IDOSyncBloodOxygenDataInfoBluetoothModel *>*> *)queryOneYearBloodOxygenWithYear:(NSInteger)year
                                                                                                     macAddr:(NSString *)macAddr
                                                                                                isQueryItems:(BOOL)isQuery;

/**
 * @brief 查询当前设备某月份的所有数据 (如果查询当天无数据,会创建空的数据对象,大于当天的数据不累加)
 * Query all data of the current device for a certain month (If there is no data on the query day, an empty data object will be created,
 * which is larger than the data of the day)
 * @param year 年 (如 : 2018) | Year (eg: 2018)
 * @param month 月 (如 : 9) | Month (eg: 9)
 * @param macAddr  mac 地址  | mac address
 * @param dates 当前查询月份的所有日期集合的指针 (格式 ：[10/01...10/31])
 * Pointer to all date collections for the current query month (format: [10/01...10/31])
 * @param isQuery 是否查询items | is query items
 * @return 一个月的血氧数据集合,其中IDOSyncBloodOxygenDataInfoBluetoothModel对象是一天总血氧数据模型
 * A one-month blood oxygen data collection, where the IDOSyncHrDataInfoBluetoothModel object is the total blood oxygen data model for the day
 */
+ (NSArray <__kindof IDOSyncBloodOxygenDataInfoBluetoothModel *>*)queryOneMonthBloodOxygenWithYear:(NSInteger)year
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
 * @param macAddr  mac 地址  | mac address
 * @param dates 当前查询周的所有日期集合的指针 (格式 ：[10/01...10/07])
 * Pointer to all date collections for the current query week (format: [10/01...10/07])
 * @param isQuery 是否查询items | is query items
 * @return 一周的血氧数据集合,其中IDOSyncBloodOxygenDataInfoBluetoothModel对象是一天总血氧数据模型
 * A week's blood oxygen data collection, where the IDOSyncBloodOxygenDataInfoBluetoothModel object is the total blood oxygen data model for the day
 */
+ (NSArray <__kindof IDOSyncBloodOxygenDataInfoBluetoothModel *>*)queryOneWeekBloodOxygenWithWeekIndex:(NSInteger)weekIndex
                                                                                          weekStartDay:(NSInteger)weekStartDay
                                                                                               macAddr:(NSString *)macAddr
                                                                                           datesOfWeek:(NSArray <NSString *>**)dates
                                                                                          isQueryItems:(BOOL)isQuery;

/**
 * @brief 查询当前设备某天血氧数据并有详情数据
 * Query current blood oxygen data of the current device and have detailed data
 * @param macAddr  mac 地址  | mac address
 * @param year  年份  | year
 * @param month 月份  | month
 * @param day   日期  | day
 * @return 一天血氧数据的集合和详情数据结合 | Collection of day blood oxygen data and details data
 */
+ (NSArray <__kindof IDOSyncBloodOxygenDataInfoBluetoothModel *>*)queryOneDayBloodOxygenDetailWithMac:(NSString *)macAddr
                                                                                                  year:(NSInteger)year
                                                                                                 month:(NSInteger)month
                                                                                                   day:(NSInteger)day;

/**
 * @brief 查询所有血氧数据,血氧包个数大于0
 * Query all blood oxygen data The number of blood oxygen packets is greater than 0
 * @param macAddr  mac地址 | mac address
 * @return 所有血氧数据的集合和详情数据（不包括当天数据）
 * Collection of all blood oxygen data and details data
 */
+ (NSArray <__kindof IDOSyncBloodOxygenDataInfoBluetoothModel *>*)queryAllBloodOxygensWithMac:(NSString *)macAddr;


@end

