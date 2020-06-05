//
//  FlashLogViewModel.m
//  IDOBlue
//
//  Created by 何东阳 on 2020/3/7.
//  Copyright © 2020 hedongyang. All rights reserved.
//

#import "FlashLogViewModel.h"
#import "LabelCellModel.h"
#import "OneLabelTableViewCell.h"
#import "FuncViewController.h"
#import "OneButtonTableViewCell.h"
#import "FuncCellModel.h"
#import <QuickLook/QuickLook.h>

@interface FlashLogViewModel ()<QLPreviewControllerDelegate,QLPreviewControllerDataSource>
@property (nonatomic,copy)void(^labelSelectCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)NSString * filePath;
@property (nonatomic,strong) NSArray * buttonTitles;
@end

@implementation FlashLogViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getLabelCallback];
        [self getButtonCallback];
        [self getCellModels];
        [self getFlashLogComplete];
    }
    return self;
}

- (NSArray *)logFileArray
{
    NSURL * url = [NSURL URLWithString:[IDORecordDeviceLog recordFlashLogFloaderPath]];
    NSError * error = nil;
    if (!url) return [NSArray array];
    NSArray * fileList =  [[NSFileManager defaultManager] contentsOfDirectoryAtURL:url
                                                        includingPropertiesForKeys:nil
                                                                           options:0
                                                                             error:&error];
    return fileList;
}

- (NSArray *)buttonTitles
{
    if (!_buttonTitles) {
        _buttonTitles = @[lang(@"get general log"),lang(@"get reset log"),
                          lang(@"get algorithm log"),lang(@"get hardware log")];
    }
    return _buttonTitles;
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    
    for (int i = 0;i<self.buttonTitles.count;i++) {
        NSString * title = self.buttonTitles[i];
        FuncCellModel * model = [[FuncCellModel alloc]init];
        model.typeStr = @"oneButton";
        model.data    = @[title];
        model.cellHeight = 70.0f;
        model.cellClass  = [OneButtonTableViewCell class];
        model.modelClass = [NSNull class];
        model.index = i;
        model.isShowLine = YES;
        model.buttconCallback = self.buttconCallback;
        [cellModels addObject:model];
    }

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

- (void)getFlashLogComplete
{
    __weak typeof(self) weakSelf = self;
    [IDORecordDeviceLog flashLogRecordComplete:^(int errorCode) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVc = (FuncViewController *)[IDODemoUtility getCurrentVC];
        if (errorCode == 0) {
            [funcVc showToastWithText:lang(@"get flash log complete")];
        }else if(errorCode == 6){
            [funcVc showToastWithText:lang(@"feature is not supported on the current device")];
        }else {
            [funcVc showToastWithText:lang(@"get flash log failed")];
        }
        [strongSelf getCellModels];
        [funcVc reloadData];
    }];
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
        strongSelf.filePath = [[IDORecordDeviceLog recordFlashLogFloaderPath] stringByAppendingPathComponent:filePath];
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
        NSIndexPath * indexPath = [funcVc.tableView indexPathForCell:tableViewCell];
        FuncCellModel * model = [strongSelf.cellModels objectAtIndex:indexPath.row];
        NSString * message = [NSString stringWithFormat:@"%@...",[model.data firstObject]];
        [funcVc showLoadingWithMessage:message];
        if (model.index == 0) { //通用日志
            [IDORecordDeviceLog startFlashLogRecordWithType:IDO_FLASH_LOG_GENERAL_TYPE];
        }else if (model.index == 1) { //复位日志
            [IDORecordDeviceLog startFlashLogRecordWithType:IDO_FLASH_LOG_RESET_TYPE];
        }else if (model.index == 2) {//算法日志
            [IDORecordDeviceLog startFlashLogRecordWithType:IDO_FLASH_LOG_ALGORITHM_TYPE];
        }else if (model.index == 3) {//硬件日志
            [IDORecordDeviceLog startFlashLogRecordWithType:IDO_FLASH_LOG_HARDWARE_TYPE];
        }
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
