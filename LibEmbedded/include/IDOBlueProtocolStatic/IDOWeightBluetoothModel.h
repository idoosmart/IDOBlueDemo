//
//  IDOWeightBluetoothModel.h
//  IDOBluetooth
//
//  Created by 何东阳 on 2018/10/27.
//  Copyright © 2018年 apple. All rights reserved.
//

#if __has_include(<IDOBluetoothInternal/IDOBluetoothInternal.h>)
#elif __has_include(<IDOBlueProtocol/IDOBlueProtocol.h>)
#else
#import "IDOBluetoothBaseModel.h"
#endif

@interface IDOWeightBluetoothModel : IDOBluetoothBaseModel

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

/*
 * 日期时间戳 time interval since 1970 (如:1444361933)
 * Date Timestamp  time interval since 1970 (eg 14442361933)
 */
@property (nonatomic,copy) NSString * dateStr;

/*
 * 时间戳 time interval since 1970 (如:1444361933)
 * Timestamp time interval since 1970 (eg: 14443361933)
 */
@property (nonatomic,copy) NSString * timeStamp;

/*
 体重值 | Weight value
 */
@property (nonatomic,copy) NSString * weightValue;

/*
 体重单位 0是磅 1是公斤  | Weight unit  0 is pound  1 is kg
 */
@property (nonatomic,copy) NSString * weightUnit;

/*
 最后一次记录的体重单位 0是磅 1是公斤 | Last recorded weight unit   0 is pound 1 is kg
 */
@property (nonatomic,copy) NSString * lastWeightUnit;

/*
 最后一次记录的体重 | Last recorded weight
 */
@property (nonatomic,copy) NSString * lastWeightValue;

/*
 手动输入？ | Manual input
 */
@property (nonatomic,assign) BOOL isHandsRecord;

/*
 BMI
 */
@property (nonatomic,copy) NSString * bmi;

/*
 体脂率 | Body fat rate
 */
@property (nonatomic,copy) NSString * bodyFat;

/*
 内脏脂肪 | Visceral fat
 */
@property (nonatomic,copy) NSString * visFat;

/*
 体水分 | Body water
 */
@property (nonatomic,copy) NSString * water;

/*
 蛋白质 | Protein
 */
@property (nonatomic,copy) NSString * protein;

/*
 骨量 | Bone mass
 */
@property (nonatomic,copy) NSString * bone;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOUserWeightModel
 */
+ (__kindof IDOWeightBluetoothModel *)currentModel;

/**
 * @brief 查询指定日期前七次体重数据，如果没有数据会初始化体重为0的数据对象
 * Query the weight data seven times before the specified date, if there is no data, initialize the data object with weight 0
 * @return IDOUserWeightModel
 */
+ (NSArray <__kindof IDOWeightBluetoothModel *>*)querySevenTimesRecentlyWithDateStr:(NSString *)dateStr;

/**
 * @brief 查询当前设备某天体重详情数据 | Query current device weight data for one day
 * @param year 年份  | year
 * @param month 月份 | month
 * @param day 日期   | day
 * @return 体重详情数据 | Weight details data
 */
+ (__kindof IDOWeightBluetoothModel *)queryOneDayDataWithYear:(NSInteger)year
                                                        month:(NSInteger)month
                                                          day:(NSInteger)day;

@end
