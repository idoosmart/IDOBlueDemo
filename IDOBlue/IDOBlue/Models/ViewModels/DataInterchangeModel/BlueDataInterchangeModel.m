//
//  BlueAppDataInterchangeModel.m
//  IDOBlue
//
//  Created by hedongyang on 2018/10/10.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "BlueDataInterchangeModel.h"
#import "TextViewCellModel.h"
#import "OneTextViewTableViewCell.h"
#import "IDODemoUtility.h"
#import "NSObject+DemoToDic.h"

@interface BlueDataInterchangeModel()
@property (nonatomic,strong) UITextView * textView;
@property (nonatomic,strong) IDODataExchangeModel * dataModel;
@property (nonatomic,copy)void(^textViewCallback)(UITextView * textView);
@end

@implementation BlueDataInterchangeModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self listenBlueControl];
        [self getTextViewCallback];
        [self getCellModels];
    }
    return self;
}

- (IDODataExchangeModel *)dataModel
{
    if (!_dataModel) {
        _dataModel = [IDODataExchangeModel new];
    }
    return _dataModel;
}

- (void)getCellModels
{
    TextViewCellModel * model1 = [[TextViewCellModel alloc]init];
    model1.typeStr = @"oneTextView";
    model1.textViewCallback = self.textViewCallback;
    model1.cellHeight = [IDODemoUtility getCurrentVC].view.frame.size.height - 40;
    model1.cellClass  = [OneTextViewTableViewCell class];
    self.cellModels = @[model1];
}

- (void)listenBlueControl
{
    __weak typeof(self) weakSelf = self;
    self.dataModel.retCode = 0;
    [IDOFoundationCommand bleStartSportCommand:self.dataModel
                              bleStartCallback:^(IDODataExchangeModel * _Nullable model, int errorCode) {
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf appSportStart];
        [strongSelf addMessageText:[NSString stringWithFormat:@"%@:\n%@\n\n",lang(@"bracelet start activity"),model.dicFromObject]];
    }];
    
    [IDOFoundationCommand blePauseSportCommand:self.dataModel
                              blePauseCallback:^(IDODataExchangeModel * _Nullable model, int errorCode) {
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf addMessageText:[NSString stringWithFormat:@"%@:\n%@\n\n",lang(@"bracelet suspended activity"),model.dicFromObject]];
    }];
    
    [IDOFoundationCommand bleRestoreSportCommand:self.dataModel
                              bleRestoreCallback:^(IDODataExchangeModel * _Nullable model, int errorCode) {
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf addMessageText:[NSString stringWithFormat:@"%@:\n%@\n\n",lang(@"bracelet restore activity"),model.dicFromObject]];
    }];
    
    [IDOFoundationCommand bleEndSportCommand:self.dataModel
                              bleEndCallback:^(IDODataExchangeModel * _Nullable model, int errorCode) {
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf addMessageText:[NSString stringWithFormat:@"%@:\n%@\n\n",lang(@"bracelet stop activity"),model.dicFromObject]];
        [NSObject cancelPreviousPerformRequestsWithTarget:strongSelf selector:@selector(appSportStart) object:nil];
    }];
    
    [IDOFoundationCommand bleIngSportCommand:self.dataModel
                              bleIngCallback:^(IDODataExchangeModel * _Nullable model, int errorCode) {
          __strong typeof(self) strongSelf = weakSelf;
        [strongSelf addMessageText:[NSString stringWithFormat:@"%@:\n%@\n\n",lang(@"bracelet send data"),model.dicFromObject]];
    }];
}

- (void)appSportStart
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(appSportStart) object:nil];
    self.dataModel.distance += 1;
    [self performSelector:@selector(appSportStart) withObject:nil afterDelay:1.0];
}

- (void)getTextViewCallback
{
    __weak typeof(self) weakSelf = self;
    self.textViewCallback = ^(UITextView *textView) {
        __strong typeof(self) strongSelf = weakSelf;
        strongSelf.textView = textView;
    };
}

- (void)addMessageText:(NSString *)message
{
    message = [NSString stringWithFormat:@"%@\n\n%@",self.textView.text,message];
    TextViewCellModel * model = [self.cellModels firstObject];
    model.data = @[message?:@""];
    self.textView.text = message;
    [self.textView scrollRangeToVisible:NSMakeRange(self.textView.text.length, 1)];
}

@end
