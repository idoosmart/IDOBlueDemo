//
//  IDOAiAudioManager.h
//  IDOBlueProtocol
//
//  Created by hedongyang on 2024/4/1.
//  Copyright © 2024 何东阳. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IDOAiVoiceToText : NSObject
/**
 语音识别结果 0：成功，1：失败，2：失败，敏感词汇 ..
 */
@property (nonatomic,assign) NSInteger errorCode;
/**
 文本类型：1:设备录音转换的文本 2:ai回复转换的文本
 */
@property (nonatomic,assign) NSInteger textType;
/**
 文本内容 长度不超过1000字节
 */
@property (nonatomic,strong) NSString * textContent;

@end

@protocol IDOAiVoiceManagerDelegate <NSObject>

//计算语音丢包率
- (void)aiVoiceAllSize:(int)allSize
              lostSize:(int)lostSize;

/**
 * state : 0 =>空闲 1=> 开始 2=> 停止 3=>超时
 * 4=>断线 5=>登录状态 6=>开始 7=>app发起开始失败
 * 8=>app停止状态 9=>app发起结束失败
 * 10 =>按钮退出到主界面
 */
- (void)aiVoiceOperationState:(int)state;

/**
  设备过来的语音转成wav格式文件
 filePath : 音频转码后的存放地址
 state ：转码状态，0为成功，非0为失败
 */
- (void)aiVoiceEncodeFile:(NSString *)filePath
               encodeSate:(int)state;

/**
 设备进入ai请求
 type :  1 ai表盘;  2 ai语音
 */
- (void)aiVoiceDeviceRequest:(int)type;

/**
 设备通知APP录音转文字确认完成
 type :  1 ai表盘;  2 ai语音
 sure :  0: 用户确定录音转文字结果完成;  1:  用户重新录入语音
 */
- (void)aiVoiceToTextConfirmComplete:(int)type
                           sureState:(int)sure;

@end

@interface IDOAiVoiceManager : NSObject

/**
 是否支持ai语音
 */
@property (nonatomic,assign,readonly) BOOL supportAiVoice;

/**
 是否支持ai表盘
 */
@property (nonatomic,assign,readonly) BOOL supportAiWatch;

/**
 代理对象
 */
@property (nonatomic,assign) id<IDOAiVoiceManagerDelegate> delegate;


//单例
+ (instancetype)shareInstance;

/**
 回复APP状态
 0:成功
 1:失败
 2:失败，表盘空间不足
 3:失败，操作频繁
 4:失败，账户禁用
 */
+ (void)replyAiVoiceApp:(int)state;

/**
 停止ai语音
 */
+ (void)stopAiVoice;

/**
 APP下发ai文本
 */
+ (BOOL)sendAiVoiceText:(IDOAiVoiceToText *)model;


@end

NS_ASSUME_NONNULL_END
