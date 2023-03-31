//
//  test.swift
//  IDOBluetoothDemo
//
//  Created by apple on 2018/9/14.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

import Foundation
import IDOBlueProtocol
import UIKit
import IDOBluetooth
import CoreAudioTypes

class test: NSObject{
    
   
   
        
    func test_func() {
//            let config = IDO_WANT_TO_SYNC_ITEM_TYPE(rawValue:1)
//            let health = IDO_WANT_TO_SYNC_ITEM_TYPE(rawValue:2)
//            let activity = IDO_WANT_TO_SYNC_ITEM_TYPE(rawValue:4)
//            let gps = IDO_WANT_TO_SYNC_ITEM_TYPE(rawValue:8)
//        let all_type = [IDO_WANT_TO_SYNC_ITEM_TYPE.CONFIG_ITEM_TYPE,IDO_WANT_TO_SYNC_ITEM_TYPE.HEALTH_ITEM_TYPE,IDO_WANT_TO_SYNC_ITEM_TYPE.ACTIVITY_ITEM_TYPE,IDO_WANT_TO_SYNC_ITEM_TYPE.GPS_ITEM_TYPE]
        initSyncManager().wantToSyncType = IDO_WANT_TO_SYNC_ITEM_TYPE.ALL_ITEM_TYPE
        
        initSyncManager().addSyncComplete!{(stateCode)in
             //Sync complete status
              if stateCode == .GLOBAL_COMPLETE {
              //Query the corresponding cached data after synchronization is complete
              }
        }.addSyncProgess!{(type,progress)in
             //Sync item, sync progress (0-1)
        }.addSyncHrv!{(json)in
            let model = IDOSyncBodyPowerDataModel.bodyPowerDataJsonString(toObjectModel: json)
            //Sync item, sync progress (0-1)
       }.addSyncBloodOxygen!{(json)in
           let model = IDOSyncSpo2DataModel.bloodOxygenDataJsonString(toObjectModel: json)
           //Sync item, sync progress (0-1)
      }.addSyncFailed!{(errorCode)in
             //sync failed
        }.addSyncConfigInitData!{(type)in
             //According to the returned synchronization type, return the initialized data model collection according to the business requirements
             //Refer to the above objc code execution
             return [];
        }.mandatorySyncConfig!(true);// The binding needs to perform synchronization configuration, and subsequent reconnection does not need to perform synchronization configuration
        
        IDOSyncManager.startSync()
        
        
    }
    
    
    
    
}
