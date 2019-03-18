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
    NSArray <IDOSyncActivityDataInfoBluetoothModel *> * activitys = [IDOSyncActivityDataInfoBluetoothModel queryAllTrajectorySportActivitysWithMac:@""];
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
    BOOL isGps = [IDOSyncGpsDataInfoBluetoothModel queryActivityHasCoordinatesWithTimeStr:model.timeStr macAddr:@""];
    NSString * titleStr = [NSString stringWithFormat:@"活动类型 ：%@ [%@]",[self.pickerDataModel.sportTypes objectAtIndex:model.type],isGps ? @"有轨迹":@"无轨迹"];
    NSString * timeStr  = [NSString stringWithFormat:@"时间 ：%@",[IDODemoUtility timeStrFromTimeStamp:model.timeStr]];
    NSString * macAddrStr  = [NSString stringWithFormat:@"MAC ：%@",model.macAddr];
    NSString * dataStr  = [NSString stringWithFormat:@"卡路里 ：%ld\n步数 ：%ld\n平均心率 ：%ld",(long)model.calories,(long)model.step,(long)model.avgHrValue];
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
        IDOSyncGpsDataInfoBluetoothModel * gpsModel = [IDOSyncGpsDataInfoBluetoothModel queryOneActivityCoordinatesWithTimeStr:model.timeStr macAddr:@""];
        FuncViewController * newFuncVc = [FuncViewController new];
        QueryActivityDetailViewModel * detailModel = [QueryActivityDetailViewModel new];
        detailModel.activityModel = gpsModel ? gpsModel : model;
        newFuncVc.model = detailModel;
        newFuncVc.title = gpsModel ? @"GPS详情" : @"活动详情";
        [funcVc.navigationController pushViewController:newFuncVc animated:YES];
    };
}

@end