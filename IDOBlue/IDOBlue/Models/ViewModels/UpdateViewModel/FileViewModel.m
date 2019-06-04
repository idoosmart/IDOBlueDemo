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
#import "OtherFileViewModel.h"

@interface FileViewModel()
@property (nonatomic,copy)void(^labelSelectCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy) NSString * dirPath;
@end

@implementation FileViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        NSInteger fileMode = [[[NSUserDefaults standardUserDefaults]objectForKey:FILE_MODE_KEY] integerValue];
        self.rightButtonTitle = fileMode == 1 ? lang(@"sandbox") : lang(@"bundle");
        self.isRightButton    = YES;
        self.rightButton      = @selector(actionButton:);
        [self getLabelSelectCallback];
    }
    return self;
}

- (void)actionButton:(UIBarButtonItem *)sender
{
    if ([sender.title isEqualToString:lang(@"sandbox")]) {
        sender.title = lang(@"bundle");
        [[NSUserDefaults standardUserDefaults] setValue:@(0) forKey:FILE_MODE_KEY];
    }else {
        sender.title = lang(@"sandbox");
        [[NSUserDefaults standardUserDefaults] setValue:@(1) forKey:FILE_MODE_KEY];
    }
    [self getFiles];
    FuncViewController * funcVC = (FuncViewController *)[IDODemoUtility getCurrentVC];
    [funcVC reloadData];
    
}

- (NSArray *)otaLocalFileArr
{
    NSInteger fileMode = [[[NSUserDefaults standardUserDefaults]objectForKey:FILE_MODE_KEY] integerValue];
    NSString * dirPath = nil;
    if (fileMode == 0) {
        NSString * filePath = [NSBundle mainBundle].bundlePath;
        dirPath = [filePath stringByAppendingPathComponent:@"Firmwares"];
    }else {
        dirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) lastObject];
    }
    if (!dirPath) return [NSArray array];
    self.dirPath = dirPath;
    NSArray * fileList =  [[NSFileManager defaultManager] contentsOfDirectoryAtPath:dirPath error:nil];
    return fileList;
}

- (NSArray *)agpsLocalFileArr
{
    NSInteger fileMode = [[[NSUserDefaults standardUserDefaults]objectForKey:FILE_MODE_KEY] integerValue];
    NSString * dirPath = nil;
    if (fileMode == 0) {
        NSString * filePath = [NSBundle mainBundle].bundlePath;
        dirPath = [filePath stringByAppendingPathComponent:@"Agps"];
    }else {
        dirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) lastObject];
    }
    if (!dirPath) return [NSArray array];
    self.dirPath = dirPath;
    NSArray * fileList =  [[NSFileManager defaultManager] contentsOfDirectoryAtPath:dirPath error:nil];
    return fileList;
}

- (void)setType:(NSInteger)type
{
    _type = type;
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
        NSString * fileName = [cellModel.data firstObject];
        NSInteger fileMode  = [[[NSUserDefaults standardUserDefaults]objectForKey:FILE_MODE_KEY] integerValue];
        if (fileMode == 0) {
            if (strongSelf.type == 0) {
                NSString * filePath = [NSBundle mainBundle].bundlePath;
                NSString * dirPath = [filePath stringByAppendingPathComponent:@"Firmwares"];
                filePath = [dirPath stringByAppendingPathComponent:fileName];
                [[NSUserDefaults standardUserDefaults] setValue:filePath forKey:FIRMWARE_FILE_PATH_KEY];
            }else {
                NSString * filePath = [NSBundle mainBundle].bundlePath;
                NSString * dirPath = [filePath stringByAppendingPathComponent:@"Agps"];
                filePath = [dirPath stringByAppendingPathComponent:fileName];
                [[NSUserDefaults standardUserDefaults] setValue:filePath forKey:AGPS_FILE_PATH_KEY];
            }
            [[NSNotificationCenter defaultCenter]postNotificationName:@"idoDemoSelectFileNotice" object:nil userInfo:nil];
            [funcVC.navigationController popViewControllerAnimated:YES];
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
                vc.title = lang(@"selected firmware");
                fileModel.selectFileCallback = ^(NSString * _Nonnull filePath) {
                    if (strongSelf.type == 0) {
                        [[NSUserDefaults standardUserDefaults] setValue:filePath forKey:FIRMWARE_FILE_PATH_KEY];
                    }else {
                        [[NSUserDefaults standardUserDefaults] setValue:filePath forKey:AGPS_FILE_PATH_KEY];
                    }
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"idoDemoSelectFileNotice" object:nil userInfo:nil];
                    NSInteger index = [funcVC.navigationController.viewControllers indexOfObject:funcVC];
                    UIViewController * vc = [funcVC.navigationController.viewControllers objectAtIndex:index >= 1 ? (index - 1) : 0];
                    [funcVC.navigationController popToViewController:vc animated:YES];
                };
                [funcVC.navigationController pushViewController:vc animated:YES];
            }else { //文件无下级文件
                if (strongSelf.type == 0) {
                    [[NSUserDefaults standardUserDefaults] setValue:filePath forKey:FIRMWARE_FILE_PATH_KEY];
                }else {
                    [[NSUserDefaults standardUserDefaults] setValue:filePath forKey:AGPS_FILE_PATH_KEY];
                }
                [[NSNotificationCenter defaultCenter]postNotificationName:@"idoDemoSelectFileNotice" object:nil userInfo:nil];
                [funcVC.navigationController popViewControllerAnimated:YES];
            }
        }
       
    };
}

@end
