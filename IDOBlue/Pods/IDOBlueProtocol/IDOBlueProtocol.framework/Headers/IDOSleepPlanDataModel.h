//
//  IDOSleepPlanDataModel.h
//  IDOBlueProtocol
//
//  Created by hedongyang on 2024/4/19.
//  Copyright © 2024 何东阳. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//睡眠计划启动时间
@interface IDOSleepPlanStartTimeModel : NSObject
//年
@property (nonatomic,assign) NSInteger year;
//月
@property (nonatomic,assign) NSInteger month;
//日
@property (nonatomic,assign) NSInteger day;
//时
@property (nonatomic,assign) NSInteger hour;
//分
@property (nonatomic,assign) NSInteger minute;
//秒
@property (nonatomic,assign) NSInteger second;

@end

//睡眠计划入睡目标时间
@interface IDOSleepPlanFallAsleepTimeModel : NSObject
//时
@property (nonatomic,assign) NSInteger hour;
//分
@property (nonatomic,assign) NSInteger minute;
//秒
@property (nonatomic,assign) NSInteger second;
@end

//睡眠计划起床目标时间
@interface IDOSleepPlanGetUpTimeModel : NSObject
//时
@property (nonatomic,assign) NSInteger hour;
//分
@property (nonatomic,assign) NSInteger minute;
//秒
@property (nonatomic,assign) NSInteger second;
@end

//睡眠计划
@interface IDOSleepPlanDataModel : NSObject
//睡眠计划协议版本，默认0
@property (nonatomic,assign) NSInteger planVersion;
//操作类型 0:无效 1:设置
@property (nonatomic,assign) NSInteger operate;
//是否有计划标志 0:当前无睡眠计划 1:APP有睡眠计划
@property (nonatomic,assign) BOOL isHavePlan;
//睡眠计划启动时间
@property (nonatomic,strong) IDOSleepPlanStartTimeModel * startTime;
//睡眠计划入睡目标时间
@property (nonatomic,strong) IDOSleepPlanFallAsleepTimeModel * asleepTime;
//睡眠计划起床目标时间
@property (nonatomic,strong) IDOSleepPlanGetUpTimeModel * getUpTime;
/*
入睡提醒时间
0:不提醒
1:入睡时提醒
2:15min
3:30min
4:45min
5:1h
6:1h30min
7:2h
*/
@property (nonatomic,assign) NSInteger reminderTime;
//起床闹钟开关
@property (nonatomic,assign) BOOL alarmOnOff;
//稍后提醒开关
@property (nonatomic,assign) BOOL laterReminderOnOff;
//稍后提醒间隔时长 单位秒
@property (nonatomic,assign) NSInteger laterReminderIntervalTime;
//重复提醒次数
@property (nonatomic,assign) NSInteger repeatReminderTime;

@end

NS_ASSUME_NONNULL_END
