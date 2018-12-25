//
//  QuerySportsViewModel.m
//  IDOBlue
//
//  Created by hedongyang on 2018/10/13.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "QuerySportsViewModel.h"
#import "FuncCellModel.h"
#import "TabCellModel.h"
#import "TextViewCellModel.h"
#import "CurveChartCellModel.h"
#import "FuncViewController.h"
#import "OneButtonTableViewCell.h"
#import "CurveChartTableViewCell.h"
#import "ThreeButtonTableViewCell.h"
#import "OneTextViewTableViewCell.h"
#import "NSObject+ModelToDic.h"
#import "CurveChartView.h"

@interface QuerySportsViewModel()
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^threeButtonCallback)(NSInteger index,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^textViewCallback)(UITextView * textView);
@property (nonatomic,copy)void(^curveChartCallback)(CurveChartView * chartView);
@property (nonatomic,strong) UITextView * textView;
@property (nonatomic,strong) CurveChartView * chartView;
@property (nonatomic,assign) NSInteger year;
@property (nonatomic,assign) NSInteger month;
@property (nonatomic,assign) NSInteger week;
@end

@implementation QuerySportsViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        IDOSetTimeInfoBluetoothModel * time = [IDOSetTimeInfoBluetoothModel new];
        self.year  = time.year;
        self.month = time.month;
        self.week  = 0;
        [self getCurveChartCallback];
        [self getTextViewCallback];
        [self getButtonCallback];
        [self getCellModels];
    }
    return self;
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    
    TabCellModel * model1 = [[TabCellModel alloc]init];
    model1.typeStr = @"threeButton";
    model1.data = @[@"按年查询",@"按月查询",@"按周查询"];
    model1.selectIndexs = @[[NSNumber numberWithBool:YES],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO]];
    model1.cellHeight = 70.0f;
    model1.cellClass = [ThreeButtonTableViewCell class];
    model1.modelClass = [NSNull class];
    model1.threeButtonCallback = self.threeButtonCallback;
    model1.isShowLine = YES;
    [cellModels addObject:model1];
    
    CurveChartCellModel * model2 = [[CurveChartCellModel alloc]init];
    model2.typeStr = @"curveChart";
    model2.cellHeight = 260.0f;
    model2.curveChartCallback = self.curveChartCallback;
    model2.cellClass = [CurveChartTableViewCell class];
    model2.modelClass = [NSNull class];
    model2.isShowLine = YES;
    [cellModels addObject:model2];
    
    TextViewCellModel * model5 = [[TextViewCellModel alloc]init];
    model5.typeStr = @"oneTextView";
    model5.data = @[@""];
    model5.textViewCallback = self.textViewCallback;
    model5.cellHeight = 150;
    model5.isShowLine = YES;
    model5.cellClass  = [OneTextViewTableViewCell class];
    [cellModels addObject:model5];
    
    FuncCellModel * model3 = [[FuncCellModel alloc]init];
    model3.typeStr = @"oneButton";
    model3.data    = @[@"上一年"];
    model3.cellHeight = 70.0f;
    model3.index = 0;
    model3.cellClass  = [OneButtonTableViewCell class];
    model3.modelClass = [NSNull class];
    model3.isShowLine = YES;
    model3.buttconCallback = self.buttconCallback;
    [cellModels addObject:model3];
    
    FuncCellModel * model4 = [[FuncCellModel alloc]init];
    model4.typeStr = @"oneButton";
    model4.data    = @[@"下一年"];
    model4.cellHeight = 70.0f;
    model4.index = 1;
    model4.cellClass  = [OneButtonTableViewCell class];
    model4.modelClass = [NSNull class];
    model4.isShowLine = YES;
    model4.buttconCallback = self.buttconCallback;
    [cellModels addObject:model4];
    
    self.cellModels = cellModels;
}

- (void)getTextViewCallback
{
    __weak typeof(self) weakSelf = self;
    self.textViewCallback = ^(UITextView *textView) {
        __strong typeof(self) strongSelf = weakSelf;
        strongSelf.textView = textView;
    };
}

- (void)getCurveChartCallback
{
    __weak typeof(self) weakSelf = self;
    self.curveChartCallback = ^(CurveChartView *chartView) {
        __strong typeof(self) strongSelf = weakSelf;
        strongSelf.chartView = chartView;
    };
}

- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.threeButtonCallback = ^(NSInteger index, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVc = (FuncViewController *)[IDODemoUtility getCurrentVC];
        NSIndexPath * indexPath1 = [NSIndexPath indexPathForRow:3 inSection:0];
        NSIndexPath * indexPath2 = [NSIndexPath indexPathForRow:4 inSection:0];
        NSIndexPath * indexPath3 = [NSIndexPath indexPathForRow:0 inSection:0];
        
        TabCellModel  * model1 = [strongSelf.cellModels firstObject];
        FuncCellModel * model2 = [strongSelf.cellModels objectAtIndex:3];
        FuncCellModel * model3 = [strongSelf.cellModels lastObject];
        NSMutableArray * slectIndexs = [NSMutableArray arrayWithArray:model1.selectIndexs];
        [slectIndexs replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:YES]];
        if (index == 0) {
            [slectIndexs replaceObjectAtIndex:1 withObject:[NSNumber numberWithBool:NO]];
            [slectIndexs replaceObjectAtIndex:2 withObject:[NSNumber numberWithBool:NO]];
        }else if (index == 1) {
            [slectIndexs replaceObjectAtIndex:0 withObject:[NSNumber numberWithBool:NO]];
            [slectIndexs replaceObjectAtIndex:2 withObject:[NSNumber numberWithBool:NO]];
        }else if (index == 2) {
            [slectIndexs replaceObjectAtIndex:0 withObject:[NSNumber numberWithBool:NO]];
            [slectIndexs replaceObjectAtIndex:1 withObject:[NSNumber numberWithBool:NO]];
        }
        model1.selectIndexs = slectIndexs;
        IDOSetTimeInfoBluetoothModel * time = [IDOSetTimeInfoBluetoothModel new];
        strongSelf.year  = time.year;
        strongSelf.month = time.month;
        strongSelf.week  = 0;
        if (index == 0) {
            model2.data = @[@"上一年"];
            model3.data = @[@"下一年"];
            [strongSelf querySportsYearDataWtithVc:funcVc];
        }else if (index == 1) {
            model2.data = @[@"上一月"];
            model3.data = @[@"下一月"];
            [strongSelf querySportsMonthDataWtithVc:funcVc];
        }else {
            model2.data = @[@"上一周"];
            model3.data = @[@"下一周"];
            [strongSelf querySportsWeekDataWtithVc:funcVc];
        }
        [funcVc.tableView reloadRowsAtIndexPaths:@[indexPath1,indexPath2,indexPath3] withRowAnimation:UITableViewRowAnimationNone];
    };
    
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVc = (FuncViewController *)viewController;
        NSIndexPath * indexPath   = [funcVc.tableView indexPathForCell:tableViewCell];
        FuncCellModel * funcModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
        TabCellModel  * model1    = [strongSelf.cellModels firstObject];
        NSInteger index = [model1.selectIndexs indexOfObject:[NSNumber numberWithBool:YES]];
        if(index == 0) {  //年
            if (funcModel.index == 0) {
                strongSelf.year --;
            }else {
                strongSelf.year ++;
            }
            [strongSelf querySportsYearDataWtithVc:funcVc];
        }else if (index == 1) { //月
            if (funcModel.index == 0) {
                strongSelf.month <=1 ? (strongSelf.month = 1) : (strongSelf.month --);
            }else {
                strongSelf.month >=12 ? (strongSelf.month = 12) : (strongSelf.month ++);
            }
            [strongSelf querySportsMonthDataWtithVc:funcVc];
        }else if(index == 2) { //周
            if (funcModel.index == 0) {
                strongSelf.week ++;
            }else {
                strongSelf.week <=0 ? (strongSelf.week = 0) : (strongSelf.week --);
            }
            [strongSelf querySportsWeekDataWtithVc:funcVc];
        }
    };
}

- (void)querySportsYearDataWtithVc:(FuncViewController *)funcVc
{
    NSArray * array = [IDOSyncSportDataInfoBluetoothModel queryOneYearSportsWithYear:self.year];
    if (array.count == 0) {
        self.textView.text = @"当前年无数据";
        [funcVc showToastWithText:@"当前年无数据"];
    }else {
        IDOCalculateSportBluetoothModel * sport = [IDOCalculateSportBluetoothModel calculateOneYearSportDataWithSportModels:array];
        self.textView.text = [NSString stringWithFormat:@"%ld\n%@",(long)self.year,sport.dicFromObject];
        [self showSportsYearChartViewWithModels:array];
    }
}

- (void)querySportsMonthDataWtithVc:(FuncViewController *)funcVc
{
    NSArray * days = nil;
    NSArray * array = [IDOSyncSportDataInfoBluetoothModel queryOneMonthSportsWithYear:self.year month:self.month datesOfMonth:&days];
    if (array.count == 0) {
        self.textView.text = @"当前月无数据";
        [funcVc showToastWithText:@"当前月无数据"];
    }else {
        IDOCalculateSportBluetoothModel * sport = [IDOCalculateSportBluetoothModel calculateOneMonthOrWeekSportDataWithSportModels:array];
        self.textView.text = [NSString stringWithFormat:@"%@-%@\n%@",[days firstObject],[days lastObject],sport.dicFromObject];
        [self showSportsMonthOrWeekChartViewWithModels:array days:days];
    }
}

- (void)querySportsWeekDataWtithVc:(FuncViewController *)funcVc
{
    NSArray * days = nil;
    NSArray * array = [IDOSyncSportDataInfoBluetoothModel queryOneWeekSportsWithWeekIndex:self.week weekStartDay:5 datesOfWeek:&days];
    if (array.count == 0) {
        self.textView.text = @"当前周无数据";
        [funcVc showToastWithText:@"当前周无数据"];
    }else {
        IDOCalculateSportBluetoothModel * sport = [IDOCalculateSportBluetoothModel calculateOneMonthOrWeekSportDataWithSportModels:array];
        self.textView.text = [NSString stringWithFormat:@"%@-%@\n%@",[days firstObject],[days lastObject],sport.dicFromObject];
        [self showSportsMonthOrWeekChartViewWithModels:array days:days];
    }
}

- (void)showSportsYearChartViewWithModels:(NSArray <NSArray <IDOSyncSportDataInfoBluetoothModel *>*>*)models
{
    if (models.count == 0) return;
    NSMutableArray * allMonths = [NSMutableArray array];
    for (NSArray<IDOSyncSportDataInfoBluetoothModel *> * oneMonthModels in models) {
        NSPredicate * predicate    =  [NSPredicate predicateWithFormat:@"totalDistances > 0 and totalStep > 0 and totalCalories > 0"];
        NSArray * newModels        =  [oneMonthModels filteredArrayUsingPredicate:predicate];
        if (newModels.count > 0) {
            NSInteger totalStep =  (NSInteger)[[newModels valueForKeyPath:@"@avg.totalStep"] floatValue];
            [allMonths addObject:[NSNumber numberWithInteger:totalStep]];
        }else {
            [allMonths addObject:[NSNumber numberWithInteger:0]];
        }
    }
    NSMutableArray * titles = [NSMutableArray array];
    for (int i = 1; i <= 12; i++) {
        [titles addObject:[NSString stringWithFormat:@"%d",i]];
    }
    self.chartView.gap = 20;
    self.chartView.target = [NSString stringWithFormat:@"%ld",(long)IDO_BLUE_ENGINE.userEngine.goalStepCount];
    self.chartView.titles = titles;
    self.chartView.values = allMonths;
}

- (void)showSportsMonthOrWeekChartViewWithModels:(NSArray <IDOSyncSportDataInfoBluetoothModel*>*)models
                                            days:(NSArray <NSString *>*)days
{
    if (models.count == 0) return;
    NSMutableArray * allDays = [NSMutableArray array];
    for (IDOSyncSportDataInfoBluetoothModel * model in models) {
        [allDays addObject:[NSNumber numberWithInteger:model.totalStep]];
    }
    NSMutableArray * titles = [NSMutableArray array];
    for (int i = 1; i <= days.count; i++) {
        [titles addObject:[NSString stringWithFormat:@"%d",i]];
    }
    self.chartView.gap = 20;
    self.chartView.target = [NSString stringWithFormat:@"%ld",(long)IDO_BLUE_ENGINE.userEngine.goalStepCount];
    self.chartView.titles = titles;
    self.chartView.values = allDays;
}

@end
