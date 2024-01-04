//
//  SetV3Weather.m
//  IDOBlue
//
//  Created by xiongjie on 2021/8/13.
//  Copyright © 2021 hedongyang. All rights reserved.
//

#import "SetV3WeatherViewModel.h"
#import "TextFieldCellModel.h"
#import "OneTextFieldTableViewCell.h"
#import "TwoTextFieldTableViewCell.h"
#import "EmpltyCellModel.h"
#import "EmptyTableViewCell.h"
#import "FuncCellModel.h"
#import "OneButtonTableViewCell.h"
#import "FuncViewController.h"


@interface SetV3WeatherViewModel()

@property(nonatomic,strong) IDOSetV3WeatherDataModel *weatherDataModel;
@property (nonatomic,strong) NSArray * dataArray;
@property (nonatomic,strong) NSArray * titleArray;

@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^textFeildCallback)(UIViewController * viewController,UITextField * textField,UITableViewCell * tableViewCell);
@property (nonatomic,strong) UITextField * textField;

@end


@implementation SetV3WeatherViewModel

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


- (IDOSetV3WeatherDataModel *)weatherDataModel
{
    if (!_weatherDataModel) {
         _weatherDataModel = [IDOSetV3WeatherDataModel currentModel];

        
        _weatherDataModel.weatherType = 1;
        _weatherDataModel.todayUvIntensity=4;
        _weatherDataModel.sunsetMin= 39;
        _weatherDataModel.pk= 0;
        _weatherDataModel.humidity= 53;
        _weatherDataModel.cityName= @"Shenzhen";
        _weatherDataModel.sunriseHour=6;
        _weatherDataModel.snowDepthMin= 0;
        _weatherDataModel.windSpeed= 0;
        _weatherDataModel.moonriseHour= 0;
        _weatherDataModel.moonPhase= 0;
        _weatherDataModel.snowDepth= 0;
        _weatherDataModel.moonsetHour= 0;
        _weatherDataModel.cityNameLen= 9;
        _weatherDataModel.airQuality= 56;
        _weatherDataModel.atmosphericPressure= 0;
        _weatherDataModel.precipitationProbability= 7;
        _weatherDataModel.sunriseMin= 40;
        _weatherDataModel.moonriseMin= 0;
        _weatherDataModel.snowDepthMax= 0;
        _weatherDataModel.migrationState= 0;
        _weatherDataModel.airGradeInfo=@"中等";
        _weatherDataModel.snowfall= 0;
        _weatherDataModel.weatherVersion= 1;
        _weatherDataModel.moonsetMin=0;
        _weatherDataModel.sunsetHour = 17;
        
        IDOSetTimeInfoBluetoothModel*timeModel = [IDOSetTimeInfoBluetoothModel currentModel];
        _weatherDataModel.month= timeModel.month;
        _weatherDataModel.day= timeModel.day;
        _weatherDataModel.hour= timeModel.hour;
        _weatherDataModel.min= timeModel.minute;
        _weatherDataModel.sec= timeModel.second;
        _weatherDataModel.week= timeModel.weekDay;
        
        NSInteger todayTmp = 100+24;//Temperature value = current temperature + 100 (compatible with devices)
        NSInteger todayMinTemp = 100+18;//Temperature value = current temperature + 100 (compatible with devices)
        NSInteger todayMaxTemp = 100+27;//Temperature value = current temperature + 100 (compatible with devices)
        _weatherDataModel.todayTmp = todayTmp;
        _weatherDataModel.todayMinTemp = todayMinTemp;
        _weatherDataModel.todayMaxTemp = todayMaxTemp;
        
        // 24、48 小时天气 模拟数据 | 24/48 hour weather simulation data
        NSMutableArray * hourWeaArray = [NSMutableArray arrayWithCapacity:0];
        for (int i = 0; i < 48; i ++)
        {
            IDOFuture24HourWeatherModel * wModel = [[IDOFuture24HourWeatherModel alloc] init];
            wModel.weatherType = 1;
            wModel.pk = 0;
            if (i == 0) {
                wModel.temperature = todayTmp;
            }else{
                wModel.temperature = 100+i;// 温度赋值 = 当前温度 + 100 |  Temperature value = current temperature + 100 (compatible with devices)
            }
           
            wModel.probability = 7;
            wModel.migrationState = 0;
            [hourWeaArray addObject:wModel];
        }
        self.weatherDataModel.future24HoursItems = hourWeaArray;
        
        // 未来7天的天气 模拟数据 | Weather simulation data for the next 7 days
        NSMutableArray * futureWeaArray = [NSMutableArray arrayWithCapacity:0];
        for (int i = 0; i < 7; i ++)
        {
            IDOFuture7DayWeatherDataModel * fModel = [[IDOFuture7DayWeatherDataModel alloc] init];
            fModel.weatherType = 1;
            // 温度赋值 = 当前温度 + 100 |  Temperature value = current temperature + 100 (compatible with devices)
            fModel.maxTemp = 100+(20+i);
            // 温度赋值 = 当前温度 + 100 |  Temperature value = current temperature + 100 (compatible with devices)
            fModel.minTemp = 100+(10+i);
            fModel.pk = 0;
            fModel.migrationState = 0;
            [futureWeaArray addObject:fModel];
        }
        self.weatherDataModel.future7DaysItems = futureWeaArray;
        
        // 未来三天日出日落 模拟数据
        NSMutableArray * futureSunriseArray = [NSMutableArray arrayWithCapacity:0];
        for (int i = 0; i < 4; i ++)
        {
            IDOFutureSunriseWeatherDataItems * model = [[IDOFutureSunriseWeatherDataItems alloc] init];
            model.sunriseHour = 6;
            model.sunriseMin = i+1;
            model.sunsetHour = 17;
            model.sunsetMin = 39;
            model.pk = 0;
            model.migrationState = 0;
            [futureSunriseArray addObject:model];
        }
        
        self.weatherDataModel.futureSunriseItems = futureSunriseArray;

        
    }
    return _weatherDataModel;
}

- (NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = @[@(self.weatherDataModel.weatherType),
                       @(self.weatherDataModel.todayTmp),
                       @(self.weatherDataModel.todayMaxTemp),
                       @(self.weatherDataModel.todayMinTemp),
                       @(self.weatherDataModel.airQuality),
                       @(self.weatherDataModel.precipitationProbability),
                       @(self.weatherDataModel.humidity),
                       @(self.weatherDataModel.todayUvIntensity),
                       @(self.weatherDataModel.windSpeed),
                       @(self.weatherDataModel.week),
                      ];
    }
    return _dataArray;
}


- (NSArray *)titleArray
{
    if (!_titleArray)
    {
        _titleArray = @[lang(@"weather type"),
                        lang(@"current v3 weather"),
                        lang(@"max v3 weather"),
                        lang(@"min v3 weather"),
                        lang(@"air quality"),
                        lang(@"Precipitation probability"),
                        lang(@"humidity"),
                        lang(@"uv intensity"),
                        lang(@"wind speed"),
                        lang(@"week"),
        ];
    }
    return _titleArray;
}

- (int)convertToInt:(NSString*)strtemp
{
    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding];i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }

    }
    return strlength;
}


- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    
    for (int i = 0; i < self.titleArray.count; i++)
    {
        TextFieldCellModel * model = [[TextFieldCellModel alloc]init];
        model.typeStr = @"oneTextField";
        model.titleStr = self.titleArray[i];
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
    
    TextFieldCellModel * model1 = [[TextFieldCellModel alloc] init];
    model1.typeStr = @"twoTextField";
    model1.titleStr = lang(@"month day");
    model1.data = @[@(self.weatherDataModel.month),@(self.weatherDataModel.day)];
    model1.cellHeight = 70.0f;
    model1.cellClass = [TwoTextFieldTableViewCell class];
    model1.modelClass = [NSNull class];
    model1.isShowLine = YES;
    model1.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model1];
    
    TextFieldCellModel * model2 = [[TextFieldCellModel alloc] init];
    model2.typeStr = @"twoTextField";
    model2.titleStr = lang(@"sunrise time");
    model2.data = @[@(self.weatherDataModel.sunriseHour),@(self.weatherDataModel.sunriseMin)];
    model2.cellHeight = 70.0f;
    model2.cellClass = [TwoTextFieldTableViewCell class];
    model2.modelClass = [NSNull class];
    model2.isShowLine = YES;
    model2.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model2];
    
    TextFieldCellModel * model3 = [[TextFieldCellModel alloc] init];
    model3.typeStr = @"twoTextField";
    model3.titleStr = lang(@"sunset time");
    model3.data = @[@(self.weatherDataModel.sunsetHour),@(self.weatherDataModel.sunsetMin)];
    model3.cellHeight = 70.0f;
    model3.cellClass = [TwoTextFieldTableViewCell class];
    model3.modelClass = [NSNull class];
    model3.isShowLine = YES;
    model3.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model3];
    
    TextFieldCellModel * model4 = [[TextFieldCellModel alloc]init];
    model4.typeStr = @"oneTextField";
    model4.titleStr = lang(@"city name");
    model4.data = @[self.weatherDataModel.cityName?:@""];
    model4.cellHeight = 70.0f;
    model4.cellClass = [OneTextFieldTableViewCell class];
    model4.modelClass = [NSNull class];
    model4.isShowLine = YES;
    model4.isShowKeyboard = YES;
    model4.keyType = UIKeyboardTypeDefault;
    model4.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model4];
    
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
    
    
    self.cellModels = cellModels;
}

- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;

        [funcVC showLoadingWithMessage:lang(@"set weather forecast data...")];
        
        IDOSetWeatherSwitchInfoBluetoothModel*switchInfoBluetoothModel = [IDOSetWeatherSwitchInfoBluetoothModel currentModel];
        switchInfoBluetoothModel.isOpen = YES;
        
        [IDOFoundationCommand setWeatherCommand:switchInfoBluetoothModel callback:^(int errorCode) {
            if (errorCode == 0) {
                [IDOFoundationCommand setV3WeatcherDataCommand:strongSelf.weatherDataModel callback:^(int errorCode) {
                    if(errorCode == 0) {
                        [funcVC showToastWithText:lang(@"set weather data success")];
                    }else if (errorCode == 6) {
                        [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
                    }else {
                        [funcVC showToastWithText:lang(@"set weather data failed")];
                    }
                }];
            }
            
        }];
        
    };
}



- (void)getTextFieldCallback
{
    __weak typeof(self) weakSelf = self;
    self.textFeildCallback = ^(UIViewController *viewController, UITextField *textField, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        
        if (indexPath.row < 10)
        {
            TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
            NSArray * dataArray = [NSArray array];
            if(textFieldModel.index == 0) {
                dataArray = strongSelf.pickerDataModel.weatherArray;
            }else if (textFieldModel.index <= 3 && textFieldModel.index > 0) {
                dataArray = strongSelf.pickerDataModel.tempV3Array;
            }else if (textFieldModel.index == 9){
                dataArray = strongSelf.pickerDataModel.weekArray;
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
                if (indexPath.row == 0 || indexPath.row == 9) {
                    textFieldModel.data = @[selectStr];
                }else {
                    textFieldModel.data = @[@([selectStr integerValue])];
                }
                [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                if (textFieldModel.index == 0) {
                    strongSelf.weatherDataModel.weatherType  = [dataArray containsObject:selectStr] ? [dataArray indexOfObject:selectStr] : 0 ;
                }else if (textFieldModel.index == 1) {
                    strongSelf.weatherDataModel.todayTmp  = [selectStr integerValue];
                }else if (textFieldModel.index == 2) {
                    strongSelf.weatherDataModel.todayMaxTemp  = [selectStr integerValue];
                }else if (textFieldModel.index == 3) {
                    strongSelf.weatherDataModel.todayMinTemp  = [selectStr integerValue];
                }else if (textFieldModel.index == 4) {
                    strongSelf.weatherDataModel.airQuality  = [selectStr integerValue];
                }else if (textFieldModel.index == 5) {
                    strongSelf.weatherDataModel.precipitationProbability  = [selectStr integerValue];
                }else if (textFieldModel.index == 6) {
                    strongSelf.weatherDataModel.humidity  = [selectStr integerValue];
                }else if (textFieldModel.index == 7) {
                    strongSelf.weatherDataModel.todayUvIntensity  = [selectStr integerValue];
                }else if (textFieldModel.index == 8) {
                    strongSelf.weatherDataModel.windSpeed  = [selectStr integerValue];
                }else if (textFieldModel.index == 9) {
                    strongSelf.weatherDataModel.week  = [dataArray containsObject:selectStr] ? [dataArray indexOfObject:selectStr] : 0 ;
                }
            };
        }
        else if (indexPath.row == 10)  //月日
        {
            TwoTextFieldTableViewCell * twoCell = (TwoTextFieldTableViewCell *)tableViewCell;
            TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
            NSArray * pickerArray = twoCell.textField1 == textField ? strongSelf.pickerDataModel.monthArray : strongSelf.pickerDataModel.dayArray;
            funcVC.pickerView.pickerArray = pickerArray;
            funcVC.pickerView.currentIndex = [pickerArray containsObject:@([textField.text intValue])] ? [pickerArray indexOfObject:@([textField.text intValue])] : 0 ;
            [funcVC.pickerView show];
            funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
                textField.text = selectStr;
                if (twoCell.textField1 == textField) {
                    strongSelf.weatherDataModel.month = [selectStr integerValue];
                }else {
                    strongSelf.weatherDataModel.day = [selectStr integerValue];
                }
                textFieldModel.data = @[@(strongSelf.weatherDataModel.month),@(strongSelf.weatherDataModel.day)];
                [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            };
        }
        else if (indexPath.row == 11)  //日出
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
                    strongSelf.weatherDataModel.sunriseHour    = [selectStr integerValue];
                }else {
                    strongSelf.weatherDataModel.sunriseMin = [selectStr integerValue];
                }
                textFieldModel.data = @[@(strongSelf.weatherDataModel.sunriseHour),@(strongSelf.weatherDataModel.sunriseMin)];
                [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            };
        }
        else if (indexPath.row == 12)  //日落
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
                    strongSelf.weatherDataModel.sunsetHour    = [selectStr integerValue];
                }else {
                    strongSelf.weatherDataModel.sunsetMin = [selectStr integerValue];
                }
                textFieldModel.data = @[@(strongSelf.weatherDataModel.sunsetHour),@(strongSelf.weatherDataModel.sunsetMin)];
                [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            };
        }
        else if (indexPath.row == 13)  // 城市名称
        {
            strongSelf.textField = textField;
            
        }
    };
}

@end
