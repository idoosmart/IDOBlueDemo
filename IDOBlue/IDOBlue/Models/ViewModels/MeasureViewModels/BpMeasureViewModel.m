//
//  BpMeasureViewModel.m
//  IDOBlue
//
//  Created by 何东阳 on 2019/5/5.
//  Copyright © 2019 hedongyang. All rights reserved.
//

#import "BpMeasureViewModel.h"
#import "FuncCellModel.h"
#import "TextViewCellModel.h"
#import "OneButtonTableViewCell.h"
#import "OneTextViewTableViewCell.h"
#import "FuncViewController.h"
#import "IDODemoUtility.h"
#import "NSObject+DemoToDic.h"

@interface BpMeasureViewModel()
@property (nonatomic,strong) UITextView * textView;
@property (nonatomic,assign) NSInteger progressNum;
@property (nonatomic, strong) NSTimer * bpTimer;//定时器
@property (nonatomic,copy)void(^textViewCallback)(UITextView * textView);
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation BpMeasureViewModel

- (void)dealloc
{
    [self timerInvalidate];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.progressNum = 0;
        [self getButtonCallback];
        [self getTextViewCallback];
        [self getCellModels];
    }
    return self;
}

- (NSTimer *)bpTimer
{
    if (!_bpTimer) {
        _bpTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                    target:self
                                                  selector:@selector(bloodPressureTesting)
                                                  userInfo:nil
                                                   repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_bpTimer forMode:NSDefaultRunLoopMode];
        
    }
    return _bpTimer;
}

- (void)timerInvalidate
{
    if (_bpTimer) {
        [_bpTimer invalidate];
        _bpTimer = nil;
    }
}

- (void)bloodPressureTesting
{
    _progressNum += 1;
    __weak typeof(self) weakSelf = self;
     FuncViewController * funcVC = (FuncViewController *)[IDODemoUtility getCurrentVC];
    if (_progressNum >= 60) { //超时测量结束
        if (IDO_BLUE_ENGINE.managerEngine.isConnected) {
            IDOSetBpMeasureInfoBluetoothModel *model = [IDOSetBpMeasureInfoBluetoothModel currentModel];
            model.flag = 0x02;
            [IDOFoundationCommand setBpMeasureCommand:model callback:^(int errorCode, IDOSetBpMeasureInfoBluetoothModel * _Nullable model) {
                __strong typeof(self) strongSelf = weakSelf;
                [strongSelf timerInvalidate];
                if(errorCode == 0) {//测量正常
                    if(model.status == 0x00) { //不支持
                        [funcVC showToastWithText:lang(@"not support blood pressure measure")];
                    }else if (model.status == 0x01) {//正在测量
                        NSString * str = [NSString stringWithFormat:lang(@"%ld seconds in blood pressure measure"),strongSelf.progressNum];
                        [funcVC showLoadingWithMessage:str];
                    }else if (model.status == 0x02) {//测量成功
                        [funcVC showToastWithText:lang(@"successful blood pressure measure")];
                        strongSelf.textView.text = [NSString stringWithFormat:@"%@",[model dicFromObject]];
                    }else if (model.status == 0x03) {//测量失败
                        [funcVC showToastWithText:lang(@"failure blood pressure measure")];
                    }else if (model.status == 0x04) {//设备正在运动模式
                        [funcVC showToastWithText:lang(@"device in sport mode")];
                    }
                }else if(errorCode == 6) {//测量异常
                    [funcVC showToastWithText:lang(@"not support blood pressure measure")];
                }else {
                    [funcVC showToastWithText:lang(@"abnormal device measure")];
                }
            }];
        }else{
            [self timerInvalidate];
        }
        
    } else if (_progressNum % 3 == 0){
        if (IDO_BLUE_ENGINE.managerEngine.isConnected) {
            IDOSetBpMeasureInfoBluetoothModel *model = [IDOSetBpMeasureInfoBluetoothModel currentModel];
            model.flag = 0x03;
            [IDOFoundationCommand setBpMeasureCommand:model callback:^(int errorCode, IDOSetBpMeasureInfoBluetoothModel * _Nullable model) {
                __strong typeof(self) strongSelf = weakSelf;
                if(errorCode == 0) {//测量正常
                    if(model.status == 0x00) { //不支持
                        [funcVC showToastWithText:lang(@"not support blood pressure measure")];
                        [strongSelf timerInvalidate];
                    }else if (model.status == 0x01) {//正在测量
                        NSString * str = [NSString stringWithFormat:lang(@"%ld seconds in blood pressure measure"),strongSelf.progressNum];
                        [funcVC showLoadingWithMessage:str];
                    }else if (model.status == 0x02) {//测量成功
                        [funcVC showToastWithText:lang(@"successful blood pressure measure")];
                        strongSelf.textView.text = [NSString stringWithFormat:@"%@",[model dicFromObject]];
                        [strongSelf timerInvalidate];
                    }else if (model.status == 0x03) {//测量失败
                        [funcVC showToastWithText:lang(@"failure blood pressure measure")];
                        [strongSelf timerInvalidate];
                    }else if (model.status == 0x04) {//设备正在运动模式
                        [funcVC showToastWithText:lang(@"device in sport mode")];
                        [strongSelf timerInvalidate];
                    }
                }else if(errorCode == 6) {//测量异常
                    [funcVC showToastWithText:lang(@"not support blood pressure measure")];
                    [strongSelf timerInvalidate];
                }else {
                    [funcVC showToastWithText:lang(@"abnormal device measure")];
                    [strongSelf timerInvalidate];
                }
            }];
        }else{
          [self timerInvalidate];
        }
    }
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
        FuncViewController * funcVC = (FuncViewController *)viewController;
        [funcVC showLoadingWithMessage:lang(@"measure blood pressure...")];
        IDOSetBpMeasureInfoBluetoothModel * model = [IDOSetBpMeasureInfoBluetoothModel currentModel];
        model.flag = 0x01;
        [IDOFoundationCommand setBpMeasureCommand:model
                                         callback:^(int errorCode, IDOSetBpMeasureInfoBluetoothModel * _Nullable model) {
            __strong typeof(self) strongSelf = weakSelf;
             if(errorCode == 0) {//测量正常
                 if(model.status == 0x00) { //不支持
                     [funcVC showToastWithText:lang(@"not support blood pressure measure")];
                 }else if (model.status == 0x01) {//正在测量
                     strongSelf.progressNum = 0;
                     [strongSelf.bpTimer setFireDate:[NSDate date]];
                 }else if (model.status == 0x02) {//测量成功
                     [funcVC showToastWithText:lang(@"successful blood pressure measure")];
                 }else if (model.status == 0x03) {//测量失败
                     [funcVC showToastWithText:lang(@"failure blood pressure measure")];
                 }else if (model.status == 0x04) {//设备正在运动模式
                     [funcVC showToastWithText:lang(@"device in sport mode")];
                 }
             }else if(errorCode == 6) {//测量异常
                 [funcVC showToastWithText:lang(@"not support blood pressure measure")];
             }else {
                 [funcVC showToastWithText:lang(@"abnormal device measure")];
             }
        }];
    };
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    FuncCellModel * model = [[FuncCellModel alloc]init];
    model.typeStr = @"oneButton";
    model.data = @[lang(@"measure blood pressure")];
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
