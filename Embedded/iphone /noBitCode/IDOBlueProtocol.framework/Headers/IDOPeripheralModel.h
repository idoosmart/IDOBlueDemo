//
//  IDOPeripheralModel.h
//  VeryfitSDK
//
//  Created by hedongyang on 2018/6/4.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface IDOPeripheralModel : NSObject

/**
 外围设备 | peripheral
 */
@property (nullable,nonatomic,strong) CBPeripheral * peripheral;

/**
 手环名字 | Bracelet name
 */
@property (nullable,nonatomic,copy)   NSString * name;

/**
 手环uuid | Bracelet uuid
 */
@property (nullable,nonatomic,copy)   NSString * uuidStr;

/**
 手环rssi | bracelet rssi
 */
@property (nonatomic,assign) NSInteger  rssi;

/**
 手环距离 单位 米 | Bracelet Distance Units
 */
@property (nonatomic,assign) float distance;

/**
 是否是OTA | Is it OTA?
 */
@property (nonatomic,assign) BOOL isOta;

/**
 mac 地址 | mac address 
 */
@property (nullable,nonatomic,copy) NSString * macAddr;

/**
 设备ID  | Device ID
 */
@property (nonatomic,assign) int deviceId;

/**
 固件版本  | Firmware version
 */
@property (nonatomic,assign) int bltVersion;

@end
