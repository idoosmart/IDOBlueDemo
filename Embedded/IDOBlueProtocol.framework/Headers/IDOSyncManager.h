//
//  IDOSyncManager.h
//  VeryfitSDK
//
//  Created by hedongyang on 2018/5/25.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#if __has_include(<IDOBluetoothInternal/IDOBluetoothInternal.h>)
#elif __has_include(<IDOBlueProtocol/IDOBlueProtocol.h>)
#else
#import "IDOSyncEnum.h"
#endif

@interface IDOSyncManager : NSObject

/**
 * 当前连接设备是否正在同步,⚠️配置同步不纳入正在同步中,其他(步数、心率、血压、睡眠、血氧、压力、活动、gps、游泳)数据同步纳入其中
 * Whether the currently connected device is synchronizing, ⚠️ configuration synchronization is not included in the synchronization,
 * and other (step, heart rate, blood pressure, sleep, activity, gps、swim) data synchronization is included.
 */
@property (nonatomic,assign,readonly) BOOL isSyncHealthRun;

/**
 * 当前连接设备是否在同步配置信息
 * Is the currently connected device synchronizing configuration information?
 */
@property (nonatomic,assign,readonly) BOOL isSyncConfigRun;

/**
 * 当前连接设备是否需要同步配置
 * Does the current connected device require synchronization configuration?
 */
@property (nonatomic,assign,readonly) BOOL isNeedSyncConfig;

/**
 * 设置需要同步的选项(同步配置、同步健康、同步活动、同步GPS)
 * Set the options that need to be synchronized (sync config、sync health、sync activity、sync GPS)
 */
@property (nonatomic,assign) IDO_WANT_TO_SYNC_ITEM_TYPE wantToSyncType;

/**
 * 同步的数据是否存入SDK数据库中,默认YES
 * Whether the synchronized data is stored in the SDK database, the default is YES
 */
@property (nonatomic,assign) BOOL isSave;

/**
 * 同步的数据超时时长，默认 60秒
 * Synchronous data timeout duration, default 60 seconds
 */
@property (nonatomic,assign) NSInteger syncTimeout;

/**
 * 同步配置日志回调
 * Synchronize configuration log callback
 */
@property (nonatomic,copy,nullable) IDOSyncManager *_Nonnull(^addSyncConfig)(void(^ _Nullable configLogCallback)(NSString * _Nullable logStr));

/**
 * 同步健康心率数据回调
 * Synchronize healthy heart rate data callback
 */
@property (nonatomic,copy,nullable) IDOSyncManager *_Nonnull(^addSyncHeartRate)(void(^ _Nullable heartRateDataCallback)(NSString * _Nullable jsonStr));

/**
 * 同步健康睡眠数据回调
 * Synchronize healthy sleep data callback
 */
@property (nonatomic,copy,nullable) IDOSyncManager *_Nonnull(^addSyncSleep)(void(^ _Nullable sleepDataCallback)(NSString * _Nullable jsonStr));

/**
 * 同步健康步数数据回调
 * Synchronize health step data callback
 */
@property (nonatomic,copy,nullable) IDOSyncManager *_Nonnull(^addSyncSport)(void(^ _Nullable sportDataCallback)(NSString * _Nullable jsonStr));

/**
 * 同步健康血压数据回调
 * Synchronize healthy blood pressure data callback
 */
@property (nonatomic,copy,nullable) IDOSyncManager *_Nonnull(^addSyncBp)(void(^ _Nullable bpDataCallback)(NSString * _Nullable jsonStr));

/**
 * 同步活动数据回调
 * Synchronize active data callbacks
 */
@property (nonatomic,copy,nullable) IDOSyncManager *_Nonnull(^addSyncActivity)(void(^ _Nullable activityDataCallback)(NSString * _Nullable jsonStr));

/**
 * 同步gps数据回调
 * Synchronize GPS data callbacks
 */
@property (nonatomic,copy,nullable) IDOSyncManager *_Nonnull(^addSyncGps)(void(^ _Nullable gpsDataCallback)(NSString * _Nullable jsonStr));

/**
 * 同步游泳数据回调
 * Synchronize swim data callback
 */
@property (nonatomic,copy,nullable) IDOSyncManager *_Nonnull(^addSyncSwim)(void(^ _Nullable swimCallback)(NSString * _Nullable jsonStr));

/**
 * 同步健康血氧数据回调
 * Synchronize healthy blood oxygen data callback
 */
@property (nonatomic,copy,nullable) IDOSyncManager *_Nonnull(^addSyncBloodOxygen)(void(^ _Nullable bloodOxygenDataCallback)(NSString * _Nullable jsonStr));

/**
 * 同步压力数据回调
 * Synchronize pressure data callback
 */
@property (nonatomic,copy,nullable) IDOSyncManager *_Nonnull(^addSyncPressure)(void(^ _Nullable pressureCallback)(NSString * _Nullable jsonStr));

/**
 * 同步统一进度回调
 * Synchronize unified progress callback
 */
@property (nonatomic,copy,nullable) IDOSyncManager *_Nonnull(^addSyncProgess)(void(^ _Nullable syncProgessCallback)(IDO_CURRENT_SYNC_TYPE type,float progress));

/**
 * 同步完成回调
 * Synchronize completes the callback
 */
@property (nonatomic,copy,nullable) IDOSyncManager *_Nonnull(^addSyncComplete)(void(^ _Nullable syncCompleteCallback)(IDO_SYNC_COMPLETE_STATUS stateCode));

/**
 * 同步失败回调  如: 超时、断线、OTA
 * Synchronize failed callback eg: timeout, disconnect, OTA
 */
@property (nonatomic,copy,nullable) IDOSyncManager *_Nonnull(^addSyncFailed)(void(^ _Nullable syncFailedCallback)(int errorCode));

/**
 * 删除当天数据回调
 * Delete current day data callback
 */
@property (nonatomic,copy,nullable) IDOSyncManager *_Nonnull(^deleteCurrentDayData)(void(^ _Nullable deleteCallback)(BOOL success));

/**
 * 强制执行或不执行同步配置
 * Enforce or not enforce the synchronize configuration
 */
@property (nonatomic,copy,nullable) IDOSyncManager *_Nonnull(^mandatorySyncConfig)(BOOL isSync);

/**
 * 初始化同步单例对象
 * init sync manager
 */
IDOSyncManager * _Nonnull initSyncManager(void);

/**
 开始同步 | Start sync
 */
+ (void)startSync;

/**
 结束同步 | End sync
 */
+ (void)stopSync;

@end
