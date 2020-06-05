//
//  DataMigrationViewModel.m
//  IDOBlue
//
//  Created by 何东阳 on 2019/1/15.
//  Copyright © 2019年 hedongyang. All rights reserved.
//

#import "DataMigrationViewModel.h"
#import "FuncCellModel.h"
#import "OneButtonTableViewCell.h"
#import "FuncViewController.h"
#import "FileViewModel.h"

@interface DataMigrationViewModel ()
@property (nonatomic,strong) NSArray * buttonTitles;
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)NSString * jsonPath;
@end

@implementation DataMigrationViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.rightButtonTitle = lang(@"selected files");
        self.isRightButton = YES;
        self.rightButton   = @selector(actionButton:);
        [self getButtonCallback];
        [self getCellModels];
    }
    return self;
}

- (NSString *)getFilePath
{
    NSString * filePath = [[NSUserDefaults standardUserDefaults]objectForKey:SANDBOX_FILE_PATH_KEY];
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) lastObject];
    NSRange range   = [filePath rangeOfString:@"Documents"];
    if (range.location != NSNotFound) {
        NSString * fileName = [filePath substringFromIndex:range.location + range.length];
        path = [path stringByAppendingPathComponent:fileName];
    }
    return path;
}

- (void)actionButton:(UIBarButtonItem *)sender
{
    FuncViewController * vc = [[FuncViewController alloc]init];
    FileViewModel * fileModel = [FileViewModel new];
    fileModel.type = 2;
    vc.model = fileModel;
    vc.title = lang(@"selected files");
    [[IDODemoUtility getCurrentVC].navigationController pushViewController:vc animated:YES];
}

- (NSArray *)buttonTitles
{
    if (!_buttonTitles) {
        _buttonTitles = @[@[lang(@"data migration")],@[lang(@"data to json")]];
    }
    return _buttonTitles;
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    for (int i = 0; i < self.buttonTitles.count; i++) {
        NSArray * data = [self.buttonTitles objectAtIndex:i];
        FuncCellModel * model = [[FuncCellModel alloc]init];
        model.typeStr = @"oneButton";
        model.data    = data;
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
        FuncViewController * funcVc = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVc.tableView indexPathForCell:tableViewCell];
        if (indexPath.row == 0) {
            if ([IDODataMigrationManager isNeedMigration]) {
                [IDODataMigrationManager dataMigrationProgressBlock:^(float progress) {
                    [funcVc showSyncProgress:progress];
                }];
                [IDODataMigrationManager dataMigrationWithFileNames:@[] completeBlock:^(BOOL isSuccess) {
                    [funcVc showToastWithText:lang(@"data migration complete")];
                }];
                [IDODataMigrationManager dataMigrationStart];
            }else {
                [funcVc showToastWithText:lang(@"no need migration")];
            }
        }else if (indexPath.row == 1) {
            __strong typeof(self) strongSelf = weakSelf;
            //[strongSelf deleteHealthData];
            [funcVc showLoadingWithMessage:lang(@"data migration...")];
            [IDODataMigrationManager dataToJsonFileProgressBlock:^(float progress) {
                [funcVc showSyncProgress:progress];
            }];
            [IDODataMigrationManager dataToJsonFileCompleteBlock:^(BOOL isSuccess, NSString *zipPath) {
                [funcVc showToastWithText:lang(@"data to json commplete")];
            }];
            [IDODataMigrationManager dataToJsonFileStart:[strongSelf getFilePath]];
        }
    };
}

- (void)deleteHealthData
{
    [IDOSyncSportDataInfoBluetoothModel deleteCurrentTable];
    [IDOSyncSportDataItemInfoBluetoothModel deleteCurrentTable];
    //睡眠
    [IDOSyncSleepDataInfoBluetoothModel deleteCurrentTable];
    [IDOSyncSleepDataItemInfoBluetoothModel deleteCurrentTable];
    //心率
    [IDOSyncHrDataInfoBluetoothModel deleteCurrentTable];
    [IDOSyncHrDataItemInfoBluetoothModel deleteCurrentTable];
    //血压
    [IDOSyncBpDataInfoBluetoothModel deleteCurrentTable];
    [IDOSyncBpDataItemInfoBluetoothModel deleteCurrentTable];
    //运动
    [IDOSyncActivityDataInfoBluetoothModel deleteCurrentTable];
    //轨迹
    [IDOSyncGpsDataInfoBluetoothModel deleteCurrentTable];
    [IDOSyncGpsDataItemInfoBluetoothModel deleteCurrentTable];
    //体重
    [IDOWeightBluetoothModel deleteCurrentTable];
}

@end
