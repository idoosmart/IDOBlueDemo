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
 初始化同步血氧、压力协议命令(内部使用) | init sync blood oxygen protocol command
 */
+ (void)idoProtocolSyncBloodPressureInit;

/**
 血氧、压力 开始同步 | Blood oxygen, pressure Start syncing
 */
+ (void)startSync;

/**
 血氧、压力 停止同步 | Blood oxygen, pressure Stop syncing
 */
+ (void)stopSync;

/**
 当前同步血氧、压力是否在运行 | get current sync blood oxygen, pressure is run
 */
+ (BOOL)getSyncBpRun;

/**
 * @brief 血氧、压力 同步进度 (0-100) | Blood oxygen, pressure Synchronization progress (0-100)
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

