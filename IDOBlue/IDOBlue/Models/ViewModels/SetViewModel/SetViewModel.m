//
//  SetViewModel.m
//  IDOBluetoothDemo
//
//  Created by apple on 2018/9/16.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "SetViewModel.h"
#import "FuncCellModel.h"
#import "FuncViewController.h"
#import "OneButtonTableViewCell.h"
#import "SetUserInfoViewModel.h"
#import "SetTargetViewModel.h"
#import "SetFindPhoneViewModel.h"
#import "SetHandUpViewModel.h"
#import "SetLeftRightHandViewModel.h"
#import "SetPreventLostViewModel.h"
#import "SetDisplayViewModel.h"
#import "SetNotfityViewModel.h"
#import "SetTimeViewModel.h"
#import "AllAlarmViewModel.h"
#import "SetLongSitViewModel.h"
#import "SetWeatherViewModel.h"
#import "SetHrModeViewModel.h"
#import "SetHrIntervalViewModel.h"
#import "SetNoDisturbViewModel.h"
#import "SetUnitViewModel.h"
#import "SetOneKeySosViewModel.h"
#import "SetShortcutViewModel.h"
#import "SetBloodPressureViewModel.h"
#import "SetSportShortcutViewModel.h"
#import "SetScreenViewModel.h"
#import "SetMusicViewModel.h"
#import "SetGpsInfoViewModel.h"
#import "SetHotStartViewModel.h"
#import "SetDialParamViewModel.h"
#import "SetSleepTimeViewModel.h"

@interface SetViewModel()
@property (nonatomic,strong) NSArray * buttonTitles;
@property (nonatomic,strong) NSArray * modelClasss;
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation SetViewModel
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
        _buttonTitles = @[@[@"设置个人信息"],@[@"设置目标信息"],@[@"设置寻找手机"],@[@"设置抬腕识别"],
                          @[@"设置左右手穿戴"],@[@"设置丢失提醒"],@[@"设置显示模式"],@[@"设置智能提醒"],
                          @[@"设置当前时间"],@[@"设置闹钟提醒"],@[@"设置久坐提醒"],@[@"设置天气预报"],
                          @[@"设置心率模式"],@[@"设置心率区间"],@[@"设置勿扰模式"],@[@"设置设备单位"],
                          @[@"设置一键呼叫"],@[@"设置快捷方式"],@[@"设置血压校准"],@[@"设置运动快捷"],
                          @[@"设置屏幕亮度"],@[@"设置音乐开关"],@[@"设置GPS信息"],@[@"设置启动参数"],
                          @[@"设置表盘参数"],@[@"设置睡眠时间"]];
    }
    return _buttonTitles;
}

- (NSArray *)modelClasss
{
    if (!_modelClasss) {
        _modelClasss = @[[SetUserInfoViewModel class],[SetTargetViewModel class],[SetFindPhoneViewModel class],[SetHandUpViewModel class],
                         [SetLeftRightHandViewModel class],[SetPreventLostViewModel class],[SetDisplayViewModel class],[SetNotfityViewModel class],
                         [SetTimeViewModel class],[AllAlarmViewModel class],[SetLongSitViewModel class],[SetWeatherViewModel class],
                         [SetHrModeViewModel class],[SetHrIntervalViewModel class],[SetNoDisturbViewModel class],[SetUnitViewModel class],
                         [SetOneKeySosViewModel class],[SetShortcutViewModel class],[SetBloodPressureViewModel class],[SetSportShortcutViewModel class],
                         [SetScreenViewModel class],[SetMusicViewModel class],[SetGpsInfoViewModel class],[SetHotStartViewModel class],
                         [SetDialParamViewModel class],[SetSleepTimeViewModel class]];
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
        model.data = data;
        model.cellHeight = 70.0f;
        model.cellClass = [OneButtonTableViewCell class];
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
