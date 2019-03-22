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
 * @brief 血氧、压力 同步数据 | Blood oxygen, pressure Synchronization data
 * @param callback 数据回调 | jsonStr callback
 */
+ (void)syncBloodOxygenPressureDataCallback:(void(^_Nullable)(NSString * _Nullable jsonStr))callback;

@end

