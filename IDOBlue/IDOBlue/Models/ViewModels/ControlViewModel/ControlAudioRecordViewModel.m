//
//  ControlAudioRecordViewModel.m
//  IDOBlue
//
//  Created by hedongyang on 2021/8/27.
//  Copyright © 2021 hedongyang. All rights reserved.
//

#import <IDOAlexaClient/IDOAlexaClient.h>
#import "ControlAudioRecordViewModel.h"
#import "FuncCellModel.h"
#import "OneButtonTableViewCell.h"
#import "FuncViewController.h"
#import "RecordAudio.h"

@interface ControlAudioRecordViewModel()
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation ControlAudioRecordViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getButtonCallback];
        [self getCellModels];
    }
    return self;
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    
    FuncCellModel * model3 = [[FuncCellModel alloc]init];
    model3.typeStr = @"oneButton";
    model3.data = @[lang(@"audio record control")];
    model3.cellHeight = 70.0f;
    model3.cellClass = [OneButtonTableViewCell class];
    model3.modelClass = [NSNull class];
    model3.isShowLine = YES;
    model3.buttconCallback = self.buttconCallback;
    [cellModels addObject:model3];
    
    FuncCellModel * model4 = [[FuncCellModel alloc]init];
    model4.typeStr = @"oneButton";
    model4.data = @[lang(@"alexa test")];
    model4.cellHeight = 70.0f;
    model4.cellClass = [OneButtonTableViewCell class];
    model4.modelClass = [NSNull class];
    model4.isShowLine = YES;
    model4.buttconCallback = self.buttconCallback;
    [cellModels addObject:model4];
    
    self.cellModels = cellModels;
}

- (void)getButtonCallback
{
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        if (indexPath.row == 0) {
            [funcVC showLoadingWithMessage:[NSString stringWithFormat:@"%@...",lang(@"audio record control")]];
            NSString * dirPath = [NSBundle mainBundle].bundlePath;
            dirPath = [dirPath stringByAppendingPathComponent:@"Files"];
            NSString * filePath = [dirPath stringByAppendingPathComponent:@"3.mp3"];
            NSData * data = [NSData dataWithContentsOfFile:filePath];
            if ([[IDOAlexaAudioManager shareInstance] mp3AudioToPcmWithData:data]) {
                [IDOAlexaAudioManager shareInstance].transferStateCallback = ^(int stateCode) {
                    if (stateCode == 2) {
                        [funcVC showToastWithText:lang(@"audio record control success")];
                    }else if (stateCode > 2) {
                        [funcVC showToastWithText:lang(@"audio record control failed")];
                    }
                };
                [[IDOAlexaAudioManager shareInstance] startTransferAudioFile];
            }else {
                [funcVC showToastWithText:lang(@"audio record control failed")];
            }
        }else {
            [IDOAlexaManager registerAlexa];
            [IDOAlexaManager isPlayAudio:YES];
            [IDOAlexaManager authorizeRequestWithproductId:@"id206"
                                                   Handler:^(BOOL isLogin) {
                if (isLogin) {
                    NSLog(@"alexe 登录成功");
                }else {
                    NSLog(@"alexe 登录失败");
                }
            }];
        }
    };
}

@end
