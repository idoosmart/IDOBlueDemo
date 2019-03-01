//
//  IDOBluetoothServices.h
//  VeryfitSDK
//
//  Created by apple on 2018/8/22.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import <Foundation/Foundation.h>

// 蓝牙扫描、连接状态通知监听名字 | Bluetooth scan, connection status notification listener name
extern NSString * IDOBluetoothConnectStateNotifyName;

// 蓝牙扫描、连接过程错误通知监听名字 | Bluetooth scan, connection process error notification listener name
extern NSString * IDOBluetoothConnectErrorNotifyName;

// 当前连接的手环设备为OTA模式通知监听名字 | The currently connected bracelet device is OTA mode notification listener name
extern NSString * IDOBluetoothOtaModeNotifyName;

@interface IDOBluetoothServices : NSObject

/*
 是否输出蓝牙sdk运行日志 | Whether to output the Bluetooth sdk running log
 */
@property (nonatomic,copy,nullable) IDOBluetoothServices *_Nonnull(^outputSdkLog)(BOOL isOutput);

/*
 是否输出蓝牙协议运行日志 | Whether to output the Bluetooth protocol running log
 */
@property (nonatomic,copy,nullable) IDOBluetoothServices *_Nonnull(^outputProtocolLog)(BOOL isOutput);

/*
 是否添加阿里云日志 默认 No | Add Alibaba Cloud Log Default No
 */
@property (nonatomic,copy,nullable) IDOBluetoothServices *_Nonnull(^addAliYunLog)(BOOL isAdd);

/**
 * @brief  注册SDK服务 | Register for SDK service
 * @param  isNeedBlueManager 是否需要SDK蓝牙管理中心 默认 YES
 * Whether SDK bluetooth management center is required Default YES
 * @return IDOBluetoothServices
 */
IDOBluetoothServices * _Nonnull registrationServices(BOOL isNeedBlueManager);

@end
