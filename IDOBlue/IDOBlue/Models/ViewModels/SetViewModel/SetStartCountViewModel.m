//
//  SetStartCountViewModel.m
//  IDOBlue
//
//  Created by 何东阳 on 2019/1/22.
//  Copyright © 2019年 hedongyang. All rights reserved.
//

#import "SetStartCountViewModel.h"
#import "FuncViewController.h"
#import "OneTextFieldTableViewCell.h"
#import "EmptyTableViewCell.h"
#import "OneButtonTableViewCell.h"
#import "TextFieldCellModel.h"
#import "EmpltyCellModel.h"
#import "FuncCellModel.h"

@interface SetStartCountViewModel()
@property (nonatomic,copy)void(^textFeildCallback)(UIViewController * viewController,UITextField * textField,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)NSArray * startArray;
@property (nonatomic,assign) NSInteger startCount;
@end

@implementation SetStartCountViewModel
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

- (NSArray *)startArray
{
    if (!_startArray) {
        _startArray = @[@"1",@"2",@"3",@"4",@"5"];
    }
    return _startArray;
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    TextFieldCellModel * model1 = [[TextFieldCellModel alloc]init];
    model1.typeStr = @"oneTextField";
    model1.titleStr = @"设置星星个数 : ";
    model1.data = @[@"1"];
    model1.cellHeight = 70.0f;
    model1.cellClass = [OneTextFieldTableViewCell class];
    model1.modelClass = [NSNull class];
    model1.isShowLine = YES;
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
    model3.data = @[@"设置星星个数"];
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
            TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
            funcVC.pickerView.pickerArray  = strongSelf.startArray;
            funcVC.pickerView.currentIndex = [strongSelf.startArray containsObject:textField.text] ? [strongSelf.startArray indexOfObject:textField.text] : 0 ;
            [funcVC.pickerView show];
            strongSelf.startCount = [textField.text integerValue];
            funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
                textField.text = selectStr;
                textFieldModel.data = @[selectStr];
                strongSelf.startCount = [selectStr integerValue];
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
        [funcVC showLoadingWithMessage:@"设置星星个数..."];
        [IDOFoundationCommand setStartCountCommand:strongSelf.startCount callback:^(int errorCode) {
            if(errorCode == 0) {
                [funcVC showToastWithText:@"设置星星个数成功"];
            }else {
                [funcVC showToastWithText:@"设置星星个数失败"];
            }
        }];
    };
}
@end
