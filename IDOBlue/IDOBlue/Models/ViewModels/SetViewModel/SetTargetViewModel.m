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
#import "EmpltyCellModel.h"
#import "FuncCellModel.h"


@interface SetTargetViewModel()
@property (nonatomic,copy)void(^textFeildCallback)(UIViewController * viewController,UITextField * textField,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,strong) IDOSetUserInfoBuletoothModel * userModel;
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
    model1.titleStr = @"目标类型 : ";
    model1.data = @[self.pickerDataModel.goalTypeArray[self.userModel.goalType]];
    model1.cellHeight = 70.0f;
    model1.cellClass = [OneTextFieldTableViewCell class];
    model1.modelClass = [NSNull class];
    model1.isShowLine = YES;
    model1.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model1];
    
    if (self.userModel.goalType == 0) {
        TextFieldCellModel * model2 = [[TextFieldCellModel alloc]init];
        model2.typeStr = @"oneTextField";
        model2.titleStr = @"目标步数(S) : ";
        model2.data = @[@(self.userModel.goalStepData)];
        model2.cellHeight = 70.0f;
        model2.cellClass = [OneTextFieldTableViewCell class];
        model2.modelClass = [NSNull class];
        model2.isShowLine = YES;
        model2.textFeildCallback = self.textFeildCallback;
        [cellModels addObject:model2];
    }else if (self.userModel.goalType == 1) {
        TextFieldCellModel * model3 = [[TextFieldCellModel alloc]init];
        model3.typeStr = @"oneTextField";
        model3.titleStr = @"目标卡路里(J) : ";
        model3.data = @[@(self.userModel.goalCalorieData)];
        model3.cellHeight = 70.0f;
        model3.cellClass = [OneTextFieldTableViewCell class];
        model3.modelClass = [NSNull class];
        model3.isShowLine = YES;
        model3.textFeildCallback = self.textFeildCallback;
        [cellModels addObject:model3];
    }else if (self.userModel.goalType == 2) {
        TextFieldCellModel * model4 = [[TextFieldCellModel alloc]init];
        model4.typeStr = @"oneTextField";
        model4.titleStr = @"目标距离(M) : ";
        model4.data = @[@(self.userModel.goalDistanceData)];
        model4.cellHeight = 70.0f;
        model4.cellClass = [OneTextFieldTableViewCell class];
        model4.modelClass = [NSNull class];
        model4.isShowLine = YES;
        model4.textFeildCallback = self.textFeildCallback;
        [cellModels addObject:model4];
    }
   
    EmpltyCellModel * model5 = [[EmpltyCellModel alloc]init];
    model5.typeStr = @"empty";
    model5.cellHeight = 30.0f;
    model5.isShowLine = YES;
    model5.cellClass  = [EmptyTableViewCell class];
    [cellModels addObject:model5];
    
    FuncCellModel * model6 = [[FuncCellModel alloc]init];
    model6.typeStr = @"oneButton";
    model6.data = @[@"设置目标信息"];
    model6.cellHeight = 70.0f;
    model6.cellClass = [OneButtonTableViewCell class];
    model6.modelClass = [NSNull class];
    model6.isShowLine = YES;
    model6.buttconCallback = self.buttconCallback;
    [cellModels addObject:model6];
    
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
            TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
            funcVC.pickerView.pickerArray = strongSelf.pickerDataModel.goalTypeArray;
            funcVC.pickerView.currentIndex = [strongSelf.pickerDataModel.goalTypeArray containsObject:textField.text] ?
            [strongSelf.pickerDataModel.goalTypeArray indexOfObject:textField.text] : 0 ;
            [funcVC.pickerView show];
            funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
                textField.text = selectStr;
                textFieldModel.data = @[selectStr];
                strongSelf.userModel.goalType  = [strongSelf.pickerDataModel.goalTypeArray containsObject:textField.text] ?
                [strongSelf.pickerDataModel.goalTypeArray indexOfObject:textField.text] : 0 ;
            };
        }else {
            if (strongSelf.userModel.goalType == 0) {
                TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
                funcVC.pickerView.pickerArray = strongSelf.pickerDataModel.tenThousandArray;
                funcVC.pickerView.currentIndex = [strongSelf.pickerDataModel.tenThousandArray containsObject:@([textField.text integerValue])] ?
                [strongSelf.pickerDataModel.tenThousandArray indexOfObject:@([textField.text integerValue])] : 0 ;
                [funcVC.pickerView show];
                funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
                    textField.text = selectStr;
                    textFieldModel.data = @[@([selectStr integerValue])];
                    strongSelf.userModel.goalStepData  = [strongSelf.pickerDataModel.tenThousandArray containsObject:@([selectStr integerValue])] ?
                    [strongSelf.pickerDataModel.tenThousandArray indexOfObject:@([selectStr integerValue])] : 0 ;
                    
                };
            }else if (strongSelf.userModel.goalType == 1) {
                TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
                funcVC.pickerView.pickerArray = strongSelf.pickerDataModel.thousandArray;
                funcVC.pickerView.currentIndex = [strongSelf.pickerDataModel.thousandArray containsObject:@([textField.text integerValue])] ?
                [strongSelf.pickerDataModel.thousandArray indexOfObject:@([textField.text integerValue])] : 0 ;
                [funcVC.pickerView show];
                funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
                    textField.text = selectStr;
                    textFieldModel.data = @[@([selectStr integerValue])];
                    strongSelf.userModel.goalCalorieData  = [strongSelf.pickerDataModel.thousandArray containsObject:@([selectStr integerValue])] ?
                    [strongSelf.pickerDataModel.thousandArray indexOfObject:@([selectStr integerValue])] : 0 ;
                    
                };
            }else if (strongSelf.userModel.goalType == 2) {
                TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
                funcVC.pickerView.pickerArray = strongSelf.pickerDataModel.tenThousandArray;
                funcVC.pickerView.currentIndex = [strongSelf.pickerDataModel.tenThousandArray containsObject:@([textField.text integerValue])] ?
                [strongSelf.pickerDataModel.tenThousandArray indexOfObject:@([textField.text integerValue])] : 0 ;
                [funcVC.pickerView show];
                funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
                    textField.text = selectStr;
                    textFieldModel.data = @[@([selectStr integerValue])];
                    strongSelf.userModel.goalDistanceData  = [strongSelf.pickerDataModel.tenThousandArray containsObject:@([selectStr integerValue])] ?
                    [strongSelf.pickerDataModel.tenThousandArray indexOfObject:@([selectStr integerValue])] : 0 ;
                };
            }
        }
    };
}

- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        [funcVC showLoadingWithMessage:@"设置目标信息..."];
        [IDOFoundationCommand setTargetInfoCommand:strongSelf.userModel
                                         callback:^(int errorCode) {
            if(errorCode == 0) {
                [funcVC showToastWithText:@"设置目标信息成功"];
            }else {
                [funcVC showToastWithText:@"设置目标信息失败"];
            }
        }];
    };
}
@end
