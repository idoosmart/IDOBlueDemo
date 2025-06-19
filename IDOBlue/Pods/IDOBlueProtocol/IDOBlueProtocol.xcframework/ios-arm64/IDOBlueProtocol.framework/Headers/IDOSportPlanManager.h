//
//  IDOSportPlanManager.h
//  IDOBlueProtocol
//
//  Created by hedongyang on 2022/4/20.
//  Copyright © 2022 何东阳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IDOBlueProtocol/IDOSportPlanDataModel.h>

NS_ASSUME_NONNULL_BEGIN

@protocol IDOSportPlanManagerDelegate <NSObject>

//运动计划操作完成回调
- (void)sportPlanOperateComplete:(int)errorCode
                       planModel:(IDOSportPlanDataModel *)model;
@end


@interface IDOSportPlanManager : NSObject

//代理对象
@property (nonatomic,weak) id<IDOSportPlanManagerDelegate> delegate;

//单例
+ (instancetype)shareInstance;

//开始计划
+ (BOOL)startSportPlan:(IDOSportPlanDataModel *)model;

//计划数据下发
+ (BOOL)setSportPlan:(IDOSportPlanSetDataModel *)model;

//结束运动计划
+ (BOOL)endSportPlan:(IDOSportPlanDataModel *)model;

//查询运动计划
+ (BOOL)querySportPlan;

@end

NS_ASSUME_NONNULL_END
