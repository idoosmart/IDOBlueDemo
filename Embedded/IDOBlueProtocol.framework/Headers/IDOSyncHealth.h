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
 初始化同步健康协议命令(内部使用) | init sync health protocol command
 */
+ (void)idoProtocolSyncHealthInit;

/**
 健康 开始同步 | Health Start syncing
 */
+ (void)startSync;

/**
 健康 停止同步 | Health Stop syncing
 */
+ (void)stopSync;

/**
 当前同步健康是否在运行 | get current sync health is run
 */
+ (BOOL)getSyncHealthRun;

/**
 * 删除当天健康数据 | delete current day health data
 * ⚠️只有在解绑手环时作删除操作 | only when unbundling bracelets for deletion
 */
+ (void)deleteHealthCurrentDayData;

/**
 * @brief 健康 同步进度 | Health Synchronization progress
 * @param callback 进度回调 | Progress callback
 */
+ (void)syncHealthDataProgressCallback:(void(^_Nullable)(int progress))callback;

/**
 * @brief 健康 同步完成 | Health Synchronization completed
 * @param callback 完成回调 | Complete callback
 */
+ (void)syncHealthDataCompleteCallback:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 健康 同步数据 | Health Synchronization data
 * @param callback 健康数据回调 | jsonStr callback
 */
+ (void)syncHealthDataCallback:(void(^_Nullable)(NSString * _Nullable jsonStr))callback;

@end
