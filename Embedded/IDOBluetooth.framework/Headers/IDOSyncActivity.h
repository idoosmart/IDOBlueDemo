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
 活动 开始同步
 */
+ (void)startSync;

/**
 活动 停止同步
 */
+ (void)stopSync;

/**
 活动 同步进度 (1-100)
 
 @param callback 进度回调
 */
+ (void)syncAcitvityDataProgressCallback:(void(^_Nullable)(int progress))callback;

/**
 活动 同步完成
 
 @param callback 完成回调
 */
+ (void)syncAcitvityDataCompleteCallback:(void(^_Nullable)(int errorCode))callback;

/**
 活动 同步日志

 @param callback 日志回调
 */
+ (void)syncActivityLogCallback:(void(^_Nullable)(NSString * _Nullable logStr))callback;


@end
