//
//  IDOBluetoothEngine.h
//  VeryfitSDK
//
//  Created by hedongyang on 2018/5/31.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
/**
 IDO 当前手环蓝牙引擎 | IDO current bracelet Bluetooth engine
 */
#define IDO_BLUE_ENGINE  [IDOBluetoothEngine shareInstance] 

/**
 IDO 当前手环蓝牙功能列表 | IDO Current Bracelet Bluetooth Feature List
 */
#define __IDO_FUNCTABLE__  IDO_BLUE_ENGINE.managerEngine.funcTableModel

/**
 IDO 当前手环UUID | IDO Current Bracelet UUID
 */
#define __IDO_UUID__  IDO_BLUE_ENGINE.peripheralEngine.uuidStr

/**
 IDO 当前手环MAC | IDO Current Bracelet MAC
 */
#define __IDO_MAC_ADDR__  IDO_BLUE_ENGINE.peripheralEngine.macAddr

/**
 IDO 当前手环绑定状态 | IDO Current Bracelet Binding Status
 */
#define __IDO_BIND__  IDO_BLUE_ENGINE.peripheralEngine.isBind

/**
 IDO 当前手环配对中状态 | IDO Current Bracelet pairing Status
 */
#define __IDO_PAIRING__  IDO_BLUE_ENGINE.peripheralEngine.isPairing

/**
 IDO 用户ID | IDO User ID
 */
#define __IDO_USER_ID__  IDO_BLUE_ENGINE.userEngine.userId

/**
 IDO 当前手环ota状态 | IDO current bracelet ota status
 */
#define __IDO_OTA__  IDO_BLUE_ENGINE.peripheralEngine.isOta

/**
 IDO 当前手环名字 | IDO Current Bracelet Name
 */
#define __IDO_NAME__  IDO_BLUE_ENGINE.peripheralEngine.deviceName

/**
 IDO 当前蓝牙系统管理对象 | IDO Current Bluetooth System Management Object
 */
#define __IDO_MANAGER__  IDO_BLUE_ENGINE.managerEngine.centralManager


/**
 IDO 当前外围设备对象 | IDO Current Peripheral Object
 */
#define __IDO_PERIPHERAL__  IDO_BLUE_ENGINE.managerEngine.peripheral

/**
 IDO 当前升级框架类型 | updates framework type
 */
#define __IDO_UPDATE_FRAME_TYPE__  IDO_BLUE_ENGINE.managerEngine.updateFrameworkType


@interface IDOBluetoothManagerInfoEngine : NSObject

/**
 蓝牙管理中心 | Bluetooth Management Center
 */
@property (nonatomic,strong) CBCentralManager * centralManager;

/**
 外围设备 | Peripherals
 */
@property (nonatomic,strong) CBPeripheral  * peripheral;

/**
 蓝牙是否开启 | Is Bluetooth enabled?
 */
@property (nonatomic,assign,readonly,getter=isPoweredOn) BOOL poweredOn;

/**
 蓝牙是否连接 | Bluetooth is connected
 */
@property (nonatomic,assign,readonly,getter=isConnected) BOOL connected;

/**
 蓝牙是否正在连接中 | Bluetooth is connecting
 */
@property (nonatomic,assign,readonly,getter=isConnecting) BOOL connecting;

/**
 命令服务特征 | Command Service Features
 */
@property (nonatomic,strong) CBCharacteristic * commandCharacteristic;

/**
 健康服务特征 | Health Service Features
 */
@property (nonatomic,strong) CBCharacteristic * healthCharacteristic;

/**
 锐捷定制发送服务特征 | ruijie write service Features
 */
@property (nonatomic,strong) CBCharacteristic * customWriteCharacteristic;

/**
 功能列表 | Function List
 */
@property (nonatomic,strong) IDOGetDeviceFuncBluetoothModel * funcTableModel;

/**
 * 固件升级使用框架类型 | Firmware updates use the frame type
 */
@property (nonatomic,assign) IDO_UPDATE_FRAMEWORK_TYPE updateFrameworkType;

@end

@interface IDOBluetoothPeripheralInfoEngine : NSObject

/**
 当前连接外围设备的uuid | uuid currently connected to peripherals
 */
@property (nonatomic,copy)   NSString * uuidStr;

/**
 当前连接设备ID | Current connection device ID
 */
@property (nonatomic,copy)   NSString * deviceId;

/**
 当前连接设备名字 | Current connected device name
 */
@property (nonatomic,copy)   NSString * deviceName;

/**
 当前连接设备固件版本号 | Current connected device firmware version number
 */
@property (nonatomic,copy)   NSString * version;

/**
 当前连接设备Mac地址  | Currently connected device Mac address
 */
@property (nonatomic,copy)   NSString * macAddr;

/**
 当前连接设备授权码 | Currently connected device authorization code
 */
@property (nonatomic,copy)   NSString * authCode;

/**
 当前连接设备模式 | Current connected device mode
 */
@property (nonatomic,assign) NSInteger  deviceMode;

/**
 当前连接设备状态 | Current connected device status
 */
@property (nonatomic,assign) NSInteger  battStatus;

/**
 当前连接设备电量 | Current connected device power
 */
@property (nonatomic,assign) NSInteger  battLevel;

/**
 当前连接设备是否重启 | Is the current connected device restarted?
 */
@property (nonatomic,assign) NSInteger  rebootFlag;

/**
 当前连接设备授权码长度 | Current connection device authorization code length
 */
@property (nonatomic,assign) NSInteger  authLength;

/**
 当前连接设备是否绑定 | Is the current connected device bound?
 */
@property (nonatomic,assign) BOOL isBind;

/**
 当前连接设备是否配对中 | Is the current connected device pairing?
 */
@property (nonatomic,assign) BOOL isPairing;

/**
 当前连接设备是否ota | Is the current connected device ota?
 */
@property (nonatomic,assign) BOOL isOta;

@end

@interface IDOBluetoothUserInfoEngine : NSObject

/**
 用户ID | User ID
 */
@property (nonatomic,copy)   NSString * userId;

/**
 用户生日 (例如:2018-10-01) | | User birthday (example: 2018-10-01)
 */
@property (nonatomic,copy)   NSString * birthday;

/**
 用户目标步数 | User target steps
 */
@property (nonatomic,assign) NSInteger goalStepCount;

/**
 目标睡眠 (分钟) | Target sleep (minutes)
 */
@property (nonatomic,assign) NSInteger goalSleepMinute;

/**
 目标卡路里 | Goal Calories
 */
@property (nonatomic,assign) NSInteger goalCalorieData;

/**
 目标距离 | Target distance
 */
@property (nonatomic,assign) NSInteger goalDistanceData;

/**
 目标体重 (千克) | Target weight (kg)
 */
@property (nonatomic,assign) NSInteger goalWeight;

/**
 用户性别 | User gender
 */
@property (nonatomic,assign) NSInteger sex;

/**
 用户体重 | User weight
 */
@property (nonatomic,assign) NSInteger weight;

/**
 用户升高 | User rises
 */
@property (nonatomic,assign) NSInteger height;

/**
 是否登陆 | Login
 */
@property (nonatomic,assign) BOOL isLogin;

@end

@interface IDOBluetoothAppInfoEngine : NSObject

/**
 设备名字 | Device Name
 */
@property (nonatomic,copy) NSString * iphoneName;

/**
 手机系统版本 | Mobile phone system version
 */
@property (nonatomic,copy) NSString * sysVersion;

/**
 sdk版本 | sdk version
 */
@property (nonatomic,copy) NSString * sdkVersion;

@end

@interface IDOBluetoothUnitInfoEngine : NSObject

/**
 时间格式是否12小时制 | Is the time format 12-hour format?
 */
@property (nonatomic,assign) BOOL is12Hour;

/**
 语言单位 | Language unit
 */
@property (nonatomic,assign) NSInteger language;

/**
 距离单位 | Distance unit
 */
@property (nonatomic,assign) NSInteger distUnit;

/**
 体重单位 | Weight unit
 */
@property (nonatomic,assign) NSInteger weightUnit;

/**
 温度单位 | Temperature unit
 */
@property (nonatomic,assign) NSInteger tempUnit;

/**
 走路步伐单位 | Walking pace unit
 */
@property (nonatomic,assign) NSInteger strideWalkUnit;

/**
 跑步步伐单位 | Running pace unit
 */
@property (nonatomic,assign) NSInteger strideRunUnit;

@end

@interface IDOBluetoothEngine : NSObject
+ (IDOBluetoothEngine *)shareInstance;
- (void)deserialization;
@property (nonatomic,strong) IDOBluetoothManagerInfoEngine    * managerEngine;
@property (nonatomic,strong) IDOBluetoothPeripheralInfoEngine * peripheralEngine;
@property (nonatomic,strong) IDOBluetoothUserInfoEngine       * userEngine;
@property (nonatomic,strong) IDOBluetoothAppInfoEngine        * appEngine;
@property (nonatomic,strong) IDOBluetoothUnitInfoEngine       * unitEngine;
@end

