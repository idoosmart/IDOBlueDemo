//
//  IDOSyncActivity.h
//  VeryfitSDK
//
//  Created by hedongyang on 2018/5/29.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface IDOSyncActivity : NSObject
/**
 活动 开始同步 | Activity Start syncing
 */
+ (void)startSync;

/**
 活动 停止同步 | Activity Stop syncing
 */
+ (void)stopSync;

/**
 * @brief 活动 同步进度 (1-100) | Synchronization progress (1-100)
 * @param callback 进度回调 | Progress callback
 */
+ (void)syncAcitvityDataProgressCallback:(void(^_Nullable)(int progress))callback;

/**
 * @brief 活动 同步完成 | Activity Synchronization completed
 * @param callback 完成回调 | Complete callback
 */
+ (void)syncAcitvityDataCompleteCallback:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 活动 同步日志 | Activity Synchronization log
 * @param callback 日志回调 | Log callback
 */
+ (void)syncActivityLogCallback:(void(^_Nullable)(NSString * _Nullable logStr))callback;


@end
