//
//  SyncBopViewModel.m
//  IDOBlue
//
//  Created by 何东阳 on 2019/1/10.
//  Copyright © 2019年 hedongyang. All rights reserved.
//

#import "SyncBopViewModel.h"
#import "FuncCellModel.h"
#import "TextViewCellModel.h"
#import "OneButtonTableViewCell.h"
#import "OneTextViewTableViewCell.h"
#import "FuncViewController.h"
#import "IDODemoUtility.h"
#import "NSObject+DemoToDic.h"

@interface SyncBopViewModel ()
@property (nonatomic,strong) UITextView * textView;
@property (nonatomic,copy)void(^textViewCallback)(UITextView * textView);
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation SyncBopViewModel
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
        [funcVC showLoadingWithMessage:@"同步血氧压力数据..."];
        //同步血氧压力日
        [IDOSyncBop syncBloodOxygenPressureDataCallback:^(NSString * _Nullable jsonStr) {
            NSString * newLogStr = [NSString stringWithFormat:@"%@\n\n%@",strongSelf.textView.text,jsonStr];
            TextViewCellModel * model = [strongSelf.cellModels firstObject];
            model.data = @[newLogStr?:@""];
            strongSelf.textView.text = newLogStr;
        }];
        
        //同步血氧压力完成
        [IDOSyncBop syncBloodOxygenPressureDataCompleteCallback:^(int errorCode) {
            NSString * errorStr = [IDOErrorCodeToStr errorCodeToStr:errorCode];
            NSString * activityStr = [NSString stringWithFormat:@"%@ ERROR_CODE = %@",@"SYNC_HEALTH_COMPLETE",errorStr];
            NSString * newLogStr = [NSString stringWithFormat:@"%@\n\n%@",strongSelf.textView.text,activityStr];
            TextViewCellModel * model = [strongSelf.cellModels firstObject];
            model.data = @[newLogStr?:@""];
            strongSelf.textView.text = newLogStr;
            [funcVC showToastWithText:@"同步血氧压力完成"];
        }];
        //同步血氧压力进度
        [IDOSyncBop syncBloodOxygenPressureDataProgressCallback:^(int progress) {
            NSString * healthStr = [NSString stringWithFormat:@"%@...%d",@"SYNC_HEALTH_PROGRESS",progress];
            NSString * newLogStr = [NSString stringWithFormat:@"%@\n\n%@",strongSelf.textView.text,healthStr];
            TextViewCellModel * model = [strongSelf.cellModels firstObject];
            model.data = @[newLogStr?:@""];
            strongSelf.textView.text = newLogStr;
            [funcVC showSyncProgress:progress/100.0f];
        }];
        //同步血氧压力开始
        [IDOSyncBop startSync];
    };
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    FuncCellModel * model = [[FuncCellModel alloc]init];
    model.typeStr = @"oneButton";
    model.data = @[@"同步血氧压力数据"];
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
