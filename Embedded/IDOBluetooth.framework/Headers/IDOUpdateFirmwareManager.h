//
//  IDOUpdateManager.h
//  IDOBluetooth
//
//  Created by hedongyang on 2018/9/14.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IDOBluetooth/IDOEnum.h>
#import <IDOBluetooth/IDOUpdateManagerDelegate.h>

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
 * @brief 初始化升级管理中心对象 | Initialize the Upgrade Management Center object
 * @param delgate 接收管理中心角色事件的委托 | Receiving delegates for Management Center role events
 * @return IDOUpdateManager
 */
+ (__kindof IDOUpdateFirmwareManager * _Nullable)registerWtihDelegate:(id <IDOUpdateManagerDelegate> _Nullable)delgate;


/**
 开始升级 | Start upgrading
 */
+ (void)startUpdate;

@end
