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
 设置代理
 */
@property (nonatomic,weak,nullable) id <IDOUpdateManagerDelegate> delegate;

/**
 固件包本地路径
 */
@property (nonatomic,copy,nullable) NSString * packagePath;

/**
 升级错误码
 */
@property (nonatomic,assign,readonly) IDO_UPDATE_ERROR_TYPE errorCode;

/**
 升级状态
 */
@property (nonatomic,assign,readonly) IDO_UPDATE_STATE state;

/**
 初始化升级管理中心对象
 
 @param delgate 接收管理中心角色事件的委托
 @return IDOUpdateManager
 */
+ (__kindof IDOUpdateFirmwareManager * _Nullable)registerWtihDelegate:(id <IDOUpdateManagerDelegate> _Nullable)delgate;


/**
 开始升级
 */
+ (void)startUpdate;

@end
