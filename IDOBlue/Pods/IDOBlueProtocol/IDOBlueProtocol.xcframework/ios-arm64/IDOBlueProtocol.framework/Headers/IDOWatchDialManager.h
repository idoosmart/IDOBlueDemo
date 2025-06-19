//
//  IDOWatchDialManager.h
//  IDOBluetoothInternal
//
//  Created by 何东阳 on 2019/8/21.
//  Copyright © 2019 何东阳. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^_Nullable setComplete)(int errorCode);

@interface IDOWatchDialManager : NSObject

/**
 * 表盘唯一id （ 如果不赋值，表盘id默认为表盘包的名字 ）
 * unique id （ If not assigned, the dial id defaults to the name of the dial pack ）
 */
@property (nonatomic,copy,nullable) NSString * uniqueId;

/**
 * 表盘文件传输路径 (zip)
 * Transfer file path
 */
@property (nonatomic,copy,nullable) NSString * filePath;

/**
 颜色格式 | color format
 */
@property (nonatomic,assign) NSInteger colorFormat;

/**
 压缩块大小 | block size
 */
@property (nonatomic,assign) NSInteger blockSize;

/**
 * 获取当前设备屏幕信息
 * Gets the current device screen information
 */
@property (nonatomic,copy,nullable) IDOWatchDialManager *_Nonnull(^getDialScreenInfo)(void(^ _Nullable dialScreenCallback)(IDOWatchScreenInfoModel * _Nullable model,int errorCode));

#pragma mark ====== watch v2 ===========
/**
 * 获取当前设备所有表盘信息
 * Gets all dial information of the current device
 */
@property (nonatomic,copy,nullable) IDOWatchDialManager *_Nonnull(^getDialListInfo)(void(^ _Nullable dialListCallback)(IDOWatchDialInfoModel * _Nullable model,int errorCode));

/**
 * 获取当前设备当前表盘名字
 * Gets current dial information of name
 */
@property (nonatomic,copy,nullable) IDOWatchDialManager *_Nonnull(^getCurrentDialInfo)(void(^ _Nullable currentDialCallback)(NSString * _Nullable fileName,int errorCode));

/**
 * 设置当前表盘并回调
 * Set the current dial and call back
 */
@property (nonatomic,copy,nullable) IDOWatchDialManager *_Nonnull(^setCurrentDial)(setComplete block,IDOWatchDialInfoItemModel * _Nullable model);

#pragma mark ====== watch v3 ===========

/**
 * 获取当前设备v3表盘列表信息
 * Get current device v3 watch face list information
 */
@property (nonatomic,copy,nullable) IDOWatchDialManager *_Nonnull(^getV3WatchListInfo)(void(^ _Nullable v3WialListCallback)(IDOV3WatchDialInfoModel * _Nullable model,int errorCode));

/**
 * 获取当前设备壁纸表盘信息
 * Get current device wallpaper and dial information
 */
@property (nonatomic,copy,nullable) IDOWatchDialManager *_Nonnull(^getWallpaperDialInfo)(void(^ _Nullable wallpaperDialCallback)(IDOV3WallpaperDialInfoModel * _Nullable model,int errorCode));

/**
 * 设置当前设备壁纸表盘信息
 * Set the current device wallpaper and watch face information
 */
@property (nonatomic,copy,nullable) IDOWatchDialManager *_Nonnull(^setWallpaperDialInfo)(setComplete block,IDOV3WallpaperDialInfoModel * _Nullable model);

/**
 * 设置表盘排序
 * Set watch face sorting
 */
@property (nonatomic,copy,nullable) IDOWatchDialManager *_Nonnull(^setWatchDialSort)(setComplete block,IDOV3WatchDialInfoModel * _Nullable model);


#pragma mark ====== watch transmission ===========

/**
 * 表盘传输进度回调 (1-100)
 * file transfer progress (1-100)
 */
@property (nonatomic,copy,nullable) IDOWatchDialManager *_Nonnull(^addDialProgress)(void(^ _Nullable progressCallback)(int progress));

/**
 * 表盘传输完成回调
 * File transfer complete callback
 跟传输文件错误码一致
 (errorCode + 24) ///< 表盘空间够但需要整理
 (errorCode + 25) ///< 表盘空间整理中
 finishingTime :只有错误码在24和25才有效，固件预计整理时长
 */
@property (nonatomic,copy,nullable) IDOWatchDialManager *_Nonnull(^addDialTransfer)(void(^ _Nullable transferComplete)(int errorCode,int finishingTime));

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

/**
 云端表盘文件制作iwf文件
 */
+ (BOOL)makeIwfFile:(NSString * _Nullable)zipPath
        colorFormat:(NSInteger)colorFormat
            iwfPath:(NSString *_Nullable*_Nullable)iwfPath
           fileSize:(unsigned long long *_Nullable)fileSize;

/**
 iwf 文件目录地址
 根据目录自行管理文件
 */
+ (NSString *_Nullable)iwfDirPath;

@end
