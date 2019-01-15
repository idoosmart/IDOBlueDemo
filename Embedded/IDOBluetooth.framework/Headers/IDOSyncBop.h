//
//  IDOSyncBop.h
//  IDOBluetooth
//
//  Created by 何东阳 on 2019/1/8.
//  Copyright © 2019年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDOSyncBop : NSObject

/**
 血氧、压力 开始同步 | Blood oxygen, pressure Start syncing
 */
+ (void)startSync;

/**
 血氧、压力 停止同步 | Blood oxygen, pressure Stop syncing
 */
+ (void)stopSync;

/**
 * @brief 血氧、压力 同步进度 | Blood oxygen, pressure Synchronization progress
 * @param callback 进度回调 | Progress callback
 */
+ (void)syncBloodOxygenPressureDataProgressCallback:(void(^_Nullable)(int progress))callback;

/**
 * @brief 血氧、压力 同步完成 | Blood oxygen, pressure Synchronization completed
 * @param callback 完成回调 | Complete callback
 */
+ (void)syncBloodOxygenPressureDataCompleteCallback:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief 血氧、压力 同步日志 | Blood oxygen, pressure Synchronization Log
 * @param callback 日志回调 | Log callback
 */
+ (void)syncBloodOxygenPressureLogCallback:(void(^_Nullable)(NSString * _Nullable logStr))callback;

@end

