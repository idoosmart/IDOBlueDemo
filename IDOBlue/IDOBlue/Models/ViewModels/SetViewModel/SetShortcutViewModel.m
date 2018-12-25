//
//  SetShortcutViewModel.m
//  IDOBlue
//
//  Created by hedongyang on 2018/9/29.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "SetShortcutViewModel.h"
#import "FuncViewController.h"
#import "EmpltyCellModel.h"
#import "FuncCellModel.h"
#import "LabelCellModel.h"
#import "EmptyTableViewCell.h"
#import "OneButtonTableViewCell.h"
#import "OneLabelTableViewCell.h"

@interface SetShortcutViewModel()
@property (nonatomic,strong) IDOSetShortcutInfoBluetoothModel * shortcutModel;
@property (nonatomic,copy)void(^labelSelectCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation SetShortcutViewModel
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

- (IDOSetShortcutInfoBluetoothModel *)shortcutModel
{
    if (!_shortcutModel) {
        _shortcutModel = [IDOSetShortcutInfoBluetoothModel currentModel];
    }
    return _shortcutModel;
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    LabelCellModel * model1 = [[LabelCellModel alloc]init];
    model1.typeStr = @"oneLabel";
    model1.data = @[@"无效"];
    model1.cellHeight = 70.0f;
    model1.cellClass = [OneLabelTableViewCell class];
    model1.modelClass = [NSNull class];
    model1.labelSelectCallback = self.labelSelectCallback;
    model1.isShowLine = YES;
    model1.isSelected = self.shortcutModel.shortcutType == 0;
    [cellModels addObject:model1];
    
    LabelCellModel * model2 = [[LabelCellModel alloc]init];
    model2.typeStr = @"oneLabel";
    model2.data = @[@"快速进入拍照控制"];
    model2.cellHeight = 70.0f;
    model2.cellClass = [OneLabelTableViewCell class];
    model2.modelClass = [NSNull class];
    model2.labelSelectCallback = self.labelSelectCallback;
    model2.isShowLine = YES;
    model2.isSelected = self.shortcutModel.shortcutType == 1;
    [cellModels addObject:model2];
    
    LabelCellModel * model3 = [[LabelCellModel alloc]init];
    model3.typeStr = @"oneLabel";
    model3.data = @[@"快速进入运动模式"];
    model3.cellHeight = 70.0f;
    model3.cellClass = [OneLabelTableViewCell class];
    model3.modelClass = [NSNull class];
    model3.labelSelectCallback = self.labelSelectCallback;
    model3.isShowLine = YES;
    model3.isSelected = self.shortcutModel.shortcutType == 2;
    [cellModels addObject:model3];
    
    LabelCellModel * model4 = [[LabelCellModel alloc]init];
    model4.typeStr = @"oneLabel";
    model4.data = @[@"快速进入勿扰模式"];
    model4.cellHeight = 70.0f;
    model4.cellClass = [OneLabelTableViewCell class];
    model4.modelClass = [NSNull class];
    model4.labelSelectCallback = self.labelSelectCallback;
    model4.isShowLine = YES;
    model3.isSelected = self.shortcutModel.shortcutType == 3;
    [cellModels addObject:model4];
    
    EmpltyCellModel * model5 = [[EmpltyCellModel alloc]init];
    model5.typeStr = @"empty";
    model5.cellHeight = 30.0f;
    model5.isShowLine = YES;
    model5.cellClass  = [EmptyTableViewCell class];
    [cellModels addObject:model5];
    
    FuncCellModel * model6 = [[FuncCellModel alloc]init];
    model6.typeStr = @"oneButton";
    model6.data = @[@"设置快捷方式"];
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
        [funcVC showLoadingWithMessage:@"设置快捷方式..."];
        [IDOFoundationCommand setShortcutCommand:strongSelf.shortcutModel
                                        callback:^(int errorCode) {
            if(errorCode == 0) {
                [funcVC showToastWithText:@"设置快捷方式成功"];
            }else {
                [funcVC showToastWithText:@"设置快捷方式失败"];
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
        strongSelf.shortcutModel.shortcutType = indexPath.row;
        [funcVC.tableView reloadData];
    };
}
@end
