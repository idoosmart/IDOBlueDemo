//
//  IDOPeripheralModel.h
//  VeryfitSDK
//
//  Created by hedongyang on 2018/6/4.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDOPeripheralModel : NSObject

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
 mac 地址(只有在OTA下的手环才有) | mac address (only available under the OTA bracelet)
 */
@property (nullable,nonatomic,copy) NSString * macAddr;

/**
 设备ID (只有在OTA下的手环才有) | Device ID (only available under the OTA bracelet)
 */
@property (nonatomic,assign) int deviceId;

/**
 固件版本 (只有在OTA下的手环才有) | Firmware version (only available under the OTA bracelet)
 */
@property (nonatomic,assign) int bltVersion;

@end
