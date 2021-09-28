//
//  SetWorldTimeViewModel.m
//  IDOBlue
//
//  Created by xiongjie on 2021/8/11.
//  Copyright © 2021 hedongyang. All rights reserved.
//

#import "SetWorldTimeViewModel.h"
#import "SwitchCellModel.h"
#import "OneSwitchTableViewCell.h"
#import "TextFieldCellModel.h"
#import "TwoTextFieldTableViewCell.h"
#import "EmpltyCellModel.h"
#import "EmptyTableViewCell.h"
#import "FuncCellModel.h"
#import "OneButtonTableViewCell.h"
#import "OneTextFieldTableViewCell.h"
#import "ThreeTextFieldTableViewCell.h"
#import "FuncViewController.h"

@interface SetWorldTimeViewModel()

@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^switchCallback)(UIViewController * viewController,UISwitch * onSwitch,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^textFeildCallback)(UIViewController * viewController,UITextField * textField,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^textFeildDidEditCallback)(UIViewController * viewController,UITextField * textField,UITableViewCell * tableViewCell);
@property (nonatomic,copy) NSString * cityId;
@property (nonatomic,copy) NSString *cityName;
@property (nonatomic,copy) NSString *minuteOffset;

@end

@implementation SetWorldTimeViewModel


-(instancetype)init
{
    self = [super init];
    if (self)
    {
        [self getTextFieldCallback];
        [self getTextFeildDidEditCallback];
        [self getButtonCallback];
        [self getSwitchCallback];
        [self getCellModels];
        
    }
    
    return self;
}

-(void)setTimeItemModel:(IDOSetV3WorldTimeItemModel *)timeItemModel {
    _timeItemModel = timeItemModel;
    if (!_timeItemModel) {
        _timeItemModel = [[IDOSetV3WorldTimeItemModel alloc] init];
        _timeItemModel.cityId = 1;
    }else {
        FuncViewController * funcVC = (FuncViewController *)[IDODemoUtility getCurrentVC];
        [self getCellModels];
        [funcVC reloadData];
    }
}


- (void)getTextFeildDidEditCallback {
    __weak typeof(self) weakSelf = self;
    self.textFeildDidEditCallback = ^(UIViewController *viewController, UITextField *textField, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        if (indexPath.row == 0)
        {
            strongSelf.cityId = textField.text;
            TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
            strongSelf.timeItemModel.cityId = [textField.text integerValue];
            textFieldModel.data = @[@(strongSelf.timeItemModel.cityId)];
        }
        else if (indexPath.row == 1)
        {
            strongSelf.minuteOffset = textField.text;
            TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
            strongSelf.timeItemModel.minuteOffset = [textField.text integerValue];
            textFieldModel.data = @[@(strongSelf.timeItemModel.minuteOffset)];
        }
        else if (indexPath.row == 2)
        {
            strongSelf.cityName = textField.text;
            TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
            strongSelf.timeItemModel.cityName = textField.text;
            textFieldModel.data = @[strongSelf.timeItemModel.cityName];
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
        if (indexPath.row == 3)
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
                    strongSelf.timeItemModel.sunriseHour    = [selectStr integerValue];
                }else {
                    strongSelf.timeItemModel.sunriseMin  = [selectStr integerValue];
                }
                textFieldModel.data = @[@(strongSelf.timeItemModel.sunriseHour),@(strongSelf.timeItemModel.sunriseMin)];
                [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            };
        }
        else if (indexPath.row == 4)
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
                    strongSelf.timeItemModel.sunsetHour    = [selectStr integerValue];
                }else {
                    strongSelf.timeItemModel.sunsetMin = [selectStr integerValue];
                }
                textFieldModel.data = @[@(strongSelf.timeItemModel.sunsetHour),@(strongSelf.timeItemModel.sunsetMin)];
                [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            };
        }
        else if (indexPath.row == 6)   // 经度
        {
            TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
            funcVC.pickerView.pickerArray = strongSelf.pickerDataModel.hundredArray;
            funcVC.pickerView.currentIndex = [strongSelf.pickerDataModel.hundredArray containsObject:@([textField.text intValue])] ?
            [strongSelf.pickerDataModel.hundredArray indexOfObject:@([textField.text intValue])] : 0 ;
            [funcVC.pickerView show];
            funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
                textField.text = selectStr;
                textFieldModel.data = @[@([selectStr integerValue])];
                [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                strongSelf.timeItemModel.longitude  = [selectStr integerValue];
            };
        }
        else if (indexPath.row == 8)   // 纬度
        {
            TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
            funcVC.pickerView.pickerArray = strongSelf.pickerDataModel.hundredArray;
            funcVC.pickerView.currentIndex = [strongSelf.pickerDataModel.hundredArray containsObject:@([textField.text intValue])] ?
            [strongSelf.pickerDataModel.hundredArray indexOfObject:@([textField.text intValue])] : 0 ;
            [funcVC.pickerView show];
            funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
                textField.text = selectStr;
                textFieldModel.data = @[@([selectStr integerValue])];
                [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                strongSelf.timeItemModel.latitude  = [selectStr integerValue];
            };
        }
        
    };
}


- (int)convertToInt:(NSString*)strtemp
{
    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
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



- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;

        strongSelf.timeItemModel.cityNameLen = [strongSelf convertToInt:strongSelf.timeItemModel.cityName];
        
        if (strongSelf.addWorldTimeComplete) {
//            [funcVC showToastWithText:@"添加成功"];
            strongSelf.addWorldTimeComplete(YES, strongSelf.timeItemModel);
            [funcVC.navigationController popViewControllerAnimated:YES];
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
        if (indexPath.row == 3)
        {
            SwitchCellModel * switchCellModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
            strongSelf.timeItemModel.longitudeFlag = onSwitch.isOn?1:2;
            switchCellModel.data = @[@(strongSelf.timeItemModel.longitudeFlag == 1)];
        }
        else if (indexPath.row == 5)
        {
            SwitchCellModel * switchCellModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
            strongSelf.timeItemModel.latitudeFlag = onSwitch.isOn?1:2;
            switchCellModel.data = @[@(strongSelf.timeItemModel.latitudeFlag == 1)];
        }
    };
}



- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    
    TextFieldCellModel * model10 = [[TextFieldCellModel alloc]init];
    model10.typeStr = @"oneTextField";
    model10.titleStr = lang(@"city id");
    model10.data = @[@(self.timeItemModel.cityId)];
    model10.cellHeight = 70.0f;
    model10.cellClass = [OneTextFieldTableViewCell class];
    model10.modelClass = [NSNull class];
    model10.isShowLine = YES;
    model10.isShowKeyboard = YES;
    model10.keyType = UIKeyboardTypeNumberPad;
    model10.textFeildDidEditCallback  = self.textFeildDidEditCallback;
    [cellModels addObject:model10];
    
    
    TextFieldCellModel * model11 = [[TextFieldCellModel alloc]init];
    model11.typeStr = @"oneTextField";
    model11.titleStr = lang(@"the offset minute between the current time and the 0 time zone");
    model11.data = @[@(self.timeItemModel.minuteOffset)];
    model11.cellHeight = 70.0f;
    model11.cellClass = [OneTextFieldTableViewCell class];
    model11.modelClass = [NSNull class];
    model11.isShowLine = YES;
    model11.isShowKeyboard = YES;
    model11.keyType = UIKeyboardTypeNumberPad;
    model11.textFeildDidEditCallback = self.textFeildDidEditCallback;
    [cellModels addObject:model11];
    
    TextFieldCellModel * model1 = [[TextFieldCellModel alloc]init];
    model1.typeStr = @"oneTextField";
    model1.titleStr = lang(@"city name");
    model1.data = @[self.timeItemModel.cityName?:@""];
    model1.cellHeight = 70.0f;
    model1.cellClass = [OneTextFieldTableViewCell class];
    model1.modelClass = [NSNull class];
    model1.isShowLine = YES;
    model1.isShowKeyboard = YES;
    model1.keyType = UIKeyboardTypeDefault;
    model1.textFeildDidEditCallback = self.textFeildDidEditCallback;
    [cellModels addObject:model1];
    
    
   
    TextFieldCellModel * model2 = [[TextFieldCellModel alloc] init];
    model2.typeStr = @"twoTextField";
    model2.titleStr = lang(@"sunrise time");
    model2.data = @[@(self.timeItemModel.sunriseHour),@(self.timeItemModel.sunriseMin)];
    model2.cellHeight = 70.0f;
    model2.cellClass = [TwoTextFieldTableViewCell class];
    model2.modelClass = [NSNull class];
    model2.isShowLine = YES;
    model2.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model2];
    
    
    TextFieldCellModel * model3 = [[TextFieldCellModel alloc] init];
    model3.typeStr = @"twoTextField";
    model3.titleStr = lang(@"sunset time");
    model3.data = @[@(self.timeItemModel.sunsetHour),@(self.timeItemModel.sunsetMin)];
    model3.cellHeight = 70.0f;
    model3.cellClass = [TwoTextFieldTableViewCell class];
    model3.modelClass = [NSNull class];
    model3.isShowLine = YES;
    model3.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model3];
    
   
    SwitchCellModel * model4 = [[SwitchCellModel alloc]init];
    model4.typeStr = @"oneSwitch";
    model4.titleStr = lang(@"is it the east longitude");
    model4.data = @[@(self.timeItemModel.longitudeFlag == 1)];
    model4.cellHeight = 70.0f;
    model4.cellClass = [OneSwitchTableViewCell class];
    model4.modelClass = [NSNull class];
    model4.isShowLine = YES;
    model4.switchCallback = self.switchCallback;
    [cellModels addObject:model4];
    
    
    TextFieldCellModel * model5 = [[TextFieldCellModel alloc]init];
    model5.typeStr = @"oneTextField";
    model5.titleStr =lang(@"longitude");
    model5.data = @[@(self.timeItemModel.longitude)?:@""];
    model5.cellHeight = 70.0f;
    model5.cellClass = [OneTextFieldTableViewCell class];
    model5.modelClass = [NSNull class];
    model5.isShowLine = YES;
    model5.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model5];
    
    
    SwitchCellModel * model6 = [[SwitchCellModel alloc]init];
    model6.typeStr = @"oneSwitch";
    model6.titleStr = lang(@"is it north latitude");
    model6.data = @[@(self.timeItemModel.latitudeFlag == 1)];
    model6.cellHeight = 70.0f;
    model6.cellClass = [OneSwitchTableViewCell class];
    model6.modelClass = [NSNull class];
    model6.isShowLine = YES;
    model6.switchCallback = self.switchCallback;
    [cellModels addObject:model6];
    
    
    TextFieldCellModel * model7 = [[TextFieldCellModel alloc]init];
    model7.typeStr = @"oneTextField";
    model7.titleStr = lang(@"latitude");
    model7.data = @[@(self.timeItemModel.latitude)?:@""];
    model7.cellHeight = 70.0f;
    model7.cellClass = [OneTextFieldTableViewCell class];
    model7.modelClass = [NSNull class];
    model7.isShowLine = YES;
    model7.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model7];
    

    EmpltyCellModel * model8 = [[EmpltyCellModel alloc]init];
    model8.typeStr = @"empty";
    model8.cellHeight = 30.0f;
    model8.isShowLine = YES;
    model8.cellClass  = [EmptyTableViewCell class];
    [cellModels addObject:model8];
    
    
    FuncCellModel * model9 = [[FuncCellModel alloc]init];
    model9.typeStr = @"oneButton";
    model9.data = @[@"setup"];
    model9.cellHeight = 70.0f;
    model9.cellClass = [OneButtonTableViewCell class];
    model9.modelClass = [NSNull class];
    model9.isShowLine = YES;
    model9.buttconCallback = self.buttconCallback;
    [cellModels addObject:model9];
    
    self.cellModels = cellModels;
}

@end
