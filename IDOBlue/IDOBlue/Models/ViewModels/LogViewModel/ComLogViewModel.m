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
#import <QuickLook/QuickLook.h>

@interface ComLogViewModel()<QLPreviewControllerDelegate,QLPreviewControllerDataSource>
@property (nonatomic,copy)void(^labelSelectCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)NSString * filePath;
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
        NSString * filePath = [[labelModel.data firstObject] lastPathComponent];
        strongSelf.filePath = [[IDORecordDeviceLog recordLogFloaderPath] stringByAppendingPathComponent:filePath];
        QLPreviewController *QLPVC = [[QLPreviewController alloc] init];
        QLPVC.delegate = strongSelf;
        QLPVC.dataSource = strongSelf;
        [funcVC presentViewController:QLPVC animated:YES completion:nil];
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
