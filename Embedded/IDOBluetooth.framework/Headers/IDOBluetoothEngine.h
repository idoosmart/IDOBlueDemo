//
//  IDOBluetoothEngine.h
//  VeryfitSDK
//
//  Created by hedongyang on 2018/5/31.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <IDOBluetooth/IDOGetInfoBluetoothModel.h>
#import <IDOBluetooth/IDOSetInfoBluetoothModel.h>
#import <IDOBluetooth/IDOBluetoothManager.h>
#import <IDOBluetooth/IDOSyncManager.h>
#import <IDOBluetooth/IDOUpdateFirmwareManager.h>


/**
 IDO 当前手环蓝牙引擎
 */
#define IDO_BLUE_ENGINE  [IDOBluetoothEngine shareInstance] 

/**
 IDO 当前手环蓝牙功能列表
 */
#define __IDO_FUNCTABLE__  IDO_BLUE_ENGINE.managerEngine.funcTableModel

/**
 IDO 当前手环UUID
 */
#define __IDO_UUID__  IDO_BLUE_ENGINE.peripheralEngine.uuidStr

/**
 IDO 当前手环MAC
 */
#define __IDO_MAC_ADDR__  IDO_BLUE_ENGINE.peripheralEngine.macAddr

/**
 IDO 当前手环绑定状态
 */
#define __IDO_BIND__  IDO_BLUE_ENGINE.peripheralEngine.isBind

/**
 IDO 用户ID
 */
#define __IDO_USER_ID__  IDO_BLUE_ENGINE.userEngine.userId

/**
 IDO 当前手环ota状态
 */
#define __IDO_OTA__  IDO_BLUE_ENGINE.peripheralEngine.isOta

/**
 IDO 当前手环名字
 */
#define __IDO_NAME__  IDO_BLUE_ENGINE.peripheralEngine.deviceName

/**
 IDO 当前蓝牙系统管理对象
 */
#define __IDO_MANAGER__  IDO_BLUE_ENGINE.managerEngine.centralManager

/**
 IDO 当前外围设备对象
 */
#define __IDO_PERIPHERAL__  IDO_BLUE_ENGINE.managerEngine.peripheral



@interface IDOBluetoothManagerInfoEngine : NSObject

/**
 蓝牙管理中心
 */
@property (nonatomic,strong) CBCentralManager * centralManager;

/**
 蓝牙是否开启
 */
@property (nonatomic,assign,readonly,getter=isPoweredOn) BOOL poweredOn;

/**
 蓝牙是否连接
 */
@property (nonatomic,assign,readonly,getter=isConnected) BOOL connected;

/**
 外围设备
 */
@property (nonatomic,strong) CBPeripheral  * peripheral;

/**
 命令服务特征
 */
@property (nonatomic,strong) CBCharacteristic * commandCharacteristic;

/**
 健康服务特征
 */
@property (nonatomic,strong) CBCharacteristic * healthCharacteristic;

/**
 IDO 蓝牙管理中心
 */
@property (nonatomic,strong,readonly) IDOBluetoothManager * idoManager;

/**
 IDO 同步管理中心
 */
@property (nonatomic,strong,readonly) IDOSyncManager * syncManager;

/**
 功能列表
 */
@property (nonatomic,strong) IDOGetDeviceFuncBluetoothModel * funcTableModel;

/**
 当前手环活动个数
 */
@property (nonatomic,assign) NSInteger activityCount;

@end

@interface IDOBluetoothPeripheralInfoEngine : NSObject

/**
 之前连接过的外围设备的uuid
 */
@property (nonatomic,copy)   NSString * beforuuidStr;

/**
 当前连接外围设备的uuid
 */
@property (nonatomic,copy)   NSString * uuidStr;

/**
 当前连接设备ID
 */
@property (nonatomic,copy)   NSString * deviceId;

/**
 当前连接设备名字
 */
@property (nonatomic,copy)   NSString * deviceName;

/**
 当前连接设备固件版本号
 */
@property (nonatomic,copy)   NSString * version;

/**
 当前连接设备Mac地址
 */
@property (nonatomic,copy)   NSString * macAddr;

/**
 当前连接设备授权码
 */
@property (nonatomic,copy)   NSString * authCode;

/**
 当前连接设备模式
 */
@property (nonatomic,assign) NSInteger  deviceMode;

/**
 当前连接设备状态
 */
@property (nonatomic,assign) NSInteger  battStatus;

/**
 当前连接设备电量
 */
@property (nonatomic,assign) NSInteger  battLevel;

/**
 当前连接设备是否重启
 */
@property (nonatomic,assign) NSInteger  rebootFlag;

/**
 当前连接设备授权码长度
 */
@property (nonatomic,assign) NSInteger  authLength;

/**
 当前连接设备是否绑定
 */
@property (nonatomic,assign) BOOL isBind;

/**
 当前连接设备是否ota
 */
@property (nonatomic,assign) BOOL isOta;

@end

@interface IDOBluetoothUserInfoEngine : NSObject

/**
 用户ID
 */
@property (nonatomic,copy)   NSString * userId;

/**
 用户生日 (2018-10-01)
 */
@property (nonatomic,copy)   NSString * birthday;

/**
 用户目标步数
 */
@property (nonatomic,assign) NSInteger goalStepCount;

/**
 目标睡眠 (分钟)
 */
@property (nonatomic,assign) NSInteger goalSleepMinute;

/**
 目标卡路里
 */
@property (nonatomic,assign) NSInteger goalCalorieData;

/**
 目标距离
 */
@property (nonatomic,assign) NSInteger goalDistanceData;

/**
 目标体重 (千克)
 */
@property (nonatomic,assign) NSInteger goalWeight;

/**
 用户性别
 */
@property (nonatomic,assign) NSInteger sex;

/**
 用户体重
 */
@property (nonatomic,assign) NSInteger weight;

/**
 用户升高
 */
@property (nonatomic,assign) NSInteger height;

/**
 是否登陆
 */
@property (nonatomic,assign) BOOL isLogin;

@end

@interface IDOBluetoothAppInfoEngine : NSObject

/**
 设备名字
 */
@property (nonatomic,copy) NSString * iphoneName;

/**
 手机系统版本
 */
@property (nonatomic,copy) NSString * sysVersion;

/**
 sdk版本
 */
@property (nonatomic,copy) NSString * sdkVersion;

@end

@interface IDOBluetoothUnitInfoEngine : NSObject

/**
 时间格式是否12小时制
 */
@property (nonatomic,assign) BOOL is12Hour;

/**
 语言单位
 */
@property (nonatomic,assign) NSInteger language;

/**
 距离单位
 */
@property (nonatomic,assign) NSInteger distUnit;

/**
 体重单位
 */
@property (nonatomic,assign) NSInteger weightUnit;

/**
 温度单位
 */
@property (nonatomic,assign) NSInteger tempUnit;

/**
 走路步伐单位
 */
@property (nonatomic,assign) NSInteger strideWalkUnit;

/**
 跑步步伐单位
 */
@property (nonatomic,assign) NSInteger strideRunUnit;

@end

@interface IDOBluetoothEngine : NSObject
+ (IDOBluetoothEngine *)shareInstance;
@property (nonatomic,strong) IDOBluetoothManagerInfoEngine    * managerEngine;
@property (nonatomic,strong) IDOBluetoothPeripheralInfoEngine * peripheralEngine;
@property (nonatomic,strong) IDOBluetoothUserInfoEngine       * userEngine;
@property (nonatomic,strong) IDOBluetoothAppInfoEngine        * appEngine;
@property (nonatomic,strong) IDOBluetoothUnitInfoEngine       * unitEngine;
@end

