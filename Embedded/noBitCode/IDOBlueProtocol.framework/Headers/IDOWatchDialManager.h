//
//  IDOWatchDialManager.h
//  IDOBluetoothInternal
//
//  Created by 何东阳 on 2019/8/21.
//  Copyright © 2019 何东阳. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ _Nullable setComplete)(IDOWatchDialInfoModel * _Nullable model,int errorCode);

@interface IDOWatchDialManager : NSObject

/**
 * 表盘文件传输路径 (zip)
 * Transfer file path
 */
@property (nonatomic,copy,nullable) NSString * filePath;

/**
 * 获取当前设备屏幕信息
 * Gets the current device screen information
 */
@property (nonatomic,copy,nullable) IDOWatchDialManager *_Nonnull(^getDialScreenInfo)(void(^ _Nullable dialScreenCallback)(IDOWatchScreenInfoModel * _Nullable model,int errorCode));

/**
 * 获取当前设备所有表盘信息
 * Gets all dial information of the current device
 */
@property (nonatomic,copy,nullable) IDOWatchDialManager *_Nonnull(^getDialListInfo)(void(^ _Nullable dialListCallback)(IDOWatchDialInfoModel * _Nullable model,int errorCode));

/**
 * 获取当前设备当前表盘信息
 * Gets current dial information of the current device
 */
@property (nonatomic,copy,nullable) IDOWatchDialManager *_Nonnull(^getCurrentDialInfo)(void(^ _Nullable currentDialCallback)(IDOWatchDialInfoModel * _Nullable model,int errorCode));

/**
 * 设置当前表盘并回调
 * Set the current dial and call back
 */
@property (nonatomic,copy,nullable) IDOWatchDialManager *_Nonnull(^setCurrentDial)(setComplete block,IDOWatchDialInfoItemModel * _Nullable model);

/**
 * 表盘传输进度回调 (1-100)
 * file transfer progress (1-100)
 */
@property (nonatomic,copy,nullable) IDOWatchDialManager *_Nonnull(^addDialProgress)(void(^ _Nullable progressCallback)(int progress));

/**
 * 表盘传输完成回调
 * File transfer complete callback
 */
@property (nonatomic,copy,nullable) IDOWatchDialManager *_Nonnull(^addDialTransfer)(void(^ _Nullable transferComplete)(int errorCode));

/**
 * 初始化表盘传输管理对象(单例)
 * Initialize the transfer file management object (singleton)
 */
IDOWatchDialManager * _Nonnull initWatchDialManager(void);

/**
 * 表盘开始传输
 * file start transfer
 */
+ (void)startDialTransfer;

/**
 * 表盘结束传输
 * file stop transfer
 */
+ (void)stopDialTransfer;

@end
