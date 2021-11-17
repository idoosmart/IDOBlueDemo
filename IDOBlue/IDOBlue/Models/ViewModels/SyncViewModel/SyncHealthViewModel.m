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

- (void)dealloc
{
    
}

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
        //只针对v2运动数据有效
        initSyncManager().wantToSyncType = IDO_WANT_TO_SYNC_HEALTH_ITEM_TYPE;
        initSyncManager().addSyncComplete(^(IDO_SYNC_COMPLETE_STATUS stateCode) {
            if (stateCode == IDO_SYNC_GLOBAL_COMPLETE) {
                [funcVC showToastWithText:lang(@"sync data complete")];
            }
        }).addSyncProgess(^(IDO_CURRENT_SYNC_TYPE type, float progress) {
            [funcVC showSyncProgress:progress];
        }).addSyncFailed(^(int errorCode) {
            NSString * newLogStr = [NSString stringWithFormat:@"%@\n\n%@",strongSelf.textView.text,[IDOErrorCodeToStr errorCodeToStr:errorCode]];
            TextViewCellModel * model = [strongSelf.cellModels firstObject];
            model.data = @[newLogStr?:@""];
            strongSelf.textView.text = newLogStr;
            [funcVC showToastWithText:lang(@"sync data failed")];
        }).addSyncSwim(^(NSString * jsonStr){
            NSString * newLogStr = [NSString stringWithFormat:@"%@\n\n%@",strongSelf.textView.text,jsonStr];
            TextViewCellModel * model = [strongSelf.cellModels firstObject];
            model.data = @[newLogStr?:@""];
            strongSelf.textView.text = newLogStr;
        }).addSyncHeartRate(^(NSString * jsonStr){
            NSString * newLogStr = [NSString stringWithFormat:@"%@\n\n%@",strongSelf.textView.text,jsonStr];
            TextViewCellModel * model = [strongSelf.cellModels firstObject];
            model.data = @[newLogStr?:@""];
            strongSelf.textView.text = newLogStr;
        }).addSyncBloodOxygen(^(NSString * jsonStr){
            NSString * newLogStr = [NSString stringWithFormat:@"%@\n\n%@",strongSelf.textView.text,jsonStr];
            TextViewCellModel * model = [strongSelf.cellModels firstObject];
            model.data = @[newLogStr?:@""];
            strongSelf.textView.text = newLogStr;
        }).addSyncBp(^(NSString * jsonStr){
            NSString * newLogStr = [NSString stringWithFormat:@"%@\n\n%@",strongSelf.textView.text,jsonStr];
            TextViewCellModel * model = [strongSelf.cellModels firstObject];
            model.data = @[newLogStr?:@""];
            strongSelf.textView.text = newLogStr;
        }).addSyncSleep(^(NSString * jsonStr){
            NSString * newLogStr = [NSString stringWithFormat:@"%@\n\n%@",strongSelf.textView.text,jsonStr];
            TextViewCellModel * model = [strongSelf.cellModels firstObject];
            model.data = @[newLogStr?:@""];
            strongSelf.textView.text = newLogStr;
        }).addSyncSport(^(NSString * jsonStr){
            NSString * newLogStr = [NSString stringWithFormat:@"%@\n\n%@",strongSelf.textView.text,jsonStr];
            TextViewCellModel * model = [strongSelf.cellModels firstObject];
            model.data = @[newLogStr?:@""];
            strongSelf.textView.text = newLogStr;
        }).addSyncPressure(^(NSString * jsonStr){
            NSString * newLogStr = [NSString stringWithFormat:@"%@\n\n%@",strongSelf.textView.text,jsonStr];
            TextViewCellModel * model = [strongSelf.cellModels firstObject];
            model.data = @[newLogStr?:@""];
            strongSelf.textView.text = newLogStr;
        }).mandatorySyncConfig(NO);
        [IDOSyncManager startSync];
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
