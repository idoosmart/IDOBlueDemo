//
//  SetV3ScheduleRemindItemViewModel.m
//  IDOBlue
//
//  Created by huangkunhe on 2021/9/4.
//  Copyright © 2021 hedongyang. All rights reserved.
//

#import "SetV3ScheduleRemindItemViewModel.h"
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
#import "LabelCellModel.h"
#import "OneLabelTableViewCell.h"


@interface SetV3ScheduleRemindItemViewModel ()

@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^switchCallback)(UIViewController * viewController,UISwitch * onSwitch,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^textFeildCallback)(UIViewController * viewController,UITextField * textField,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^textFeildDidEditCallback)(UIViewController * viewController,UITextField * textField,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^labelSelectCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);

@property (nonatomic, copy)NSArray *stateArray;
@property (nonatomic, copy)NSArray *nowDayRemindTypeArray;
@property (nonatomic, copy)NSArray *futureRemindTypeArray;

@end

@implementation SetV3ScheduleRemindItemViewModel

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        [self getTextFieldCallback];
        [self getTextFeildDidEditCallback];
        [self getButtonCallback];
        [self getLabelCallback];
        [self getCellModels];
    }
    
    return self;
}

// 0:无效, 1：删除状态, 2：启用状态
- (NSArray *)stateArray
{
    if (!_stateArray)
    {
        _stateArray = @[lang(@"invalid state"),lang(@"delete state"),lang(@"enable state")];
    }
    return _stateArray;
}

/**
 * 提醒类型 0:不提醒 2:准时 4:提前5分钟 8:提前10分钟 16:提前30分钟 32:提前1小时 64:提前1天
 */
-(NSArray *)nowDayRemindTypeArray {
    if (!_nowDayRemindTypeArray)
    {
        _nowDayRemindTypeArray = @[lang(@"no remind"),lang(@"on time"),lang(@"5 minutes in advance"),lang(@"10 minutes in advance"),lang(@"30 minutes in advance"),lang(@"1 hour in advance"),lang(@"1 day in advance")];
    }
    return _nowDayRemindTypeArray;
}

/**
 * 超过天数提醒类型 0:当天 2:提前1天 4:提前2天 8:提前3天 16:提前1周
 */
-(NSArray *)futureRemindTypeArray {
    if (!_futureRemindTypeArray)
    {
        _futureRemindTypeArray = @[lang(@"same day"),lang(@"1 day in advance"),lang(@"2 day in advance"),lang(@"3 day in advance"),lang(@"1 week in advance")];
    }
    return _futureRemindTypeArray;
}



-(void)setRemindItemModel:(IDOSetRemindItemModel *)remindItemModel {
    _remindItemModel = remindItemModel;
    if (!_remindItemModel) {
        _remindItemModel = [[IDOSetRemindItemModel alloc] init];
        if(![_remindItemModel.repeat isKindOfClass:[NSArray class]])_remindItemModel.repeat = @[@0,@0,@0,@0,@0,@0,@0];
        
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
        TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
        if (indexPath.row == 0)
        {
            strongSelf.remindItemModel.remindId = [textField.text integerValue];
            textFieldModel.data = @[@(strongSelf.remindItemModel.remindId)];
        }
        else if (indexPath.row == 1)
        {
            strongSelf.remindItemModel.title = textField.text;
            textFieldModel.data = @[strongSelf.remindItemModel.title];
        }
        else if (indexPath.row == 2)
        {
            strongSelf.remindItemModel.note = textField.text;
            textFieldModel.data = @[strongSelf.remindItemModel.note];
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
                strongSelf.remindItemModel.year  = [dateArray[0] integerValue];
                strongSelf.remindItemModel.month = [dateArray[1] integerValue];
                strongSelf.remindItemModel.day   = [dateArray[2] integerValue];
            };
           
               
        }
        else if (indexPath.row == 4)
        {
            ThreeTextFieldTableViewCell * threeCell = (ThreeTextFieldTableViewCell *)tableViewCell;
            
            TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
            if (threeCell.textField1 == textField) {
                funcVC.pickerView.pickerArray = strongSelf.pickerDataModel.hourArray;
            }else if(threeCell.textField2 == textField) {
                funcVC.pickerView.pickerArray = strongSelf.pickerDataModel.minuteArray;
            }else if (threeCell.textField3 == textField){
                funcVC.pickerView.pickerArray = strongSelf.pickerDataModel.minuteArray;
            }
            funcVC.pickerView.currentIndex = [funcVC.pickerView.pickerArray containsObject:@([textField.text intValue])] ? [funcVC.pickerView.pickerArray indexOfObject:@([textField.text intValue])] : 0 ;
            [funcVC.pickerView show];
            funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
                textField.text = selectStr;
                if (threeCell.textField1 == textField) {
                    strongSelf.remindItemModel.hour  = [selectStr integerValue];
                }else if(threeCell.textField2 == textField) {
                    strongSelf.remindItemModel.minute = [selectStr integerValue];
                }else if (threeCell.textField3 == textField){
                    strongSelf.remindItemModel.second = [selectStr integerValue];
                }
                textFieldModel.data = @[@(strongSelf.remindItemModel.hour),@(strongSelf.remindItemModel.minute),@(strongSelf.remindItemModel.second)];
                [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            };
            
        }
        else if (indexPath.row == 5)
        {
            funcVC.pickerView.pickerArray = strongSelf.stateArray;
            funcVC.pickerView.currentIndex = [strongSelf.stateArray containsObject:textField.text] ? [strongSelf.stateArray indexOfObject:textField.text] : 0 ;
            [funcVC.pickerView show];
            funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
                TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
                textField.text = selectStr;
                textFieldModel.data = @[selectStr];
                [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                strongSelf.remindItemModel.state  = [strongSelf.stateArray containsObject:selectStr] ? [strongSelf.stateArray indexOfObject:selectStr] : 0 ;
            };
        }else if (indexPath.row == 6) {
            
            funcVC.pickerView.pickerArray = strongSelf.nowDayRemindTypeArray;
            funcVC.pickerView.currentIndex = [strongSelf.nowDayRemindTypeArray containsObject:textField.text] ? [strongSelf.nowDayRemindTypeArray indexOfObject:textField.text] : 0 ;
            [funcVC.pickerView show];
            funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
                TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
                textField.text = selectStr;
                textFieldModel.data = @[selectStr];
                [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                NSInteger nowDayRemindType = [strongSelf.nowDayRemindTypeArray containsObject:selectStr] ? [strongSelf.nowDayRemindTypeArray indexOfObject:selectStr] : 0 ;
                strongSelf.remindItemModel.nowDayRemindType  = 1<< nowDayRemindType;
            };
            
        }else if(indexPath.row == 7) {
            
            funcVC.pickerView.pickerArray = strongSelf.futureRemindTypeArray;
            funcVC.pickerView.currentIndex = [strongSelf.futureRemindTypeArray containsObject:textField.text] ? [strongSelf.futureRemindTypeArray indexOfObject:textField.text] : 0 ;
            [funcVC.pickerView show];
            funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
                TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
                textField.text = selectStr;
                textFieldModel.data = @[selectStr];
                [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                NSInteger futureRemindType = [strongSelf.futureRemindTypeArray containsObject:selectStr] ? [strongSelf.futureRemindTypeArray indexOfObject:selectStr] : 0 ;
                strongSelf.remindItemModel.futureRemindType  = 1<< futureRemindType;
            };
            
        }
        
    };
}

- (void)getLabelCallback
{
    __weak typeof(self) weakSelf = self;
    self.labelSelectCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        LabelCellModel * labelModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
        if (labelModel.isMultiSelect)labelModel.isSelected = !labelModel.isSelected;
        NSMutableArray * repeatArray = [NSMutableArray arrayWithArray:strongSelf.remindItemModel.repeat];
        [repeatArray replaceObjectAtIndex:labelModel.index withObject:@(labelModel.isSelected)];
        strongSelf.remindItemModel.repeat = repeatArray;
        [funcVC.tableView reloadData];
    };
}


- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        if (strongSelf.addRemindItemComplete) {
//            [funcVC showToastWithText:@"添加成功"];
            strongSelf.addRemindItemComplete(YES, strongSelf.remindItemModel);
            [funcVC.navigationController popViewControllerAnimated:YES];
        }
        
    };
}




- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    
    TextFieldCellModel * model10 = [[TextFieldCellModel alloc]init];
    model10.typeStr = @"oneTextField";
    model10.titleStr = lang(@"schedule id");
    model10.data = @[@(self.remindItemModel.remindId)];
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
    model11.titleStr = lang(@"schedule title");
    model11.data = @[self.remindItemModel.title?:@""];
    model11.cellHeight = 70.0f;
    model11.cellClass = [OneTextFieldTableViewCell class];
    model11.modelClass = [NSNull class];
    model11.isShowLine = YES;
    model11.isShowKeyboard = YES;
    model11.keyType = UIKeyboardTypeDefault;
    model11.textFeildDidEditCallback = self.textFeildDidEditCallback;
    [cellModels addObject:model11];
    
    TextFieldCellModel * model12 = [[TextFieldCellModel alloc]init];
    model12.typeStr = @"oneTextField";
    model12.titleStr = lang(@"schedule note");
    model12.data = @[self.remindItemModel.note?:@""];
    model12.cellHeight = 70.0f;
    model12.cellClass = [OneTextFieldTableViewCell class];
    model12.modelClass = [NSNull class];
    model12.isShowLine = YES;
    model12.isShowKeyboard = YES;
    model12.keyType = UIKeyboardTypeDefault;
    model12.textFeildDidEditCallback = self.textFeildDidEditCallback;
    [cellModels addObject:model12];
    
    
    TextFieldCellModel * model13 = [[TextFieldCellModel alloc]init];
    model13.typeStr = @"threeTextField";
    model13.titleStr = lang(@"date input");
    model13.data = @[@(self.remindItemModel.year),@(self.remindItemModel.month),@(self.remindItemModel.day)];
    model13.cellHeight = 70.0f;
    model13.cellClass = [ThreeTextFieldTableViewCell class];
    model13.modelClass = [NSNull class];
    model13.isShowLine = YES;
    model13.isShowKeyboard = YES;
    model13.keyType = UIKeyboardTypeNumberPad;
    model13.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model13];
    
    TextFieldCellModel * model14 = [[TextFieldCellModel alloc]init];
    model14.typeStr = @"threeTextField";
    model14.titleStr = lang(@"time input");
    model14.data = @[@(self.remindItemModel.hour),@(self.remindItemModel.minute),@(self.remindItemModel.second)];
    model14.cellHeight = 70.0f;
    model14.cellClass = [ThreeTextFieldTableViewCell class];
    model14.modelClass = [NSNull class];
    model14.isShowLine = YES;
    model14.isShowKeyboard = YES;
    model14.keyType = UIKeyboardTypeDefault;
    model14.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model14];
    
    //状态码 0:无效, 1：删除状态, 2：启用状态
    TextFieldCellModel * model15 = [[TextFieldCellModel alloc] init];
    model15.typeStr = @"oneTextField";
    model15.titleStr = lang(@"status code");
    model15.data = @[self.stateArray[self.remindItemModel.state]];;
    model15.cellHeight = 70.0f;
    model15.cellClass = [OneTextFieldTableViewCell class];
    model15.modelClass = [NSNull class];
    model15.isShowLine = YES;
    model15.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model15];
    
    TextFieldCellModel * model16 = [[TextFieldCellModel alloc] init];
    model16.typeStr = @"oneTextField";
    model16.titleStr = lang(@"reminder type");
    NSInteger nowDayRemindType = [self convertType:(self.remindItemModel.nowDayRemindType)];
    model16.data = @[self.nowDayRemindTypeArray[nowDayRemindType]];
    model16.cellHeight = 70.0f;
    model16.cellClass = [OneTextFieldTableViewCell class];
    model16.modelClass = [NSNull class];
    model16.isShowLine = YES;
    model16.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model16];
    
    TextFieldCellModel * model17 = [[TextFieldCellModel alloc] init];
    model17.typeStr = @"oneTextField";
    model17.titleStr = lang(@"future remind type") ;
    
    NSInteger futureRemindType =[self convertType:(self.remindItemModel.futureRemindType)];
    model17.data = @[self.futureRemindTypeArray[futureRemindType]];
    model17.cellHeight = 70.0f;
    model17.cellClass = [OneTextFieldTableViewCell class];
    model17.modelClass = [NSNull class];
    model17.isShowLine = YES;
    model17.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model17];
    
    
    EmpltyCellModel * model5 = [[EmpltyCellModel alloc]init];
    model5.typeStr = @"empty";
    model5.cellHeight = 30.0f;
    model5.isShowLine = YES;
    model5.cellClass  = [EmptyTableViewCell class];
    [cellModels addObject:model5];
    
    for (int i = 0; i < self.pickerDataModel.weekArray.count; i++) {
        LabelCellModel * model = [[LabelCellModel alloc]init];
        model.typeStr = @"oneLabel";
        model.data = @[self.pickerDataModel.weekArray[i]];
        model.cellHeight = 40.0f;
        model.cellClass = [OneLabelTableViewCell class];
        model.modelClass = [NSNull class];
        model.labelSelectCallback = self.labelSelectCallback;
        model.isShowLine = YES;
        model.index = i;
        model.isMultiSelect = YES;
        model.isSelected = [self.remindItemModel.repeat[i] boolValue];
        [cellModels addObject:model];
    }
    
    EmpltyCellModel * model6 = [[EmpltyCellModel alloc]init];
    model6.typeStr = @"empty";
    model6.cellHeight = 30.0f;
    model6.isShowLine = YES;
    model6.cellClass  = [EmptyTableViewCell class];
    [cellModels addObject:model6];

    
    
    FuncCellModel * model9 = [[FuncCellModel alloc]init];
    model9.typeStr = @"oneButton";
    model9.data = @[lang(@"add schedule")];
    model9.cellHeight = 70.0f;
    model9.cellClass = [OneButtonTableViewCell class];
    model9.modelClass = [NSNull class];
    model9.isShowLine = YES;
    model9.buttconCallback = self.buttconCallback;
    [cellModels addObject:model9];
    
    self.cellModels = cellModels;
}

-(NSInteger )convertType:(NSInteger)type {
    switch (type) {
        case 0:
            return 0;
            break;
        case 2:
            return 1;
            break;
        case 4:
            return 2;
            break;
        case 8:
            return 3;
            break;
        case 16:
            return 4;
            break;
        case 32:
            return 5;
            break;
        case 64:
            return 6;
            break;
        default:
            return 0;
            break;
    }
}


@end
