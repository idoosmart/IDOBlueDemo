//
//  GetEncryptionCodeViewModel.m
//  IDOBlue
//
//  Created by hedongyang on 2021/3/15.
//  Copyright © 2021 hedongyang. All rights reserved.
//

#import "GetEncryptionCodeViewModel.h"
#import "FuncCellModel.h"
#import "OneButtonTableViewCell.h"
#import "TextViewCellModel.h"
#import "OneTextViewTableViewCell.h"
#import "IDODemoUtility.h"
#import "FuncViewController.h"
#import "NSObject+DemoToDic.h"

@interface GetEncryptionCodeViewModel()
@property (nonatomic,strong) UITextView * textView;
@property (nonatomic,copy)void(^textViewCallback)(UITextView * textView);
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation GetEncryptionCodeViewModel

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
        [funcVC showLoadingWithMessage:[NSString stringWithFormat:@"%@...",lang(@"get function list")]];
        [IDOFoundationCommand getFuncTableCommand:^(int errorCode, IDOGetDeviceFuncBluetoothModel * _Nullable data) {
            if (errorCode == 0) {
                [funcVC showLoadingWithMessage:[NSString stringWithFormat:@"%@...",lang(@"get encrypted code")]];
                [IDOFoundationCommand getEncryptedCodeCommand:^(int errorCode, IDOSetBindingInfoBluetoothModel * _Nullable data) {
                    if (errorCode == 0) {
                        [funcVC showToastWithText:lang(@"get encrypted code success")];
                        strongSelf.textView.text = [NSString stringWithFormat:@"%@\n%@",strongSelf.textView.text,data.dicFromObject];
                        [IDOFoundationCommand detectionEncryptedCode];
                    }else if (errorCode == 6) {
                       [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
                    }else {
                       [funcVC showToastWithText:lang(@"get encrypted code failed")];
                    }
                }];
                [funcVC showToastWithText:lang(@"get function list success")];
                strongSelf.textView.text = [NSString stringWithFormat:@"encryptedAuth == %d",data.funcTable29Model.encryptedAuth];
            }else if (errorCode == 6) {
                [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
            }else {
                [funcVC showToastWithText:lang(@"get function list failed") ];
            }
        }];
        
    };
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    FuncCellModel * model = [[FuncCellModel alloc]init];
    model.typeStr = @"oneButton";
    model.data = @[lang(@"get encrypted code")];
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

@end
