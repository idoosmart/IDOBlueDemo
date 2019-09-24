//
//  SetTargetViewModel.m
//  IDOBluetoothDemo
//
//  Created by hedongyang on 2018/9/25.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "SetTargetViewModel.h"
#import "FuncViewController.h"
#import "OneTextFieldTableViewCell.h"
#import "EmptyTableViewCell.h"
#import "OneButtonTableViewCell.h"
#import "TextFieldCellModel.h"
#import "TwoTextFieldTableViewCell.h"
#import "EmpltyCellModel.h"
#import "FuncCellModel.h"


@interface SetTargetViewModel()
@property (nonatomic,copy)void(^textFeildCallback)(UIViewController * viewController,UITextField * textField,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,strong) IDOSetUserInfoBuletoothModel * userModel;
@property (nonatomic,strong) UITextField * textField1;
@property (nonatomic,strong) UITextField * textField2;
@property (nonatomic,strong) UITextField * textField3;
@property (nonatomic,strong) UITextField * textField4;
@property (nonatomic,strong) UITextField * textField5;
@property (nonatomic,strong) UITextField * textField6;
@end

@implementation SetTargetViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getTextFieldCallback];
        [self getButtonCallback];
        [self getCellModels];
    }
    return self;
}

- (IDOSetUserInfoBuletoothModel *)userModel
{
    if (!_userModel) {
        _userModel = [IDOSetUserInfoBuletoothModel currentModel];
    }
    return _userModel;
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    
    TextFieldCellModel * model1 = [[TextFieldCellModel alloc]init];
    model1.typeStr = @"oneTextField";
    model1.titleStr = lang(@"set target step");
    model1.data = @[@(self.userModel.goalStepData)];
    model1.cellHeight = 70.0f;
    model1.cellClass = [OneTextFieldTableViewCell class];
    model1.modelClass = [NSNull class];
    model1.isShowLine = YES;
    model1.isShowKeyboard = YES;
    model1.keyType = UIKeyboardTypeDecimalPad;
    model1.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model1];
    
    TextFieldCellModel * model2 = [[TextFieldCellModel alloc]init];
    model2.typeStr = @"twoTextField";
    model2.titleStr = lang(@"set target sleep");
    model2.data = @[@(self.userModel.goalSleepDataHour),@(self.userModel.goalSleepDataMinute)];
    model2.cellHeight = 70.0f;
    model2.cellClass = [TwoTextFieldTableViewCell class];
    model2.modelClass = [NSNull class];
    model2.isShowLine = YES;
    model2.isShowKeyboard = YES;
    model2.keyType = UIKeyboardTypeDecimalPad;
    model2.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model2];
    
    TextFieldCellModel * model3 = [[TextFieldCellModel alloc]init];
    model3.typeStr = @"oneTextField";
    model3.titleStr = lang(@"set target weight");
    model3.data = @[@(self.userModel.goalWeightData)];
    model3.cellHeight = 70.0f;
    model3.cellClass = [OneTextFieldTableViewCell class];
    model3.modelClass = [NSNull class];
    model3.isShowLine = YES;
    model3.isShowKeyboard = YES;
    model3.keyType = UIKeyboardTypeDecimalPad;
    model3.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model3];
    
    EmpltyCellModel * model4 = [[EmpltyCellModel alloc]init];
    model4.typeStr = @"empty";
    model4.cellHeight = 30.0f;
    model4.isShowLine = YES;
    model4.cellClass  = [EmptyTableViewCell class];
    [cellModels addObject:model4];
    
    FuncCellModel * model5 = [[FuncCellModel alloc]init];
    model5.typeStr = @"oneButton";
    model5.data = @[lang(@"set target step|sleep|weight")];
    model5.cellHeight = 70.0f;
    model5.cellClass = [OneButtonTableViewCell class];
    model5.modelClass = [NSNull class];
    model5.isShowLine = YES;
    model5.buttconCallback = self.buttconCallback;
    [cellModels addObject:model5];
    
    TextFieldCellModel * model6 = [[TextFieldCellModel alloc]init];
    model6.typeStr = @"oneTextField";
    model6.titleStr = lang(@"set target calorie");
    model6.data = @[@(self.userModel.goalCalorieData)];
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
    model7.titleStr = lang(@"set target distance");
    model7.data = @[@(self.userModel.goalDistanceData)];
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
    model9.data = @[lang(@"set target calorie|distance")];
    model9.cellHeight = 70.0f;
    model9.cellClass = [OneButtonTableViewCell class];
    model9.modelClass = [NSNull class];
    model9.isShowLine = YES;
    model9.buttconCallback = self.buttconCallback;
    [cellModels addObject:model9];
    
    self.cellModels = cellModels;
}

- (void)getTextFieldCallback
{
    __weak typeof(self) weakSelf = self;
    self.textFeildCallback = ^(UIViewController *viewController, UITextField *textField, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        __block FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        if(indexPath.row == 0) {
            strongSelf.userModel.goalType = 0;
            strongSelf.textField1 = textField;
        }else if (indexPath.row == 1) {
            TwoTextFieldTableViewCell * twoCell = (TwoTextFieldTableViewCell *)tableViewCell;
            strongSelf.textField2 = twoCell.textField1;
            strongSelf.textField3 = twoCell.textField2;
        }else if (indexPath.row == 2) {
            strongSelf.textField4 = textField;
        }else if (indexPath.row == 5) {
            strongSelf.userModel.goalType = 1;
            strongSelf.textField5 = textField;
        }else if (indexPath.row == 6) {
            strongSelf.userModel.goalType = 2;
            strongSelf.textField6 = textField;
        }
    };
}

- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        if (indexPath.row == 4) {
            TextFieldCellModel * textFieldModel1 = [strongSelf.cellModels objectAtIndex:0];
            textFieldModel1.data = @[@([strongSelf.textField1.text integerValue])];
            TextFieldCellModel * textFieldModel2 = [strongSelf.cellModels objectAtIndex:1];
            textFieldModel2.data = @[@([strongSelf.textField2.text integerValue]),@([strongSelf.textField3.text integerValue])];
            TextFieldCellModel * textFieldModel3 = [strongSelf.cellModels objectAtIndex:2];
            textFieldModel3.data = @[@([strongSelf.textField4.text integerValue])];
            strongSelf.userModel.goalType = 0;
            NSInteger goalStepData = [strongSelf.textField1.text integerValue];
            NSInteger goalSleepDataHour = [strongSelf.textField2.text integerValue];
            NSInteger goalSleepDataMinute = [strongSelf.textField3.text integerValue];
            NSInteger goalWeightData = [strongSelf.textField4.text integerValue];
            strongSelf.userModel.goalStepData = goalStepData == 0 ? strongSelf.userModel.goalStepData : goalStepData;
            strongSelf.userModel.goalSleepDataHour = goalSleepDataHour == 0 ? strongSelf.userModel.goalSleepDataHour : goalSleepDataHour;
            strongSelf.userModel.goalSleepDataMinute = goalSleepDataMinute == 0 ? strongSelf.userModel.goalSleepDataMinute : goalSleepDataMinute;
            strongSelf.userModel.goalWeightData = goalWeightData == 0 ? strongSelf.userModel.goalWeightData : goalWeightData;
            [funcVC showLoadingWithMessage:lang(@"set target info...")];
            [IDOFoundationCommand setTargetInfoCommand:strongSelf.userModel
                                              callback:^(int errorCode) {
                  if(errorCode == 0) {
                      [funcVC showToastWithText:lang(@"set target info success")];
                  }else if (errorCode == 6) {
                      [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
                  }else {
                      [funcVC showToastWithText:lang(@"set target info failed")];
                  }
            }];
        }else if (indexPath.row == 8) {
            TextFieldCellModel * textFieldModel4 = [strongSelf.cellModels objectAtIndex:5];
            textFieldModel4.data = @[@([strongSelf.textField5.text integerValue])];
            strongSelf.userModel.goalCalorieData  = [strongSelf.textField5.text integerValue];
            strongSelf.userModel.goalDistanceData = [strongSelf.textField6.text integerValue];
            if (   __IDO_FUNCTABLE__.funcTable20Model.calorieGoal
                && __IDO_FUNCTABLE__.funcTable20Model.distanceGoal) {
                [funcVC showLoadingWithMessage:lang(@"set target info...")];
                [IDOFoundationCommand setCalorieAndDistanceGoalCommand:strongSelf.userModel
                                                              callback:^(int errorCode) {
                      if(errorCode == 0) {
                          [funcVC showToastWithText:lang(@"set target info success")];
                      }else if (errorCode == 6) {
                          [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
                      }else {
                          [funcVC showToastWithText:lang(@"set target info failed")];
                      }
                }];
            }else {
                [funcVC showLoadingWithMessage:lang(@"set target info...")];
                [IDOFoundationCommand setTargetInfoCommand:strongSelf.userModel
                                                  callback:^(int errorCode) {
                      if(errorCode == 0) {
                          [funcVC showToastWithText:lang(@"set target info success")];
                      }else if (errorCode == 6) {
                          [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
                      }else {
                          [funcVC showToastWithText:lang(@"set target info failed")];
                      }
                 }];
            }
        }
    };
}
@end
