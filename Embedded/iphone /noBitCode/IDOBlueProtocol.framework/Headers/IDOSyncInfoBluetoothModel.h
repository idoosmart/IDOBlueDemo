//
//  IDOSyncInfoBluetoothModel.h
//  VeryfitSDK
//
//  Created by hedongyang on 2018/8/22.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

@interface IDOSyncPressureItemInfoBluetoothModel : IDOBluetoothBaseModel

/**
 日期 精确到日期 date interval since 1970 (如:1444361933) | Date time interval since 1970 (eg 14442361933)
 */
@property (nonatomic,copy) NSString * dateStr;

/**
 子时间偏移量 (分钟) | Subtime offset (minutes)
 */
@property (nonatomic,assign) NSUInteger offset;

/**
 压力值 | pressure value 0 ~ 255
 */
@property (nonatomic,assign) NSInteger pressureVal;

@end

@interface IDOSyncPressureDataInfoBluetoothModel : IDOBluetoothBaseModel

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
 总时间偏移量 (分钟) | Total time offset (minutes)
 */
@property (nonatomic,assign) NSUInteger minuteOffset;

/**
 压力数据包量 | Pressure data package
 */
@property (nonatomic,assign) NSInteger itemsCount;

/**
 * @brief 压力集合 只有定义好的查询方法才能转成model集合，自定义的查询方法无法直接转成model集合，需要再查询itemModel赋给当前属性
 * pressure collection Only defined query methods can be converted into model collections. Custom query methods cannot be directly converted
 * into model collections. You need to query itemModel to assign current attributes.
 */
@property (nonatomic,copy) NSArray <IDOSyncPressureItemInfoBluetoothModel *>* pressures;

/**
 * @brief 初始化同步的压力数据模型 (内部使用) | Initialize synchronized pressure data model (internal use)
 * @param data 压力结构体数据 | pressure Structure Data
 * @return 是 或 否 |yes or no
 */
+ (BOOL)pressureDataInfoStructToModel:(void *)data;

/**
 * @brief 查询当前设备某年12个月所有数据 (如果查询当月无数据,会创建空的数据对象,大于当月的数据不累加)
 * Query all data of the current device for 12 months in a certain year (If there is no data in the query month, an empty data object will be created,
 * and the data larger than the current month will not be accumulated)
 * @param year 年 (如 : 2018) | Year (eg: 2018)
 * @param macAddr  mac 地址  | mac address
 * @param isQuery 是否查询items | is query items
 * @return 一年12个月的压力数据集合,其中IDOSyncPressureDataInfoBluetoothModel对象是一天总血氧数据模型
 * pressure data collection for 12 months a year, where the IDOSyncPressureDataInfoBluetoothModel object is the total pressure data model for the day
 */
+ (NSArray <NSArray<__kindof IDOSyncPressureDataInfoBluetoothModel *>*> *)queryOneYearPressureWithYear:(NSInteger)year
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
 * @return 一个月的压力数据集合,其中IDOSyncPressureDataInfoBluetoothModel对象是一天总压力数据模型
 * A one-month pressure data collection, where the IDOSyncPressureDataInfoBluetoothModel object is the total pressure data model for the day
 */
+ (NSArray <__kindof IDOSyncPressureDataInfoBluetoothModel *>*)queryOneMonthPressureWithYear:(NSInteger)year
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
 * @return 一周的压力数据集合,其中IDOSyncPressureDataInfoBluetoothModel对象是一天总压力数据模型
 * A week's pressure data collection, where the IDOSyncPressureDataInfoBluetoothModel object is the total pressure data model for the day
 */
+ (NSArray <__kindof IDOSyncPressureDataInfoBluetoothModel *>*)queryOneWeekPressureWithWeekIndex:(NSInteger)weekIndex
                                                                                    weekStartDay:(NSInteger)weekStartDay
                                                                                         macAddr:(NSString *)macAddr
                                                                                     datesOfWeek:(NSArray <NSString *>**)dates
                                                                                    isQueryItems:(BOOL)isQuery;

/**
 * @brief 查询当前设备某天压力数据并有详情数据
 * Query current pressure data of the current device and have detailed data
 * @param macAddr  mac 地址  | mac address
 * @param year  年份  | year
 * @param month 月份  | month
 * @param day   日期  | day
 * @return 一天压力数据的集合和详情数据 | Collection of day pressure data and details data
 */
+ (__kindof IDOSyncPressureDataInfoBluetoothModel *)queryOneDayPressureDetailWithMac:(NSString *)macAddr
                                                                                Year:(NSInteger)year
                                                                               month:(NSInteger)month
                                                                                 day:(NSInteger)day;

/**
 * @brief 查询所有压力数据，压力包个数大于0
 * Query all pressure data The number of pressure packets is greater than 0
 * @param macAddr  mac地址 | mac address
 * @return 所有压力数据的集合和详情数据（不包括当天数据）
 * Collection of all pressure data and details data（Data for the day are not included）
 */
+ (NSArray <__kindof IDOSyncPressureDataInfoBluetoothModel *>*)queryAllPressuresWithMac:(NSString *)macAddr;

@end

@interface IDOSyncBloodOxygenItemInfoBluetoothModel : IDOBluetoothBaseModel

/**
 日期 time interval since 1970 (如:1444361933) | Date time interval since 1970 (eg 14442361933)
 */
@property (nonatomic,copy) NSString * dateStr;

/**
 子时间偏移量 (分钟) | Subtime offset (minutes)
 */
@property (nonatomic,assign) NSUInteger offset;

/**
 血氧值 | Blood oxygen value 0 ~ 255
 */
@property (nonatomic,assign) NSInteger spo2Val;

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
 总时间偏移量 (分钟) | Total time offset (minutes)
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
 * @brief 初始化同步的血氧数据模型 (内部使用) | Initialize synchronized blood oxygen data model (internal use)
 * @param data 血氧结构体数据 | Blood oxygen Structure Data
 * @return 是 或 否 |yes or no
 */
+ (BOOL)bloodOxygenDataInfoStructToModel:(void *)data;

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
 * @return 一天血氧数据的集合和详情数据 | Collection of day blood oxygen data and details data
 */
+ (__kindof IDOSyncBloodOxygenDataInfoBluetoothModel *)queryOneDayBloodOxygenDetailWithMac:(NSString *)macAddr
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

@interface IDOSyncActivityDataInfoBluetoothModel : IDOBluetoothBaseModel

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
 时 | hour
 */
@property (nonatomic,assign) NSInteger hour;

/**
 分 | minutes
 */
@property (nonatomic,assign) NSInteger minute;

/**
 秒 | seconds
 */
@property (nonatomic,assign) NSInteger second;

/**
 日期 精确到日期 date interval since 1970 (如:1444361933) | Date time interval since 1970 (eg 14442361933)
 */
@property (nonatomic,copy) NSString * dateStr;

/**
 开始时间 精确到秒 | start time interval since 1970 (eg 14442361933)
 */
@property (nonatomic,copy) NSString * timeStr;

/**
 数据长度 | Data length
 */
@property (nonatomic,assign) NSInteger  dataLength;

/**
 心率数据产生间隔 (单位 : s) | Heart rate data generation interval (unit: s)
 */
@property (nonatomic,assign) NSInteger hrInterval;

/**
 心率项数据个数 | Heart rate item data
 */
@property (nonatomic,assign) NSInteger  hrItemCount;

/**
 包的总数 | Total number of packages
 */
@property (nonatomic,assign) NSInteger  packetCount;

/*
 * 类型:0x01:走路, 0x02:跑步， 0x03:骑行 0x04:徒步 这些类型才有轨迹运动
 * Type: 0x01: Walk, 0x02: Running, 0x03: Cycling 0x04: Walking These types have track motion
 */
@property (nonatomic,assign) NSInteger type;

/**
 步数(骑行 时，步数为 0) | Number of steps (when riding, the number of steps is 0)
 */
@property (nonatomic,assign) NSInteger step;

/**
 持续时长 (单位:s) | Duration (unit: s)
 */
@property (nonatomic,assign) NSInteger durations;

/**
 卡路里(单 位:大卡) | Calories (Unit: Big Card)
 */
@property (nonatomic,assign) NSInteger calories;

/**
 距离(单位: 米) | Distance (in meters)
 */
@property (nonatomic,assign) NSInteger distance;

/**
 平均心率 | Average heart rate
 */
@property (nonatomic,assign) NSInteger  avgHrValue;

/**
 最大心率 | Maximum heart rate
 */
@property (nonatomic,assign) NSInteger  maxHrValue;

/**
 脂肪燃烧时长 | Fat burning time
 */
@property (nonatomic,assign) NSInteger burnFatMins;

/**
 心肺锻炼时长 (分钟) | Cardio workout time (minutes)
 */
@property (nonatomic,assign) NSInteger aerobicMins;

/**
 极限锻炼时长 (分钟) | Extreme workout time (minutes)
 */
@property (nonatomic,assign) NSInteger limitMins;

/**
 有序列号的心率集合 json字符串 | Heart rate collection with serial number json string
 */
@property (nonatomic,copy) NSString  * hrValuesStr;

/**
 是否需要保存数据 (用于数据交换) | Do you need to save data (for data exchange)
 */
@property (nonatomic,assign) BOOL isSave;

/**
 * 运动发起端 (1 : 手环发起 0 : app发起)
 * Sports Initiator (1 : Bracelet Initiation  0 : app initiated)
 */
@property (nonatomic,assign) NSInteger startFrom;

/**
 * @brief 初始化同步的活动数据模型 (内部使用)
 * Initialize synchronized active data model (internal use)
 * @param data 活动结构体数据 | Active Structure Data
 * @return 是 或 否 |yes or no
 */
+ (BOOL)activityDataInfoStructToModel:(const void *)data;

/**
 * @brief 当前设备根据活动开始时间查询某个活动详情
 * The current device queries an event details based on the event start time
 * @param macAddr  mac地址 | Mac address
 * @param timeStr 活动开始时间 | Event start time
 * @return model IDOSyncActivityDataInfoBluetoothModel
 */
+ (__kindof IDOSyncActivityDataInfoBluetoothModel *)queryOneActivityDataWithTimeStr:(NSString *)timeStr
                                                                            macAddr:(NSString *)macAddr;

/**
 * @brief 当前设备根据日期查询某天的活动集合
 * The current device queries the collection of events for a certain day based on the date
 * @param macAddr  mac地址 | Mac address
 * @param year  年份 | year
 * @param month 月份 | month
 * @param day   日期 | day
 * @return 活动集合 | Activity collection
 */
+ (NSArray <__kindof IDOSyncActivityDataInfoBluetoothModel *>*)queryOneDayActivityDataWithMacAddr:(NSString *)macAddr
                                                                                             year:(NSInteger)year
                                                                                            month:(NSInteger)month
                                                                                              day:(NSInteger)day;


/**
 * @brief 当前设备活动分页查询活动集合 | Current Device Activity Paging Query Activity Collection
 * @param pageIndex 页码 第几页 (如 : 0,1,2,3,4,...) | Page Number of pages (eg : 0,1,2,3,4,...)
 * @param numOfPage 每页的数据个数 (如 : 10,20,30...) | The number of data per page (eg: 10, 20, 30...)
 * @param macAddr  mac地址 | Mac address
 * @return 活动集合
 */
+ (NSArray <__kindof IDOSyncActivityDataInfoBluetoothModel *>*)queryOnePageActivityDataWithPageIndex:(NSInteger)pageIndex
                                                                                           numOfPage:(NSInteger)numOfPage
                                                                                             macAddr:(NSString *)macAddr;

/**
 * @brief 当前设备所有轨迹运动 | Current track motion of all devices
 * @param macAddr mac 地址 | mac address
 * @return 活动集合 | Activity collection
 */
+ (NSArray <__kindof IDOSyncActivityDataInfoBluetoothModel *>*)queryAllTrajectorySportActivitysWithMac:(NSString *)macAddr;

/**
 * @brief 当前设备所有轻运动 | Current equipment all light sports
 * @param macAddr mac 地址 | mac address
 * @return 活动集合 | Activity collection
 */
+ (NSArray <__kindof IDOSyncActivityDataInfoBluetoothModel *>*)queryAllLightSportActivitysWithMac:(NSString *)macAddr;



@end

@interface IDOSyncBpDataItemInfoBluetoothModel : IDOBluetoothBaseModel

/**
 较大收缩压 | Large systolic pressure
 */
@property (nonatomic,assign) NSInteger sysBlood;

/**
 较小舒张压 | Small diastolic pressure
 */
@property (nonatomic,assign) NSInteger diasBlood;

/**
 子时间偏移量 (分钟) | Subtime offset (minutes)
 */
@property (nonatomic,assign) NSInteger offset;

/**
 序列号 | Serial number
 */
@property (nonatomic,assign) NSInteger  serialNumber;

/**
 时间戳 精确到日期 date interval since 1970 (如:1444361933) | Timestamp date interval since 1970 (eg: 14443361933)
 */
@property (nonatomic,copy)   NSString * dateStr;

/**
 时间戳 精确到分钟 time interval since 1970 (如:1444361933) | Timestamp time interval since 1970 (eg: 14443361933)
 */
@property (nonatomic,copy)   NSString * timeStr;

/**
 本地设置数据，区分手环同步的数据 | Locally set data to distinguish the data of the bracelet synchronization
 */
@property (nonatomic,assign) BOOL isLocal;

@end

@interface IDOSyncBpDataInfoBluetoothModel : IDOBluetoothBaseModel

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
 * 血压集合 只有定义好的查询方法才能转成model集合，自定义的查询方法无法直接转成model集合，需要再查询itemModel赋给当前属性
 * Blood pressure collection Only defined query methods can be converted into model collections. Custom query methods cannot be directly
 * converted into model collections. You need to query itemModel to assign current attributes.
 */
@property (nonatomic,copy)   NSArray <IDOSyncBpDataItemInfoBluetoothModel *>* bloodbPressures;

/**
 时间戳 精确到日期 date interval since 1970 (如:1444361933) | Timestamp date interval since 1970 (eg: 14443361933)
 */
@property (nonatomic,copy)   NSString * dateStr;

/**
 总时间偏移量 (分钟) | Total time offset (minutes)
 */
@property (nonatomic,assign) NSUInteger minuteOffset;

/**
 本地设置数据，区分手环同步的数据 | Locally set data to distinguish the data of the bracelet synchronization
 */
@property (nonatomic,assign) BOOL isLocal;

/**
 * @brief 初始化同步的血压数据模型 (内部使用) | Initialize synchronized blood pressure data model (internal use
 * @param data 血压结构体数据 | Blood pressure structure data
 * @return 是或否  | yes or no
 */
+ (BOOL)bloodbPressureDataInfoStructToModel:(void *)data;

/**
 * @brief 查询当前设备某年12个月所有数据 (如果查询当月无数据,会创建空的数据对象,大于当月的数据不累加)
 * Query all data of the current device for 12 months in a certain year (If there is no data in the current month, an empty data object will be created,
 * and the data larger than the current month will not be accumulated)
 * @param year 年 (如 : 2018) | year (eg 2018)
 * @param isQuery 是否查询items | is query items
 * @return 一年12个月的血压数据集合,其中IDOSyncBpDataInfoBluetoothModel对象是一天总血压数据模型
 * A 12-month blood pressure data collection, where the IDOSyncBpDataInfoBluetoothModel object is a total blood pressure data model for the day
 */
+ (NSArray <NSArray<__kindof IDOSyncBpDataInfoBluetoothModel *>*> *)queryOneYearBloodPressuresWithYear:(NSInteger)year
                                                                                               macAddr:(NSString *)macAddr
                                                                                          isQueryItems:(BOOL)isQuery;

/**
 * @brief 查询当前设备某月份的所有数据 (如果查询当天无数据,会创建空的数据对象,大于当天的数据不累加)
 * Query all data of the current device for a certain month (If there is no data on the query day, an empty data object will be created,
 * which is larger than the data of the day)
 * @param year 年 (如 : 2018) | Year (eg: 2018)
 * @param month 月 (如 : 9) | Month (eg: 9)
 * @param dates 当前查询月份的所有日期集合的指针 (格式 ：[10/01...10/31])
 * Pointer to all date collections for the current query month (format: [10/01...10/31])
 * @param isQuery 是否查询items | is query items
 * @return 一个月的血压数据集合,其中IDOSyncBpDataInfoBluetoothModel对象是一天总血压数据模型
 * One month blood pressure data set, where the IDOSyncBpDataInfoBluetoothModel object is the total day blood pressure data model
 */
+ (NSArray <__kindof IDOSyncBpDataInfoBluetoothModel *>*)queryOneMonthBloodPressuresWithYear:(NSInteger)year
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
 * @param dates 当前查询周的所有日期集合的指针 (格式 ：[10/01...10/07])
 * Pointer to all date collections for the current query week (format: [10/01...10/07])
 * @param isQuery 是否查询items | is query items
 * @return 一周的血压数据集合,其中IDOSyncBpDataInfoBluetoothModel对象是一天总血压数据模型
 * A week's blood pressure data collection, where the IDOSyncBpDataInfoBluetoothModel object is the total day blood pressure data model
 */
+ (NSArray <__kindof IDOSyncBpDataInfoBluetoothModel *>*)queryOneWeekBloodPressuresWithWeekIndex:(NSInteger)weekIndex
                                                                                    weekStartDay:(NSInteger)weekStartDay
                                                                                         macAddr:(NSString *)macAddr
                                                                                     datesOfWeek:(NSArray <NSString *>**)dates
                                                                                    isQueryItems:(BOOL)isQuery;

/**
 * @brief 查询当前设备某天血压数据并有详情数据
 * Query current device blood pressure data for one day and have detailed data
 * @param macAddr mac 地址 | mac address
 * @param year  年份 | year
 * @param month 月份 | month
 * @param day   日期 | day
 * @return 一天血压数据的集合和详情数据 | Collection of day blood pressure data and detailed data
 */
+ (__kindof IDOSyncBpDataInfoBluetoothModel *)queryOneDayBloodPressureDetailWithMac:(NSString *)macAddr
                                                                               year:(NSInteger)year
                                                                              month:(NSInteger)month
                                                                                day:(NSInteger)day;

/**
 * @brief 查询当前设备最近一天血压数据并有详情数据
 * Query the current day's blood pressure data of the device and have detailed data
 * @param macAddr mac 地址 | mac address
 * @return 一天血压数据的集合和详情数据 | Collection of day blood pressure data and detailed data
 */
+ (__kindof IDOSyncBpDataInfoBluetoothModel *)queryLastDayBloodPressureDetailWithMac:(NSString *)macAddr;

/**
 * @brief 查询所有血压数据 血压包数大于0
 * Query all blood pressure data The number of blood pressure packets is greater than 0
 * @param macAddr mac 地址 | mac address
 * @return 所有血压数据的集合和详情数据 | Collection and detailed data of all blood pressure data
 */
+ (NSArray <__kindof IDOSyncBpDataInfoBluetoothModel *>*)queryAllBloodPressuresWithMac:(NSString *)macAddr;

@end

@interface IDOSyncHrDataItemInfoBluetoothModel : IDOBluetoothBaseModel

/**
 子时间偏移量 (分钟) | Subtime offset (minutes)
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
 总时间偏移量 | Total time offset
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


/**
 * @brief 初始化同步的心率数据模型 （内部使用） | Initialize synchronized heart rate data model (internal use)
 * @param data 心率结构体数据 | Heart rate structure data
 * @return 是或否 | yes or no
 */
+ (BOOL)hearRateDataInfoStructToModel:(void *)data;

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
 * @return 一天心率数据的集合和详情数据 | Collection of day heart rate data and details data
 */
+ (__kindof IDOSyncHrDataInfoBluetoothModel *)queryOneDayHearRatesDetailWithMac:(NSString *)macAddr
                                                                           year:(NSInteger)year
                                                                          month:(NSInteger)month
                                                                            day:(NSInteger)day;

/**
 * @brief 查询所有心率数据 心率包个数大于0 | Query all heart rate data The number of heart rate packets is greater than 0
 * @param macAddr mac 地址 | mac address
 * @return 所有心率数据的集合和详情数据 | Collection of all heart rate data and details data
 */
+ (NSArray <__kindof IDOSyncHrDataInfoBluetoothModel *>*)queryAllHearRatesWithMac:(NSString *)macAddr;

@end

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
 * @brief 初始化同步的睡眠数据模型 (内部使用) | Initialize synchronized sleep data model (internal use)
 * @param data 睡眠结构体数据 | Sleep Structure Data
 * @return 是或否 | yes or no
 */
+ (BOOL)sleepDataInfoStructToModel:(void *)data;

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
 * @return 一天睡眠数据的集合和详情数据 | Collection of daily sleep data and detailed data
 */
+ (__kindof IDOSyncSleepDataInfoBluetoothModel *)queryOneDaySleepsDetailWithMac:(NSString *)macAddr
                                                                           year:(NSInteger)year
                                                                          month:(NSInteger)month
                                                                            day:(NSInteger)day;

/**
 * @brief 查询所有睡眠数据 睡眠时长大于0 | Query all sleep data Sleep duration is greater than 0
 * @param macAddr mac 地址 | mac address
 * @return 所有睡眠数据的集合和详情数据 | Collection and details of all sleep data
 */
+ (NSArray <__kindof IDOSyncSleepDataInfoBluetoothModel *>*)queryAllSleepsWithMac:(NSString *)macAddr;

@end

@interface IDOSyncSportDataItemInfoBluetoothModel : IDOBluetoothBaseModel

/**
 运动模式 | Sports mode
 */
@property (nonatomic,assign) NSInteger mode;

/**
 运动步数 | Number of steps
 */
@property (nonatomic,assign) NSInteger sportCount;

/**
 活跃时间 | Active time
 */
@property (nonatomic,assign) NSInteger activeTime;

/**
 卡路里 | Calories
 */
@property (nonatomic,assign) NSInteger calories;

/**
 运动距离 | Sport distance
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
 * @brief 初始化同步的运动数据模型 (内部使用) | Initialize synchronized motion data model (internal use)
 * @param data 运动结构体数据 | Sports Structure Data
 * @return 是或否 | yes or no
 */
+ (BOOL)sportDataInfoStructToModel:(void *)data;

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
 * @return 一天运动数据的集合和详情数据 | Collection of daily exercise data and detailed data
 */
+ (__kindof IDOSyncSportDataInfoBluetoothModel *)queryOneDaySportDetailWithMac:(NSString *)macAddr
                                                                          year:(NSInteger)year
                                                                         month:(NSInteger)month
                                                                           day:(NSInteger)day;

/**
 * @brief 查询所有运动数据 步数大于0 | Query all motion data Steps greater than 0
 * @param macAddr mac 地址 | mac address
 * @return 所有运动数据的集合和详情数据 | Collection and detailed data of all sports data
 */
+ (NSArray <__kindof IDOSyncSportDataInfoBluetoothModel *>*)queryAllSportsWithMac:(NSString *)macAddr;

@end

@interface IDOSyncGpsDataItemInfoBluetoothModel : IDOBluetoothBaseModel

/**
 序列号 | Serial number
 */
@property (nonatomic,assign) NSInteger serialNumber;

/**
 经度 | Longitude
 */
@property (nonatomic,copy) NSString * latitudeStr;

/**
 纬度 | Latitude
 */
@property (nonatomic,copy) NSString * longitudeStr;

/**
  * 发起运动时间 时间戳 精确到秒 time interval since 1970 (如:1444361933)
  * Initiate exercise time Timestamp time interval since 1970 (eg 14442361933)
 */
@property (nonatomic,copy) NSString * timeStr;

/**
 日期 精确到日期 date interval since 1970 (如:1444361933) | date interval since 1970 (eg: 14443361933)
 */
@property (nonatomic,copy) NSString * dateStr;

@end


@interface IDOSyncGpsDataInfoBluetoothModel : IDOBluetoothBaseModel

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
 时 | hour
 */
@property (nonatomic,assign) NSInteger hour;

/**
 分 | minutes
 */
@property (nonatomic,assign) NSInteger minute;

/**
 秒 | seconds
 */
@property (nonatomic,assign) NSInteger second;

/**
 * 发起运动时间 时间戳 精确到秒 time interval since 1970 (如:1444361933)
 * Initiate exercise time Timestamp time interval since 1970 (eg 14442361933)
 */
@property (nonatomic,copy) NSString * timeStr;

/**
 日期 精确到日期 date interval since 1970 (如:1444361933) | date interval since 1970 (eg: 14443361933)
 */
@property (nonatomic,copy) NSString * dateStr;

/**
 gps数据包数量 | gps packet number
 */
@property (nonatomic,assign) NSInteger itemsCount;

/**
 间隔时长 | Interval length
 */
@property (nonatomic,assign) int interval;

/**
 运动发起端 (1 : 手环发起 0 : app发起) | Sports Initiator (1 : Bracelet Initiation  0 : app initiated)
 */
@property (nonatomic,assign) NSInteger startFrom;

/**
 * GPS 坐标点集合 只有定义好的查询方法才能转成model集合，自定义的查询方法无法直接转成model集合，需要再查询itemModel赋给当前属性
 * GPS coordinate point set Only defined query methods can be converted into model collections. Custom query methods cannot be directly
 * converted into model collections. You need to query itemModel to assign current attributes.
 */
@property (nonatomic,copy) NSArray <IDOSyncGpsDataItemInfoBluetoothModel *>* gpsItems;

/**
 * @brief 初始化同步的GPS数据模型 (内部使用) | Initialize synchronized GPS data model (internal use)
 * @param data GPS data 结构体数据 | data GPS data structure data
 * @param head GPS head 结构体数据 | data GPS head structure data
 * @param count GPS count 个数 | data GPS count 
 * @return 是或否 | yes or no
 */
+ (BOOL)gpsDataInfoStructToModel:(void *)data
                            head:(const void *)head
                        gpsCount:(uint32_t)count;

/**
 * @brief 根据时间戳查询某个活动的GPS信息 | Querying the GPS information of an activity based on the timestamp
 * @param timeStr 时间戳  time interval since 1970 (如:1444361933) | Timestamp time interval since 1970 (eg: 14443361933)
 * @param macAddr mac 地址 | mac address
 * @return gps信息数据 坐标item对象集合 | gps information data coordinate item object collection
 */
+ (__kindof IDOSyncGpsDataInfoBluetoothModel *)queryOneActivityCoordinatesWithTimeStr:(NSString *)timeStr
                                                                              macAddr:(NSString *)macAddr;

/**
 * @brief 根据时间戳查询某个活动是否存在轨迹 | Query whether an activity has a track based on a timestamp
 * @param timeStr 时间戳  time interval since 1970 (如:1444361933) | Timestamp time interval since 1970 (eg: 14443361933)
 * @param macAddr mac 地址 | mac address
 * @return 是否存在轨迹 yes or no | Is there a track?
 */
+ (BOOL)queryActivityHasCoordinatesWithTimeStr:(NSString *)timeStr
                                       macAddr:(NSString *)macAddr;

@end

@interface IDOSyncInfoBluetoothModel : IDOBluetoothBaseModel

@end

