//
//  SyncGpsViewModel.m
//  IDOBlue
//
//  Created by apple on 2018/10/4.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "SyncGpsViewModel.h"
#import "FuncCellModel.h"
#import "OneButtonTableViewCell.h"
#import "TextViewCellModel.h"
#import "OneTextViewTableViewCell.h"
#import "IDODemoUtility.h"
#import "FuncViewController.h"
#import "NSObject+DemoToDic.h"

@interface SyncGpsViewModel()
@property (nonatomic,strong) UITextView * textView;
@property (nonatomic,copy)void(^textViewCallback)(UITextView * textView);
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation SyncGpsViewModel
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
        [funcVC showLoadingWithMessage:@"同步GPS..."];
        [IDOFoundationCommand getActivityCountCommand:^(int errorCode,
                                                        IDOGetActivityCountBluetoothModel * _Nullable data) {
            if (errorCode == 0) {
                if (data.gpsCount > 0) {
                    //同步GPS日志
                    [IDOSyncGps syncGpsDataCallback:^(NSString * _Nullable jsonStr) {
                        NSString * newLogStr = [NSString stringWithFormat:@"%@\n\n%@",strongSelf.textView.text,jsonStr];
                        TextViewCellModel * model = [strongSelf.cellModels firstObject];
                        model.data = @[newLogStr?:@""];
                        strongSelf.textView.text = newLogStr;
                        //  [strongSelf.textView scrollRangeToVisible:NSMakeRange(strongSelf.textView.text.length, 1)];
                    }];
                    //同步GPS完成
                    [IDOSyncGps syncGpsDataCompleteCallback:^(int errorCode) {
                        NSString * errorStr = [IDOErrorCodeToStr errorCodeToStr:errorCode];
                        NSString * activityStr = [NSString stringWithFormat:@"%@ ERROR_CODE = %@",@"SYNC_GPS_COMPLETE",errorStr];
                        NSString * newLogStr = [NSString stringWithFormat:@"%@\n\n%@",strongSelf.textView.text,activityStr];
                        TextViewCellModel * model = [strongSelf.cellModels firstObject];
                        model.data = @[newLogStr?:@""];
                        strongSelf.textView.text = newLogStr;
                      //  [strongSelf.textView scrollRangeToVisible:NSMakeRange(strongSelf.textView.text.length, 1)];
                        [funcVC showToastWithText:@"同步GPS完成"];
                    }];
                    //同步GPS进度
                    [IDOSyncGps syncGpsDataProgressCallback:^(int progress) {
                        NSString * gpsStr = [NSString stringWithFormat:@"%@...%d",@"SYNC_GPS_PROGRESS",progress];
                        NSString * newLogStr = [NSString stringWithFormat:@"%@\n\n%@",strongSelf.textView.text,gpsStr];
                        TextViewCellModel * model = [strongSelf.cellModels firstObject];
                        model.data = @[newLogStr?:@""];
                        strongSelf.textView.text = newLogStr;
                      //  [strongSelf.textView scrollRangeToVisible:NSMakeRange(strongSelf.textView.text.length, 1)];
                        [funcVC showSyncProgress:progress/100.0f];
                    }];
                    //同步GPS开始
                    [IDOSyncGps startSync];
                }else {
                    NSString * activityStr = [NSString stringWithFormat:@"%@...%d",@"SYNC_GPS_COUNT",0];
                    NSString * newLogStr = [NSString stringWithFormat:@"%@\n\n%@",strongSelf.textView.text,activityStr];
                    TextViewCellModel * model = [strongSelf.cellModels firstObject];
                    model.data = @[newLogStr?:@""];
                    strongSelf.textView.text = newLogStr;
                   // [strongSelf.textView scrollRangeToVisible:NSMakeRange(strongSelf.textView.text.length, 1)];
                    [funcVC showToastWithText:@"暂无GPS数据可同步"];
                }
            }else {
                [funcVC showToastWithText:@"获取GPS数量失败"];
            }
        }];
    };
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    FuncCellModel * model = [[FuncCellModel alloc]init];
    model.typeStr = @"oneButton";
    model.data = @[@"同步GPS"];
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
