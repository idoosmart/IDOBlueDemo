//
//  IDOMakePhotoManager.h
//  IDOBluetoothInternal
//
//  Created by 何东阳 on 2019/12/3.
//  Copyright © 2019 何东阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDOMakePhotoManager : NSObject

/**
 * 图片文件名称
 * file name
 */
@property (nonatomic,copy,nullable) NSString * fileName;
/**
 * 图片文件传输路径 
 * Transfer file path
 */
@property (nonatomic,copy,nullable) NSString * filePath;

/**
 * 图片传输进度回调 (1-100)
 * file transfer progress (1-100)
 */
@property (nonatomic,copy,nullable) IDOMakePhotoManager *_Nonnull(^addPhotoProgress)(void(^ _Nullable progressCallback)(int progress));

/**
 * 图片传输完成回调
 * File transfer complete callback
 */
@property (nonatomic,copy,nullable) IDOMakePhotoManager *_Nonnull(^addPhotoTransfer)(void(^ _Nullable transferComplete)(int errorCode));
/**
 * 初始化制作图片管理对象(单例)
 * Initialize the transfer file management object (singleton)
 */
IDOMakePhotoManager * _Nonnull initMakePhotoManager(void);

/**
 * 图片开始传输
 * file start transfer
 */
+ (void)startPhotoTransfer;

/**
 * 图片结束传输
 * file stop transfer
 */
+ (void)stopPhotoTransfer;

@end

