//
//  SetUserInfoViewModel.m
//  IDOBluetoothDemo
//
//  Created by apple on 2018/9/24.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "SetUserInfoViewModel.h"
#import "TextFieldCellModel.h"
#import "LabelCellModel.h"
#import "FuncCellModel.h"
#import "EmpltyCellModel.h"
#import "ThreeTextFieldTableViewCell.h"
#import "OneLabelTableViewCell.h"
#import "TwoButtonTableViewCell.h"
#import "OneTextFieldTableViewCell.h"
#import "OneButtonTableViewCell.h"
#import "EmptyTableViewCell.h"
#import "FuncViewController.h"

static NSString * tipText = @"设置用户信息:用户信息中的身高和性别等参数是计算手环的步长,卡路里,公里数等的重要参数,请在第一时间将升高性别身高体重参数设置好,以免手环上的步数显示错误";

@interface SetUserInfoViewModel()
@property (nonatomic,copy)void(^textFeildCallback)(UIViewController * viewController,UITextField * textField,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,strong) IDOSetUserInfoBuletoothModel * userModel;
@end

@implementation SetUserInfoViewModel

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
    LabelCellModel * model1 = [[LabelCellModel alloc]init];
    model1.typeStr = @"oneLabel";
    model1.data = @[tipText];
    model1.cellHeight = 100.0f;
    model1.cellClass = [OneLabelTableViewCell class];
    model1.modelClass = [NSNull class];
    model1.isShowLine = YES;
    [cellModels addObject:model1];
    
    TextFieldCellModel * model8 = [[TextFieldCellModel alloc]init];
    model8.typeStr = @"oneTextField";
    model8.titleStr = @"用户ID : ";
    model8.data = @[self.userModel.userId?:@""];
    model8.cellHeight = 70.0f;
    model8.cellClass = [OneTextFieldTableViewCell class];
    model8.modelClass = [NSNull class];
    model8.isShowLine = YES;
    model8.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model8];
    
    TextFieldCellModel * model2 = [[TextFieldCellModel alloc]init];
    model2.typeStr = @"threeTextField";
    model2.titleStr = @"生日 : ";
    model2.data = @[@(self.userModel.year),@(self.userModel.month),@(self.userModel.day)];
    model2.cellHeight = 70.0f;
    model2.cellClass = [ThreeTextFieldTableViewCell class];
    model2.modelClass = [NSNull class];
    model2.isShowLine = YES;
    model2.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model2];
    
    FuncCellModel * model3 = [[FuncCellModel alloc]init];
    model3.typeStr = @"twoButton";
    model3.titleStr = @"性别 : ";
    model3.data = @[@{@"title":@"男",@"state":@1},@{@"title":@"女",@"state":@0}];
    model3.cellHeight = 70.0f;
    model3.cellClass = [TwoButtonTableViewCell class];
    model3.modelClass = [NSNull class];
    model3.isShowLine = YES;
    model3.buttconCallback = self.buttconCallback;
    [cellModels addObject:model3];
    
    TextFieldCellModel * model4 = [[TextFieldCellModel alloc]init];
    model4.typeStr = @"oneTextField";
    model4.titleStr = @"身高 : ";
    model4.data = @[@(self.userModel.height)];
    model4.cellHeight = 70.0f;
    model4.cellClass = [OneTextFieldTableViewCell class];
    model4.modelClass = [NSNull class];
    model4.isShowLine = YES;
    model4.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model4];
    
    TextFieldCellModel * model5 = [[TextFieldCellModel alloc]init];
    model5.typeStr = @"oneTextField";
    model5.titleStr = @"体重 : ";
    model5.data = @[@(self.userModel.weight)];
    model5.cellHeight = 70.0f;
    model5.cellClass = [OneTextFieldTableViewCell class];
    model5.modelClass = [NSNull class];
    model5.isShowLine = YES;
    model5.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model5];
    
    EmpltyCellModel * model6 = [[EmpltyCellModel alloc]init];
    model6.typeStr = @"empty";
    model6.cellHeight = 30.0f;
    model6.isShowLine = YES;
    model6.cellClass  = [EmptyTableViewCell class];
    [cellModels addObject:model6];
    
    FuncCellModel * model7 = [[FuncCellModel alloc]init];
    model7.typeStr = @"oneButton";
    model7.data = @[@"设置个人信息"];
    model7.cellHeight = 70.0f;
    model7.cellClass = [OneButtonTableViewCell class];
    model7.modelClass = [NSNull class];
    model7.isShowLine = YES;
    model7.buttconCallback = self.buttconCallback;
    [cellModels addObject:model7];
    
    self.cellModels = cellModels;
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
                textFieldModel.data = @[selectStr?:@""];
                [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                strongSelf.userModel.userId  = selectStr;
            };
        }else if (indexPath.row == 2) {
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
                strongSelf.userModel.year  = [dateArray[0] integerValue];
                strongSelf.userModel.month = [dateArray[1] integerValue];
                strongSelf.userModel.day   = [dateArray[2] integerValue];
            };
        }else if (indexPath.row == 4) {
            TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
            funcVC.pickerView.pickerArray = strongSelf.pickerDataModel.heightArray;
            funcVC.pickerView.currentIndex = [strongSelf.pickerDataModel.heightArray containsObject:@([textField.text intValue])] ?
            [strongSelf.pickerDataModel.heightArray indexOfObject:@([textField.text intValue])] : 0 ;
            [funcVC.pickerView show];
            funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
                textField.text = selectStr;
                textFieldModel.data = @[@([selectStr integerValue])];
                [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                strongSelf.userModel.height  = [selectStr integerValue];
            };
        }else if (indexPath.row == 5) {
            TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
            funcVC.pickerView.pickerArray = strongSelf.pickerDataModel.weightArray;
            funcVC.pickerView.currentIndex = [strongSelf.pickerDataModel.weightArray containsObject:@([textField.text intValue])] ?
            [strongSelf.pickerDataModel.weightArray indexOfObject:@([textField.text intValue])] : 0 ;
            [funcVC.pickerView show];
            funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
                textField.text = selectStr;
                textFieldModel.data = @[@([selectStr integerValue])];
                [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                strongSelf.userModel.weight  = [selectStr integerValue];
            };
        }
    };
}

- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        TwoButtonTableViewCell * twoCell = (TwoButtonTableViewCell *)tableViewCell;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        if (indexPath.row == 3) {
            FuncCellModel * funcCellModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
            strongSelf.userModel.gender = twoCell.button1.isSelected ? 1 : 2;
            BOOL isMan = twoCell.button1.isSelected ? YES : NO;
            funcCellModel.data = @[@{@"title":@"男",@"state":[NSNumber numberWithBool:isMan]},@{@"title":@"女",@"state":[NSNumber numberWithBool:!isMan]}];
        }else {
            [funcVC showLoadingWithMessage:@"设置用户信息..."];
            strongSelf.userModel.isLogin = YES;
            [IDOFoundationCommand setUserInfoCommand:strongSelf.userModel
                                            callback:^(int errorCode) {
                if(errorCode == 0) {
                    [funcVC showToastWithText:@"设置用户信息成功"];
                }else {
                    [funcVC showToastWithText:@"设置用户信息失败"];
                }
            }];
        }
    };
}

@end
