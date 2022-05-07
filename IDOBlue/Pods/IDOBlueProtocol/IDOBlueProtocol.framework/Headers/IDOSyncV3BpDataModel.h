//
//  IDOSyncV3BpDataModel.h
//  IDOBlueProtocol
//
//  Created by hedongyang on 2022/1/6.
//  Copyright © 2022 何东阳. All rights reserved.
//

#import <IDOBlueProtocol/IDOBlueProtocol.h>

NS_ASSUME_NONNULL_BEGIN

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

@end

NS_ASSUME_NONNULL_END
