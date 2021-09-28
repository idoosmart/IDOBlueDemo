//
//  IDOBluetoothServices.h
//  VeryfitSDK
//
//  Created by apple on 2018/8/22.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#if __has_include(<IDOBlueProtocol/IDOBlueProtocol.h>)
#else
#import "IDOGetInfoBluetoothModel.h"
#endif

// 蓝牙扫描、连接状态通知监听名字 | Bluetooth scan, connection status notification listener name
extern NSString * _Nonnull IDOBluetoothConnectStateNotifyName;

// 蓝牙扫描、连接过程错误通知监听名字 | Bluetooth scan, connection process error notification listener name
extern NSString * _Nonnull IDOBluetoothConnectErrorNotifyName;

// 蓝牙主动断开通知监听名字,多在配对和固件升级使用 | Bluetooth disconnect notification listener name
extern NSString * _Nonnull IDOBluetoothDisconnectNotifyName;

// 蓝牙主动开始扫描通知监听名字,多在配对和固件升级使用 | Bluetooth start scan notification listener name
extern NSString * _Nonnull IDOBluetoothStartScanNotifyName;

// 蓝牙主动停止扫描通知监听名字,多在配对和固件升级使用 | Bluetooth stop scan notification listener name
extern NSString * _Nonnull IDOBluetoothStopScanNotifyName;

// 当前连接的手环设备为OTA模式通知监听名字 | The currently connected bracelet device is OTA mode notification listener name
extern NSString * _Nonnull IDOBluetoothOtaModeNotifyName;

// 蓝牙日志打开记录通知名字 | Bluetooth log opens record notification name
extern NSString * _Nonnull IDOBluetoothOpenLogRecordNotifyName DEPRECATED_MSG_ATTRIBUTE("this attribute is discarded");

// 数据迁移状态通知名字 | Data migration status notification name
extern NSString * _Nonnull IDOBluetoothDataMigrationNotifyName;

// 设备绑定状态通知名字 | device bind status notification name
extern NSString * _Nonnull IDOBluetoothDeviceBindNotifyName;

// 获取设备信息通知名字 | get device info notification name
extern NSString * _Nonnull IDOBluetoothGetDeviceInfoNotifyName;

// 同步配置完成通知名字 | sync config complete notification name
extern NSString * _Nonnull IDOBluetoothSyncConfigNotifyName;

// 同步健康数据完成通知名字 | sync health data complete notification name
extern NSString * _Nonnull IDOBluetoothSyncHealthNotifyName;

// 刚连接时快速配置完成通知名字 | fast sync complete notification name
extern NSString * _Nonnull IDOBluetoothFastSyncNotifyName;

@interface IDOBluetoothServices : NSObject

/*
 是否输出蓝牙sdk运行日志 | Whether to output the Bluetooth sdk running log
 */
@property (nonatomic,copy,nullable) IDOBluetoothServices *_Nonnull(^outputSdkLog)(BOOL isOutput);

/*
 是否输出蓝牙协议运行日志 | Whether to output the Bluetooth protocol running log
 */
@property (nonatomic,copy,nullable) IDOBluetoothServices *_Nonnull(^outputProtocolLog)(BOOL isOutput,BOOL isRecord);

/*
 是否记录原始数据日志 | Whether to log raw data
 */
@property (nonatomic,copy,nullable) IDOBluetoothServices *_Nonnull(^rawDataLog)(BOOL isRecord);

/*
 是否使用功能表判断 | Whether to use function table judge
 */
@property (nonatomic,copy,nullable) IDOBluetoothServices *_Nonnull(^useFunctionTable)(BOOL isUse);

/*
 开始启动需要连接的设备 | Start the device that needs to be connected
 */
@property (nonatomic,copy,nullable) IDOBluetoothServices *_Nonnull(^startConnectDevice)(NSString * _Nullable macAddr);

/**
 * 注册SDK服务后,初始化设备信息并返回,需开始启动蓝牙,根据各自业务需求,可以选择自己的APP创建蓝牙管理,也可以使用我们提供的库创建蓝牙管理.
 * After the SDK service is registered, the device information is initialized and returned, and bluetooth needs to be started.
 * According to their business needs, they can choose their own APP to create bluetooth management, or they can use the library we provide to create bluetooth management.
 */
@property (nonatomic,copy,nullable) void(^startScanBule)(void(^ _Nullable getDeviceInfoBlock)(IDOGetDeviceInfoBluetoothModel * _Nullable model));

/**
 * @brief  注册SDK服务,初始化设备信息 | Register for SDK service,initializes device info
 * password 数据库密码 ｜ Database password
 * macAddr 需要连接的设备 
 * @return IDOBluetoothServices
 */
IDOBluetoothServices * _Nonnull registrationServices(NSString * _Nullable password);

@end
