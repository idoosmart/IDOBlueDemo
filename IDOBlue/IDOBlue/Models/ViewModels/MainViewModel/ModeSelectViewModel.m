//
//  ModeSelectViewModel.m
//  IDOBlue
//
//  Created by 何东阳 on 2018/10/15.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "ModeSelectViewModel.h"
#import "LabelCellModel.h"
#import "FuncCellModel.h"
#import "EmpltyCellModel.h"
#import "SliderCellModel.h"
#import "OneLabelTableViewCell.h"
#import "TwoButtonTableViewCell.h"
#import "SliderTableViewCell.h"
#import "EmptyTableViewCell.h"
#import "FuncViewController.h"

@interface ModeSelectViewModel()
@property (nonatomic,assign) int rssiValue;
@property (nonatomic,assign) int modeValue;
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^sliderCallback)(UIViewController * viewController,UISlider * slider,UITableViewCell * tableViewCell);
@end

@implementation ModeSelectViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getButtonCallback];
        [self getSliderCallback];
        [self getWillDisappearCallback];
        [self getCellModels];
    }
    return self;
}

- (void)getCellModels
{
    self.modeValue = (int)[[NSUserDefaults standardUserDefaults]integerForKey:PRODUCTION_MODE_KEY];
    self.rssiValue = (int)[[NSUserDefaults standardUserDefaults]integerForKey:RSSI_KEY];
    if (self.rssiValue == 0)self.rssiValue = 80;
    
    NSMutableArray * cellModels = [NSMutableArray array];
    
    FuncCellModel * model1 = [[FuncCellModel alloc]init];
    model1.typeStr = @"twoButton";
    model1.titleStr = @"模式 : ";
    BOOL isFactory = self.modeValue == 0 ? YES : NO;
    model1.data = @[@{@"title":@"工厂",@"state":[NSNumber numberWithBool:isFactory]},@{@"title":@"普通",@"state":[NSNumber numberWithBool:!isFactory]}];
    model1.cellHeight = 70.0f;
    model1.cellClass = [TwoButtonTableViewCell class];
    model1.modelClass = [NSNull class];
    model1.isShowLine = YES;
    model1.buttconCallback = self.buttconCallback;
    [cellModels addObject:model1];
    
    EmpltyCellModel * model2 = [[EmpltyCellModel alloc]init];
    model2.typeStr = @"empty";
    model2.cellHeight = 30.0f;
    model2.isShowLine = YES;
    model2.cellClass  = [EmptyTableViewCell class];
    [cellModels addObject:model2];
    
    SliderCellModel * model3 = [[SliderCellModel alloc]init];
    model3.typeStr = @"slider";
    model3.cellHeight = 70.0f;
    model3.isShowLine = YES;
    model3.data = @[@(self.rssiValue)];
    model3.cellClass  = [SliderTableViewCell class];
    model3.sliderCallback = self.sliderCallback;
    [cellModels addObject:model3];
    
    self.cellModels = cellModels;
}

- (void)getWillDisappearCallback
{
    __weak typeof(self) weakSelf = self;
    self.viewWillDisappearCallback = ^(UIViewController *viewController) {
        __strong typeof(self) strongSelf = weakSelf;
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:strongSelf.rssiValue] forKey:RSSI_KEY];
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:strongSelf.modeValue] forKey:PRODUCTION_MODE_KEY];
    };
}

- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVc = (FuncViewController *)viewController;
        TwoButtonTableViewCell * twoCell = (TwoButtonTableViewCell *)tableViewCell;
        NSIndexPath * indexPath = [funcVc.tableView indexPathForCell:tableViewCell];
        FuncCellModel * funcCellModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
        strongSelf.modeValue = twoCell.button1.isSelected ? 0 : 1;
        funcCellModel.data = @[@{@"title":@"工厂",@"state":[NSNumber numberWithBool:twoCell.button1.isSelected]},
                               @{@"title":@"普通",@"state":[NSNumber numberWithBool:twoCell.button2.isSelected]}];
    };
}

- (void)getSliderCallback
{
    __weak typeof(self) weakSelf = self;
    self.sliderCallback = ^(UIViewController *viewController, UISlider *slider, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVc = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVc.tableView indexPathForCell:tableViewCell];
        SliderCellModel * sliderCellModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
        strongSelf.rssiValue = (int)slider.value;
        sliderCellModel.data = @[@(slider.value)];
    };
}

@end
