//
//  SetPressureSwitchViewModel.m
//  IDOBlue
//
//  Created by hedongyang on 2020/4/24.
//  Copyright © 2020 hedongyang. All rights reserved.
//

#import "SetPressureSwitchViewModel.h"
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


@interface SetPressureSwitchViewModel()
@property (nonatomic,strong)IDOSetPressureSwitchBluetoothModel * pressureModel;
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^switchCallback)(UIViewController * viewController,UISwitch * onSwitch,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^textFeildCallback)(UIViewController * viewController,UITextField * textField,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^labelSelectCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);

@end

@implementation SetPressureSwitchViewModel

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

- (IDOSetPressureSwitchBluetoothModel *)pressureModel
{
    if (!_pressureModel) {
         _pressureModel = [IDOSetPressureSwitchBluetoothModel currentModel];
    }
    return _pressureModel;
}

- (void)getTextFieldCallback
{
    __weak typeof(self) weakSelf = self;
    self.textFeildCallback = ^(UIViewController *viewController, UITextField *textField, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        if (indexPath.row == 1) {
            TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
            funcVC.pickerView.pickerArray = strongSelf.pickerDataModel.hundredArray;
            funcVC.pickerView.currentIndex = [strongSelf.pickerDataModel.hundredArray containsObject:@([textField.text intValue])] ?
            [strongSelf.pickerDataModel.hundredArray indexOfObject:@([textField.text intValue])] : 0 ;
            [funcVC.pickerView show];
            funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
                textField.text = selectStr;
                textFieldModel.data = @[@([selectStr integerValue])];
                [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                strongSelf.pressureModel.interval  = [selectStr integerValue];
            };
        }else if (indexPath.row == 2) {
            TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
            funcVC.pickerView.pickerArray = strongSelf.pickerDataModel.hundredArray;
            funcVC.pickerView.currentIndex = [strongSelf.pickerDataModel.hundredArray containsObject:@([textField.text intValue])] ?
            [strongSelf.pickerDataModel.hundredArray indexOfObject:@([textField.text intValue])] : 0 ;
            [funcVC.pickerView show];
            funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
                textField.text = selectStr;
                textFieldModel.data = @[@([selectStr integerValue])];
                [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                strongSelf.pressureModel.highThreshold  = [selectStr integerValue];
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
                    strongSelf.pressureModel.startHour    = [selectStr integerValue];
                }else {
                    strongSelf.pressureModel.startMinute  = [selectStr integerValue];
                }
                textFieldModel.data = @[@(strongSelf.pressureModel.startHour),@(strongSelf.pressureModel.startMinute)];
                [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            };
        }else if (indexPath.row == 4){
            TwoTextFieldTableViewCell * twoCell = (TwoTextFieldTableViewCell *)tableViewCell;
            TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
            NSArray * pickerArray = twoCell.textField1 == textField ? strongSelf.pickerDataModel.hourArray : strongSelf.pickerDataModel.minuteArray;
            funcVC.pickerView.pickerArray = pickerArray;
            funcVC.pickerView.currentIndex = [pickerArray containsObject:@([textField.text intValue])] ? [pickerArray indexOfObject:@([textField.text intValue])] : 0 ;
            [funcVC.pickerView show];
            funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
                textField.text = selectStr;
                if (twoCell.textField1 == textField) {
                    strongSelf.pressureModel.endHour    = [selectStr integerValue];
                }else {
                    strongSelf.pressureModel.endMinute  = [selectStr integerValue];
                }
                textFieldModel.data = @[@(strongSelf.pressureModel.endHour),@(strongSelf.pressureModel.endMinute)];
                [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            };
        }
    };
}

- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        [funcVC showLoadingWithMessage:[NSString stringWithFormat:@"%@...",lang(@"set pressure switch")]];
        [IDOFoundationCommand setPressureSwitchCommand:strongSelf.pressureModel callback:^(int errorCode) {
            if(errorCode == 0) {
               [funcVC showToastWithText:lang(@"set pressure switch success")];
            }else if (errorCode == 6) {
               [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
            }else {
               [funcVC showToastWithText:lang(@"set pressure switch failed")];
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
        if (indexPath.row == 0) {
            SwitchCellModel * switchCellModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
            strongSelf.pressureModel.onOff = onSwitch.isOn;
            switchCellModel.data = @[@(strongSelf.pressureModel.onOff)];
        }else {
            SwitchCellModel * switchCellModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
            strongSelf.pressureModel.remindOnOff = onSwitch.isOn;
            switchCellModel.data = @[@(strongSelf.pressureModel.remindOnOff)];
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
        if (labelModel.isMultiSelect)labelModel.isSelected = !labelModel.isSelected;
        NSMutableArray * repeatArray = [NSMutableArray arrayWithArray:strongSelf.pressureModel.repeat];
        [repeatArray replaceObjectAtIndex:labelModel.index withObject:@(labelModel.isSelected)];
        strongSelf.pressureModel.repeat = repeatArray;
        [funcVC.tableView reloadData];
    };
}


- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    SwitchCellModel * model1 = [[SwitchCellModel alloc]init];
    model1.typeStr = @"oneSwitch";
    model1.titleStr = [NSString stringWithFormat:@"%@ :",lang(@"set pressure switch")];
    model1.data = @[@(self.pressureModel.onOff)];
    model1.cellHeight = 70.0f;
    model1.cellClass = [OneSwitchTableViewCell class];
    model1.modelClass = [NSNull class];
    model1.isShowLine = YES;
    model1.switchCallback = self.switchCallback;
    [cellModels addObject:model1];
    
    TextFieldCellModel * model8 = [[TextFieldCellModel alloc]init];
    model8.typeStr = @"oneTextField";
    model8.titleStr = lang(@"set interval length");
    model8.data = @[@(self.pressureModel.interval)];
    model8.cellHeight = 70.0f;
    model8.cellClass = [OneTextFieldTableViewCell class];
    model8.modelClass = [NSNull class];
    model8.isShowLine = YES;
    model8.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model8];
    
    TextFieldCellModel * model10 = [[TextFieldCellModel alloc]init];
    model10.typeStr = @"oneTextField";
    model10.titleStr = lang(@"high pressure threshold");
    model10.data = @[@(self.pressureModel.highThreshold)];
    model10.cellHeight = 70.0f;
    model10.cellClass = [OneTextFieldTableViewCell class];
    model10.modelClass = [NSNull class];
    model10.isShowLine = YES;
    model10.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model10];
    
    TextFieldCellModel * model4 = [[TextFieldCellModel alloc]init];
    model4.typeStr = @"twoTextField";
    model4.titleStr = lang(@"set start time") ;
    model4.data = @[@(self.pressureModel.startHour),@(self.pressureModel.startMinute)];
    model4.cellHeight = 70.0f;
    model4.cellClass = [TwoTextFieldTableViewCell class];
    model4.modelClass = [NSNull class];
    model4.isShowLine = YES;
    model4.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model4];
    
    TextFieldCellModel * model5 = [[TextFieldCellModel alloc]init];
    model5.typeStr = @"twoTextField";
    model5.titleStr = lang(@"set end time");
    model5.data = @[@(self.pressureModel.endHour),@(self.pressureModel.endMinute)];
    model5.cellHeight = 70.0f;
    model5.cellClass = [TwoTextFieldTableViewCell class];
    model5.modelClass = [NSNull class];
    model5.isShowLine = YES;
    model5.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model5];
    
    SwitchCellModel * model9 = [[SwitchCellModel alloc]init];
    model9.typeStr = @"oneSwitch";
    model9.titleStr = [NSString stringWithFormat:@"%@ :",lang(@"set pressure reminder switch")];
    model9.data = @[@(self.pressureModel.remindOnOff)];
    model9.cellHeight = 70.0f;
    model9.cellClass = [OneSwitchTableViewCell class];
    model9.modelClass = [NSNull class];
    model9.isShowLine = YES;
    model9.switchCallback = self.switchCallback;
    [cellModels addObject:model9];
    
    EmpltyCellModel * model6 = [[EmpltyCellModel alloc]init];
    model6.typeStr = @"empty";
    model6.cellHeight = 30.0f;
    model6.isShowLine = YES;
    model6.cellClass  = [EmptyTableViewCell class];
    [cellModels addObject:model6];
        
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
        model.isSelected = [self.pressureModel.repeat[i] boolValue];
        [cellModels addObject:model];
    }
    
    FuncCellModel * model7 = [[FuncCellModel alloc]init];
    model7.typeStr = @"oneButton";
    model7.data = @[lang(@"set pressure switch")];
    model7.cellHeight = 70.0f;
    model7.cellClass = [OneButtonTableViewCell class];
    model7.modelClass = [NSNull class];
    model7.isShowLine = YES;
    model7.buttconCallback = self.buttconCallback;
    [cellModels addObject:model7];
    
    self.cellModels = cellModels;
}
@end
