//
//  SetAppNotifyStateItemViewModel.m
//  IDOBlue
//
//  Created by huangkunhe on 2021/9/6.
//  Copyright © 2021 hedongyang. All rights reserved.
//

#import "SetAppNotifyStateItemViewModel.h"
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


@interface SetAppNotifyStateItemViewModel ()

@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^switchCallback)(UIViewController * viewController,UISwitch * onSwitch,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^textFeildCallback)(UIViewController * viewController,UITextField * textField,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^textFeildDidEditCallback)(UIViewController * viewController,UITextField * textField,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^labelSelectCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);

@property (nonatomic, copy)NSArray *notifyStateArray;
@property (nonatomic, strong)UITextField *textField;

@end
@implementation SetAppNotifyStateItemViewModel

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


//通知状态  允许通知：1，静默通知 ：2， 关闭通知：3
- (NSArray *)notifyStateArray
{
    if (!_notifyStateArray)
    {
        _notifyStateArray = @[lang(@"allow notify flag"),lang(@"silence notify flag"),lang(@"close notify flag")];
    }
    return _notifyStateArray;
}


-(void)setStateItemModel:(IDOSetAppNotifyStateItemModel *)stateItemModel {
    _stateItemModel = stateItemModel;
    if (!_stateItemModel) {
        _stateItemModel = [[IDOSetAppNotifyStateItemModel alloc] init];
        _stateItemModel.notifyState = 1;
    }else {
        FuncViewController * funcVC = (FuncViewController *)[IDODemoUtility getCurrentVC];
        [self getCellModels];
        [funcVC reloadData];
    }
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
            strongSelf.textField = textField;

        }
        else if (indexPath.row == 1)
        {
            funcVC.pickerView.pickerArray = strongSelf.notifyStateArray;
            funcVC.pickerView.currentIndex = [strongSelf.notifyStateArray containsObject:textField.text] ? [strongSelf.notifyStateArray indexOfObject:textField.text] : 0 ;
            [funcVC.pickerView show];
            funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
                TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
                textField.text = selectStr;
                textFieldModel.data = @[selectStr];
                [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                NSInteger notifyState = ([strongSelf.notifyStateArray containsObject:selectStr] ? [strongSelf.notifyStateArray indexOfObject:selectStr] : 0)+1;
                strongSelf.stateItemModel.notifyState  = notifyState ;
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
        if (strongSelf.textField) {
            strongSelf.stateItemModel.evtType = [strongSelf.textField.text integerValue];
        }
        if (strongSelf.addAppNotifyStateItemModelmComplete) {
//            [funcVC showToastWithText:@"添加成功"];
            strongSelf.addAppNotifyStateItemModelmComplete(YES, strongSelf.stateItemModel);
            [funcVC.navigationController popViewControllerAnimated:YES];
        }
        
    };
}


- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    
    TextFieldCellModel * model10 = [[TextFieldCellModel alloc]init];
    model10.typeStr = @"oneTextField";
    model10.titleStr = lang(@"event type");
    model10.data = @[@(self.stateItemModel.evtType)];
    model10.cellHeight = 70.0f;
    model10.cellClass = [OneTextFieldTableViewCell class];
    model10.modelClass = [NSNull class];
    model10.isShowLine = YES;
    model10.isShowKeyboard = YES;
    model10.keyType = UIKeyboardTypeNumberPad;
    model10.textFeildCallback  = self.textFeildCallback;
    [cellModels addObject:model10];
    

    //状态码 0:无效, 1：删除状态, 2：启用状态
    TextFieldCellModel * model15 = [[TextFieldCellModel alloc] init];
    model15.typeStr = @"oneTextField";
    model15.titleStr = lang(@"notification status");
    if (self.stateItemModel.notifyState > 1) {
        model15.data = @[self.notifyStateArray[self.stateItemModel.notifyState -1]];
    }else {
        model15.data = @[self.notifyStateArray[0]];
    }
    
    model15.cellHeight = 70.0f;
    model15.cellClass = [OneTextFieldTableViewCell class];
    model15.modelClass = [NSNull class];
    model15.isShowLine = YES;
    model15.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model15];

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
