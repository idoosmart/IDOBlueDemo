//
//  IDORecordDeviceLog.h
//  IDOBluetooth
//
//  Created by hedongyang on 2018/9/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDORecordDeviceLog : NSObject

/**
 获取设备日志信息 （在设备连接，并不在ota模式下使用获取设备重启日志）

 @param callback 日志信息获取完成回调
 */
+ (void)getDeviceLogWithCallback:(void(^)(BOOL isComplete))callback;

/**
 设备重启日志路径
 
 @return 日志存储目录 目录下可能有多个日志文件 日志文件是按日期生成的
 */
+ (NSString *)rebootLogFloderPath;

/**
 命令执行记录日志路径
 
 @return 日志存储目录 目录下可能有多个日志文件 日志文件是按日期生成的
 */
+ (NSString *)recordLogFloaderPath;

@end
