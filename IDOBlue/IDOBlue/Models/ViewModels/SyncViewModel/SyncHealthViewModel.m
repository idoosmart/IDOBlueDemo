//
//  SyncHealthViewModel.m
//  IDOBlue
//
//  Created by apple on 2018/10/4.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "SyncHealthViewModel.h"
#import "FuncCellModel.h"
#import "TextViewCellModel.h"
#import "OneButtonTableViewCell.h"
#import "OneTextViewTableViewCell.h"
#import "FuncViewController.h"
#import "IDODemoUtility.h"
#import "NSObject+DemoToDic.h"

@interface SyncHealthViewModel()
@property (nonatomic,strong) UITextView * textView;
@property (nonatomic,copy)void(^textViewCallback)(UITextView * textView);
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation SyncHealthViewModel
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
        [funcVC showLoadingWithMessage:lang(@"sync health data...")];
        //同步健康日志
        [IDOSyncHealth syncHealthDataCallback:^(NSString * _Nullable jsonStr) {
            if (![IDOConsoleBoard borad].isShow) {
                NSString * newLogStr = [NSString stringWithFormat:@"%@\n\n%@",strongSelf.textView.text,jsonStr];
                TextViewCellModel * model = [strongSelf.cellModels firstObject];
                model.data = @[newLogStr?:@""];
                strongSelf.textView.text = newLogStr;
            }
            // [strongSelf.textView scrollRangeToVisible:NSMakeRange(strongSelf.textView.text.length, 1)];
        }];
        //同步健康完成
        [IDOSyncHealth syncHealthDataCompleteCallback:^(int errorCode) {
            if (![IDOConsoleBoard borad].isShow) {
                NSString * errorStr = [IDOErrorCodeToStr errorCodeToStr:errorCode];
                NSString * activityStr = [NSString stringWithFormat:@"%@ ERROR_CODE = %@",@"SYNC_HEALTH_COMPLETE",errorStr];
                NSString * newLogStr = [NSString stringWithFormat:@"%@\n\n%@",strongSelf.textView.text,activityStr];
                TextViewCellModel * model = [strongSelf.cellModels firstObject];
                model.data = @[newLogStr?:@""];
                strongSelf.textView.text = newLogStr;
            }
          //  [strongSelf.textView scrollRangeToVisible:NSMakeRange(strongSelf.textView.text.length, 1)];
            [funcVC showToastWithText:lang(@"sync health data complete")];
        }];
        //同步健康进度
        [IDOSyncHealth syncHealthDataProgressCallback:^(int progress) {
            if (![IDOConsoleBoard borad].isShow) {
                NSString * healthStr = [NSString stringWithFormat:@"%@...%d",@"SYNC_HEALTH_PROGRESS",progress];
                NSString * newLogStr = [NSString stringWithFormat:@"%@\n\n%@",strongSelf.textView.text,healthStr];
                TextViewCellModel * model = [strongSelf.cellModels firstObject];
                model.data = @[newLogStr?:@""];
                strongSelf.textView.text = newLogStr;
                // [strongSelf.textView scrollRangeToVisible:NSMakeRange(strongSelf.textView.text.length, 1)];
                [funcVC showSyncProgress:progress/100.0f];
            }
        }];
        //同步健康开始
        [IDOSyncHealth startSync];
    };
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    FuncCellModel * model = [[FuncCellModel alloc]init];
    model.typeStr = @"oneButton";
    model.data = @[lang(@"health data sync")];
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
    [cellModels addObject:model2];
    
    self.cellModels = cellModels;
}
@end
