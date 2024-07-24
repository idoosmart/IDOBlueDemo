//
//  SetSpo2SwitchViewModel.m
//  IDOBlue
//
//  Created by hedongyang on 2020/4/23.
//  Copyright © 2020 hedongyang. All rights reserved.
//

#import "SetSpo2SwitchViewModel.h"
#import "SwitchCellModel.h"
#import "OneSwitchTableViewCell.h"
#import "TextFieldCellModel.h"
#import "TwoTextFieldTableViewCell.h"
#import "EmpltyCellModel.h"
#import "EmptyTableViewCell.h"
#import "OneTextFieldTableViewCell.h"
#import "FuncCellModel.h"
#import "OneButtonTableViewCell.h"
#import "FuncViewController.h"


@interface SetSpo2SwitchViewModel()
@property (nonatomic,strong)IDOSetSpo2SwitchBluetoothModel * spo2Model;
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^switchCallback)(UIViewController * viewController,UISwitch * onSwitch,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^textFeildCallback)(UIViewController * viewController,UITextField * textField,UITableViewCell * tableViewCell);
@end

@implementation SetSpo2SwitchViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getTextFieldCallback];
        [self getSwitchCallback];
        [self getButtonCallback];
        [self getCellModels];
    }
    return self;
}

- (IDOSetSpo2SwitchBluetoothModel *)spo2Model
{
    if (!_spo2Model) {
        _spo2Model = [IDOSetSpo2SwitchBluetoothModel currentModel];
    }
    return _spo2Model;
}

- (void)getTextFieldCallback
{
    __weak typeof(self) weakSelf = self;
    self.textFeildCallback = ^(UIViewController *viewController, UITextField *textField, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        if (indexPath.row == 1) {
            TwoTextFieldTableViewCell * twoCell = (TwoTextFieldTableViewCell *)tableViewCell;
            TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
            NSArray * pickerArray = twoCell.textField1 == textField ? strongSelf.pickerDataModel.hourArray : strongSelf.pickerDataModel.minuteArray;
            funcVC.pickerView.pickerArray = pickerArray;
            funcVC.pickerView.currentIndex = [pickerArray containsObject:@([textField.text intValue])] ? [pickerArray indexOfObject:@([textField.text intValue])] : 0 ;
            [funcVC.pickerView show];
            funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
                textField.text = selectStr;
                if (twoCell.textField1 == textField) {
                    strongSelf.spo2Model.startHour    = [selectStr integerValue];
                }else {
                    strongSelf.spo2Model.startMinute  = [selectStr integerValue];
                }
                textFieldModel.data = @[@(strongSelf.spo2Model.startHour),@(strongSelf.spo2Model.startMinute)];
                [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            };
        }else if (indexPath.row == 2){
            TwoTextFieldTableViewCell * twoCell = (TwoTextFieldTableViewCell *)tableViewCell;
            TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
            NSArray * pickerArray = twoCell.textField1 == textField ? strongSelf.pickerDataModel.hourArray : strongSelf.pickerDataModel.minuteArray;
            funcVC.pickerView.pickerArray = pickerArray;
            funcVC.pickerView.currentIndex = [pickerArray containsObject:@([textField.text intValue])] ? [pickerArray indexOfObject:@([textField.text intValue])] : 0 ;
            [funcVC.pickerView show];
            funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
                textField.text = selectStr;
                if (twoCell.textField1 == textField) {
                    strongSelf.spo2Model.endHour    = [selectStr integerValue];
                }else {
                    strongSelf.spo2Model.endMinute  = [selectStr integerValue];
                }
                textFieldModel.data = @[@(strongSelf.spo2Model.endHour),@(strongSelf.spo2Model.endMinute)];
                [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            };
        }
        else if (indexPath.row == 4)
        {
            TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
            funcVC.pickerView.pickerArray = strongSelf.pickerDataModel.hundredArray;
            funcVC.pickerView.currentIndex = [strongSelf.pickerDataModel.hundredArray containsObject:@([textField.text intValue])] ?
            [strongSelf.pickerDataModel.hundredArray indexOfObject:@([textField.text intValue])] : 0 ;
            [funcVC.pickerView show];
            funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
                textField.text = selectStr;
                textFieldModel.data = @[@([selectStr integerValue])];
                [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                strongSelf.spo2Model.lowValue  = [selectStr integerValue];
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
        if (!__IDO_FUNCTABLE__.funcTable20Model.spo2Data) {
            [funcVC showToastWithText:@"feature is not supported on the current device"];
            return;
        }
        [funcVC showLoadingWithMessage:[NSString stringWithFormat:@"%@...",lang(@"set spo2 switch")]];
        [IDOFoundationCommand setSpo2SwitchCommand:strongSelf.spo2Model callback:^(int errorCode) {
            if(errorCode == 0) {
               [funcVC showToastWithText:lang(@"set spo2 switch success")];
            }else if (errorCode == 6) {
               [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
            }else {
               [funcVC showToastWithText:lang(@"set spo2 switch failed")];
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
            strongSelf.spo2Model.onOff = onSwitch.isOn;
            switchCellModel.data = @[@(strongSelf.spo2Model.onOff)];
        }
        else if (indexPath.row == 3) {
            SwitchCellModel * switchCellModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
            strongSelf.spo2Model.lowOnOff = onSwitch.isOn;
            switchCellModel.data = @[@(strongSelf.spo2Model.lowOnOff)];
        }
    };
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    SwitchCellModel * model1 = [[SwitchCellModel alloc]init];
    model1.typeStr = @"oneSwitch";
    model1.titleStr = [NSString stringWithFormat:@"%@ :",lang(@"set spo2 switch")];
    model1.data = @[@(self.spo2Model.onOff)];
    model1.cellHeight = 70.0f;
    model1.cellClass = [OneSwitchTableViewCell class];
    model1.modelClass = [NSNull class];
    model1.isShowLine = YES;
    model1.switchCallback = self.switchCallback;
    [cellModels addObject:model1];
    
    TextFieldCellModel * model4 = [[TextFieldCellModel alloc]init];
    model4.typeStr = @"twoTextField";
    model4.titleStr = lang(@"set start time") ;
    model4.data = @[@(self.spo2Model.startHour),@(self.spo2Model.startMinute)];
    model4.cellHeight = 70.0f;
    model4.cellClass = [TwoTextFieldTableViewCell class];
    model4.modelClass = [NSNull class];
    model4.isShowLine = YES;
    model4.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model4];
    
    TextFieldCellModel * model5 = [[TextFieldCellModel alloc]init];
    model5.typeStr = @"twoTextField";
    model5.titleStr = lang(@"set end time");
    model5.data = @[@(self.spo2Model.endHour),@(self.spo2Model.endMinute)];
    model5.cellHeight = 70.0f;
    model5.cellClass = [TwoTextFieldTableViewCell class];
    model5.modelClass = [NSNull class];
    model5.isShowLine = YES;
    model5.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model5];
    
    SwitchCellModel * model10 = [[SwitchCellModel alloc]init];
    model10.typeStr = @"oneSwitch";
    model10.titleStr = [NSString stringWithFormat:@"%@ :",lang(@"low blood oxygen switch")];
    model10.data = @[@(self.spo2Model.lowOnOff)];
    model10.cellHeight = 70.0f;
    model10.cellClass = [OneSwitchTableViewCell class];
    model10.modelClass = [NSNull class];
    model10.isShowLine = YES;
    model10.switchCallback = self.switchCallback;
    [cellModels addObject:model10];
    
    TextFieldCellModel * model11 = [[TextFieldCellModel alloc]init];
    model11.typeStr = @"oneTextField";
    model11.titleStr = lang(@"low blood oxygen threshold");
    model11.data = @[@(self.spo2Model.lowValue)];
    model11.cellHeight = 70.0f;
    model11.cellClass = [OneTextFieldTableViewCell class];
    model11.modelClass = [NSNull class];
    model11.isShowLine = YES;
    model11.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model11];
    
    EmpltyCellModel * model6 = [[EmpltyCellModel alloc]init];
    model6.typeStr = @"empty";
    model6.cellHeight = 30.0f;
    model6.isShowLine = YES;
    model6.cellClass  = [EmptyTableViewCell class];
    [cellModels addObject:model6];
    
    FuncCellModel * model7 = [[FuncCellModel alloc]init];
    model7.typeStr = @"oneButton";
    model7.data = @[lang(@"set spo2 switch")];
    model7.cellHeight = 70.0f;
    model7.cellClass = [OneButtonTableViewCell class];
    model7.modelClass = [NSNull class];
    model7.isShowLine = YES;
    model7.buttconCallback = self.buttconCallback;
    [cellModels addObject:model7];
    
    self.cellModels = cellModels;
}


@end

