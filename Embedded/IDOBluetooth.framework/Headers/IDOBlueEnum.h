//
//  IDOBlueEnum.h
//  IDOBluetoothInternal
//
//  Created by 何东阳 on 2019/8/3.
//  Copyright © 2019 何东阳. All rights reserved.
//

#ifndef IDOBlueEnum_h
#define IDOBlueEnum_h

/**
 * 蓝牙扫描设备模式枚举
 * Bluetooth scanning device mode enumeration
 */
typedef NS_ENUM(NSInteger, IDO_SCAN_DEVICE_MODE) {
    /**
     * 手机蓝牙关闭或不支持蓝牙功能将不能扫描设备
     * Mobile phone Bluetooth off or not supporting Bluetooth will not scan the device
     */
    IDO_DO_NOT_SCAN_MODE  = 0,
    
    /**
     * 手动扫描连接模式
     * Manual scan connection mode
     */
    IDO_MANUAL_SCAN_CONNECT_MODE,
    
    /**
     * 系统蓝牙列表扫描连接模式
     * System bluetooth list scan connection mode
     */
    IDO_SYSTEM_LIST_SCAN_CONNECT_MODE,
    
    /**
     * 自动扫描连接模式
     * MAutomatic scan connection mode
     */
    IDO_AUTO_SCAN_CONNECT_MODE,
    
};

/**
 * 蓝牙管理状态枚举
 * Bluetooth management status enumeration
 */
typedef NS_ENUM(NSInteger, IDO_BLUETOOTH_MANAGER_STATE) {
    /**
     * 蓝牙关闭
     * Bluetooth off
     */
    IDO_MANAGER_STATE_POWEREDOFF = 1,
    
    /**
     * 蓝牙打开
     * Bluetooth open
     */
    IDO_MANAGER_STATE_POWEREDON,
    
    /**
     * 蓝牙自动扫描中
     * Bluetooth automatic scanning
     */
    IDO_MANAGER_STATE_AUTO_SCANING,
    
    /**
     * 在ota模式自动连接
     * Automatically connect in ota mode
     */
    IDO_MANAGER_STATE_AUTO_OTA_CONNECT,
    
    /**
     * 普通模式自动连接
     * Normal mode automatic connection
     */
    IDO_MANAGER_STATE_AUTO_CONNECT,
    
    /**
     * 蓝牙扫描停止
     * Bluetooth scan stop
     */
    IDO_MANAGER_STATE_SCAN_STOP,
    
    /**
     * 蓝牙手动扫描中
     * Bluetooth manual scanning
     */
    IDO_MANAGER_STATE_MANUAL_SCANING,
    
    /**
     * 在ota模式手动连接
     * Manually connect in ota mode
     */
    IDO_MANAGER_STATE_MANUAL_OTA_CONNECT,
    
    /**
     * 普通模式手动连接
     * Normal mode manual connection
     */
    IDO_MANAGER_STATE_MANUAL_CONNECT,
    
    /**
     * 手环连接成功
     * The bracelet is connected successfully
     */
    IDO_MANAGER_STATE_DID_CONNECT,
    
    /**
     * 手环连接失败
     * Bracelet connection failed
     */
    IDO_MANAGER_STATE_CONNECT_FAILED,
    
    /**
     * 手环断开连接
     * Bracelet dis connect
     */
    IDO_MANAGER_STATE_DIS_CONNECT
};


/**
 * 蓝牙连接错误类型枚举
 * Bluetooth connection error type enumeration
 */
typedef NS_ENUM(NSInteger, IDO_BLUETOOTH_CONNECT_ERROR_TYPE) {
    /**
     * UUID 为空蓝牙不能自动连接
     * UUID is Empty, Bluetooth cannot be automatically connected
     */
    IDO_BLUETOOTH_UUID_EMPTY_TYPE = 1,
    
    /**
     * MAC地址为空ota模式蓝牙不能自动连接
     * The MAC address is empty. ota mode Bluetooth cannot be automatically connected.
     */
    IDO_BLUETOOTH_MAC_ADDR_EMPTY_TYPE,
    
    /**
     * 未绑定设备蓝牙不能自动连接
     * Unbound device Bluetooth cannot be automatically connected.
     */
    IDO_BLUETOOTH_UNBOUND_TYPE,
    
    /**
     * 蓝牙关闭不能自动连接
     * Bluetooth off does not automatically connect.
     */
    IDO_BLUETOOTH_POWERED_OFF_TYPE,
    
    /**
     * 外围设备不存在
     * Peripheral device does not exist
     */
    IDO_BLUETOOTH_PERIPHERAL_DON_EXIST,
    
    /**
     * 蓝牙自动模式断开连接
     * Bluetooth auto mode disconnect
     */
    IDO_BLUETOOTH_AUTO_DIS_CONNECT_TYPE,
    
    /**
     * 蓝牙手动模式断开连接
     * Bluetooth manual mode disconnect
     */
    IDO_BLUETOOTH_MANUAL_DIS_CONNECT_TYPE,
    
    /**
     * 蓝牙连接失败
     * Bluetooth connection failed
     */
    IDO_BLUETOOTH_CONNECT_FAIL_TYPE,
    
    /**
     * 蓝牙连接超时
     * Bluetooth connection timeout
     */
    IDO_BLUETOOTH_CONNECT_TIME_OUT_TYPE,
    
    /**
     * 蓝牙扫描连接超时
     * Bluetooth scan connection timed out
     */
    IDO_BLUETOOTH_SCAN_CONNECT_TIME_OUT_TYPE,
    
    /**
     * 蓝牙发现外围设备服务失败
     * Bluetooth discovery peripheral service failed
     */
    IDO_BLUETOOTH_DISCOVER_SERVICE_FAIL_TYPE,
    
    /**
     * 蓝牙发现外围设备服务不存在
     * Bluetooth discovery peripheral service does not exist
     */
    IDO_BLUETOOTH_DISCOVER_SERVICE_NO_EXIST_TYPE,
    
    /**
     * 蓝牙发现外围设备特征失败
     * Bluetooth discovery peripheral feature failed
     */
    IDO_BLUETOOTH_DISCOVER_CHARACTERISTICS_TYPE,
    
    /**
     * 蓝牙数据交换错误
     * Bluetooth data exchange error
     */
    IDO_BLUETOOTH_DATA_EXCHANGE_ERROR_TYPE
    
};

#endif /* IDOBlueEnum_h */
