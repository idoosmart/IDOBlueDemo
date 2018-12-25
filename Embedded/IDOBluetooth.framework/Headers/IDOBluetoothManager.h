//
//  IDOBluetoothManager.h
//  VeryfitSDK
//
//  Created by hedongyang on 2018/6/4.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IDOBluetooth/IDOBluetoothManagerDelegate.h>

@interface IDOBluetoothManager : NSObject

/**
 设置代理
 */
@property (nonatomic,weak) id<IDOBluetoothManagerDelegate> delegate;

/**
 自动扫描连接超时时长 默认 20
 */
@property (nonatomic,assign) NSInteger timeout;

/**
 设置扫描过滤信号弱的设备 默认值 80 大于80会被过滤
 */
@property (nonatomic,assign) NSInteger rssiNum;

/**
 是否启动超时,间隔扫描 默认 yes 最大间隔一分钟扫描一次
 */
@property (nonatomic,assign) BOOL isIntervalScan;

/**
 蓝牙扫描设备模式
 */
@property (nonatomic,assign,readonly) IDO_SCAN_DEVICE_MODE scanMode;

/**
 蓝牙管理连接状态
 */
@property (nonatomic,assign,readonly) IDO_BLUETOOTH_MANAGER_STATE  state;

/**
 蓝牙连接错误码
 */
@property (nonatomic,assign,readonly) IDO_BLUETOOTH_CONNECT_ERROR_TYPE errorCode;

/**
 手动点击连接设备的总时长
 */
@property (nonatomic,assign,readonly) NSInteger manualConnectTotalTime;

/**
 自动扫描到成功连接设备的总时长
 */
@property (nonatomic,assign,readonly) NSInteger autoConnectTotalTime;

/**
 自动连接设备block回调
 */
@property (nonatomic,copy) void(^autoConnectDeviceComplete)(BOOL isConnected);

/**
 初始化蓝牙管理中心对象

 @return IDOBluetoothManager
 */
+ (__kindof IDOBluetoothManager *)shareInstance;

/**
 初始化蓝牙管理中心对象
 
 @param delgate 接收管理中心角色事件的委托
 @return IDOBluetoothManager
 */
+ (__kindof IDOBluetoothManager *)registerWtihDelegate:(id<IDOBluetoothManagerDelegate>)delgate;

/**
 开始扫描
 */
+ (void)startScan;

/**
 停止扫描
 */
+ (void)stopScan;

/**
 1、普通模式下选择外围设备连接
 2、ota模式下选择外围设备连接
 @param model IDOPeripheralModel 对象
 */
+ (void)connectDeviceWithModel:(IDOPeripheralModel *)model;

/**
 断开当前外围设备的连接
 */
+ (void)cancelCurrentPeripheralConnection;


@end

