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
#import "SendMessageViewModel.h"
#import "SetMenuListViewModel.h"
#import "SetDrinkWaterViewModel.h"
#import "SetHrSwitchViewModel.h"
#import "SetSportSwitchViewModel.h"
#import "SetSpo2SwitchViewModel.h"
#import "SetBreatheViewModel.h"
#import "SetWalkRemindViewModel.h"
#import "SetPressureSwitchViewModel.h"
#import "SetWashHandReminderViewModel.h"
#import "SetSmartHeartRateModeViewModel.h"
#import "Setv3ScientificSleepViewModel.h"
#import "SetV3TemperatureViewModel.h"
#import "SetV3NoiseViewModel.h"
#import "SetFitnessGuidanceViewModel.h"
#import "SetWorldTimeViewModel.h"
#import "SetWeatchSunTimeViewModel.h"
#import "SetV3WeatherViewModel.h"
#import "SetSportParamSortViewModel.h"
#import "SetV3ScheduleReminderViewModel.h"
#import "SetMainUISortViewModel.h"
#import "SetSyncContactViewModel.h"
#import "SetV3NoticeMessageViewModel.h"
#import "AllWorldTimeViewModel.h"
#import "AllTakeMedicineViewModel.h"
#import "SetEnterOTAViewModel.h"

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
        _buttonTitles = @[@[lang(@"set user info")],
                          @[lang(@"set target info")],
                          @[lang(@"set find phone")],
                          @[lang(@"set hand up identify")],
                          @[lang(@"set left right hand")],
                          @[lang(@"set prevent lost")],
                          @[lang(@"set display mode")],
                          @[lang(@"set smart notfity")],
                          @[lang(@"set current time")],
                          @[lang(@"set alarm remind")],
                          @[lang(@"set long sit remind")],
                          @[lang(@"set weather forecast")],
                          @[lang(@"set heart rate mode")],
                          @[lang(@"set heart rate interval")],
                          @[lang(@"set no disturb mode")],
                          @[lang(@"set device unit")],
                          @[lang(@"set one key sos")],
                          @[lang(@"set shortcut mode")],
                          @[lang(@"set blood pressure calibration")],
                          @[lang(@"set sport shortcut")],
                          @[lang(@"set sport mode sort")],
                          @[lang(@"set screen brightness")],
                          @[lang(@"set music open off")],
                          @[lang(@"set gps info")],
                          @[lang(@"set hot start info")],
                          @[lang(@"set dial parameters")],
                          @[lang(@"set sleep time")],
                          @[lang(@"set menstruation parameter")],
                          @[lang(@"set menstruation remind")],
                          @[lang(@"custom set func")],
                          @[lang(@"send prompt message")],
                          @[lang(@"set menu list")],
                          @[lang(@"set drink water reminder")],
                          @[lang(@"set v3 heart rate mode")],
                          @[lang(@"set sport identify switch")],
                          @[lang(@"set spo2 switch")],
                          @[lang(@"set breathe train")],
                          @[lang(@"set walk reminder")],
                          @[lang(@"set pressure switch")],
                          @[lang(@"set wash hand reminder")],
                          @[lang(@"set smart heart rate")],
                          @[lang(@"set sleep switch")],
                          @[lang(@"set nocturnal temperature switch")],
                          @[lang(@"set noise switch")],
                          @[lang(@"fitness guidance switch")],
                          @[lang(@"set world time")],
                          @[lang(@"sunrise sunset time")],
                          @[lang(@"set V3 weather data")],
                          @[lang(@"set sport param sort")],
                          @[lang(@"set schedule reminder")],
                          @[lang(@"set main interface sort")],
                          @[lang(@"set bule contact")],
                          @[lang(@"set app notify status")],
                          @[lang(@"设置服药记录")],
                          @[lang(@"set enter OTA mode")],
                        ];
    }
    return _buttonTitles;
}

- (NSArray *)modelClasss
{
    if (!_modelClasss) {
        _modelClasss = @[[SetUserInfoViewModel class],
                         [SetTargetViewModel class],
                         [SetFindPhoneViewModel class],
                         [SetHandUpViewModel class],
                         [SetLeftRightHandViewModel class],
                         [SetPreventLostViewModel class],
                         [SetDisplayViewModel class],
                         [SetNotfityViewModel class],
                         [SetTimeViewModel class],
                         [AllAlarmViewModel class],
                         [SetLongSitViewModel class],
                         [SetWeatherViewModel class],
                         [SetHrModeViewModel class],
                         [SetHrIntervalViewModel class],
                         [SetNoDisturbViewModel class],
                         [SetUnitViewModel class],
                         [SetOneKeySosViewModel class],
                         [SetShortcutViewModel class],
                         [SetBloodPressureViewModel class],
                         [SetSportShortcutViewModel class],
                         [SetSportModeSortViewModel class],
                         [SetScreenViewModel class],
                         [SetMusicViewModel class],
                         [SetGpsInfoViewModel class],
                         [SetHotStartViewModel class],
                         [SetDialParamViewModel class],
                         [SetSleepTimeViewModel class],
                         [SetMenstruationViewModel class],
                         [SetMenstruationRemindViewModel class],
                         [SetCustomFuncViewModel class],
                         [SendMessageViewModel class],
                         [SetMenuListViewModel class],
                         [SetDrinkWaterViewModel class],
                         [SetHrSwitchViewModel class],
                         [SetSportSwitchViewModel class],
                         [SetSpo2SwitchViewModel class],
                         [SetBreatheViewModel class],
                         [SetWalkRemindViewModel class],
                         [SetPressureSwitchViewModel class],
                         [SetWashHandReminderViewModel class],
                         [SetSmartHeartRateModeViewModel class],
                         [Setv3ScientificSleepViewModel class],
                         [SetV3TemperatureViewModel class],
                         [SetV3NoiseViewModel class],
                         [SetFitnessGuidanceViewModel class],
                         [AllWorldTimeViewModel class],
                         [SetWeatchSunTimeViewModel class],
                         [SetV3WeatherViewModel class],
                         [SetSportParamSortViewModel class],
                         [SetV3ScheduleReminderViewModel class],
                         [SetMainUISortViewModel class],
                         [SetSyncContactViewModel class],
                         [SetV3NoticeMessageViewModel class],
                         [AllTakeMedicineViewModel class],
                         [SetEnterOTAViewModel class],
                         
                        ];
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
        FuncViewController * newFuncVc = [[FuncViewController alloc] init];
        newFuncVc.model = [[model.modelClass alloc] init];
        newFuncVc.title = [model.data firstObject];
        [funcVc.navigationController pushViewController:newFuncVc animated:YES];
    };
}






@end
