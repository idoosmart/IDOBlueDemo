//
//  IDOAlexaAudioManager.h
//  IDOBlueProtocol
//
//  Created by hedongyang on 2021/8/27.
//  Copyright © 2021 何东阳. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol IDOAlexaAudioManagerDelegate <NSObject>

@optional
/**
 下发音频回调状态
 stateCode :  0:初始化状态 1:开始状态 2:传输完成 3:传输超时
 4:传输断线 5:采样率转换失败 6:当前ota模式 7:设备未连接 8:音频文件不存在 9:开始下发音频配置失败
 */
- (void)transferAudioStateCode:(int)stateCode
                       message:(NSString *)message;

@end

@interface IDOAlexaAudioManager : NSObject
//alexa 语音下发管理
@property (nonatomic,weak) id<IDOAlexaAudioManagerDelegate> delegate;
/**
 音频传输状态
 stateCode :  0:初始化状态 1:开始状态 2:传输完成 3:传输超时
 4:传输断线 5:采样率转换失败 6:当前ota模式 7:设备未连接 8:音频文件不存在 9:开始下发音频配置失败
 */
@property (nonatomic,copy) void(^transferStateCallback)(int stateCode);

//pcm存储路径
@property (nonatomic,copy,readonly) NSString * filePath;

//是否在传输中
@property (nonatomic,assign,readonly) BOOL isTransfer;

//单例
+ (instancetype)shareInstance;

//mp3 转 pcm 文件
- (BOOL)mp3AudioToPcmWithData:(NSData *)data;

//开始传输音频
- (void)startTransferAudioFile;

//结束音频
- (void)stopTransferAudioFile;

@end

NS_ASSUME_NONNULL_END
