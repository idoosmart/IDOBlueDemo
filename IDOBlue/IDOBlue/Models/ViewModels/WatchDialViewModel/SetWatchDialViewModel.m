//
//  SetWatchDialViewModel.m
//  IDOBlue
//
//  Created by 何东阳 on 2019/9/4.
//  Copyright © 2019 hedongyang. All rights reserved.
//

#import "SetWatchDialViewModel.h"
#import "FuncCellModel.h"
#import "OneButtonTableViewCell.h"
#import "FuncViewController.h"

@interface SetWatchDialViewModel()
@property (nonatomic,strong) NSArray * allDevices;
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation SetWatchDialViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getButtonCallback];
        [self getCellModels];
    }
    return self;
}

- (NSArray *)allDevices
{
    if (!_allDevices) {
        _allDevices = [IDOWatchDialInfoModel queryCurrentAllWatchDialModels];
    }
    return _allDevices;
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    for (int i = 0; i < self.allDevices.count; i++) {
        IDOWatchDialInfoModel * watchModel = [self.allDevices objectAtIndex:i];
        FuncCellModel * model = [[FuncCellModel alloc]init];
        model.typeStr = @"oneButton";
        model.data    = @[watchModel.fileName];
        model.cellHeight = 70.0f;
        model.cellClass  = [OneButtonTableViewCell class];
        model.modelClass = [NSNull class];
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
        __block FuncViewController * funcVc = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVc.tableView indexPathForCell:tableViewCell];
        IDOWatchDialInfoModel * model = strongSelf.allDevices[indexPath.row];
        if (model.operate == 0x02) {
            [funcVc showToastWithText:lang(@"current dial has been deleted")];
            return;
        }
        [funcVc showLoadingWithMessage:[NSString stringWithFormat:@"%@...",lang(@"set current dial info")]];
        initWatchDialManager().setCurrentDial(^(int errorCode) {
            if (errorCode == 0) {
                [funcVc showToastWithText:lang(@"set current dial info success")];
            }else if (errorCode == 6) {
                [funcVc showToastWithText:lang(@"feature is not supported on the current device")];
            }else {
                [funcVc showToastWithText:lang(@"set current dial info failed")];
            }
        }, model);
    };
}
@end
