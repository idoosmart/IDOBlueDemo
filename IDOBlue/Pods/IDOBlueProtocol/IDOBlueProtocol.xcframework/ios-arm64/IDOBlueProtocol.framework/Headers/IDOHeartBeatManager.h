//
//  IDOHeartBeatManager.h
//  IDOBlueProtocol
//
//  Created by huangkunhe on 2022/8/31.
//  Copyright © 2022 何东阳. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IDOHeartBeatManager : NSObject

+ (IDOHeartBeatManager *)shareInstance;

//定时器，间隔时间，默认10s一次，检测是否有跟蓝牙交互过数据
@property (nonatomic,assign) int timerCount;

//定时数据发送时间，默认30，就是定时器在30s后，没有跟蓝牙数据交互过，就需要向固件发送一条数据，防止，后台app给挂起
@property (nonatomic,assign) int heartBeatTimeCount;

//需要保活时间，默认3600秒（1小时）
@property (nonatomic,assign) int allLiveTimer;


//进入前台是否把后台模式关闭 （默认是YES，进去前台自动关闭）
@property (nonatomic,assign) BOOL isEndBackgroundTask;

//启动蓝牙心跳,进入后台后才会开始计时。每30秒获取一次数据交互
//进入后台后，会直接调用beginBackgroundTaskWithExpirationHandler
//进入前台后，会调用默认 endBackgroundTask，可使用isEndBackgroundTask控制
- (void)startHeartBeat;

//重新设置定时器的时间参数的话，需要调用这个方法重置一下定时器
- (void)reStartHeartBeat;

//取消定时器，取消后台保活机制
- (void)deallocHeartBeat;

@end

NS_ASSUME_NONNULL_END
