//
//  GetVersionInfoViewModel.m
//  IDOBlue
//
//  Created by 何东阳 on 2019/1/10.
//  Copyright © 2019年 hedongyang. All rights reserved.
//

#import "GetVersionInfoViewModel.h"
#import "FuncCellModel.h"
#import "TextViewCellModel.h"
#import "IDODemoUtility.h"
#import "NSObject+DemoToDic.h"
#import "OneButtonTableViewCell.h"
#import "OneTextViewTableViewCell.h"
#import "FuncViewController.h"


@interface GetVersionInfoViewModel()
@property (nonatomic,strong) UITextView * textView;
@property (nonatomic,copy)void(^textViewCallback)(UITextView * textView);
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation GetVersionInfoViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getButtonCallback];
        [self getTextViewCallback];
        [self getCellModels];
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
        FuncViewController * funcVC = (FuncViewController *)viewController;
        [funcVC showLoadingWithMessage:[NSString stringWithFormat:@"%@...",lang(@"get version information")] ];
        [IDOFoundationCommand getVersionInfoCommand:^(int errorCode, IDOGetVersionInfoBluetoothModel * _Nullable data) {
            if (errorCode == 0) {
                [funcVC showToastWithText:lang(@"get version information success") ];
                NSString * sdkv   = [NSString stringWithFormat:@"sdk : %ld",(long)data.sdkVersion];
                NSString * hrv    = [NSString stringWithFormat:@"hr : %ld",(long)data.hrAlgorithmVersion];
                NSString * sleepv = [NSString stringWithFormat:@"sleep : %ld",(long)data.sleepAlgorithmVersion];
                NSString * stepv    = [NSString stringWithFormat:@"step : %ld",(long)data.stepAlgorithmVersion];
                NSString * gesturev = [NSString stringWithFormat:@"gesture : %ld",(long)data.gestureRecognitionVersion];
                NSString * pcbv     = [NSString stringWithFormat:@"pcb : %ld",(long)data.pcbVersion];
                strongSelf.textView.text = [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%@\n%@\n",sdkv,hrv,sleepv,stepv,gesturev,pcbv];
            }else if (errorCode == 6) {
                [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
            }else {
                [funcVC showToastWithText:lang(@"get version information failed")];
            }
        }];
    };
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    FuncCellModel * model = [[FuncCellModel alloc]init];
    model.typeStr = @"oneButton";
    model.data = @[lang(@"get version information")];
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
    IDOGetVersionInfoBluetoothModel * versionModel = [IDOGetVersionInfoBluetoothModel currentModel];
    NSString * sdkv   = [NSString stringWithFormat:@"sdk : %ld",(long)versionModel.sdkVersion];
    NSString * hrv    = [NSString stringWithFormat:@"hr : %ld",(long)versionModel.hrAlgorithmVersion];
    NSString * sleepv = [NSString stringWithFormat:@"sleep : %ld",(long)versionModel.sleepAlgorithmVersion];
    NSString * stepv  = [NSString stringWithFormat:@"step : %ld",(long)versionModel.stepAlgorithmVersion];
    NSString * gesturev = [NSString stringWithFormat:@"gesture : %ld",(long)versionModel.gestureRecognitionVersion];
    NSString * pcbv     = [NSString stringWithFormat:@"pcb : %ld",(long)versionModel.pcbVersion];
    NSString * version  = [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%@\n%@\n",sdkv,hrv,sleepv,stepv,gesturev,pcbv];
    model2.data = @[version];
    [cellModels addObject:model2];
    self.cellModels = cellModels;
}
@end
