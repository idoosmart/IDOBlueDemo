//
//  SetWomenHealthViewModel.m
//  IDOBlue
//
//  Created by 何东阳 on 2019/4/4.
//  Copyright © 2019年 hedongyang. All rights reserved.
//

#import "SetMenstruationViewModel.h"
#import "TextFieldCellModel.h"
#import "SwitchCellModel.h"
#import "OneSwitchTableViewCell.h"
#import "OneTextFieldTableViewCell.h"
#import "ThreeTextFieldTableViewCell.h"
#import "EmpltyCellModel.h"
#import "EmptyTableViewCell.h"
#import "FuncCellModel.h"
#import "OneButtonTableViewCell.h"
#import "FuncViewController.h"

@interface SetMenstruationViewModel()
@property (nonatomic,strong)IDOSetMenstruationInfoBluetoothModel * menstruationModel;
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^switchCallback)(UIViewController * viewController,UISwitch * onSwitch,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^textFeildCallback)(UIViewController * viewController,UITextField * textField,UITableViewCell * tableViewCell);
@end

@implementation SetMenstruationViewModel

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

- (IDOSetMenstruationInfoBluetoothModel *)menstruationModel
{
    if (!_menstruationModel) {
        _menstruationModel = [IDOSetMenstruationInfoBluetoothModel currentModel];
    }
    return _menstruationModel;
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
            strongSelf.menstruationModel.onOff = onSwitch.isOn;
            switchCellModel.data = @[@(strongSelf.menstruationModel.onOff)];
        }
    };
}

- (void)getTextFieldCallback
{
    __weak typeof(self) weakSelf = self;
    self.textFeildCallback = ^(UIViewController *viewController, UITextField *textField, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
        if (indexPath.row == 1) {
            strongSelf.menstruationModel.menstrualLength = [textField.text integerValue];
            textFieldModel.data = @[@(strongSelf.menstruationModel.menstrualLength)];
        }else if (indexPath.row == 2) {
            strongSelf.menstruationModel.menstrualCycle = [textField.text integerValue];
            textFieldModel.data = @[@(strongSelf.menstruationModel.menstrualCycle)];
        }else if (indexPath.row == 3) {
            ThreeTextFieldTableViewCell * threeCell = (ThreeTextFieldTableViewCell *)tableViewCell;
            funcVC.datePickerView.currentDateStr = [NSString stringWithFormat:@"%@-%@-%@",threeCell.textField1.text,threeCell.textField2.text,threeCell.textField3.text];
            [funcVC.datePickerView show];
            funcVC.datePickerView.datePickerViewCallback = ^(NSArray *dateArray) {
                TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
                if (dateArray.count!=3) return;
                threeCell.textField1.text = dateArray[0];
                threeCell.textField2.text = dateArray[1];
                threeCell.textField3.text = dateArray[2];
                textFieldModel.data = @[@([threeCell.textField1.text integerValue]),@([threeCell.textField2.text integerValue]),@([threeCell.textField3.text integerValue])];
                [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                strongSelf.menstruationModel.lastMenstrualYear  = [dateArray[0] integerValue];
                strongSelf.menstruationModel.lastMenstrualMonth = [dateArray[1] integerValue];
                strongSelf.menstruationModel.lastMenstrualDay   = [dateArray[2] integerValue];
            };
        }else if (indexPath.row == 4) {
            strongSelf.menstruationModel.ovulationIntervalDay = [textField.text integerValue];
            textFieldModel.data = @[@(strongSelf.menstruationModel.ovulationIntervalDay)];
        }else if (indexPath.row == 5) {
            strongSelf.menstruationModel.ovulationBeforeDay = [textField.text integerValue];
            textFieldModel.data = @[@(strongSelf.menstruationModel.ovulationBeforeDay)];
        }else if (indexPath.row == 6) {
            strongSelf.menstruationModel.ovulationAfterDay = [textField.text integerValue];
            textFieldModel.data = @[@(strongSelf.menstruationModel.ovulationAfterDay)];
        }
    };
}

- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        [funcVC showLoadingWithMessage:[NSString stringWithFormat:@"%@...",lang(@"set menstruation parameter")] ];
        [IDOFoundationCommand setMenstrualCommand:strongSelf.menstruationModel
                                         callback:^(int errorCode) {
             if (errorCode == 0) {
                 [funcVC showToastWithText:lang(@"set menstruation parameter success") ];
             }else if (errorCode == 6) {
                 [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
             }else {
                 [funcVC showToastWithText:lang(@"set menstruation parameter failed")];
             }
        }];
    };
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    
    SwitchCellModel * model1 = [[SwitchCellModel alloc]init];
    model1.typeStr = @"oneSwitch";
    model1.titleStr = lang(@"menstrual switch：");
    model1.data = @[@(self.menstruationModel.onOff)];
    model1.cellHeight = 70.0f;
    model1.cellClass = [OneSwitchTableViewCell class];
    model1.modelClass = [NSNull class];
    model1.isShowLine = YES;
    model1.switchCallback = self.switchCallback;
    [cellModels addObject:model1];
    
    TextFieldCellModel * model2 = [[TextFieldCellModel alloc]init];
    model2.typeStr = @"oneTextField";
    model2.titleStr = lang(@"menstrual length：");
    model2.data = @[@(self.menstruationModel.menstrualLength)];
    model2.cellHeight = 70.0f;
    model2.cellClass = [OneTextFieldTableViewCell class];
    model2.modelClass = [NSNull class];
    model2.isShowLine = YES;
    model2.isShowKeyboard = YES;
    model2.keyType = UIKeyboardTypeDecimalPad;
    model2.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model2];
    
    TextFieldCellModel * model3 = [[TextFieldCellModel alloc]init];
    model3.typeStr = @"oneTextField";
    model3.titleStr = lang(@"menstrual cycle：");
    model3.data = @[@(self.menstruationModel.menstrualLength)];
    model3.cellHeight = 70.0f;
    model3.cellClass = [OneTextFieldTableViewCell class];
    model3.modelClass = [NSNull class];
    model3.isShowLine = YES;
    model3.isShowKeyboard = YES;
    model3.keyType = UIKeyboardTypeDecimalPad;
    model3.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model3];
    
    TextFieldCellModel * model4 = [[TextFieldCellModel alloc]init];
    model4.typeStr = @"oneTextField";
    model4.titleStr = lang(@"recently menstrual：");
    model4.data = @[@(self.menstruationModel.lastMenstrualYear),
                    @(self.menstruationModel.lastMenstrualMonth),
                    @(self.menstruationModel.lastMenstrualDay)];
    model4.cellHeight = 70.0f;
    model4.cellClass = [ThreeTextFieldTableViewCell class];
    model4.modelClass = [NSNull class];
    model4.isShowLine = YES;
    model4.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model4];
    
    TextFieldCellModel * model5 = [[TextFieldCellModel alloc]init];
    model5.typeStr = @"oneTextField";
    model5.titleStr = lang(@"interval between ovulation days:");
    model5.data = @[@(self.menstruationModel.ovulationIntervalDay)];
    model5.cellHeight = 70.0f;
    model5.cellClass = [OneTextFieldTableViewCell class];
    model5.modelClass = [NSNull class];
    model5.isShowLine = YES;
    model5.isShowKeyboard = YES;
    model5.keyType = UIKeyboardTypeDecimalPad;
    model5.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model5];
    
    TextFieldCellModel * model6 = [[TextFieldCellModel alloc]init];
    model6.typeStr = @"oneTextField";
    model6.titleStr = lang(@"day before menstrual:");
    model6.data = @[@(self.menstruationModel.ovulationBeforeDay)];
    model6.cellHeight = 70.0f;
    model6.cellClass = [OneTextFieldTableViewCell class];
    model6.modelClass = [NSNull class];
    model6.isShowLine = YES;
    model6.isShowKeyboard = YES;
    model6.keyType = UIKeyboardTypeDecimalPad;
    model6.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model6];
    
    TextFieldCellModel * model7 = [[TextFieldCellModel alloc]init];
    model7.typeStr = @"oneTextField";
    model7.titleStr = lang(@"day after menstrual:");
    model7.data = @[@(self.menstruationModel.ovulationAfterDay)];
    model7.cellHeight = 70.0f;
    model7.cellClass = [OneTextFieldTableViewCell class];
    model7.modelClass = [NSNull class];
    model7.isShowLine = YES;
    model7.isShowKeyboard = YES;
    model7.keyType = UIKeyboardTypeDecimalPad;
    model7.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model7];
    
    EmpltyCellModel * model8 = [[EmpltyCellModel alloc]init];
    model8.typeStr = @"empty";
    model8.cellHeight = 30.0f;
    model8.isShowLine = YES;
    model8.cellClass  = [EmptyTableViewCell class];
    [cellModels addObject:model8];
    
    FuncCellModel * model9 = [[FuncCellModel alloc]init];
    model9.typeStr = @"oneButton";
    model9.data = @[lang(@"set menstruation parameter")];
    model9.cellHeight = 70.0f;
    model9.cellClass  = [OneButtonTableViewCell class];
    model9.modelClass = [NSNull class];
    model9.isShowLine = YES;
    model9.buttconCallback = self.buttconCallback;
    [cellModels addObject:model9];
    
    self.cellModels = cellModels;
}


@end
