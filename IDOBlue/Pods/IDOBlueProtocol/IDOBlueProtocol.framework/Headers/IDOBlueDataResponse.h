//
//  IDOBlueDataResponse.h
//  IDOBlueProtocol
//
//  Created by 何东阳 on 2019/5/8.
//  Copyright © 2019 何东阳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

NS_ASSUME_NONNULL_BEGIN

@interface IDOBlueDataResponse : NSObject

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
 * manager ：当前蓝牙管理中心
 * peripheral : 当前外接设备
 * serviceIndex : 当前发现服务的索引 默认传0不作服务索引判断
 * current bluetooth management center
 * current bluetooth peripheral
 * serviceIndex : the index of the current discovered service is set to 0 by default without service index judgment
 */
+ (void)blueManager:(CBCentralManager *)manager
         peripheral:(CBPeripheral *)peripheral
       serviceIndex:(NSInteger)serviceIndex
       didConnected:(void(^)(BOOL isOta))callback;

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
