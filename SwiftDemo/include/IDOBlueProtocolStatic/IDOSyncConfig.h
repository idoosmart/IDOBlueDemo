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
 初始化同步配置协议命令(内部使用) | init sync config protocol command
 */
+ (void)idoProtocolSyncConfigInit;

/**
 配置 开始同步 | Configuration Start syncing
 */
+ (void)startSync;

/**
 配置 停止同步 | Configuration Stop Synchronization
 */
+ (void)stopSync;

/**
 当前同步配置是否在运行 | get current sync config is run
 */
+ (BOOL)getSyncConfigRun;

/**
 * @brief 闹钟 同步进度 (0-100) (暂时不能使用) | Alarm clock Synchronization progress (0-100) (not available at the moment)
 * @param callback 进度回调 | Progress callback
 */
+ (void)syncAlarmsProgressCallback:(void(^_Nullable)(int progress))callback;

/**
 * @brief 闹钟 同步完成 (暂时不能使用) | Alarm clock sync completed (not available for the time being)
 * @param callback 完成回调 | Complete callback
 */
+ (void)syncAlarmsCompleteCallback:(void (^_Nullable)(int errorCode))callback;

/**
 * @brief 配置 同步进度（0-100）| Configuration Synchronization progress （0-100）
 * @param callback 进度回调 | Progress callback
 */
+ (void)syncConfigProgressCallback:(void(^_Nullable)(int progress))callback;

/**
 * @brief 配置 同步完成 | Configuration Synchronization completed
 * @param callback 完成回调 | Complete callback
 */
+ (void)syncConfigCompleteCallback:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 配置 同步日志 | Configuration Synchronization log
 * @param callback 日志回调 | logStr callback
 */
+ (void)syncConfigLogCallback:(void(^_Nullable)(NSString * _Nullable logStr))callback;

@end
