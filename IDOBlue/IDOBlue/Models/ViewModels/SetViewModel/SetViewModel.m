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
#import "SetSportModeSortViewModel.h"
#import "SetScreenViewModel.h"
#import "SetMusicViewModel.h"
#import "SetGpsInfoViewModel.h"
#import "SetHotStartViewModel.h"
#import "SetDialParamViewModel.h"
#import "SetSleepTimeViewModel.h"
#import "SetMenstruationViewModel.h"
#import "SetMenstruationRemindViewModel.h"
#import "SetCustomFuncViewModel.h"

@interface SetViewModel()
@property (nonatomic,strong) NSArray * buttonTitles;
@property (nonatomic,strong) NSArray * modelClasss;
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation SetViewModel

- (void)dealloc
{
    
}

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
        _buttonTitles = @[@[lang(@"set user info")],@[lang(@"set target info")],@[lang(@"set find phone")],@[lang(@"set hand up identify")],
                          @[lang(@"set left right hand")],@[lang(@"set prevent lost")],@[lang(@"set display mode")],@[lang(@"set smart notfity")],
                          @[lang(@"set current time")],@[lang(@"set alarm remind")],@[lang(@"set long sit remind")],@[lang(@"set weather forecast")],
                          @[lang(@"set heart rate mode")],@[lang(@"set heart rate interval")],@[lang(@"set no disturb mode")],@[lang(@"set device unit")],
                          @[lang(@"set one key sos")],@[lang(@"set shortcut mode")],@[lang(@"set blood pressure calibration")],@[lang(@"set sport shortcut")],
                          @[lang(@"set sport mode sort")],@[lang(@"set screen brightness")],@[lang(@"set music open off")],@[lang(@"set gps info")],
                          @[lang(@"set hot start info")],@[lang(@"set dial parameters")],@[lang(@"set sleep time")],@[lang(@"set menstruation parameter")],
                          @[lang(@"set menstruation remind")],@[lang(@"custom set func")]];
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
                         [SetSportModeSortViewModel class],[SetScreenViewModel class],[SetMusicViewModel class],[SetGpsInfoViewModel class],
                         [SetHotStartViewModel class],[SetDialParamViewModel class],[SetSleepTimeViewModel class],[SetMenstruationViewModel class],
                         [SetMenstruationRemindViewModel class],[SetCustomFuncViewModel class]];
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
        __strong typeof(SetViewModel *) strongSelf = weakSelf;
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
