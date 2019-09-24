//
//  SetHrIntervalViewModel.m
//  IDOBlue
//
//  Created by hedongyang on 2018/9/28.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "SetHrIntervalViewModel.h"
#import "TextFieldCellModel.h"
#import "OneTextFieldTableViewCell.h"
#import "EmpltyCellModel.h"
#import "EmptyTableViewCell.h"
#import "FuncCellModel.h"
#import "OneButtonTableViewCell.h"
#import "FuncViewController.h"


@interface SetHrIntervalViewModel()
@property (nonatomic,strong)IDOSetHrIntervalInfoBluetoothModel * hrIntervalModel;
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^textFeildCallback)(UIViewController * viewController,UITextField * textField,UITableViewCell * tableViewCell);
@end

@implementation SetHrIntervalViewModel
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

- (IDOSetHrIntervalInfoBluetoothModel *)hrIntervalModel
{
    if (!_hrIntervalModel) {
        _hrIntervalModel = [IDOSetHrIntervalInfoBluetoothModel currentModel];
    }
    return _hrIntervalModel;
}

- (void)getTextFieldCallback
{
    __weak typeof(self) weakSelf = self;
    self.textFeildCallback = ^(UIViewController *viewController, UITextField *textField, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
        funcVC.pickerView.pickerArray = strongSelf.pickerDataModel.hrArray;
        funcVC.pickerView.currentIndex = [strongSelf.pickerDataModel.hrArray containsObject:@([textField.text intValue])] ?
        [strongSelf.pickerDataModel.hrArray indexOfObject:@([textField.text intValue])] : 0 ;
        [funcVC.pickerView show];
        funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
            textField.text = selectStr;
            textFieldModel.data = @[@([selectStr integerValue])];
            [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            if(indexPath.row == 0) {
                strongSelf.hrIntervalModel.burnFat  = [selectStr integerValue];
            }else if (indexPath.row == 1) {
                strongSelf.hrIntervalModel.aerobic  = [selectStr integerValue];
            }else if (indexPath.row == 2) {
                strongSelf.hrIntervalModel.limitValue  = [selectStr integerValue];
            }else if (indexPath.row == 3) {
                strongSelf.hrIntervalModel.userMaxHr  = [selectStr integerValue];
            }else if (indexPath.row == 5) {
                strongSelf.hrIntervalModel.warmUp  = [selectStr integerValue];
            }else if (indexPath.row == 6) {
                strongSelf.hrIntervalModel.anaerobic  = [selectStr integerValue];
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
        [funcVC showLoadingWithMessage: [NSString stringWithFormat:@"%@...",lang(@"set heart rate interval")] ];
        [IDOFoundationCommand setHrIntervalCommand:strongSelf.hrIntervalModel
                                          callback:^(int errorCode) {
              if(errorCode == 0) {
                  [funcVC showToastWithText:lang(@"set heart rate interval success")];
              }else if (errorCode == 6) {
                  [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
              }else {
                  [funcVC showToastWithText:lang(@"set heart rate interval failed")];
              }
        }];
    };
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];

    TextFieldCellModel * model1 = [[TextFieldCellModel alloc]init];
    model1.typeStr = @"oneTextField";
    model1.titleStr = lang(@"burn fat:"); // 脂肪燃烧
    model1.data = @[@(self.hrIntervalModel.burnFat)];
    model1.cellHeight = 70.0f;
    model1.cellClass = [OneTextFieldTableViewCell class];
    model1.modelClass = [NSNull class];
    model1.isShowLine = YES;
    model1.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model1];
    
    TextFieldCellModel * model2 = [[TextFieldCellModel alloc]init];
    model2.typeStr = @"oneTextField";
    model2.titleStr = lang(@"aerobic exercise:"); // 有氧运动
    model2.data = @[@(self.hrIntervalModel.aerobic)];
    model2.cellHeight = 70.0f;
    model2.cellClass = [OneTextFieldTableViewCell class];
    model2.modelClass = [NSNull class];
    model2.isShowLine = YES;
    model2.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model2];
    
    TextFieldCellModel * model3 = [[TextFieldCellModel alloc]init];
    model3.typeStr = @"oneTextField";
    model3.titleStr =  lang(@"extreme exercise:") ; //极限运动
    model3.data = @[@(self.hrIntervalModel.limitValue)];
    model3.cellHeight = 70.0f;
    model3.cellClass = [OneTextFieldTableViewCell class];
    model3.modelClass = [NSNull class];
    model3.isShowLine = YES;
    model3.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model3];
    
    TextFieldCellModel * model4 = [[TextFieldCellModel alloc]init];
    model4.typeStr = @"oneTextField";
    model4.titleStr = lang(@"max heart rate:"); // 最大心率
    model4.data = @[@(self.hrIntervalModel.userMaxHr)];
    model4.cellHeight = 70.0f;
    model4.cellClass = [OneTextFieldTableViewCell class];
    model4.modelClass = [NSNull class];
    model4.isShowLine = YES;
    model4.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model4];
    
    TextFieldCellModel * model8 = [[TextFieldCellModel alloc]init];
    model8.typeStr = @"oneTextField";
    model8.titleStr = lang(@"warm up:");//热身运动
    model8.data = @[@(self.hrIntervalModel.warmUp)];
    model8.cellHeight = 70.0f;
    model8.cellClass = [OneTextFieldTableViewCell class];
    model8.modelClass = [NSNull class];
    model8.isShowLine = YES;
    model8.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model8];
    
    TextFieldCellModel * model9 = [[TextFieldCellModel alloc]init];
    model9.typeStr = @"oneTextField";
    model9.titleStr = lang(@"anaerobic exercise:"); //无氧运动
    model9.data = @[@(self.hrIntervalModel.anaerobic)];
    model9.cellHeight = 70.0f;
    model9.cellClass = [OneTextFieldTableViewCell class];
    model9.modelClass = [NSNull class];
    model9.isShowLine = YES;
    model9.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model9];
    
    EmpltyCellModel * model5 = [[EmpltyCellModel alloc]init];
    model5.typeStr = @"empty";
    model5.cellHeight = 30.0f;
    model5.isShowLine = YES;
    model5.cellClass  = [EmptyTableViewCell class];
    [cellModels addObject:model5];
    
    FuncCellModel * model6 = [[FuncCellModel alloc]init];
    model6.typeStr = @"oneButton";
    model6.data = @[lang(@"set heart rate interval button")];
    model6.cellHeight = 70.0f;
    model6.cellClass = [OneButtonTableViewCell class];
    model6.modelClass = [NSNull class];
    model6.isShowLine = YES;
    model6.buttconCallback = self.buttconCallback;
    [cellModels addObject:model6];
    
    self.cellModels = cellModels;
}

@end
