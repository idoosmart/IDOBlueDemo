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
#import "OneButtonTableViewCell.h"
#import "FuncCellModel.h"
#import <QuickLook/QuickLook.h>

@interface RestartLogViewModel()<QLPreviewControllerDelegate,QLPreviewControllerDataSource>
@property (nonatomic,copy)void(^labelSelectCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)NSString * filePath;
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
    model.data    = @[lang(@"get log")];
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
        NSString * filePath = [[labelModel.data firstObject] lastPathComponent];
        strongSelf.filePath = [[IDORecordDeviceLog rebootLogFloderPath] stringByAppendingPathComponent:filePath];
        QLPreviewController *QLPVC = [[QLPreviewController alloc] init];
        QLPVC.delegate = strongSelf;
        QLPVC.dataSource = strongSelf;
        [funcVC presentViewController:QLPVC animated:YES completion:nil];
    };
}

- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVc = (FuncViewController *)viewController;
        [funcVc showLoadingWithMessage:lang(@"get the device logs...")];
        [IDORecordDeviceLog getDeviceLogWithCallback:^(BOOL isComplete) {
            [funcVc showToastWithText:lang(@"get device log completion")];
            if (isComplete) {
                [strongSelf getCellModels];
                [funcVc reloadData];
            }
        }];
    };
}

- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller{
    return 1;
}
- (id<QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index{
    NSArray *arr = @[self.filePath];
    return [NSURL fileURLWithPath:arr[index]];
}


@end
