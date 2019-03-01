//
//  SyncAllViewModel.m
//  IDOBlue
//
//  Created by apple on 2018/10/4.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "SyncAllViewModel.h"
#import "FuncCellModel.h"
#import "OneButtonTableViewCell.h"
#import "TextViewCellModel.h"
#import "OneTextViewTableViewCell.h"
#import "IDODemoUtility.h"
#import "FuncViewController.h"
#import "NSObject+DemoToDic.h"

@interface SyncAllViewModel()
@property (nonatomic,strong) UITextView * textView;
@property (nonatomic,copy)void(^textViewCallback)(UITextView * textView);
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation SyncAllViewModel
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
        [funcVC showLoadingWithMessage:@"同步数据..."];
        //同步日志
        [IDOSyncManager syncDataJsonCallback:^(IDO_CURRENT_SYNC_TYPE syncType, NSString * _Nullable jsonStr) {
            NSString * newLogStr = [NSString stringWithFormat:@"%@\n\n%@",strongSelf.textView.text,jsonStr];
            TextViewCellModel * model = [strongSelf.cellModels firstObject];
            model.data = @[newLogStr?:@""];
            strongSelf.textView.text = newLogStr;
            // [strongSelf.textView scrollRangeToVisible:NSMakeRange(strongSelf.textView.text.length, 1)];
        }];
        //同步完成
        [IDOSyncManager syncDataCompleteCallback:^(IDO_SYNC_COMPLETE_STATUS stateCode, NSString * _Nullable stateInfo) {
            NSString * newLogStr = [NSString stringWithFormat:@"%@\n\n%@",strongSelf.textView.text,stateInfo];
            TextViewCellModel * model = [strongSelf.cellModels firstObject];
            model.data = @[newLogStr?:@""];
            strongSelf.textView.text = newLogStr;
           // [strongSelf.textView scrollRangeToVisible:NSMakeRange(strongSelf.textView.text.length, 1)];
            if (stateCode == IDO_SYNC_GLOBAL_COMPLETE) {
              [funcVC showToastWithText:@"同步数据完成"];
            }
        } failCallback:^(int errorCode) {
            [funcVC showToastWithText:@"同步失败"];
        }];
        //同步进度
        [IDOSyncManager syncDataProgressCallback:^(float progress) {
            NSString * allStr = [NSString stringWithFormat:@"%@...%.2f",@"SYNC_DATA_PROGRESS",progress * 100.0f];
            NSString * newLogStr = [NSString stringWithFormat:@"%@\n\n%@",strongSelf.textView.text,allStr];
            TextViewCellModel * model = [strongSelf.cellModels firstObject];
            model.data = @[newLogStr?:@""];
            strongSelf.textView.text = newLogStr;
            //[strongSelf.textView scrollRangeToVisible:NSMakeRange(strongSelf.textView.text.length, 1)];
            [funcVC showSyncProgress:progress];
        }];
        
        //同步
        IDOSyncManager.startSync(YES);
    };
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    FuncCellModel * model = [[FuncCellModel alloc]init];
    model.typeStr = @"oneButton";
    model.data = @[@"同步数据"];
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
