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
#import "SwitchCellModel.h"
#import "OneLabelTableViewCell.h"
#import "TwoButtonTableViewCell.h"
#import "OneSwitchTableViewCell.h"
#import "SliderTableViewCell.h"
#import "EmptyTableViewCell.h"
#import "FuncViewController.h"

@interface ModeSelectViewModel()
@property (nonatomic,assign) int rssiValue;
@property (nonatomic,assign) int modeValue;
@property (nonatomic,assign) int langValue;
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^sliderCallback)(UIViewController * viewController,UISlider * slider,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^switchCallback)(UIViewController * viewController,UISwitch * onSwitch,UITableViewCell * tableViewCell);
@end

@implementation ModeSelectViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getButtonCallback];
        [self getSliderCallback];
        [self getSwitchCallback];
        [self getWillDisappearCallback];
        [self getCellModels];
    }
    return self;
}

- (void)getCellModels
{
    self.modeValue = (int)[[NSUserDefaults standardUserDefaults]integerForKey:PRODUCTION_MODE_KEY];
    self.rssiValue = (int)[[NSUserDefaults standardUserDefaults]integerForKey:RSSI_KEY];
    self.langValue = (int)[[NSUserDefaults standardUserDefaults]integerForKey:LANG_KEY] == 0 ? 1 : (int)[[NSUserDefaults standardUserDefaults]integerForKey:LANG_KEY];
    if (self.rssiValue == 0)self.rssiValue = 80;
    
    NSMutableArray * cellModels = [NSMutableArray array];
    
    FuncCellModel * model1 = [[FuncCellModel alloc]init];
    model1.typeStr  = @"twoButton";
    model1.titleStr = lang(@"mode");
    BOOL isFactory  = self.modeValue == 0 ? YES : NO;
    model1.data = @[@{@"title":lang(@"update mode"),@"state":[NSNumber numberWithBool:isFactory]},
                    @{@"title":lang(@"normal mode"),@"state":[NSNumber numberWithBool:!isFactory]}];
    model1.cellHeight = 70.0f;
    model1.cellClass = [TwoButtonTableViewCell class];
    model1.modelClass = [NSNull class];
    model1.isShowLine = YES;
    model1.buttconCallback = self.buttconCallback;
    [cellModels addObject:model1];
    
    EmpltyCellModel * model2 = [[EmpltyCellModel alloc]init];
    model2.typeStr = @"empty";
    model2.cellHeight = 10.0f;
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
    
    EmpltyCellModel * model4 = [[EmpltyCellModel alloc]init];
    model4.typeStr = @"empty";
    model4.cellHeight = 10.0f;
    model4.isShowLine = YES;
    model4.cellClass  = [EmptyTableViewCell class];
    [cellModels addObject:model4];
    
    FuncCellModel * model5 = [[FuncCellModel alloc]init];
    model5.typeStr = @"twoButton";
    model5.titleStr = lang(@"lang");
    isFactory = self.langValue == 1 ? YES : NO;
    model5.data = @[@{@"title":lang(@"chinese"),@"state":[NSNumber numberWithBool:isFactory]},
                    @{@"title":lang(@"english"),@"state":[NSNumber numberWithBool:!isFactory]}];
    model5.cellHeight = 70.0f;
    model5.cellClass = [TwoButtonTableViewCell class];
    model5.modelClass = [NSNull class];
    model5.isShowLine = YES;
    model5.buttconCallback = self.buttconCallback;
    [cellModels addObject:model5];
    
    EmpltyCellModel * model7 = [[EmpltyCellModel alloc]init];
    model7.typeStr = @"empty";
    model7.cellHeight = 10.0f;
    model7.isShowLine = YES;
    model7.cellClass  = [EmptyTableViewCell class];
    [cellModels addObject:model7];
    
    SwitchCellModel * model6 = [[SwitchCellModel alloc]init];
    model6.typeStr = @"oneSwitch";
    model6.titleStr = lang(@"show log");
    model6.data = @[@([IDOConsoleBoard borad].isShow)];
    model6.cellHeight = 60.0f;
    model6.cellClass = [OneSwitchTableViewCell class];
    model6.modelClass = [NSNull class];
    model6.isShowLine = YES;
    model6.switchCallback = self.switchCallback;
    [cellModels addObject:model6];
    
    
    
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
        if (indexPath.row == 0) {
            strongSelf.modeValue = twoCell.button1.isSelected ? 0 : 1;
            funcCellModel.data   = @[@{@"title":lang(@"update mode"),@"state":[NSNumber numberWithBool:twoCell.button1.isSelected]},
                                     @{@"title":lang(@"normal mode"),@"state":[NSNumber numberWithBool:twoCell.button2.isSelected]}];
        }else {
            strongSelf.langValue = twoCell.button1.isSelected ? 1 : 2;
            [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:strongSelf.langValue] forKey:LANG_KEY];
            funcVc.title = lang(@"parameter select");
            NSString * stateStr = IDO_BLUE_ENGINE.managerEngine.isConnected ? lang(@"connected") : IDO_BLUE_ENGINE.managerEngine.isConnecting ? lang(@"connecting") : lang(@"scanning");
            funcVc.statusLabel.text = stateStr;
            [strongSelf getCellModels];
            [funcVc reloadData];
        }
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

- (void)getSwitchCallback
{
    __weak typeof(self) weakSelf = self;
    self.switchCallback = ^(UIViewController *viewController, UISwitch *onSwitch, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        SwitchCellModel * switchCellModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
        switchCellModel.data = @[@(onSwitch.isOn)];
        [funcVC.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        if (onSwitch.isOn) {
            [[IDOConsoleBoard borad]show];
        }else {
            [[IDOConsoleBoard borad]close];
        }
    };
}

@end
