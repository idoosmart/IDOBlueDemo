//
//  SetFitnessGuidanceViewModel.m
//  IDOBlue
//  健身指导开关下发
//  Created by xiongjie on 2021/8/10.
//  Copyright © 2021 hedongyang. All rights reserved.
//

#import "SetFitnessGuidanceViewModel.h"
#import "SwitchCellModel.h"
#import "OneSwitchTableViewCell.h"
#import "TextFieldCellModel.h"
#import "TwoTextFieldTableViewCell.h"
#import "EmpltyCellModel.h"
#import "EmptyTableViewCell.h"
#import "FuncCellModel.h"
#import "OneButtonTableViewCell.h"
#import "OneTextFieldTableViewCell.h"
#import "FuncViewController.h"
#import "LabelCellModel.h"
#import "OneLabelTableViewCell.h"

@interface SetFitnessGuidanceViewModel ()

@property (nonatomic,strong) IDOSetFitnessGuidanceModel * fitnessGuidanceModel;
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^switchCallback)(UIViewController * viewController,UISwitch * onSwitch,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^textFeildCallback)(UIViewController * viewController,UITextField * textField,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^labelSelectCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);

@end

@implementation SetFitnessGuidanceViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getTextFieldCallback];
        [self getSwitchCallback];
        [self getButtonCallback];
        [self getLabelCallback];
        [self getCellModels];
    }
    return self;
}


- (IDOSetFitnessGuidanceModel *)fitnessGuidanceModel
{
    if (!_fitnessGuidanceModel) {
         _fitnessGuidanceModel = [IDOSetFitnessGuidanceModel currentModel];
    }
    return _fitnessGuidanceModel;
}


- (void)getTextFieldCallback
{
    __weak typeof(self) weakSelf = self;
    self.textFeildCallback = ^(UIViewController *viewController, UITextField *textField, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        if (indexPath.row == 1) {
            TwoTextFieldTableViewCell * twoCell = (TwoTextFieldTableViewCell *)tableViewCell;
            TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
            NSArray * pickerArray = twoCell.textField1 == textField ? strongSelf.pickerDataModel.hourArray : strongSelf.pickerDataModel.minuteArray;
            funcVC.pickerView.pickerArray = pickerArray;
            funcVC.pickerView.currentIndex = [pickerArray containsObject:@([textField.text intValue])] ? [pickerArray indexOfObject:@([textField.text intValue])] : 0 ;
            [funcVC.pickerView show];
            funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
                textField.text = selectStr;
                if (twoCell.textField1 == textField) {
                    strongSelf.fitnessGuidanceModel.startHour    = [selectStr integerValue];
                }else {
                    strongSelf.fitnessGuidanceModel.startMinute  = [selectStr integerValue];
                }
                textFieldModel.data = @[@(strongSelf.fitnessGuidanceModel.startHour),@(strongSelf.fitnessGuidanceModel.startMinute)];
                [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            };
        }else if (indexPath.row == 2){
            TwoTextFieldTableViewCell * twoCell = (TwoTextFieldTableViewCell *)tableViewCell;
            TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
            NSArray * pickerArray = twoCell.textField1 == textField ? strongSelf.pickerDataModel.hourArray : strongSelf.pickerDataModel.minuteArray;
            funcVC.pickerView.pickerArray = pickerArray;
            funcVC.pickerView.currentIndex = [pickerArray containsObject:@([textField.text intValue])] ? [pickerArray indexOfObject:@([textField.text intValue])] : 0 ;
            [funcVC.pickerView show];
            funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
                textField.text = selectStr;
                if (twoCell.textField1 == textField) {
                    strongSelf.fitnessGuidanceModel.endHour    = [selectStr integerValue];
                }else {
                    strongSelf.fitnessGuidanceModel.endMinute  = [selectStr integerValue];
                }
                textFieldModel.data = @[@(strongSelf.fitnessGuidanceModel.endHour),@(strongSelf.fitnessGuidanceModel.endMinute)];
                [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            };
        }else if(indexPath.row == 3) {
            TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
            funcVC.pickerView.pickerArray = strongSelf.pickerDataModel.notifyFlagArray;
            funcVC.pickerView.currentIndex = [strongSelf.pickerDataModel.notifyFlagArray containsObject:textField.text] ?
            [strongSelf.pickerDataModel.notifyFlagArray indexOfObject:textField.text] : 0 ;
            [funcVC.pickerView show];
            funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
                textField.text = selectStr;
                textFieldModel.data = @[selectStr];
                [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                strongSelf.fitnessGuidanceModel.notifyFlag  = [strongSelf.pickerDataModel.notifyFlagArray containsObject:selectStr] ?
                [strongSelf.pickerDataModel.notifyFlagArray indexOfObject:selectStr] : 0 ;
            };
        }else if (indexPath.row == 4) {
            TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
            funcVC.pickerView.pickerArray = strongSelf.pickerDataModel.tenThousandArray;
            funcVC.pickerView.currentIndex = [strongSelf.pickerDataModel.tenThousandArray containsObject:@([textField.text intValue])] ?
            [strongSelf.pickerDataModel.tenThousandArray indexOfObject:@([textField.text intValue])] : 0 ;
            [funcVC.pickerView show];
            funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
                textField.text = selectStr;
                textFieldModel.data = @[@([selectStr integerValue])];
                [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                strongSelf.fitnessGuidanceModel.targetSteps  = [selectStr integerValue];
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
        [IDOFoundationCommand setFitnessGuidanceCommand:strongSelf.fitnessGuidanceModel
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

- (void)getSwitchCallback
{
    __weak typeof(self) weakSelf = self;
    self.switchCallback = ^(UIViewController *viewController, UISwitch *onSwitch, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        if (indexPath.row == 0) {
            SwitchCellModel * switchCellModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
            strongSelf.fitnessGuidanceModel.mode = onSwitch.isOn;
            switchCellModel.data = @[@(strongSelf.fitnessGuidanceModel.mode)];
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
        NSMutableArray * repeatArray = [NSMutableArray arrayWithArray:strongSelf.fitnessGuidanceModel.repeat];
        [repeatArray replaceObjectAtIndex:labelModel.index withObject:@(labelModel.isSelected)];
        strongSelf.fitnessGuidanceModel.repeat = repeatArray;
        [funcVC.tableView reloadData];
    };
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    SwitchCellModel * model1 = [[SwitchCellModel alloc]init];
    model1.typeStr = @"oneSwitch";
    model1.titleStr = lang(@"fitness guidance switch");
    model1.data = @[@(self.fitnessGuidanceModel.mode)];
    model1.cellHeight = 70.0f;
    model1.cellClass = [OneSwitchTableViewCell class];
    model1.modelClass = [NSNull class];
    model1.isShowLine = YES;
    model1.switchCallback = self.switchCallback;
    [cellModels addObject:model1];
    
    TextFieldCellModel * model4 = [[TextFieldCellModel alloc]init];
    model4.typeStr = @"twoTextField";
    model4.titleStr = lang(@"set start time") ;
    model4.data = @[@(self.fitnessGuidanceModel.startHour),@(self.fitnessGuidanceModel.startMinute)];
    model4.cellHeight = 70.0f;
    model4.cellClass = [TwoTextFieldTableViewCell class];
    model4.modelClass = [NSNull class];
    model4.isShowLine = YES;
    model4.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model4];
    
    TextFieldCellModel * model5 = [[TextFieldCellModel alloc]init];
    model5.typeStr = @"twoTextField";
    model5.titleStr = lang(@"set end time");
    model5.data = @[@(self.fitnessGuidanceModel.endHour),@(self.fitnessGuidanceModel.endMinute)];
    model5.cellHeight = 70.0f;
    model5.cellClass = [TwoTextFieldTableViewCell class];
    model5.modelClass = [NSNull class];
    model5.isShowLine = YES;
    model5.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model5];
    
    TextFieldCellModel * model6 = [[TextFieldCellModel alloc]init];
    model6.typeStr = @"oneTextField";
    model6.titleStr = lang(@"notify flag");
    model6.data = @[self.pickerDataModel.notifyFlagArray[self.fitnessGuidanceModel.notifyFlag]];
    model6.cellHeight = 70.0f;
    model6.cellClass = [OneTextFieldTableViewCell class];
    model6.modelClass = [NSNull class];
    model6.isShowLine = YES;
    model6.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model6];
    
    TextFieldCellModel * model8 = [[TextFieldCellModel alloc]init];
    model8.typeStr = @"oneTextField";
    model8.titleStr = lang(@"set target step");
    model8.data = @[@(self.fitnessGuidanceModel.targetSteps)];
    model8.cellHeight = 70.0f;
    model8.cellClass = [OneTextFieldTableViewCell class];
    model8.modelClass = [NSNull class];
    model8.isShowLine = YES;
    model8.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model8];
    
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
        model.isSelected = [self.fitnessGuidanceModel.repeat[i] boolValue];
        [cellModels addObject:model];
    }
       
    EmpltyCellModel * model12 = [[EmpltyCellModel alloc]init];
    model12.typeStr = @"empty";
    model12.cellHeight = 30.0f;
    model12.isShowLine = YES;
    model12.cellClass  = [EmptyTableViewCell class];
    [cellModels addObject:model12];
    
    FuncCellModel * model7 = [[FuncCellModel alloc]init];
    model7.typeStr = @"oneButton";
    model7.data = @[lang(@"setup")];
    model7.cellHeight = 70.0f;
    model7.cellClass = [OneButtonTableViewCell class];
    model7.modelClass = [NSNull class];
    model7.isShowLine = YES;
    model7.buttconCallback = self.buttconCallback;
    [cellModels addObject:model7];
    
    self.cellModels = cellModels;
}


@end
