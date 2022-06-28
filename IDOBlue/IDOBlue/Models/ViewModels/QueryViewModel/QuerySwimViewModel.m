//
//  QuerySwimViewModel.m
//  IDOBlue
//
//  Created by hedongyang on 2022/6/22.
//  Copyright © 2022 hedongyang. All rights reserved.
//

#import "QuerySwimViewModel.h"
#import "TextFieldCellModel.h"
#import "FuncCellModel.h"
#import "TextViewCellModel.h"
#import "EmpltyCellModel.h"
#import "ThreeTextFieldTableViewCell.h"
#import "OneButtonTableViewCell.h"
#import "EmptyTableViewCell.h"
#import "FuncViewController.h"
#import "OneTextViewTableViewCell.h"
#import "NSObject+ModelToDic.h"

@interface QuerySwimViewModel ()
@property (nonatomic,strong) UITextView * textView;
@property (nonatomic,copy)void(^textFeildCallback)(UIViewController * viewController,UITextField * textField,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^textViewCallback)(UITextView * textView);
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,assign) NSInteger year;
@property (nonatomic,assign) NSInteger month;
@property (nonatomic,assign) NSInteger day;
@property (nonatomic,assign) NSInteger hour;
@property (nonatomic,assign) NSInteger minute;
@property (nonatomic,assign) NSInteger second;
@end

@implementation QuerySwimViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getButtonCallback];
        [self getTextViewCallback];
        [self getTextFieldCallback];
        [self getCellModels];
    }
    return self;
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    
    IDOSetTimeInfoBluetoothModel * time = [[IDOSetTimeInfoBluetoothModel alloc]init];
    self.year = time.year;
    self.month = time.month;
    self.day = time.day;
    self.hour = time.hour;
    self.minute = time.minute;
    self.second = time.second;
    TextFieldCellModel * model1 = [[TextFieldCellModel alloc]init];
    model1.typeStr = @"threeTextField";
    model1.titleStr = lang(@"date:");
    model1.data = @[@(time.year),@(time.month),@(time.day)];
    model1.cellHeight = 70.0f;
    model1.cellClass = [ThreeTextFieldTableViewCell class];
    model1.modelClass = [NSNull class];
    model1.isShowLine = YES;
    model1.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model1];
    
    TextFieldCellModel * model2 = [[TextFieldCellModel alloc]init];
    model2.typeStr = @"threeTextField";
    model2.titleStr = lang(@"time:");
    model2.data = @[@(time.hour),@(time.minute),@(time.second)];
    model2.cellHeight = 70.0f;
    model2.cellClass = [ThreeTextFieldTableViewCell class];
    model2.modelClass = [NSNull class];
    model2.isShowLine = YES;
    model2.isShowKeyboard = YES;
    model2.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model2];
    
    FuncCellModel * model3 = [[FuncCellModel alloc]init];
    model3.typeStr = @"oneButton";
    model3.data    = @[lang(@"one timestamp query")];
    model3.cellHeight = 70.0f;
    model3.cellClass  = [OneButtonTableViewCell class];
    model3.modelClass = [NSNull class];
    model3.buttconCallback = self.buttconCallback;
    [cellModels addObject:model3];
    
    FuncCellModel * model4 = [[FuncCellModel alloc]init];
    model4.typeStr = @"oneButton";
    model4.data    = @[lang(@"one date query")];
    model4.cellHeight = 70.0f;
    model4.cellClass  = [OneButtonTableViewCell class];
    model4.modelClass = [NSNull class];
    model4.buttconCallback = self.buttconCallback;
    [cellModels addObject:model4];
    
    FuncCellModel * model6 = [[FuncCellModel alloc]init];
    model6.typeStr = @"oneButton";
    model6.data    = @[lang(@"all data query")];
    model6.cellHeight = 70.0f;
    model6.cellClass  = [OneButtonTableViewCell class];
    model6.modelClass = [NSNull class];
    model6.buttconCallback = self.buttconCallback;
    [cellModels addObject:model6];
    
    TextViewCellModel * model5 = [[TextViewCellModel alloc]init];
    model5.typeStr = @"oneTextView";
    model5.data = @[@""];
    model5.textViewCallback = self.textViewCallback;
    model5.cellHeight = 310;
    model5.isShowLine = YES;
    model5.cellClass  = [OneTextViewTableViewCell class];
    [cellModels addObject:model5];
   
    self.cellModels = cellModels;
}

- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVc = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVc.tableView indexPathForCell:tableViewCell];
        if (indexPath.row == 2) { //查询时间戳数据
            [strongSelf querySwimTimeStampDataWtithVc:funcVc];
        }else if (indexPath.row == 3) { //查询日期数据
            [strongSelf queryDateDataWtithVc:funcVc];
        }else if (indexPath.row == 4) { //查询所有数据
            [strongSelf queryAllDataWithVc:funcVc];
        }
    };
}

- (void)querySwimTimeStampDataWtithVc:(FuncViewController *)funcVc
{
    if (!__IDO_FUNCTABLE__.funcTable22Model.v3SwimData) {
        [funcVc showToastWithText:lang(@"feature is not supported on the current device")];
        return;
    }
    NSString * timeStr = [NSString stringWithFormat:@"%.4d-%.2d-%.2d %.2d:%.2d:%.2d",self.year,self.month,self.day,self.hour,self.minute,self.second];
    NSString * timeStamp = [IDODemoUtility timeStampFromTimeStr:timeStr];
    IDOSyncSwimmingDataInfoBluetoothModel * model = [IDOSyncSwimDataModel querySwimDataWithTimeStr:timeStamp macAddr:__IDO_MAC_ADDR__];
    self.textView.text = [NSString stringWithFormat:@"%@:%@",lang(@"one timestamp query"),model ? model.dicFromObject : lang(@"no data")];
}

- (void)queryDateDataWtithVc:(FuncViewController *)funcVc
{
    if (!__IDO_FUNCTABLE__.funcTable22Model.v3SwimData) {
        [funcVc showToastWithText:lang(@"feature is not supported on the current device")];
        return;
    }
    NSString * timeStr = [NSString stringWithFormat:@"%.4d-%.2d-%.2d %.2d:%.2d:%.2d",self.year,self.month,self.day,0,0,0];
    NSString * timeStamp = [IDODemoUtility timeStampFromTimeStr:timeStr];
    NSArray * array = [IDOSyncSwimDataModel querySwimDataWithDateStr:timeStamp macAddr:__IDO_MAC_ADDR__];
    NSMutableArray * oneDaySwims = [NSMutableArray array];
    for (IDOSyncSwimmingDataInfoBluetoothModel * model in array) {
        NSDictionary * dic = model.dicFromObject;
        [oneDaySwims addObject:dic];
    }
    self.textView.text = [NSString stringWithFormat:@"%@:%@",lang(@"one date query"),oneDaySwims.count > 0 ? oneDaySwims : lang(@"no data")];
}

- (void)queryAllDataWithVc:(FuncViewController *)funcVc
{
    if (!__IDO_FUNCTABLE__.funcTable22Model.v3SwimData) {
        [funcVc showToastWithText:lang(@"feature is not supported on the current device")];
        return;
    }
    NSArray * array = [IDOSyncSwimDataModel queryAllSwimDataWithMacAddr:__IDO_MAC_ADDR__];
    NSMutableArray * oneDaySwims = [NSMutableArray array];
    for (IDOSyncSwimmingDataInfoBluetoothModel * model in array) {
        NSDictionary * dic = model.dicFromObject;
        [oneDaySwims addObject:dic];
    }
    self.textView.text = [NSString stringWithFormat:@"%@:%@",lang(@"all data query"),oneDaySwims.count > 0 ? oneDaySwims : lang(@"no data")];
}

- (void)getTextViewCallback
{
    __weak typeof(self) weakSelf = self;
    self.textViewCallback = ^(UITextView *textView) {
        __strong typeof(self) strongSelf = weakSelf;
        strongSelf.textView = textView;
    };
}

- (void)getTextFieldCallback
{
    __weak typeof(self) weakSelf = self;
    self.textFeildCallback = ^(UIViewController *viewController, UITextField *textField, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        if (indexPath.row == 0) {
            ThreeTextFieldTableViewCell * threeCell = (ThreeTextFieldTableViewCell *)tableViewCell;
            funcVC.datePickerView.currentDateStr = [NSString stringWithFormat:@"%@-%@-%@",threeCell.textField1.text,threeCell.textField2.text,threeCell.textField3.text];
            [funcVC.datePickerView show];
            funcVC.datePickerView.datePickerViewCallback = ^(NSArray *dateArray) {
                TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
                if (dateArray.count!=3) return;
                threeCell.textField1.text = dateArray[0];
                threeCell.textField2.text = dateArray[1];
                threeCell.textField3.text = dateArray[2];
                textFieldModel.data = @[@([threeCell.textField1.text integerValue]),@([threeCell.textField2.text integerValue]),@([threeCell.textField3.text integerValue])];
                [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                strongSelf.year  = [threeCell.textField1.text integerValue];
                strongSelf.month = [threeCell.textField2.text integerValue];
                strongSelf.day   = [threeCell.textField3.text integerValue];
            };
        }else if (indexPath.row == 1) {
            ThreeTextFieldTableViewCell * threeCell = (ThreeTextFieldTableViewCell *)tableViewCell;
            TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
            NSArray * pickerArray = threeCell.textField1 == textField ? strongSelf.pickerDataModel.hourArray :strongSelf.pickerDataModel.minuteArray;
            funcVC.pickerView.pickerArray = pickerArray;
            funcVC.pickerView.currentIndex = [pickerArray containsObject:@([textField.text intValue])] ? [pickerArray indexOfObject:@([textField.text intValue])] : 0 ;
            [funcVC.pickerView show];
            funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
                textField.text = selectStr;
                if (threeCell.textField1 == textField) {
                    strongSelf.hour = [selectStr integerValue];
                }else if (threeCell.textField2 == textField){
                    strongSelf.minute = [selectStr integerValue];
                }else {
                    strongSelf.second = [selectStr integerValue];
                }
                textFieldModel.data = @[@(strongSelf.hour),@(strongSelf.minute),@(strongSelf.second)];
                [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            };
        }
    };
}

@end
