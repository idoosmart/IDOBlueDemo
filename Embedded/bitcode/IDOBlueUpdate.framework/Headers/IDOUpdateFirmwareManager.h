//
//  IDOUpdateManager.h
//  IDOBluetooth
//
//  Created by hedongyang on 2018/9/14.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#if __has_include(<IDOBluetoothInternal/IDOBluetoothInternal.h>)
#elif __has_include(<IDOBlueUpdate/IDOBlueUpdate.h>)
#else
#import "IDOUpdateEnum.h"
#endif

@class IDOUpdateFirmwareManager;

@protocol IDOUpdateManagerDelegate<NSObject>

@required
/**
 * @brief 传入包的存放本地路径 | Local path to store incoming packets
 * @param manager 升级管理中心对象 | Upgrade Management Center Objects
 * @return 升级包的存放路径 | Upgrade package storage path
 */
- (NSString *_Nullable)currentPackagePathWithUpdateManager:(IDOUpdateFirmwareManager *_Nullable)manager;

/**
 * @brief  升级过程的进度 | Progress of the upgrade process
 * @param manager 升级管理中心对象 | Upgrade Management Center Objects
 * @param progress 进度 (0 ~ 1) | Progress (0 ~ 1)
 * @param message 升级日志信息 | Upgrade log information
 */
- (void)updateManager:(IDOUpdateFirmwareManager *_Nullable)manager
             progress:(float)progress
              message:(NSString *_Nullable)message;


/**
 * @brief 升级状态 | Upgrade status
 * @param manager 升级管理中心对象 | Upgrade Management Center Objects
 * @param state 状态值 | Status value
 */
- (void)updateManager:(IDOUpdateFirmwareManager *_Nullable)manager
                state:(IDO_UPDATE_STATE)state;


/**
 * @brief 升级过程报错 | The upgrade process is reporting an error
 * @param manager 升级管理中心对象 | Upgrade Management Center Objects
 * @param error 错误信息 | Error message
 */
- (void)updateManager:(IDOUpdateFirmwareManager *_Nullable)manager
          updateError:(NSError *_Nullable)error;


@optional
/**
 * @brief 传入固件包的类型 （SOFTDEVICE、BOOTLOADER、SOFTDEVICE_BOOTLOADER、APPLICATION）默认 APPLICATION 暂时不支持其他类型,只适合Nordic
 * Incoming firmware package type (SOFTDEVICE, BOOTLOADER, SOFTDEVICE_BOOTLOADER, APPLICATION) Default APPLICATION does not support other types,only suitable for Nordic
 * @param manager 升级管理中心对象 | Upgrade Management Center Objects
 * @return 固件包的类型 | Type of firmware package
 */
- (IDO_UPDATE_DFU_FIRMWARE_TYPE)selectDfuFirmwareTypeWithUpdateManager:(IDOUpdateFirmwareManager *_Nullable)manager;

@end


@interface IDOUpdateFirmwareManager : NSObject

/**
 设置代理 | Setting up the agent
 */
@property (nonatomic,weak,nullable) id <IDOUpdateManagerDelegate> delegate;

/**
 固件包本地路径 | Firmware package local path
 */
@property (nonatomic,copy,nullable) NSString * packagePath;

/**
 升级错误码 | Upgrade error code
 */
@property (nonatomic,assign,readonly) IDO_UPDATE_ERROR_TYPE errorCode;

/**
 升级状态 | Upgrade status
 */
@property (nonatomic,assign,readonly) IDO_UPDATE_STATE state;

/**
 升级类型 | Upgrade type
 */
@property (nonatomic,assign) IDO_UPDATE_PLATFORM_TYPE updateType;

/**
 * @brief 初始化升级管理中心对象 | Initialize the Upgrade Management Center object
 * @return IDOUpdateManager
 */
+ (__kindof IDOUpdateFirmwareManager *_Nonnull)shareInstance;


/**
 开始升级 | Start upgrading
 */
+ (void)startUpdate;

@end
