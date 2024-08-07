//
//  GetViewModel.m
//  IDOBluetoothDemo
//
//  Created by apple on 2018/9/16.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "GetViewModel.h"
#import "FuncCellModel.h"
#import "OneButtonTableViewCell.h"
#import "FuncViewController.h"
#import "GetFuncTableViewModel.h"
#import "GetMacViewModel.h"
#import "GetDeviceViewModel.h"
#import "GetRealTimeViewModel.h"
#import "GetActivityViewModel.h"
#import "GetGpsInfoViewModel.h"
#import "GetStressThresholdModel.h"
#import "GetNotifyStateViewModel.h"
#import "GetVersionInfoViewModel.h"
#import "GetStartCountViewModel.h"
#import "GetOtaAuthInfoViewModel.h"
#import "GetFlashInfoViewModel.h"
#import "GetBatteryInfoViewModel.h"
#import "GetDefaultLanguageViewModel.h"
#import "GetMenuListViewModel.h"
#import "GetDefaultSportViewModel.h"
#import "GetErrorLogViewModel.h"
#import "GetV3AlarmsViewModel.h"
#import "GetV3HearRateViewModel.h"
#import "GetV2HearRateViewModel.h"

#import "GetMtuInfoViewModel.h"
#import "GetOverHeatLogViewModel.h"
#import "GetNoDisturbViewModel.h"
#import "GetBatteryLogViewModel.h"
#import "GetEncryptionCodeViewModel.h"
#import "GetCalorieDistanceGoalViewModel.h"
#import "GetWalkReminderViewModel.h"
#import "GetHealthSwitchViewModel.h"
#import "GetMainUiSortViewModel.h"
#import "GetScheduleRemindViewModel.h"
#import "GetV3NotifyStateViewModel.h"
#import "GetSportSortViewModel.h"
#import "GetV3LevelModel.h"
#import "GetAlgVersionViewModel.h"
@interface GetViewModel()
@property (nonatomic,strong) NSArray * buttonTitles;
@property (nonatomic,strong) NSArray * modelClasss;
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation GetViewModel
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
        _buttonTitles = @[@[lang(@"get function list")],
                          @[lang(@"get Mac address")],
                          @[lang(@"get device information")],
                          @[lang(@"get real-time data")],
                          @[lang(@"get the number of activities")],
                          @[lang(@"get GPS information")],
                          @[lang(@"get PressureThreshold information")],
                          @[lang(@"get notification status")],
                          @[lang(@"get version information")],
                          @[lang(@"get the number of stars")],
                          @[lang(@"get ota auth information")],
                          @[lang(@"get flash info")],
                          @[lang(@"get battery info")],
                          @[lang(@"get default language")],
                          @[lang(@"get menu list")],
                          @[lang(@"get default sport type")],
                          @[lang(@"get error log state")],
                          @[lang(@"get v3 alarms info")],
                          @[lang(@"get v3 heart rate mode")],
                          @[lang(@"get v2 heart rate mode")],
                          @[lang(@"get blue mtu info")],
                          @[lang(@"get over heat log")],
                          @[lang(@"get device battery log")],
                          @[lang(@"get not disturb mode")],
                          @[lang(@"get encrypted code")],
                          @[lang(@"get target info")],
                          @[lang(@"get walk reminder")],
                          @[lang(@"get health switch state")],
                          @[lang(@"get main ui sort")],
                          @[lang(@"get schedule reminder")],
                          @[lang(@"get V3 notification status")], //"get V3 notification status"
                          @[lang(@"get sport sort")],
                          @[lang(@"get level 3 version info")],
                          @[lang(@"get alg version")]
                        ];
    }
    return _buttonTitles;
}

- (NSArray *)modelClasss
{
    if (!_modelClasss) {
        _modelClasss = @[[GetFuncTableViewModel class],
                         [GetMacViewModel class],
                         [GetDeviceViewModel class],
                         [GetRealTimeViewModel class],
                         [GetActivityViewModel class],
                         [GetGpsInfoViewModel class],
                         [GetStressThresholdModel class],
                         [GetNotifyStateViewModel class],
                         [GetVersionInfoViewModel class],
                         [GetStartCountViewModel class],
                         [GetOtaAuthInfoViewModel class],
                         [GetFlashInfoViewModel class],
                         [GetBatteryInfoViewModel class],
                         [GetDefaultLanguageViewModel class],
                         [GetMenuListViewModel class],
                         [GetDefaultSportViewModel class],
                         [GetErrorLogViewModel class],
                         [GetV3AlarmsViewModel class],
                         [GetV3HearRateViewModel class],
                         [GetV2HearRateViewModel class],
                         [GetMtuInfoViewModel class],
                         [GetOverHeatLogViewModel class],
                         [GetBatteryLogViewModel class],
                         [GetNoDisturbViewModel class],
                         [GetEncryptionCodeViewModel class],
                         [GetCalorieDistanceGoalViewModel class],
                         [GetWalkReminderViewModel class],
                         [GetHealthSwitchViewModel class],
                         [GetMainUiSortViewModel class],
                         [GetScheduleRemindViewModel class],
                         [GetV3NotifyStateViewModel class],
                         [GetSportSortViewModel class],
                         [GetV3LevelModel class],
                         [GetAlgVersionViewModel class],
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
