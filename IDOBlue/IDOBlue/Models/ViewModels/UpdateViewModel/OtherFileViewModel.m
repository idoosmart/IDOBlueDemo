//
//  OtherFileViewModel.m
//  IDOBlue
//
//  Created by 何东阳 on 2019/6/3.
//  Copyright © 2019 hedongyang. All rights reserved.
//

#import "OtherFileViewModel.h"
#import "IDODemoUtility.h"
#import "LabelCellModel.h"
#import "OneLabelTableViewCell.h"
#import "FuncViewController.h"

@interface OtherFileViewModel()
@property (nonatomic,copy)void(^labelSelectCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation OtherFileViewModel
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
    if (!_dirPath) return [NSArray array];
    NSArray * fileList =  [[NSFileManager defaultManager] contentsOfDirectoryAtPath:_dirPath error:nil];
    return fileList;
}

- (NSArray *)agpsLocalFileArr
{
    if (!_dirPath) return [NSArray array];
    NSArray * fileList =  [[NSFileManager defaultManager] contentsOfDirectoryAtPath:_dirPath error:nil];
    return fileList;
}

- (void)setDirPath:(NSString *)dirPath
{
    _dirPath = dirPath;
    [self getFiles];
}

- (void)getFiles
{
    if (_type == 0) { //固件文件
        [self getCellModels:self.otaLocalFileArr];
    }else { //agps文件
        [self getCellModels:self.agpsLocalFileArr];
    }
}

- (void)getCellModels:(NSArray *)files
{
    NSMutableArray * cellModels = [NSMutableArray array];
    for (int i = 0; i < files.count; i++) {
        NSString * fileName = [files objectAtIndex:i];
        LabelCellModel * model = [[LabelCellModel alloc]init];
        model.typeStr = @"oneLabel";
        model.data    = @[fileName];
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
        NSString * fileName = [cellModel.data firstObject];
        if (strongSelf.type == 2) {
            BOOL isDir = NO;
            NSString * filePath = [strongSelf.dirPath stringByAppendingPathComponent:fileName];
            [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDir];
            if(isDir) { //目录有下级文件
                FuncViewController * vc = [[FuncViewController alloc]init];
                OtherFileViewModel * fileModel = [OtherFileViewModel new];
                fileModel.type    = strongSelf.type;
                fileModel.dirPath = filePath;
                vc.model = fileModel;
                vc.title = fileName?:lang(@"selected files");
                fileModel.selectFileCallback = strongSelf.selectFileCallback;
                [funcVC.navigationController pushViewController:vc animated:YES];
            }else { //文件无下级文件
                [[NSUserDefaults standardUserDefaults] setValue:filePath forKey:SANDBOX_FILE_PATH_KEY];
                if (strongSelf.selectFileCallback) {
                    strongSelf.selectFileCallback(filePath);
                }
            }
        }else {
            NSInteger fileMode  = [[[NSUserDefaults standardUserDefaults]objectForKey:FILE_MODE_KEY] integerValue];
            if (fileMode == 0) {
                if (strongSelf.type == 0) {
                    NSString * filePath = [NSBundle mainBundle].bundlePath;
                    NSString * dirPath = [filePath stringByAppendingPathComponent:@"Firmwares"];
                    filePath = [dirPath stringByAppendingPathComponent:fileName];
                    [[NSUserDefaults standardUserDefaults] setValue:filePath forKey:FIRMWARE_FILE_PATH_KEY];
                    if (strongSelf.selectFileCallback) {
                        strongSelf.selectFileCallback(filePath);
                    }
                }else {
                    NSString * filePath = [NSBundle mainBundle].bundlePath;
                    NSString * dirPath = [filePath stringByAppendingPathComponent:@"Files"];
                    filePath = [dirPath stringByAppendingPathComponent:fileName];
                    [[NSUserDefaults standardUserDefaults] setValue:filePath forKey:TRAN_FILE_PATH_KEY];
                    if (strongSelf.selectFileCallback) {
                        strongSelf.selectFileCallback(filePath);
                    }
                }
            }else {
                BOOL isDir = NO;
                NSString * filePath = [strongSelf.dirPath stringByAppendingPathComponent:fileName];
                [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDir];
                if(isDir) { //目录有下级文件
                    FuncViewController * vc = [[FuncViewController alloc]init];
                    OtherFileViewModel * fileModel = [OtherFileViewModel new];
                    fileModel.type    = strongSelf.type;
                    fileModel.dirPath = filePath;
                    vc.model = fileModel;
                    vc.title = fileName?:lang(@"selected firmware");
                    fileModel.selectFileCallback = strongSelf.selectFileCallback;
                    [funcVC.navigationController pushViewController:vc animated:YES];
                }else { //文件无下级文件
                    if (strongSelf.type == 0) {
                        [[NSUserDefaults standardUserDefaults] setValue:filePath forKey:FIRMWARE_FILE_PATH_KEY];
                    }else {
                        [[NSUserDefaults standardUserDefaults] setValue:filePath forKey:TRAN_FILE_PATH_KEY];
                    }
                    if (strongSelf.selectFileCallback) {
                        strongSelf.selectFileCallback(filePath);
                    }
                }
            }
        }
    };
}
@end
