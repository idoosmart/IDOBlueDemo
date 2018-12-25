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
 GPS 开始同步
 */
+ (void)startSync;

/**
 GPS 停止同步
 */
+ (void)stopSync;

/**
 GPS 同步进度

 @param callback 进度回调
 */
+ (void)syncGpsDataProgressCallback:(void(^_Nullable)(int progress))callback;

/**
 GPS 同步完成

 @param callback 完成回调
 */
+ (void)syncGpsDataCompleteCallback:(void(^_Nullable)(int errorCode))callback;

/**
 GPS 同步日志
 
 @param callback 日志回调
 */
+ (void)syncGpsLogCallback:(void(^_Nullable)(NSString * _Nullable logStr))callback;

@end
