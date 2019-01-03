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
 * @brief 扫描所有外围设备 | Scan all peripherals
 * @param manager IDO蓝牙管理中心 | IDO Bluetooth Management Center
 * @param allDevices 扫描所有外围设备(包括OTA设备集合) | Scan all peripherals (including OTA device collections)
 * @param otaDevices OTA 设备集合 | OTA Device Collection
 */
- (void)bluetoothManager:(IDOBluetoothManager *)manager
              allDevices:(NSArray <IDOPeripheralModel *>*)allDevices
              otaDevices:(NSArray <IDOPeripheralModel *>*)otaDevices;


/**
 * @brief 连接设备成功回调 | Connected device successfully callback
 
 * @param manager IDO蓝牙管理中心 | IDO Bluetooth Management Center
 * @param centerManager 蓝牙管理中心 | Bluetooth Management Center
 * @param peripheral 外围设备 | Peripherals
 * @param isOtaMode 连接是否在OTA模式 | Is the connection in OTA mode?
 * @return 是或否 | yes or no
 */
- (BOOL)bluetoothManager:(IDOBluetoothManager *)manager
           centerManager:(CBCentralManager *)centerManager
    didConnectPeripheral:(CBPeripheral *)peripheral
               isOatMode:(BOOL)isOtaMode;

/**
 * @brief 蓝牙管理状态 | Bluetooth management status
 
 * @param manager IDO蓝牙管理中心 | IDO Bluetooth Management Center
 * @param state 状态 | Status
 */
- (void)bluetoothManager:(IDOBluetoothManager *)manager
          didUpdateState:(IDO_BLUETOOTH_MANAGER_STATE)state;

/**
 * @brief 连接设备错误回调 | Connection Device Error Callback
 
 * @param manager IDO蓝牙管理中心 | IDO Bluetooth Management Center
 * @param error 错误信息 | Error message
 */
- (void)bluetoothManager:(IDOBluetoothManager *)manager
  connectPeripheralError:(NSError *)error;

@end

#endif /* IDOBluetoothManagerDelegate_h */
