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
  传人agps文件路径,当回调后才可执行开始更新的方法,因为需要执行连接参数,设置传输速度

 @param packagePath agps文件路径
 @param callback 状态回调 (errorCode : 0 设置成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)updateAgpsWithPath:(NSString *_Nullable)packagePath
           prepareCallback:(void(^_Nullable)(int errorCode))callback;

/**
 agps文件传输进度 (1-100)

 @param callback 进度回调
 */
+ (void)updateAgpsProgressCallback:(void(^_Nullable)(int progress))callback;


/**
 agps 文件传输完成

 @param complete 文件传输完成 (正在写入...) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 @param callback 文件写入完成 (errorCode : 0 写入成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 */
+ (void)updateAgpsTransmissionComplete:(void(^_Nullable)(int errorCode))complete
                        updateComplete:(void(^_Nullable)(int errorCode))callback;

/**
 agps 文件更新开始
 */
+ (void)startUpdate;

/**
 agps 更新结束
 */
+ (void)stopUpdate;
@end
