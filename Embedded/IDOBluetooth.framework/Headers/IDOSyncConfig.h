//
//  IDOSyncConfigManager.h
//  VeryfitSDK
//
//  Created by hedongyang on 2018/5/25.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface IDOSyncConfig : NSObject

/**
 配置 开始同步
 */
+ (void)startSync;

/**
 配置 停止同步
 */
+ (void)stopSync;

/**
 闹钟 同步进度 (暂时不能使用)
 
 @param callback 进度回调
 */
+ (void)syncAlarmsProgressCallback:(void(^_Nullable)(int progress))callback;

/**
 闹钟 同步完成 (暂时不能使用)
 
 @param callback 完成回调
 */
+ (void)syncAlarmsCompleteCallback:(void (^_Nullable)(int errorCode))callback;

/**
 配置 同步进度
 
 @param callback 进度回调
 */
+ (void)syncConfigProgressCallback:(void(^_Nullable)(int progress))callback;

/**
 配置 同步完成
 
 @param callback 完成回调
 */
+ (void)syncConfigCompleteCallback:(void(^_Nullable)(int errorCode))callback;

/**
 配置 同步日志
 
 @param callback 日志回调
 */
+ (void)syncConfigLogCallback:(void(^_Nullable)(NSString * _Nullable logStr))callback;

@end
