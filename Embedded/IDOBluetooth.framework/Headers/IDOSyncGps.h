//
//  IDOSyncGPS.h
//  VeryfitSDK
//
//  Created by hedongyang on 2018/5/31.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface IDOSyncGps : NSObject

/**
 GPS 开始同步 | GPS starts syncing
 */
+ (void)startSync;

/**
 GPS 停止同步 | GPS stops syncing
 */
+ (void)stopSync;

/**
 * @brief GPS 同步进度 | GPS sync progress
 * @param callback 进度回调 | Progress callback
 */
+ (void)syncGpsDataProgressCallback:(void(^_Nullable)(int progress))callback;

/**
 * @brief GPS 同步完成 | GPS synchronization completed
 * @param callback 完成回调 | Complete callback
 */
+ (void)syncGpsDataCompleteCallback:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief GPS 同步数据 | GPS sync data
 * @param callback 数据回调 | callback jsonStr callback
 */
+ (void)syncGpsDataCallback:(void(^_Nullable)(NSString * _Nullable jsonStr))callback;

@end
