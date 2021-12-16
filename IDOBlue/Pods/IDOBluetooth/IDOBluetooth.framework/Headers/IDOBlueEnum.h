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
    IDO_MANUAL_SCAN_CONNECT_MODE = 1,
    
    /**
     * 系统蓝牙列表扫描连接模式
     * System bluetooth list scan connection mode
     */
    IDO_SYSTEM_LIST_SCAN_CONNECT_MODE = 2,
    
    /**
     * 自动扫描连接模式
     * MAutomatic scan connection mode
     */
    IDO_AUTO_SCAN_CONNECT_MODE = 3,
    
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
    IDO_MANAGER_STATE_POWEREDON = 2,
    
    /**
     * 蓝牙自动扫描中
     * Bluetooth automatic scanning
     */
    IDO_MANAGER_STATE_AUTO_SCANING = 3,
    
    /**
     * 在ota模式自动连接
     * Automatically connect in ota mode
     */
    IDO_MANAGER_STATE_AUTO_OTA_CONNECT = 4,
    
    /**
     * 普通模式自动连接
     * Normal mode automatic connection
     */
    IDO_MANAGER_STATE_AUTO_CONNECT = 5,
    
    /**
     * 蓝牙扫描停止
     * Bluetooth scan stop
     */
    IDO_MANAGER_STATE_SCAN_STOP = 6,
    
    /**
     * 蓝牙手动扫描中
     * Bluetooth manual scanning
     */
    IDO_MANAGER_STATE_MANUAL_SCANING = 7,
    
    /**
     * 在ota模式手动连接
     * Manually connect in ota mode
     */
    IDO_MANAGER_STATE_MANUAL_OTA_CONNECT = 8,
    
    /**
     * 普通模式手动连接
     * Normal mode manual connection
     */
    IDO_MANAGER_STATE_MANUAL_CONNECT = 9,
    
    /**
     * 手环连接成功
     * The bracelet is connected successfully
     */
    IDO_MANAGER_STATE_DID_CONNECT = 10,
    
    /**
     * 手环连接失败
     * Bracelet connection failed
     */
    IDO_MANAGER_STATE_CONNECT_FAILED = 11,
    
    /**
     * 手环断开连接
     * Bracelet dis connect
     */
    IDO_MANAGER_STATE_DIS_CONNECT = 12,
    
    /**
     * 蓝牙权限未开启
     * Bluetooth no open authorized
     */
    IDO_MANAGER_STATE_NO_OPEN_AUTHORIZED = 13,
    
    /**
     * 用户主动发起断线
     * User initiates disconnection
     */
    IDO_MANAGER_STATE_INITIATIVE_DISCONNECT = 14
    
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
    IDO_BLUETOOTH_MAC_ADDR_EMPTY_TYPE = 2,
    
    /**
     * 未绑定设备蓝牙不能自动连接
     * Unbound device Bluetooth cannot be automatically connected.
     */
    IDO_BLUETOOTH_UNBOUND_TYPE = 3,
    
    /**
     * 蓝牙关闭不能自动连接
     * Bluetooth off does not automatically connect.
     */
    IDO_BLUETOOTH_POWERED_OFF_TYPE = 4,
    
    /**
     * 外围设备不存在
     * Peripheral device does not exist
     */
    IDO_BLUETOOTH_PERIPHERAL_DON_EXIST = 5,
    
    /**
     * 蓝牙自动模式断开连接
     * Bluetooth auto mode disconnect
     */
    IDO_BLUETOOTH_AUTO_DIS_CONNECT_TYPE = 6,
    
    /**
     * 蓝牙手动模式断开连接
     * Bluetooth manual mode disconnect
     */
    IDO_BLUETOOTH_MANUAL_DIS_CONNECT_TYPE = 7,
    
    /**
     * 蓝牙连接失败
     * Bluetooth connection failed
     */
    IDO_BLUETOOTH_CONNECT_FAIL_TYPE = 8,
    
    /**
     * 蓝牙连接超时
     * Bluetooth connection timeout
     */
    IDO_BLUETOOTH_CONNECT_TIME_OUT_TYPE = 9,
    
    /**
     * 蓝牙扫描连接超时
     * Bluetooth scan connection timed out
     */
    IDO_BLUETOOTH_SCAN_CONNECT_TIME_OUT_TYPE = 10,
    
    /**
     * 蓝牙发现外围设备服务失败
     * Bluetooth discovery peripheral service failed
     */
    IDO_BLUETOOTH_DISCOVER_SERVICE_FAIL_TYPE = 11,
    
    /**
     * 蓝牙发现外围设备服务不存在
     * Bluetooth discovery peripheral service does not exist
     */
    IDO_BLUETOOTH_DISCOVER_SERVICE_NO_EXIST_TYPE = 12,
    
    /**
     * 蓝牙发现外围设备特征失败
     * Bluetooth discovery peripheral feature failed
     */
    IDO_BLUETOOTH_DISCOVER_CHARACTERISTICS_TYPE = 13,
    
    /**
     * 蓝牙数据交换错误
     * Bluetooth data exchange error
     */
    IDO_BLUETOOTH_DATA_EXCHANGE_ERROR_TYPE = 14,
    
    /**
     * 写入蓝牙数据错误
     * Bluetooth write data error
     */
    IDO_BLUETOOTH_DATA_WRITE_ERROR_TYPE = 15,
    
    /**
     * 蓝牙配对异常
     * Peer removed pairing information
     */
    IDO_BLUETOOTH_PAIRING_ERROR_TYPE = 16,
    
    /**
     * 蓝牙发现服务超时
     * Bluetooth dicover service timeout
     */
    IDO_BLUETOOTH_DISCOVER_SERVICE_TIME_OUT_TYPE = 17,
    
    /**
     * 蓝牙发现特征超时
     * Bluetooth dicover characteristics timeout
     */
    IDO_BLUETOOTH_DISCOVER_CHARACTERISTICS_TIME_OUT_TYPE = 18,
    
    /**
     * 尝试连接超时
     * Try connect device timeout
     */
    IDO_BLUETOOTH_TRY_CONNECT_DEIVCIE_TIMEOUT_TYPE = 19,
    /**
     * 蓝牙写入数据无权限
     * blue data write insufficient
     */
    IDO_BLUETOOTH_DATA_WRITE_INSUFFICIENT_TYPE = 20
    
};

#endif /* IDOBlueEnum_h */
