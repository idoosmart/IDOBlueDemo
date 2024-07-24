//
//  SetSmartHeartRateModeViewModel.m
//  IDOBlue
//
//  Created by xiongjie on 2021/8/9.
//  Copyright © 2021 hedongyang. All rights reserved.
//

#import "SetSmartHeartRateModeViewModel.h"
#import "SwitchCellModel.h"
#import "OneSwitchTableViewCell.h"
#import "FuncCellModel.h"
#import "OneButtonTableViewCell.h"
#import "FuncViewController.h"
#import "TextFieldCellModel.h"
#import "OneTextFieldTableViewCell.h"

@interface SetSmartHeartRateModeViewModel()

@property (nonatomic,strong)IDOSetSmartHeartRateModel * smartHRModel;


@property (nonatomic,copy)void(^switchCallback)(UIViewController * viewController,UISwitch * onSwitch,UITableViewCell * tableViewCell);

@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);

@property (nonatomic,copy)void(^textFeildCallback)(UIViewController * viewController,UITextField * textField,UITableViewCell * tableViewCell);

@end


@implementation SetSmartHeartRateModeViewModel


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getSwitchCallback];
        [self getButtonCallback];
        [self getTextFieldCallback];
        [self getCellModels];
    }
    return self;
}

- (IDOSetSmartHeartRateModel *)smartHRModel
{
    if (!_smartHRModel) {
        _smartHRModel = [IDOSetSmartHeartRateModel currentModel];
    }
    return _smartHRModel;
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
            strongSelf.smartHRModel.modeFlag = onSwitch.isOn;
            switchCellModel.data = @[@(strongSelf.smartHRModel.modeFlag)];
        }else if (indexPath.row == 2) {
            SwitchCellModel * switchCellModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
            strongSelf.smartHRModel.highHeartMode = onSwitch.isOn;
            switchCellModel.data = @[@(strongSelf.smartHRModel.highHeartMode)];
        }else if (indexPath.row == 4) {
            SwitchCellModel * switchCellModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
            strongSelf.smartHRModel.lowHeartMode = onSwitch.isOn;
            switchCellModel.data = @[@(strongSelf.smartHRModel.lowHeartMode)];
        }
    };
}



- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        [funcVC showLoadingWithMessage:[NSString stringWithFormat:@"%@...",lang(@"set smart heart rate")]];
        [IDOFoundationCommand setSmartHeartRateCommand:strongSelf.smartHRModel
                                              callback:^(int errorCode) {
            if(errorCode == 0) {
                [funcVC showToastWithText:lang(@"setup success")];
            }else if (errorCode == 6) {
                [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
            }else {
                [funcVC showToastWithText:lang(@"setup failed")];
            }
        }];
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
            funcVC.pickerView.pickerArray = strongSelf.pickerDataModel.notifyFlagArray;
            funcVC.pickerView.currentIndex = [strongSelf.pickerDataModel.notifyFlagArray containsObject:textField.text] ?
            [strongSelf.pickerDataModel.notifyFlagArray indexOfObject:textField.text] : 0 ;
            [funcVC.pickerView show];
            funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
                textField.text = selectStr;
                textFieldModel.data = @[selectStr];
                [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                strongSelf.smartHRModel.notifyFlag  = [strongSelf.pickerDataModel.notifyFlagArray containsObject:selectStr] ?
                [strongSelf.pickerDataModel.notifyFlagArray indexOfObject:selectStr] : 0 ;
            };
        }else if (indexPath.row == 3) {
            TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
            funcVC.pickerView.pickerArray = strongSelf.pickerDataModel.hrArray;
            funcVC.pickerView.currentIndex = [strongSelf.pickerDataModel.hrArray containsObject:textField.text] ?
            [strongSelf.pickerDataModel.hrArray indexOfObject:textField.text] : 0 ;
            [funcVC.pickerView show];
            funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
                textField.text = selectStr;
                textFieldModel.data = @[selectStr];
                [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                strongSelf.smartHRModel.highHeartValue  = [strongSelf.pickerDataModel.hrArray containsObject:selectStr] ?
                [strongSelf.pickerDataModel.hrArray indexOfObject:selectStr] : 0 ;
            };
        }else if (indexPath.row == 5) {
            TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
            funcVC.pickerView.pickerArray = strongSelf.pickerDataModel.hrArray;
            funcVC.pickerView.currentIndex = [strongSelf.pickerDataModel.hrArray containsObject:textField.text] ?
            [strongSelf.pickerDataModel.hrArray indexOfObject:textField.text] : 0 ;
            [funcVC.pickerView show];
            funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
                textField.text = selectStr;
                textFieldModel.data = @[selectStr];
                [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                strongSelf.smartHRModel.lowHeartValue  = [strongSelf.pickerDataModel.hrArray containsObject:selectStr] ?
                [strongSelf.pickerDataModel.hrArray indexOfObject:selectStr] : 0 ;
            };
        }
    };
}




- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    SwitchCellModel * model1 = [[SwitchCellModel alloc]init];
    model1.typeStr = @"oneSwitch";
    model1.titleStr = lang(@"smart heart rate model");
    model1.data = @[@(self.smartHRModel.modeFlag)];
    model1.cellHeight = 70.0f;
    model1.cellClass = [OneSwitchTableViewCell class];
    model1.modelClass = [NSNull class];
    model1.isShowLine = YES;
    model1.switchCallback = self.switchCallback;
    [cellModels addObject:model1];
    
    TextFieldCellModel * model2 = [[TextFieldCellModel alloc]init];
    model2.typeStr = @"oneTextField";
    model2.titleStr = lang(@"notify flag");
    model2.data = @[self.pickerDataModel.notifyFlagArray[self.smartHRModel.notifyFlag]];
    model2.cellHeight = 70.0f;
    model2.cellClass = [OneTextFieldTableViewCell class];
    model2.modelClass = [NSNull class];
    model2.isShowLine = YES;
    model2.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model2];
    
    SwitchCellModel * model3 = [[SwitchCellModel alloc]init];
    model3.typeStr = @"oneSwitch";
    model3.titleStr = lang(@"high heart rate reminder switch");
    model3.data = @[@(self.smartHRModel.highHeartMode)];
    model3.cellHeight = 70.0f;
    model3.cellClass = [OneSwitchTableViewCell class];
    model3.modelClass = [NSNull class];
    model3.isShowLine = YES;
    model3.switchCallback = self.switchCallback;
    [cellModels addObject:model3];
    
    TextFieldCellModel * model5 = [[TextFieldCellModel alloc]init];
    model5.typeStr = @"oneTextField";
    model5.titleStr = lang(@"high heart rate alert threshold");
    model5.data = @[@(self.smartHRModel.highHeartValue)];
    model5.cellHeight = 70.0f;
    model5.cellClass = [OneTextFieldTableViewCell class];
    model5.modelClass = [NSNull class];
    model5.isShowLine = YES;
    model5.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model5];
    
    SwitchCellModel * model4 = [[SwitchCellModel alloc]init];
    model4.typeStr = @"oneSwitch";
    model4.titleStr = lang(@"low heart rate reminder switch");
    model4.data = @[@(self.smartHRModel.lowHeartMode)];
    model4.cellHeight = 70.0f;
    model4.cellClass = [OneSwitchTableViewCell class];
    model4.modelClass = [NSNull class];
    model4.isShowLine = YES;
    model4.switchCallback = self.switchCallback;
    [cellModels addObject:model4];
    
    TextFieldCellModel * model6 = [[TextFieldCellModel alloc]init];
    model6.typeStr = @"oneTextField";
    model6.titleStr = lang(@"low heart rate alert threshold");
    model6.data = @[@(self.smartHRModel.lowHeartValue)];
    model6.cellHeight = 70.0f;
    model6.cellClass = [OneTextFieldTableViewCell class];
    model6.modelClass = [NSNull class];
    model6.isShowLine = YES;
    model6.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model6];
    
    FuncCellModel * model7 = [[FuncCellModel alloc]init];
    model7.typeStr = @"oneButton";
    model7.data = @[lang(@"setup")];
    model7.cellHeight = 70.0f;
    model7.cellClass = [OneButtonTableViewCell class];
    model7.modelClass = [NSNull class];
    model7.isShowLine = YES;
    model7.buttconCallback = self.buttconCallback;
    [cellModels addObject:model7];
    
    self.cellModels = cellModels;
}

@end
