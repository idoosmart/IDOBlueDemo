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
@property (nonatomic,strong) NSArray * allActivitys;
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

- (void)getCellModels
{
    if (__IDO_FUNCTABLE__.funcTable22Model.v3GpsData) {
        self.allActivitys = [IDOSyncV3ActivityDataModel queryAllTrajectorySportV3ActivitysWithMac:__IDO_MAC_ADDR__];
    }else if(__IDO_FUNCTABLE__.funcTable19Model.gps){
        self.allActivitys = [IDOSyncActivityDataModel queryAllTrajectorySportActivitysWithMac:__IDO_MAC_ADDR__];
    }else {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            FuncViewController * funcVc = (FuncViewController *)[IDODemoUtility getCurrentVC];
            [funcVc showToastWithText:lang(@"feature is not supported on the current device")];
        });
        return;
    }
    NSMutableArray * cellModels = [NSMutableArray array];
    for (IDOBluetoothBaseModel * item in self.allActivitys) {
        LabelCellModel * model = [[LabelCellModel alloc]init];
        model.typeStr = @"oneLabel";
        NSString * str = [self dataStrWithModel:item];
        model.data = @[str];
        model.cellHeight = [self getCellHeightWithStr:str];
        model.cellClass = [OneLabelTableViewCell class];
        model.modelClass = [NSNull class];
        model.labelSelectCallback = self.labelSelectCallback;
        model.isShowLine = YES;
        [cellModels addObject:model];
    }
    self.cellModels = cellModels;
}

- (NSString *)dataStrWithModel:(IDOBluetoothBaseModel *)item
{
    if (__IDO_FUNCTABLE__.funcTable22Model.v3GpsData) {
        IDOSyncV3ActivityDataInfoBluetoothModel * model = (IDOSyncV3ActivityDataInfoBluetoothModel *)item;
        BOOL isGps = [IDOSyncGpsDataModel queryActivityHasCoordinatesWithTimeStr:model.timeStr macAddr:@""];
        NSString * type = model.type < self.pickerDataModel.sportTypes.count ? [self.pickerDataModel.sportTypes objectAtIndex:model.type] : lang(@"walk");
        NSString * titleStr = [NSString stringWithFormat:@"%@:%@ [%@]",lang(@"activty type"),type,isGps ? lang(@"trajectory"):lang(@"no trajectory")];
        NSString * timeStr     = [NSString stringWithFormat:@"%@%@",lang(@"time"),[IDODemoUtility timeStrFromTimeStamp:model.timeStr]];
        NSString * macAddrStr  = [NSString stringWithFormat:@"MAC:%@",model.macAddr];
        NSString * dataStr     = [NSString stringWithFormat:@"%@:%ld\n%@:%ld\n%@:%ld",lang(@"calories"),(long)model.calories,
                               lang(@"step"),(long)model.step,lang(@"avg heart rate"),(long)model.avgHrValue];
        NSString * str = [NSString stringWithFormat:@"%@\n%@\n%@\n%@",titleStr,macAddrStr,timeStr,dataStr];
        return str;
    }else {
        IDOSyncActivityDataInfoBluetoothModel * model = (IDOSyncActivityDataInfoBluetoothModel *)item;
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
