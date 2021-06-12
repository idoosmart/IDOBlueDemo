//
//  SetHrSwitchViewModel.m
//  IDOBlue
//
//  Created by hedongyang on 2020/4/23.
//  Copyright © 2020 hedongyang. All rights reserved.
//

#import "SetHrSwitchViewModel.h"
#import "SwitchCellModel.h"
#import "OneSwitchTableViewCell.h"
#import "TextFieldCellModel.h"
#import "OneTextFieldTableViewCell.h"
#import "TwoTextFieldTableViewCell.h"
#import "EmpltyCellModel.h"
#import "EmptyTableViewCell.h"
#import "FuncCellModel.h"
#import "OneButtonTableViewCell.h"
#import "FuncViewController.h"


@interface SetHrSwitchViewModel()
@property (nonatomic,strong)IDOSetV3HeartRateModeBluetoothModel * v3HrModel;
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^switchCallback)(UIViewController * viewController,UISwitch * onSwitch,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^textFeildCallback)(UIViewController * viewController,UITextField * textField,UITableViewCell * tableViewCell);
@end
@implementation SetHrSwitchViewModel
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

- (IDOSetV3HeartRateModeBluetoothModel *)v3HrModel
{
    if (!_v3HrModel) {
        _v3HrModel = [IDOSetV3HeartRateModeBluetoothModel currentModel];
    }
    return _v3HrModel;
}

- (void)getTextFieldCallback
{
    __weak typeof(self) weakSelf = self;
    self.textFeildCallback = ^(UIViewController *viewController, UITextField *textField, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        if(indexPath.row == 0) { 
            TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
            funcVC.pickerView.pickerArray = strongSelf.pickerDataModel.v3HrModeArray;
            funcVC.pickerView.currentIndex = [strongSelf.pickerDataModel.v3HrModeArray containsObject:textField.text] ?
            [strongSelf.pickerDataModel.v3HrModeArray indexOfObject:textField.text] : 0 ;
            [funcVC.pickerView show];
            funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
                textField.text = selectStr;
                textFieldModel.data = @[selectStr];
                [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                strongSelf.v3HrModel.modeType  = [strongSelf.pickerDataModel.v3HrModeArray containsObject:selectStr] ?
                [strongSelf.pickerDataModel.v3HrModeArray indexOfObject:selectStr] : 0 ;
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
                strongSelf.v3HrModel.measurementInterval  = [selectStr integerValue];
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
                    strongSelf.v3HrModel.startHour    = [selectStr integerValue];
                }else {
                    strongSelf.v3HrModel.startMinute  = [selectStr integerValue];
                }
                textFieldModel.data = @[@(strongSelf.v3HrModel.startHour),@(strongSelf.v3HrModel.startMinute)];
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
                    strongSelf.v3HrModel.endHour    = [selectStr integerValue];
                }else {
                    strongSelf.v3HrModel.endMinute  = [selectStr integerValue];
                }
                textFieldModel.data = @[@(strongSelf.v3HrModel.endHour),@(strongSelf.v3HrModel.endMinute)];
                [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            };
        }
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
        strongSelf.v3HrModel.isHasTimeRange = onSwitch.isOn;
        switchCellModel.data = @[@(strongSelf.v3HrModel.isHasTimeRange)];
    };
}

- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        [funcVC showLoadingWithMessage:[NSString stringWithFormat:@"%@...",lang(@"set v3 heart rate mode")]];
        IDOSetTimeInfoBluetoothModel * timeModel = [[IDOSetTimeInfoBluetoothModel alloc] init];
        strongSelf.v3HrModel.updateTime = timeModel.timeStamp;
        strongSelf.v3HrModel.modeType = 5;
        [IDOFoundationCommand setV3HrModelCommand:strongSelf.v3HrModel callback:^(int errorCode) {
            if(errorCode == 0) {
                 [funcVC showToastWithText:lang(@"set v3 heart rate mode success")];
             }else if (errorCode == 6) {
                 [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
             }else {
                 [funcVC showToastWithText:lang(@"set v3 heart rate mode failed")];
             }
        }];
    };
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    
    TextFieldCellModel * model1 = [[TextFieldCellModel alloc]init];
    model1.typeStr = @"oneTextField";
    model1.titleStr = [NSString stringWithFormat:@"%@:",lang(@"set v3 heart rate mode")];
    model1.data = @[self.pickerDataModel.hrModeArray[self.v3HrModel.modeType]];
    model1.cellHeight = 70.0f;
    model1.cellClass = [OneTextFieldTableViewCell class];
    model1.modelClass = [NSNull class];
    model1.isShowLine = YES;
    model1.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model1];
    
    SwitchCellModel * model2 = [[SwitchCellModel alloc]init];
    model2.typeStr = @"oneSwitch";
    model2.titleStr = lang(@"heart rate time range");
    model2.data = @[@(self.v3HrModel.isHasTimeRange)];
    model2.cellHeight = 70.0f;
    model2.cellClass = [OneSwitchTableViewCell class];
    model2.modelClass = [NSNull class];
    model2.isShowLine = YES;
    model2.switchCallback = self.switchCallback;
    [cellModels addObject:model2];
    
    TextFieldCellModel * model7 = [[TextFieldCellModel alloc]init];
    model7.typeStr = @"oneTextField";
    model7.titleStr = lang(@"set interval second length");
    model7.data = @[@(self.v3HrModel.measurementInterval)];
    model7.cellHeight = 70.0f;
    model7.cellClass = [OneTextFieldTableViewCell class];
    model7.modelClass = [NSNull class];
    model7.isShowLine = YES;
    model7.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model7];
    
    TextFieldCellModel * model3 = [[TextFieldCellModel alloc]init];
    model3.typeStr = @"twoTextField";
    model3.titleStr = lang(@"set start time");
    model3.data = @[@(self.v3HrModel.startHour),@(self.v3HrModel.startMinute)];
    model3.cellHeight = 70.0f;
    model3.cellClass = [TwoTextFieldTableViewCell class];
    model3.modelClass = [NSNull class];
    model3.isShowLine = YES;
    model3.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model3];
    
    TextFieldCellModel * model4 = [[TextFieldCellModel alloc]init];
    model4.typeStr = @"twoTextField";
    model4.titleStr = lang(@"set end time");
    model4.data = @[@(self.v3HrModel.endHour),@(self.v3HrModel.endMinute)];
    model4.cellHeight = 70.0f;
    model4.cellClass = [TwoTextFieldTableViewCell class];
    model4.modelClass = [NSNull class];
    model4.isShowLine = YES;
    model4.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model4];
    
    EmpltyCellModel * model5 = [[EmpltyCellModel alloc]init];
    model5.typeStr = @"empty";
    model5.cellHeight = 30.0f;
    model5.isShowLine = YES;
    model5.cellClass  = [EmptyTableViewCell class];
    [cellModels addObject:model5];
    
    FuncCellModel * model6 = [[FuncCellModel alloc]init];
    model6.typeStr = @"oneButton";
    model6.data = @[lang(@"set v3 heart rate mode")];
    model6.cellHeight = 70.0f;
    model6.cellClass = [OneButtonTableViewCell class];
    model6.modelClass = [NSNull class];
    model6.isShowLine = YES;
    model6.buttconCallback = self.buttconCallback;
    [cellModels addObject:model6];
    
    self.cellModels = cellModels;
}

@end
