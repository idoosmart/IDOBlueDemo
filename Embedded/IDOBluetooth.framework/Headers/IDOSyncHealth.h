//
//  IDOSyncHeath.h
//  VeryfitSDK
//
//  Created by hedongyang on 2018/5/31.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDOSyncHealth : NSObject
/**
 健康 开始同步
 */
+ (void)startSync;

/**
 健康 停止同步
 */
+ (void)stopSync;

/**
 健康 同步进度
 
 @param callback 进度回调
 */
+ (void)syncHealthDataProgressCallback:(void(^_Nullable)(int progress))callback;

/**
 健康 同步完成
 
 @param callback 完成回调
 */
+ (void)syncHealthDataCompleteCallback:(void(^_Nullable)(int errorCode))callback;

/**
 健康 同步日志
 
 @param callback 日志回调
 */
+ (void)syncHealthLogCallback:(void(^_Nullable)(NSString * _Nullable logStr))callback;

@end
