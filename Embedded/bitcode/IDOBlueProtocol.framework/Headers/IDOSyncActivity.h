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
 初始化同步活动协议命令(内部使用) | init sync activity protocol command
 */
+ (void)idoProtocolSyncActivityInit;

/**
 活动 开始同步 | Activity Start syncing
 */
+ (void)startSync;

/**
 活动 停止同步 | Activity Stop syncing
 */
+ (void)stopSync;

/**
 当前同步活动是否在运行 | get current sync activity is run
 */
+ (BOOL)getSyncActivityRun;

/**
 * 删除当天活动数据 | delete current day activity data
 * ⚠️只有在解绑手环时作删除操作 | only when unbundling bracelets for deletion
 */
+ (void)deleteActivityCurrentDayData;

/**
 * @brief 活动 同步进度 (0-100) | Synchronization progress (0-100)
 * @param callback 进度回调 | Progress callback
 */
+ (void)syncAcitvityDataProgressCallback:(void(^_Nullable)(int progress))callback;

/**
 * @brief 活动 同步完成 | Activity Synchronization completed
 * @param callback 完成回调 | Complete callback
 */
+ (void)syncAcitvityDataCompleteCallback:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 活动 同步数据 | Activity Synchronization data
 * @param callback 数据回调 | jsonStr callback
 */
+ (void)syncActivityDataCallback:(void(^_Nullable)(NSString * _Nullable jsonStr))callback;


@end
