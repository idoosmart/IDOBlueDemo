//
//  FileViewModel.m
//  IDOBluetoothDemo
//
//  Created by apple on 2018/9/16.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "FileViewModel.h"
#import "IDODemoUtility.h"
#import "LabelCellModel.h"
#import "OneLabelTableViewCell.h"
#import "FuncViewController.h"

@interface FileViewModel()
@property (nonatomic,copy)void(^labelSelectCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation FileViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getLabelSelectCallback];
    }
    return self;
}

- (NSArray *)otaLocalFileArr
{
    NSInteger type = [[NSUserDefaults standardUserDefaults]integerForKey:PRODUCTION_MODE_KEY];
    NSString * filePath = nil;
    if(type == 0) {
        NSString * docsdir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) lastObject];
        filePath = [docsdir stringByAppendingPathComponent:@"Firmwares"];
    }else {
        NSString * docsdir = [NSBundle mainBundle].bundlePath;
        filePath = [docsdir stringByAppendingPathComponent:@"Firmwares"];
    }
    NSURL * url = [NSURL URLWithString:filePath];
    NSError * error = nil;
    if (!url) return [NSArray array];
    NSArray * fileList =  [[NSFileManager defaultManager] contentsOfDirectoryAtURL:url
                                                        includingPropertiesForKeys:nil
                                                                           options:0
                                                                             error:&error];
    return fileList;
}

- (NSArray *)agpsLocalFileArr
{
    NSString * filePath = [NSBundle mainBundle].bundlePath;
    filePath = [filePath stringByAppendingPathComponent:@"Agps"];
    NSURL * url = [NSURL URLWithString:filePath];
    NSError * error = nil;
    if (!url) return [NSArray array];
    NSArray * fileList =  [[NSFileManager defaultManager] contentsOfDirectoryAtURL:url
                                                        includingPropertiesForKeys:nil
                                                                           options:0
                                                                             error:&error];
    return fileList;
}

- (void)setType:(NSInteger)type
{
    _type = type;
    if (type == 0) {
        [self getCellModels:self.otaLocalFileArr];
    }else {
        [self getCellModels:self.agpsLocalFileArr];
    }
}

- (void)getCellModels:(NSArray *)files
{
    NSMutableArray * cellModels = [NSMutableArray array];
    for (int i = 0; i < files.count; i++) {
        NSURL * url = [files objectAtIndex:i];
        LabelCellModel * model = [[LabelCellModel alloc]init];
        model.typeStr = @"oneLabel";
        model.data    = @[url];
        model.cellHeight = 45.0f;
        model.isShowLine = YES;
        model.cellClass  = [OneLabelTableViewCell class];
        model.modelClass = [NSNull class];
        model.labelSelectCallback = self.labelSelectCallback;
        [cellModels addObject:model];
    }
    self.cellModels = cellModels;
}

- (void)getLabelSelectCallback
{
    __weak typeof(self) weakSelf = self;
    self.labelSelectCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        LabelCellModel * cellModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
        NSString * filepath = [[cellModel.data firstObject] absoluteString];
        if (strongSelf.type == 0) {
           [[NSUserDefaults standardUserDefaults] setValue:filepath forKey:FIRMWARE_FILE_PATH_KEY];
        }else {
           [[NSUserDefaults standardUserDefaults] setValue:filepath forKey:AGPS_FILE_PATH_KEY];
        }
        [funcVC.navigationController popViewControllerAnimated:YES];
    };
}

@end
