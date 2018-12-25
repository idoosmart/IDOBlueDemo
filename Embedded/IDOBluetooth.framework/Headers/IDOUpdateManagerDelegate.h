//
//  IDOUpdateManagerDelegate.h
//  IDOBluetooth
//
//  Created by 何东阳 on 2018/12/18.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IDOUpdateFirmwareManager;

@protocol IDOUpdateManagerDelegate<NSObject>

@required
/**
 传入包的存放本地路径
 
 @param manager 升级管理中心对象
 @return 升级包的存放路径
 */
- (NSString *_Nullable)currentPackagePathWithUpdateManager:(IDOUpdateFirmwareManager *_Nullable)manager;

/**
 升级过程的进度
 
 @param manager 升级管理中心对象
 @param progress 进度 (0 ~ 1)
 @param message 升级日志信息
 */
- (void)updateManager:(IDOUpdateFirmwareManager *_Nullable)manager
             progress:(float)progress
              message:(NSString *_Nullable)message;


/**
 升级状态
 
 @param manager 升级管理中心对象
 @param state 状态值
 */
- (void)updateManager:(IDOUpdateFirmwareManager *_Nullable)manager
                state:(IDO_UPDATE_STATE)state;


/**
 升级过程报错
 
 @param manager 升级管理中心对象
 @param error 错误信息
 */
- (void)updateManager:(IDOUpdateFirmwareManager *_Nullable)manager
          updateError:(NSError *_Nullable)error;


@optional
/**
 传入固件包的类型 （SOFTDEVICE、BOOTLOADER、SOFTDEVICE_BOOTLOADER、APPLICATION）默认 APPLICATION 暂时不支持其他类型
 
 @param manager 升级管理中心对象
 @return 固件包的类型
 */
- (IDO_UPDATE_DFU_FIRMWARE_TYPE)selectDfuFirmwareTypeWithUpdateManager:(IDOUpdateFirmwareManager *_Nullable)manager;

@end
