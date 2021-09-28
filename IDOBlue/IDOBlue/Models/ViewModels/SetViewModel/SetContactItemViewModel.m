//
//  SetContactItemViewModel.m
//  IDOBlue
//
//  Created by huangkunhe on 2021/9/6.
//  Copyright © 2021 hedongyang. All rights reserved.
//

#import "SetContactItemViewModel.h"
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

@interface SetContactItemViewModel ()
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^textFeildDidEditCallback)(UIViewController * viewController,UITextField * textField,UITableViewCell * tableViewCell);
@end

@implementation SetContactItemViewModel

-(instancetype)init
{
   self = [super init];
    if (self){
        
        [self getTextFeildDidEditCallback];
        [self getButtonCallback];
        [self getCellModels];
    }
    return self;
}



-(void)setContactItemModel:(IDOSetContactItemModel *)contactItemModel {
    _contactItemModel = contactItemModel;
    if (!_contactItemModel) {
        _contactItemModel = [[IDOSetContactItemModel alloc] init];
        
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
            strongSelf.contactItemModel.name =textField.text ;
            textFieldModel.data = @[strongSelf.contactItemModel.name];
        }
        else if (indexPath.row == 1)
        {
            strongSelf.contactItemModel.phone = textField.text;
            textFieldModel.data = @[strongSelf.contactItemModel.phone];
        }
    };
}

- (void)getButtonCallback
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        if (strongSelf.addContactItemComplete) {
//            [funcVC showToastWithText:@"添加成功"];
            strongSelf.addContactItemComplete(YES, strongSelf.contactItemModel);
            [funcVC.navigationController popViewControllerAnimated:YES];
        }
        
    };
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    
    TextFieldCellModel * model10 = [[TextFieldCellModel alloc]init];
    model10.typeStr = @"oneTextField";
    model10.titleStr = lang(@"name");
    model10.data = @[self.contactItemModel.name?self.contactItemModel.name:@""];
    model10.cellHeight = 70.0f;
    model10.cellClass = [OneTextFieldTableViewCell class];
    model10.modelClass = [NSNull class];
    model10.isShowLine = YES;
    model10.isShowKeyboard = YES;
    model10.textFeildDidEditCallback  = self.textFeildDidEditCallback;
    [cellModels addObject:model10];
    
    
    TextFieldCellModel * model11 = [[TextFieldCellModel alloc]init];
    model11.typeStr = @"oneTextField";
    model11.titleStr = lang(@"phone");
    model11.data = @[self.contactItemModel.phone?self.contactItemModel.phone:@""];
    model11.cellHeight = 70.0f;
    model11.cellClass = [OneTextFieldTableViewCell class];
    model11.modelClass = [NSNull class];
    model11.isShowLine = YES;
    model11.isShowKeyboard = YES;
    model11.keyType = UIKeyboardTypeNumberPad;
    model11.textFeildDidEditCallback = self.textFeildDidEditCallback;
    [cellModels addObject:model11];
    
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
