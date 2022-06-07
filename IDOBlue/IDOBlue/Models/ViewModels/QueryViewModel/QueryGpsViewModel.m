//
//  QueryGpsViewModel.m
//  IDOBlue
//
//  Created by 何东阳 on 2019/3/13.
//  Copyright © 2019年 hedongyang. All rights reserved.
//

#import "QueryGpsViewModel.h"
#import "FuncCellModel.h"
#import "LabelCellModel.h"
#import "FuncViewController.h"
#import "OneLabelTableViewCell.h"
#import "QueryDataDetailViewModel.h"
#import "NSObject+ModelToDic.h"
#import "QueryActivityDetailViewModel.h"

@interface QueryGpsViewModel()
@property (nonatomic,strong) NSMutableArray * allActivitys;
@property (nonatomic,strong) NSMutableArray * allCellModels;
@property (nonatomic,copy)void(^labelSelectCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end


@implementation QueryGpsViewModel
- (id)init
{
    self = [super init];
    if (self) {
        [self getLabelCallback];
        [self getCellModels];
    }
    return self;
}

- (NSMutableArray *)allActivitys
{
    if (!_allActivitys) {
        _allActivitys = [NSMutableArray array];
    }
    return _allActivitys;
}

- (NSMutableArray *)allCellModels
{
    if (!_allCellModels) {
        _allCellModels = [NSMutableArray array];
    }
    return _allCellModels;
}

- (void)getCellModels
{
    NSArray <IDOSyncActivityDataInfoBluetoothModel *> * activitys = [IDOSyncActivityDataModel queryAllTrajectorySportActivitysWithMac:@""];
    [self.allActivitys addObjectsFromArray:activitys];
    
    NSMutableArray * cellModels = [NSMutableArray array];
    for (IDOSyncActivityDataInfoBluetoothModel * activity in activitys) {
        LabelCellModel * model = [[LabelCellModel alloc]init];
        model.typeStr = @"oneLabel";
        NSString * str = [self dataStrWithModel:activity];
        model.data = @[str];
        model.cellHeight = [self getCellHeightWithStr:str];
        model.cellClass = [OneLabelTableViewCell class];
        model.modelClass = [NSNull class];
        model.labelSelectCallback = self.labelSelectCallback;
        model.isShowLine = YES;
        [cellModels addObject:model];
    }
    [self.allCellModels addObjectsFromArray:cellModels];
    self.cellModels = self.allCellModels;
}

- (NSString *)dataStrWithModel:(IDOSyncActivityDataInfoBluetoothModel *)model
{
    BOOL isGps = [IDOSyncGpsDataModel queryActivityHasCoordinatesWithTimeStr:model.timeStr macAddr:@""];
    NSString * type = model.type < self.pickerDataModel.sportTypes.count ? [self.pickerDataModel.sportTypes objectAtIndex:model.type] : lang(@"walk");
    NSString * titleStr = [NSString stringWithFormat:@"%@:%@ [%@]",lang(@"activty type"),type,isGps ? lang(@"trajectory"):lang(@"no trajectory")];
    NSString * timeStr     = [NSString stringWithFormat:@"%@%@",lang(@"time"),[IDODemoUtility timeStrFromTimeStamp:model.timeStr]];
    NSString * macAddrStr  = [NSString stringWithFormat:@"MAC:%@",model.macAddr];
    NSString * dataStr     = [NSString stringWithFormat:@"%@:%ld\n%@:%ld\n%@:%ld",lang(@"calories"),(long)model.calories,
                           lang(@"step"),(long)model.step,lang(@"avg heart rate"),(long)model.avgHrValue];
    NSString * str = [NSString stringWithFormat:@"%@\n%@\n%@\n%@",titleStr,macAddrStr,timeStr,dataStr];
    return str;
}

- (CGFloat)getCellHeightWithStr:(NSString *)str
{
    return [IDODemoUtility getLabelheight:str width:[IDODemoUtility getCurrentVC].view.frame.size.width - 32 font:[UIFont systemFontOfSize:14]] + 20;
}

- (void)getLabelCallback
{
    __weak typeof(self) weakSelf = self;
    self.labelSelectCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        
        FuncViewController * funcVc = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVc.tableView indexPathForCell:tableViewCell];
        IDOSyncActivityDataInfoBluetoothModel * model = [strongSelf.allActivitys objectAtIndex:indexPath.row];
        FuncViewController * newFuncVc = [FuncViewController new];
        QueryActivityDetailViewModel * detailModel = [QueryActivityDetailViewModel new];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            IDOSyncGpsDataInfoBluetoothModel * gpsModel = [IDOSyncGpsDataModel queryOneActivityCoordinatesWithTimeStr:model.timeStr macAddr:@""];
            dispatch_async(dispatch_get_main_queue(), ^{
                detailModel.activityModel = gpsModel ? gpsModel : model;
            });
        });
        newFuncVc.title = lang(@"GPS detail");
        newFuncVc.model = detailModel;
        [funcVc.navigationController pushViewController:newFuncVc animated:YES];
    };
}

@end
