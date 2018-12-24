# IDOBluetooth
>IDOBluetooth is suitable for iOS devices and IDO company's bracelet to achieve bluetooth connection control framework library. Based on the bluetooth framework of iOS system, it extends the abstraction of bluetooth scanning, connection, binding, control, setting, reading, listening and other functions. It USES the protocol library written by c to realize the conversion of bluetooth data and logical processing of data synchronization process, which reduces the error of bluetooth communication and improves the speed and accuracy of bluetooth communication. The feature-rich API is easy to use and very enjoyable to use.

## How To Get Started

* Download IDOBluetooth and try the accompanying iPhone sample application;
* View the documentation to fully understand all apis provided in IDOBluetooth;
 
## Requirements
| IDOBluetooth version | minimum iOS target| notes |
| :------:| :------: | :------: |
| 3.0.0 | iOS 8.0 | Only the objective-c file in the project needs to add an empty swift file |

## Architecture

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
## Introduction to main function API

* [1.0 Old data migration](#1.0)  
* [2.0 Register SDK services](#2.0)  
* [3.0 Start SDK bluetooth management](#3.0) 
* [4.0 Binding bracelet](#4.0) 
* [5.0 Synchronize bracelet data](#5.0) 
* [6.0 Query bracelet data](#6.0) 
* [7.0 Average method of health data calculation](#7.0) 
* [8.0 Bluetooth common commands](#8.0) 
* [9.0 AGPS file updates](#9.0) 
* [10.0 Firmware update (OTA)](#10.0) 

## <span id="1.0">Old data migration</span>
* <p>Only in the old project need to do data migration, the old database needs to be migrated to the new database, optimize the operation of the database, reduce data redundancy, improve program performance. Before performing data migration, it is necessary to determine whether the old database exists or not, and after data migration, it is necessary to pass in a collection of directory names that cannot be deleted to ensure data integrity. After the migration, the data that is not retained will be deleted and the old database will be copied to the new directory, which can be obtained through the path.</p>

```objc
  if ([IDODataMigrationManager isNeedMigration]) {
        [IDODataMigrationManager dataMigrationProgressBlock:^(float progress) {
            
        }];
        [IDODataMigrationManager dataMigrationWithFileNames:@[@"user directory name"]
                                              completeBlock:^(BOOL isSuccess) {
            
        }];
        // start migration is the data currently downloaded for the cloud?
        [IDODataMigrationManager dataMigrationStart:YES];
    }
```
* <p>VeryFitPro project is to upload database files to save and update. The downloaded database is an old database that needs to be migrated first. When the migration is complete, the local new database is transferred to a json file and uploaded to the server. If you download the data as a json file, you first merge the new database and then transfer the merged json file to the server.</p>

```objc
 [IDODataMigrationManager dataToJsonFileProgressBlock:^(float progress) {
        
  }];
 [IDODataMigrationManager dataToJsonFileCompleteBlock:^(BOOL isSuccess, NSString *newDirePath) {
        
 }];
 //Directory path for downloaded JSON files
 [IDODataMigrationManager dataToJsonFileStart:@""];
```
## <span id="2.0">Register SDK services</span>
* <p>Register IDOBluetooth SDK service and control the running log output of SDK and protocol library. Aliyun log is temporarily invalid. Note: Bluetooth settings need to add a continuous background configuration when registering services.</p>

```
registrationServices().outputSdkLog(YES).outputProtocolLog(YES);
```
## <span id="3.0">Start SDK bluetooth management</span>


