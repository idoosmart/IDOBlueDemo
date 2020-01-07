//
//  IDOTransferFileManager.h
//  IDOBluetooth
//
//  Created by hedongyang on 2018/9/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#if __has_include(<IDOBluetoothInternal/IDOBluetoothInternal.h>)
#elif __has_include(<IDOBlueProtocol/IDOBlueProtocol.h>)
#else
#import "IDOTranEnum.h"
#endif

@interface IDOTransferFileManager : NSObject

/**
 * 传输文件类型 agps文件、表盘文件、字库文件、图片文件
 * Transfer file type agps file, dial file
 */
@property (nonatomic,assign) IDO_DATA_FILE_TRAN_TYPE transferType;

/**
 * 传输文件压缩类型 不适用压缩、zlib压缩、fastlz压缩
 * Transfer file compression types  not suitable for compression, zlib compression, fastlz compression
 */
@property (nonatomic,assign) IDO_DATA_TRAN_COMPRESSION_TYPE compressionType;

/**
 * 传输文件过程状态
 * Transfer file process status
 */
@property (nonatomic,assign) IDO_DATA_FILE_TRAN_STATE_TYPE tranStateType;

/**
 * 设置传输文件包文个数 默认 10
 * Set the number of transfer file packet default 10
 */
@property (nonatomic,assign) NSInteger numberPackets;

/**
 * 传输文件名称
 * Transfer file name
 */
@property (nonatomic,copy,nullable) NSString * fileName;

/**
 * 传输文件路径
 * Transfer file path
 */
@property (nonatomic,copy,nullable) NSString * filePath;

/*
 * 传输文件的二进制数据
 * Transfer the binary data of the file
 */
@property (nonatomic,copy,nullable) NSData * fileData;

/**
 * 蓝牙写入数据是否响应
 * Bluetooth sends data in response
 */
@property (nonatomic,assign) BOOL isResponse;

/**
 * 是否设置连接参数
 * Set connection parameters
 */
@property (nonatomic,assign) BOOL isSetConnectParam;

/**
 * 检测文件回调
 * Detect file callback
 */
@property (nonatomic,copy,nullable) IDOTransferFileManager *_Nonnull(^addDetection)(void(^ _Nullable detectionCallback)(int errorCode));

/**
 * 文件传输进度回调 (1-100)
 * file transfer progress (1-100)
 */
@property (nonatomic,copy,nullable) IDOTransferFileManager *_Nonnull(^addProgress)(void(^ _Nullable progressCallback)(int progress));

/**
 * 文件传输完成回调
 * File transfer complete callback
 */
@property (nonatomic,copy,nullable) IDOTransferFileManager *_Nonnull(^addTransfer)(void(^ _Nullable transferComplete)(int errorCode));

/**
 * 文件写入完成回调 agps文件传输完成后需要查询写入状态
 * File write complete callback
 */
@property (nonatomic,copy,nullable) IDOTransferFileManager *_Nonnull(^addWrite)(void(^ _Nullable writeComplete)(int errorCode));

/**
 * 初始化传输文件管理对象(单例)
 * Initialize the transfer file management object (singleton)
 */
IDOTransferFileManager * _Nonnull initTransferManager(void);

/**
 * 文件开始传输
 * file start transfer
 */
+ (void)startTransfer;

/**
 * 文件结束传输
 * file stop transfer
 */
+ (void)stopTransfer;



@end
