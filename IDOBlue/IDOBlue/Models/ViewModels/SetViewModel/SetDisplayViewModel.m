//
//  SetDisplayViewModel.m
//  IDOBluetoothDemo
//
//  Created by hedongyang on 2018/9/26.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "SetDisplayViewModel.h"
#import "FuncViewController.h"
#import "EmpltyCellModel.h"
#import "FuncCellModel.h"
#import "LabelCellModel.h"
#import "EmptyTableViewCell.h"
#import "OneButtonTableViewCell.h"
#import "OneLabelTableViewCell.h"

@interface SetDisplayViewModel()
@property (nonatomic,strong) IDOSetDisplayModeInfoBluetoothModel * displayModel;
@property (nonatomic,copy)void(^labelSelectCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation SetDisplayViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getButtonCallback];
        [self getLabelCallback];
        [self getCellModels];
    }
    return self;
}

- (IDOSetDisplayModeInfoBluetoothModel *)displayModel
{
    if (!_displayModel) {
        _displayModel = [IDOSetDisplayModeInfoBluetoothModel currentModel];
    }
    return _displayModel;
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    LabelCellModel * model1 = [[LabelCellModel alloc]init];
    model1.typeStr = @"oneLabel";
    model1.data = @[lang(@"default")];
    model1.cellHeight = 70.0f;
    model1.cellClass = [OneLabelTableViewCell class];
    model1.modelClass = [NSNull class];
    model1.labelSelectCallback = self.labelSelectCallback;
    model1.isShowLine = YES;
    model1.isSelected = self.displayModel.modeType == 0;
    [cellModels addObject:model1];
    
    LabelCellModel * model2 = [[LabelCellModel alloc]init];
    model2.typeStr = @"oneLabel";
    model2.data = @[lang(@"cross screen")];
    model2.cellHeight = 70.0f;
    model2.cellClass = [OneLabelTableViewCell class];
    model2.modelClass = [NSNull class];
    model2.labelSelectCallback = self.labelSelectCallback;
    model2.isShowLine = YES;
    model2.isSelected = self.displayModel.modeType == 1;
    [cellModels addObject:model2];
    
    LabelCellModel * model3 = [[LabelCellModel alloc]init];
    model3.typeStr = @"oneLabel";
    model3.data = @[lang(@"vertical screen")];
    model3.cellHeight = 70.0f;
    model3.cellClass = [OneLabelTableViewCell class];
    model3.modelClass = [NSNull class];
    model3.labelSelectCallback = self.labelSelectCallback;
    model3.isShowLine = YES;
    model3.isSelected = self.displayModel.modeType == 2;
    [cellModels addObject:model3];
    
    LabelCellModel * model4 = [[LabelCellModel alloc]init];
    model4.typeStr = @"oneLabel";
    model4.data = @[lang(@"rotate 180 degrees")];
    model4.cellHeight = 70.0f;
    model4.cellClass = [OneLabelTableViewCell class];
    model4.modelClass = [NSNull class];
    model4.labelSelectCallback = self.labelSelectCallback;
    model4.isShowLine = YES;
    model3.isSelected = self.displayModel.modeType == 3;
    [cellModels addObject:model4];
    
    EmpltyCellModel * model5 = [[EmpltyCellModel alloc]init];
    model5.typeStr = @"empty";
    model5.cellHeight = 30.0f;
    model5.isShowLine = YES;
    model5.cellClass  = [EmptyTableViewCell class];
    [cellModels addObject:model5];
    
    FuncCellModel * model6 = [[FuncCellModel alloc]init];
    model6.typeStr = @"oneButton";
    model6.data = @[lang(@"set display mode")];
    model6.cellHeight = 70.0f;
    model6.cellClass = [OneButtonTableViewCell class];
    model6.modelClass = [NSNull class];
    model6.isShowLine = YES;
    model6.buttconCallback = self.buttconCallback;
    [cellModels addObject:model6];
    
    self.cellModels = cellModels;
}

- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        [funcVC showLoadingWithMessage:lang(@"set display mode...")];
        [IDOFoundationCommand setDisplayModeCommand:strongSelf.displayModel
                                          callback:^(int errorCode) {
            if(errorCode == 0) {
                [funcVC showToastWithText:lang(@"set display mode success")];
            }else if (errorCode == 6) {
                [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
            }else {
                [funcVC showToastWithText:lang(@"set display mode failed")];
            }
        }];
    };
}

- (void)getLabelCallback
{
    __weak typeof(self) weakSelf = self;
    self.labelSelectCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        for (BaseCellModel * model in strongSelf.cellModels) {
            if ([model isKindOfClass:[LabelCellModel class]]) {
                LabelCellModel * labelModel = (LabelCellModel *)model;
                labelModel.isSelected = NO;
            }
        }
        LabelCellModel * labelModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
        labelModel.isSelected = YES;
        strongSelf.displayModel.modeType = indexPath.row;
        [funcVC.tableView reloadData];
    };
}

@end
