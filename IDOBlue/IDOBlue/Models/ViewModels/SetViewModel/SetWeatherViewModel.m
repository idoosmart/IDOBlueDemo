//
//  SetWeatherViewModel.m
//  IDOBlue
//
//  Created by hedongyang on 2018/9/27.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "SetWeatherViewModel.h"
#import "SwitchCellModel.h"
#import "OneSwitchTableViewCell.h"
#import "TextFieldCellModel.h"
#import "OneTextFieldTableViewCell.h"
#import "TwoTextFieldTableViewCell.h"
#import "EmpltyCellModel.h"
#import "EmptyTableViewCell.h"
#import "FuncCellModel.h"
#import "OneButtonTableViewCell.h"
#import "LabelCellModel.h"
#import "OneLabelTableViewCell.h"
#import "FuncViewController.h"


@interface SetWeatherViewModel()
@property (nonatomic,strong)IDOSetWeatherSwitchInfoBluetoothModel * weatherSwitchModel;
@property (nonatomic,strong)IDOSetWeatherDataInfoBluetoothModel  * weatherDataModel;
@property (nonatomic,strong) NSArray * dataArray;
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^switchCallback)(UIViewController * viewController,UISwitch * onSwitch,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^textFeildCallback)(UIViewController * viewController,UITextField * textField,UITableViewCell * tableViewCell);
@end

@implementation SetWeatherViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getTextFieldCallback];
        [self getSwitchCallback];
        [self getButtonCallback];
        [self getCellModels];
    }
    return self;
}

- (IDOSetWeatherSwitchInfoBluetoothModel *)weatherSwitchModel
{
    if (!_weatherSwitchModel) {
        _weatherSwitchModel = [IDOSetWeatherSwitchInfoBluetoothModel currentModel];
    }
    return _weatherSwitchModel;
}

- (IDOSetWeatherDataInfoBluetoothModel *)weatherDataModel
{
    if (!_weatherDataModel) {
        _weatherDataModel = [IDOSetWeatherDataInfoBluetoothModel currentModel];
    }
    return _weatherDataModel;
}

- (NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = @[@(self.weatherDataModel.todayType),@(self.weatherDataModel.todayTemp),@(self.weatherDataModel.todayMaxTemp),@(self.weatherDataModel.todayMinTemp),
                       @(self.weatherDataModel.humidity),@(self.weatherDataModel.todayUvIntensity),@(self.weatherDataModel.todayAqi)];
    }
    return _dataArray;
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    if (!self.weatherSwitchModel.isOpen) {
        SwitchCellModel * model1 = [[SwitchCellModel alloc]init];
        model1.typeStr = @"oneSwitch";
        model1.titleStr = lang(@"set weather forecast switch");
        model1.data = @[@(self.weatherSwitchModel.isOpen)];
        model1.cellHeight = 70.0f;
        model1.cellClass = [OneSwitchTableViewCell class];
        model1.modelClass = [NSNull class];
        model1.isShowLine = YES;
        model1.switchCallback = self.switchCallback;
        [cellModels addObject:model1];
        
        EmpltyCellModel * model2 = [[EmpltyCellModel alloc]init];
        model2.typeStr = @"empty";
        model2.cellHeight = 30.0f;
        model2.isShowLine = YES;
        model2.cellClass  = [EmptyTableViewCell class];
        [cellModels addObject:model2];
        
        FuncCellModel * model3 = [[FuncCellModel alloc]init];
        model3.typeStr = @"oneButton";
        model3.data = @[lang(@"set weather forecast button")];
        model3.cellHeight = 70.0f;
        model3.cellClass = [OneButtonTableViewCell class];
        model3.modelClass = [NSNull class];
        model3.isShowLine = YES;
        model3.buttconCallback = self.buttconCallback;
        [cellModels addObject:model3];
    }else {
        for (int i = 0; i < self.pickerDataModel.weatherTitleArray.count; i++) {
            TextFieldCellModel * model = [[TextFieldCellModel alloc]init];
            model.typeStr = @"oneTextField";
            model.titleStr = self.pickerDataModel.weatherTitleArray[i];
            if (i == 0) {
                NSInteger index = [self.dataArray[i] integerValue];
                model.data = @[self.pickerDataModel.weatherArray[index]];
            }else {
                model.data = @[self.dataArray[i]];
            }
            model.cellHeight = 70.0f;
            model.cellClass = [OneTextFieldTableViewCell class];
            model.modelClass = [NSNull class];
            model.isShowLine = YES;
            model.index = i;
            model.textFeildCallback = self.textFeildCallback;
            [cellModels addObject:model];
        }
        
        EmpltyCellModel * model6 = [[EmpltyCellModel alloc]init];
        model6.typeStr = @"empty";
        model6.cellHeight = 30.0f;
        model6.isShowLine = YES;
        model6.cellClass  = [EmptyTableViewCell class];
        [cellModels addObject:model6];
        
        FuncCellModel * model7 = [[FuncCellModel alloc]init];
        model7.typeStr = @"oneButton";
        model7.data = @[lang(@"set weather data")];
        model7.cellHeight = 70.0f;
        model7.cellClass = [OneButtonTableViewCell class];
        model7.modelClass = [NSNull class];
        model7.isShowLine = YES;
        model7.buttconCallback = self.buttconCallback;
        [cellModels addObject:model7];
    }
    //后三天天气模拟数据
    NSDictionary * dic1 = @{@"type":@(10),@"maxTemp":@(30),@"minTemp":@(18)};
    NSDictionary * dic2 = @{@"type":@(15),@"maxTemp":@(33),@"minTemp":@(26)};
    NSDictionary * dic3 = @{@"type":@(17),@"maxTemp":@(31),@"minTemp":@(20)};
    NSArray * weathers = @[dic1,dic2,dic3];
    self.weatherDataModel.future = weathers;
    
    self.cellModels = cellModels;
}

- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        if (indexPath.row == 2) {
            [funcVC showLoadingWithMessage:lang(@"set weather forecast switch...")];
            [IDOFoundationCommand setWeatherCommand:strongSelf.weatherSwitchModel
                                          callback:^(int errorCode) {
                  if(errorCode == 0) {
                      [funcVC showToastWithText:lang(@"set weather forecast success")];
                      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                          strongSelf.weatherSwitchModel = [IDOSetWeatherSwitchInfoBluetoothModel currentModel];
                          [strongSelf getCellModels];
                          [funcVC reloadData];
                      });
                  }else if (errorCode == 6) {
                      [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
                  }else {
                      [funcVC showToastWithText:lang(@"set weather forecast failed")];
                  }
            }];
        }else {
            [funcVC showLoadingWithMessage:lang(@"set weather forecast data...")];
            [IDOFoundationCommand setWeatherDataCommand:strongSelf.weatherDataModel
                                              callback:^(int errorCode) {
                  if(errorCode == 0) {
                      [funcVC showToastWithText:lang(@"set weather data success")];
                  }else if (errorCode == 6) {
                      [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
                  }else {
                      [funcVC showToastWithText:lang(@"set weather data failed")];
                  }
            }];
        }
    };
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
            strongSelf.weatherSwitchModel.isOpen = onSwitch.isOn;
            switchCellModel.data = @[@(strongSelf.weatherSwitchModel.isOpen)];
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
        NSArray * dataArray = [NSArray array];
        if(textFieldModel.index == 0) {
            dataArray = strongSelf.pickerDataModel.weatherArray;
        }else if (textFieldModel.index <= 2 && textFieldModel.index > 0) {
            dataArray = strongSelf.pickerDataModel.tempArray;
        }else {
            dataArray = strongSelf.pickerDataModel.tenArray;
        }
        funcVC.pickerView.pickerArray = dataArray;
        if (indexPath.row == 0) {
            funcVC.pickerView.currentIndex = [dataArray containsObject:textField.text] ? [dataArray indexOfObject:textField.text] : 0 ;
        }else {
            funcVC.pickerView.currentIndex = [dataArray containsObject:@([textField.text intValue])] ?
            [dataArray indexOfObject:@([textField.text intValue])] : 0 ;
        }
        [funcVC.pickerView show];
        funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
            textField.text = selectStr;
            if (indexPath.row == 0) {
                textFieldModel.data = @[selectStr];
            }else {
                textFieldModel.data = @[@([selectStr integerValue])];
            }
            [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            if (textFieldModel.index == 0) {
                strongSelf.weatherDataModel.todayType  = [dataArray containsObject:selectStr] ? [dataArray indexOfObject:selectStr] : 0 ;
            }else if (textFieldModel.index == 1) {
                strongSelf.weatherDataModel.todayTemp  = [selectStr integerValue];
            }else if (textFieldModel.index == 2) {
                strongSelf.weatherDataModel.todayMaxTemp  = [selectStr integerValue];
            }else if (textFieldModel.index == 3) {
                strongSelf.weatherDataModel.todayMinTemp  = [selectStr integerValue];
            }else if (textFieldModel.index == 4) {
                strongSelf.weatherDataModel.humidity  = [selectStr integerValue];
            }else if (textFieldModel.index == 5) {
                strongSelf.weatherDataModel.todayUvIntensity  = [selectStr integerValue];
            }else if (textFieldModel.index == 6) {
                strongSelf.weatherDataModel.todayAqi  = [selectStr integerValue];
            }
        };
    };
}

@end
