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
 设置代理 | Setting up the agent
 */
@property (nonatomic,weak) id<IDOBluetoothManagerDelegate> delegate;

/**
 自动扫描连接超时时长 默认 20 | Auto Scan Connection Timeout Duration Default 20
 */
@property (nonatomic,assign) NSInteger timeout;

/**
 * 设置扫描过滤信号弱的设备 默认值 80 大于80会被过滤
 * Set the device with weak scan filtering signal. Default value 80 is greater than 80 will be filtered.
 */
@property (nonatomic,assign) NSInteger rssiNum;

/**
 * 是否启动超时,间隔扫描 默认 yes 最大间隔一分钟扫描一次
 * Whether to start timeout, interval scan Default yes Maximum interval one minute scan
 */
@property (nonatomic,assign) BOOL isIntervalScan;

/**
 * 是否需要重连机制 默认 YES
 * Whether a reconnect mechanism is required
 */
@property (nonatomic,assign) BOOL isReconnect;

/**
 * 设置扫描间隔时长 默认 10秒 如果不启动超时间隔扫描，则无效
 * Set the scan interval to 10 seconds by default.If timeout interval scanning is not started, it is not valid.
 */
@property (nonatomic,assign) NSInteger autoScanInterval;

/**
 蓝牙扫描设备模式 | Bluetooth Scanning Device Mode
 */
@property (nonatomic,assign,readonly) IDO_SCAN_DEVICE_MODE scanMode;

/**
 蓝牙管理连接状态 | Bluetooth management connection status
 */
@property (nonatomic,assign,readonly) IDO_BLUETOOTH_MANAGER_STATE  state;

/**
 蓝牙连接错误码 | Bluetooth connection error code
 */
@property (nonatomic,assign,readonly) IDO_BLUETOOTH_CONNECT_ERROR_TYPE errorCode;

/**
 手动点击连接设备的总时长 | Total time to manually click on the connected device
 */
@property (nonatomic,assign,readonly) NSInteger manualConnectTotalTime;

/**
 自动扫描到成功连接设备的总时长 | Total time from automatic scanning to successful connection to the device
 */
@property (nonatomic,assign,readonly) NSInteger autoConnectTotalTime;

/**
 自动连接设备block回调 | Automatically connect device block callbacks
 */
@property (nonatomic,copy) void(^autoConnectDeviceComplete)(BOOL isConnected);

/**
 * @brief 初始化蓝牙管理中心对象 | Initialize the Bluetooth Management Center object
 * @return IDOBluetoothManager
 */
+ (__kindof IDOBluetoothManager *)shareInstance;

/**
 开始扫描 | Start scanning
 */
+ (void)startScan;

/**
 停止扫描 | Stop scanning
 */
+ (void)stopScan;

/**
 * @brief 1、普通模式下选择外围设备连接 2、ota模式下选择外围设备连接
 * 1. Select peripheral device connection in normal mode
 * 2. Select peripheral device connection in ota mode
 * @param model IDOPeripheralModel 对象 | IDOPeripheralModel object
 */
+ (void)connectDeviceWithModel:(IDOPeripheralModel *)model;

/**
 断开当前外围设备的连接 | Disconnect the current peripheral device
 */
+ (void)cancelCurrentPeripheralConnection;

/**
 * 连接外围设备成功后发现外围设备特征
 * After successfully connecting the peripheral device, peripheral device characteristics are found.
 */
+ (void)findCharac:(CBPeripheral *)peripheral
           service:(CBService *)service;

/**
 * 蓝牙接收到手环返回的数据
 * Bluetooth receives data from the ring
 */
+ (void)idoDidUpdateValueForCharacteristic:(CBCharacteristic *)characteristic;


@end

