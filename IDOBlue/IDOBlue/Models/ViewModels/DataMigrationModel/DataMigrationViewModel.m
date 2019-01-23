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

@interface DataMigrationViewModel ()
@property (nonatomic,strong) NSArray * buttonTitles;
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation DataMigrationViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getButtonCallback];
        [self getCellModels];
    }
    return self;
}

- (NSArray *)buttonTitles
{
    if (!_buttonTitles) {
        _buttonTitles = @[@[@"数据库迁移"],@[@"数据转json"]];
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
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        FuncViewController * funcVc = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVc.tableView indexPathForCell:tableViewCell];
        if (indexPath.row == 0) {
            if ([IDODataMigrationManager isNeedMigration]) {
                [IDODataMigrationManager dataMigrationProgressBlock:^(float progress) {
                    [funcVc showSyncProgress:progress];
                }];
                [IDODataMigrationManager dataMigrationWithFileNames:@[] completeBlock:^(BOOL isSuccess) {
                    [funcVc showToastWithText:@"数据迁移完成"];
                }];
                [IDODataMigrationManager dataMigrationStart:NO];
            }else {
                [funcVc showToastWithText:@"不需要数据迁移"];
            }
        }else {
            [funcVc showLoadingWithMessage:@"数据正在转换中..."];
            [IDODataMigrationManager dataToJsonFileProgressBlock:^(float progress) {
                [funcVc showSyncProgress:progress];
            }];
            [IDODataMigrationManager dataToJsonFileCompleteBlock:^(BOOL isSuccess, NSString *newDirePath) {
                [funcVc showToastWithText:@"数据转json完成"];
            }];
            [IDODataMigrationManager dataToJsonFileStart:nil];
        }
    };
}

@end
