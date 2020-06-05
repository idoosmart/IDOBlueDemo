//
//  ListenVoiceDataViewModel.m
//  IDOBlue
//
//  Created by hedongyang on 2020/4/3.
//  Copyright © 2020 hedongyang. All rights reserved.
//

#import "ListenVoiceDataViewModel.h"
#import "FuncCellModel.h"
#import "OneButtonTableViewCell.h"
#import "IDODemoUtility.h"
#import "FuncViewController.h"
#import "TextFieldCellModel.h"
#import "OneTextFieldTableViewCell.h"
#import "NSObject+DemoToDic.h"
#import "PCMDataPlayer.h"
#import "PQVoiceInputView.h"

#define EVERY_READ_LENGTH 1024 //每次从PCM文件读取的长度
@interface ListenVoiceDataViewModel()
@property (nonatomic,strong) PCMDataPlayer * player;
@property (nonatomic) char * pcmDataBuffer; //pcm读数据的缓冲区
@property (nonatomic,strong) NSTimer* sendDataTimer;
@property (nonatomic,assign) int offset;
@property (nonatomic,assign) int bufferLength;
@property (nonatomic) char * pcmAllBuffer;
@property (nonatomic,assign) FILE * pcmFile;
@property (nonatomic,strong) NSArray * controlNames;
@property (nonatomic,strong) NSArray * pickerArray;
@property (nonatomic,strong) PQVoiceInputView * voiceView1;
@property (nonatomic,strong) PQVoiceInputView * voiceView2;
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^textFeildCallback)(UIViewController * viewController,UITextField * textField,UITableViewCell * tableViewCell);
@end

@implementation ListenVoiceDataViewModel

- (void)dealloc
{

}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getViewWillDisappearCallback];
        [self listenVoiceCallback];
        [self getButtonCallback];
        [self getTextFieldCallback];
        [self getCellModels];
    }
    return self;
}

- (NSArray *)controlNames
{
    if (!_controlNames) {
        _controlNames = @[lang(@"set sport type"),lang(@"set real time hr"),lang(@"set no disturb"),lang(@"set wrist bright screen"),
                          lang(@"set music control"),lang(@"set screen brightness"),lang(@"set stopwatch"),lang(@"set countdown"),
                          lang(@"heart rate detection"),lang(@"pressure detection"),lang(@"breathing training"),lang(@"sleep record"),
                          lang(@"sport record"),lang(@"weather interface"),lang(@"find phone"),lang(@"black screen"),lang(@"reboot control"),
                          lang(@"message interface")];
    }
    return _controlNames;
}

- (NSArray *)pickerArray
{
    if (!_pickerArray) {
        _pickerArray = @[self.pickerDataModel.sportSortTitleArray,self.pickerDataModel.switchTypes,self.pickerDataModel.switchTypes,
                         self.pickerDataModel.switchTypes,self.pickerDataModel.musicTypes,self.pickerDataModel.hundredArray];
    }
    return _pickerArray;
}

- (PCMDataPlayer *)player
{
    if (!_player) {
        _player = [[PCMDataPlayer alloc] init];
    }
    return _player;
}

- (PQVoiceInputView *)voiceView1
{
    if (!_voiceView1) {
        FuncViewController * funcVC = (FuncViewController *)[IDODemoUtility getCurrentVC];
        CGRect frame = CGRectMake((funcVC.view.frame.size.width - 100)/2,(funcVC.view.frame.size.height - 100)/2,100,100);
        _voiceView1 = [PQVoiceInputView pgq_reateVoiceViewWithRect:frame
                                                        voiceColor:[UIColor whiteColor]
                                                       volumeColor:[UIColor lightGrayColor]
                                                             title:lang(@"voice start")
                                                          showType:VOICEINPUT_TYPE_OUTSIDE
                                                            hidden:^(PQVoiceInputView * _Nullable view, NSString * _Nullable text, NSInteger type) {
        }];
        [funcVC.view addSubview:_voiceView1];
    }
    return _voiceView1;
}

- (PQVoiceInputView *)voiceView2
{
    if (!_voiceView2) {
        FuncViewController * funcVC = (FuncViewController *)[IDODemoUtility getCurrentVC];
        CGRect frame = CGRectMake((funcVC.view.frame.size.width - 100)/2,(funcVC.view.frame.size.height - 100)/2,100,100);
        _voiceView2 = [PQVoiceInputView pgq_reateVoiceViewWithRect:frame
                                                        voiceColor:[UIColor whiteColor]
                                                       volumeColor:[UIColor whiteColor]
                                                             title:lang(@"voice play")
                                                          showType:VOICEINPUT_TYPE_INSIDE
                                                            hidden:^(PQVoiceInputView * _Nullable view, NSString * _Nullable text, NSInteger type) {
        }];
        [funcVC.view addSubview:_voiceView2];
    }
    return _voiceView2;
}

- (NSTimer *)sendDataTimer
{
    if (!_sendDataTimer) {
        _sendDataTimer = [NSTimer scheduledTimerWithTimeInterval:(1.0 / 40.0)
                                                          target:self
                                                        selector:@selector(readNextPCMData:)
                                                        userInfo:nil
                                                         repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_sendDataTimer forMode:NSRunLoopCommonModes];
    }
    return _sendDataTimer;
}

#define ARC4RANDOM_MAX 0x100000000
static int countdown = 0;
- (void)readNextPCMData:(NSTimer*)timer
{
    if (self.pcmFile== NULL || self.pcmDataBuffer == NULL) return;
    self.voiceView2.hidden = NO;
    if (countdown % 5 == 0) {
        double val = ((double)arc4random() / ARC4RANDOM_MAX);
        [self.voiceView2 updateVoiceViewWithVolume:val];
    }
    countdown ++;
    
    int readLength = 0;
    if (self.offset + EVERY_READ_LENGTH <= self.bufferLength) {
        readLength = (int)fread(self.pcmDataBuffer, 1, EVERY_READ_LENGTH, self.pcmFile);
        self.offset += EVERY_READ_LENGTH;
    }else if(self.offset < self.bufferLength){
        readLength = (int)fread(self.pcmDataBuffer, 1,self.bufferLength - self.offset, self.pcmFile);
        self.offset = self.bufferLength;
    }
    
    if (readLength > 0) {
        [self.player play:self.pcmDataBuffer length:readLength];
    }else {
       if (self.sendDataTimer) {
           [self.sendDataTimer setFireDate:[NSDate distantFuture]];
        }
        
        if (self.player) {
            [self.player stop];
        }

        if (self.pcmFile) {
            fclose(self.pcmFile);
        }
        self.pcmFile = NULL;

        if (self.pcmDataBuffer) {
            free(self.pcmDataBuffer);
        }
        self.pcmDataBuffer = NULL;
        self.voiceView2.hidden = YES;
    }
}

- (void)getViewWillDisappearCallback
{
    __weak typeof(self) weakSelf = self;
    self.viewWillDisappearCallback = ^(UIViewController *viewController) {
        __strong typeof(self) strongSelf = weakSelf;
        if (strongSelf->_sendDataTimer) {
           [strongSelf.sendDataTimer invalidate];
            strongSelf.sendDataTimer = nil;
        }

        if (strongSelf->_player) {
          [strongSelf.player stop];
          strongSelf.player = nil;
        }

        if (strongSelf->_pcmDataBuffer) {
           free(strongSelf.pcmDataBuffer);
            strongSelf.pcmDataBuffer = NULL;
        }
        
        if (strongSelf->_voiceView1) {
           [strongSelf.voiceView1 stopCircleAnimation];
           strongSelf.voiceView1 = nil;
        }
        
        if (strongSelf->_voiceView2) {
           strongSelf.voiceView2 = nil;
        }
    };
}

- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        FuncCellModel * cellModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
        NSString * str = [NSString stringWithFormat:@"%@...",lang(@"set page jump")];
        [funcVC showLoadingWithMessage:str];
        if (cellModel.index == 0) {
            [IDOFoundationCommand voiceControlToStopWatchCommand:^(int errorCode) {
                if (errorCode == 0) {
                   [funcVC showToastWithText:lang(@"set page jump success")];
                }else if (errorCode == 6) {
                    [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
                }else {
                   [funcVC showToastWithText:lang(@"set page jump failed")];
                }
            }];
        }else if (cellModel.index == 1) {
            [IDOFoundationCommand voiceControlToCountDownCommand:^(int errorCode) {
                if (errorCode == 0) {
                   [funcVC showToastWithText:lang(@"set page jump success")];
                }else if (errorCode == 6) {
                    [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
                }else {
                   [funcVC showToastWithText:lang(@"set page jump failed")];
                }
            }];
        }else if (cellModel.index == 2) {
            [IDOFoundationCommand voiceControlToHeartRateCommand:^(int errorCode) {
                if (errorCode == 0) {
                   [funcVC showToastWithText:lang(@"set page jump success")];
                }else if (errorCode == 6) {
                    [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
                }else {
                   [funcVC showToastWithText:lang(@"set page jump failed")];
                }
            }];
        }else if (cellModel.index == 3) {
            [IDOFoundationCommand voiceControlToPressureCommand:^(int errorCode) {
                if (errorCode == 0) {
                   [funcVC showToastWithText:lang(@"set page jump success")];
                }else if (errorCode == 6) {
                    [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
                }else {
                   [funcVC showToastWithText:lang(@"set page jump failed")];
                }
            }];
        }else if (cellModel.index == 4) {
            [IDOFoundationCommand voiceControlToBreathingCommand:^(int errorCode) {
                if (errorCode == 0) {
                   [funcVC showToastWithText:lang(@"set page jump success")];
                }else if (errorCode == 6) {
                    [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
                }else {
                   [funcVC showToastWithText:lang(@"set page jump failed")];
                }
            }];
        }else if (cellModel.index == 5) {
            [IDOFoundationCommand voiceControlToSleepRecordCommand:^(int errorCode) {
                if (errorCode == 0) {
                   [funcVC showToastWithText:lang(@"set page jump success")];
                }else if (errorCode == 6) {
                    [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
                }else {
                   [funcVC showToastWithText:lang(@"set page jump failed")];
                }
            }];
        }else if (cellModel.index == 6) {
            [IDOFoundationCommand voiceControlToSportRecordCommand:^(int errorCode) {
                if (errorCode == 0) {
                   [funcVC showToastWithText:lang(@"set page jump success")];
                }else if (errorCode == 6) {
                    [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
                }else {
                   [funcVC showToastWithText:lang(@"set page jump failed")];
                }
            }];
        }else if (cellModel.index == 7) {
            [IDOFoundationCommand voiceControlToWeatherCommand:^(int errorCode) {
                if (errorCode == 0) {
                   [funcVC showToastWithText:lang(@"set page jump success")];
                }else if (errorCode == 6) {
                    [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
                }else {
                   [funcVC showToastWithText:lang(@"set page jump failed")];
                }
            }];
        }else if (cellModel.index == 8) {
            [IDOFoundationCommand voiceControlToFindPhoneCommand:^(int errorCode) {
                if (errorCode == 0) {
                   [funcVC showToastWithText:lang(@"set page jump success")];
                }else if (errorCode == 6) {
                    [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
                }else {
                   [funcVC showToastWithText:lang(@"set page jump failed")];
                }
            }];
        }else if (cellModel.index == 9) {
            [IDOFoundationCommand voiceControlToBlackScreenCommand:^(int errorCode) {
                if (errorCode == 0) {
                   [funcVC showToastWithText:lang(@"set page jump success")];
                }else if (errorCode == 6) {
                    [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
                }else {
                   [funcVC showToastWithText:lang(@"set page jump failed")];
                }
            }];
        }else if (cellModel.index == 10) {
            [IDOFoundationCommand voiceControlToRebootCommand:^(int errorCode) {
                if (errorCode == 0) {
                   [funcVC showToastWithText:lang(@"set page jump success")];
                }else if (errorCode == 6) {
                    [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
                }else {
                   [funcVC showToastWithText:lang(@"set page jump failed")];
                }
            }];
        }else if (cellModel.index == 11) {
            [IDOFoundationCommand voiceControlToNotifyCommand:^(int errorCode) {
                if (errorCode == 0) {
                   [funcVC showToastWithText:lang(@"set page jump success")];
                }else if (errorCode == 6) {
                    [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
                }else {
                   [funcVC showToastWithText:lang(@"set page jump failed")];
                }
            }];
        }
    };
}

- (void)getTextFieldCallback
{
    __weak typeof(self) weakSelf = self;
    self.textFeildCallback = ^(UIViewController *viewController, UITextField *textField, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
        NSArray * pickerArray = strongSelf.pickerArray[textFieldModel.index];
        funcVC.pickerView.pickerArray = pickerArray;
        funcVC.pickerView.currentIndex = [pickerArray containsObject:textField.text] ? [pickerArray indexOfObject:textField.text] : 0 ;
        [funcVC.pickerView show];
        funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
            textField.text = selectStr;
            if(textFieldModel.index == 5) {
               textFieldModel.data = @[@([selectStr integerValue])];
            }else {
               textFieldModel.data = @[selectStr];
            }
            NSInteger index = [pickerArray containsObject:selectStr] ? [pickerArray indexOfObject:selectStr] : 0 ;
            FuncViewController * funcVc = (FuncViewController *)[IDODemoUtility getCurrentVC];
            if (textFieldModel.index == 0) {
                NSInteger type = index + 1;
                NSString * str = [NSString stringWithFormat:@"%@...",lang(@"set sport type")];
                [funcVc showLoadingWithMessage:str];
                [IDOFoundationCommand voiceControlActivityWithType:type callback:^(int errorCode) {
                    if (errorCode == 0) {
                        [funcVc showToastWithText:lang(@"set sport type success")];
                    }else if (errorCode == 6) {
                        [funcVc showToastWithText:lang(@"feature is not supported on the current device")];
                    }else {
                        [funcVc showToastWithText:lang(@"set sport type failed")];
                    }
                }];
            }else if (textFieldModel.index == 1) {
                BOOL isOpen = index;
                NSString * str = [NSString stringWithFormat:@"%@...",lang(@"set real time hr")];
                [funcVc showLoadingWithMessage:str];
                [IDOFoundationCommand voiceControlRealTimeHrWithSwitch:isOpen callback:^(int errorCode) {
                    if (errorCode == 0) {
                       [funcVc showToastWithText:lang(@"set real time hr success")];
                    }else if (errorCode == 6) {
                        [funcVc showToastWithText:lang(@"feature is not supported on the current device")];
                    }else {
                       [funcVc showToastWithText:lang(@"set real time hr failed")];
                    }
                }];
            }else if (textFieldModel.index == 2) {
                BOOL isOpen = index;
                NSString * str = [NSString stringWithFormat:@"%@...",lang(@"set no disturb")];
                [funcVc showLoadingWithMessage:str];
                [IDOFoundationCommand voiceControlNoDisturbWithSwitch:isOpen callback:^(int errorCode) {
                    if (errorCode == 0) {
                       [funcVc showToastWithText:lang(@"set no disturb success")];
                    }else if (errorCode == 6) {
                        [funcVc showToastWithText:lang(@"feature is not supported on the current device")];
                    }else {
                       [funcVc showToastWithText:lang(@"set no disturb failed")];
                    }
                }];
            }else if (textFieldModel.index == 3) {
                BOOL isOpen = index;
                NSString * str = [NSString stringWithFormat:@"%@...",lang(@"set wrist bright screen")];
                [funcVc showLoadingWithMessage:str];
                [IDOFoundationCommand voiceControlWristBrightScreenWithSwitch:isOpen callback:^(int errorCode) {
                    if (errorCode == 0) {
                       [funcVc showToastWithText:lang(@"set wrist bright screen success")];
                    }else if (errorCode == 6) {
                        [funcVc showToastWithText:lang(@"feature is not supported on the current device")];
                    }else {
                       [funcVc showToastWithText:lang(@"set wrist bright screen failed")];
                    }
                }];
            }else if (textFieldModel.index == 4) {
                NSInteger type = index + 1;
                NSString * str = [NSString stringWithFormat:@"%@...",lang(@"set music control")];
                [funcVc showLoadingWithMessage:str];
                [IDOFoundationCommand voiceControlMusicWithType:type callback:^(int errorCode) {
                    if (errorCode == 0) {
                      [funcVc showToastWithText:lang(@"set music control success")];
                    }else if (errorCode == 6) {
                        [funcVc showToastWithText:lang(@"feature is not supported on the current device")];
                    }else {
                      [funcVc showToastWithText:lang(@"set music control failed")];
                    }
                }];
            }else if (textFieldModel.index == 5) {
                NSInteger level = index;
                NSString * str = [NSString stringWithFormat:@"%@...",lang(@"set screen brightness")];
                [funcVc showLoadingWithMessage:str];
                [IDOFoundationCommand voiceControlBrightScreenWithLevel:level callback:^(int errorCode) {
                    if (errorCode == 0) {
                      [funcVc showToastWithText:lang(@"set screen level success")];
                    }else if (errorCode == 6) {
                        [funcVc showToastWithText:lang(@"feature is not supported on the current device")];
                    }else {
                      [funcVc showToastWithText:lang(@"set screen level failed")];
                    }
                }];
            }
        };
    };
}


- (void)listenVoiceCallback
{
    __weak typeof(self) weakSelf = self;
    [IDOFoundationCommand listenVoiceFileDataCommand:^(int state, int errorCode) {
        __strong typeof(self) strongSelf = weakSelf;
        if (errorCode == 0) {
            if (state == 1) {
               strongSelf.voiceView1.hidden = NO;
               [strongSelf.voiceView1 startCircleAnimation];
            }else if(state == 2) {
                strongSelf.voiceView1.hidden = YES;
               [strongSelf.voiceView1 stopCircleAnimation];
            }
        }else {
            strongSelf.voiceView1.hidden = YES;
            [strongSelf.voiceView1 stopCircleAnimation];
        }
    } complete:^(NSString * _Nullable filePath) {
        __strong typeof(self) strongSelf = weakSelf;
         NSFileManager* manager = [NSFileManager defaultManager];
          int fileSize = (int)[[manager attributesOfItemAtPath:filePath error:nil] fileSize];
          strongSelf.pcmFile = fopen([filePath UTF8String],"r");
          if (strongSelf.pcmFile) {
              countdown = 0;
             fseek(strongSelf.pcmFile, 0, SEEK_SET);
             strongSelf.pcmDataBuffer = malloc(EVERY_READ_LENGTH);
             strongSelf.offset = 0;
             strongSelf.bufferLength = fileSize;
             [strongSelf.sendDataTimer setFireDate:[NSDate date]];
         }
    }];
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    int index1 = 0;
    int index2 = 0;
    for (int i = 0; i < self.controlNames.count; i++) {
        if (i <= 5) {
           TextFieldCellModel * model1 = [[TextFieldCellModel alloc]init];
           model1.typeStr = @"oneTextField";
           model1.titleStr = self.controlNames[index1];
           model1.data = @[self.pickerArray[index1][0]];
           model1.cellHeight = 70.0f;
           model1.cellClass = [OneTextFieldTableViewCell class];
           model1.modelClass = [NSNull class];
           model1.isShowLine = YES;
           model1.index = index1;
           model1.textFeildCallback = self.textFeildCallback;
           [cellModels addObject:model1];
           index1++;
        }else {
            NSString * str = [self.controlNames objectAtIndex:i];
            FuncCellModel * model = [[FuncCellModel alloc]init];
            model.typeStr = @"oneButton";
            model.data = @[str];
            model.cellHeight = 70.0f;
            model.cellClass = [OneButtonTableViewCell class];
            model.modelClass = [NSNull class];
            model.isShowLine = YES;
            model.index = index2;
            model.buttconCallback = self.buttconCallback;
            [cellModels addObject:model];
            index2 ++;
        }
    }
    self.cellModels = cellModels;
}
@end

