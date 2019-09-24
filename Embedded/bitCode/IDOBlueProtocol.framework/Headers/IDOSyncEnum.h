//
//  IDOSyncEnum.h
//  IDOBluetoothInternal
//
//  Created by 何东阳 on 2019/8/3.
//  Copyright © 2019 何东阳. All rights reserved.
//

#ifndef IDOSyncEnum_h
#define IDOSyncEnum_h

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
     * v3健康同步完成
     * v3 health synchronization completed
     */
    IDO_SYNC_V3_HEALTH_COMPLETE,
    
    /**
     * v3健康同步完成异常
     * v3 health synchronization completes exception
     */
    IDO_SYNC_V3_HEALTH_COMPLETE_EXCEPTION,
    
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
    IDO_SYNC_CONFIG_TYPE = 1,
    
    /**
     * 当前同步健康
     * Current sync health
     */
    IDO_SYNC_HEALTH_TYPE,
    
    /**
     * 当前同步V3健康
     * Current sync Blood oxygen and pressure
     */
    IDO_SYNC_V3_HEALTH_TYPE,
    
    /**
     * 当前同步活动
     * Current synchronization activity
     */
    IDO_SYNC_ACTIVITY_TYPE,
    
    /**
     * 当前同步GPS
     * Current synchronous GPS
     */
    IDO_SYNC_GPS_TYPE,
    
};

/**
 * 同步配置数据类型
 * Synchronous configuration data type
 */
typedef NS_ENUM(NSInteger, IDO_SYNC_CONFIG_DATA_TYPE) {
    /*
     * 不设置默认数据
     * set none
     */
    IDO_SYNC_DEFAULT_NONE = 0,
    /*
     * 设置当前时间
     * set time
     */
    IDO_SYNC_SET_TIME_TYPE = 1,
    /*
     * 设置闹钟
     * set alarm
     */
    IDO_SYNC_SET_ALARM_TYPE,
    /*
     * 设置久坐
     * set long sit
     */
    IDO_SYNC_SET_LONG_SIT_TYPE,
    /*
     * 设置防丢失
     * set lost find
     */
    IDO_SYNC_SET_LOST_FIND_TYPE,
    /*
     * 设置寻找手机
     * set find phone
     */
    IDO_SYNC_SET_FIND_PHONE_TYPE,
    /*
     * 设置运动目标(步数)
     * set sport goal
     */
    IDO_SYNC_SET_SPORT_GOAL_TYPE,
    /*
     * 设置用户信息
     * set user info
     */
    IDO_SYNC_SET_USER_INFO_TYPE,
    /*
     * 设置单位
     * set unit
     */
    IDO_SYNC_SET_UNIT_TYPE,
    /*
     * 设置开启授权
     * set open auth
     */
    IDO_SYNC_SET_AUTH_TYPE,
    /*
     * 设置心率模式
     * set heart rate mode
     */
    IDO_SYNC_SET_HEART_RATE_MODE_TYPE,
    /*
     * 设置抬手
     * set up hand gesture
     */
    IDO_SYNC_SET_UP_HAND_GESTURE_TYPE,
    /*
     * 设置勿扰模式
     * set do not disturb
     */
    IDO_SYNC_SET_DO_NOT_DISTURB_TYPE,
    /*
     * 设置显示模式
     * set display mode
     */
    IDO_SYNC_SET_DISPLAY_MODE_TYPE,
    /*
     * 设置一键呼叫
     * set one key sos
     */
    IDO_SYNC_SET_ONE_KEY_SOS_TYPE,
    /*
     * 设置音乐开关
     * set muisc on off
     */
    IDO_SYNC_SET_MUISC_ON_OFF_TYPE,
    /*
     * 设置天气开关
     * set weather switch
     */
    IDO_SYNC_SET_WEATHER_SWITCH_TYPE,
    /*
     * 设置心率区间
     * set heart rate interval
     */
    IDO_SYNC_SET_HEART_RATE_INTERVAL_TYPE,
    /*
     * 设置运动模式选择
     * set sport mode select
     */
    IDO_SYNC_SET_SPORT_MODE_SELECT_TYPE,
    /*
     * 设置运动模式排序
     * set sport mode sort
     */
    IDO_SYNC_SET_SPORT_MODE_SORT_TYPE,
    /*
     * 设置表盘
     * set watch dial
     */
    IDO_SYNC_SET_WATCH_DIAL_TYPE,
    /*
     * 设置快捷方式
     * set shortcut
     */
    IDO_SYNC_SET_SHORTCUT_TYPE,
    /*
     * 设置睡眠时间段
     * set sleep period
     */
    IDO_SYNC_SET_SLEEP_PERIOD_TYPE,
    /*
     * 设置屏幕亮度
     * set screen brightness
     */
    IDO_SYNC_SET_SCREEN_BRIGHTNESS_TYPE,
    /*
     * 设置女性生理周期提醒
     * set menstruation remind
     */
    IDO_SYNC_SET_MENSTRUATION_REMIND_TYPE,
    /*
     * 设置女性生理周期
     * set menstruation
     */
    IDO_SYNC_SET_SET_MENSTRUATION_TYPE,
    /*
     * 设置卡路里和距离目标
     * set calorie distance goal
     */
    IDO_SYNC_SET_CALORIE_DISTANCE_GOAL_TYPE,
    /*
     * 设置GPS信息
     * set gps config
     */
    IDO_SYNC_SET_CONFIG_GPS_TYPE,
    /*
     * 设置打开苹果通知开关
     * set open ancs
     */
    IDO_SYNC_SET_BLE_OPEN_ANCS_TYPE,
    /*
     * 设置走路提醒
     * set walk reminder
     */
    IDO_SYNC_SET_WALK_REMINDER_TYPE,
    /*
     * 设置血氧训练
     * set breathe train
     */
    IDO_SYNC_SET_BREATHE_TRAIN_TYPE,
    /*
     * 设置活动识别开关
     * set activity switch
     */
    IDO_SYNC_SET_ACTIVITY_SWITCH_TYPE,
};

/**
 * 设置同步项类型
 * set want to sync item type
 */
typedef NS_ENUM(NSInteger, IDO_WANT_TO_SYNC_ITEM_TYPE)  {
    /*
     * 同步配置
     * sync config
     */
    IDO_WANT_TO_SYNC_CONFIG_ITEM_TYPE = 1 << 0,
    /*
     * 同步健康
     * sync health
     */
    IDO_WANT_TO_SYNC_HEALTH_ITEM_TYPE = 1 << 1,
    /*
     * 同步活动
     * sync activity
     */
    IDO_WANT_TO_SYNC_ACTIVITY_ITEM_TYPE = 1 << 2,
    /*
     * 同步 GPS
     * sync gps
     */
    IDO_WANT_TO_SYNC_GPS_ITEM_TYPE = 1 << 3
};

#endif /* IDOSyncEnum_h */
