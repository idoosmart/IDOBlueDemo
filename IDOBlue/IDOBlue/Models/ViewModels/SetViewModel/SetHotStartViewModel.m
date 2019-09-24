//
//  SetHotStartViewModel.m
//  IDOBlue
//
//  Created by hedongyang on 2018/9/30.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "SetHotStartViewModel.h"
#import "TextFieldCellModel.h"
#import "OneTextFieldTableViewCell.h"
#import "EmpltyCellModel.h"
#import "EmptyTableViewCell.h"
#import "FuncCellModel.h"
#import "OneButtonTableViewCell.h"
#import "FuncViewController.h"

@interface SetHotStartViewModel()
@property (nonatomic,strong)IDOGetHotStartParamBluetoothModel * hotStartMode;
@property (nonatomic,strong)NSArray * hotStartDataArray;
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^textFeildCallback)(UIViewController * viewController,UITextField * textField,UITableViewCell * tableViewCell);
@end

@implementation SetHotStartViewModel
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

- (IDOGetHotStartParamBluetoothModel *)hotStartMode
{
    if (!_hotStartMode) {
        _hotStartMode = [IDOGetHotStartParamBluetoothModel currentModel];
    }
    return _hotStartMode;
}

- (NSArray *)hotStartDataArray
{
    if (!_hotStartDataArray) {
        _hotStartDataArray = @[@(self.hotStartMode.tcxoOffset),@(self.hotStartMode.longitude),
                          @(self.hotStartMode.latitude),@(self.hotStartMode.altitude)];
    }
    return _hotStartDataArray;
}

- (void)getTextFieldCallback
{
    __weak typeof(self) weakSelf = self;
    self.textFeildCallback = ^(UIViewController *viewController, UITextField *textField, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        if (indexPath.row == 0) {
            strongSelf.hotStartMode.tcxoOffset = [textField.text doubleValue] * pow(10,1);
        }else if (indexPath.row == 1) {
            strongSelf.hotStartMode.longitude = [textField.text doubleValue] * pow(10,6);
        }else if (indexPath.row == 2) {
            strongSelf.hotStartMode.latitude = [textField.text doubleValue] * pow(10,6);
        }else if (indexPath.row == 3) {
            strongSelf.hotStartMode.altitude = [textField.text doubleValue] * pow(10,1);
        }
    };
}

- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        [funcVC showLoadingWithMessage:[NSString stringWithFormat:@"%@...",lang(@"set hot start information")]];
        [IDOFoundationCommand setHotStartParamCommand:strongSelf.hotStartMode
                                             callback:^(int errorCode) {
            if(errorCode == 0) {
                [funcVC showToastWithText:lang(@"set hot start information success")];
            }else if (errorCode == 6) {
                [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
            }else {
                [funcVC showToastWithText:lang(@"set hot start information failed")];
            }
        }];
    };
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    
    for (int i = 0; i < self.pickerDataModel.hotStartTitleArray.count; i++) {
        TextFieldCellModel * model = [[TextFieldCellModel alloc]init];
        double data = [[self.hotStartDataArray objectAtIndex:i] doubleValue];
        model.typeStr = @"oneTextField";
        model.placeholders = @[self.pickerDataModel.hotStartplaceholderArray[i]];
        model.titleStr = self.pickerDataModel.hotStartTitleArray[i];
        model.data = @[@(data)];
        model.cellHeight = 70.0f;
        model.cellClass = [OneTextFieldTableViewCell class];
        model.modelClass = [NSNull class];
        model.isShowLine = YES;
        model.isShowKeyboard = YES;
        model.keyType = UIKeyboardTypeDecimalPad;
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
    model5.data = @[lang(@"set hot start information")];
    model5.cellHeight = 70.0f;
    model5.cellClass = [OneButtonTableViewCell class];
    model5.modelClass = [NSNull class];
    model5.isShowLine = YES;
    model5.buttconCallback = self.buttconCallback;
    [cellModels addObject:model5];
    
    self.cellModels = cellModels;
}
@end
