//
//  SetIotButtonViewModel.m
//  IDOBlue
//
//  Created by 何东阳 on 2019/12/28.
//  Copyright © 2019 hedongyang. All rights reserved.
//

#import "SetIotButtonViewModel.h"
#import "TextFieldCellModel.h"
#import "OneTextFieldTableViewCell.h"
#import "EmpltyCellModel.h"
#import "EmptyTableViewCell.h"
#import "FuncCellModel.h"
#import "OneButtonTableViewCell.h"
#import "LabelCellModel.h"
#import "OneLabelTableViewCell.h"
#import "FuncViewController.h"

@interface SetIotButtonViewModel ()
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^textFeildCallback)(UIViewController * viewController,UITextField * textField,UITableViewCell * tableViewCell);
@property (nonatomic,strong) NSMutableArray * buttonArray;
@property (nonatomic,strong) UITextField * textField;
@property (nonatomic,assign) NSInteger currentIndex;
@end

@implementation SetIotButtonViewModel

- (void)dealloc
{
    self.buttonArray = nil;
    self.textField = nil;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.currentIndex = 0;
        [self getButtonCallback];
        [self getTextFieldCallback];
        [self getListenIotButtonCallback];
        [self getCellModels];
    }
    return self;
}

- (NSMutableArray *)buttonArray
{
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    TextFieldCellModel * model1 = [[TextFieldCellModel alloc]init];
    model1.typeStr = @"oneTextField";
    model1.titleStr = lang(@"button name");
    model1.cellHeight = 70.0f;
    model1.cellClass = [OneTextFieldTableViewCell class];
    model1.modelClass = [NSNull class];
    model1.data = @[@""];
    model1.isShowLine = YES;
    model1.isShowKeyboard = YES;
    model1.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model1];
    
    EmpltyCellModel * model4 = [[EmpltyCellModel alloc]init];
    model4.typeStr = @"empty";
    model4.cellHeight = 30.0f;
    model4.isShowLine = YES;
    model4.cellClass  = [EmptyTableViewCell class];
    [cellModels addObject:model4];
    
    FuncCellModel * model5 = [[FuncCellModel alloc]init];
    model5.typeStr = @"oneButton";
    model5.data = @[lang(@"add iot button")];
    model5.cellHeight = 70.0f;
    model5.cellClass = [OneButtonTableViewCell class];
    model5.modelClass = [NSNull class];
    model5.isShowLine = YES;
    model5.buttconCallback = self.buttconCallback;
    [cellModels addObject:model5];

    NSInteger index = 0;
    for (NSDictionary * dic in self.buttonArray) {
        LabelCellModel * model = [[LabelCellModel alloc]init];
        model.typeStr = @"oneLabel";
        model.data = @[dic[@"button"]];
        model.cellHeight = 70.0f;
        model.cellClass = [OneLabelTableViewCell class];
        model.modelClass = [NSNull class];
        model.isShowLine = YES;
        model.isCenter = YES;
        model.isSelected = self.currentIndex == (index + 1);
        [cellModels addObject:model];
        index++;
    }
    
    if (self.buttonArray.count > 0) {
        FuncCellModel * model3 = [[FuncCellModel alloc]init];
        model3.typeStr = @"oneButton";
        model3.data = @[lang(@"sync iot button")];
        model3.cellHeight = 70.0f;
        model3.cellClass = [OneButtonTableViewCell class];
        model3.modelClass = [NSNull class];
        model3.isShowLine = YES;
        model3.buttconCallback = self.buttconCallback;
        [cellModels addObject:model3];
    }
    
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
            if (strongSelf.textField.text.length == 0) {
                [funcVC showToastWithText:lang(@"please write button name")];
                return;
            }
            NSDictionary * dic = @{@"index":@(strongSelf.buttonArray.count),
                                   @"button":strongSelf.textField.text};
            [strongSelf.buttonArray addObject:dic];
            [strongSelf getCellModels];
            [funcVC reloadData];
        }else if (indexPath.row == strongSelf.cellModels.count - 1) { //设置iot按钮
            [IDOFoundationCommand setIotButtonNamesCommand:strongSelf.buttonArray
                                                  callback:^(float progress) {
                NSLog(@"progress == %lf",progress);
                [funcVC showSyncProgress:progress];
            } complete:^(int errorCode) {
                if (errorCode == 0) {
                    [funcVC showToastWithText:lang(@"sync iot button success")];
                }else {
                    [funcVC showToastWithText:lang(@"sync iot button failed")];
                }
            }];
        }
    };
}

- (void)getTextFieldCallback
{
    __weak typeof(self) weakSelf = self;
    self.textFeildCallback = ^(UIViewController *viewController, UITextField *textField, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        if (!strongSelf.textField) {
             strongSelf.textField = textField;
        }
    };
}

- (void)getListenIotButtonCallback
{
    __weak typeof(self) weakSelf = self;
    [IDOFoundationCommand listenIotButtonCommand:^(int errorCode, int index) {
        __strong typeof(self) strongSelf = weakSelf;
        if (errorCode == 0) {
            strongSelf.currentIndex = index+1;
            FuncViewController * funcVC = (FuncViewController *)[IDODemoUtility getCurrentVC];
            [strongSelf getCellModels];
            [funcVC reloadData];
        }
    }];
}

@end
