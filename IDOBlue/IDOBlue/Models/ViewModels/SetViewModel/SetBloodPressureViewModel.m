//
//  SetBpViewModel.m
//  IDOBlue
//
//  Created by hedongyang on 2018/9/29.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "SetBloodPressureViewModel.h"
#import "FuncCellModel.h"
#import "OneButtonTableViewCell.h"
#import "EmpltyCellModel.h"
#import "EmptyTableViewCell.h"
#import "TextFieldCellModel.h"
#import "OneTextFieldTableViewCell.h"
#import "FuncViewController.h"


@interface SetBloodPressureViewModel()
@property (nonatomic,strong) IDOSetBloodPressureInfoBluetoothModel * bpModel;
@property (nonatomic,copy)void(^textFeildCallback)(UIViewController * viewController,UITextField * textField,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation SetBloodPressureViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getButtonCallback];
        [self getTextFieldCallback];
        [self getCellModels];
    }
    return self;
}

- (IDOSetBloodPressureInfoBluetoothModel *)bpModel
{
    if (!_bpModel) {
        _bpModel = [IDOSetBloodPressureInfoBluetoothModel currentModel];
        _bpModel.flag = 1;
    }
    return _bpModel;
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    TextFieldCellModel * model1 = [[TextFieldCellModel alloc]init];
    model1.typeStr = @"oneTextField";
    model1.titleStr = lang(@"diastolic");
    model1.data = @[@(self.bpModel.diastolic)];
    model1.cellHeight = 70.0f;
    model1.cellClass = [OneTextFieldTableViewCell class];
    model1.modelClass = [NSNull class];
    model1.isShowLine = YES;
    model1.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model1];
    
    TextFieldCellModel * model2 = [[TextFieldCellModel alloc]init];
    model2.typeStr = @"oneTextField";
    model2.titleStr = lang(@"shrinkage");
    model2.data = @[@(self.bpModel.shrinkage)];
    model2.cellHeight = 70.0f;
    model2.cellClass = [OneTextFieldTableViewCell class];
    model2.modelClass = [NSNull class];
    model2.isShowLine = YES;
    model2.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model2];
    
    EmpltyCellModel * model3 = [[EmpltyCellModel alloc]init];
    model3.typeStr = @"empty";
    model3.cellHeight = 30.0f;
    model3.isShowLine = YES;
    model3.cellClass  = [EmptyTableViewCell class];
    [cellModels addObject:model3];
    
    FuncCellModel * model4 = [[FuncCellModel alloc]init];
    model4.typeStr = @"oneButton";
    model4.data = @[lang(@"set blood pressure data")];
    model4.cellHeight = 70.0f;
    model4.cellClass = [OneButtonTableViewCell class];
    model4.modelClass = [NSNull class];
    model4.isShowLine = YES;
    model4.buttconCallback = self.buttconCallback;
    [cellModels addObject:model4];
    
    self.cellModels = cellModels;
}

- (void)getTextFieldCallback
{
    __weak typeof(self) weakSelf = self;
    self.textFeildCallback = ^(UIViewController *viewController, UITextField *textField, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
        funcVC.pickerView.pickerArray = strongSelf.pickerDataModel.bpArray;
        funcVC.pickerView.currentIndex = [strongSelf.pickerDataModel.bpArray containsObject:@([textField.text intValue])] ? [strongSelf.pickerDataModel.bpArray indexOfObject:@([textField.text intValue])] : 0 ;
        [funcVC.pickerView show];
        funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
            textField.text = selectStr;
            textFieldModel.data = @[@([selectStr integerValue])];
            [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            if (indexPath.row == 0) {
                strongSelf.bpModel.diastolic = [selectStr integerValue];
            }else {
                strongSelf.bpModel.shrinkage = [selectStr integerValue];
            }
        };
    };
}


- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        strongSelf.bpModel.flag = 1;
        if(   !__IDO_FUNCTABLE__.funcTable18Model.bloodPressure
           && !__IDO_FUNCTABLE__.funcTable34Model.supportV3Bp) {
            FuncViewController * funcVC = (FuncViewController *)viewController;
            [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
            return;
        }
        [strongSelf queryBpCalCommand];
    };
}

- (void)queryBpCalCommand
{
    __weak typeof(self) weakSelf = self;
    FuncViewController * funcVC = (FuncViewController *)[IDODemoUtility getCurrentVC];
    [funcVC showLoadingWithMessage:[NSString stringWithFormat:@"%@...",lang(@"set blood pressure data")]];
    [IDOFoundationCommand setBpCalCommand:self.bpModel
                                 callback:^(int errorCode, IDOSetBloodPressureInfoBluetoothModel * _Nullable model) {
             __strong typeof(self) strongSelf = weakSelf;
             if(errorCode == 0) {
                 if (model.statusCode == 0x01) {
                     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                         strongSelf.bpModel.flag = 2;
                         [strongSelf queryBpCalCommand];
                     });
                 }else if (model.statusCode > 0x02) {
                     [funcVC showToastWithText:lang(@"set blood pressure data failed") ];
                 }else {
                     [funcVC showToastWithText:lang(@"set blood pressure data success") ];
                 }
             }else if (errorCode == 6) {
                 [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
             }else {
                 [funcVC showToastWithText:lang(@"set blood pressure data failed") ];
             }
    }];
}

@end
