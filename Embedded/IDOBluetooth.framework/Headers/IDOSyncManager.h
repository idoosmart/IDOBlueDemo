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
 同步状态
 */
@property (nonatomic,assign,readonly) IDO_SYNC_COMPLETE_STATUS syncStatus;

/**
 当前同步类型
 */
@property (nonatomic,assign,readonly) IDO_CURRENT_SYNC_TYPE syncType;

/**
 当前连接设备是否正在同步,⚠️配置同步不纳入正在同步中,其他(步数、心率、血压、睡眠、活动、gps)数据同步纳入其中
 */
@property (nonatomic,assign,readonly) BOOL isSyncing;

/**
 当前连接设备是否在同步配置信息
 */
@property (nonatomic,assign,readonly) BOOL isSyncConfigRun;

/**
 初始化同步管理对象

 @return IDOSyncManager
 */
IDOSyncManager * _Nonnull instanceSyncManagerHandler(void);

/**
 同步完成,每同步完一项会回调一次 请根据上述枚举进行判断是否同步完成
 stateInfo : 从同步开始到同步结束,返回每项同步的状态信息,每项同步会累加记录,告知哪项成果或失败了

 @param callback 完成回调block
 @param failCallback 失败错误回调block
 */

+ (void)syncDataCompleteCallback:(void (^)(IDO_SYNC_COMPLETE_STATUS stateCode, NSString * _Nullable stateInfo))callback
                    failCallback:(void (^)(int errorCode))failCallback;
/**
 同步进度 *统一进度回调 0 ~ 1

 @param callback 进度回调block
 */
+ (void)syncDataProgressCallback:(void(^_Nullable)(float progress))callback;

/**
 同步日志信息

 @param callback 日志信息回调block
 */
+ (void)syncDataLogInfoCallback:(void(^_Nullable)(IDO_CURRENT_SYNC_TYPE syncType,NSString * _Nullable logStr))callback;


/**
 开始同步
 */
+ (void(^)(BOOL isConfig))startSync;

/**
 结束同步
 */
+ (void)stopSync;

@end
