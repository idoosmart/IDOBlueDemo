//
//  SetCityNameViewModel.m
//  IDOBlue
//
//  Created by 何东阳 on 2019/12/27.
//  Copyright © 2019 hedongyang. All rights reserved.
//

#import "SetCityNameViewModel.h"
#import "FuncViewController.h"
#import "OneTextFieldTableViewCell.h"
#import "EmptyTableViewCell.h"
#import "OneButtonTableViewCell.h"
#import "TextFieldCellModel.h"
#import "EmpltyCellModel.h"
#import "FuncCellModel.h"

@interface SetCityNameViewModel()
@property (nonatomic,copy)void(^textFeildCallback)(UIViewController * viewController,UITextField * textField,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,strong) UITextField * textField;
@end

@implementation SetCityNameViewModel

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

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    TextFieldCellModel * model1 = [[TextFieldCellModel alloc]init];
    model1.typeStr = @"oneTextField";
    model1.titleStr = [NSString stringWithFormat:@"%@ :",lang(@"set weather city name")];
    model1.data = @[@""];
    model1.cellHeight = 70.0f;
    model1.cellClass = [OneTextFieldTableViewCell class];
    model1.modelClass = [NSNull class];
    model1.isShowLine = YES;
    model1.isShowKeyboard = YES;
    model1.keyType = UIKeyboardTypeDefault;
    model1.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model1];
    
    EmpltyCellModel * model2 = [[EmpltyCellModel alloc]init];
    model2.typeStr = @"empty";
    model2.cellHeight = 30.0f;
    model2.isShowLine = YES;
    model2.cellClass  = [EmptyTableViewCell class];
    [cellModels addObject:model2];
    
    FuncCellModel * model3 = [[FuncCellModel alloc]init];
    model3.typeStr = @"oneButton";
    model3.data = @[lang(@"set weather city name")];
    model3.cellHeight = 70.0f;
    model3.cellClass  = [OneButtonTableViewCell class];
    model3.modelClass = [NSNull class];
    model3.isShowLine = YES;
    model3.buttconCallback = self.buttconCallback;
    [cellModels addObject:model3];
    self.cellModels = cellModels;
}

- (void)getTextFieldCallback
{
    __weak typeof(self) weakSelf = self;
    self.textFeildCallback = ^(UIViewController *viewController, UITextField *textField, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        __block FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        if (indexPath.row == 0) {
            strongSelf.textField = textField;
        }
    };
}

- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        [funcVC showLoadingWithMessage:[NSString stringWithFormat:@"%@...",lang(@"set weather city name")]];
        IDOSetWeatherDataInfoBluetoothModel * model = [IDOSetWeatherDataInfoBluetoothModel currentModel];
        NSDictionary * dic = @{@"today":model,
                               @"city":strongSelf.textField.text?:@"",
                               @"oneHourWeather":[strongSelf get24HourWeatherData]};
        [IDOFoundationCommand setWeatherDataExtensionCommand:dic callback:^(int errorCode) {
            if (errorCode == 0) {
               [funcVC showToastWithText:lang(@"set weather city name success")];
            }else {
               [funcVC showToastWithText:lang(@"set weather city name failed")];
            }
        }];
    };
}

- (NSArray *)get24HourWeatherData
{
    NSMutableArray * array = [NSMutableArray array];
    for (int i = 0; i < 24; i++) {
        NSInteger temp = [self getRandomNumber:0 to:40];
        NSInteger type = [self getRandomNumber:1 to:19];
        NSDictionary * dic = @{@"temp":@(temp),@"type":@(type)};
        [array addObject:dic];
    }
    return array;
}

 - (int)getRandomNumber:(int)from to:(int)to
{
   return (int)(from+(arc4random()%(to-from + 1)));
}

@end