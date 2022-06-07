//
//  SetFindPhoneViewModel.m
//  IDOBluetoothDemo
//
//  Created by hedongyang on 2018/9/25.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "SetFindPhoneViewModel.h"
#import "SwitchCellModel.h"
#import "FuncCellModel.h"
#import "EmpltyCellModel.h"
#import "FuncViewController.h"
#import "OneButtonTableViewCell.h"
#import "OneSwitchTableViewCell.h"
#import "EmptyTableViewCell.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface SetFindPhoneViewModel()
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^switchCallback)(UIViewController * viewController,UISwitch * onSwitch,UITableViewCell * tableViewCell);
@property (nonatomic,strong) IDOSetFindPhoneInfoBuletoothModel * findPhoneModel;
@end

@implementation SetFindPhoneViewModel

- (void)dealloc
{
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getSwitchCallback];
        [self getButtonCallback];
        [self getCellModels];
    }
    return self;
}

- (IDOSetFindPhoneInfoBuletoothModel *)findPhoneModel
{
    if (!_findPhoneModel) {
        _findPhoneModel = [IDOSetFindPhoneInfoBuletoothModel currentModel];
    }
    return _findPhoneModel;
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    
    SwitchCellModel * model1 = [[SwitchCellModel alloc]init];
    model1.typeStr = @"oneSwitch";
    model1.titleStr = lang(@"set find phone switch");
    model1.data = @[@(self.findPhoneModel.isOpen)];
    model1.cellHeight = 70.0f;
    model1.cellClass = [OneSwitchTableViewCell class];
    model1.modelClass = [NSNull class];
    model1.isShowLine = YES;
    model1.switchCallback = self.switchCallback;
    [cellModels addObject:model1];
    
    EmpltyCellModel * model2 = [[EmpltyCellModel alloc]init];
    model2.typeStr = @"empty";
    model2.cellHeight = 30.0f;
    model2.isShowLine = YES;
    model2.cellClass  = [EmptyTableViewCell class];
    [cellModels addObject:model2];
    
    FuncCellModel * model3 = [[FuncCellModel alloc]init];
    model3.typeStr = @"oneButton";
    model3.data = @[lang(@"set find phone button")];
    model3.cellHeight = 70.0f;
    model3.cellClass = [OneButtonTableViewCell class];
    model3.modelClass = [NSNull class];
    model3.isShowLine = YES;
    model3.buttconCallback = self.buttconCallback;
    [cellModels addObject:model3];
    self.cellModels = cellModels;
}

- (void)getSwitchCallback
{
    __weak typeof(self) weakSelf = self;
    self.switchCallback = ^(UIViewController *viewController, UISwitch *onSwitch, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        SwitchCellModel * switchCellModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
        strongSelf.findPhoneModel.isOpen = onSwitch.isOn;
        switchCellModel.data = @[@(strongSelf.findPhoneModel.isOpen)];
    };
}

- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        
        [funcVC showLoadingWithMessage:lang(@"set find phone switch...")];
        [IDOFoundationCommand setFindPhoneCommand:strongSelf.findPhoneModel
                                        callback:^(int errorCode) {
            if(errorCode == 0) {
                [funcVC showToastWithText:lang(@"set find phone success")];
            }else if (errorCode == 6) {
                [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
            }else {
                [funcVC showToastWithText:lang(@"set find phone failed")];
            }
        }];
    };
    
    __block SystemSoundID sound = kSystemSoundID_Vibrate;
    NSString *path = @"/System/Library/Audio/UISounds/sms-received6.caf";
    OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&sound);
    [IDOFoundationCommand listenFindPhoneStartCommand:^(int errorCode) {
        if (errorCode == 0) {
        if (error != kAudioServicesNoError) {
            sound = 0;
        }
        AudioServicesPlaySystemSound(sound);//播放声音
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);//静音模式下震动
        }
    }];
    
    [IDOFoundationCommand listenFindPhoneStopCommand:^(int errorCode) {  //此方法暂时无用
        if (errorCode == 0) {
        if (error != kAudioServicesNoError) {
            sound = 0;
        }
         AudioServicesRemoveSystemSoundCompletion(sound);
         AudioServicesDisposeSystemSoundID(sound);
        }
    }];
}
@end
