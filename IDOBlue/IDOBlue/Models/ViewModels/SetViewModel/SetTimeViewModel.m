//
//  SetTimeViewModel.m
//  IDOBluetoothDemo
//
//  Created by hedongyang on 2018/9/26.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "SetTimeViewModel.h"
#import "FuncViewController.h"
#import "EmpltyCellModel.h"
#import "FuncCellModel.h"
#import "LabelCellModel.h"
#import "EmptyTableViewCell.h"
#import "OneButtonTableViewCell.h"
#import "OneLabelTableViewCell.h"

@interface SetTimeViewModel()
@property (nonatomic,strong) IDOSetTimeInfoBluetoothModel * timeModel;
@property (nonatomic,copy)void(^labelSelectCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation SetTimeViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getButtonCallback];
        [self getCellModels];
        [self getViewWillDisappearCallback];
    }
    return self;
}

- (IDOSetTimeInfoBluetoothModel *)timeModel
{
    _timeModel = [IDOSetTimeInfoBluetoothModel currentModel];
    return _timeModel;
}

- (void)getViewWillDisappearCallback
{
    __weak typeof(self) weakSelf = self;
    self.viewWillDisappearCallback = ^(UIViewController *viewController) {
        __strong typeof(self) strongSelf = weakSelf;
        [NSObject cancelPreviousPerformRequestsWithTarget:strongSelf selector:@selector(startTimer) object:nil];
    };
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    LabelCellModel * model1 = [[LabelCellModel alloc]init];
    model1.typeStr = @"oneLabel";
    IDOSetTimeInfoBluetoothModel * timeModel = self.timeModel;
    NSString * currentTimeStr = [NSString stringWithFormat:@"%@ %ld-%02d-%02d %02d:%02d:%02d",lang(@"current time"),timeModel.year,(int)timeModel.month,
                                 (int)timeModel.day,(int)timeModel.hour,(int)timeModel.minute,(int)timeModel.second];
    model1.data = @[currentTimeStr];
    model1.cellHeight = 70.0f;
    model1.cellClass = [OneLabelTableViewCell class];
    model1.modelClass = [NSNull class];
    model1.isShowLine = YES;
    [cellModels addObject:model1];
    
    LabelCellModel * model2 = [[LabelCellModel alloc]init];
    model2.typeStr = @"oneLabel";
    NSString * weekDayStr = self.pickerDataModel.weekArray[(timeModel.weekDay == 1) ? 6 : timeModel.weekDay - 2];
    model2.data = @[weekDayStr];
    model2.cellHeight = 70.0f;
    model2.cellClass = [OneLabelTableViewCell class];
    model2.modelClass = [NSNull class];
    model2.isShowLine = YES;
    [cellModels addObject:model2];
    
    LabelCellModel * model3 = [[LabelCellModel alloc]init];
    model3.typeStr = @"oneLabel";
    NSString * sysTimeZone = [NSString stringWithFormat:@"%@ %@",lang(@"system time zone"),[NSTimeZone systemTimeZone].name];
    model3.data = @[sysTimeZone];
    model3.cellHeight = 70.0f;
    model3.cellClass = [OneLabelTableViewCell class];
    model3.modelClass = [NSNull class];
    model3.isShowLine = YES;
    [cellModels addObject:model3];
    
    EmpltyCellModel * model4 = [[EmpltyCellModel alloc]init];
    model4.typeStr = @"empty";
    model4.cellHeight = 30.0f;
    model4.isShowLine = YES;
    model4.cellClass  = [EmptyTableViewCell class];
    [cellModels addObject:model4];
    
    FuncCellModel * model5 = [[FuncCellModel alloc]init];
    model5.typeStr = @"oneButton";
    model5.data = @[lang(@"set current time button")];
    model5.cellHeight = 70.0f;
    model5.cellClass = [OneButtonTableViewCell class];
    model5.modelClass = [NSNull class];
    model5.isShowLine = YES;
    model5.buttconCallback = self.buttconCallback;
    [cellModels addObject:model5];
    self.cellModels = cellModels;
    [self performSelector:@selector(startTimer) withObject:nil afterDelay:0];
}

- (void)startTimer
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(startTimer) object:nil];
    IDOSetTimeInfoBluetoothModel * timeModel = self.timeModel;
    NSString * currentTimeStr = [NSString stringWithFormat:@"%@ %ld-%02d-%02d %02d:%02d:%02d",lang(@"current time"),timeModel.year,(int)timeModel.month,
                                 (int)timeModel.day,(int)timeModel.hour,(int)timeModel.minute,(int)timeModel.second];
    LabelCellModel * cellModel = [self.cellModels firstObject];
    cellModel.data = @[currentTimeStr];
    FuncViewController * funcVC = (FuncViewController *)[IDODemoUtility getCurrentVC];
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [funcVC.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    [self performSelector:@selector(startTimer) withObject:nil afterDelay:1];
}

- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        [funcVC showLoadingWithMessage:lang(@"set current time...")];
        [IDOFoundationCommand setCurrentTimeCommand:strongSelf.timeModel
                                          callback:^(int errorCode) {
              if(errorCode == 0) {
                  [funcVC showToastWithText:lang(@"set current time success")];
              }else {
                  [funcVC showToastWithText:lang(@"set current time failed")];
              }
        }];
    };
}

@end
