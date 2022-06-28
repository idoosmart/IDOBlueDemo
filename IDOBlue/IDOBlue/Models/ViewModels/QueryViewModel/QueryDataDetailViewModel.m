//
//  QueryDataDetailViewModel.m
//  IDOBlue
//
//  Created by 何东阳 on 2019/3/12.
//  Copyright © 2019年 hedongyang. All rights reserved.
//

#import "QueryDataDetailViewModel.h"
#import "TextViewCellModel.h"
#import "FuncCellModel.h"
#import "FuncViewController.h"
#import "OneButtonTableViewCell.h"
#import "OneTextViewTableViewCell.h"
#import "NSObject+ModelToDic.h"

@interface QueryDataDetailViewModel()
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^textViewCallback)(UITextView * textView);
@property (nonatomic,strong) UITextView * textView;
@property (nonatomic,copy) NSString * macAddr;
@property (nonatomic,assign) NSInteger year;
@property (nonatomic,assign) NSInteger month;
@property (nonatomic,assign) NSInteger day;
@property (nonatomic,assign) NSInteger week;
@end

@implementation QueryDataDetailViewModel


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.macAddr = @"";
        self.rightButtonTitle = @"🔒";
        self.isRightButton = YES;
        self.rightButton   = @selector(actionButton:);
        [self initTime];
        [self getTextViewCallback];
        [self getButtonCallback];
        [self getCellModels];
    }
    return self;
}

- (void)actionButton:(UIBarButtonItem *)sender
{
    if ([sender.title isEqualToString:@"🔒"]) {
        self.macAddr = __IDO_MAC_ADDR__;
        [sender setTitle:@"🔓"];
    }else {
        self.macAddr = @"";
        [sender setTitle:@"🔒"];
    }
}

- (void)initTime
{
    IDOSetTimeInfoBluetoothModel * time = [IDOSetTimeInfoBluetoothModel new];
    if (__IDO_FUNCTABLE__.funcTable28Model.utcTimeZone) {
        time = [IDOSetTimeInfoBluetoothModel getCurrentUtcTimeModel];
    }
    self.year  = time.year;
    self.month = time.month;
    self.day   = time.day;
    self.week  = 0;
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    
    TextViewCellModel * model1 = [[TextViewCellModel alloc]init];
    model1.typeStr = @"oneTextView";
    model1.data = @[@""];
    model1.textViewCallback = self.textViewCallback;
    model1.cellHeight = 310;
    model1.isShowLine = YES;
    model1.cellClass  = [OneTextViewTableViewCell class];
    [cellModels addObject:model1];
    
    FuncCellModel * model2 = [[FuncCellModel alloc]init];
    model2.typeStr = @"oneButton";
    model2.data    = @[lang(@"previous year")];
    model2.cellHeight = 70.0f;
    model2.index = 0;
    model2.cellClass  = [OneButtonTableViewCell class];
    model2.modelClass = [NSNull class];
    model2.isShowLine = YES;
    model2.buttconCallback = self.buttconCallback;
    [cellModels addObject:model2];
    
    FuncCellModel * model3 = [[FuncCellModel alloc]init];
    model3.typeStr = @"oneButton";
    model3.data    = @[lang(@"next year")];
    model3.cellHeight = 70.0f;
    model3.index = 1;
    model3.cellClass  = [OneButtonTableViewCell class];
    model3.modelClass = [NSNull class];
    model3.isShowLine = YES;
    model3.buttconCallback = self.buttconCallback;
    [cellModels addObject:model3];
    
    self.cellModels = cellModels;
}

- (void)setTimeType:(NSInteger)timeType
{
    _timeType = timeType;
    FuncViewController * funcVc = (FuncViewController *)[IDODemoUtility getCurrentVC];
    switch (_timeType) {
        case 0:
        {
            NSIndexPath * indexPath1 = [NSIndexPath indexPathForRow:1 inSection:0];
            NSIndexPath * indexPath2 = [NSIndexPath indexPathForRow:2 inSection:0];
            FuncCellModel * model1 = [self.cellModels objectAtIndex:1];
            FuncCellModel * model2 = [self.cellModels lastObject];
            model1.data = @[lang(@"previous year")];
            model2.data = @[lang(@"next year")];
            [funcVc.tableView reloadRowsAtIndexPaths:@[indexPath1,indexPath2] withRowAnimation:UITableViewRowAnimationNone];
        }
            break;
        case 1:
        {
            NSIndexPath * indexPath1 = [NSIndexPath indexPathForRow:1 inSection:0];
            NSIndexPath * indexPath2 = [NSIndexPath indexPathForRow:2 inSection:0];
            FuncCellModel * model1 = [self.cellModels objectAtIndex:1];
            FuncCellModel * model2 = [self.cellModels lastObject];
            model1.data = @[lang(@"previous month")];
            model2.data = @[lang(@"next month")];
            [funcVc.tableView reloadRowsAtIndexPaths:@[indexPath1,indexPath2] withRowAnimation:UITableViewRowAnimationNone];
        }
            break;
        case 2:
        {
            NSIndexPath * indexPath1 = [NSIndexPath indexPathForRow:1 inSection:0];
            NSIndexPath * indexPath2 = [NSIndexPath indexPathForRow:2 inSection:0];
            FuncCellModel * model1 = [self.cellModels objectAtIndex:1];
            FuncCellModel * model2 = [self.cellModels lastObject];
            model1.data = @[lang(@"previous week")];
            model2.data = @[lang(@"next week")];
            [funcVc.tableView reloadRowsAtIndexPaths:@[indexPath1,indexPath2] withRowAnimation:UITableViewRowAnimationNone];
        }
            break;
        case 3:
        {
            NSIndexPath * indexPath1 = [NSIndexPath indexPathForRow:1 inSection:0];
            NSIndexPath * indexPath2 = [NSIndexPath indexPathForRow:2 inSection:0];
            FuncCellModel * model1 = [self.cellModels objectAtIndex:1];
            FuncCellModel * model2 = [self.cellModels lastObject];
            model1.data = @[lang(@"previous day")];
            model2.data = @[lang(@"next day")];
            [funcVc.tableView reloadRowsAtIndexPaths:@[indexPath1,indexPath2] withRowAnimation:UITableViewRowAnimationNone];
        }
            break;
        case 4:
        {
            TextViewCellModel * model1 = [self.cellModels firstObject];
            FuncCellModel * model2 = [self.cellModels objectAtIndex:1];
            model2.data = @[lang(@"query all data")];
            self.cellModels = @[model1,model2];
            [funcVc.tableView reloadData];
        }
            break;
        default:
            break;
    }
}

- (void)getTextViewCallback
{
    __weak typeof(self) weakSelf = self;
    self.textViewCallback = ^(UITextView *textView) {
        __strong typeof(self) strongSelf = weakSelf;
        strongSelf.textView = textView;
        FuncViewController * funcVc = (FuncViewController *)[IDODemoUtility getCurrentVC];
        [strongSelf queryHealthWtithVc:funcVc];
    };
}


- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVc = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVc.tableView indexPathForCell:tableViewCell];
        FuncCellModel * funcModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
        if (funcModel.index == 0) {
            if (strongSelf.timeType == 0) {//上一年
                strongSelf.year --;
            }else if (strongSelf.timeType == 1) {//上一月
                strongSelf.month --;
                if (strongSelf.month == 0) {
                    strongSelf.month = 12;
                    strongSelf.year --;
                }
                
            }else if (strongSelf.timeType == 2) {//上一周
                strongSelf.week ++;
                
            }else if (strongSelf.timeType == 3) {//上一日
                strongSelf.day --;
                if (strongSelf.day == 0) {
                    strongSelf.month --;
                    strongSelf.day = [IDODemoUtility getDaysInMonthWithYear:strongSelf.year month:strongSelf.month];
                    if (strongSelf.month == 0) {
                        strongSelf.month = 12;
                        strongSelf.year --;
                    }
                }
            }
            [strongSelf queryHealthWtithVc:funcVc];
        }else {
            if (strongSelf.timeType == 0) {//下一年
                strongSelf.year ++;
                
            }else if (strongSelf.timeType == 1) {//下一月
                strongSelf.month ++;
                if (strongSelf.month > 12) {
                    strongSelf.month = 1;
                    strongSelf.year ++;
                }
            }else if (strongSelf.timeType == 2) {//下一周
                strongSelf.week --;
               
            }else if (strongSelf.timeType == 3) {//下一日
                strongSelf.day ++;
                NSInteger day = [IDODemoUtility getDaysInMonthWithYear:strongSelf.year month:strongSelf.month];
                if (strongSelf.day > day) {
                    strongSelf.month --;
                    strongSelf.day = [IDODemoUtility getDaysInMonthWithYear:strongSelf.year month:strongSelf.month];
                    if (strongSelf.month == 0) {
                        strongSelf.month = 12;
                        strongSelf.year --;
                    }
                }
            }
            [strongSelf queryHealthWtithVc:funcVc];
        }
    };
}

- (void)queryHealthWtithVc:(FuncViewController *)funcVc
{
    if (self.timeType == 0) {// year
        if (self.dataType == 0) {//sports
           [self querySportsYearDataWtithVc:funcVc];
        }else if (self.dataType == 1) {//heart rate
           [self queryHrsYearDataWtithVc:funcVc];
        }else if (self.dataType == 2) {//blood pressure
           [self queryBpsYearDataWtithVc:funcVc];
        }else if (self.dataType == 3) {//sleep
           [self querySleepsYearDataWtithVc:funcVc];
        }else if (self.dataType == 4) {//blood oxygen
           [self queryBopsYearDataWtithVc:funcVc];
        }else if (self.dataType == 5) {//pressure
           [self queryPressuresYearDataWtithVc:funcVc];
        }else if (self.dataType == 6) {//noise
            [self queryNoiseYearDataWtithVc:funcVc];
        }else if (self.dataType == 7) {//temperature
            [self queryTemperaturesYearDataWtithVc:funcVc];
        }else if (self.dataType == 8) {//breath rate
            [self queryBreathRatesYearDataWtithVc:funcVc];
        }else if (self.dataType == 9) {//body power
            [self queryBodyPowersYearDataWtithVc:funcVc];
        }
    }else if (self.timeType == 1) {//month
        if (self.dataType == 0) {//sports
            [self querySportsMonthDataWtithVc:funcVc];
        }else if (self.dataType == 1) {//heart rate
            [self queryHrsMonthDataWtithVc:funcVc];
        }else if (self.dataType == 2) {//blood pressure
            [self queryBpsMonthDataWtithVc:funcVc];
        }else if (self.dataType == 3) {//sleep
            [self querySleepsMonthDataWtithVc:funcVc];
        }else if (self.dataType == 4) {//blood oxygen
            [self queryBopsMonthDataWtithVc:funcVc];
        }else if (self.dataType == 5) {//pressure
            [self queryPressuresMonthDataWtithVc:funcVc];
        }else if (self.dataType == 6) {//noise
            [self queryNoisesMonthDataWtithVc:funcVc];
        }else if (self.dataType == 7) {//temperature
            [self queryTemperaturesMonthDataWtithVc:funcVc];
        }else if (self.dataType == 8) {//breath rate
            [self queryBreathRatesMonthDataWtithVc:funcVc];
        }else if (self.dataType == 9) {//body power
            [self queryBodyPowersMonthDataWtithVc:funcVc];
        }
    }else if (self.timeType == 2) {//week
        if (self.dataType == 0) {//sports
            [self querySportsWeekDataWtithVc:funcVc];
        }else if (self.dataType == 1) {//heart rate
            [self queryHrsWeekDataWtithVc:funcVc];
        }else if (self.dataType == 2) {//blood pressure
            [self queryBpsWeekDataWtithVc:funcVc];
        }else if (self.dataType == 3) {//sleep
            [self querySleepsWeekDataWtithVc:funcVc];
        }else if (self.dataType == 4) {//blood oxygen
            [self queryBopsWeekDataWtithVc:funcVc];
        }else if (self.dataType == 5) {//pressure
            [self queryPressuresWeekDataWtithVc:funcVc];
        }else if (self.dataType == 6) {//noise
            [self queryNoisesWeekDataWtithVc:funcVc];
        }else if (self.dataType == 7) {//temperature
            [self queryTemperaturesWeekDataWtithVc:funcVc];
        }else if (self.dataType == 8) {//breath rate
            [self queryBreathRatesWeekDataWtithVc:funcVc];
        }else if (self.dataType == 9) {//body power
            [self queryBodyPowersWeekDataWtithVc:funcVc];
        }
    }else if (self.timeType == 3) {//day
        if (self.dataType == 0) {//sports
            [self querySportsDayDataWtithVc:funcVc];
        }else if (self.dataType == 1) {//heart rate
            [self queryHrsDayDataWtithVc:funcVc];
        }else if (self.dataType == 2) {//blood pressure
            [self queryBpsDayDataWtithVc:funcVc];
        }else if (self.dataType == 3) {//sleep
            [self querySleepsDayDataWtithVc:funcVc];
        }else if (self.dataType == 4) {//blood oxygen
            [self queryBopsDayDataWtithVc:funcVc];
        }else if (self.dataType == 5) {//pressure
            [self queryPressuresDayDataWtithVc:funcVc];
        }else if (self.dataType == 6) {//noise
            [self queryNoisesDayDataWtithVc:funcVc];
        }else if (self.dataType == 7) {//temperature
            [self queryTemperaturesDayDataWtithVc:funcVc];
        }else if (self.dataType == 8) {//breath rate
            [self queryBreathRatesDayDataWtithVc:funcVc];
        }else if (self.dataType == 9) {//body power
            [self queryBodyPowersDayDataWtithVc:funcVc];
        }
    }else if (self.timeType == 4) {// all data
        if (self.dataType == 0) {//sports
            [self queryAllSportsDataWtithVc:funcVc];
        }else if (self.dataType == 1) {//heart rate
            [self queryAllHrsDataWtithVc:funcVc];
        }else if (self.dataType == 2) {//blood pressure
            [self queryAllBpsDataWtithVc:funcVc];
        }else if (self.dataType == 3) {//sleep
            [self queryAllSleepcsDataWtithVc:funcVc];
        }else if (self.dataType == 4) {//blood oxygen
            [self queryAllBopsDataWtithVc:funcVc];
        }else if (self.dataType == 5) {//pressure
            [self queryAllPressuresDataWtithVc:funcVc];
        }else if (self.dataType == 6) {//noise
            [self queryAllNoisesDataWtithVc:funcVc];
        }else if (self.dataType == 7) {//temperature
            [self queryAllTemperaturesDataWtithVc:funcVc];
        }else if (self.dataType == 8) {//breath rate
            [self queryAllBreathRatesDataWtithVc:funcVc];
        }else if (self.dataType == 9) {//body power
            [self queryAllBodyPowersDataWtithVc:funcVc];
        }
    }
}

#pragma mark ==== query sport step data =================

- (void)querySportsYearDataWtithVc:(FuncViewController *)funcVc
{
    NSArray * array = nil;
    if (__IDO_FUNCTABLE__.funcTable30Model.v3Sports
        || __IDO_FUNCTABLE__.funcTable36Model.stepsOneMinute) { //v3 sports
        array = [IDOSyncV3SportDataModel queryOneYearV3SportsWithYear:self.year
                                                              macAddr:self.macAddr
                                                         isQueryItems:NO];
    }else {
        array = [IDOSyncSportDataModel queryOneYearSportsWithYear:self.year
                                                          macAddr:self.macAddr
                                                     isQueryItems:NO];
    }
    if (array.count == 0) {
        self.textView.text = lang(@"current year no data");
        [funcVc showToastWithText:lang(@"current year no data")];
    }else {
        NSMutableArray * oneYearSports = [NSMutableArray array];
        for (NSArray * oneMonthSports in array) {
            for (IDOSyncSportDataInfoBluetoothModel * oneDaySport in oneMonthSports) {
                NSDictionary * dic = oneDaySport.dicFromObject;
                [oneYearSports addObject:dic];
            }
        }
        self.textView.text = [NSString stringWithFormat:@"%ld\n%@",(long)self.year,
                              oneYearSports.count > 0 ? oneYearSports : lang(@"no data")];
    }
}

- (void)querySportsMonthDataWtithVc:(FuncViewController *)funcVc
{
    NSArray * days = nil;
    NSArray * array = nil;
    if (   __IDO_FUNCTABLE__.funcTable30Model.v3Sports
        || __IDO_FUNCTABLE__.funcTable36Model.stepsOneMinute) { //v3 sports
        array = [IDOSyncV3SportDataModel queryOneMonthV3SportsWithYear:self.year
                                                                 month:self.month
                                                               macAddr:self.macAddr
                                                          datesOfMonth:&days
                                                          isQueryItems:NO];
    }else {
        array = [IDOSyncSportDataModel queryOneMonthSportsWithYear:self.year
                                                            month:self.month
                                                          macAddr:self.macAddr
                                                     datesOfMonth:&days
                                                     isQueryItems:NO];
    }
    if (array.count == 0) {
        self.textView.text = lang(@"current month no data");
        [funcVc showToastWithText:lang(@"current month no data")];
    }else {
        NSMutableArray * oneMonthSports = [NSMutableArray array];
        for (IDOSyncSportDataInfoBluetoothModel * oneDaySport in array) {
            NSDictionary * dic = oneDaySport.dicFromObject;
            [oneMonthSports addObject:dic];
        }
        self.textView.text = [NSString stringWithFormat:@"%@-%@\n%@",[days firstObject],
                              [days lastObject],oneMonthSports.count > 0 ? oneMonthSports : lang(@"no data")];
    }
}

- (void)querySportsWeekDataWtithVc:(FuncViewController *)funcVc
{
    NSArray * days = nil;
    NSArray * array = nil;
    if (   __IDO_FUNCTABLE__.funcTable30Model.v3Sports
        || __IDO_FUNCTABLE__.funcTable36Model.stepsOneMinute) { //v3 sports
        array = [IDOSyncV3SportDataModel queryOneWeekV3SportsWithWeekIndex:self.week
                                                         weekStartDay:0
                                                              macAddr:self.macAddr
                                                          datesOfWeek:&days
                                                         isQueryItems:NO];
    }else {
        array = [IDOSyncSportDataModel queryOneWeekSportsWithWeekIndex:self.week
                                                         weekStartDay:0
                                                              macAddr:self.macAddr
                                                          datesOfWeek:&days
                                                         isQueryItems:NO];
    }
    if (array.count == 0) {
        self.textView.text = lang(@"current week no data");
        [funcVc showToastWithText:lang(@"current week no data")];
    }else {
        NSMutableArray * oneWeekSports = [NSMutableArray array];
        for (IDOSyncSportDataInfoBluetoothModel * oneDaySport in array) {
            NSDictionary * dic = oneDaySport.dicFromObject;
            [oneWeekSports addObject:dic];
        }
        self.textView.text = [NSString stringWithFormat:@"%@-%@\n%@",[days firstObject],[days lastObject],
                              oneWeekSports.count > 0 ? oneWeekSports : lang(@"no data")];
    }
}

- (void)querySportsDayDataWtithVc:(FuncViewController *)funcVc
{
    NSArray * array = nil;
    if (   __IDO_FUNCTABLE__.funcTable30Model.v3Sports
        || __IDO_FUNCTABLE__.funcTable36Model.stepsOneMinute) { //v3 sports
        array = [IDOSyncV3SportDataModel queryOneDayV3SportDetailWithMac:self.macAddr
                                                              year:self.year
                                                             month:self.month
                                                               day:self.day];
    }else {
        array = [IDOSyncSportDataModel queryOneDaySportDetailWithMac:self.macAddr
                                                              year:self.year
                                                             month:self.month
                                                               day:self.day];
    }
    if (array.count == 0) {
        self.textView.text = lang(@"current day no data");
        [funcVc showToastWithText:lang(@"current day no data")];
    }else {
        NSMutableArray * oneDaySports = [NSMutableArray array];
        for (IDOSyncSportDataInfoBluetoothModel * sportModel in array) {
            NSDictionary * dic = sportModel.dicFromObject;
            [oneDaySports addObject:dic];
        }
        self.textView.text = [NSString stringWithFormat:@"%ld-%ld-%ld\n%@",(long)self.year,(long)self.month,
                              (long)self.day,oneDaySports.count > 0 ? oneDaySports : lang(@"no data")];
    }
}


- (void)queryAllSportsDataWtithVc:(FuncViewController *)funcVc
{
    NSArray * array = nil;
    if (   __IDO_FUNCTABLE__.funcTable30Model.v3Sports
        || __IDO_FUNCTABLE__.funcTable36Model.stepsOneMinute) { //v3 sports
        array = [IDOSyncV3SportDataModel queryAllV3SportsWithMac:self.macAddr];
    }else {
        array = [IDOSyncSportDataModel queryAllSportsWithMac:self.macAddr];
    }
    if (!array || array.count == 0) {
        self.textView.text = lang(@"no data");
        [funcVc showToastWithText:lang(@"no data")];
    }else {
        self.textView.text = [NSString stringWithFormat:@"%@:%ld\n%@",lang(@"data count"),
                              (long)array.count,array.count > 0 ? array : lang(@"no data")];
    }
}

#pragma mark ==== query heart rate data =================

- (void)queryHrsYearDataWtithVc:(FuncViewController *)funcVc
{
    NSArray * array = [NSArray array];
    if(__IDO_FUNCTABLE__.funcTable22Model.v3HrData) {   //v3 heart rate
        array = [IDOSyncHeartRateDataModel queryOneYearSecHearRatesWithYear:self.year
                                                                    macAddr:self.macAddr
                                                               isQueryItems:NO];
    }else { //v2 heart rate
        array = [IDOSyncHeartRateDataModel queryOneYearHearRatesWithYear:self.year
                                                                 macAddr:self.macAddr
                                                            isQueryItems:NO];
    }
    if (array.count == 0) {
        self.textView.text = lang(@"current year no data");
        [funcVc showToastWithText:lang(@"current year no data")];
    }else {
        NSMutableArray * oneYearHrs = [NSMutableArray array];
        for (NSArray * oneMonthHrs in array) {
            for (IDOBluetoothBaseModel * modle in oneMonthHrs) {
                NSDictionary * dic = modle.dicFromObject;
                [oneYearHrs addObject:dic];
            }
        }
        self.textView.text = [NSString stringWithFormat:@"%ld\n%@",(long)self.year,
                              oneYearHrs.count > 0 ? oneYearHrs : lang(@"no data")];
    }
}

- (void)queryHrsMonthDataWtithVc:(FuncViewController *)funcVc
{
    NSArray * days = nil;
    NSArray * array = [NSArray array];
    if(__IDO_FUNCTABLE__.funcTable22Model.v3HrData) { //v3 heart rate
        array = [IDOSyncHeartRateDataModel queryOneMonthSecHearRatesWithYear:self.year
                                                                        month:self.month
                                                                      macAddr:self.macAddr
                                                                 datesOfMonth:&days
                                                                 isQueryItems:NO];
    }else {
        array = [IDOSyncHeartRateDataModel queryOneMonthHearRatesWithYear:self.year
                                                                    month:self.month
                                                                  macAddr:self.macAddr
                                                             datesOfMonth:&days
                                                             isQueryItems:NO];
    }
    if (array.count == 0) {
        self.textView.text = lang(@"current month no data");
        [funcVc showToastWithText:lang(@"current month no data")];
    }else {
        NSMutableArray * oneMonthHrs = [NSMutableArray array];
        for (IDOBluetoothBaseModel * modle in array) {
            NSDictionary * dic = modle.dicFromObject;
            [oneMonthHrs addObject:dic];
        }
        self.textView.text = [NSString stringWithFormat:@"%@-%@\n%@",[days firstObject],[days lastObject],
                              oneMonthHrs.count > 0 ? oneMonthHrs : lang(@"no data")];
    }
}

- (void)queryHrsWeekDataWtithVc:(FuncViewController *)funcVc
{
    NSArray * days = nil;
    NSArray * array = [NSArray array];
    if(__IDO_FUNCTABLE__.funcTable22Model.v3HrData) { //v3 heart rate
        array = [IDOSyncHeartRateDataModel queryOneWeekSecHearRatesWithWeekIndex:self.week
                                                                     weekStartDay:0
                                                                          macAddr:self.macAddr
                                                                      datesOfWeek:&days
                                                                     isQueryItems:NO];
    }else {
        array = [IDOSyncHeartRateDataModel queryOneWeekHearRatesWithWeekIndex:self.week
                                                                 weekStartDay:0
                                                                      macAddr:self.macAddr
                                                                  datesOfWeek:&days
                                                                 isQueryItems:NO];
    }
    if (array.count == 0) {
        self.textView.text = lang(@"current week no data");
        [funcVc showToastWithText:lang(@"current week no data")];
    }else {
        NSMutableArray * oneWeekHrs = [NSMutableArray array];
        for (IDOBluetoothBaseModel * modle in array) {
            NSDictionary * dic = modle.dicFromObject;
            [oneWeekHrs addObject:dic];
        }
        self.textView.text = [NSString stringWithFormat:@"%@-%@\n%@",[days firstObject],[days lastObject]
                              ,oneWeekHrs.count > 0 ? oneWeekHrs : lang(@"no data")];
    }
}

- (void)queryHrsDayDataWtithVc:(FuncViewController *)funcVc
{
    NSArray * array = nil;
    if (__IDO_FUNCTABLE__.funcTable22Model.v3HrData) { //v3 heart rate
       array = [IDOSyncHeartRateDataModel queryOneDaySecHearRatesDetailWithMac:self.macAddr
                                                                          year:self.year
                                                                         month:self.month
                                                                           day:self.day
                                                                    isQueryItems:NO];
    }else {
       array = [IDOSyncHeartRateDataModel queryOneDayHearRatesDetailWithMac:self.macAddr
                                                                       year:self.year
                                                                      month:self.month
                                                                        day:self.day];
    }
    if (array.count == 0) {
        self.textView.text = lang(@"current day no data");
        [funcVc showToastWithText:lang(@"current day no data")];
    }else {
        NSMutableArray * oneDayHrs = [NSMutableArray array];
        for (IDOBluetoothBaseModel * hrModel in array) {
            NSDictionary * dic = hrModel.dicFromObject;
            [oneDayHrs addObject:dic];
        }
        self.textView.text = [NSString stringWithFormat:@"%ld-%ld-%ld\n%@",(long)self.year,(long)self.month,
                              (long)self.day,oneDayHrs.count > 0 ? oneDayHrs : lang(@"no data")];
    }
}

- (void)queryAllHrsDataWtithVc:(FuncViewController *)funcVc
{
    NSArray * array = [NSArray array];
    if(__IDO_FUNCTABLE__.funcTable22Model.v3HrData) { //v3 heart rate
        array = [IDOSyncHeartRateDataModel queryAllSecHearRatesWithMac:self.macAddr];
    }else {
        array = [IDOSyncHeartRateDataModel queryAllHearRatesWithMac:self.macAddr];
    }
    if (!array || array.count == 0) {
        self.textView.text = lang(@"no data");
        [funcVc showToastWithText:lang(@"no data")];
    }else {
        self.textView.text = [NSString stringWithFormat:@"%@:%ld\n%@",lang(@"data count"),(long)array.count,
                              array.count > 0 ? array : lang(@"no data")];
    }
}

#pragma mark ==== query blood pressure data =================

- (void)queryBpsYearDataWtithVc:(FuncViewController *)funcVc
{
    if (   !__IDO_FUNCTABLE__.funcTable34Model.supportV3Bp
        && !__IDO_FUNCTABLE__.funcTable18Model.bloodPressure) {
        [funcVc showToastWithText:lang(@"feature is not supported on the current device")];
        return;
    }
    
    NSArray * array = nil;
    if(__IDO_FUNCTABLE__.funcTable34Model.supportV3Bp) { // v3 blood pressure
        array = [IDOSyncV3BpDataModel queryOneYearBpWithYear:self.year
                                                     macAddr:self.macAddr];
    }else {
        array = [IDOSyncBpDataModel queryOneYearBloodPressuresWithYear:self.year
                                                              macAddr:self.macAddr
                                                         isQueryItems:NO];
    }
    if (array.count == 0) {
        self.textView.text = lang(@"current year no data");
        [funcVc showToastWithText:lang(@"current year no data")];
    }else {
        NSMutableArray * oneYearBps = [NSMutableArray array];
        for (NSArray * oneMonthBps in array) {
            for (IDOSyncBpDataInfoBluetoothModel * oneDayBp in oneMonthBps) {
                NSDictionary * dic = oneDayBp.dicFromObject;
                [oneYearBps addObject:dic];
            }
        }
        self.textView.text = [NSString stringWithFormat:@"%ld\n%@",
                              (long)self.year,oneYearBps.count > 0 ? oneYearBps : lang(@"no data")];
    }
}

- (void)queryBpsMonthDataWtithVc:(FuncViewController *)funcVc
{
    if (   !__IDO_FUNCTABLE__.funcTable34Model.supportV3Bp
        && !__IDO_FUNCTABLE__.funcTable18Model.bloodPressure) {
        [funcVc showToastWithText:lang(@"feature is not supported on the current device")];
        return;
    }
    
    NSArray * days = nil;
    NSArray * array = nil;
    if(__IDO_FUNCTABLE__.funcTable34Model.supportV3Bp) {
        array = [IDOSyncV3BpDataModel queryOneMonthBpWithYear:self.year
                                                        month:self.month
                                                      macAddr:self.macAddr
                                                 datesOfMonth:&days];
    }else {
        array = [IDOSyncBpDataModel queryOneMonthBloodPressuresWithYear:self.year
                                                                 month:self.month
                                                               macAddr:self.macAddr
                                                          datesOfMonth:&days
                                                          isQueryItems:NO];
    }
    if (array.count == 0) {
        self.textView.text = lang(@"current month no data");
        [funcVc showToastWithText:lang(@"current month no data")];
    }else {
        NSMutableArray * oneMonthBps = [NSMutableArray array];
        for (IDOSyncSportDataInfoBluetoothModel * oneDayBp in array) {
            NSDictionary * dic = oneDayBp.dicFromObject;
            [oneMonthBps addObject:dic];
        }
        self.textView.text = [NSString stringWithFormat:@"%@-%@\n%@",[days firstObject],
                              [days lastObject],oneMonthBps.count > 0 ? oneMonthBps : lang(@"no data")];
    }
}

- (void)queryBpsWeekDataWtithVc:(FuncViewController *)funcVc
{
    if (   !__IDO_FUNCTABLE__.funcTable34Model.supportV3Bp
        && !__IDO_FUNCTABLE__.funcTable18Model.bloodPressure) {
        [funcVc showToastWithText:lang(@"feature is not supported on the current device")];
        return;
    }
    
    NSArray * days = nil;
    NSArray * array = nil;
    if(__IDO_FUNCTABLE__.funcTable34Model.supportV3Bp) {
        array = [IDOSyncV3BpDataModel queryOneWeekBpWithWeekIndex:self.week
                                                     weekStartDay:0
                                                          macAddr:self.macAddr
                                                      datesOfWeek:&days];
    }else {
        array = [IDOSyncBpDataModel queryOneWeekBloodPressuresWithWeekIndex:self.week
                                                              weekStartDay:0
                                                                   macAddr:self.macAddr
                                                               datesOfWeek:&days
                                                              isQueryItems:NO];
    }
    if (array.count == 0) {
        self.textView.text = lang(@"current week no data");
        [funcVc showToastWithText:lang(@"current week no data")];
    }else {
        NSMutableArray * oneWeekBps = [NSMutableArray array];
        for (IDOSyncBpDataInfoBluetoothModel * oneDayBp in array) {
            NSDictionary * dic = oneDayBp.dicFromObject;
            [oneWeekBps addObject:dic];
        }
        self.textView.text = [NSString stringWithFormat:@"%@-%@\n%@",[days firstObject],[days lastObject],
                              oneWeekBps.count > 0 ? oneWeekBps : lang(@"no data")];
    }
}

- (void)queryBpsDayDataWtithVc:(FuncViewController *)funcVc
{
    if (   !__IDO_FUNCTABLE__.funcTable34Model.supportV3Bp
        && !__IDO_FUNCTABLE__.funcTable18Model.bloodPressure) {
        [funcVc showToastWithText:lang(@"feature is not supported on the current device")];
        return;
    }
    
    NSArray * array = nil;
    if(__IDO_FUNCTABLE__.funcTable34Model.supportV3Bp) {
        array = [IDOSyncV3BpDataModel queryOneDayBpDetailWithMac:self.macAddr
                                                            year:self.year
                                                           month:self.month
                                                             day:self.day];
    }else {
        array = [IDOSyncBpDataModel queryOneDayBloodPressureDetailWithMac:self.macAddr
                                                                    year:self.year
                                                                   month:self.month
                                                                     day:self.day];
    }
    if (array.count == 0) {
        self.textView.text = lang(@"current day no data");
        [funcVc showToastWithText:lang(@"current day no data")];
    }else {
        NSMutableArray * oneDayBps = [NSMutableArray array];
        for (IDOSyncBpDataInfoBluetoothModel * oneDayBp in array) {
            NSDictionary * dic = oneDayBp.dicFromObject;
            [oneDayBps addObject:dic];
        }
        self.textView.text = [NSString stringWithFormat:@"%ld-%ld-%ld\n%@",(long)self.year,(long)self.month,
                              (long)self.day,oneDayBps.count > 0 ? oneDayBps : lang(@"no data")];
    }
}

- (void)queryAllBpsDataWtithVc:(FuncViewController *)funcVc
{
    if (   !__IDO_FUNCTABLE__.funcTable34Model.supportV3Bp
        && !__IDO_FUNCTABLE__.funcTable18Model.bloodPressure) {
        [funcVc showToastWithText:lang(@"feature is not supported on the current device")];
        return;
    }
    
    NSArray * array = nil;
    if(__IDO_FUNCTABLE__.funcTable34Model.supportV3Bp) {
        array = [IDOSyncV3BpDataModel queryAllBpWithMac:self.macAddr];
    }else {
        array = [IDOSyncBpDataModel queryAllBloodPressuresWithMac:self.macAddr];
    }
    if (!array || array.count == 0) {
        self.textView.text = lang(@"no data");
        [funcVc showToastWithText:lang(@"no data")];
    }else {
        self.textView.text = [NSString stringWithFormat:@"%@:%ld\n%@",lang(@"data count"),(long)array.count,
                              array.count > 0 ? array : lang(@"no data")];
    }
}

#pragma mark ==== query sleep data =================

- (void)querySleepsYearDataWtithVc:(FuncViewController *)funcVc
{
    NSArray * array = nil;
    if (__IDO_FUNCTABLE__.funcTable29Model.v3Sleep) {
        array = [IDOSyncV3SleepDataModel v3QueryOneYearSleepsWithYear:self.year
                                                              macAddr:self.macAddr
                                                         isQueryItems:NO];
    }else {
        array = [IDOSyncSleepDataModel queryOneYearSleepsWithYear:self.year
                                                         macAddr:self.macAddr
                                                    isQueryItems:NO];
    }
    if (array.count == 0) {
        self.textView.text = lang(@"current year no data");
        [funcVc showToastWithText:lang(@"current year no data")];
    }else {
        NSMutableArray * oneYearSleeps = [NSMutableArray array];
        for (NSArray * oneMonthSleeps in array) {
            for (IDOCalculateSleepBluetoothModel * oneDaySleep in oneMonthSleeps) {
                NSDictionary * dic = oneDaySleep.dicFromObject;
                [oneYearSleeps addObject:dic];
            }
        }
        self.textView.text = [NSString stringWithFormat:@"%ld\n%@",(long)self.year,
                              oneYearSleeps.count > 0 ? oneYearSleeps : lang(@"no data")];
    }
}

- (void)querySleepsMonthDataWtithVc:(FuncViewController *)funcVc
{
    NSArray * days = nil;
    NSArray * array = nil;
    if (__IDO_FUNCTABLE__.funcTable29Model.v3Sleep) {
        array = [IDOSyncV3SleepDataModel v3QueryOneMonthSleepsWithYear:self.year
                                                                 month:self.month
                                                               macAddr:self.macAddr
                                                          datesOfMonth:&days
                                                          isQueryItems:NO];
    }else {
        array = [IDOSyncSleepDataModel queryOneMonthSleepsWithYear:self.year
                                                            month:self.month
                                                          macAddr:self.macAddr
                                                     datesOfMonth:&days
                                                     isQueryItems:NO];
    }
    if (array.count == 0) {
        self.textView.text = lang(@"current month no data");
        [funcVc showToastWithText:lang(@"current month no data")];
    }else {
        NSMutableArray * oneMonthSleeps = [NSMutableArray array];
        for (IDOSyncSleepDataInfoBluetoothModel * oneDaySleep in array) {
            NSDictionary * dic = oneDaySleep.dicFromObject;
            [oneMonthSleeps addObject:dic];
        }
        self.textView.text = [NSString stringWithFormat:@"%@-%@\n%@",[days firstObject],[days lastObject],
                              oneMonthSleeps.count > 0 ? oneMonthSleeps : lang(@"no data")];
    }
}

- (void)querySleepsWeekDataWtithVc:(FuncViewController *)funcVc
{
    NSArray * days = nil;
    NSArray * array = nil;
    if (__IDO_FUNCTABLE__.funcTable29Model.v3Sleep) {
        array = [IDOSyncV3SleepDataModel v3QueryOneWeekSleepsWithWeekIndex:self.week
                                                              weekStartDay:0
                                                                   macAddr:self.macAddr
                                                               datesOfWeek:&days
                                                              isQueryItems:NO];
    }else {
        array = [IDOSyncSleepDataModel queryOneWeekSleepsWithWeekIndex:self.week
                                                         weekStartDay:0
                                                              macAddr:self.macAddr
                                                          datesOfWeek:&days
                                                         isQueryItems:NO];
    }
    if (array.count == 0) {
        self.textView.text = lang(@"current week no data");
        [funcVc showToastWithText:lang(@"current week no data")];
    }else {
        NSMutableArray * oneWeekSleeps = [NSMutableArray array];
        for (IDOSyncSleepDataInfoBluetoothModel * oneDaySleep in array) {
            NSDictionary * dic = oneDaySleep.dicFromObject;
            [oneWeekSleeps addObject:dic];
        }
        self.textView.text = [NSString stringWithFormat:@"%@-%@\n%@",[days firstObject],[days lastObject],oneWeekSleeps.dicFromObject];
    }
}

- (void)querySleepsDayDataWtithVc:(FuncViewController *)funcVc
{
    NSArray * array = nil;
    if (__IDO_FUNCTABLE__.funcTable29Model.v3Sleep) {
        array = [IDOSyncV3SleepDataModel v3QueryOneDaySleepsDetailWithMac:self.macAddr
                                                                     year:self.year
                                                                    month:self.month
                                                                      day:self.day];
    }else {
        array = [IDOSyncSleepDataModel queryOneDaySleepsDetailWithMac:self.macAddr
                                                               year:self.year
                                                              month:self.month
                                                                day:self.day];
    }
    if (array.count == 0) {
        self.textView.text = lang(@"current day no data");
        [funcVc showToastWithText:lang(@"current day no data")];
    }else {
        NSMutableArray * oneDaySleeps = [NSMutableArray array];
        for (IDOSyncSleepDataInfoBluetoothModel * sleepModel in array) {
            NSDictionary * dic = sleepModel.dicFromObject;
            [oneDaySleeps addObject:dic];
        }
        self.textView.text = [NSString stringWithFormat:@"%ld-%ld-%ld\n%@",(long)self.year,(long)self.month,
                              (long)self.day,oneDaySleeps.count > 0 ? oneDaySleeps : lang(@"no data")];
    }
}

- (void)queryAllSleepcsDataWtithVc:(FuncViewController *)funcVc
{
    NSArray * array = nil;
    if (__IDO_FUNCTABLE__.funcTable29Model.v3Sleep) {
        array = [IDOSyncV3SleepDataModel v3QueryAllSleepsWithMac:self.macAddr];
    }else {
        array = [IDOSyncSleepDataModel queryAllSleepsWithMac:self.macAddr];
    }
    if (!array || array.count == 0) {
        self.textView.text = lang(@"no data");
        [funcVc showToastWithText:lang(@"no data")];
    }else {
        self.textView.text = [NSString stringWithFormat:@"%@:%ld\n%@",lang(@"data count"),(long)array.count,
                              array.count > 0 ? array : lang(@"no data")];
    }
}

#pragma mark ==== query blood oxygen data =================
- (void)queryBopsYearDataWtithVc:(FuncViewController *)funcVc
{
    if (!__IDO_FUNCTABLE__.funcTable20Model.spo2Data) {
        [funcVc showToastWithText:lang(@"feature is not supported on the current device")];
        return;
    }
    NSArray * array = [IDOSyncSpo2DataModel queryOneYearBloodOxygenWithYear:self.year
                                                                    macAddr:self.macAddr
                                                               isQueryItems:NO];
    if (array.count == 0) {
        self.textView.text = lang(@"current year no data");
        [funcVc showToastWithText:lang(@"current year no data")];
    }else {
        NSMutableArray * oneYearBops = [NSMutableArray array];
        for (NSArray * oneMonthBops in array) {
            for (IDOSyncBloodOxygenDataInfoBluetoothModel * oneDayBop in oneMonthBops) {
                NSDictionary * dic = oneDayBop.dicFromObject;
                [oneYearBops addObject:dic];
            }
        }
        self.textView.text = [NSString stringWithFormat:@"%ld\n%@",
                              (long)self.year,oneYearBops.count > 0 ? oneYearBops : lang(@"no data")];
    }
}

- (void)queryBopsMonthDataWtithVc:(FuncViewController *)funcVc
{
    if (!__IDO_FUNCTABLE__.funcTable20Model.spo2Data) {
        [funcVc showToastWithText:lang(@"feature is not supported on the current device")];
        return;
    }
    NSArray * days = nil;
    NSArray * array = [IDOSyncSpo2DataModel queryOneMonthBloodOxygenWithYear:self.year
                                                                       month:self.month
                                                                     macAddr:self.macAddr
                                                                datesOfMonth:&days
                                                                isQueryItems:NO];
    if (array.count == 0) {
        self.textView.text = lang(@"current month no data");
        [funcVc showToastWithText:lang(@"current month no data")];
    }else {
        NSMutableArray * oneMonthBops = [NSMutableArray array];
        for (IDOSyncBloodOxygenDataInfoBluetoothModel * oneDayBop in array) {
            NSDictionary * dic = oneDayBop.dicFromObject;
            [oneMonthBops addObject:dic];
        }
        self.textView.text = [NSString stringWithFormat:@"%@-%@\n%@",[days firstObject],[days lastObject],
                              oneMonthBops.count > 0 ? oneMonthBops : lang(@"no data")];
    }
}

- (void)queryBopsWeekDataWtithVc:(FuncViewController *)funcVc
{
    if (!__IDO_FUNCTABLE__.funcTable20Model.spo2Data) {
        [funcVc showToastWithText:lang(@"feature is not supported on the current device")];
        return;
    }
    NSArray * days = nil;
    NSArray * array = [IDOSyncSpo2DataModel queryOneWeekBloodOxygenWithWeekIndex:self.week
                                                                    weekStartDay:0
                                                                         macAddr:self.macAddr
                                                                     datesOfWeek:&days
                                                                    isQueryItems:NO];
    if (array.count == 0) {
        self.textView.text = lang(@"current week no data");
        [funcVc showToastWithText:lang(@"current week no data")];
    }else {
        NSMutableArray * oneWeekBops = [NSMutableArray array];
        for (IDOSyncBloodOxygenDataInfoBluetoothModel * oneDayBop in array) {
            NSDictionary * dic = oneDayBop.dicFromObject;
            [oneWeekBops addObject:dic];
        }
        self.textView.text = [NSString stringWithFormat:@"%@-%@\n%@",[days firstObject],[days lastObject],
                              oneWeekBops.count > 0 ? oneWeekBops : lang(@"no data")];
    }
}

- (void)queryBopsDayDataWtithVc:(FuncViewController *)funcVc
{
    if (!__IDO_FUNCTABLE__.funcTable20Model.spo2Data) {
        [funcVc showToastWithText:lang(@"feature is not supported on the current device")];
        return;
    }
    NSArray * array = [IDOSyncSpo2DataModel queryOneDayBloodOxygenDetailWithMac:self.macAddr
                                                                           year:self.year
                                                                          month:self.month
                                                                            day:self.day];
    if (array.count == 0) {
        self.textView.text = lang(@"current day no data");
        [funcVc showToastWithText:lang(@"current day no data")];
    }else {
        NSMutableArray * oneDayBops = [NSMutableArray array];
        for (IDOSyncBloodOxygenDataInfoBluetoothModel * oneDayBop in array) {
            NSDictionary * dic = oneDayBop.dicFromObject;
            [oneDayBops addObject:dic];
        }
        self.textView.text = [NSString stringWithFormat:@"%ld-%ld-%ld\n%@",(long)self.year,(long)self.month,
                              (long)self.day,oneDayBops.count > 0 ? oneDayBops : lang(@"no data")];
    }
}

- (void)queryAllBopsDataWtithVc:(FuncViewController *)funcVc
{
    if (!__IDO_FUNCTABLE__.funcTable20Model.spo2Data) {
        [funcVc showToastWithText:lang(@"feature is not supported on the current device")];
        return;
    }
    NSArray * array = [IDOSyncSpo2DataModel queryAllBloodOxygensWithMac:self.macAddr];
    if (!array || array.count == 0) {
        self.textView.text = lang(@"no data");
        [funcVc showToastWithText:lang(@"no data")];
    }else {
        self.textView.text = [NSString stringWithFormat:@"%@:%ld\n%@",lang(@"data count"),
                              (long)array.count,array.count > 0 ? array : lang(@"no data")];
    }
}

#pragma mark ==== query pressures data =================

- (void)queryPressuresYearDataWtithVc:(FuncViewController *)funcVc
{
    if (!__IDO_FUNCTABLE__.funcTable20Model.pressureData) {
        [funcVc showToastWithText:lang(@"feature is not supported on the current device")];
        return;
    }
    NSArray * array = [IDOSyncPressureDataModel queryOneYearPressureWithYear:self.year
                                                                     macAddr:self.macAddr
                                                                isQueryItems:NO];
    if (array.count == 0) {
        self.textView.text = lang(@"current year no data");
        [funcVc showToastWithText:lang(@"current year no data")];
    }else {
        NSMutableArray * oneYearPressures = [NSMutableArray array];
        for (NSArray * oneMonthPressures in array) {
            for (IDOSyncPressureDataInfoBluetoothModel * oneDayPressure in oneMonthPressures) {
                NSDictionary * dic = oneDayPressure.dicFromObject;
                [oneYearPressures addObject:dic];
            }
        }
        self.textView.text = [NSString stringWithFormat:@"%ld\n%@",
                              (long)self.year,oneYearPressures.count > 0 ? oneYearPressures : lang(@"no data")];
    }
}

- (void)queryPressuresMonthDataWtithVc:(FuncViewController *)funcVc
{
    if (!__IDO_FUNCTABLE__.funcTable20Model.pressureData) {
        [funcVc showToastWithText:lang(@"feature is not supported on the current device")];
        return;
    }
    NSArray * days = nil;
    NSArray * array = [IDOSyncPressureDataModel queryOneMonthPressureWithYear:self.year
                                                                        month:self.month
                                                                      macAddr:self.macAddr
                                                                 datesOfMonth:&days
                                                                 isQueryItems:NO];
    if (array.count == 0) {
        self.textView.text = lang(@"current month no data");
        [funcVc showToastWithText:lang(@"current month no data")];
    }else {
        NSMutableArray * oneMonthPressures = [NSMutableArray array];
        for (IDOSyncPressureDataInfoBluetoothModel * oneDayPressure in array) {
            NSDictionary * dic = oneDayPressure.dicFromObject;
            [oneMonthPressures addObject:dic];
        }
        self.textView.text = [NSString stringWithFormat:@"%@-%@\n%@",[days firstObject],[days lastObject],
                              oneMonthPressures.count > 0 ? oneMonthPressures : lang(@"no data")];
    }
}

- (void)queryPressuresWeekDataWtithVc:(FuncViewController *)funcVc
{
    if (!__IDO_FUNCTABLE__.funcTable20Model.pressureData) {
        [funcVc showToastWithText:lang(@"feature is not supported on the current device")];
        return;
    }
    NSArray * days = nil;
    NSArray * array = [IDOSyncPressureDataModel queryOneWeekPressureWithWeekIndex:self.week
                                                                  weekStartDay:0
                                                                       macAddr:self.macAddr
                                                                   datesOfWeek:&days
                                                                  isQueryItems:NO];
    if (array.count == 0) {
        self.textView.text = lang(@"current week no data");
        [funcVc showToastWithText:lang(@"current week no data")];
    }else {
        NSMutableArray * oneWeekPressures = [NSMutableArray array];
        for (IDOSyncPressureDataInfoBluetoothModel * oneDayPressure in array) {
            NSDictionary * dic = oneDayPressure.dicFromObject;
            [oneWeekPressures addObject:dic];
        }
        self.textView.text = [NSString stringWithFormat:@"%@-%@\n%@",[days firstObject],[days lastObject],
                              oneWeekPressures.count > 0 ? oneWeekPressures : lang(@"no data")];
    }
}

- (void)queryPressuresDayDataWtithVc:(FuncViewController *)funcVc
{
    if (!__IDO_FUNCTABLE__.funcTable20Model.pressureData) {
        [funcVc showToastWithText:lang(@"feature is not supported on the current device")];
        return;
    }
    NSArray * array = [IDOSyncPressureDataModel queryOneDayPressureDetailWithMac:self.macAddr
                                                                            year:self.year
                                                                           month:self.month
                                                                             day:self.day];
    if (array.count == 0) {
        self.textView.text = lang(@"current day no data");
        [funcVc showToastWithText:lang(@"current day no data")];
    }else {
        NSMutableArray * oneDayPressures = [NSMutableArray array];
        for (IDOSyncPressureDataInfoBluetoothModel * oneDayPressure in array) {
            NSDictionary * dic = oneDayPressure.dicFromObject;
            [oneDayPressures addObject:dic];
        }
        self.textView.text = [NSString stringWithFormat:@"%ld-%ld-%ld\n%@",(long)self.year,(long)self.month,(long)self.day,
                              oneDayPressures.count > 0 ? oneDayPressures : lang(@"no data")];
    }
}

- (void)queryAllPressuresDataWtithVc:(FuncViewController *)funcVc
{
    if (!__IDO_FUNCTABLE__.funcTable20Model.pressureData) {
        [funcVc showToastWithText:lang(@"feature is not supported on the current device")];
        return;
    }
    NSArray * array = [IDOSyncPressureDataModel queryAllPressuresWithMac:self.macAddr];
    if (!array || array.count == 0) {
        self.textView.text = lang(@"no data");
        [funcVc showToastWithText:lang(@"no data")];
    }else {
        self.textView.text = [NSString stringWithFormat:@"%@:%ld\n%@",lang(@"data count"),(long)array.count,
                              array.count > 0 ? array : lang(@"no data")];
    }
}

#pragma mark ==== query noise data =================

- (void)queryNoiseYearDataWtithVc:(FuncViewController *)funcVc
{
    if (!__IDO_FUNCTABLE__.funcTable37Model.syncNoise) {
        [funcVc showToastWithText:lang(@"feature is not supported on the current device")];
        return;
    }
    NSArray * array = [IDOSyncNoiseDataModel queryOneYearNoiseWithYear:self.year
                                                             macAddr:self.macAddr
                                                        isQueryItems:NO];
    if (array.count == 0) {
        self.textView.text = lang(@"current year no data");
        [funcVc showToastWithText:lang(@"current year no data")];
    }else {
        NSMutableArray * oneYearNoises = [NSMutableArray array];
        for (NSArray * oneMonthNoises in array) {
            for (IDOSyncNoiseBluetoothDataModel * oneDayNoise in oneMonthNoises) {
                NSDictionary * dic = oneDayNoise.dicFromObject;
                [oneYearNoises addObject:dic];
            }
        }
        self.textView.text = [NSString stringWithFormat:@"%ld\n%@",
                              (long)self.year,oneYearNoises.count > 0 ? oneYearNoises : lang(@"no data")];
    }
}

- (void)queryNoisesMonthDataWtithVc:(FuncViewController *)funcVc
{
    if (!__IDO_FUNCTABLE__.funcTable37Model.syncNoise) {
        [funcVc showToastWithText:lang(@"feature is not supported on the current device")];
        return;
    }
    NSArray * days = nil;
    NSArray * array = [IDOSyncNoiseDataModel queryOneMonthNoiseWithYear:self.year
                                                                month:self.month
                                                              macAddr:self.macAddr
                                                         datesOfMonth:&days
                                                         isQueryItems:NO];
    if (array.count == 0) {
        self.textView.text = lang(@"current month no data");
        [funcVc showToastWithText:lang(@"current month no data")];
    }else {
        NSMutableArray * oneMonthNoises = [NSMutableArray array];
        for (IDOSyncNoiseBluetoothDataModel * oneDayNoise in array) {
            NSDictionary * dic = oneDayNoise.dicFromObject;
            [oneMonthNoises addObject:dic];
        }
        self.textView.text = [NSString stringWithFormat:@"%@-%@\n%@",[days firstObject],[days lastObject],
                              oneMonthNoises.count > 0 ? oneMonthNoises : lang(@"no data")];
    }
}

- (void)queryNoisesWeekDataWtithVc:(FuncViewController *)funcVc
{
    if (!__IDO_FUNCTABLE__.funcTable37Model.syncNoise) {
        [funcVc showToastWithText:lang(@"feature is not supported on the current device")];
        return;
    }
    NSArray * days = nil;
    NSArray * array = [IDOSyncNoiseDataModel queryOneWeekNoiseWithWeekIndex:self.week
                                                              weekStartDay:0
                                                                   macAddr:self.macAddr
                                                               datesOfWeek:&days
                                                              isQueryItems:NO];
    if (array.count == 0) {
        self.textView.text = lang(@"current week no data");
        [funcVc showToastWithText:lang(@"current week no data")];
    }else {
        NSMutableArray * oneWeekNoises = [NSMutableArray array];
        for (IDOSyncNoiseBluetoothDataModel * oneDayNoise in array) {
            NSDictionary * dic = oneDayNoise.dicFromObject;
            [oneWeekNoises addObject:dic];
        }
        self.textView.text = [NSString stringWithFormat:@"%@-%@\n%@",[days firstObject],[days lastObject],
                              oneWeekNoises.count > 0 ? oneWeekNoises : lang(@"no data")];
    }
}

- (void)queryNoisesDayDataWtithVc:(FuncViewController *)funcVc
{
    if (!__IDO_FUNCTABLE__.funcTable37Model.syncNoise) {
        [funcVc showToastWithText:lang(@"feature is not supported on the current device")];
        return;
    }
    NSArray * array = [IDOSyncNoiseDataModel queryOneDayNoiseDetailWithMac:self.macAddr
                                                                    year:self.year
                                                                   month:self.month
                                                                     day:self.day];
    if (array.count == 0) {
        self.textView.text = lang(@"current day no data");
        [funcVc showToastWithText:lang(@"current day no data")];
    }else {
        NSMutableArray * oneDayNoises = [NSMutableArray array];
        for (IDOSyncNoiseBluetoothDataModel * oneDayNoise in array) {
            NSDictionary * dic = oneDayNoise.dicFromObject;
            [oneDayNoises addObject:dic];
        }
        self.textView.text = [NSString stringWithFormat:@"%ld-%ld-%ld\n%@",(long)self.year,(long)self.month,(long)self.day,
                              oneDayNoises.count > 0 ? oneDayNoises : lang(@"no data")];
    }
}

- (void)queryAllNoisesDataWtithVc:(FuncViewController *)funcVc
{
    if (!__IDO_FUNCTABLE__.funcTable37Model.syncNoise) {
        [funcVc showToastWithText:lang(@"feature is not supported on the current device")];
        return;
    }
    NSArray * array = [IDOSyncNoiseDataModel queryAllNoiseWithMac:self.macAddr];
    if (!array || array.count == 0) {
        self.textView.text = lang(@"no data");
        [funcVc showToastWithText:lang(@"no data")];
    }else {
        self.textView.text = [NSString stringWithFormat:@"%@:%ld\n%@",lang(@"data count"),(long)array.count,
                              array.count > 0 ? array : lang(@"no data")];
    }
}

#pragma mark ==== query temperature data =================

- (void)queryTemperaturesYearDataWtithVc:(FuncViewController *)funcVc
{
    if (!__IDO_FUNCTABLE__.funcTable37Model.syncTemperature) {
        [funcVc showToastWithText:lang(@"feature is not supported on the current device")];
        return;
    }
    
    NSArray * array = [IDOSyncTemperatureDataModel queryOneYearTemperatureWithYear:self.year
                                                                         macAddr:self.macAddr
                                                                    isQueryItems:NO];
    if (array.count == 0) {
        self.textView.text = lang(@"current year no data");
        [funcVc showToastWithText:lang(@"current year no data")];
    }else {
        NSMutableArray * oneYearTemperatures = [NSMutableArray array];
        for (NSArray * oneMonthTemperatures in array) {
            for (IDOSyncTemperatureBluetoothDataModel * oneDayTemperature in oneMonthTemperatures) {
                NSDictionary * dic = oneDayTemperature.dicFromObject;
                [oneYearTemperatures addObject:dic];
            }
        }
        self.textView.text = [NSString stringWithFormat:@"%ld\n%@",
                              (long)self.year,oneYearTemperatures.count > 0 ? oneYearTemperatures : lang(@"no data")];
    }
}

- (void)queryTemperaturesMonthDataWtithVc:(FuncViewController *)funcVc
{
    if (!__IDO_FUNCTABLE__.funcTable37Model.syncTemperature) {
        [funcVc showToastWithText:lang(@"feature is not supported on the current device")];
        return;
    }
    NSArray * days = nil;
    NSArray * array = [IDOSyncTemperatureDataModel queryOneMonthTemperatureWithYear:self.year
                                                                            month:self.month
                                                                          macAddr:self.macAddr
                                                                     datesOfMonth:&days
                                                                     isQueryItems:NO];
    if (array.count == 0) {
        self.textView.text = lang(@"current month no data");
        [funcVc showToastWithText:lang(@"current month no data")];
    }else {
        NSMutableArray * oneMonthTemperatures = [NSMutableArray array];
        for (IDOSyncTemperatureBluetoothDataModel * oneDayTemperature in array) {
            NSDictionary * dic = oneDayTemperature.dicFromObject;
            [oneMonthTemperatures addObject:dic];
        }
        self.textView.text = [NSString stringWithFormat:@"%@-%@\n%@",[days firstObject],[days lastObject],
                              oneMonthTemperatures.count > 0 ? oneMonthTemperatures : lang(@"no data")];
    }
}

- (void)queryTemperaturesWeekDataWtithVc:(FuncViewController *)funcVc
{
    if (!__IDO_FUNCTABLE__.funcTable37Model.syncTemperature) {
        [funcVc showToastWithText:lang(@"feature is not supported on the current device")];
        return;
    }
    NSArray * days = nil;
    NSArray * array = [IDOSyncTemperatureDataModel queryOneWeekTemperatureWithWeekIndex:self.week
                                                                          weekStartDay:0
                                                                               macAddr:self.macAddr
                                                                           datesOfWeek:&days
                                                                          isQueryItems:NO];
    if (array.count == 0) {
        self.textView.text = lang(@"current week no data");
        [funcVc showToastWithText:lang(@"current week no data")];
    }else {
        NSMutableArray * oneWeekTemperatures = [NSMutableArray array];
        for (IDOSyncTemperatureBluetoothDataModel * oneDayTemperature in array) {
            NSDictionary * dic = oneDayTemperature.dicFromObject;
            [oneWeekTemperatures addObject:dic];
        }
        self.textView.text = [NSString stringWithFormat:@"%@-%@\n%@",[days firstObject],[days lastObject],
                              oneWeekTemperatures.count > 0 ? oneWeekTemperatures : lang(@"no data")];
    }
}

- (void)queryTemperaturesDayDataWtithVc:(FuncViewController *)funcVc
{
    if (!__IDO_FUNCTABLE__.funcTable37Model.syncTemperature) {
        [funcVc showToastWithText:lang(@"feature is not supported on the current device")];
        return;
    }
    NSArray * array = [IDOSyncTemperatureDataModel queryOneDayTemperatureDetailWithMac:self.macAddr
                                                                    year:self.year
                                                                   month:self.month
                                                                     day:self.day];
    if (array.count == 0) {
        self.textView.text = lang(@"current day no data");
        [funcVc showToastWithText:lang(@"current day no data")];
    }else {
        NSMutableArray * oneDayTemperatures = [NSMutableArray array];
        for (IDOSyncTemperatureBluetoothDataModel * oneDayTemperature in array) {
            NSDictionary * dic = oneDayTemperature.dicFromObject;
            [oneDayTemperatures addObject:dic];
        }
        self.textView.text = [NSString stringWithFormat:@"%ld-%ld-%ld\n%@",(long)self.year,(long)self.month,(long)self.day,
                              oneDayTemperatures.count > 0 ? oneDayTemperatures : lang(@"no data")];
    }
}

- (void)queryAllTemperaturesDataWtithVc:(FuncViewController *)funcVc
{
    if (!__IDO_FUNCTABLE__.funcTable37Model.syncTemperature) {
        [funcVc showToastWithText:lang(@"feature is not supported on the current device")];
        return;
    }
    NSArray * array = [IDOSyncTemperatureDataModel queryAllTemperatureWithMac:self.macAddr];
    
    if (!array || array.count == 0) {
        self.textView.text = lang(@"no data");
        [funcVc showToastWithText:lang(@"no data")];
    }else {
        self.textView.text = [NSString stringWithFormat:@"%@:%ld\n%@",lang(@"data count"),(long)array.count,
                              array.count > 0 ? array : lang(@"no data")];
    }
}

#pragma mark ==== query breath rate data =================

- (void)queryBreathRatesYearDataWtithVc:(FuncViewController *)funcVc
{
    if (!__IDO_FUNCTABLE__.funcTable34Model.supportBreathRate) {
        [funcVc showToastWithText:lang(@"feature is not supported on the current device")];
        return;
    }
    NSArray * array = [IDOSyncBreathRateDataModel queryOneYearBreathRateWithYear:self.year
                                                                         macAddr:self.macAddr];
    if (array.count == 0) {
        self.textView.text = lang(@"current year no data");
        [funcVc showToastWithText:lang(@"current year no data")];
    }else {
        NSMutableArray * oneYearBreathRates = [NSMutableArray array];
        for (NSArray * oneMonthBreathRates in array) {
            for (IDOSyncBreathRateDataModel * oneDayBreathRates in oneMonthBreathRates) {
                NSDictionary * dic = oneDayBreathRates.dicFromObject;
                [oneYearBreathRates addObject:dic];
            }
        }
        self.textView.text = [NSString stringWithFormat:@"%ld\n%@",
                              (long)self.year,oneYearBreathRates.count > 0 ? oneYearBreathRates : lang(@"no data")];
    }
}

- (void)queryBreathRatesMonthDataWtithVc:(FuncViewController *)funcVc
{
    if (!__IDO_FUNCTABLE__.funcTable34Model.supportBreathRate) {
        [funcVc showToastWithText:lang(@"feature is not supported on the current device")];
        return;
    }
    NSArray * days = nil;
    NSArray * array = [IDOSyncBreathRateDataModel queryOneMonthBreathRateWithYear:self.year
                                                                            month:self.month
                                                                          macAddr:self.macAddr
                                                                     datesOfMonth:&days];
    if (array.count == 0) {
        self.textView.text = lang(@"current month no data");
        [funcVc showToastWithText:lang(@"current month no data")];
    }else {
        NSMutableArray * oneMonthBreathRates = [NSMutableArray array];
        for (IDOSyncBreathRateDataModel * oneDayBreathRates in array) {
            NSDictionary * dic = oneDayBreathRates.dicFromObject;
            [oneMonthBreathRates addObject:dic];
        }
        self.textView.text = [NSString stringWithFormat:@"%@-%@\n%@",[days firstObject],[days lastObject],
                              oneMonthBreathRates.count > 0 ? oneMonthBreathRates : lang(@"no data")];
    }
}

- (void)queryBreathRatesWeekDataWtithVc:(FuncViewController *)funcVc
{
    if (!__IDO_FUNCTABLE__.funcTable34Model.supportBreathRate) {
        [funcVc showToastWithText:lang(@"feature is not supported on the current device")];
        return;
    }
    NSArray * days = nil;
    NSArray * array = [IDOSyncBreathRateDataModel queryOneWeekBreathRateWithWeekIndex:self.week
                                                                      weekStartDay:0
                                                                           macAddr:self.macAddr
                                                                       datesOfWeek:&days];
    if (array.count == 0) {
        self.textView.text = lang(@"current week no data");
        [funcVc showToastWithText:lang(@"current week no data")];
    }else {
        NSMutableArray * oneWeekBreathRates = [NSMutableArray array];
        for (IDOSyncBreathRateDataModel * oneDayBreathRates in array) {
            NSDictionary * dic = oneDayBreathRates.dicFromObject;
            [oneWeekBreathRates addObject:dic];
        }
        self.textView.text = [NSString stringWithFormat:@"%@-%@\n%@",[days firstObject],[days lastObject],
                              oneWeekBreathRates.count > 0 ? oneWeekBreathRates : lang(@"no data")];
    }
}

- (void)queryBreathRatesDayDataWtithVc:(FuncViewController *)funcVc
{
    if (!__IDO_FUNCTABLE__.funcTable34Model.supportBreathRate) {
        [funcVc showToastWithText:lang(@"feature is not supported on the current device")];
        return;
    }
    NSArray * array = [IDOSyncBreathRateDataModel queryOneDayBreathRateDetailWithMac:self.macAddr
                                                                    year:self.year
                                                                   month:self.month
                                                                     day:self.day];
    if (array.count == 0) {
        self.textView.text = lang(@"current day no data");
        [funcVc showToastWithText:lang(@"current day no data")];
    }else {
        NSMutableArray * oneDayBreathRates = [NSMutableArray array];
        for (IDOSyncBreathRateDataModel * oneDayBreathRate in array) {
            NSDictionary * dic = oneDayBreathRate.dicFromObject;
            [oneDayBreathRates addObject:dic];
        }
        self.textView.text = [NSString stringWithFormat:@"%ld-%ld-%ld\n%@",(long)self.year,(long)self.month,(long)self.day,
                              oneDayBreathRates.count > 0 ? oneDayBreathRates : lang(@"no data")];
    }
}

- (void)queryAllBreathRatesDataWtithVc:(FuncViewController *)funcVc
{
    if (!__IDO_FUNCTABLE__.funcTable34Model.supportBreathRate) {
        [funcVc showToastWithText:lang(@"feature is not supported on the current device")];
        return;
    }
    NSArray * array = [IDOSyncBreathRateDataModel queryAllBreathRateWithMac:self.macAddr];
    
    if (!array || array.count == 0) {
        self.textView.text = lang(@"no data");
        [funcVc showToastWithText:lang(@"no data")];
    }else {
        self.textView.text = [NSString stringWithFormat:@"%@:%ld\n%@",lang(@"data count"),(long)array.count,
                              array.count > 0 ? array : lang(@"no data")];
    }
}

#pragma mark ==== query body power data =================

- (void)queryBodyPowersYearDataWtithVc:(FuncViewController *)funcVc
{
    if (!__IDO_FUNCTABLE__.funcTable36Model.v3BodyPower) {
        [funcVc showToastWithText:lang(@"feature is not supported on the current device")];
        return;
    }
    NSArray * array = [IDOSyncBodyPowerDataModel queryOneYearBodyPowerWithYear:self.year
                                                                       macAddr:self.macAddr];
    if (array.count == 0) {
        self.textView.text = lang(@"current year no data");
        [funcVc showToastWithText:lang(@"current year no data")];
    }else {
        NSMutableArray * oneYearBodyPowers = [NSMutableArray array];
        for (NSArray * oneMonthBodyPowers in array) {
            for (IDOSyncBodyPowerDataModel * oneDayBodyPowers in oneMonthBodyPowers) {
                NSDictionary * dic = oneDayBodyPowers.dicFromObject;
                [oneYearBodyPowers addObject:dic];
            }
        }
        self.textView.text = [NSString stringWithFormat:@"%ld\n%@",
                              (long)self.year,oneYearBodyPowers.count > 0 ? oneYearBodyPowers : lang(@"no data")];
    }
}

- (void)queryBodyPowersMonthDataWtithVc:(FuncViewController *)funcVc
{
    if (!__IDO_FUNCTABLE__.funcTable36Model.v3BodyPower) {
        [funcVc showToastWithText:lang(@"feature is not supported on the current device")];
        return;
    }
    NSArray * days = nil;
    NSArray * array = [IDOSyncBodyPowerDataModel queryOneMonthBodyPowerWithYear:self.year
                                                                        month:self.month
                                                                      macAddr:self.macAddr
                                                                 datesOfMonth:&days];
    if (array.count == 0) {
        self.textView.text = lang(@"current month no data");
        [funcVc showToastWithText:lang(@"current month no data")];
    }else {
        NSMutableArray * oneMonthBodyPowers = [NSMutableArray array];
        for (IDOSyncBodyPowerDataModel * oneDayBodyPowers in array) {
            NSDictionary * dic = oneDayBodyPowers.dicFromObject;
            [oneMonthBodyPowers addObject:dic];
        }
        self.textView.text = [NSString stringWithFormat:@"%@-%@\n%@",[days firstObject],[days lastObject],
                              oneMonthBodyPowers.count > 0 ? oneMonthBodyPowers : lang(@"no data")];
    }
}

- (void)queryBodyPowersWeekDataWtithVc:(FuncViewController *)funcVc
{
    if (!__IDO_FUNCTABLE__.funcTable36Model.v3BodyPower) {
        [funcVc showToastWithText:lang(@"feature is not supported on the current device")];
        return;
    }
    NSArray * days = nil;
    NSArray * array = [IDOSyncBodyPowerDataModel queryOneWeekBodyPowerWithWeekIndex:self.week
                                                                       weekStartDay:0
                                                                            macAddr:self.macAddr
                                                                        datesOfWeek:&days];
    if (array.count == 0) {
        self.textView.text = lang(@"current week no data");
        [funcVc showToastWithText:lang(@"current week no data")];
    }else {
        NSMutableArray * oneWeekBodyPowers = [NSMutableArray array];
        for (IDOSyncBodyPowerDataModel * oneDayBodyPowers in array) {
            NSDictionary * dic = oneDayBodyPowers.dicFromObject;
            [oneWeekBodyPowers addObject:dic];
        }
        self.textView.text = [NSString stringWithFormat:@"%@-%@\n%@",[days firstObject],[days lastObject],
                              oneWeekBodyPowers.count > 0 ? oneWeekBodyPowers : lang(@"no data")];
    }
}

- (void)queryBodyPowersDayDataWtithVc:(FuncViewController *)funcVc
{
    if (!__IDO_FUNCTABLE__.funcTable36Model.v3BodyPower) {
        [funcVc showToastWithText:lang(@"feature is not supported on the current device")];
        return;
    }
    NSArray * array = [IDOSyncBodyPowerDataModel queryOneDayBodyPowerDetailWithMac:self.macAddr
                                                                    year:self.year
                                                                   month:self.month
                                                                     day:self.day];
    if (array.count == 0) {
        self.textView.text = lang(@"current day no data");
        [funcVc showToastWithText:lang(@"current day no data")];
    }else {
        NSMutableArray * oneDayBodyPowers = [NSMutableArray array];
        for (IDOSyncBodyPowerDataModel * oneDayBodyPower in array) {
            NSDictionary * dic = oneDayBodyPower.dicFromObject;
            [oneDayBodyPowers addObject:dic];
        }
        self.textView.text = [NSString stringWithFormat:@"%ld-%ld-%ld\n%@",(long)self.year,(long)self.month,(long)self.day,
                              oneDayBodyPowers.count > 0 ? oneDayBodyPowers : lang(@"no data")];
    }
}

- (void)queryAllBodyPowersDataWtithVc:(FuncViewController *)funcVc
{
    if (!__IDO_FUNCTABLE__.funcTable36Model.v3BodyPower) {
        [funcVc showToastWithText:lang(@"feature is not supported on the current device")];
        return;
    }
    NSArray * array = [IDOSyncBodyPowerDataModel queryAllBodyPowerWithMac:self.macAddr];
    
    if (!array || array.count == 0) {
        self.textView.text = lang(@"no data");
        [funcVc showToastWithText:lang(@"no data")];
    }else {
        self.textView.text = [NSString stringWithFormat:@"%@:%ld\n%@",lang(@"data count"),(long)array.count,
                              array.count > 0 ? array : lang(@"no data")];
    }
}

@end
