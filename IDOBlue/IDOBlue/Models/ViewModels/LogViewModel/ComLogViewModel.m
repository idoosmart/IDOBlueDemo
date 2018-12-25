//
//  ComLogViewModel.m
//  IDOBlue
//
//  Created by hedongyang on 2018/9/30.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "ComLogViewModel.h"
#import "LabelCellModel.h"
#import "OneLabelTableViewCell.h"
#import "FuncViewController.h"
#import "ShowLogViewModel.h"


@interface ComLogViewModel()
@property (nonatomic,copy)void(^labelSelectCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation ComLogViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getLabelCallback];
        [self getCellModels];
    }
    return self;
}

- (NSArray *)logFileArray
{
    NSURL * url = [NSURL URLWithString:[IDORecordDeviceLog recordLogFloaderPath]];
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
        filePath = [[IDORecordDeviceLog recordLogFloaderPath] stringByAppendingPathComponent:filePath];
        model.filePath = filePath;
        newFunc.model = model;
        newFunc.title = @"日志详情";
        [funcVC.navigationController pushViewController:newFunc animated:YES];
    };
}

@end
