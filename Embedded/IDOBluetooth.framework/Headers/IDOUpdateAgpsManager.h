//
//  IDOUpdateAgpsManager.h
//  IDOBluetooth
//
//  Created by hedongyang on 2018/9/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface IDOUpdateAgpsManager : NSObject

/**
 * @brief 传人agps文件路径,当回调后才可执行开始更新的方法,因为需要执行连接参数,设置传输速度
 * Pass the agps file path, the call to start the update method after the callback, because you need to execute the connection parameters, set the transfer speed
 * @param packagePath agps文件路径 | packagePath agps file path
 * @param callback 状态回调 (errorCode : 0 设置成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Status callback (errorCode : 0 set successfully, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)updateAgpsWithPath:(NSString *_Nullable)packagePath
           prepareCallback:(void(^_Nullable)(int errorCode))callback;

/**
 * @brief agps文件传输进度 (1-100) | agps file transfer progress (1-100)
 * @param callback 进度回调 | Progress callback
 */
+ (void)updateAgpsProgressCallback:(void(^_Nullable)(int progress))callback;


/**
 * @brief agps 文件传输完成 | File transfer completed
 * @param tranComplete 文件传输完成 (正在写入...) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * File transfer completed (writing...) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 * @param writeComplete 文件写入完成 (errorCode : 0 写入成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * File write completed (errorCode : 0 write succeeded, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
+ (void)updateAgpsTransmissionComplete:(void(^_Nullable)(int errorCode))tranComplete
                         writeComplete:(void(^_Nullable)(int errorCode))writeComplete;

/**
 * agps 文件更新开始 | agps file update begins
 * @return 是否开始更新 yes or no | Whether to start update yes or no
 */
+ (BOOL)startUpdate;

/**
 * agps 更新结束 | agps end of change
 */
+ (void)stopUpdate;
@end
