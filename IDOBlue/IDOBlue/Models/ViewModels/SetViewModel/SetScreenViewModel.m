//
//  SetScreenViewModel.m
//  IDOBlue
//
//  Created by hedongyang on 2018/9/29.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "SetScreenViewModel.h"
#import "FuncCellModel.h"
#import "OneButtonTableViewCell.h"
#import "EmpltyCellModel.h"
#import "SwitchCellModel.h"
#import "OneSwitchTableViewCell.h"
#import "EmptyTableViewCell.h"
#import "TextFieldCellModel.h"
#import "OneTextFieldTableViewCell.h"
#import "TwoTextFieldTableViewCell.h"
#import "FuncViewController.h"

@interface SetScreenViewModel()
@property (nonatomic,strong)IDOSetScreenBrightnessInfoBluetoothModel * screenModel;
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^textFeildCallback)(UIViewController * viewController,UITextField * textField,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^switchCallback)(UIViewController * viewController,UISwitch * onSwitch,UITableViewCell * tableViewCell);
@end

@implementation SetScreenViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getTextFieldCallback];
        [self getButtonCallback];
        [self getSwitchCallback];
        [self getCellModels];
    }
    return self;
}

- (IDOSetScreenBrightnessInfoBluetoothModel *)screenModel
{
    if (!_screenModel) {
        _screenModel = [IDOSetScreenBrightnessInfoBluetoothModel currentModel];
        
        // deviceId ： 391是 K6默认亮度等级 5
        if (__IDO_FUNCTABLE__.funcTable23Model.screenBrightness5Level
            && [IDO_BLUE_ENGINE.peripheralEngine.deviceId integerValue] == 391) {
            _screenModel.levelValue = 100;
        }else if(__IDO_FUNCTABLE__.funcTable23Model.screenBrightness5Level
                 && [IDO_BLUE_ENGINE.peripheralEngine.deviceId integerValue] == 7653) { //  [207 7653] 亮度等级默认2级，10s
            _screenModel.levelValue = 40;
            _screenModel.showInterval = 10;
        } else {
            _screenModel.levelValue = 60;
        }
        
        _screenModel.autoAdjustNight = 1;
        _screenModel.startHour = 19;
        _screenModel.startMinute = 0;
        _screenModel.endHour = 6;
        _screenModel.endMinute = 0;
    }
    return _screenModel;
}

- (void)getTextFieldCallback
{
    __weak typeof(self) weakSelf = self;
    self.textFeildCallback = ^(UIViewController *viewController, UITextField *textField, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        if (indexPath.row == 0) {
            TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
            funcVC.pickerView.pickerArray  = strongSelf.pickerDataModel.hundredArray;
            funcVC.pickerView.currentIndex = [strongSelf.pickerDataModel.hundredArray containsObject:@([textField.text intValue])] ? [strongSelf.pickerDataModel.hundredArray indexOfObject:@([textField.text intValue])] : 0 ;
            [funcVC.pickerView show];
            funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
                textField.text = selectStr;
                textFieldModel.data = @[@([selectStr integerValue])];
                [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                strongSelf.screenModel.levelValue = [selectStr integerValue];
            };
        }else if (indexPath.row == 2) {
            TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
            funcVC.pickerView.pickerArray  = strongSelf.pickerDataModel.screenModeArray;
            funcVC.pickerView.currentIndex = [strongSelf.pickerDataModel.screenModeArray containsObject:textField.text] ? [strongSelf.pickerDataModel.screenModeArray indexOfObject:textField.text] : 0 ;
            [funcVC.pickerView show];
            funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
                textField.text = selectStr;
                textFieldModel.data = @[selectStr];
                [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                strongSelf.screenModel.mode = [strongSelf.pickerDataModel.screenModeArray indexOfObject:selectStr];
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
                    strongSelf.screenModel.startHour    = [selectStr integerValue];
                }else {
                    strongSelf.screenModel.startMinute  = [selectStr integerValue];
                }
                textFieldModel.data = @[@(strongSelf.screenModel.startHour),@(strongSelf.screenModel.startMinute)];
                [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            };
        }else if (indexPath.row == 4) {
            TwoTextFieldTableViewCell * twoCell = (TwoTextFieldTableViewCell *)tableViewCell;
            TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
            NSArray * pickerArray = twoCell.textField1 == textField ? strongSelf.pickerDataModel.hourArray : strongSelf.pickerDataModel.minuteArray;
            funcVC.pickerView.pickerArray = pickerArray;
            funcVC.pickerView.currentIndex = [pickerArray containsObject:@([textField.text intValue])] ? [pickerArray indexOfObject:@([textField.text intValue])] : 0 ;
            [funcVC.pickerView show];
            funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
                textField.text = selectStr;
                if (twoCell.textField1 == textField) {
                    strongSelf.screenModel.endHour    = [selectStr integerValue];
                }else {
                    strongSelf.screenModel.endMinute  = [selectStr integerValue];
                }
                textFieldModel.data = @[@(strongSelf.screenModel.endHour),@(strongSelf.screenModel.endMinute)];
                [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            };
        }else if (indexPath.row == 5) {
            TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
            funcVC.pickerView.pickerArray  = strongSelf.pickerDataModel.hundredArray;
            funcVC.pickerView.currentIndex = [strongSelf.pickerDataModel.hundredArray containsObject:@([textField.text intValue])] ? [strongSelf.pickerDataModel.hundredArray indexOfObject:@([textField.text intValue])] : 0 ;
            [funcVC.pickerView show];
            funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
                textField.text = selectStr;
                textFieldModel.data = @[@([selectStr integerValue])];
                [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                strongSelf.screenModel.nightLevel = [selectStr integerValue];
            };
        }else if (indexPath.row == 6) {
            TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
            funcVC.pickerView.pickerArray  = strongSelf.pickerDataModel.tenArray;
            funcVC.pickerView.currentIndex = [strongSelf.pickerDataModel.tenArray containsObject:@([textField.text intValue])] ? [strongSelf.pickerDataModel.tenArray indexOfObject:@([textField.text intValue])] : 0 ;
            [funcVC.pickerView show];
            funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
                textField.text = selectStr;
                textFieldModel.data = @[@([selectStr integerValue])];
                [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                strongSelf.screenModel.showInterval = [selectStr integerValue];
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
        [funcVC showLoadingWithMessage:[NSString stringWithFormat:@"%@...",lang(@"set screen brightness")] ];
        [IDOFoundationCommand setScreenBrightnessCommand:strongSelf.screenModel
                                                callback:^(int errorCode) {
            if(errorCode == 0) {
                [funcVC showToastWithText:lang(@"set screen brightness success")];
            }else if (errorCode == 6) {
                [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
            }else {
                [funcVC showToastWithText:lang(@"set screen brightness failed")];
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
        strongSelf.screenModel.isManual = onSwitch.isOn;
        switchCellModel.data = @[@(strongSelf.screenModel.isManual)];
    };
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    
    TextFieldCellModel * model1 = [[TextFieldCellModel alloc]init];
    model1.typeStr = @"oneTextField";
    model1.titleStr = lang(@"screen brightness level:");
    model1.data = @[@(self.screenModel.levelValue)];
    model1.cellHeight = 70.0f;
    model1.cellClass = [OneTextFieldTableViewCell class];
    model1.modelClass = [NSNull class];
    model1.isShowLine = YES;
    model1.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model1];
    
    SwitchCellModel * model2 = [[SwitchCellModel alloc]init];
    model2.typeStr = @"oneSwitch";
    model2.titleStr = lang(@"set is manual switch:");
    model2.data = @[@(self.screenModel.isManual)];
    model2.cellHeight = 70.0f;
    model2.cellClass = [OneSwitchTableViewCell class];
    model2.modelClass = [NSNull class];
    model2.isShowLine = YES;
    model2.switchCallback = self.switchCallback;
    [cellModels addObject:model2];
    
    TextFieldCellModel * model3 = [[TextFieldCellModel alloc]init];
    model3.typeStr = @"oneTextField";
    model3.titleStr = lang(@"set screen mode:");
    model3.data = @[self.pickerDataModel.screenModeArray[self.screenModel.mode]];
    model3.cellHeight = 70.0f;
    model3.cellClass = [OneTextFieldTableViewCell class];
    model3.modelClass = [NSNull class];
    model3.isShowLine = YES;
    model3.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model3];
    
    TextFieldCellModel * model4 = [[TextFieldCellModel alloc]init];
    model4.typeStr = @"twoTextField";
    model4.titleStr = lang(@"set start time");
    model4.data = @[@(self.screenModel.startHour),@(self.screenModel.startMinute)];
    model4.cellHeight = 70.0f;
    model4.cellClass = [TwoTextFieldTableViewCell class];
    model4.modelClass = [NSNull class];
    model4.isShowLine = YES;
    model4.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model4];
    
    TextFieldCellModel * model5 = [[TextFieldCellModel alloc]init];
    model5.typeStr = @"twoTextField";
    model5.titleStr = lang(@"set end time");
    model5.data = @[@(self.screenModel.endHour),@(self.screenModel.endMinute)];
    model5.cellHeight = 70.0f;
    model5.cellClass = [TwoTextFieldTableViewCell class];
    model5.modelClass = [NSNull class];
    model5.isShowLine = YES;
    model5.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model5];
    
    TextFieldCellModel * model8 = [[TextFieldCellModel alloc]init];
    model8.typeStr = @"oneTextField";
    model8.titleStr = lang(@"night brightness level:");
    model8.data = @[@(self.screenModel.nightLevel)];
    model8.cellHeight = 70.0f;
    model8.cellClass = [OneTextFieldTableViewCell class];
    model8.modelClass = [NSNull class];
    model8.isShowLine = YES;
    model8.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model8];
    
    TextFieldCellModel * model9 = [[TextFieldCellModel alloc]init];
    model9.typeStr = @"oneTextField";
    model9.titleStr = lang(@"show interval:");
    model9.data = @[@(self.screenModel.showInterval)];
    model9.cellHeight = 70.0f;
    model9.cellClass = [OneTextFieldTableViewCell class];
    model9.modelClass = [NSNull class];
    model9.isShowLine = YES;
    model9.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model9];
    
    EmpltyCellModel * model6 = [[EmpltyCellModel alloc]init];
    model6.typeStr = @"empty";
    model6.cellHeight = 30.0f;
    model6.isShowLine = YES;
    model6.cellClass  = [EmptyTableViewCell class];
    [cellModels addObject:model6];
        
    FuncCellModel * model7 = [[FuncCellModel alloc]init];
    model7.typeStr = @"oneButton";
    model7.data = @[lang(@"set screen brightness")];
    model7.cellHeight = 70.0f;
    model7.cellClass = [OneButtonTableViewCell class];
    model7.modelClass = [NSNull class];
    model7.isShowLine = YES;
    model7.buttconCallback = self.buttconCallback;
    [cellModels addObject:model7];
        
    self.cellModels = cellModels;
}

@end
