//
//  IDOEnum.h
//  IDOBluetooth
//
//  Created by hedongyang on 2018/8/31.
//  Copyright © 2018年 apple. All rights reserved.
//

#ifndef IDOEnum_h
#define IDOEnum_h
/**
 * 绑定状态枚举
 * Binding status enumeration
 */
typedef NS_ENUM(NSInteger, IDO_BIND_STATUS) {
    /**
     * 绑定失败
     * Binding failed
     */
    IDO_BLUETOOTH_BIND_FAILED = 0,
    
    /**
     * 绑定成功
     * Binding succeeded
     */
    IDO_BLUETOOTH_BIND_SUCCESS,
    
    /**
     * 已经绑定
     * Already bound
     */
    IDO_BLUETOOTH_BINDED,
    
    /**
     * 需要授权绑定
     * Need authorization binding
     */
    IDO_BLUETOOTH_NEED_AUTH,
    
    /**
     * 拒绝绑定
     * Rejected binding
     */
    IDO_BLUETOOTH_REFUSED_BINDED,
    
};

/**
 * 同步状态枚举
 * Synchronization status enumeration
 */
typedef NS_ENUM(NSInteger, IDO_SYNC_COMPLETE_STATUS) {
    /**
     * 全部同步完成
     * All sync completed
     */
    IDO_SYNC_GLOBAL_COMPLETE = 1,
    
    /**
     * 配置同步完成
     * Configuration synchronization completed
     */
    IDO_SYNC_CONFIG_COMPLETE,
    
    /**
     * 配置同步完成异常
     * Configure synchronization completion exception
     */
    IDO_SYNC_CONFIG_COMPLETE_EXCEPTION,
    
    /**
     * 健康同步完成
     * Health synchronization completed
     */
    IDO_SYNC_HEALTH_COMPLETE,
    
    /**
     * 健康同步完成异常
     * Health synchronization completes exception
     */
    IDO_SYNC_HEALTH_COMPLETE_EXCEPTION,
    
    /**
     * 血氧和压力同步完成
     * blood oxygen and pressure synchronization completed
     */
    IDO_SYNC_BOP_COMPLETE,
    
    /**
     * 血氧和压力同步完成异常
     * blood oxygen and pressure synchronization completes exception
     */
    IDO_SYNC_BOP_COMPLETE_EXCEPTION,
    
    /**
     * 活动同步完成
     * Activity synchronization completed
     */
    IDO_SYNC_ACTIVITY_COMPLETE,
    
    /**
     * 活动同步完成异常
     * Activity synchronization completes exception
     */
    IDO_SYNC_ACTIVITY_COMPLETE_EXCEPTION,
    
    /**
     * GPS同步完成
     * GPS synchronization completed
     */
    IDO_SYNC_GPS_COMPLETE,
    
    /**
     * GPS同步完成异常
     * GPS synchronization completes exception
     */
    IDO_SYNC_GPS_COMPLETE_EXCEPTION,
    
};

/**
 * 当前同步类型枚举
 * Current sync type enumeration
 */
typedef NS_ENUM(NSInteger, IDO_CURRENT_SYNC_TYPE) {
    /**
     * 当前同步配置
     * Current synchronization configuration
     */
    IDO_SYNC_CONFIG_TYPE = 0,
    
    /**
     * 当前同步健康
     * Current sync health
     */
    IDO_SYNC_HEALTH_TYPE,
    
    /**
     * 当前同步血氧和压力
     * Current sync Blood oxygen and pressure
     */
    IDO_SYNC_BLOOD_OXYGEN_PRESSURE_TYPE,
    
    /**
     * 当前同步活动
     * Current synchronization activity
     */
    IDO_SYNC_ACTIVITY_TYPE,
    
    /**
     * 当前同步GPS
     * Current synchronous GPS
     */
    IDO_SYNC_GPS_TYPE
    
};

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
     * 蓝牙断开连接
     * Bluetooth disconnect
     */
    IDO_BLUETOOTH_DIS_CONNECT_TYPE,
    
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

/**
 * OTA升级状态枚举
 * OTA upgrade status enumeration
 */
typedef NS_ENUM(NSInteger, IDO_UPDATE_STATE) {
    /**
     * 开始进入OTA
     * Start entering OTA
     */
    IDO_UPDATE_START_ENTER_OTA = 1,
    
    /**
     * 已进入OTA
     * Has entered OTA
     */
    IDO_UPDATE_DID_ENTER_OTA,
    
    /**
     * 开始重连设备
     * Start reconnecting devices
     */
    IDO_UPDATE_START_RECONECT_DEVICE,
    
    /**
     * 设备已经重新连接上
     * The device has been reconnected
     */
    IDO_UPDATE_DID_RECONECT_DEVICE,
    /**
     * 开始启动升级固件
     * Start booting the firmware
     */
    IDO_UPDATE_STARTING ,
    
    /**
     * 固件升级中
     * Firmware upgrade
     */
    IDO_UPDATE_UPLOADING,
    /**
     * 固件升级完成
     * Firmware upgrade completed
     */
    IDO_UPDATE_COMPLETED,
    
};


/**
 * 设备升级错误类型枚举
 * Device upgrade error type enumeration
 */
typedef NS_ENUM(NSInteger, IDO_UPDATE_ERROR_TYPE) {
    /**
     * 固件包文件不存在
     * The firmware package file does not exist
     */
    IDO_UPDATE_PACKAGE_FILE_NO_EXIST_TYPE = 1,
    
    /**
     * 电量不足不能进入OTA模式
     * Insufficient power can not enter OTA mode
     */
    IDO_UPDATE_ENTER_OTA_LOW_ELECTRICITY_TYPE,
    
    /**
     * 设备不支持OTA升级
     * The device does not support OTA upgrade
     */
    IDO_UPDATE_NO_SUPPORTED_OTA_TYPE,
    
    /**
     * 进入OTA设置参数错误
     * Enter OTA setting parameter error
     */
    IDO_UPDATE_ENTER_OTA_PARAMETER_ERROR_TYPE,
    
    /**
     * 进入OTA失败
     * Entering OTA failed
     */
    IDO_UPDATE_ENTER_OTA_FAILED_TYPE,
    
    /**
     * 进入ota蓝牙重连失败
     * Enter OTA Bluetooth reconnection failed
     */
    IDO_UPDATE_ENTER_OTA_RECONNECT_FAILED_TYPE,
    
    /**
     * 蓝牙断开无法升级
     * Bluetooth disconnect cannot be upgraded
     */
    IDO_UPDATE_BLUETOOTH_DIS_CONNECT_TYPE,
    
    /**
     * 升级固件包失败
     * Upgrade firmware package failed
     */
    IDO_UPDATE_FIRMWARE_FAILED_TYPE,
    
    /*
     * 升级过程中系统蓝牙断开
     * The system bluetooth was disconnected during the upgrade
     */
    IDO_SYSTEM_BLUETOOTH_DISABLED_TYPE,
} ;

/**
 * 设备升级固件包类型
 * Device upgrade dfu firmware type enum
 */
typedef NS_ENUM(NSInteger, IDO_UPDATE_DFU_FIRMWARE_TYPE)  {
    /**
     *
     * Soft device type
     */
    IDO_DFU_FIRMWARE_SOFTDEVICE_TYPE = 1,
    /**
     * 引导装载程序
     * Bootloader type
     */
    IDO_DFU_FIRMWARE_BOOTLOADER_TYPE,
    /**
     *
     * Soft device and bootloader type
     */
    IDO_DFU_FIRMWARE_SOFTDEVICE_BOOTLOADER_TYPE,
    /**
     * 应用程序
     * Application type
     */
    IDO_DFU_FIRMWARE_APPLICATION_TYPE,
};

/**
 * 记录日志类型
 * Log type
 */
typedef NS_ENUM(NSInteger, IDO_RECORD_LOG_TYPE)  {
    /**
     * 手动连接手环
     * Manually connect the bracelet
     */
    IDO_MANUAL_CONNECT_LOG = 1,
    /**
     * 自动连接手环
     * Automatic connection bracelet
     */
    IDO_AUTO_CONNECT_LOG,
    /**
     * 手环绑定
     * Bracelet binding
     */
    IDO_BIND_DEVICE_LOG,
    /**
     * 手环解绑
     * Untie the bracelet
     */
    IDO_UNBIND_DEVICE_LOG,
    /**
     * 同步配置
     * Synchronous configuration
     */
    IDO_SYNC_CONFIG_LOG,
    /**
     * 同步健康 步数
     * Synchronous Health Steps
     */
    IDO_SYNC_HEALTH_SPORT_LOG,
    /**
     * 同步健康 睡眠
     * Synchronized Health Sleep
     */
    IDO_SYNC_HEALTH_SLEEP_LOG,
    /**
     * 同步健康 心率
     * Synchronized Health Heart Rate
     */
    IDO_SYNC_HEALTH_HR_LOG,
    /**
     * 同步健康 血压
     * Synchronized Health Blood Pressure
     */
    IDO_SYNC_HEALTH_BP_LOG,
    
    /**
     * 同步 血氧
     * Synchronized blood oxygen
     */
    IDO_SYNC_BLOOD_OXYGEN_LOG,
    
    /**
     * 同步 压力
     * Synchronized Pressure
     */
    IDO_SYNC_PRESSURE_LOG,
    /**
     * 同步活动
     * Synchronous activity
     */
    IDO_SYNC_ACTIVITY_LOG,
    /**
     * 同步gps
     * Synchronous gps
     */
    IDO_SYNC_GPS_LOG,
    /**
     * 同步结束
     * End of synchronization
     */
    IDO_SYNC_COMPLETE_LOG,
    /**
     * 蓝牙写入数据
     * Bluetooth write data
     */
    IDO_WRITE_DATA_LOG,
    /**
     * 蓝牙接收数据
     * Bluetooth receiving data
     */
    IDO_RECEIVE_DATA_LOG,
    /**
     * 手环启动配对
     * Bracelet starts pairing
     */
    IDO_PAIRING_START_LOG,
    /**
     * 手环配对失败
     * Bracelet pairing failed
     */
    IDO_PAIRING_FAILED_LOG,
    /**
     * 手环配对后重连失败
     * The bracelet failed to reconnect after pairing
     */
    IDO_PAIRING_RECONNECT_FAILED_LOG,
    /**
     * 手环配对后重连成功
     * The bracelet successfully to reconnect after pairing
     */
    IDO_PAIRING_RECONNECT_SUCCESS_LOG,
    /**
     * 手环配对后启动设置子开关
     * After the bracelet is paired, start the setting sub-switch
     */
    IDO_PAIRING_RECONNECT_SET_SUB_SWITCH_LOG,
    /**
     * 手环配对后设置子开关失败
     * Failed to set sub-switch after bracelet pairing
     */
    IDO_PAIRING_RECONNECT_SET_SUB_SWITCH_FAILED_LOG,
    /**
     * 手环配对后设置子开关成功
     * Set the sub-switch successfully after the bracelet is paired
     */
    IDO_PAIRING_RECONNECT_SET_SUB_SWITCH_SUCCESS_LOG,
};

/**
 * 固件升级使用框架类型
 * Firmware updates use the frame type
 */
typedef NS_ENUM(NSInteger, IDO_UPDATE_FRAMEWORK_TYPE)  {
    /**
     * nordic 蓝牙升级
     * nordic bluetooth update
     */
    IDO_NORDIC_FRAMEWORK_TYPE = 0,
    /**
     * realtk 蓝牙升级
     * realtk bluetooth update
     */
    IDO_REALTK_FRAMEWORK_TYPE,
};

#endif /* IDOEnum_h */
