//
//  SetWeatchSunTimeViewModel.m
//  IDOBlue
//
//  Created by xiongjie on 2021/8/12.
//  Copyright © 2021 hedongyang. All rights reserved.
//

#import "SetWeatchSunTimeViewModel.h"
#import "TextFieldCellModel.h"
#import "TwoTextFieldTableViewCell.h"
#import "EmpltyCellModel.h"
#import "EmptyTableViewCell.h"
#import "FuncCellModel.h"
#import "OneButtonTableViewCell.h"
#import "FuncViewController.h"

@interface SetWeatchSunTimeViewModel()

@property(nonatomic,strong) IDOSetWeatherSunTimeModel *weatherSunTimeModel;
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^textFeildCallback)(UIViewController * viewController,UITextField * textField,UITableViewCell * tableViewCell);

@end


@implementation SetWeatchSunTimeViewModel


-(instancetype)init
{
    self = [super init];
    if (self)
    {
        [self getTextFieldCallback];
        [self getButtonCallback];
        [self getCellModels];
    }
    
    return self;
}


- (IDOSetWeatherSunTimeModel *)weatherSunTimeModel
{
    if (!_weatherSunTimeModel)
    {
         _weatherSunTimeModel = [IDOSetWeatherSunTimeModel currentModel];
    }
    return  _weatherSunTimeModel;
}


- (void)getTextFieldCallback
{
    __weak typeof(self) weakSelf = self;
    self.textFeildCallback = ^(UIViewController *viewController, UITextField *textField, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        if (indexPath.row == 0)
        {
            TwoTextFieldTableViewCell * twoCell = (TwoTextFieldTableViewCell *)tableViewCell;
            TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
            NSArray * pickerArray = twoCell.textField1 == textField ? strongSelf.pickerDataModel.hourArray : strongSelf.pickerDataModel.minuteArray;
            funcVC.pickerView.pickerArray = pickerArray;
            funcVC.pickerView.currentIndex = [pickerArray containsObject:@([textField.text intValue])] ? [pickerArray indexOfObject:@([textField.text intValue])] : 0 ;
            [funcVC.pickerView show];
            funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
                textField.text = selectStr;
                if (twoCell.textField1 == textField) {
                    strongSelf.weatherSunTimeModel.sunriseHour    = [selectStr integerValue];
                }else {
                    strongSelf.weatherSunTimeModel.sunriseMinute  = [selectStr integerValue];
                }
                textFieldModel.data = @[@(strongSelf.weatherSunTimeModel.sunriseHour),@(strongSelf.weatherSunTimeModel.sunriseMinute)];
                [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            };
        }
        else if (indexPath.row == 1)
        {
            TwoTextFieldTableViewCell * twoCell = (TwoTextFieldTableViewCell *)tableViewCell;
            TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
            NSArray * pickerArray = twoCell.textField1 == textField ? strongSelf.pickerDataModel.hourArray : strongSelf.pickerDataModel.minuteArray;
            funcVC.pickerView.pickerArray = pickerArray;
            funcVC.pickerView.currentIndex = [pickerArray containsObject:@([textField.text intValue])] ? [pickerArray indexOfObject:@([textField.text intValue])] : 0 ;
            [funcVC.pickerView show];
            funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
                textField.text = selectStr;
                if (twoCell.textField1 == textField) {
                    strongSelf.weatherSunTimeModel.sunsetHour    = [selectStr integerValue];
                }else {
                    strongSelf.weatherSunTimeModel.sunsetMinute = [selectStr integerValue];
                }
                textFieldModel.data = @[@(strongSelf.weatherSunTimeModel.sunsetHour),@(strongSelf.weatherSunTimeModel.sunsetMinute)];
                [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            };
        }
    };
}

- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        [funcVC showLoadingWithMessage:[NSString stringWithFormat:@"%@...",lang(@"setup")]];
        [IDOFoundationCommand setWeatherSunTimeCommand:strongSelf.weatherSunTimeModel
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

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    
    TextFieldCellModel * model2 = [[TextFieldCellModel alloc] init];
    model2.typeStr = @"twoTextField";
    model2.titleStr = lang(@"sunrise time");
    model2.data = @[@(self.weatherSunTimeModel.sunriseHour),@(self.weatherSunTimeModel.sunriseMinute)];
    model2.cellHeight = 70.0f;
    model2.cellClass = [TwoTextFieldTableViewCell class];
    model2.modelClass = [NSNull class];
    model2.isShowLine = YES;
    model2.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model2];
    
    TextFieldCellModel * model3 = [[TextFieldCellModel alloc] init];
    model3.typeStr = @"twoTextField";
    model3.titleStr = lang(@"sunset time");
    model3.data = @[@(self.weatherSunTimeModel.sunsetHour),@(self.weatherSunTimeModel.sunsetMinute)];
    model3.cellHeight = 70.0f;
    model3.cellClass = [TwoTextFieldTableViewCell class];
    model3.modelClass = [NSNull class];
    model3.isShowLine = YES;
    model3.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model3];
    
    EmpltyCellModel * model8 = [[EmpltyCellModel alloc]init];
    model8.typeStr = @"empty";
    model8.cellHeight = 30.0f;
    model8.isShowLine = YES;
    model8.cellClass  = [EmptyTableViewCell class];
    [cellModels addObject:model8];
    
    FuncCellModel * model9 = [[FuncCellModel alloc]init];
    model9.typeStr = @"oneButton";
    model9.data = @[lang(@"setup")];
    model9.cellHeight = 70.0f;
    model9.cellClass = [OneButtonTableViewCell class];
    model9.modelClass = [NSNull class];
    model9.isShowLine = YES;
    model9.buttconCallback = self.buttconCallback;
    [cellModels addObject:model9];
    
    self.cellModels = cellModels;
}

@end
