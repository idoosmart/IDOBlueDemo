# IDOBluetooth
>IDOBluetooth is suitable for iOS devices and IDO company's bracelet to achieve bluetooth connection control framework library. Based on the bluetooth framework of iOS system, it extends the abstraction of bluetooth scanning, connection, binding, control, setting, reading, listening and other functions. It USES the protocol library written by c to realize the conversion of bluetooth data and logical processing of data synchronization process, which reduces the error of bluetooth communication and improves the speed and accuracy of bluetooth communication. The feature-rich API is easy to use and very enjoyable to use.

## How To Get Started

* Download [IDOBluetooth](https://github.com/idoosmart/IDOBluetooth/archive/master.zip) and try the accompanying iPhone sample application;
* View the <a href="https://idoosmart.github.io/IDOBluetooth.API/" target="_blank">documentation</a> to fully understand all apis provided in IDOBluetooth;
 
## Requirements
| IDOBluetooth version | minimum iOS target| notes |
| :------:| :------: | :------: |
| 3.1.4 | iOS 8.0 | Only the objective-c file in the project needs to add an empty swift file |
| 3.1.8 | iOS 8.0 | Xcode 10.2.1 |

## Project configuration
* Reference header file
  <br>![image](/images/7.png)
  <br>
* Project demo directory
  <br>![image](/images/1.png)
  <br>
* Project configuration
  <br>![image](/images/2.png)
  <br>
  <br>![image](/images/3.png)
  <br>
  <br>![image](/images/4.png)
  <br>
  <br>![image](/images/5.png)
  <br>
  <br>![image](/images/6.png)
  <br>
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

```objc
registrationServices(YES).outputSdkLog(YES).outputProtocolLog(YES);
```
## <span id="3.0">Start SDK bluetooth management</span>
* <p>When you apply an unconnected binding device, you need to create a view controller to implement the SDK bluetooth proxy. Scanning peripheral devices, the agent will return device collection, display in the list, select the device that needs to be connected, and return device information and whether the device is in OTA mode after successful connection, and there will be an error callback if the connection fails. The default scanning signal filter parameter is 80, and the automatic scanning connection timeout time is 20 seconds.</p>

```objc
<IDOBluetoothManagerDelegate>
[IDOBluetoothManager shareInstance].delegate = self;
[IDOBluetoothManager shareInstance].rssiNum = 100;

#pragma mark === IDOBluetoothManagerDelegate ===
- (BOOL)bluetoothManager:(IDOBluetoothManager *)manager
           centerManager:(CBCentralManager *)centerManager
    didConnectPeripheral:(CBPeripheral *)peripheral
               isOatMode:(BOOL)isOtaMode
{
  //Device connected successfully
}

- (void)bluetoothManager:(IDOBluetoothManager *)manager
              allDevices:(NSArray<IDOPeripheralModel *> *)allDevices
              otaDevices:(NSArray<IDOPeripheralModel *> *)otaDevices
{
  //Scanning peripherals
}

- (void)bluetoothManager:(IDOBluetoothManager *)manager
          didUpdateState:(IDO_BLUETOOTH_MANAGER_STATE)state
{
    //Bluetooth manages center state
}

- (void)bluetoothManager:(IDOBluetoothManager *)manager
  connectPeripheralError:(NSError *)error
{
    //Returns an error
}
```
## <span id="4.0">Binding bracelet</span>

* <p>Device under the connection state, binding device initialization "IDOSetBindingInfoBluetoothModel" object, to bind command, returns the binding state and command error code, binding state is divided into: binding, has been binding, binding failures, success requires authorization binding, refused to binding. The mode of "need authorization binding" requires the user to fill in the authorization code and click ok before binding the device. Authorization information is stored only in the "require authorization binding" mode; other bindings are not.</p>

```objc
IDOSetBindingInfoBluetoothModel * model = [[IDOSetBindingInfoBluetoothModel alloc]init];
    __weak typeof(self) weakSelf = self;
    [IDOFoundationCommand bindingCommand:model callback:^(IDO_BIND_STATUS status, int errorCode) {
        __strong typeof(self) strongSelf = weakSelf;
        if (errorCode == 0) {
            if (status == IDO_BLUETOOTH_BIND_SUCCESS) { //bind success
            
            }else if (status == IDO_BLUETOOTH_BINDED) { //binded
                
            }else if (status == IDO_BLUETOOTH_BIND_FAILED) { //bind failed
                
            }else if (status == IDO_BLUETOOTH_NEED_AUTH) { //bind need auth
                [strongSelf showAuthView];
            }else if (status == IDO_BLUETOOTH_REFUSED_BINDED) { //refused binded
                
            }
        }else { //bind failed
            
        }
    }];
    
     __weak typeof(self) weakSelf = self;
IDOSetBindingInfoBluetoothModel * model = [IDOSetBindingInfoBluetoothModel currentModel];
model.authCode = codeStr;
[IDOFoundationCommand setAuthCodeCommand:model callback:^(int errorCode) {
    __strong typeof(self) strongSelf = weakSelf;
    if (errorCode == 0) {
    
    }else {
        
    }
}];
    
```
## <span id="5.0">Synchronize bracelet data</span>

* <p>Synchronizing device data is a very important function. Synchronization procedures recommend against executing other commands, even if they are invalid. Synchronous configuration is performed after the first successful binding of the connected device. Otherwise, NO is not synchronized. Progress is returned in the synchronization process, and a completion block will be returned after each item is synchronized. Judging by the synchronization status, synchronization is completed, and the synchronization log will be returned in the synchronization process.</p>

```objc
// Synchronizing log  
 [IDOSyncManager syncDataLogInfoCallback:^(IDO_CURRENT_SYNC_TYPE syncType, NSString * _Nullable logStr) {
 
 }];
 // Synchronizing complete
[IDOSyncManager syncDataCompleteCallback:^(IDO_SYNC_COMPLETE_STATUS stateCode, NSString * _Nullable stateInfo) {

}];
// Synchronizing progress
[IDOSyncManager syncDataProgressCallback:^(float progress) {

 }];
 // Synchronization configuration is performed after the first binding of the connecting device is successful. In other cases, NO is not synchronized.
[IDOSyncManager shareInstance].isSave = YES;
IDOSyncManager.startSync(YES or NO);
```
## <span id="6.0">Query bracelet data</span>
* <P>The general method of Bluetooth command initialization model is "+(__kindof IDOBluetoothBaseModel*)currentModel" in each class object. This method queries the database first, if the query fails to initialize the new model object. Synchronized data is an encapsulation method for querying data in each model class. Only encapsulated method queries will have detailed data, while the data queried by custom query methods will not have detailed data. It is recommended that database operations not delete database data, but only insert and update data. Current data can only be queried after synchronization is completed. The unsynchronized data is still in the hand ring, and the data can not be queried locally.</P>

```objc
1、activity query
 //The current device queries an event details based on the event start time
 + (__kindof IDOSyncActivityDataInfoBluetoothModel *)queryOneActivityDataWithTimeStr:(NSString *)timeStr macAddr:(NSString *)macAddr;

 //The current device queries the collection of events for a certain day based on the date
 + (NSArray <__kindof IDOSyncActivityDataInfoBluetoothModel *>*)queryOneDayActivityDataWithMacAddr:(NSString *)macAddr year:(NSInteger)year
 month:(NSInteger)month day:(NSInteger)day;                                     

//Current Device Activity Paging Query Activity Collection
+ (NSArray <__kindof IDOSyncActivityDataInfoBluetoothModel *>*)queryOnePageActivityDataWithPageIndex:(NSInteger)pageIndex
numOfPage:(NSInteger)numOfPage macAddr:(NSString *)macAddr;                                                             

//Current track motion of all devices
+ (NSArray <__kindof IDOSyncActivityDataInfoBluetoothModel *>*)queryAllTrajectorySportActivitysWithMac:(NSString *)macAddr;

//Current equipment all light sports
+ (NSArray <__kindof IDOSyncActivityDataInfoBluetoothModel *>*)queryAllLightSportActivitysWithMac:(NSString *)macAddr;

2、blood pressure query
//Query all data of the current device for 12 months in a certain year (If there is no data in the current month, an empty data object will be created, and the data larger than the current month will not be accumulated)
+ (NSArray <NSArray<__kindof IDOSyncBpDataInfoBluetoothModel *>*> *)queryOneYearBloodPressuresWithYear:(NSInteger)year macAddr:(NSString *)macAddr isQueryItems:(BOOL)isQuery;

//Query all data of the current device for a certain month (If there is no data on the query day, an empty data object will be created, which is larger than the data of the day)
+ (NSArray <__kindof IDOSyncBpDataInfoBluetoothModel *>*)queryOneMonthBloodPressuresWithYear:(NSInteger)year month:(NSInteger)month
macAddr:(NSString *)macAddr datesOfMonth:(NSArray <NSString *>**)dates isQueryItems:(BOOL)isQuery;                                                                        

//Query all data of the current device for a certain week (If there is no data on the day of the query, an empty data object will be created, and the data larger than the current day will not be accumulated)
+ (NSArray <__kindof IDOSyncBpDataInfoBluetoothModel *>*)queryOneWeekBloodPressuresWithWeekIndex:(NSInteger)weekIndex weekStartDay:(NSInteger)weekStartDay macAddr:(NSString *)macAddr datesOfWeek:(NSArray <NSString *>**)dates isQueryItems:(BOOL)isQuery;                                                                                 

//Query current device blood pressure data for one day and have detailed data
+ (__kindof IDOSyncBpDataInfoBluetoothModel *)queryOneDayBloodPressureDetailWithMac:(NSString *)macAddr year:(NSInteger)year
month:(NSInteger)month day:(NSInteger)day;                                                                    

//Query the current day's blood pressure data of the device and have detailed data
+ (__kindof IDOSyncBpDataInfoBluetoothModel *)queryLastDayBloodPressureDetailWithMac:(NSString *)macAddr;

//Query all blood pressure data The number of blood pressure packets is greater than 0
+ (NSArray <__kindof IDOSyncBpDataInfoBluetoothModel *>*)queryAllBloodPressuresWithMac:(NSString *)macAddr;

3、heart rate query
//Query all data of the current device for 12 months in a certain year (If there is no data in the query month, an empty data object will be created, and the data larger than the current month will not be accumulated)
+ (NSArray <NSArray<__kindof IDOSyncHrDataInfoBluetoothModel *>*> *)queryOneYearHearRatesWithYear:(NSInteger)year macAddr:(NSString *)macAddr isQueryItems:(BOOL)isQuery;

//Query all data of the current device for a certain month (If there is no data on the query day, an empty data object will be created, which is larger than the data of the day)
+ (NSArray <__kindof IDOSyncHrDataInfoBluetoothModel *>*)queryOneMonthHearRatesWithYear:(NSInteger)year month:(NSInteger)month
macAddr:(NSString *)macAddr datesOfMonth:(NSArray <NSString *>**)dates isQueryItems:(BOOL)isQuery;                                                                                                      

//Query all data of the current device for a certain week (If there is no data on the day of the query, an empty data object will be created, and the data larger than the current day will not be accumulated)
+ (NSArray <__kindof IDOSyncHrDataInfoBluetoothModel *>*)queryOneWeekHearRatesWithWeekIndex:(NSInteger)weekIndex weekStartDay:(NSInteger)weekStartDay macAddr:(NSString *)macAddr datesOfWeek:(NSArray <NSString *>**)dates isQueryItems:(BOOL)isQuery;                                                                   

//Query current heart rate data of the current device and have detailed data
+ (__kindof IDOSyncHrDataInfoBluetoothModel *)queryOneDayHearRatesDetailWithMac:(NSString *)macAddr year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;
                                                                                                                                                    
//Query all heart rate data The number of heart rate packets is greater than 0
+ (NSArray <__kindof IDOSyncHrDataInfoBluetoothModel *>*)queryAllHearRatesWithMac:(NSString *)macAddr;

4、sleep query
//Query all data of the current device for 12 months in a certain year (If there is no data in the current month, an empty data object will be created, and the data larger than the current month will not be accumulated)
+ (NSArray <NSArray <__kindof IDOSyncSleepDataInfoBluetoothModel *>*>*)queryOneYearSleepsWithYear:(NSInteger)year macAddr:(NSString *)macAddr isQueryItems:(BOOL)isQuery;

// Query all data of the current device for a certain month (If there is no data on the query day, an empty data object will be created, which is larger than the data of the day)
+ (NSArray <__kindof IDOSyncSleepDataInfoBluetoothModel *>*)queryOneMonthSleepsWithYear:(NSInteger)year month:(NSInteger)month
macAddr:(NSString *)macAddr datesOfMonth:(NSArray <NSString *>**)dates isQueryItems:(BOOL)isQuery;
                                                                                                                                                      
//Query all data of the current device for a certain week (If there is no data on the day of the query, an empty data object will be created, and the data larger than the current day will not be accumulated)
+ (NSArray <__kindof IDOSyncSleepDataInfoBluetoothModel *>*)queryOneWeekSleepsWithWeekIndex:(NSInteger)weekIndex weekStartDay:(NSInteger)weekStartDay macAddr:(NSString *)macAddr datesOfWeek:(NSArray <NSString *>**)dates isQueryItems:(BOOL)isQuery;
                                                                                                                                                       
//Query the current device's sleep data and have detailed data
+ (__kindof IDOSyncSleepDataInfoBluetoothModel *)queryOneDaySleepsDetailWithMac:(NSString *)macAddr year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;
                                                                                                                                                    
//Query all sleep data Sleep duration is greater than 0
+ (NSArray <__kindof IDOSyncSleepDataInfoBluetoothModel *>*)queryAllSleepsWithMac:(NSString *)macAddr;

5、sport query
//Query all data of the current device for 12 months in a certain year (If there is no data in the current month, an empty data object will be created, and the data larger than the current month will not be accumulated)
+ (NSArray <NSArray <__kindof IDOSyncSportDataInfoBluetoothModel *> *>*)queryOneYearSportsWithYear:(NSInteger)year macAddr:(NSString *)macAddr isQueryItems:(BOOL)isQuery;

//Query all data of the current device for a certain month (If there is no data on the query day, an empty data object will be created, which is larger than the data of the day)
+ (NSArray <__kindof IDOSyncSportDataInfoBluetoothModel *>*)queryOneMonthSportsWithYear:(NSInteger)year month:(NSInteger)month
macAddr:(NSString *)macAddr datesOfMonth:(NSArray <NSString *>**)dates isQueryItems:(BOOL)isQuery;
                                                                                  
//Query all data of the current device for a certain week (If there is no data on the day of the query, an empty data object will be created, and the data larger than the current day will not be accumulated)                                                                       
+ (NSArray <__kindof IDOSyncSportDataInfoBluetoothModel *>*)queryOneWeekSportsWithWeekIndex:(NSInteger)weekIndex weekStartDay:(NSInteger)weekStartDay macAddr:(NSString *)macAddr datesOfWeek:(NSArray <NSString *>**)dates isQueryItems:(BOOL)isQuery;
                                                                               
//Query the current device's mobile data and have detailed data                                                                                
+ (__kindof IDOSyncSportDataInfoBluetoothModel *)queryOneDaySportDetailWithMac:(NSString *)macAddr year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

//Query all motion data Steps greater than 0
+ (NSArray <__kindof IDOSyncSportDataInfoBluetoothModel *>*)queryAllSportsWithMac:(NSString *)macAddr;

6、GPS query

//Querying the GPS information of an activity based on the timestamp
+ (__kindof IDOSyncGpsDataInfoBluetoothModel *)queryOneActivityCoordinatesWithTimeStr:(NSString *)timeStr macAddr:(NSString *)macAddr;

//Query whether an activity has a track based on a timestamp
+ (BOOL)queryActivityHasCoordinatesWithTimeStr:(NSString *)timeStr macAddr:(NSString *)macAddr;
```
## <span id="7.0">Average method of health data calculation</span>
* <p>The encapsulated method of calculating the average health data is designed according to the requirements of VeryFitPro project. If the project needs are different, the data can be calculated by itself according to the query data.</p>

```objc
1、 blood pressure
// Calculate the average blood pressure per day
+ (__kindof IDOCalculateBpBluetoothModel *)calculateOneDayBpDataWithBpModel:(__kindof IDOSyncBpDataInfoBluetoothModel *)model；

//Calculate the average blood pressure for one week and one month
+ (__kindof IDOCalculateBpBluetoothModel *)calculateOneMonthOrWeekBpDataWithBpModels:(NSArray <__kindof IDOSyncBpDataInfoBluetoothModel *>*)models allDayCalculateBpModels:(NSArray <IDOCalculateBpBluetoothModel *> **)calculateBpModels;

2、heart rate
//Calculate the average heart rate per day
+ (__kindof IDOCalculateHrBluetoothModel *)calculateOneDayHrDataWithHrModel:(__kindof IDOSyncHrDataInfoBluetoothModel *)model;

//Calculate the heart rate average for one week and one month
+ (__kindof IDOCalculateHrBluetoothModel *)calculateOneMonthOrWeekHrDataWithHrModels:(NSArray <__kindof IDOSyncHrDataInfoBluetoothModel *>*)models;

//Calculate the annual heart rate average
+ (__kindof IDOCalculateHrBluetoothModel *)calculateOneYearHrDataWithHrModels:(NSArray <NSArray<__kindof IDOSyncHrDataInfoBluetoothModel *>*> *)models;

3、sleep
//Calculate the average daily sleep
+ (__kindof IDOCalculateSleepBluetoothModel *)calculateOneDaySleepDataWithSleepModel:(__kindof IDOSyncSleepDataInfoBluetoothModel *)model;

//Calculation - Week, January sleep average
+ (__kindof IDOCalculateSleepBluetoothModel *)calculateOneMonthOrWeekSleepDataWithSleepModels:(NSArray <__kindof IDOSyncSleepDataInfoBluetoothModel *>*)models;

//Calculate the average sleep value for one year
+ (__kindof IDOCalculateSleepBluetoothModel *)calculateOneYearSleepDataWithSleepModels:(NSArray <NSArray<__kindof IDOSyncSleepDataInfoBluetoothModel *>*> *)models;

4、sport
//Calculate the average number of steps per day
+ (__kindof IDOCalculateSportBluetoothModel *)calculateOneDaySportDataWithSportModel:(__kindof IDOSyncSportDataInfoBluetoothModel *)model;

//Calculation - Week, January Step Average
+ (__kindof IDOCalculateSportBluetoothModel *)calculateOneMonthOrWeekSportDataWithSportModels:(NSArray <__kindof IDOSyncSportDataInfoBluetoothModel *>*)models;

//Calculate the average number of steps in a year
+ (__kindof IDOCalculateSportBluetoothModel *)calculateOneYearSportDataWithSportModels:(NSArray <NSArray<__kindof IDOSyncSportDataInfoBluetoothModel *>*> *)models;
                                                             
```
## <span id="8.0">Bluetooth common commands</span>
* <p>Introduction to Common Command Usage</p>

```objc
//get func table
[IDOFoundationCommand getFuncTableCommand:^(int errorCode,   IDOGetDeviceFuncBluetoothModel * _Nullable data) {
    if (errorCode == 0) {
    }else {
    }
 }];
 
// get mac address
[IDOFoundationCommand getMacAddrCommand:^(int errorCode, IDOGetMacAddrInfoBluetoothModel * _Nullable data) {
    if (errorCode == 0) {
    }else {
    }
}];

//get device info
[IDOFoundationCommand getDeviceInfoCommand:^(int errorCode, IDOGetDeviceInfoBluetoothModel * _Nullable data) {
    if (errorCode == 0) {
        }else {
        }
}];

//get live data
[IDOFoundationCommand getLiveDataCommand:^(int errorCode, IDOGetLiveDataBluetoothModel * _Nullable data) {
  if (errorCode == 0) {
        }else {
        }
}];

//get activity count
[IDOFoundationCommand getActivityCountCommand:^(int errorCode, IDOGetActivityCountBluetoothModel * _Nullable data) {
 if (errorCode == 0) {
        }else {
        }
}];

//get gps info
[IDOFoundationCommand getGpsInfoCommand:^(int errorCode, IDOGetGpsInfoBluetoothModel * _Nullable data) {
     if (errorCode == 0) {
        }else {
        }
}];

//get notice status
[IDOFoundationCommand getNoticeStatusCommand:^(int errorCode, IDOSetNoticeInfoBuletoothModel * _Nullable data) {
      if (errorCode == 0) {
        }else {
        }
}];
```

```objc
//set user info
userModel = [IDOSetUserInfoBuletoothModel currentModel];
[IDOFoundationCommand setUserInfoCommand:userModel callback:^(int errorCode) {
   if (errorCode == 0) {
    }else {
    }
}];

//set target info
userModel = [IDOSetUserInfoBuletoothModel currentModel];
[IDOFoundationCommand setTargetInfoCommand:userModel callback:^(int errorCode) {
    if (errorCode == 0) {
    }else {
    }
}];

//set find phone
findPhoneModel = [IDOSetFindPhoneInfoBuletoothModel currentModel];
[IDOFoundationCommand setFindPhoneCommand:findPhoneModel callback:^(int errorCode){
    if (errorCode == 0) {
    }else {
    }
}];

//set hand up
handUpModel = [IDOSetHandUpInfoBuletoothModel currentModel];
[IDOFoundationCommand setHandUpCommand:handUpModel callback:^(int errorCode) {
    if (errorCode == 0) {
    }else {
    }
}];

//set left right hand
leftOrRightModel = [IDOSetLeftOrRightInfoBuletoothModel currentModel];
[IDOFoundationCommand setLeftRightHandCommand:leftOrRightModel callback:^(int errorCode) {
    if (errorCode == 0) {
    }else {
    }
}];

//set prevent lost
preventLostModel = [IDOSetPreventLostInfoBuletoothModel currentModel];
[IDOFoundationCommand setPreventLostCommand:preventLostModel callback:^(int errorCode) {
      if (errorCode == 0) {
     }else {
     }
}];

//set display mode
displayModel = [IDOSetDisplayModeInfoBluetoothModel currentModel];
[IDOFoundationCommand setDisplayModeCommand:displayModel callback:^(int errorCode) {
     if (errorCode == 0) {
     }else {
     }
}];

//set notice 
noticeModel  = [IDOSetNoticeInfoBuletoothModel currentModel];
pairingModel = [IDOSetPairingInfoBuletoothModel currentModel];
if (!pairingModel.isPairing) {
[IDOFoundationCommand setBluetoothPairingCommandWithCallback:^(int errorCode) {
    if(errorCode == 0) {
    }else {
    }
}];
}else {
    [IDOFoundationCommand setSwitchNoticeCommand:noticeModel callback:^(int errorCode) {
        if(errorCode == 0) {
        }else {
        }
    }];
}

// set time
timeModel = [IDOSetTimeInfoBluetoothModel currentModel];
[IDOFoundationCommand setCurrentTimeCommand:timeModel callback:^(int errorCode) {
         if(errorCode == 0) {
        }else {
        }
 }];
 
//set one alarm 
 NSArray * alarms = [IDOSetAlarmInfoBluetoothModel queryAllNoOpenAlarms];
 alarmModel = [alarms firstObject];
 [IDOFoundationCommand setAlarmCommand:alarmModel callback:^(int errorCode) {
     if(errorCode == 0) {
        }else {
        }
 }];
 
 //set all alarms 
 NSArray * alarms = [IDOSetAlarmInfoBluetoothModel queryAllAlarms];
 [IDOFoundationCommand setAllAlarmsCommand:alarms callback:^(int errorCode) {
    if(errorCode == 0) {
        }else {
        }        
 }];
 
 //set long sit
 longSitModel = [IDOSetLongSitInfoBuletoothModel currentModel];
 [IDOFoundationCommand setLongSitCommand:longSitModel callback:^(int errorCode) {
        if(errorCode == 0) {
        }else {
        }   
 }];
 
 //set weather 
 weatherSwitchModel = [IDOSetWeatherSwitchInfoBluetoothModel currentModel];
 weatherDataModel   = [IDOSetWeatherDataInfoBluetoothModel currentModel];
 [IDOFoundationCommand setWeatherCommand:weatherSwitchModel callback:^(int errorCode) {
        if(errorCode == 0) {
        }else {
        }   
}];
[IDOFoundationCommand setWeatherDataCommand:weatherDataModel callback:^(int errorCode) {
        if(errorCode == 0) {
        }else {
        }  
}];

//set hr mode
hrModel = [IDOSetHrModeInfoBluetoothModel currentModel];
[IDOFoundationCommand setHrModeCommand:hrModel callback:^(int errorCode) {
        if(errorCode == 0) {
        }else {
        }  
}];

//set hr interval
hrIntervalModel = [IDOSetHrIntervalInfoBluetoothModel currentModel];
[IDOFoundationCommand setHrIntervalCommand:hrIntervalModel callback:^(int errorCode) {
        if(errorCode == 0) {
        }else {
        } 
}];

//set no disturb
noDisturbMode = [IDOSetNoDisturbModeInfoBluetoothModel currentModel];
[IDOFoundationCommand setNoDisturbModeCommand:noDisturbMode callback:^(int errorCode) {
        if(errorCode == 0) {
        }else {
        } 
}];

//set unit
unitMode = [IDOSetUnitInfoBluetoothModel currentModel];
[IDOFoundationCommand setUnitCommand:unitMode callback:^(int errorCode) {
       if(errorCode == 0) {
        }else {
        } 
}];

//set one key sos
oneKeySosModel = [IDOSetOneKeySosInfoBuletoothModel currentModel];
[IDOFoundationCommand setOneKeySosCommand:oneKeySosModel callback:^(int errorCode) {
         if(errorCode == 0) {
        }else {
        } 
}];

//set shortcut
shortcutModel = [IDOSetShortcutInfoBluetoothModel currentModel];
[IDOFoundationCommand setShortcutCommand:shortcutModel callback:^(int errorCode) {
         if(errorCode == 0) {
        }else {
        } 
}];

//set sport shortcut
sportShortcutModel = [IDOSetSportShortcutInfoBluetoothModel currentModel];
[IDOFoundationCommand setSportModeSelectCommand:sportShortcutModel callback:^(int errorCode) {
           if(errorCode == 0) {
        }else {
        } 
}];

// set sport mode sort
sportModeSortModel = [IDOSetSportSortingInfoBluetoothModel currentModel];
[IDOFoundationCommand setSportModeSortCommand:sportModeSortModel callback:^(int errorCode) {
    if(errorCode == 0) {

    }else {

    }
}];

//set screen
screenModel = [IDOSetScreenBrightnessInfoBluetoothModel currentModel];
 [IDOFoundationCommand setScreenBrightnessCommand:screenModel callback:^(int errorCode) {
            if(errorCode == 0) {
        }else {
        } 
}];

//set music switch
musicModel = [IDOSetMusicOpenInfoBuletoothModel currentModel];
pairingModel = [IDOSetPairingInfoBuletoothModel currentModel];
if(!pairingModel.isPairing) {
    [IDOFoundationCommand setBluetoothPairingCommandWithCallback:^(int errorCode) {
            if(errorCode == 0) {
              [IDOFoundationCommand setOpenMusicCommand:musicMode callback:^(int errorCode) {
                     if(errorCode == 0) {
                     }else {
                     }
               }];
            }else {
            } 
    }];
} else {
[IDOFoundationCommand setOpenMusicCommand:musicModel callback:^(int errorCode) {
     if(errorCode == 0) {
     }else {
     }
 }];
}

//set gps info
gpsMode = [IDOSetGpsConfigInfoBluetoothModel currentModel];
[IDOFoundationCommand setGpsInfoCommand:gpsMode callback:^(int errorCode) {
     if(errorCode == 0) {
     }else {
     }
}];

//set hot start 
hotStartMode = [IDOGetHotStartParamBluetoothModel currentModel];
[IDOFoundationCommand setHotStartParamCommand:hotStartMode callback:^(int errorCode) {
     if(errorCode == 0) {
     }else {
     }
}];

//set watch dia
watchDiaModel = [IDOSetWatchDiaInfoBluetoothModel currentModel];
[IDOFoundationCommand setWatchDiaCommand:watchDiaModel callback:^(int errorCode) {
     if(errorCode == 0) {
     }else {
     }
}];

```
## <span id="9.0">AGPS file updates</span>
* <p>AGPS file upgrade needs to be noted: 15 seconds after the hand ring connects app and the query GPS status is not running to update the AGPS file, otherwise it will cause update failure</p>

```objc
//get gps status
[IDOFoundationCommand getGpsStatusCommand:^(int errorCode, IDOGetGpsStatusBluetoothModel * _Nullable data) {
    if (data.gpsRunStatus == 0) {
    //AGPS file start transfer
[IDOUpdateAgpsManager updateAgpsWithPath:filePath prepareCallback:^(int errorCode) {
        if(errorCode == 0) {
         }else {
         }                
     }];
     
     //AGPS file transfer completed, start writing
    [IDOUpdateAgpsManager updateAgpsTransmissionComplete:^(int errorCode){                         
         if(errorCode == 0) {
         }else {
     }    
        } updateComplete:^(int errorCode) { //Write file complete
            if(errorCode == 0) {
             }else {
             }    
     }];
     
     //AGPS file transfer schedule
    [IDOUpdateAgpsManager updateAgpsProgressCallback:^(int progress) {                         
    }];
 }else {
 }
}];
```
## <span id="10.0">Firmware update (OTA)</span>
* <P>SDK upgrade function is only responsible for firmware upgrade. As for firmware version judgment and firmware download, it is not handled. Attention should be paid to the integrity of firmware download, the firmware local sandbox path should be passed in when upgrading, and the upgrade progress and completion status should be monitored, as well as the error proxy callback.</P>

```objc
<IDOUpdateManagerDelegate>
[IDOUpdateFirmwareManager shareInstance].delegate = self;
- (NSString *)currentPackagePathWithUpdateManager:(IDOUpdateFirmwareManager *)manager
{
   // firmware file path
    return filePath;
}

- (void)updateManager:(IDOUpdateFirmwareManager *)manager
                state:(IDO_UPDATE_STATE)state
{
    if (state == IDO_UPDATE_COMPLETED) { //update complete
    }else { //updating
       
    }
}

- (void)updateManager:(IDOUpdateFirmwareManager *)manager updateError:(NSError *)error
{
   // update error
}

- (void)updateManager:(IDOUpdateFirmwareManager *)manager
             progress:(float)progress
              message:(NSString *)message
{
 // update progress (0-1)
}

@optional
- (IDO_UPDATE_DFU_FIRMWARE_TYPE)selectDfuFirmwareTypeWithUpdateManager:(IDOUpdateFirmwareManager * _Nullable)manager
{
    // update type
    return IDO_DFU_FIRMWARE_APPLICATION_TYPE;
}

```


