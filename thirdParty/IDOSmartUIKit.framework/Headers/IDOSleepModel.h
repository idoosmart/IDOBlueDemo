//
//  IDOSleepModel.h
//  IDOEducation
//
//  Created by 农大浒 on 2019/12/11.
//  Copyright © 2019 TigerNong. All rights reserved.
//

// 每一次睡眠的数据模型

#import <Foundation/Foundation.h>
#import "IDOSleepItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface IDOSleepModel : NSObject

/**
 入睡的时间（用于显示x轴开始的时间），只需传入时分
 */
@property (nonatomic, copy) NSString *sleepTimeStr;

/**
 入睡的时间戳，这个主要是用来比较当天的入睡最早的一次，用来显示时间
 */
@property (nonatomic, assign) NSInteger sleepTime;

/**
 醒来的时间戳（用于显示x轴结束的时间），只需传入时分
 */
@property (nonatomic, copy) NSString *wakeUpTimeStr;

/**
 醒来的时间戳，这个主要是用来比较当天的醒来的一次，用来显示时间
 */
@property (nonatomic, assign) NSInteger wakeUpTime;

/**
 总的睡眠时间（用于进行宽度的确认）
 */
@property (nonatomic, assign) NSInteger total_sleep_mins;

/**
 深睡总的时间
 */
@property (nonatomic, assign) NSInteger deep_sleep_mins;

/**
 浅睡总的时间
 */
@property (nonatomic, assign) NSInteger light_sleep_mins;

/**
 在当次入睡与醒来的时间范围内的睡眠情况
 */
@property (nonatomic,strong) NSArray <IDOSleepItemModel *> *sleepItems;

@end

NS_ASSUME_NONNULL_END
