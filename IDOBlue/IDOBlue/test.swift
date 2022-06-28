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
        initSyncManager().wantToSyncType = IDO_WANT_TO_SYNC_ITEM_TYPE(rawValue: 15)!
        
        
    }
    
    
    
    
}
