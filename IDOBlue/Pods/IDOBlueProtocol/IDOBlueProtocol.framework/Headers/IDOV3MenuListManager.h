//
//  IDOV3MenuListManager.h
//  IDOBlueProtocol
//
//  Created by cyf on 2024/11/29.
//  Copyright © 2024 何东阳. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface IDOV3MenuListManager : NSObject


/**
 * @brief 设置V3菜单列表  | drink water reminder
 * @param menuModel 设置菜单列表 model (IDOGetMenuListInfoBluetoothModel)
 * set menu list model (IDOGetMenuListInfoBluetoothModel)
 * __IDO_FUNCTABLE__.funcTable42Model.supportProtocolV3MenuList
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
*/
+ (void)setV3MenuListCommand:(IDOSetV3MenuListModel * _Nullable)menuModel
                  callback:(void (^ _Nullable)(int errorCode))callback;


/**
 * @brief  获取V3菜单列表  | get menu list info
 * @param callback 执行后回调 data (IDOGetMenuListInfoBluetoothModel) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * __IDO_FUNCTABLE__.funcTable42Model.supportProtocolV3MenuList
 * callback data (IDOGetMenuListInfoBluetoothModel) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
*/
+ (void)getV3MenuListInfoCommand:(void(^_Nullable)(int errorCode,IDOGetV3MenuListInfoBluetoothModel * _Nullable model))callback;


@end

NS_ASSUME_NONNULL_END
