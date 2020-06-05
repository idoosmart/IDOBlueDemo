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

+ (NSString *)getStateCode:(IDO_SYNC_COMPLETE_STATUS)stateCode
{
    if (stateCode == IDO_SYNC_CONFIG_COMPLETE) {
        return @"IDO_SYNC_CONFIG_COMPLETE";
    }else if (stateCode == IDO_SYNC_CONFIG_COMPLETE_EXCEPTION) {
        return @"IDO_SYNC_CONFIG_COMPLETE_EXCEPTION";
    }else if (stateCode == IDO_SYNC_HEALTH_COMPLETE) {
        return @"IDO_SYNC_HEALTH_COMPLETE";
    }else if (stateCode == IDO_SYNC_HEALTH_COMPLETE_EXCEPTION) {
        return @"IDO_SYNC_HEALTH_COMPLETE_EXCEPTION";
    }else if (stateCode == IDO_SYNC_V3_HEALTH_COMPLETE) {
        return @"IDO_SYNC_V3_HEALTH_COMPLETE";
    }else if (stateCode == IDO_SYNC_V3_HEALTH_COMPLETE_EXCEPTION) {
        return @"IDO_SYNC_V3_HEALTH_COMPLETE_EXCEPTION";
    }else if (stateCode == IDO_SYNC_ACTIVITY_COMPLETE) {
        return @"IDO_SYNC_ACTIVITY_COMPLETE";
    }else if (stateCode == IDO_SYNC_ACTIVITY_COMPLETE_EXCEPTION) {
        return @"IDO_SYNC_ACTIVITY_COMPLETE_EXCEPTION";
    }else if (stateCode == IDO_SYNC_GPS_COMPLETE) {
        return @"IDO_SYNC_GPS_COMPLETE";
    }else if (stateCode == IDO_SYNC_GPS_COMPLETE_EXCEPTION) {
        return @"IDO_SYNC_GPS_COMPLETE_EXCEPTION";
    }else if (stateCode == IDO_SYNC_GLOBAL_COMPLETE) {
        return @"IDO_SYNC_GLOBAL_COMPLETE";
    }
    return @"";
}

- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        if (!IDO_BLUE_ENGINE.managerEngine.isConnected)return;
        [funcVC showLoadingWithMessage:lang(@"sync data...")];
        initSyncManager().wantToSyncType = IDO_WANT_TO_SYNC_CONFIG_ITEM_TYPE | IDO_WANT_TO_SYNC_HEALTH_ITEM_TYPE
        | IDO_WANT_TO_SYNC_ACTIVITY_ITEM_TYPE | IDO_WANT_TO_SYNC_GPS_ITEM_TYPE;
        initSyncManager().addSyncComplete(^(IDO_SYNC_COMPLETE_STATUS stateCode) {
            NSString * newLogStr = [NSString stringWithFormat:@"%@\n\n%@",strongSelf.textView.text,[SyncAllViewModel getStateCode:stateCode]];
            TextViewCellModel * model = [strongSelf.cellModels firstObject];
            model.data = @[newLogStr?:@""];
            strongSelf.textView.text = newLogStr;
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
        }).addSyncGps(^(NSString * jsonStr){
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
        }).addSyncActivity(^(NSString * jsonStr){
            NSString * newLogStr = [NSString stringWithFormat:@"%@\n\n%@",strongSelf.textView.text,jsonStr];
            TextViewCellModel * model = [strongSelf.cellModels firstObject];
            model.data = @[newLogStr?:@""];
            strongSelf.textView.text = newLogStr;
        }).addSyncConfig(^(NSString * logStr){
            NSString * newLogStr = [NSString stringWithFormat:@"%@\n\n%@",strongSelf.textView.text,logStr];
            TextViewCellModel * model = [strongSelf.cellModels firstObject];
            model.data = @[newLogStr?:@""];
            strongSelf.textView.text = newLogStr;
        }).mandatorySyncConfig(YES);
        [IDOSyncManager startSync];
    };
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    FuncCellModel * model = [[FuncCellModel alloc]init];
    model.typeStr = @"oneButton";
    model.data = @[lang(@"all data sync")];
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
