//
//  IDOBluetoothServices.h
//  VeryfitSDK
//
//  Created by apple on 2018/8/22.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import <Foundation/Foundation.h>

// 蓝牙扫描、连接状态通知监听名字
extern NSString * IDOBluetoothConnectStateNotifyName;

// 蓝牙扫描、连接过程错误通知监听名字
extern NSString * IDOBluetoothConnectErrorNotifyName;

@interface IDOBluetoothServices : NSObject

/*
 是否输出蓝牙sdk运行日志
 */
@property (nonatomic,copy,nullable) IDOBluetoothServices *_Nonnull(^outputSdkLog)(BOOL isOutput);

/*
 是否输出蓝牙协议运行日志
 */
@property (nonatomic,copy,nullable) IDOBluetoothServices *_Nonnull(^outputProtocolLog)(BOOL isOutput);

/*
 是否添加阿里云日志 默认 No
 */
@property (nonatomic,copy,nullable) IDOBluetoothServices *_Nonnull(^addAliYunLog)(BOOL isAdd);

/**
 注册蓝牙服务

 @return IDOBluetoothServices
 */
IDOBluetoothServices * _Nonnull registrationServices(void);

@end
