//
//  IDOSyncBreathRateDataModel.h
//  IDOBlueProtocol
//
//  Created by hedongyang on 2022/4/26.
//  Copyright © 2022 何东阳. All rights reserved.
//

#import <IDOBlueProtocol/IDOBlueProtocol.h>

NS_ASSUME_NONNULL_BEGIN

@interface IDOSyncBreathRateDataModel : IDOBluetoothBaseModel
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
@property (nonatomic,copy)   NSString * dateStr;

/**
 详情的个数
 */
@property (nonatomic,assign) NSInteger itemCount;

/**
 * 呼吸率集合 @[{@"offset":@(0),@"value":@(0)}...]
 * value：呼吸率
 * offset ：基于0点偏移量 (秒钟)
 */
@property (nonatomic,copy) NSArray <NSDictionary *>* breathRates;


@end

NS_ASSUME_NONNULL_END
