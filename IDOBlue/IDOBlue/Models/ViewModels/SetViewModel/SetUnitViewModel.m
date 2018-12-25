//
//  SetUnitViewModel.m
//  IDOBlue
//
//  Created by hedongyang on 2018/9/28.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "SetUnitViewModel.h"
#import "TextFieldCellModel.h"
#import "OneTextFieldTableViewCell.h"
#import "EmpltyCellModel.h"
#import "EmptyTableViewCell.h"
#import "FuncCellModel.h"
#import "OneButtonTableViewCell.h"
#import "FuncViewController.h"

@interface SetUnitViewModel()
@property (nonatomic,strong)IDOSetUnitInfoBluetoothModel * unitMode;
@property (nonatomic,strong)NSArray * unitDataArray;
@property (nonatomic,strong)NSArray * unitOptions;
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^textFeildCallback)(UIViewController * viewController,UITextField * textField,UITableViewCell * tableViewCell);
@end

@implementation SetUnitViewModel

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

- (IDOSetUnitInfoBluetoothModel *)unitMode
{
    if (!_unitMode) {
        _unitMode = [IDOSetUnitInfoBluetoothModel currentModel];
    }
    return _unitMode;
}

- (NSArray *)unitDataArray
{
    if (!_unitDataArray) {
        _unitDataArray = @[@(self.unitMode.distanceUnit),@(self.unitMode.weightUnit),@(self.unitMode.tempUnit),
                           @(self.unitMode.languageUnit),@(self.unitMode.strideWalk),@(self.unitMode.strideRun),
                           @(self.unitMode.strideGps),@(self.unitMode.timeUnit)];
    }
    return _unitDataArray;
}

- (NSArray *)unitOptions
{
    if (!_unitOptions) {
        _unitOptions = @[self.pickerDataModel.distanceUnitArray,self.pickerDataModel.weightUnitArray,self.pickerDataModel.tempUnitArray,
                         self.pickerDataModel.languageUnitArray,self.pickerDataModel.hundredArray,self.pickerDataModel.hundredArray,
                         self.pickerDataModel.strideGpsArray,self.pickerDataModel.timeUnitArray];
    }
    return _unitOptions;
}

- (void)getTextFieldCallback
{
    __weak typeof(self) weakSelf = self;
    self.textFeildCallback = ^(UIViewController *viewController, UITextField *textField, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
        NSArray * pickerArray = strongSelf.unitOptions[indexPath.row];
        funcVC.pickerView.pickerArray = pickerArray;
        if (indexPath.row == 4 || indexPath.row == 5) {
            funcVC.pickerView.currentIndex = [pickerArray containsObject:@([textField.text intValue])] ? [pickerArray indexOfObject:@([textField.text intValue])] : 0 ;
        }else {
            funcVC.pickerView.currentIndex = [pickerArray containsObject:textField.text] ? [pickerArray indexOfObject:textField.text] : 0 ;
        }
        [funcVC.pickerView show];
        funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
            textField.text = selectStr;
            if (indexPath.row == 4 || indexPath.row == 5) {
                textFieldModel.data = @[@([selectStr integerValue])];
            }else {
                textFieldModel.data = @[selectStr];
            }
            [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            if (indexPath.row == 0) {
                strongSelf.unitMode.distanceUnit = [pickerArray containsObject:selectStr] ? [pickerArray indexOfObject:selectStr] : 0 ;
            }else if (indexPath.row == 1) {
                strongSelf.unitMode.weightUnit = [pickerArray containsObject:selectStr] ? [pickerArray indexOfObject:selectStr] : 0 ;
            }else if (indexPath.row == 2) {
                strongSelf.unitMode.tempUnit = [pickerArray containsObject:selectStr] ? [pickerArray indexOfObject:selectStr] : 0 ;
            }else if (indexPath.row == 3) {
                strongSelf.unitMode.languageUnit = [pickerArray containsObject:selectStr] ? [pickerArray indexOfObject:selectStr] : 0 ;
            }else if (indexPath.row == 4) {
                strongSelf.unitMode.strideWalk = [selectStr integerValue];
            }else if (indexPath.row == 5) {
                strongSelf.unitMode.strideRun = [selectStr integerValue];
            }else if (indexPath.row == 6) {
                strongSelf.unitMode.strideGps = [pickerArray containsObject:selectStr] ? [pickerArray indexOfObject:selectStr] : 0 ;
            }else if (indexPath.row == 7) {
                strongSelf.unitMode.timeUnit = [pickerArray containsObject:selectStr] ? [pickerArray indexOfObject:selectStr] : 0 ;
            }
        };
    };
}

- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        [funcVC showLoadingWithMessage:@"设置设备单位..."];
        [IDOFoundationCommand setUnitCommand:strongSelf.unitMode
                                    callback:^(int errorCode) {
            if(errorCode == 0) {
                [funcVC showToastWithText:@"设置设备单位成功"];
            }else {
                [funcVC showToastWithText:@"设置设备单位失败"];
            }
        }];
    };
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    for (int i = 0; i < self.pickerDataModel.unitTitleArray.count; i++) {
        TextFieldCellModel * model = [[TextFieldCellModel alloc]init];
        NSInteger index = [[self.unitDataArray objectAtIndex:i] integerValue];
        model.typeStr = @"oneTextField";
        model.titleStr = self.pickerDataModel.unitTitleArray[i];
        if (i == 4 || i == 5) {
          model.data = @[@(index)];
        }else {
          model.data = @[[[self.unitOptions objectAtIndex:i] objectAtIndex:index]];
        }
        model.cellHeight = 70.0f;
        model.cellClass = [OneTextFieldTableViewCell class];
        model.modelClass = [NSNull class];
        model.isShowLine = YES;
        model.textFeildCallback = self.textFeildCallback;
        [cellModels addObject:model];
    }
    
    EmpltyCellModel * model4 = [[EmpltyCellModel alloc]init];
    model4.typeStr = @"empty";
    model4.cellHeight = 30.0f;
    model4.isShowLine = YES;
    model4.cellClass  = [EmptyTableViewCell class];
    [cellModels addObject:model4];
    
    FuncCellModel * model5 = [[FuncCellModel alloc]init];
    model5.typeStr = @"oneButton";
    model5.data = @[@"设置设备单位"];
    model5.cellHeight = 70.0f;
    model5.cellClass = [OneButtonTableViewCell class];
    model5.modelClass = [NSNull class];
    model5.isShowLine = YES;
    model5.buttconCallback = self.buttconCallback;
    [cellModels addObject:model5];
    
    self.cellModels = cellModels;
}

@end
