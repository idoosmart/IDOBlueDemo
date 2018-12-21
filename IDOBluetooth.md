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
##主要功能API介绍 Introduction to main function API

* [1.0 旧数据迁移 Old data migration](#1.0)  
* [2.0 注册SDK服务 Register SDK services](#2.0)  
* [3.0 启动SDK蓝牙管理 Start SDK bluetooth management](#3.0) 
* [4.0 绑定手环 Binding bracelet](#4.0) 
* [5.0 同步手环数据 Synchronize bracelet data](#5.0) 
* [6.0 查询手环数据 Query bracelet data](#6.0) 
* [7.0 计算健康数据平均值方法 Average method of health data calculation](#7.0) 
* [8.0 蓝牙常用命令 Bluetooth common commands](#8.0) 
* [9.0 AGPS文件更新 AGPS file updates](#9.0) 
* [10.0 固件(OTA)升级 Firmware update(OTA)](#10.0) 


