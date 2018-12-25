//
//  IDOBluetoothManagerDelegate.h
//  IDOBluetooth
//
//  Created by apple on 2018/8/31.
//  Copyright © 2018年 apple. All rights reserved.
//

#ifndef IDOBluetoothManagerDelegate_h
#define IDOBluetoothManagerDelegate_h


#import <IDOBluetooth/IDOPeripheralModel.h>
#import <IDOBluetooth/IDOEnum.h>

@class IDOBluetoothManager;

@protocol IDOBluetoothManagerDelegate<NSObject>

/**
 扫描所有外围设备
 @param manager IDO蓝牙管理中心
 @param allDevices 扫描所有外围设备(包括OTA设备集合)
 @param otaDevices OTA 设备集合
 */
- (void)bluetoothManager:(IDOBluetoothManager *)manager
              allDevices:(NSArray <IDOPeripheralModel *>*)allDevices
              otaDevices:(NSArray <IDOPeripheralModel *>*)otaDevices;


/**
 连接设备成功回调
 
 @param manager IDO蓝牙管理中心
 @param centerManager 蓝牙管理中心
 @param peripheral 外围设备
 @param isOtaMode 连接是否在OTA模式
 @return yes or no
 */
- (BOOL)bluetoothManager:(IDOBluetoothManager *)manager
           centerManager:(CBCentralManager *)centerManager
    didConnectPeripheral:(CBPeripheral *)peripheral
               isOatMode:(BOOL)isOtaMode;

/**
 蓝牙管理状态
 
 @param manager IDO蓝牙管理中心
 @param state 状态
 */
- (void)bluetoothManager:(IDOBluetoothManager *)manager
          didUpdateState:(IDO_BLUETOOTH_MANAGER_STATE)state;

/**
 连接设备错误回调
 
 @param manager IDO蓝牙管理中心
 @param error 错误信息
 */
- (void)bluetoothManager:(IDOBluetoothManager *)manager
  connectPeripheralError:(NSError *)error;

@end

#endif /* IDOBluetoothManagerDelegate_h */
