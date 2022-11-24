//
//  SetWatchDialViewModel.m
//  IDOBlue
//
//  Created by 何东阳 on 2019/9/4.
//  Copyright © 2019 hedongyang. All rights reserved.
//

#import "SetWatchDialViewModel.h"
#import "LabelCellModel.h"
#import "OneLabelTableViewCell.h"
#import "FuncViewController.h"

@interface SetWatchDialViewModel()
@property (nonatomic,strong) NSMutableArray * allDevices;
@property (nonatomic,copy)void(^labelSelectCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation SetWatchDialViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.rightButtonTitle = lang(@"Update dial list");
        self.isRightButton = YES;
        self.rightButton   = @selector(getDialInfoListAction);
        [self getLabelCallback];
        [self getDelectCellCallback];
        [self getCellModels];
    }
    return self;
}

- (void)getDialInfoListAction
{
    __weak typeof(self) weakSelf = self;
    FuncViewController * funcVC = (FuncViewController *)[IDODemoUtility getCurrentVC];
    [funcVC showLoadingWithMessage:[NSString stringWithFormat:@"%@...",lang(@"get watch dial list info")] ];
    if (__IDO_FUNCTABLE__.funcTable35Model.getNewWatchList) {
        initWatchDialManager().getV3WatchListInfo(^(IDOV3WatchDialInfoModel * _Nullable model, int errorCode) {
            __strong typeof(self) strongSelf = weakSelf;
            if (errorCode == 0) {
               [funcVC showToastWithText:lang(@"get watch dial list info success")];
                _allDevices = [[IDOV3WatchDialInfoModel currentModel].dialArray mutableCopy];
                [strongSelf getCellModels];
                [funcVC reloadData];
           }else if (errorCode == 6) {
               [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
           }else {
               [funcVC showToastWithText:lang(@"get watch dial list info failed")];
           }
        });
    }else {
        initWatchDialManager().getDialListInfo(^(IDOWatchDialInfoModel * _Nullable model, int errorCode) {
            __strong typeof(self) strongSelf = weakSelf;
            if (errorCode == 0) {
                _allDevices = [[IDOWatchDialInfoModel currentModel].dialArray mutableCopy];
                [strongSelf getCellModels];
                [funcVC reloadData];
               [funcVC showToastWithText:lang(@"get watch dial list info success")];
           }else if (errorCode == 6) {
               [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
           }else {
               [funcVC showToastWithText:lang(@"get watch dial list info failed")];
           }
        });
    }
}

- (NSMutableArray *)allDevices
{
    if (!_allDevices) {
        if (__IDO_FUNCTABLE__.funcTable35Model.getNewWatchList) {
            _allDevices = [[IDOV3WatchDialInfoModel currentModel].dialArray mutableCopy];
        }else {
            _allDevices = [[IDOWatchDialInfoModel currentModel].dialArray mutableCopy];
        }
    }
    return _allDevices;
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
//    self.allDevices = nil;
    for (int i = 0; i < self.allDevices.count; i++) {
        IDOWatchDialInfoItemModel * watchModel = [self.allDevices objectAtIndex:i];
        LabelCellModel * model = [[LabelCellModel alloc]init];
        model.typeStr = @"oneLabel";
        model.data    = @[watchModel.fileName?:@""];
        model.cellHeight = 70.0f;
        model.cellClass  = [OneLabelTableViewCell class];
        model.modelClass = [NSNull class];
        model.isDelete = YES;
        model.isShowLine = YES;
        model.labelSelectCallback = self.labelSelectCallback;
        [cellModels addObject:model];
    }
    self.cellModels = cellModels;
}

- (void)getLabelCallback
{
    __weak typeof(self) weakSelf = self;
    self.labelSelectCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVc = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVc.tableView indexPathForCell:tableViewCell];
        
        IDOWatchDialInfoItemModel * model = strongSelf.allDevices[indexPath.row];
        if (model.operate == 0x02) {
            [funcVc showToastWithText:lang(@"current dial has been deleted")];
            return;
        }
        model.operate = 0x01;
        [funcVc showLoadingWithMessage:[NSString stringWithFormat:@"%@...",lang(@"set current dial info")]];
        initWatchDialManager().setCurrentDial(^(int errorCode) {
            if (errorCode == 0) {
               [funcVc showToastWithText:lang(@"set current dial info success")];
                if (__IDO_FUNCTABLE__.funcTable35Model.getNewWatchList) {
                    initWatchDialManager().getDialListInfo(^(IDOWatchDialInfoModel * _Nullable model, int errorCode) {
                        if (errorCode == 0) {
                             [strongSelf getCellModels];
                             [funcVc reloadData];
                        }
                    });
                }else {
                    initWatchDialManager().getV3WatchListInfo(^(IDOV3WatchDialInfoModel * _Nullable model, int errorCode) {
                        if (errorCode == 0) {
                             [strongSelf getCellModels];
                             [funcVc reloadData];
                        }
                    });
                }
           }else if (errorCode == 6) {
               [funcVc showToastWithText:lang(@"feature is not supported on the current device")];
           }else {
               [funcVc showToastWithText:lang(@"set current dial info failed")];
           }
        }, model);
    };
}

- (void)getDelectCellCallback
{
    __weak typeof(self) weakSelf = self;
    self.delectCellCallback = ^(UIViewController *viewController, NSIndexPath *indexPath) {
          __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVc = (FuncViewController *)viewController;
        IDOWatchDialInfoItemModel * model = strongSelf.allDevices[indexPath.row];
        model.operate = 0x02;
        [funcVc showLoadingWithMessage:[NSString stringWithFormat:@"%@...",lang(@"delete current dial")]];
        
        initWatchDialManager().setCurrentDial(^(int errorCode) {
            if (errorCode == 0) {
               [funcVc showToastWithText:lang(@"delete current dial success")];
                if (__IDO_FUNCTABLE__.funcTable35Model.getNewWatchList) {
                    initWatchDialManager().getDialListInfo(^(IDOWatchDialInfoModel * _Nullable model, int errorCode) {
                        if (errorCode == 0) {
                            [strongSelf.allDevices removeObjectAtIndex:indexPath.row];
                             [strongSelf getCellModels];
                             [funcVc reloadData];
                        }
                    });
                }else {
                    initWatchDialManager().getV3WatchListInfo(^(IDOV3WatchDialInfoModel * _Nullable model, int errorCode) {
                        if (errorCode == 0) {
                            [strongSelf.allDevices removeObjectAtIndex:indexPath.row];
                             [strongSelf getCellModels];
                             [funcVc reloadData];
                        }
                    });
                }
           }else if (errorCode == 6) {
               [funcVc showToastWithText:lang(@"feature is not supported on the current device")];
           }else {
               [funcVc showToastWithText:lang(@"delete current dial failed")];
           }
        }, model);
    
        
    };
}

@end
