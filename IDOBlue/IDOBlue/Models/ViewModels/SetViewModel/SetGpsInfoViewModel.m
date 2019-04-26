//
//  SetGpsInfoViewModel.m
//  IDOBlue
//
//  Created by hedongyang on 2018/9/30.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "SetGpsInfoViewModel.h"
#import "TextFieldCellModel.h"
#import "OneTextFieldTableViewCell.h"
#import "EmpltyCellModel.h"
#import "EmptyTableViewCell.h"
#import "FuncCellModel.h"
#import "OneButtonTableViewCell.h"
#import "FuncViewController.h"

@interface SetGpsInfoViewModel()
@property (nonatomic,strong)IDOSetGpsConfigInfoBluetoothModel * gpsMode;
@property (nonatomic,strong)NSArray * gpsDataArray;
@property (nonatomic,strong)NSArray * gpsOptions;
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^textFeildCallback)(UIViewController * viewController,UITextField * textField,UITableViewCell * tableViewCell);
@end

@implementation SetGpsInfoViewModel
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

- (IDOSetGpsConfigInfoBluetoothModel *)gpsMode
{
    if (!_gpsMode) {
        _gpsMode = [IDOSetGpsConfigInfoBluetoothModel currentModel];
    }
    return _gpsMode;
}

- (NSArray *)gpsOptions
{
    if (!_gpsOptions) {
        _gpsOptions = @[self.pickerDataModel.bootModeArray,self.pickerDataModel.operatingModeArray,
                        self.pickerDataModel.thousandArray,self.pickerDataModel.satelliteModeArray];
    }
    return _gpsOptions;
}

- (NSArray *)gpsDataArray
{
    if (!_gpsDataArray) {
        _gpsDataArray = @[@(self.gpsMode.startMode),@(self.gpsMode.gsopOperationMode),
                          @(self.gpsMode.gsopCycleMs),@(self.gpsMode.gnsValue)];
    }
    return _gpsDataArray;
}


- (void)getTextFieldCallback
{
    __weak typeof(self) weakSelf = self;
    self.textFeildCallback = ^(UIViewController *viewController, UITextField *textField, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
        NSArray * pickerArray = strongSelf.gpsOptions[indexPath.row];
        funcVC.pickerView.pickerArray = pickerArray;
        if (indexPath.row == 2) {
            funcVC.pickerView.currentIndex = [pickerArray containsObject:@([textField.text intValue])] ? [pickerArray indexOfObject:@([textField.text intValue])] : 0 ;
        }else {
            funcVC.pickerView.currentIndex = [pickerArray containsObject:textField.text] ? [pickerArray indexOfObject:textField.text] : 0 ;
        }
        [funcVC.pickerView show];
        funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
            textField.text = selectStr;
            if (indexPath.row == 2) {
                textFieldModel.data = @[@([selectStr integerValue])];
            }else {
                textFieldModel.data = @[selectStr];
            }
            if (indexPath.row == 0) {
                strongSelf.gpsMode.startMode = [pickerArray containsObject:selectStr] ? [pickerArray indexOfObject:selectStr] : 0 ;
            }else if (indexPath.row == 1) {
                strongSelf.gpsMode.gsopOperationMode = [pickerArray containsObject:selectStr] ? [pickerArray indexOfObject:selectStr] : 0 ;
            }else if (indexPath.row == 2) {
                strongSelf.gpsMode.gsopCycleMs = [selectStr integerValue];
            }else if (indexPath.row == 3) {
                strongSelf.gpsMode.gnsValue = [pickerArray containsObject:selectStr] ? [pickerArray indexOfObject:selectStr] : 0 ;
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
        [funcVC showLoadingWithMessage:[NSString stringWithFormat:@"%@...",lang(@"set GPS configuration information")]];
        [IDOFoundationCommand setGpsInfoCommand:strongSelf.gpsMode callback:^(int errorCode) {
            if(errorCode == 0) {
                [funcVC showToastWithText:lang(@"set GPS configuration information success")];
            }else {
                [funcVC showToastWithText:lang(@"set GPS configuration information failed")];
            }
        }];
    };
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];

    for (int i = 0; i < self.pickerDataModel.gpsInfoTitleArray.count; i++) {
        TextFieldCellModel * model = [[TextFieldCellModel alloc]init];
        NSInteger index = [[self.gpsDataArray objectAtIndex:i] integerValue];
        model.typeStr = @"oneTextField";
        model.titleStr = self.pickerDataModel.gpsInfoTitleArray[i];
        if (i == 2) {
            model.data = @[@(index)];
        }else {
            model.data = @[[[self.gpsOptions objectAtIndex:i] objectAtIndex:index]];
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
    model5.data = @[lang(@"set GPS configuration information")];
    model5.cellHeight = 70.0f;
    model5.cellClass = [OneButtonTableViewCell class];
    model5.modelClass = [NSNull class];
    model5.isShowLine = YES;
    model5.buttconCallback = self.buttconCallback;
    [cellModels addObject:model5];
    
    self.cellModels = cellModels;
}


@end
