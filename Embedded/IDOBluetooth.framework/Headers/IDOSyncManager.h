//
//  IDOSyncManager.h
//  VeryfitSDK
//
//  Created by hedongyang on 2018/5/25.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IDOBluetooth/IDOEnum.h>


@interface IDOSyncManager : NSObject

/**
 同步状态 | Synchronization status
 */
@property (nonatomic,assign,readonly) IDO_SYNC_COMPLETE_STATUS syncStatus;

/**
 当前同步类型 | Current sync type
 */
@property (nonatomic,assign,readonly) IDO_CURRENT_SYNC_TYPE syncType;

/**
 * 当前连接设备是否正在同步,⚠️配置同步不纳入正在同步中,其他(步数、心率、血压、睡眠、血氧、压力、活动、gps)数据同步纳入其中
 * Whether the currently connected device is synchronizing, ⚠️ configuration synchronization is not included in the synchronization,
 * and other (step, heart rate, blood pressure, sleep, activity, gps) data synchronization is included.
 */
@property (nonatomic,assign,readonly) BOOL isSyncing;

/**
 当前连接设备是否在同步配置信息 | Is the currently connected device synchronizing configuration information?
 */
@property (nonatomic,assign,readonly) BOOL isSyncConfigRun;

/**
 * @brief 初始化同步管理对象 | Initialize synchronization management object
 * @param isSave 同步的数据是否存入SDK数据库中
 * @return IDOSyncManager
 */
IDOSyncManager * _Nonnull instanceSyncManagerHandler(BOOL isSave);

/**
 * @brief 同步完成,每同步完一项会回调一次 请根据上述枚举进行判断是否同步完成
 * stateInfo : 从同步开始到同步结束,返回每项同步的状态信息,每项同步会累加记录,告知哪项成果或失败了
 * Synchronization is completed, and each synchronization will be called once. Please judge whether it is synchronized according to the above enumeration.
 * stateInfo : Returns the status information of each synchronization from the start of synchronization to the end of synchronization.
 * Each synchronization will accumulate records to tell which results or failed.
 * @param callback 完成回调block | Complete callback block
 * @param failCallback 失败错误回调block | Failed error callback block
 */

+ (void)syncDataCompleteCallback:(void (^)(IDO_SYNC_COMPLETE_STATUS stateCode, NSString * _Nullable stateInfo))callback
                    failCallback:(void (^)(int errorCode))failCallback;
/**
 * @brief 同步进度 *统一进度回调 0 ~ 1 | Synchronization progress, unified progress callback 0 ~ 1
 * @param callback 进度回调block | Progress callback block
 */
+ (void)syncDataProgressCallback:(void(^_Nullable)(float progress))callback;

/**
 * @brief 同步数据json格式 | Synchronization data
 * @param callback 同步数据回调block | jsonStr callback block
 */
+ (void)syncDataJsonCallback:(void(^_Nullable)(IDO_CURRENT_SYNC_TYPE syncType,NSString * _Nullable jsonStr))callback;

/**
 * 删除当前手环当天同步的数据
 * ⚠️只有在解绑手环时作删除操作
 */
+ (void)deleteSyncCurrentDayData;


/**
 开始同步 | Start syncing
 */
+ (void(^)(BOOL isConfig))startSync;

/**
 结束同步 | End synchronization
 */
+ (void)stopSync;

@end
