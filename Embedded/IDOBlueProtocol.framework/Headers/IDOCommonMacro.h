//
//  IDOCommonMacro.h
//  IDOBluetoothInternal
//
//  Created by 何东阳 on 2019/7/8.
//  Copyright © 2019 何东阳. All rights reserved.
//

#ifndef IDOCommonMacro_h
#define IDOCommonMacro_h

#if __has_include(<IDOBluetoothInternal/IDOBluetoothInternal.h>)
#elif __has_include(<IDOBlueProtocol/IDOBlueProtocol.h>)
#else
#import "IDOBluetoothEngine.h"
#endif

/**
 IDO 当前手环蓝牙引擎 | IDO current bracelet Bluetooth engine
 */
#define IDO_BLUE_ENGINE  [IDOBluetoothEngine shareInstance]

/**
 IDO 当前手环蓝牙功能列表 | IDO Current Bracelet Bluetooth Feature List
 */
#define __IDO_FUNCTABLE__  IDO_BLUE_ENGINE.managerEngine.funcTableModel

/**
 IDO 当前蓝牙系统管理对象 | IDO Current Bluetooth System Management Object
 */
#define __IDO_MANAGER__  IDO_BLUE_ENGINE.managerEngine.centralManager

/**
 IDO 当前外围设备对象 | IDO Current Peripheral Object
 */
#define __IDO_PERIPHERAL__  IDO_BLUE_ENGINE.managerEngine.peripheral

/**
 IDO 当前外围设备是否连接 | IDO Current Peripheral is connected
 */
#define __IDO_CONNECTED__  IDO_BLUE_ENGINE.managerEngine.connected

/**
 IDO 当前外围设备是否连接中 | IDO Current Peripheral is connecting
 */
#define __IDO_CONNECTING__  IDO_BLUE_ENGINE.managerEngine.connecting

/**
 IDO 当前蓝牙管理中心是否开启 | IDO Current blue manager is powered on
 */
#define __IDO_POWERED_ON__  IDO_BLUE_ENGINE.managerEngine.poweredOn

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


#endif /* IDOCommonMacro_h */
