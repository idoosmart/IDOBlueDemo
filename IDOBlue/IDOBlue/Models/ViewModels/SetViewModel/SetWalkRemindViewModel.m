//
//  SetWalkRemindViewModel.m
//  IDOBlue
//
//  Created by hedongyang on 2020/4/23.
//  Copyright © 2020 hedongyang. All rights reserved.
//

#import "SetWalkRemindViewModel.h"
#import "SwitchCellModel.h"
#import "OneSwitchTableViewCell.h"
#import "TextFieldCellModel.h"
#import "OneTextFieldTableViewCell.h"
#import "TwoTextFieldTableViewCell.h"
#import "EmpltyCellModel.h"
#import "EmptyTableViewCell.h"
#import "FuncCellModel.h"
#import "OneButtonTableViewCell.h"
#import "LabelCellModel.h"
#import "OneLabelTableViewCell.h"
#import "FuncViewController.h"


@interface SetWalkRemindViewModel()
@property (nonatomic,strong)IDOSetWalkReminderBluetoothModel * walkReminderModel;
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^switchCallback)(UIViewController * viewController,UISwitch * onSwitch,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^textFeildCallback)(UIViewController * viewController,UITextField * textField,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^labelSelectCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation SetWalkRemindViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getTextFieldCallback];
        [self getSwitchCallback];
        [self getButtonCallback];
        [self getLabelCallback];
        [self getCellModels];
    }
    return self;
}

- (IDOSetWalkReminderBluetoothModel *)walkReminderModel
{
    if (!_walkReminderModel) {
         _walkReminderModel = [IDOSetWalkReminderBluetoothModel currentModel];
    }
    return _walkReminderModel;
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    SwitchCellModel * model1 = [[SwitchCellModel alloc]init];
    model1.typeStr = @"oneSwitch";
    model1.titleStr = lang(@"set walk reminder");
    model1.data = @[@(self.walkReminderModel.onOff)];
    model1.cellHeight = 70.0f;
    model1.cellClass = [OneSwitchTableViewCell class];
    model1.modelClass = [NSNull class];
    model1.isShowLine = YES;
    model1.switchCallback = self.switchCallback;
    [cellModels addObject:model1];
    
    TextFieldCellModel * model2 = [[TextFieldCellModel alloc]init];
    model2.typeStr = @"oneTextField";
    model2.titleStr = lang(@"set walk reminder target");
    model2.data = @[@(self.walkReminderModel.goalStep)];
    model2.cellHeight = 70.0f;
    model2.cellClass = [OneTextFieldTableViewCell class];
    model2.modelClass = [NSNull class];
    model2.isShowLine = YES;
    model2.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model2];
    
    TextFieldCellModel * model10 = [[TextFieldCellModel alloc]init];
    model10.typeStr = @"oneTextField";
    model10.titleStr = lang(@"set a target time");
    model10.data = @[@(self.walkReminderModel.goalTime)];
    model10.cellHeight = 70.0f;
    model10.cellClass = [OneTextFieldTableViewCell class];
    model10.modelClass = [NSNull class];
    model10.isShowLine = YES;
    model10.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model10];

    TextFieldCellModel * model3 = [[TextFieldCellModel alloc]init];
    model3.typeStr = @"twoTextField";
    model3.titleStr = lang(@"set start time");
    model3.data = @[@(self.walkReminderModel.startHour),@(self.walkReminderModel.startMinute)];
    model3.cellHeight = 70.0f;
    model3.cellClass = [TwoTextFieldTableViewCell class];
    model3.modelClass = [NSNull class];
    model3.isShowLine = YES;
    model3.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model3];
    
    TextFieldCellModel * model4 = [[TextFieldCellModel alloc]init];
    model4.typeStr = @"twoTextField";
    model4.titleStr = lang(@"set end time");
    model4.data = @[@(self.walkReminderModel.endHour),@(self.walkReminderModel.endMinute)];
    model4.cellHeight = 70.0f;
    model4.cellClass = [TwoTextFieldTableViewCell class];
    model4.modelClass = [NSNull class];
    model4.isShowLine = YES;
    model4.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model4];
    
    if (__IDO_FUNCTABLE__.funcTable38Model.walkReminderAddNotify) {
        TextFieldCellModel * model8 = [[TextFieldCellModel alloc]init];
        model8.typeStr = @"oneTextField";
        model8.titleStr = lang(@"notify flag:");
        model8.data = @[@(self.walkReminderModel.notifyFlag)];
        model8.cellHeight = 70.0f;
        model8.cellClass = [OneTextFieldTableViewCell class];
        model8.modelClass = [NSNull class];
        model8.isShowLine = YES;
        model8.textFeildCallback = self.textFeildCallback;
        [cellModels addObject:model8];
    }
        
    EmpltyCellModel * model5 = [[EmpltyCellModel alloc]init];
    model5.typeStr = @"empty";
    model5.cellHeight = 30.0f;
    model5.isShowLine = YES;
    model5.cellClass  = [EmptyTableViewCell class];
    [cellModels addObject:model5];
    
    for (int i = 0; i < self.pickerDataModel.weekArray.count; i++) {
        LabelCellModel * model = [[LabelCellModel alloc]init];
        model.typeStr = @"oneLabel";
        model.data = @[self.pickerDataModel.weekArray[i]];
        model.cellHeight = 40.0f;
        model.cellClass = [OneLabelTableViewCell class];
        model.modelClass = [NSNull class];
        model.labelSelectCallback = self.labelSelectCallback;
        model.isShowLine = YES;
        model.index = i;
        model.isMultiSelect = YES;
        model.isSelected = [self.walkReminderModel.repeat[i] boolValue];
        [cellModels addObject:model];
    }
    
    EmpltyCellModel * model6 = [[EmpltyCellModel alloc]init];
    model6.typeStr = @"empty";
    model6.cellHeight = 30.0f;
    model6.isShowLine = YES;
    model6.cellClass  = [EmptyTableViewCell class];
    [cellModels addObject:model6];
    
    FuncCellModel * model7 = [[FuncCellModel alloc]init];
    model7.typeStr = @"oneButton";
    model7.data = @[lang(@"set walk reminder")];
    model7.cellHeight = 70.0f;
    model7.cellClass = [OneButtonTableViewCell class];
    model7.modelClass = [NSNull class];
    model7.isShowLine = YES;
    model7.buttconCallback = self.buttconCallback;
    [cellModels addObject:model7];
    
    self.cellModels = cellModels;
}

- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        if (!__IDO_FUNCTABLE__.funcTable23Model.walkReminder) {
            [funcVC showToastWithText:@"feature is not supported on the current device"];
            return;
        }
        [funcVC showLoadingWithMessage:[NSString stringWithFormat:@"%@...",lang(@"set walk reminder")]];
        [IDOFoundationCommand setWalkReminderCommand:strongSelf.walkReminderModel callback:^(int errorCode) {
            if(errorCode == 0) {
                [funcVC showToastWithText:lang(@"set walk reminder success")];
            }else if (errorCode == 6) {
                [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
            }else {
                [funcVC showToastWithText:lang(@"set walk reminder failed")];
            }
        }];
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
        strongSelf.walkReminderModel.onOff = onSwitch.isOn;
        switchCellModel.data = @[@(strongSelf.walkReminderModel.onOff)];
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
        if (labelModel.isMultiSelect)labelModel.isSelected = !labelModel.isSelected;
        NSMutableArray * repeatArray = [NSMutableArray arrayWithArray:strongSelf.walkReminderModel.repeat];
        [repeatArray replaceObjectAtIndex:labelModel.index withObject:@(labelModel.isSelected)];
        strongSelf.walkReminderModel.repeat = repeatArray;
        [funcVC.tableView reloadData];
    };
}

- (void)getTextFieldCallback
{
    __weak typeof(self) weakSelf = self;
    self.textFeildCallback = ^(UIViewController *viewController, UITextField *textField, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        if(indexPath.row == 1) {
            TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
            funcVC.pickerView.pickerArray = strongSelf.pickerDataModel.tenThousandArray;
            funcVC.pickerView.currentIndex = [strongSelf.pickerDataModel.tenThousandArray containsObject:@([textField.text intValue])] ?
            [strongSelf.pickerDataModel.tenThousandArray indexOfObject:@([textField.text intValue])] : 0 ;
            [funcVC.pickerView show];
            funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
                textField.text = selectStr;
                textFieldModel.data = @[@([selectStr integerValue])];
                [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                strongSelf.walkReminderModel.goalStep  = [selectStr integerValue];
            };
        }else if (indexPath.row == 2) {
            TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
            funcVC.pickerView.pickerArray = strongSelf.pickerDataModel.tenArray;
            funcVC.pickerView.currentIndex = [strongSelf.pickerDataModel.tenArray containsObject:@([textField.text intValue])] ?
            [strongSelf.pickerDataModel.tenArray indexOfObject:@([textField.text intValue])] : 0 ;
            [funcVC.pickerView show];
            funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
                textField.text = selectStr;
                textFieldModel.data = @[@([selectStr integerValue])];
                [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                strongSelf.walkReminderModel.goalTime  = [selectStr integerValue];
            };
        }else if (indexPath.row == 3) {
            TwoTextFieldTableViewCell * twoCell = (TwoTextFieldTableViewCell *)tableViewCell;
            TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
            NSArray * pickerArray = twoCell.textField1 == textField ? strongSelf.pickerDataModel.hourArray : strongSelf.pickerDataModel.minuteArray;
            funcVC.pickerView.pickerArray = pickerArray;
            funcVC.pickerView.currentIndex = [pickerArray containsObject:@([textField.text intValue])] ? [pickerArray indexOfObject:@([textField.text intValue])] : 0 ;
            [funcVC.pickerView show];
            funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
                textField.text = selectStr;
                if (twoCell.textField1 == textField) {
                    strongSelf.walkReminderModel.startHour    = [selectStr integerValue];
                }else {
                    strongSelf.walkReminderModel.startMinute  = [selectStr integerValue];
                }
                textFieldModel.data = @[@(strongSelf.walkReminderModel.startHour),@(strongSelf.walkReminderModel.startMinute)];
                [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            };
        }else if (indexPath.row == 4) {
            TwoTextFieldTableViewCell * twoCell = (TwoTextFieldTableViewCell *)tableViewCell;
            TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
            NSArray * pickerArray = twoCell.textField1 == textField ? strongSelf.pickerDataModel.hourArray : strongSelf.pickerDataModel.minuteArray;
            funcVC.pickerView.pickerArray  = pickerArray;
            funcVC.pickerView.currentIndex = [pickerArray containsObject:@([textField.text intValue])] ? [pickerArray indexOfObject:@([textField.text intValue])] : 0 ;
            [funcVC.pickerView show];
            funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
                textField.text = selectStr;
                if (twoCell.textField1 == textField) {
                    strongSelf.walkReminderModel.endHour    = [selectStr integerValue];
                }else {
                    strongSelf.walkReminderModel.endMinute  = [selectStr integerValue];
                }
                textFieldModel.data = @[@(strongSelf.walkReminderModel.endHour),@(strongSelf.walkReminderModel.endMinute)];
                [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            };
        }else {
            TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
            funcVC.pickerView.pickerArray = strongSelf.pickerDataModel.tenArray;
            funcVC.pickerView.currentIndex = [strongSelf.pickerDataModel.tenArray containsObject:@([textField.text intValue])] ?
            [strongSelf.pickerDataModel.tenArray indexOfObject:@([textField.text intValue])] : 0 ;
            [funcVC.pickerView show];
            funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
                if ([selectStr integerValue] > 3) {
                    return;
                }
                textField.text = selectStr;
                textFieldModel.data = @[@([selectStr integerValue])];
                [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                strongSelf.walkReminderModel.notifyFlag  = [selectStr integerValue];
            };
        }
    };
}

@end
