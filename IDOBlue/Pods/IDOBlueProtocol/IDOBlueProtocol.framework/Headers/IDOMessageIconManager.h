//
//  IDOMessageIconManager.h
//  IDOBlueProtocol
//
//  Created by hedongyang on 2021/8/2.
//  Copyright © 2021 何东阳. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol IDOMessageIconManagerDelegate <NSObject>

@optional
/**
 处理应用图标和名字日志回调
 */
- (void)handleIconLogMessage:(NSString *)message;
/**
 处理完成应用图标和名字回调
 */
- (void)handleIconAndNameComplete;

@end

@interface IDOMessageIconManager : NSObject

//代理对象
@property (nonatomic,weak) id<IDOMessageIconManagerDelegate> delegate;

//处理完成应用图标和名字block回调
@property (nonatomic,copy) void(^handleIconAndNameComplete)(void);

//base url 地址 如果未赋值则走Apple 接口
@property (nonatomic,copy) NSString * baseUrlPath;

//初始化消息通知图标和名字更新
+ (instancetype)listenForUpdate;

//主动获取图标和名字
- (BOOL)getAppIconAndName;

@end

NS_ASSUME_NONNULL_END
