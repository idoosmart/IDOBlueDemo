//
//  IDOStatisticsManager.h
//  IDOBlueProtocol
//
//  Created by hedongyang on 2022/4/15.
//  Copyright © 2022 何东阳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IDOBlueProtocol/IDOStatisticsModel.h>

NS_ASSUME_NONNULL_BEGIN

@protocol IDOStatisticsManagerDelegate <NSObject>

//设备统计数据返回
- (void)getDeviceStatisticsData:(IDOUserHabitModel *)model
                      errorCode:(int)errorCode;


@end

@interface IDOStatisticsManager : NSObject

//单例
+ (instancetype)shareInstance;
//行为统计获取代理对象
@property (nonatomic,weak)id<IDOStatisticsManagerDelegate> delegate;

//获取统计数据
+ (BOOL)getStatisticsData;

@end

NS_ASSUME_NONNULL_END
