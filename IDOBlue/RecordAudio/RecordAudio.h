//
//  RecordAudio.h
//  JrAlexa
//
//  Created by Jonor on 2018/8/27.
//  Copyright © 2018年 Jonor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecordAudio : NSObject

+ (instancetype)shareManager;

// Recording
- (void)recordStartWithProcess:(void (^)(float peakPower))processHandler
                        failed:(void (^)(NSError *error))failedHandler
                     completed:(void (^)(NSData *data))completedHandler;
- (void)recordStop;
- (BOOL)isRecording;

// Playing
- (void)playAudioData:(NSData *)data completionHandler:(void (^)(BOOL successfully))handler;
- (BOOL)isPlaying;

/**< 外部测试 */

@end

