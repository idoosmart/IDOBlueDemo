//
//  SetAlarmViewModel.m
//  IDOBluetoothDemo
//
//  Created by hedongyang on 2018/9/26.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "SetAlarmViewModel.h"
#import "SwitchCellModel.h"
#import "OneSwitchTableViewCell.h"
#import "TextFieldCellModel.h"
#import "TwoTextFieldTableViewCell.h"
#import "EmpltyCellModel.h"
#import "EmptyTableViewCell.h"
#import "FuncCellModel.h"
#import "OneButtonTableViewCell.h"
#import "LabelCellModel.h"
#import "OneLabelTableViewCell.h"
#import "FuncViewController.h"


@interface SetAlarmViewModel()
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^switchCallback)(UIViewController * viewController,UISwitch * onSwitch,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^textFeildCallback)(UIViewController * viewController,UITextField * textField,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^labelSelectCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end


@implementation SetAlarmViewModel

- (void)dealloc
{
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getTextFieldCallback];
        [self getSwitchCallback];
        [self getButtonCallback];
        [self getLabelCallback];
    }
    return self;
}

- (void)setAlarmModel:(IDOSetAlarmInfoBluetoothModel *)alarmModel
{
    _alarmModel = alarmModel;
    if (!_alarmModel) {
        NSArray * alarms = [IDOSetAlarmInfoBluetoothModel queryAllNoOpenAlarms];
        _alarmModel = [alarms firstObject];
    }
    if (!_alarmModel) { //如果不执行同步配置，可以先获取v3闹钟初始化
        if (__IDO_FUNCTABLE__.funcTable29Model.v3SyncAlarm) {
            FuncViewController * funcVC = (FuncViewController *)[IDODemoUtility getCurrentVC];
            [funcVC showLoadingWithMessage:[NSString stringWithFormat:@"%@...",lang(@"get v3 alarms info")]];
            __weak typeof(self) weakSelf = self;
            [IDOFoundationCommand getV3AlarmsInfoCommand:^(int errorCode, IDOSetExtensionAlarmInfoBluetoothModel * _Nullable data) {
                __strong typeof(self) strongSelf = weakSelf;
               if (errorCode == 0) {
                [funcVC showToastWithText:lang(@"get v3 alarms info success")];
                   NSArray * alarms = [IDOSetAlarmInfoBluetoothModel queryAllNoOpenAlarms];
                   _alarmModel = [alarms firstObject];
                   [strongSelf getCellModels];
               }else if (errorCode == 6) {
                [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
               }else {
                [funcVC showToastWithText:lang(@"get v3 alarms info failed")];
               }
            }];
        }
    }
    [self getCellModels];
}

- (void)getTextFieldCallback
{
    __weak typeof(self) weakSelf = self;
    self.textFeildCallback = ^(UIViewController *viewController, UITextField *textField, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        TwoTextFieldTableViewCell * twoCell = (TwoTextFieldTableViewCell *)tableViewCell;
        TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
        NSArray * pickerArray = twoCell.textField1 == textField ? strongSelf.pickerDataModel.hourArray : strongSelf.pickerDataModel.minuteArray;
        funcVC.pickerView.pickerArray = pickerArray;
        funcVC.pickerView.currentIndex = [pickerArray containsObject:@([textField.text intValue])] ? [pickerArray indexOfObject:@([textField.text intValue])] : 0 ;
        [funcVC.pickerView show];
        funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
            textField.text = selectStr;
            if (twoCell.textField1 == textField) {
                strongSelf.alarmModel.hour    = [selectStr integerValue];
            }else {
                strongSelf.alarmModel.minute  = [selectStr integerValue];
            }
            textFieldModel.data = @[@(strongSelf.alarmModel.hour),@(strongSelf.alarmModel.minute)];
            [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        };
    };
}

- (void)getSwitchCallback
{
    __weak typeof(self) weakSelf = self;
    self.switchCallback = ^(UIViewController *viewController, UISwitch *onSwitch, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        SwitchCellModel * switchCellModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
        strongSelf.alarmModel.isOpen = onSwitch.isOn;
        strongSelf.alarmModel.isDelete = !onSwitch.isOn;
        switchCellModel.data = @[@(strongSelf.alarmModel.isOpen)];
    };
}

- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        [funcVC showLoadingWithMessage:lang(@"set alarm...")];
        [strongSelf.alarmModel saveOrUpdate];
        if (__IDO_FUNCTABLE__.funcTable29Model.v3SyncAlarm) { //v3闹钟
            IDOSetExtensionAlarmInfoBluetoothModel * alarmModel = [IDOSetExtensionAlarmInfoBluetoothModel currentModel];
            [IDOFoundationCommand setV3AllAlarmsCommand:alarmModel callback:^(int errorCode) {
                if (errorCode == 0) {
                   [funcVC showToastWithText:lang(@"set alarm success")];
                   if (strongSelf.addAlarmComplete) {
                       strongSelf.addAlarmComplete(YES);
                   }
                }else if (errorCode == 6) {
                    [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
                }else {
                    [funcVC showToastWithText:lang(@"set alarm failed")];
                    if (strongSelf.addAlarmComplete) {
                      strongSelf.addAlarmComplete(NO);
                    }
                }
            }];
        }else {  //v2闹钟
            NSArray * alarms = [IDOSetAlarmInfoBluetoothModel queryAllAlarms];
            [IDOFoundationCommand setAllAlarmsCommand:alarms
                                             callback:^(int errorCode) {
               if (errorCode == 0) {
                   [funcVC showToastWithText:lang(@"set alarm success")];
                   if (strongSelf.addAlarmComplete) {
                       strongSelf.addAlarmComplete(YES);
                   }
                }else if (errorCode == 6) {
                    [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
                }else {
                     [funcVC showToastWithText:lang(@"set alarm failed")];
                     if (strongSelf.addAlarmComplete) {
                       strongSelf.addAlarmComplete(NO);
                     }
                }
            }];
        }
    };
}

- (void)getLabelCallback
{
    __weak typeof(self) weakSelf = self;
    self.labelSelectCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        LabelCellModel * labelModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
        if (!labelModel.isMultiSelect) {
            for (BaseCellModel * model in strongSelf.cellModels) {
                if ([model isKindOfClass:[LabelCellModel class]]) {
                    LabelCellModel * labelModel = (LabelCellModel *)model;
                    if (!labelModel.isMultiSelect) {
                        labelModel.isSelected = NO;
                    }
                }
            }
        }
        if (labelModel.isMultiSelect)labelModel.isSelected = !labelModel.isSelected;
        else labelModel.isSelected = YES;
        if (indexPath.row <= 9) {
            NSMutableArray * repeatArray = [NSMutableArray arrayWithArray:strongSelf.alarmModel.repeat];
            [repeatArray replaceObjectAtIndex:labelModel.index withObject:@(labelModel.isSelected)];
            strongSelf.alarmModel.repeat = repeatArray;
        }else {
            strongSelf.alarmModel.type = labelModel.index;
        }
        [funcVC.tableView reloadData];
    };
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    SwitchCellModel * model1 = [[SwitchCellModel alloc]init];
    model1.typeStr = @"oneSwitch";
    model1.titleStr = lang(@"set alarm notice switch");
    model1.data = @[@(self.alarmModel.isOpen)];
    model1.cellHeight = 70.0f;
    model1.cellClass = [OneSwitchTableViewCell class];
    model1.modelClass = [NSNull class];
    model1.isShowLine = YES;
    model1.switchCallback = self.switchCallback;
    [cellModels addObject:model1];
    
    TextFieldCellModel * model2 = [[TextFieldCellModel alloc]init];
    model2.typeStr = @"twoTextField";
    model2.titleStr = lang(@"set time:");
    model2.data = @[@(self.alarmModel.hour),@(self.alarmModel.minute)];
    model2.cellHeight = 70.0f;
    model2.cellClass = [TwoTextFieldTableViewCell class];
    model2.modelClass = [NSNull class];
    model2.isShowLine = YES;
    model2.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model2];
    
    EmpltyCellModel * model3 = [[EmpltyCellModel alloc]init];
    model3.typeStr = @"empty";
    model3.cellHeight = 30.0f;
    model3.isShowLine = YES;
    model3.cellClass  = [EmptyTableViewCell class];
    [cellModels addObject:model3];
    
    for (int i = 0; i < self.pickerDataModel.weekArray.count; i++) {
        LabelCellModel * model4 = [[LabelCellModel alloc]init];
        model4.typeStr = @"oneLabel";
        model4.data = @[self.pickerDataModel.weekArray[i]];
        model4.cellHeight = 40.0f;
        model4.cellClass = [OneLabelTableViewCell class];
        model4.modelClass = [NSNull class];
        model4.labelSelectCallback = self.labelSelectCallback;
        model4.isShowLine = YES;
        model4.isMultiSelect = YES;
        model4.index = i;
        model4.isSelected = [self.alarmModel.repeat[i] boolValue];
        [cellModels addObject:model4];
    }
    
    EmpltyCellModel * model5 = [[EmpltyCellModel alloc]init];
    model5.typeStr = @"empty";
    model5.cellHeight = 30.0f;
    model5.isShowLine = YES;
    model5.cellClass  = [EmptyTableViewCell class];
    [cellModels addObject:model5];
    
    for (int i = 0; i < self.pickerDataModel.typeArray.count; i++) {
        LabelCellModel * model6 = [[LabelCellModel alloc]init];
        model6.typeStr = @"oneLabel";
        model6.data = @[self.pickerDataModel.typeArray[i]];
        model6.cellHeight = 40.0f;
        model6.cellClass = [OneLabelTableViewCell class];
        model6.modelClass = [NSNull class];
        model6.labelSelectCallback = self.labelSelectCallback;
        model6.isShowLine = YES;
        model6.index = i;
        model6.isSelected = self.alarmModel.type == i;
        [cellModels addObject:model6];
    }
    
    EmpltyCellModel * model7 = [[EmpltyCellModel alloc]init];
    model7.typeStr = @"empty";
    model7.cellHeight = 30.0f;
    model7.isShowLine = YES;
    model7.cellClass  = [EmptyTableViewCell class];
    [cellModels addObject:model7];
    
    FuncCellModel * model8 = [[FuncCellModel alloc]init];
    model8.typeStr = @"oneButton";
    model8.data = @[lang(@"edit alarm")];
    model8.cellHeight = 70.0f;
    model8.cellClass = [OneButtonTableViewCell class];
    model8.modelClass = [NSNull class];
    model8.isShowLine = YES;
    model8.buttconCallback = self.buttconCallback;
    [cellModels addObject:model8];
    
    self.cellModels = cellModels;
}

@end
