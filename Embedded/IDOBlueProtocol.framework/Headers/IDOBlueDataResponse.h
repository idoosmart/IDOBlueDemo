//
//  IDOBlueDataResponse.h
//  IDOBlueProtocol
//
//  Created by 何东阳 on 2019/5/8.
//  Copyright © 2019 何东阳. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IDOBlueDataResponse : NSObject

/**
 * 当前蓝牙管理中心
 * current bluetooth management center
 */
+ (void)currentBlueManager:(CBCentralManager *)manager;

/**
 * 当前连接外围设备
 * current connected peripheral
 */
+ (void)currentPeripheral:(CBPeripheral *)peripheral;

/**
 * 获取扫描的服务
 * [manager scanForPeripheralsWithServices:services options:@{CBCentralManagerScanOptionAllowDuplicatesKey:@YES}];
 * get the scan service
 */
+ (NSArray <CBUUID *>*)getScanServices;

/**
 * 判断当前外围设备是否为OTA模式
 * whether the current peripheral is in OTA mode
 */
+ (BOOL)isOtaModeWithPeripheral:(CBPeripheral *)peripheral;

/**
 * 连接外围设备成功后发现外围设备特征
 * - (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
 * after successfully connecting the peripheral device, peripheral device characteristics are found.
 */
+ (void)findCharac:(CBPeripheral *)peripheral
           service:(CBService *)service;

/**
 * 蓝牙接收到手环返回的数据
 * - (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
 * bluetooth receives data from the ring
 */
+ (void)didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic;

/**
 * 蓝牙写完数据的回调
 * - (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error
 * bluetooth writes a callback to the data
 */
+ (void)didWriteValueForCharacteristic:(CBCharacteristic *)characteristic
                                 error:(NSError *)error;

@end

NS_ASSUME_NONNULL_END
