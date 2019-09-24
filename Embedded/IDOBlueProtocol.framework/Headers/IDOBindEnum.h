//
//  IDOBindEnum.h
//  IDOBluetoothInternal
//
//  Created by 何东阳 on 2019/8/3.
//  Copyright © 2019 何东阳. All rights reserved.
//

#ifndef IDOBindEnum_h
#define IDOBindEnum_h

/**
 * 绑定状态枚举
 * Binding status enumeration
 */
typedef NS_ENUM(NSInteger, IDO_BIND_STATUS) {
    /**
     * 绑定失败
     * Binding failed
     */
    IDO_BLUETOOTH_BIND_FAILED = 0,
    
    /**
     * 绑定成功
     * Binding succeeded
     */
    IDO_BLUETOOTH_BIND_SUCCESS,
    
    /**
     * 已经绑定
     * Already bound
     */
    IDO_BLUETOOTH_BINDED,
    
    /**
     * 需要授权绑定
     * Need authorization binding
     */
    IDO_BLUETOOTH_NEED_AUTH,
    
    /**
     * 拒绝绑定
     * Rejected binding
     */
    IDO_BLUETOOTH_REFUSED_BINDED,
    
};

#endif /* IDOBindEnum_h */
