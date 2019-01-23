//
//  AllAlarmViewModel.m
//  IDOBluetoothDemo
//
//  Created by hedongyang on 2018/9/26.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "AllAlarmViewModel.h"
#import "FuncViewController.h"
#import "EmpltyCellModel.h"
#import "FuncCellModel.h"
#import "LabelCellModel.h"
#import "EmptyTableViewCell.h"
#import "OneButtonTableViewCell.h"
#import "OneLabelTableViewCell.h"
#import "SetAlarmViewModel.h"

@interface AllAlarmViewModel()
@property (nonatomic,strong) NSArray<IDOSetAlarmInfoBluetoothModel *> * alarmModels;
@property (nonatomic,copy)void(^labelSelectCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation AllAlarmViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getButtonCallback];
        [self getLabelCallback];
        [self getDelectCellCallback];
        [self getCellModels];
    }
    return self;
}

- (NSArray <IDOSetAlarmInfoBluetoothModel *>*)alarmModels
{
    if (!_alarmModels) {
        _alarmModels = [IDOSetAlarmInfoBluetoothModel queryAllAlarms];
    }
    return _alarmModels;
}

- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVc = (FuncViewController *)viewController;
        FuncViewController * newFuncVc = [FuncViewController new];
        SetAlarmViewModel * alarmModel = [SetAlarmViewModel new];
        alarmModel.alarmModel = nil;
        void(^addAlarmComplete)(BOOL isSuccess) = ^(BOOL isSuccess) {
            if (isSuccess) {
                strongSelf.alarmModels =  [IDOSetAlarmInfoBluetoothModel queryAllAlarms];
                [strongSelf getCellModels];
                [funcVc reloadData];
            }
        };
        alarmModel.addAlarmComplete = addAlarmComplete;
        newFuncVc.model = alarmModel;
        newFuncVc.title = @"添加闹钟";
        [viewController.navigationController pushViewController:newFuncVc animated:YES];
    };
}

- (void)getLabelCallback
{
    __weak typeof(self) weakSelf = self;
    self.labelSelectCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        IDOSetAlarmInfoBluetoothModel * alarmModel  = [strongSelf.alarmModels objectAtIndex:indexPath.row];
        FuncViewController * newFuncVc = [FuncViewController new];
        SetAlarmViewModel * newAlarmModel = [SetAlarmViewModel new];
        newAlarmModel.alarmModel = alarmModel;
        void(^addAlarmComplete)(BOOL isSuccess) = ^(BOOL isSuccess) {
            if (isSuccess) {
                strongSelf.alarmModels =  [IDOSetAlarmInfoBluetoothModel queryAllAlarms];
                [strongSelf getCellModels];
                [funcVC reloadData];
            }
        };
        newAlarmModel.addAlarmComplete = addAlarmComplete;
        newFuncVc.model = newAlarmModel;
        newFuncVc.title = [NSString stringWithFormat:@"编辑闹钟(%ld)",alarmModel.alarmId];
        [viewController.navigationController pushViewController:newFuncVc animated:YES];
    };
}

- (void)getDelectCellCallback
{
    __weak typeof(self) weakSelf = self;
    self.delectCellCallback = ^(UIViewController *viewController, NSIndexPath *indexPath) {
          __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        IDOSetAlarmInfoBluetoothModel * alarm = [strongSelf.alarmModels objectAtIndex:indexPath.row];
        alarm.isOpen = NO;
        [IDOFoundationCommand setAlarmCommand:alarm callback:^(int errorCode) {
            if (errorCode == 0) {
                strongSelf.alarmModels =  [IDOSetAlarmInfoBluetoothModel queryAllAlarms];
                [strongSelf getCellModels];
                [funcVC reloadData];
            }
        }];
    };
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    for (IDOSetAlarmInfoBluetoothModel * alarmModel in self.alarmModels) {
        if(alarmModel.isOpen && alarmModel.isSync) {
            LabelCellModel * model = [[LabelCellModel alloc]init];
            model.typeStr = @"oneLabel";
            NSString * alarmStr = [NSString stringWithFormat:@"闹钟 : %ld \n时间 : %02ld:%02ld \n重复 : %@",alarmModel.alarmId,alarmModel.hour,alarmModel.minute,
                                   [self weeksStrWithRepeats:alarmModel.repeat]];
            model.data = @[alarmStr];
            model.cellHeight = 80.0f;
            model.cellClass  = [OneLabelTableViewCell class];
            model.modelClass = [NSNull class];
            model.labelSelectCallback = self.labelSelectCallback;
            model.isShowLine = YES;
            model.isDelete = YES;
            [cellModels addObject:model];
        }
    }
    if (cellModels.count < __IDO_FUNCTABLE__.alarmCount) {
        if (cellModels.count > 0) {
            EmpltyCellModel * model = [[EmpltyCellModel alloc]init];
            model.typeStr = @"empty";
            model.cellHeight = 30.0f;
            model.isShowLine = YES;
            model.cellClass  = [EmptyTableViewCell class];
            [cellModels addObject:model];
        }
        FuncCellModel * model1 = [[FuncCellModel alloc]init];
        model1.typeStr = @"oneButton";
        model1.data    = @[@"添加闹钟"];
        model1.cellHeight = 70.0f;
        model1.cellClass = [OneButtonTableViewCell class];
        model1.modelClass = [NSNull class];
        model1.isShowLine = YES;
        model1.buttconCallback = self.buttconCallback;
        [cellModels addObject:model1];
    }
    self.cellModels = cellModels;
}

- (NSString *)weeksStrWithRepeats:(NSArray *)repeat
{
    NSString * str = [NSString string];
    for (int i = 0;i<repeat.count; i++) {
        BOOL isRepeat = [[repeat objectAtIndex:i] boolValue];
        if (isRepeat) {
            NSString * weekDayStr = self.pickerDataModel.weekArray[i];
            str = [str stringByAppendingString:[NSString stringWithFormat:@"%@%@",weekDayStr,(i == repeat.count - 1)?@"":@"|"]];
        }
    }
    return str;
}

@end
