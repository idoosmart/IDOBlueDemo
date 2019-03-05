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

@interface QueryActivityViewModel()
@property (nonatomic,assign) NSInteger pageNumber;
@property (nonatomic,assign) NSInteger pageIndex;
@property (nonatomic,strong) NSMutableArray * allActivitys;
@property (nonatomic,strong) NSMutableArray * allCellModels;
@property (nonatomic,copy)void(^labelSelectCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation QueryActivityViewModel

- (id)init
{
    self = [super init];
    if (self) {
        self.pageIndex = 0;
        self.pageNumber = 20;
        self.isFootButton = YES;
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
    NSArray <IDOSyncActivityDataInfoBluetoothModel *> * activitys = [IDOSyncActivityDataInfoBluetoothModel queryOnePageActivityDataWithPageIndex:self.pageIndex numOfPage:self.pageNumber macAddr:__IDO_MAC_ADDR__];
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
    NSString * titleStr = [self.pickerDataModel.sportTypes objectAtIndex:model.type];
    NSString * timeStr  = [NSString stringWithFormat:@"时间 ：%@",[IDODemoUtility timeStrFromTimeStamp:model.timeStr]];
    NSString * dataStr  = [NSString stringWithFormat:@"卡路里 ：%ld 步数 ：%ld 平均心率 ：%ld",(long)model.calories,(long)model.step,model.avgHrValue];
    NSString * str = [NSString stringWithFormat:@"%@\n%@\n%@",titleStr,timeStr,dataStr];
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
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
    };
}

- (void)getFootButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.footButtonCallback = ^(UIViewController *viewController) {
        __strong typeof(self) strongSelf = weakSelf;
        strongSelf.pageIndex ++;
        [strongSelf getCellModels];
    };
}

@end
