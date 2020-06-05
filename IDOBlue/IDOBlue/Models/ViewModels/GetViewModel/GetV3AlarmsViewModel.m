//
//  GetV3AlarmsViewModel.m
//  IDOBlue
//
//  Created by hedongyang on 2020/5/15.
//  Copyright © 2020 hedongyang. All rights reserved.
//

#import "GetV3AlarmsViewModel.h"
#import "FuncCellModel.h"
#import "OneButtonTableViewCell.h"
#import "TextViewCellModel.h"
#import "OneTextViewTableViewCell.h"
#import "IDODemoUtility.h"
#import "FuncViewController.h"
#import "NSObject+DemoToDic.h"

@interface GetV3AlarmsViewModel()
@property (nonatomic,strong) UITextView * textView;
@property (nonatomic,copy)void(^textViewCallback)(UITextView * textView);
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation GetV3AlarmsViewModel
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

- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf getV3Alarms];
    };
}

- (void)listenUpdateState
{
    __weak typeof(self) weakSelf = self;
    [IDOFoundationCommand listenStateChangeCommand:^(int errorCode, IDOControlDataUpdateModel * _Nullable model) {
        __strong typeof(self) strongSelf = weakSelf;
        if (errorCode == 0) {
            if (model.alarmState == 1) {
                [strongSelf getV3Alarms];
            };
        }
    }];
}

- (void)getV3Alarms
{
    __weak typeof(self) weakSelf = self;
    FuncViewController * funcVC = (FuncViewController *)[IDODemoUtility getCurrentVC];
    [funcVC showLoadingWithMessage:[NSString stringWithFormat:@"%@...",lang(@"get v3 alarms info")]];
    [IDOFoundationCommand getV3AlarmsInfoCommand:^(int errorCode, IDOSetExtensionAlarmInfoBluetoothModel * _Nullable data) {
         __strong typeof(self) strongSelf = weakSelf;
        if (errorCode == 0) {
         [funcVC showToastWithText:lang(@"get v3 alarms info success")];
          strongSelf.textView.text = [strongSelf getTextWithModel:data];
        }else if (errorCode == 6) {
         [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
        }else {
         [funcVC showToastWithText:lang(@"get v3 alarms info failed")];
        }
    }];
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    FuncCellModel * model = [[FuncCellModel alloc]init];
    model.typeStr = @"oneButton";
    model.data = @[lang(@"get v3 alarms info")];
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
    IDOSetExtensionAlarmInfoBluetoothModel * alarm = [IDOSetExtensionAlarmInfoBluetoothModel currentModel];
    NSString * str = [self getTextWithModel:alarm];
    model2.data = @[str];
    [cellModels addObject:model2];

    self.cellModels = cellModels;
}

- (NSString *)getTextWithModel:(IDOSetExtensionAlarmInfoBluetoothModel *)data
{
    NSString * str1 = [@"alarmVersion:"stringByAppendingFormat:@"%ld\n",(long)data.alarmVersion];
    NSString * str2 = [@"alarmCount:"stringByAppendingFormat:@"%ld\n",(long)data.alarmCount];
    NSString * str3 = @"";
    for (IDOSetAlarmInfoBluetoothModel * model in data.items) {
        str3 = [str3 stringByAppendingFormat:@"%@\n",model.dicFromObject];
    }
    NSString * str4 = [NSString stringWithFormat:@"%@%@%@",str1,str2,str3];
    return str4;
}
@end
