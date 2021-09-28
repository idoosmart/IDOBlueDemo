//
//  IDOSportIconManager.h
//  IDOBlueProtocol
//
//  Created by hedongyang on 2021/8/24.
//  Copyright © 2021 何东阳. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol IDOSportIconManagerDelegate <NSObject>

//传输进度
- (void)sportIconTransferProgress:(float)progress;

//传输完成 非0为错误 错误码和错误日志
- (void)sportIconTransferComplete:(int)errorCode
                          message:(NSString *)message;

@end


@interface IDOSportIconManager : NSObject

//运动图标传输对象集合
@property (nonatomic,copy) NSArray <IDOSportIconModel *>* iconModels;

//运动图标传输代理对象
@property (nonatomic,weak) id<IDOSportIconManagerDelegate> delegate;

//单例
+ (instancetype)shareInstance;

//开始传输
- (void)startTransfer;

@end

NS_ASSUME_NONNULL_END
