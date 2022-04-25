//
//  QueryActivityViewModel.m
//  IDOBlue
//
//  Created by 何东阳 on 2018/10/24.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "QueryActivityViewModel.h"
#import "LabelCellModel.h"
#import "OneLabelTableViewCell.h"
#import "FuncViewController.h"
#import "IDODemoUtility.h"
#import "QueryActivityDetailViewModel.h"

@interface QueryActivityViewModel()
@property (nonatomic,assign) NSInteger pageNumber;
@property (nonatomic,assign) NSInteger pageIndex;
@property (nonatomic,copy) NSString * macAddr;
@property (nonatomic,strong) NSMutableArray * allActivitys;
@property (nonatomic,strong) NSMutableArray * allCellModels;
@property (nonatomic,copy)void(^labelSelectCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation QueryActivityViewModel

- (id)init
{
    self = [super init];
    if (self) {
        self.pageIndex  = 0;
        self.pageNumber = 20;
        self.isFootButton = YES;
        self.rightButtonTitle = @"🔒";
        self.isRightButton = YES;
        self.rightButton   = @selector(actionButton:);
        [self getLabelCallback];
        [self getFootButtonCallback];
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
    NSArray * activitys = [NSArray array];
    if (__IDO_FUNCTABLE__.funcTable29Model.v3SyncActivity) {
         activitys = [IDOSyncV3ActivityDataModel queryOnePageV3ActivityDataWithPageIndex:self.pageIndex
                                                                             numOfPage:self.pageNumber
                                                                               macAddr:self.macAddr];
    }else {
        activitys = [IDOSyncActivityDataModel queryOnePageActivityDataWithPageIndex:self.pageIndex
                                                                          numOfPage:self.pageNumber
                                                                            macAddr:self.macAddr];
    }
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
    CGFloat width = [IDODemoUtility getCurrentVC].view.frame.size.width - 32;
    return [IDODemoUtility getLabelheight:str width:width font:[UIFont systemFontOfSize:14]] + 20;
}

- (void)getLabelCallback
{
    __weak typeof(self) weakSelf = self;
    self.labelSelectCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVc = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVc.tableView indexPathForCell:tableViewCell];
        IDOBluetoothBaseModel * model = [strongSelf.allActivitys objectAtIndex:indexPath.row];
        FuncViewController * newFuncVc = [FuncViewController new];
        QueryActivityDetailViewModel * detailModel = [QueryActivityDetailViewModel new];
        detailModel.activityModel = model;
        newFuncVc.model = detailModel;
        newFuncVc.title = lang(@"activity detail");
        [funcVc.navigationController pushViewController:newFuncVc animated:YES];
    };
}

- (void)getFootButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.footButtonCallback = ^(UIViewController *viewController) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVc = (FuncViewController *)viewController;
        [funcVc showLoadingWithMessage:lang(@"loading data...")];
        strongSelf.pageIndex ++;
        [strongSelf getCellModels];
        [funcVc.tableView reloadData];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [funcVc showToastWithText:lang(@"loading complete")];
        });
    };
}

@end
