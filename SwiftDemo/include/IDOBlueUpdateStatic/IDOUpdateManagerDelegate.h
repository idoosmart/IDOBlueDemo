//
//  IDOUpdateManagerDelegate.h
//  IDOBluetooth
//
//  Created by 何东阳 on 2018/12/18.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#if __has_include(<IDOBluetoothInternal/IDOBluetoothInternal.h>)
#elif __has_include(<IDOBlueProtocol/IDOBlueProtocol.h>)
#import <IDOBlueProtocol/IDOBlueProtocol.h>
#else
#import "IDOEnum.h"
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
 * @brief 传入固件包的类型 （SOFTDEVICE、BOOTLOADER、SOFTDEVICE_BOOTLOADER、APPLICATION）默认 APPLICATION 暂时不支持其他类型
 * Incoming firmware package type (SOFTDEVICE, BOOTLOADER, SOFTDEVICE_BOOTLOADER, APPLICATION) Default APPLICATION does not support other types
 * @param manager 升级管理中心对象 | Upgrade Management Center Objects
 * @return 固件包的类型 | Type of firmware package
 */
- (IDO_UPDATE_DFU_FIRMWARE_TYPE)selectDfuFirmwareTypeWithUpdateManager:(IDOUpdateFirmwareManager *_Nullable)manager;

@end
