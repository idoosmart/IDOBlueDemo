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
 配置 开始同步 | Configuration Start syncing
 */
+ (void)startSync;

/**
 配置 停止同步 | Configuration Stop Synchronization
 */
+ (void)stopSync;

/**
 * @brief 闹钟 同步进度 (暂时不能使用) | Alarm clock Synchronization progress (not available at the moment)
 * @param callback 进度回调 | Progress callback
 */
+ (void)syncAlarmsProgressCallback:(void(^_Nullable)(int progress))callback;

/**
 * @brief 闹钟 同步完成 (暂时不能使用) | Alarm clock sync completed (not available for the time being)
 * @param callback 完成回调 | Complete callback
 */
+ (void)syncAlarmsCompleteCallback:(void (^_Nullable)(int errorCode))callback;

/**
 * @brief 配置 同步进度 | Configuration Synchronization progress
 * @param callback 进度回调 | Progress callback
 */
+ (void)syncConfigProgressCallback:(void(^_Nullable)(int progress))callback;

/**
 * @brief 配置 同步完成 | Configuration Synchronization completed
 * @param callback 完成回调 | Complete callback
 */
+ (void)syncConfigCompleteCallback:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief  配置 同步日志 | Configuration Synchronization Log
 * @param callback 日志回调 | Log callback
 */
+ (void)syncConfigLogCallback:(void(^_Nullable)(NSString * _Nullable logStr))callback;

@end
