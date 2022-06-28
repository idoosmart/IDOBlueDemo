//
//  IDOBlueProtocol.h
//  IDOBlueProtocol
//
//  Created by 何东阳 on 2019/5/8.
//  Copyright © 2019 何东阳. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for IDOBlueProtocol.
FOUNDATION_EXPORT double IDOBlueProtocolVersionNumber;

//! Project version string for IDOBlueProtocol.
FOUNDATION_EXPORT const unsigned char IDOBlueProtocolVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <IDOBlueProtocol/PublicHeader.h>

#import <IDOBlueProtocol/IDOSyncEnum.h>
#import <IDOBlueProtocol/IDOLogEnum.h>
#import <IDOBlueProtocol/IDOBindEnum.h>
#import <IDOBlueProtocol/IDOTranEnum.h>
#import <IDOBlueProtocol/IDOSportTypeEnum.h>
#import <IDOBlueProtocol/IDOCommonMacro.h>

#import <IDOBlueProtocol/IDOBluetoothBaseModel.h>
#import <IDOBlueProtocol/IDOBasicBlueDataModel.h>
#import <IDOBlueProtocol/IDOSyncSwimDataModel.h>
#import <IDOBlueProtocol/IDOSyncSpo2DataModel.h>
#import <IDOBlueProtocol/IDOSyncPressureDataModel.h>
#import <IDOBlueProtocol/IDOSyncActivityDataModel.h>
#import <IDOBlueProtocol/IDOSyncBpDataModel.h>
#import <IDOBlueProtocol/IDOSyncHeartRateDataModel.h>
#import <IDOBlueProtocol/IDOSyncSleepDataModel.h>
#import <IDOBlueProtocol/IDOSyncSportDataModel.h>
#import <IDOBlueProtocol/IDOSyncGpsDataModel.h>
#import <IDOBlueProtocol/IDOSyncV3ActivityDataModel.h>
#import <IDOBlueProtocol/IDOSyncV3SleepDataModel.h>
#import <IDOBlueProtocol/IDOSyncV3GpsDataModel.h>
#import <IDOBlueProtocol/IDOSyncV3SportDataModel.h>
#import <IDOBlueProtocol/IDOSyncNoiseDataModel.h>
#import <IDOBlueProtocol/IDOSyncTemperatureDataModel.h>
#import <IDOBlueProtocol/IDOSyncV3BpDataModel.h>
#import <IDOBlueProtocol/IDODataExchangeModel.h>
#import <IDOBlueProtocol/IDOGetInfoBluetoothModel.h>
#import <IDOBlueProtocol/IDOSetInfoBluetoothModel.h>
#import <IDOBlueProtocol/IDOCalculateBluetoothModel.h>
#import <IDOBlueProtocol/IDOWeightBluetoothModel.h>
#import <IDOBlueProtocol/IDOWatchDialInfoModel.h>
#import <IDOBlueProtocol/IDOSyncBreathRateDataModel.h>
#import <IDOBlueProtocol/IDOSyncBodyPowerDataModel.h>

#import <IDOBlueProtocol/IDOSyncManager.h>
#import <IDOBlueProtocol/IDOBluetoothEngine.h>
#import <IDOBlueProtocol/IDOBluetoothServices.h>
#import <IDOBlueProtocol/IDOErrorCodeToStr.h>
#import <IDOBlueProtocol/IDORecordDeviceLog.h>
#import <IDOBlueProtocol/IDOBlueDataResponse.h>

#import <IDOBlueProtocol/IDOFoundationCommand.h>
#import <IDOBlueProtocol/IDODataMigrationManager.h>
#import <IDOBlueProtocol/IDOTransferFileManager.h>
#import <IDOBlueProtocol/IDOWatchDialManager.h>
#import <IDOBlueProtocol/IDOMakePhotoManager.h>
#import <IDOBlueProtocol/IDOMessageIconManager.h>
#import <IDOBlueProtocol/IDODataExchangeManager.h>

#import <IDOBlueProtocol/IDOSportIconModel.h>
#import <IDOBlueProtocol/IDOSportIconManager.h>
#import <IDOBlueProtocol/IDOAlexaAudioManager.h>
#import <IDOBlueProtocol/IDOMusicFileManager.h>
#import <IDOBlueProtocol/IDOStatisticsManager.h>
#import <IDOBlueProtocol/IDOSportPlanManager.h>
