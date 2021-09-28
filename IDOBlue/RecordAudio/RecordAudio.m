//
//  RecordAudio.m
//  JrAlexa
//
//  Created by Jonor on 2018/8/27.
//  Copyright © 2018年 Jonor. All rights reserved.
//

#import "RecordAudio.h"
#import <AVFoundation/AVFoundation.h>

static id instance = nil;

@interface RecordAudio() <AVAudioRecorderDelegate, AVAudioPlayerDelegate>

@property (nonatomic, strong) AVAudioSession *audioSession;
@property (nonatomic, strong) AVAudioRecorder *audioRecorder;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

@property (nonatomic, strong)     NSTimer *timer;

@end

@implementation RecordAudio {
    dispatch_queue_t queue;
    
    void (^_recordProcessHandler)(float volume);
    void (^_recordFailedHandler)(NSError *error);
    void (^_recordCompletedHandler)(NSData *data);
    
    void (^_palyCompletedHandler)(BOOL successfully);
}

+(instancetype)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[super allocWithZone:NULL] init];
    });
    return instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    return [RecordAudio shareManager];
}

- (id)copyWithZone:(struct _NSZone *)zone
{
    return [RecordAudio shareManager];
}

- (instancetype)init {
    if (self = [super init]) {
        _audioSession = [AVAudioSession sharedInstance];
        [_audioSession setCategory:AVAudioSessionCategoryPlayAndRecord withOptions:AVAudioSessionCategoryOptionAllowBluetooth error:nil];
        
        NSURL *directory = [NSFileManager.defaultManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask][0];
        NSURL *fileURL = [directory URLByAppendingPathComponent:@"alexa.mp3"];
        NSDictionary *settings = @{AVEncoderAudioQualityKey: @(AVAudioQualityHigh),
                                   AVEncoderBitRateKey: @16,
                                   AVNumberOfChannelsKey: @1,
                                   AVSampleRateKey: @16000.0};
        _audioRecorder = [[AVAudioRecorder alloc] initWithURL:fileURL settings:settings error:nil];
        _audioRecorder.meteringEnabled = true;
        _audioRecorder.delegate = self;
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(detectionPeakPower) userInfo:nil repeats:YES];
        _timer.fireDate = [NSDate distantFuture];
        
        queue = dispatch_queue_create("audio-manager-queue", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}


#pragma mark - Recording

- (void)recordStartWithProcess:(void (^)(float peakPower))processHandler
                        failed:(void (^)(NSError *error))failedHandler
                     completed:(void (^)(NSData *data))completedHandler {
    dispatch_async(queue, ^{
        if (!self.audioRecorder.isRecording) {
            self->_recordProcessHandler = processHandler;
            self->_recordFailedHandler = failedHandler;
            self->_recordCompletedHandler = completedHandler;
            
            [self.audioSession setCategory:AVAudioSessionCategoryPlayAndRecord withOptions:AVAudioSessionCategoryOptionDefaultToSpeaker error:nil];
            BOOL y = [self.audioRecorder prepareToRecord];
            BOOL x = [self.audioRecorder record];
            
            self->_timer.fireDate = [NSDate distantPast];
        } else {
            if (failedHandler) {
                NSError *error = [NSError errorWithDomain:@"AudioManager" code:-1 userInfo:@{NSLocalizedDescriptionKey: @"audio recorder is running."}];
                dispatch_async(dispatch_get_main_queue(), ^{
                    failedHandler(error);
                });
            }
        }
    });
}

- (void)recordStop {
    dispatch_async(queue, ^{
        if (self.audioRecorder.isRecording) {
            [self.audioRecorder stop];
            self->_timer.fireDate = [NSDate distantFuture];
        }
    });
}

- (BOOL)isRecording {
    return self.audioRecorder.isRecording;
}

- (void)detectionPeakPower {
    dispatch_async(queue, ^{
        if (self.audioRecorder.isRecording && self->_recordProcessHandler) {
            [self.audioRecorder updateMeters];
            float db = [self.audioRecorder peakPowerForChannel:0];
            float vol = pow(10, (0.05 * db));
            dispatch_async(dispatch_get_main_queue(), ^{
                self->_recordProcessHandler(vol);
            });
        }
    });
}

#pragma mark - AVAudioRecorderDelegate

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag {
    if (flag) {
        if (_recordCompletedHandler) {
            NSData *data = [[NSData alloc] initWithContentsOfURL:recorder.url];
            dispatch_async(dispatch_get_main_queue(), ^{
                self->_recordCompletedHandler(data);
            });
        }
    } else {
        if (_recordFailedHandler) {
            NSError *error = [NSError errorWithDomain:@"AudioManager" code:-2 userInfo:@{NSLocalizedDescriptionKey: @"audio recorder is failed."}];
            dispatch_async(dispatch_get_main_queue(), ^{
                self->_recordFailedHandler(error);
            });
        }
    }
}

- (void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError * __nullable)error{
    
}

#pragma mark - Playing

- (void)playAudioData:(NSData *)data completionHandler:(void (^)(BOOL successfully))handler {
    dispatch_async(queue, ^{
        if (!self.audioPlayer.isPlaying) {
            self->_palyCompletedHandler = handler;
            self.audioPlayer = [[AVAudioPlayer alloc] initWithData:data error:nil];
            self.audioPlayer.delegate = self;
            [self.audioPlayer play];
        }
    });
}

- (BOOL)isPlaying {
    return _audioPlayer.isPlaying;
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    if (_palyCompletedHandler) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self->_palyCompletedHandler(flag);
        });
    }
}



@end
