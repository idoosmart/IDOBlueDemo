//
//  IDOSleepModel.h
//  IDOEducation
//
//  Created by 农大浒 on 2019/12/11.
//  Copyright © 2019 TigerNong. All rights reserved.
//

// 每一种睡眠状态的数据模型

#import <Foundation/Foundation.h>
#import "IDOChartCommonHeader.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IDOSleepItemModel : NSObject
/**
 睡眠类型
 */
@property (nonatomic,assign) IDOSleepType sleep_status;

/**
 睡眠时长
 */
@property (nonatomic, assign) NSInteger duration;

/**
 各种睡眠类型的开始时间（传入时分即可，主要用于当点击对应的类型时，显示出该睡眠类型的开始时间）
 */
@property (nonatomic, copy) NSString *startTimeStr;

/**
 各种睡眠类型的结束时间（传入时分即可，主要用于当点击对应的类型时，显示出该睡眠类型的结束时间）
 */
@property (nonatomic, copy) NSString *endTimeStr;

/**
 对应睡眠模型显示的颜色
 */
@property (nonatomic, strong) UIColor *color;

@end

NS_ASSUME_NONNULL_END
