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
@property (nonatomic,strong) NSArray * allDevices;
@property (nonatomic,copy)void(^labelSelectCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation SetWatchDialViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getLabelCallback];
        [self getDelectCellCallback];
        [self getCellModels];
    }
    return self;
}

- (NSArray *)allDevices
{
    if (!_allDevices) {
        _allDevices = [IDOWatchDialInfoModel currentModel].dialArray;
    }
    return _allDevices;
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    self.allDevices = nil;
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
        model.isSelected = watchModel.operate == 0x00 ? YES : NO;
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
        initWatchDialManager().setCurrentDial(^(IDOWatchDialInfoModel * _Nullable model, int errorCode) {
           if (errorCode == 0) {
              [funcVc showToastWithText:lang(@"set current dial info success")];
               initWatchDialManager().getDialListInfo(^(IDOWatchDialInfoModel * _Nullable model, int errorCode) {
                   if (errorCode == 0) {
                        [strongSelf getCellModels];
                        [funcVc reloadData];
                   }
               });
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
        initWatchDialManager().setCurrentDial(^(IDOWatchDialInfoModel * _Nullable model, int errorCode) {
            if (errorCode == 0) {
               [funcVc showToastWithText:lang(@"delete current dial success")];
               initWatchDialManager().getDialListInfo(^(IDOWatchDialInfoModel * _Nullable model, int errorCode) {
                   if (errorCode == 0) {
                        [strongSelf getCellModels];
                        [funcVc reloadData];
                   }
               });
           }else if (errorCode == 6) {
               [funcVc showToastWithText:lang(@"feature is not supported on the current device")];
           }else {
               [funcVc showToastWithText:lang(@"delete current dial failed")];
           }
        }, model);
    };
}

@end
