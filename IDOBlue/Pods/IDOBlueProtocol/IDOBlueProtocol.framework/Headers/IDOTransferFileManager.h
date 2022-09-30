//
//  IDOTransferFileManager.h
//  IDOBluetooth
//
//  Created by hedongyang on 2018/9/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#if __has_include(<IDOBlueProtocol/IDOBlueProtocol.h>)
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

/*
 * 传输解压文件大小（208BT）
 * Transfer Unzip file size (208BT)
 */
@property (nonatomic,assign) NSInteger unzipFileSize;

/**
 * 是否设置连接参数 默认设置YES
 * Set connection parameters default YES
 */
@property (nonatomic,assign) BOOL isSetConnectParam;

/**
 *是否需要查询写入状态，在agps 文件传输完成后，默认为NO
 *query write state default NO
 */
@property (nonatomic,assign) BOOL isQueryWriteState;

/**
 * 是否重试启动传输 默认 YES
 * is retries
 */
@property (nonatomic,assign) BOOL isRetries;

/**
 传输文件完成是否设置慢速模式，默认是YES
 */
@property (nonatomic,assign) BOOL isSetSlowState;

/**
 * 检测文件回调
 * Detect file callback
 */
@property (nonatomic,copy,nullable) IDOTransferFileManager *_Nonnull(^addDetection)(void(^ _Nullable detectionCallback)(int errorCode));

/**
 * 文件传输进度回调 (0-100)
 * file transfer progress (0-100)
 */
@property (nonatomic,copy,nullable) IDOTransferFileManager *_Nonnull(^addProgress)(void(^ _Nullable progressCallback)(int progress));

/**
 * 其他文件传输完成回调
 * File transfer complete callback
 * (errorCode + 0) ///< Successful command
 (errorCode + 1) ///< SVC handler is missing
 (errorCode + 2) ///< SoftDevice has not been enabled
 (errorCode + 3) ///< Internal Error
 (errorCode + 4) ///< No Memory for operation
 (errorCode + 5) ///< Not found
 (errorCode + 6) ///< Not supported
 (errorCode + 7) ///< Invalid Parameter
 (errorCode + 8) ///< Invalid state, operation disallowed in this state
 (errorCode + 9) ///< Invalid Length
 (errorCode + 10) ///< Invalid Flags
 (errorCode + 11) ///< Invalid Data
 (errorCode + 12) ///< Invalid Data size
 (errorCode + 13) ///< Operation timed out
 (errorCode + 14) ///< Null Pointer
 (errorCode + 15) ///< Forbidden Operation
 (errorCode + 16) ///< Bad Memory Address
 (errorCode + 17) ///< Busy
 (errorCode + 18) ///< Maximum connection count exceeded.
 (errorCode + 19) ///< Not enough resources for operation
 (errorCode + 20) ///< Bt Bluetooth upgrade error
 (errorCode + 21) ///< Not enough space for operation
 (errorCode + 22) ///< Low Battery
 (errorCode + 23) ///< Invalid File Name/Format
 *
 * 表盘文件、AGPS文件传输完成回调（如果空间不足，就会回调error = 24或者25，标明固件需要时间整理表盘碎片）
 * The dial file and AGPS file transfer completion callback (if the space is insufficient, it will call back error = 24 or 25, indicating that the firmware needs time to defragment the dial)
 (errorCode + 24) ///< 空间够但需要整理 | Plenty of space but needs to be organized
 (errorCode + 25) ///<  空间整理中 | space in progress
 * value == times ，只有错误码在24和25才有效，固件预计整理时长，单位为秒 | Only the error codes are valid in 24 and 25. The firmware estimates the sorting time in seconds.
 *
 */
@property (nonatomic,copy,nullable) IDOTransferFileManager *_Nonnull(^addTransfer)(void(^ _Nullable transferComplete)(int errorCode, int value));

/**
 * 文件写入完成回调 agps文件传输完成后需要查询写入状态
 * File write complete callback
 */
@property (nonatomic,copy,nullable) IDOTransferFileManager *_Nonnull(^addWrite)(void(^ _Nullable writeComplete)(int errorCode));

/**
 * 文件开始传输回调,执行完设置连接参数
 * File start transmission callback
 */
@property (nonatomic,copy,nullable) IDOTransferFileManager *_Nonnull(^addStart)(void(^ _Nullable startCallback)(int errorCode));

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
