//
//  RestartLogViewModel.m
//  IDOBlue
//
//  Created by apple on 2018/10/3.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "RestartLogViewModel.h"
#import "LabelCellModel.h"
#import "OneLabelTableViewCell.h"
#import "FuncViewController.h"
#import "ShowLogViewModel.h"
#import "OneButtonTableViewCell.h"
#import "FuncCellModel.h"


@interface RestartLogViewModel()
@property (nonatomic,copy)void(^labelSelectCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end


@implementation RestartLogViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getLabelCallback];
        [self getButtonCallback];
        [self getCellModels];
    }
    return self;
}

- (NSArray *)logFileArray
{
    NSURL * url = [NSURL URLWithString:[IDORecordDeviceLog rebootLogFloderPath]];
    NSError * error = nil;
    if (!url) return [NSArray array];
    NSArray * fileList =  [[NSFileManager defaultManager] contentsOfDirectoryAtURL:url
                                                        includingPropertiesForKeys:nil
                                                                           options:0
                                                                             error:&error];
    return fileList;
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    FuncCellModel * model = [[FuncCellModel alloc]init];
    model.typeStr = @"oneButton";
    model.data    = @[@"获取日志"];
    model.cellHeight = 70.0f;
    model.cellClass  = [OneButtonTableViewCell class];
    model.modelClass = [NSNull class];
    model.isShowLine = YES;
    model.buttconCallback = self.buttconCallback;
    [cellModels addObject:model];
    
    for (NSURL * url in [self logFileArray]) {
        LabelCellModel * model = [[LabelCellModel alloc]init];
        model.typeStr = @"oneLabel";
        model.data = @[[url lastPathComponent]];
        model.cellHeight = 70.0f;
        model.cellClass = [OneLabelTableViewCell class];
        model.modelClass = [NSNull class];
        model.labelSelectCallback = self.labelSelectCallback;
        model.isShowLine = YES;
        [cellModels addObject:model];
    }
    self.cellModels = cellModels;
}

- (void)getLabelCallback
{
    __weak typeof(self) weakSelf = self;
    self.labelSelectCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        LabelCellModel * labelModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
        FuncViewController * newFunc = [FuncViewController new];
        ShowLogViewModel * model = [ShowLogViewModel new];
        NSString * filePath = [[labelModel.data firstObject] lastPathComponent];
        filePath = [[IDORecordDeviceLog rebootLogFloderPath] stringByAppendingPathComponent:filePath];
        model.filePath = filePath;
        newFunc.model = model;
        newFunc.title = @"日志详情";
        [funcVC.navigationController pushViewController:newFunc animated:YES];
    };
}

- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVc = (FuncViewController *)viewController;
        [funcVc showLoadingWithMessage:@"获取设备日志..."];
        [IDORecordDeviceLog getDeviceLogWithCallback:^(BOOL isComplete) {
            [funcVc showToastWithText:@"获取设备日志完成"];
            if (isComplete) {
                [strongSelf getCellModels];
                [funcVc reloadData];
            }
        }];
    };
}

@end
