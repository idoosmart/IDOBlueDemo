//
//  AiVoiceViewModel.m
//  IDOBlue
//
//  Created by apple on 2018/10/3.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "AiVoiceViewModel.h"
#import "FuncCellModel.h"
#import "OneButtonTableViewCell.h"
#import "TextViewCellModel.h"
#import "OneTextViewTableViewCell.h"
#import "IDODemoUtility.h"
#import "FuncViewController.h"
#import "NSObject+DemoToDic.h"
#import <AVFoundation/AVFoundation.h>

@interface AiVoiceViewModel()<IDOAiVoiceManagerDelegate>
@property (nonatomic,strong) UITextView * textView;
@property (nonatomic,copy)void(^textViewCallback)(UITextView * textView);
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation AiVoiceViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getButtonCallback];
        [self getTextViewCallback];
        [self getCellModels];
        [IDOAiVoiceManager shareInstance].delegate = self;
    }
    return self;
}

- (void)getTextViewCallback
{
    __weak typeof(self) weakSelf = self;
    self.textViewCallback = ^(UITextView *textView) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)[IDODemoUtility getCurrentVC];
        funcVC.tableView.scrollEnabled = NO;
        strongSelf.textView = textView;
    };
}

- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        
    };
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    FuncCellModel * model = [[FuncCellModel alloc]init];
    model.typeStr = @"oneButton";
    model.data = @[@"播放音频"];
    model.cellHeight = 70.0f;
    model.cellClass = [OneButtonTableViewCell class];
    model.modelClass = [NSNull class];
    model.isShowLine = YES;
    model.buttconCallback = self.buttconCallback;
    [cellModels addObject:model];
    
    TextViewCellModel * model2 = [[TextViewCellModel alloc]init];
    model2.typeStr = @"oneTextView";
    model2.cellHeight = [IDODemoUtility getCurrentVC].view.bounds.size.height-110;
    model2.cellClass  = [OneTextViewTableViewCell class];
    model2.textViewCallback = self.textViewCallback;
    model2.data = @[@""];
    [cellModels addObject:model2];
    
    self.cellModels = cellModels;
}

- (void)aiVoiceAllSize:(int)allSize lostSize:(int)lostSize {
    
}

- (void)aiVoiceDeviceRequest:(int)type {
    // 创建UIAlertController
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"进入ai语音" preferredStyle:UIAlertControllerStyleAlert];

    // 创建UIAlertAction并添加到UIAlertController
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 点击确定按钮后的处理逻辑
//        [IDOAiVoiceManager replyAiVoiceApp:0 release:0];
    }];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        // 点击取消按钮后的处理逻辑
        NSLog(@"取消按钮被点击");
    }];

    [alertController addAction:okAction];
    [alertController addAction:cancelAction];

    // 在当前视图控制器中显示UIAlertController
    [[IDODemoUtility getCurrentVC] presentViewController:alertController animated:YES completion:nil];
}

- (void)aiVoiceEncodeFile:(nonnull NSString *)filePath encodeSate:(int)state {
    NSError *error;
    NSURL *fileURL = [NSURL fileURLWithPath: filePath];
    
    AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:&error];

    if (error) {
        NSLog(@"Error in audioPlayer: %@", [error localizedDescription]);
    } else {
        
        self.textView.text = [NSString stringWithFormat:@"file path == %@",filePath];
//        [audioPlayer prepareToPlay];
        [audioPlayer play];
    }
}

- (void)aiVoiceOperationState:(int)state {
    
}

- (void)aiVoiceSendTextInfoReply:(int)errorCode {
    
}

- (void)aiVoiceSendTextTranVoiceInfoReply {
    
}

- (void)aiVoiceToTextConfirmComplete:(int)type sureState:(int)sure {
    
}

@end

