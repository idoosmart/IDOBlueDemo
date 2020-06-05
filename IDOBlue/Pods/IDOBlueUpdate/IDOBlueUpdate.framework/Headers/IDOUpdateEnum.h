//
//  IDOUpdateEnum.h
//  IDOBluetoothInternal
//
//  Created by 何东阳 on 2019/8/3.
//  Copyright © 2019 何东阳. All rights reserved.
//

#ifndef IDOUpdateEnum_h
#define IDOUpdateEnum_h

/**
 * OTA升级状态枚举
 * OTA upgrade status enumeration
 */
typedef NS_ENUM(NSInteger, IDO_UPDATE_STATE) {
    
    /**
     * 升级初始状态
     * Update initial state
     */
    IDO_UPDATE_START_INIT = 0,
    
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
    IDO_UPDATE_STARTING,
    
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
    
    /**
     * 手机系统版本过低不支持固件升级
     * Firmware upgrade is not supported in the lower version of the mobile system
     */
    IDO_SYSTEM_VERSION_TOO_LOW_TYPE,
    
    /**
     * 不支持当前平台升级
     * no supported platform update
     */
    IDO_NO_SUPPORTED_PLATFORM_TYPE,
    
    /**
     * 不支持realtk平台的耳机升级
     * no supported realtk rws
     */
    IDO_NO_SUPPORT_REALTK_RWS_TYPE
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
 * realtk设备升级类型
 * realtk device update type
 */
typedef NS_ENUM(NSInteger, IDO_REALTK_UPDATE_TYPE)  {
    /**
     *
     * normal mode update
     */
    IDO_NORMAL_MODE_UPDATE_TYPE = 1,
    /**
     * silent mode update
     */
    IDO_SILENT_MODE_UPDATE_TYPE,
};

/**
 * 固件升级使用平台类型
 * Firmware updates use the platform type
 */
typedef NS_ENUM(NSInteger, IDO_UPDATE_PLATFORM_TYPE)  {
    /**
     * nordic 蓝牙升级
     * nordic bluetooth update
     */
    IDO_NORDIC_PLATFORM_TYPE = 0,
    /**
     * realtk 蓝牙升级
     * realtk bluetooth update
     */
    IDO_REALTK_PLATFORM_TYPE,
    /**
     * apollo 蓝牙升级
     * realtk bluetooth update
     */
    IDO_APOLLO_PLATFORM_TYPE,
};


#endif /* IDOUpdateEnum_h */
