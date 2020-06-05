//
//  ViewController.h
//  IDOBluetoothDemo
//
//  Created by hedongyang on 2018/8/31.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "IDODemoUtility.h"
#import "BasePickerView.h"
#import "SetMenuView.h"
#import "BaseDatePickerView.h"

@interface BaseViewController : UIViewController
@property (nonatomic,strong) MBProgressHUD * progressHUD;
@property (nonatomic,strong) BasePickerView * pickerView;
@property (nonatomic,strong) BaseDatePickerView * datePickerView;
@property (nonatomic,strong) SetMenuView * menuView;
@property (nonatomic,strong) UILabel * statusLabel;
@property (nonatomic,strong) UILabel * timerLabel;
- (void)showLoadingWithMessage:(NSString *)message;
- (void)showToastWithText:(NSString *)message;
- (void)showUpdateProgress:(float)progress;
- (void)showSyncProgress:(float)progress;
- (void)startSync;
@end

