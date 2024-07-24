//
//  IDOSleepPlanManager.h
//  IDOBlueProtocol
//
//  Created by hedongyang on 2024/4/19.
//  Copyright © 2024 何东阳. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol IDOSleepPlanManagerDelegate <NSObject>
//设置睡眠计划数据完成回调
- (void)setSleepPlanComplete:(int)errorCode;
@end

@interface IDOSleepPlanManager : NSObject

//代理对象
@property (nonatomic,weak) id<IDOSleepPlanManagerDelegate> delegate;

//单例
+ (instancetype)shareInstance;

//睡眠计划数据下发
+ (BOOL)setSleepPlan:(IDOSleepPlanDataModel*)model;

@end

NS_ASSUME_NONNULL_END
