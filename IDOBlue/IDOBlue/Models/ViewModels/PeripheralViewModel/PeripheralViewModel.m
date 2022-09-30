//
//  PeripheralViewModel.m
//  IDOBlue
//
//  Created by huangkunhe on 2022/9/30.
//  Copyright © 2022 hedongyang. All rights reserved.
//

#import "PeripheralViewModel.h"
#import "sendScalesViewModel.h"
#import "sendBindDeviceViewModel.h"
#import "sendPeripheralsInfoViewModel.h"
#import "GetPeripheralsInfoViewModel.h"
#import "FuncCellModel.h"
#import "OneButtonTableViewCell.h"
#import "FuncViewController.h"

@interface PeripheralViewModel()
@property (nonatomic,strong) NSArray * buttonTitles;
@property (nonatomic,strong) NSArray * modelClasss;
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation PeripheralViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getButtonCallback];
        [self getCellModels];
    }
    return self;
}

- (NSArray *)buttonTitles
{
    if (!_buttonTitles) {
        _buttonTitles = @[@[lang(@"get Peripherals Info")],@[lang(@"send Peripherals Info To Device")],@[lang(@"send bind Info To Device")],
                          @[lang(@"send Scales Model MapTable")]];
    }
    return _buttonTitles;
}

- (NSArray *)modelClasss
{
    if (!_modelClasss) {
        _modelClasss = @[[GetPeripheralsInfoViewModel class],[sendPeripheralsInfoViewModel class],[sendBindDeviceViewModel class],
                         [sendScalesViewModel class]];
    }
    return _modelClasss;
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    for (int i = 0; i < self.buttonTitles.count; i++) {
        NSArray * data = [self.buttonTitles objectAtIndex:i];
        FuncCellModel * model = [[FuncCellModel alloc]init];
        model.typeStr = @"oneButton";
        model.data    = data;
        model.cellHeight = 70.0f;
        model.cellClass  = [OneButtonTableViewCell class];
        model.modelClass = self.modelClasss[i];
        model.buttconCallback = self.buttconCallback;
        [cellModels addObject:model];
    }
    self.cellModels = cellModels;
}

- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVc = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVc.tableView indexPathForCell:tableViewCell];
        BaseCellModel * model = [strongSelf.cellModels objectAtIndex:indexPath.row];
        if ([NSStringFromClass(model.modelClass)isEqualToString:@"NSNull"])return;
        FuncViewController * newFuncVc = [FuncViewController new];
        newFuncVc.model = [model.modelClass new];
        newFuncVc.title = [model.data firstObject];
        [funcVc.navigationController pushViewController:newFuncVc animated:YES];
    };
}

@end

