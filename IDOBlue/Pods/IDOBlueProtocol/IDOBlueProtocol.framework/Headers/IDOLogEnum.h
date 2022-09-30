//
//  IDOLogEnum.h
//  IDOBluetoothInternal
//
//  Created by 何东阳 on 2019/8/3.
//  Copyright © 2019 何东阳. All rights reserved.
//

#ifndef IDOLogEnum_h
#define IDOLogEnum_h

/**
 * 记录日志类型
 * Log type
 */
typedef NS_ENUM(NSInteger, IDO_RECORD_LOG_TYPE)  {
    /**
     * 日志记录初始化
     * record log init
    */
    IDO_RECORD_INIT_LOG = 0,
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
     *蓝牙连接过程
     *Connect process
     */
    IDO_DEVICE_CONNECT_PROCESS_LOG,
    /**
     *蓝牙连接错误
     *Connect error
     */
    IDO_DEVICE_CONNECT_ERROR_LOG,
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
     * 同步健康
     * Synchronous Health
     */
    IDO_SYNC_HEALTH_LOG,
    /**
     * 同步健康 步数
     * Synchronous Health Steps
     */
    IDO_SYNC_HEALTH_SPORT_LOG,
    /**
     * 同步健康 佩戴
     * Synchronous Health wear
     */
    IDO_SYNC_HEALTH_WEAR_LOG,
    /**
     * 同步健康 噪音
     * Synchronous Health noise
     */
    IDO_SYNC_HEALTH_NOISE_LOG,
    /**
     * 同步健康 体温
     * Synchronous Health temperature
     */
    IDO_SYNC_HEALTH_TEMPERATURE_LOG,
    /**
     * 同步健康 呼吸率
     * Synchronous Health breath rate
     */
    IDO_SYNC_HEALTH_BREATH_RATE_LOG,
    /**
     * 同步健康 身体电量
     * Synchronous Health body power
     */
    IDO_SYNC_HEALTH_BODY_POWER_LOG,
    /**
     * 同步健康 心率变异性水平
     * Synchronous Health hrv
     */
    IDO_SYNC_HEALTH_HRV_LOG,
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
     * 同步 游泳
     * Synchronized Swimming
     */
    IDO_SYNC_SWIMMING_LOG,
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
     * 手环开始升级
     * The bracelet starts to upgrade
     */
    IDO_START_UPDATE_LOG,
    /**
     * 手环升级失败
     * Failed to upgrade the bracelet
     */
    IDO_UPDATE_FAILED_LOG,
    /**
     * 手环升级成功
     * Bracelet upgraded successfully
     */
    IDO_UPDATE_SUCCESS_LOG,
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
    /**
     * 运动数据交换 app 数据日志
     * data exchange app data log
     */
    IDO_DATA_EXCHANGE_APP_LOG,
    /**
     * 运动数据交换 蓝牙数据日志
     * data exchange blue data log
     */
    IDO_DATA_EXCHANGE_BLUE_LOG,
    /**
     * 协议库日志记录
     * protocol c log
     */
    IDO_PROTOCOL_C_LOG,
    /**
     * 数据库存储和更新日志
     * db save or update log
     */
    IDO_DATA_SAVE_UPDATE_LOG,
    /**
     * 切换设备
     * switch device log
     */
    IDO_SWITCH_DEVICE_LOG,
    /**
     * 传输文件日志
     * transmission file log
     */
    IDO_TRANSMISSION_FILE_LOG,
    /**
     * 传输表盘日志
     * transmission watch file log
     */
    IDO_WATCH_TRANSMISSION_FILE_LOG,
    /**
     * 传输壁纸日志
     * transmission photo file log
     */
    IDO_PHOTO_TRANSMISSION_FILE_LOG,
    /**
     * 传输消息运动图标日志
     */
    IDO_ICON_TRANSMISSION_FILE_LOG,
    /**
     VBUS 模型数据日志
     */
    IDO_MODEL_DATA_LOG,
    /**
      Alexa音频下发日志
     */
    IDO_ALEXA_AUDIO_TRANSMISSION_LOG,
    /**
      音乐操作日志
     */
    IDO_MUSIC_TRANSMISSION_LOG,
    /**
     同步数据存储日志
     */
    IDO_SYNC_DATA_SAVE_LOG,
    /**
     *DB日志
     */
    IDO_DB_DATA_SAVE_LOG,
    /**
     *心跳日志
     */
    IDO_DB_DATA_HEARTBEAT_LOG,
};

typedef NS_ENUM(NSInteger, IDO_FLASH_LOG_TYPE)  {
    /**
     *通用log
     *general log
     */
    IDO_FLASH_LOG_GENERAL_TYPE    = 0,
    /**
     *复位log
     *reset log
     */
    IDO_FLASH_LOG_RESET_TYPE      =   1,
    /**
     *算法
     *algorithm log
     */
    IDO_FLASH_LOG_ALGORITHM_TYPE  =   2,
    /**
     *硬件
     *hardware log
     */
    IDO_FLASH_LOG_HARDWARE_TYPE   =   3,
    /**
     *重启日志
     *restart log
     */
    IDO_FLASH_LOG_RESTART_TYPE   =   4,
    
};


#endif /* IDOLogEnum_h */
