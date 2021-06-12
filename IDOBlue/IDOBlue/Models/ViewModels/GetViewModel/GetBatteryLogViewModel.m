//
//  GetBatteryLogViewModel.m
//  IDOBlue
//
//  Created by hedongyang on 2021/3/9.
//  Copyright © 2021 hedongyang. All rights reserved.
//

#import "GetBatteryLogViewModel.h"
#import "FuncCellModel.h"
#import "OneButtonTableViewCell.h"
#import "TextViewCellModel.h"
#import "OneTextViewTableViewCell.h"
#import "IDODemoUtility.h"
#import "FuncViewController.h"
#import "NSObject+DemoToDic.h"

@interface GetBatteryLogViewModel()
@property (nonatomic,strong) UITextView * textView;
@property (nonatomic,copy)void(^textViewCallback)(UITextView * textView);
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation GetBatteryLogViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self listenUpdateState];
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

- (void)listenUpdateState
{
    __weak typeof(self) weakSelf = self;
    [IDOFoundationCommand listenStateChangeCommand:^(int errorCode, IDOControlDataUpdateModel * _Nullable model) {
        __strong typeof(self) strongSelf = weakSelf;
        if (errorCode == 0) {
            if (model.overHeat == 2) {
                [strongSelf getOverHeatLog];
            };
        }
    }];
}

- (void)getOverHeatLog
{
    __weak typeof(self) weakSelf = self;
    FuncViewController * funcVC = (FuncViewController *)[IDODemoUtility getCurrentVC];
    [funcVC showLoadingWithMessage:[NSString stringWithFormat:@"%@...",lang(@"get device battery log")]];
    [IDOFoundationCommand getBatteryLogInfoCommand:^(int errorCode, NSDictionary * _Nullable data) {
        __strong typeof(self) strongSelf = weakSelf;
       if (errorCode == 0) {
          [funcVC showToastWithText:lang(@"get device battery log success")];
          strongSelf.textView.text = [NSString stringWithFormat:@"%@",data];
       }else if (errorCode == 6) {
          [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
       }else {
          [funcVC showToastWithText:lang(@"get device battery log success")];
       }
    }];
}


- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf getOverHeatLog];
    };
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    FuncCellModel * model = [[FuncCellModel alloc]init];
    model.typeStr = @"oneButton";
    model.data = @[lang(@"get device battery log")];
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
