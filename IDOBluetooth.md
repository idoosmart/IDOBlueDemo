# IDOBluetooth
>IDOBluetooth适用于iOS设备和IDO公司生产的手环实现蓝牙连接控制的框架库。它基于iOS系统蓝牙框架之上，扩展了蓝牙扫描、连接、绑定、控制、设置、读取、监听等功能类的抽象。它采用c编写的协议库实现蓝牙数据的转换以及数据同步过程的逻辑处理，降低了蓝牙通信的错误，提高蓝牙通信的速度和准确性。功能丰富的API简单易用，使用起来非常愉快。

>IDOBluetooth is suitable for iOS devices and IDO company's bracelet to achieve bluetooth connection control framework library. Based on the bluetooth framework of iOS system, it extends the abstraction of bluetooth scanning, connection, binding, control, setting, reading, listening and other functions. It USES the protocol library written by c to realize the conversion of bluetooth data and logical processing of data synchronization process, which reduces the error of bluetooth communication and improves the speed and accuracy of bluetooth communication. The feature-rich API is easy to use and very enjoyable to use.

## 如何开始 How To Get Started

* 下载IDOBluetooth并试用附带的iPhone示例应用程序;
 <br>Download IDOBluetooth and try the accompanying iPhone sample application;
* 查看文档以全面了解IDOBluetooth中提供的所有API;
 <br>View the documentation to fully understand all apis provided in IDOBluetooth;
 
## 使用要求 Requirements
| IDOBluetooth版本 <br>IDOBluetooth version | 最低iOS目标 <br>minimum iOS target| 笔记 <br>notes |
| :------:| :------: | :------: |
| 3.0.0 | iOS 8.0 | 项目中只有Objective-C 文件需要添加一个空的swift文件 <br> Only the objective-c file in the project needs to add an empty swift file |

##构建 Architecture

```
#import <IDOBluetooth/IDOEnum.h>
#import <IDOBluetooth/IDOBluetoothEngine.h>
#import <IDOBluetooth/IDOErrorCodeToStr.h>
#import <IDOBluetooth/IDORecordDeviceLog.h>

#import <IDOBluetooth/IDOBluetoothServices.h>
#import <IDOBluetooth/IDOFoundationCommand.h>

#import <IDOBluetooth/IDOBluetoothBaseModel.h>
#import <IDOBluetooth/IDODataExchangeModel.h>
#import <IDOBluetooth/IDOGetInfoBluetoothModel.h>
#import <IDOBluetooth/IDOSetInfoBluetoothModel.h>
#import <IDOBluetooth/IDOSyncInfoBluetoothModel.h>
#import <IDOBluetooth/IDOCalculateBluetoothModel.h>
#import <IDOBluetooth/IDOWeightBluetoothModel.h>
#import <IDOBluetooth/IDOPeripheralModel.h>

#import <IDOBluetooth/IDOSyncManager.h>
#import <IDOBluetooth/IDOSyncConfig.h>
#import <IDOBluetooth/IDOSyncHealth.h>
#import <IDOBluetooth/IDOSyncActivity.h>
#import <IDOBluetooth/IDOSyncGps.h>

#import <IDOBluetooth/IDOBluetoothManager.h>
#import <IDOBluetooth/IDODataMigrationManager.h>
#import <IDOBluetooth/IDOUpdateFirmwareManager.h>
#import <IDOBluetooth/IDOUpdateAgpsManager.h>
```
##框架目录 Framework Directory
  <details>
  <summary>[1.0 全局枚举 Global enum](#1.0)</summary>
  <pre>
  [1.1 绑定状态枚举 Binding status enum](#1.1)
  [1.2 同步状态枚举 Synchronization status enum](#1.2)
  [1.3 当前同步类型枚举 Current sync type enum](#1.3)
  [1.4 蓝牙扫描设备模式枚举 Bluetooth scanning device mode enum](#1.4)
  [1.5 蓝牙管理状态枚举 Bluetooth management status enum](#1.5)
  [1.6 蓝牙连接错误类型枚举 Bluetooth connection error type enum](#1.6)
  [1.7 OTA升级状态枚举 OTA upgrade status enum](#1.7)
  [1.8 OTA升级错误类型枚举 OTA upgrade error type enum](#1.8)
  [1.9 设备升级固件包类型 Device upgrade dfu firmware type enum](#1.9)
  [1.10 SDK记录日志类型 SDK logging type enum](#1.10)
  </pre>
  </details>
  
 <details>
  <summary>[2.0 全局蓝牙引擎 Global bluetooth engine](#2.0)</summary>
  <pre>
  [2.1 蓝牙信息管理引擎 Bluetooth info manager engine](#2.1)
  [2.2 手环信息管理引擎 Bracelet info manager engine](#2.2)
  [2.3 用户信息管理引擎 User info manager engine](#2.3)
  [2.4 应用信息管理引擎 Application info manager engine](#2.4)
  [2.5 单位信息管理引擎 Unit info manager engine](#2.5)
  </pre>
  </details>
  
  <details>
  <summary>[3.0 获取错误码注释 Gets an error code comment](#3.0)</summary>
  <pre>
  [3.1 获取错误码注释函数 Gets the error code comment function](#3.1)
  </pre>
  </details>
  
  <details>
  <summary>[4.0 SDK日志记录 SDK log record](#4.0)</summary>
  <pre>
  [4.1 获取设备日志信息 Gets device log information](#4.1)
  [4.2 设备重启日志目录路径 Device restart log directory path](#4.2)
  [4.3 命令执行记录日志目录路径 Command execution log directory path](#4.3)
  </pre>
  </details>
  
  <details>
  <summary>[5.0 注册SDK服务 Register SDK services](#5.0)</summary>
  <pre>
  [5.1 注册SDK服务函数 Register SDK service functions](#5.1)
  [5.2 日志输出控制函数 Log output control functions](#5.2)
  [5.3 蓝牙连接通知名字 Bluetooth connection notification name](#5.3)
  </pre>
  </details>
  
##<span id="1.0">全局枚举 Global Enumeration</span>
* <span id="1.1">绑定状态枚举 Binding status enum</span> 
  <details>
  <summary>IDO_BIND_STATUS</summary>
  <pre><code> typedef NS_ENUM(NSInteger, IDO_BIND_STATUS) {
    //绑定失败 Binding failed
    IDO_BLUETOOTH_BIND_FAILED = 0, 
    //绑定成功 Binding succeeded
    IDO_BLUETOOTH_BIND_SUCCESS, 
    //已经绑定 Already bound
    IDO_BLUETOOTH_BINDED, 
    //需要授权绑定 Need authorization binding
    IDO_BLUETOOTH_NEED_AUTH, 
    //拒绝绑定 Rejected binding
    IDO_BLUETOOTH_REFUSED_BINDED,
   }; 
  </code></pre>
  </details>
* <span id="1.2">同步状态枚举 Synchronization status enum</span>
  <details>
  <summary>IDO_SYNC_COMPLETE_STATUS</summary>
  <pre><code> typedef NS_ENUM(NSInteger, IDO_SYNC_COMPLETE_STATUS) {
     // 全部同步完成 All sync completed
    IDO_SYNC_GLOBAL_COMPLETE = 1, 
     // 配置同步完成 Configuration sync completed
    IDO_SYNC_CONFIG_COMPLETE,
    // 健康同步完成 Health synchronization completed
    IDO_SYNC_HEALTH_COMPLETE,  
    // 活动同步完成 Activity synchronization completed
    IDO_SYNC_ACTIVITY_COMPLETE, 
    // GPS同步完成 GPS synchronization completed
    IDO_SYNC_GPS_COMPLETE, 
  };
  </code></pre>
  </details>
* <span id="1.3">当前同步类型枚举 Current sync type enum</span>
  <details>
  <summary>IDO_CURRENT_SYNC_TYPE</summary>
  <pre><code> typedef NS_ENUM(NSInteger, IDO_CURRENT_SYNC_TYPE) {
    //当前同步配置 Current synchronization configuration
    IDO_SYNC_CONFIG_TYPE = 0, 
    //当前同步健康  Current sync health
    IDO_SYNC_HEALTH_TYPE,
    //当前同步活动  Current synchronization activity
    IDO_SYNC_ACTIVITY_TYPE,
    //当前同步GPS Current synchronous GPS
    IDO_SYNC_GPS_TYPE 
 };
  </code></pre>
  </details>
* <span id="1.4">蓝牙扫描设备模式枚举 Bluetooth scanning device mode enum</span>
  <details>
  <summary>IDO_SCAN_DEVICE_MODE</summary>
  <pre><code> typedef NS_ENUM(NSInteger, IDO_SCAN_DEVICE_MODE) {
    //手机蓝牙关闭或不支持蓝牙功能将不能扫描设备  
    //Mobile phone Bluetooth off or not supporting Bluetooth will not scan the device
    IDO_DO_NOT_SCAN_MODE = 0,
    //手动扫描连接模式  Manual scan connection mode
    IDO_MANUAL_SCAN_CONNECT_MODE,
    //自动扫描连接模式  Automatic scan connection mode   
    IDO_AUTO_SCAN_CONNECT_MODE,
};
  </code></pre>
  </details>
* <span id="1.5">蓝牙管理状态枚举 Bluetooth management status enum</span>
  <details>
  <summary>IDO_BLUETOOTH_MANAGER_STATE</summary>
  <pre><code> 
  typedef NS_ENUM(NSInteger, IDO_BLUETOOTH_MANAGER_STATE) {
    //蓝牙关闭  Bluetooth off
    IDO_MANAGER_STATE_POWEREDOFF = 1,   
    //蓝牙打开 Bluetooth open
    IDO_MANAGER_STATE_POWEREDON,
    //蓝牙自动扫描中 Bluetooth automatic scanning   
    IDO_MANAGER_STATE_AUTO_SCANING, 
    //在ota模式自动连接 Automatically connect in ota mode 
    IDO_MANAGER_STATE_AUTO_OTA_CONNECT,    
    //普通模式自动连接  Normal mode automatic connection 
    IDO_MANAGER_STATE_AUTO_CONNECT,    
    //蓝牙手动扫描中  Bluetooth manual scanning
    IDO_MANAGER_STATE_MANUAL_SCANING,  
    //在ota模式手动连接  Manually connect in ota mode   
    IDO_MANAGER_STATE_MANUAL_OTA_CONNECT,
    //普通模式手动连接  Normal mode manual connection
    IDO_MANAGER_STATE_MANUAL_CONNECT,    
    //手环连接成功  The bracelet is connected successfully 
    IDO_MANAGER_STATE_DID_CONNECT,   
    //手环连接失败  Bracelet connection failed 
    IDO_MANAGER_STATE_CONNECT_FAILED,
   };
</code></pre>
  </details>
* <span id="1.6">蓝牙连接错误类型枚举 Bluetooth connection error type enum</span>
  <details>
  <summary>IDO_BLUETOOTH_CONNECT_ERROR_TYPE</summary>
  <pre><code> 
  typedef NS_ENUM(NSInteger, IDO_BLUETOOTH_CONNECT_ERROR_TYPE) {
  //UUID 为空蓝牙不能自动连  UUID is Empty, Bluetooth cannot be automatically connected  
    IDO_BLUETOOTH_UUID_EMPTY_TYPE = 1,
    //MAC地址为空ota模式蓝牙不能自动连接  The MAC address is empty. ota mode Bluetooth cannot be automatically connected.   
    IDO_BLUETOOTH_MAC_ADDR_EMPTY_TYPE,    
    //未绑定设备蓝牙不能自动连接 Unbound device Bluetooth cannot be automatically connected. 
    IDO_BLUETOOTH_UNBOUND_TYPE,  
    //蓝牙关闭不能自动连接  Bluetooth off does not automatically connect.  
    IDO_BLUETOOTH_POWERED_OFF_TYPE,
    //外围设备不存在  Peripheral device does not exist 
    IDO_BLUETOOTH_PERIPHERAL_DON_EXIST,
    //蓝牙断开连接  Bluetooth disconnect 
    IDO_BLUETOOTH_DIS_CONNECT_TYPE,
    //蓝牙连接失败  Bluetooth connection failed
    IDO_BLUETOOTH_CONNECT_FAIL_TYPE, 
    //蓝牙连接超时  Bluetooth connection timeout 
    IDO_BLUETOOTH_CONNECT_TIME_OUT_TYPE,  
    //蓝牙扫描连接超时  Bluetooth scan connection timed out 
    IDO_BLUETOOTH_SCAN_CONNECT_TIME_OUT_TYPE,  
    //蓝牙发现外围设备服务失败  Bluetooth discovery peripheral service failed
    IDO_BLUETOOTH_DISCOVER_SERVICE_FAIL_TYPE,
    //蓝牙发现外围设备服务不存  Bluetooth discovery peripheral service does not exist         
    IDO_BLUETOOTH_DISCOVER_SERVICE_NO_EXIST_TYPE,
    //蓝牙发现外围设备特征失败 Bluetooth discovery peripheral feature failed
    IDO_BLUETOOTH_DISCOVER_CHARACTERISTICS_TYPE, 
    //蓝牙数据交换错误  Bluetooth data exchange error   
    IDO_BLUETOOTH_DATA_EXCHANGE_ERROR_TYPE};  </code></pre>
  </details>
* <span id="1.7">OTA升级状态枚举 OTA upgrade status enum</span>
 <details>
  <summary>IDO_UPDATE_STATE</summary>
  <pre><code> 
  typedef NS_ENUM(NSInteger, IDO_UPDATE_STATE) {   
    //开始进入OTA  Start entering OTA
    IDO_UPDATE_START_ENTER_OTA = 1,   
    //已进入OTA  Has entered OTA 
    IDO_UPDATE_DID_ENTER_OTA,  
    //开始重连设备  Start reconnecting devices 
    IDO_UPDATE_START_RECONECT_DEVICE, 
    //设备已经重新连接上  The device has been reconnected    
    IDO_UPDATE_DID_RECONECT_DEVICE,  
    //开始启动升级固件  Start booting the firmware  
    IDO_UPDATE_STARTING ,  
    //固件升级中  Firmware upgrade  
    IDO_UPDATE_UPLOADING,   
    //固件升级完成  Firmware upgrade completed 
    IDO_UPDATE_COMPLETED,   
};</code></pre>
  </details>
* <span id="1.8">OTA升级错误类型枚举 OTA upgrade error type enum</span>
 <details>
  <summary>IDO_UPDATE_STATE</summary>
  <pre><code> 
  typedef NS_ENUM(NSInteger, IDO_UPDATE_STATE) {   
    //开始进入OTA  Start entering OTA
    IDO_UPDATE_START_ENTER_OTA = 1,   
    //已进入OTA  Has entered OTA 
    IDO_UPDATE_DID_ENTER_OTA,  
    //开始重连设备  Start reconnecting devices 
    IDO_UPDATE_START_RECONECT_DEVICE, 
    //设备已经重新连接上  The device has been reconnected    
    IDO_UPDATE_DID_RECONECT_DEVICE,  
    //开始启动升级固件  Start booting the firmware  
    IDO_UPDATE_STARTING ,  
    //固件升级中  Firmware upgrade  
    IDO_UPDATE_UPLOADING,   
    //固件升级完成  Firmware upgrade completed 
    IDO_UPDATE_COMPLETED,   
  };
</code></pre>
  </details>
* <span id="1.9">设备升级固件包类型 Device upgrade dfu firmware type enum</span>
 <details>
  <summary>IDO_UPDATE_DFU_FIRMWARE_TYPE</summary>
  <pre><code> 
      typedef NS_ENUM(NSInteger, IDO_UPDATE_DFU_FIRMWARE_TYPE)  {
        //Soft Device type
        IDO_DFU_FIRMWARE_SOFTDEVICE_TYPE = 1, 
        //引导装载程序 Bootloader type
        IDO_DFU_FIRMWARE_BOOTLOADER_TYPE,
        //Soft device and bootloader type
        IDO_DFU_FIRMWARE_SOFTDEVICE_BOOTLOADER_TYPE,
        //应用程序 Application type
        IDO_DFU_FIRMWARE_APPLICATION_TYPE,
    };
  </code></pre>
  </details>
* <span id="1.10">SDK记录日志类型 SDK logging type enum</span>
   <details>
   <summary>IDO_RECORD_LOG_TYPE</summary>
   <pre><code> 
      typedef NS_ENUM(NSInteger, IDO_RECORD_LOG_TYPE)  {
        //手动连接手环 Manually connect the bracelet  
        IDO_MANUAL_CONNECT_LOG = 1,
        //自动连接手环 Automatic connection bracelet   
        IDO_AUTO_CONNECT_LOG,
        //手环绑定 Bracelet binding    
        IDO_BIND_DEVICE_LOG,
        //手环解绑 Untie the bracelet 
        IDO_UNBIND_DEVICE_LOG,
        //同步配置 Synchronous configuration  
        IDO_SYNC_CONFIG_LOG,
        //同步健康 步数 Synchronous health sport
        IDO_SYNC_HEALTH_SPORT_LOG,
        //同步健康 睡眠 Synchronous health sleep
        IDO_SYNC_HEALTH_SLEEP_LOG,
        //同步健康 心率 Synchronous health hr
        IDO_SYNC_HEALTH_HR_LOG,
        //同步健康 血压 Synchronous health bp
        IDO_SYNC_HEALTH_BP_LOG,
        //同步活动 Synchronous activity
        IDO_SYNC_ACTIVITY_LOG,
        //同步gps Synchronous gps
        IDO_SYNC_GPS_LOG,
        //同步结束 Synchronous complete
        IDO_SYNC_COMPLETE_LOG,
        //蓝牙写入数据 Bluetooth write data
        IDO_WRITE_DATA_LOG,
        //蓝牙接收数据 Bluetooth receiving data
        IDO_RECEIVE_DATA_LOG
  };
  </code></pre>
  </details>

##<span id="2.0">全局蓝牙引擎 Global Bluetooth Engine</span>

* <span id="2.1">蓝牙信息管理引擎 Bluetooth info manager engine</span>
  <details>
  <summary>IDOBluetoothManagerInfoEngine</summary>
  <pre><code>
    //蓝牙管理中心
    @property (nonatomic,strong) CBCentralManager * centralManager;
     //蓝牙是否开启
    @property (nonatomic,assign,readonly,getter=isPoweredOn) BOOL poweredOn;
    //蓝牙是否连接
    @property (nonatomic,assign,readonly,getter=isConnected) BOOL connected;
    //外围设备
    @property (nonatomic,strong) CBPeripheral  * peripheral;
    //命令服务特征
    @property (nonatomic,strong) CBCharacteristic * commandCharacteristic;
    //健康服务特征
    @property (nonatomic,strong) CBCharacteristic * healthCharacteristic;
    //IDO 蓝牙管理中心
    @property (nonatomic,strong,readonly) IDOBluetoothManager * idoManager;
    //IDO 同步管理中心
    @property (nonatomic,strong,readonly) IDOSyncManager * syncManager;
    //功能列表
    @property (nonatomic,strong) IDOGetDeviceFuncBluetoothModel * funcTableModel;
    //当前手环活动个数
    @property (nonatomic,assign) NSInteger activityCount;
  </code></pre>
  </details>
* <span id="2.2">手环信息管理引擎 Bracelet info manager engine</span>
<details>
  <summary>IDOBluetoothPeripheralInfoEngine</summary>
  <pre><code>
    //当前连接外围设备的uuid
    @property (nonatomic,copy)   NSString * uuidStr;
    //当前连接设备ID
    @property (nonatomic,copy)   NSString * deviceId;
    //当前连接设备名字
    @property (nonatomic,copy)   NSString * deviceName;
    //当前连接设备固件版本号
    @property (nonatomic,copy)   NSString * version;
    //当前连接设备Mac地址
    @property (nonatomic,copy)   NSString * macAddr;
    //当前连接设备授权码
    @property (nonatomic,copy)   NSString * authCode;
    //当前连接设备模式
    @property (nonatomic,assign) NSInteger  deviceMode;
    //当前连接设备状态
    @property (nonatomic,assign) NSInteger  battStatus;
    //当前连接设备电量
    @property (nonatomic,assign) NSInteger  battLevel;
    //当前连接设备是否重启
    @property (nonatomic,assign) NSInteger  rebootFlag;
    //当前连接设备授权码长度
    @property (nonatomic,assign) NSInteger  authLength;
    //当前连接设备是否绑定
    @property (nonatomic,assign) BOOL isBind;
    //当前连接设备是否ota
    @property (nonatomic,assign) BOOL isOta;
  </code></pre>
  </details>
* <span id="2.3">用户信息管理引擎 User info manager engine</span>
  <details>
  <summary>IDOBluetoothUserInfoEngine</summary>
  <pre><code>
    //用户ID
    @property (nonatomic,copy)   NSString * userId;
    //用户生日 (2018-10-01)
    @property (nonatomic,copy)   NSString * birthday;
     //用户目标步数
    @property (nonatomic,assign) NSInteger goalStepCount;
     //目标睡眠 (分钟)
    @property (nonatomic,assign) NSInteger goalSleepMinute;
     //目标卡路里
    @property (nonatomic,assign) NSInteger goalCalorieData;
     //目标距离
    @property (nonatomic,assign) NSInteger goalDistanceData;
     //目标体重 (千克)
    @property (nonatomic,assign) NSInteger goalWeight;
     //用户性别
    @property (nonatomic,assign) NSInteger sex;
     //用户体重
    @property (nonatomic,assign) NSInteger weight;
     //用户升高
    @property (nonatomic,assign) NSInteger height;
     //是否登陆
    @property (nonatomic,assign) BOOL isLogin;
   </code></pre>
   </details>
* <span id="2.4">应用信息管理引擎 Application info manager engine</span>
  <details>
  <summary>IDOBluetoothAppInfoEngine</summary>
  <pre><code>
     //设备名字
    @property (nonatomic,copy) NSString * iphoneName;
     //手机系统版本
    @property (nonatomic,copy) NSString * sysVersion;
    //sdk版本
    @property (nonatomic,copy) NSString * sdkVersion;
   </code></pre>
   </details>
* <span id="2.5">单位信息管理引擎 Unit info manager engine</span>
  <details>
  <summary>IDOBluetoothUnitInfoEngine</summary>
  <pre><code>
      //时间格式是否12小时制
    @property (nonatomic,assign) BOOL is12Hour;
     //语言单位
    @property (nonatomic,assign) NSInteger language;
     //距离单位
    @property (nonatomic,assign) NSInteger distUnit;
     //体重单位
    @property (nonatomic,assign) NSInteger weightUnit;
     //温度单位
    @property (nonatomic,assign) NSInteger tempUnit;
     //走路步伐单位
    @property (nonatomic,assign) NSInteger strideWalkUnit;
     //跑步步伐单位
    @property (nonatomic,assign) NSInteger strideRunUnit;
   </code></pre>
   </details>
   
##<span id="3.0">获取错误码含义 Gets an error code comment</span>
* <span id="3.1">获取错误码含义 Gets an error code comment</span>
  <details>
  <summary>IDOErrorCodeToStr</summary>
  <p> 
  每个命令都会callback返回一个错误码,开发人员可以通过返回的错误转换字符串判断错误码的含义。
  Each command returns an error code called callback, and the developer can     
  determine the meaning of the error code by the returned error conversion string.
  </p>
  <pre><code>
     //错误码转字符串注释
    +(NSString *)errorCodeToStr:(NSInteger)errorCode;
  </code></pre>
  </details>

##<span id="4.0">SDK日志记录 SDK logging</span>
* <span id="4.1">获取设备日志信息 Gets device log information</span>
  <details>
  <summary>获取设备日志函数 Gets the device log function</summary>
  <p> 
   只有在设备处于连接状态，并且不在OTA模式下才能获取设备重启日志。
  <br>Device restart logs can only be obtained if the device is connected and not in OTA mode.
  </p>
  <pre><code>
     //callback 日志信息获取完成回调 Log completes the callback
     +(void)getDeviceLogWithCallback:(void(^)(BOOL isComplete))callback;
  </code></pre>
  </details>
  
* <span id="4.2">设备重启日志目录路径 Device restart log directory path</span>
  <details>
  <summary>重启日志目录路径函数 Restart log directory path function</summary>
  <p> 
   日志存储目录 目录下可能有多个日志文件 日志文件是按日期生成的。七天之前的日志会删除，只保留七天以内的日志。
  <br>There may be multiple log files under the log storage directory. Log files are generated by date. Logs up to seven days old are deleted and only those less than seven days old are retained.
  </p>
  <pre><code>
     //重启日志目录路径 Restart the log directory path
     +(NSString *)rebootLogFloderPath；
  </code></pre>
  </details>

* <span id="4.3">命令执行记录日志目录路径 Command execution log directory path</span>
  <details>
  <summary>命令日志目录路径函数 Command execution log directory path function</summary>
  <p> 
   日志存储目录 目录下可能有多个日志文件 日志文件是按日期生成的。七天之前的日志会删除，只保留七天以内的日志。
  <br>There may be multiple log files under the log storage directory. Log files are generated by date. Logs up to seven days old are deleted and only those less than seven days old are retained.
  </p>
  <pre><code>
     //命令日志目录路径 Command the log directory path
     +(NSString *)recordLogFloaderPath；
  </code></pre>
  </details>

##<span id="5.0">注册SDK服务 Register SDK services</span>
* <span id="5.1">IDOBluetoothServices</span>
  <details>
  <summary>注册SDK服务函数 Register SDK service functions</summary>
  <p> 
   在app启动时需要先注册SDK服务，初始化蓝牙数据，实现蓝牙扫描、连接、绑定、控制、设置、读取、监听功能。
  <br>When the app starts up, it is necessary to register SDK services, initialize bluetooth data, and realize bluetooth scanning, connection, binding, control, setting, reading and listening functions.
  </p>
  <pre><code>
     IDOBluetoothServices * _Nonnull registrationServices(void);
  </code></pre>
  </details>
* <span id="5.2">日志输出控制 Log output control</span>
  <details>
  <summary>日志输出控制函数 Log output control functions</summary>
  <p> 
   协议日志输出控制、SDK日志输出控制、阿里云日志控制。
  <br>Protocol log output control, SDK log output control, ali cloud log control.
  </p>
  <pre><code>
          //是否输出蓝牙sdk运行日志
        @property (nonatomic,copy,nullable) IDOBluetoothServices *_Nonnull(^outputSdkLog)(BOOL isOutput);
         //是否输出蓝牙协议运行日志
        @property (nonatomic,copy,nullable) IDOBluetoothServices *_Nonnull(^outputProtocolLog)(BOOL isOutput);
         //是否添加阿里云日志 默认 No
        @property (nonatomic,copy,nullable) IDOBluetoothServices *_Nonnull(^addAliYunLog)(BOOL isAdd);
  </code></pre>
  </details>
* <span id="5.3">蓝牙连接通知 Bluetooth connection notification</span>
  <details>
  <summary>蓝牙连接通知名字 Bluetooth connection notification name</summary>
  <p> 
   蓝牙扫描、连接状态通知名字和蓝牙扫描、连接错误通知名字。
  <br>Bluetooth scanning, connection status notification name and bluetooth scanning, connection error notification name.
  </p>
  <pre><code>
       // 蓝牙扫描、连接状态通知监听名字
    extern NSString * IDOBluetoothConnectStateNotifyName;
      // 蓝牙扫描、连接过程错误通知监听名字
    extern NSString * IDOBluetoothConnectErrorNotifyName;
  </code></pre>
  </details>

