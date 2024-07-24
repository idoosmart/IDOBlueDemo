//
//  IDORunPlanModel.h
//  IDOVFHome
//
//  Created by mac2019 on 2022/5/27.
//

#import <Foundation/Foundation.h>

@class IDORunPlanWeekPlansModel;

NS_ASSUME_NONNULL_BEGIN

@interface IDORunPlanModel : NSObject

/**
 计划ID
 */
@property (nonatomic,assign) NSInteger planId;

/**
 目标类型 0 休息, 1 轻松跑,2 分段跑；3有氧基础跑；4有氧进阶跑；5 有氧耐力跑
 */
@property (nonatomic,assign) NSInteger targetType;

/**
 目标时长  当目标类型不为0时，有效
 */
@property (nonatomic,assign) NSInteger targetDurations;

/**
 1- 3公里；2- 5公里；3- 10公里
 */
@property (nonatomic,assign) NSInteger type;

/**
 当前进度，天数
 */
@property (nonatomic,assign) NSInteger actualProcess;

/**
 总进度，天数
 */
@property (nonatomic,assign) NSInteger totalProcess;

/**
 计划开始时间
 */
@property (nonatomic,strong) NSString *startDate;

/**
 计划结束时间
 */
@property (nonatomic,strong) NSString *endDate;

/**
 计划数组
 */
@property (nonatomic,strong) NSArray <IDORunPlanWeekPlansModel *>*weekPlans;

@end

@interface IDORunPlanWeekPlansModel : NSObject

/**
 日期
 */
@property (nonatomic,copy) NSString *date;

/**
 是否已经训练
 */
@property (nonatomic,assign) BOOL isTrain;

/**
 是否需要训练
 */
@property (nonatomic,assign) BOOL isTargetType;
/**
 是否已经训练完成
 */
@property (nonatomic,assign) BOOL isTrainComplete;

/**
 周
 */
@property (nonatomic,assign) NSInteger weekDay;

@end

NS_ASSUME_NONNULL_END
