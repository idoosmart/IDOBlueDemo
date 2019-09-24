//
//  FuncViewModel.m
//  IDOBluetoothDemo
//
//  Created by apple on 2018/9/15.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "FuncViewModel.h"
#import "FuncViewController.h"
#import "OneButtonTableViewCell.h"
#import "FuncCellModel.h"
#import "UnbindingViewModel.h"
#import "SetViewModel.h"
#import "GetViewModel.h"
#import "ControlViewModel.h"
#import "SyncViewModel.h"
#import "DataInterchangeModel.h"
#import "UpdateMainViewModel.h"
#import "LogViewModel.h"
#import "QueryViewModel.h"
#import "DataMigrationViewModel.h"
#import "MainMeasureViewModel.h"
#import "MainDialViewModel.h"
#import "ScanViewController.h"
#import "UIScrollView+Refresh.h"

@interface FuncViewModel()
@property (nonatomic,strong) NSArray * buttonTitles;
@property (nonatomic,strong) NSArray * modelClasss;
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation FuncViewModel

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.leftButtonTitle = lang(@"🔧");
        self.isLeftButton = YES;
        self.leftButton   = @selector(actionButton:);
        [self addNotice];
        [self getButtonCallback];
        [self getCellModels];
    }
    return self;
}

- (void)actionButton:(UIButton *)sender
{
    FuncViewController * funcVc = (FuncViewController *)[IDODemoUtility getCurrentVC];
    funcVc.menuView.hidden = NO;
}

- (NSArray *)buttonTitles
{
    if (!_buttonTitles) {
        _buttonTitles = @[@[lang(@"device unbind")],@[lang(@"set function")],@[lang(@"get function")],@[lang(@"control function")],@[lang(@"sync function")],
                          @[lang(@"data interchange")],@[lang(@"device update")],@[lang(@"data query")],@[lang(@"log query")],@[lang(@"data migration")],@[lang(@"measure data")],@[lang(@"watch dial function")]];
    }
    return _buttonTitles;
}

- (NSArray *)modelClasss
{
    if (!_modelClasss) {
        _modelClasss = @[[UnbindingViewModel class],[SetViewModel class],[GetViewModel class],[ControlViewModel class],
                         [SyncViewModel class],[DataInterchangeModel class],[UpdateMainViewModel class],[QueryViewModel class],
                         [LogViewModel class],[DataMigrationViewModel class],[MainMeasureViewModel class],[MainDialViewModel class]];
    }
    return _modelClasss;
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
        model.modelClass = self.modelClasss[i];
        model.buttconCallback = self.buttconCallback;
        [cellModels addObject:model];
    }
    self.cellModels = cellModels;
}

- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVc = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVc.tableView indexPathForCell:tableViewCell];
        BaseCellModel * model   = [strongSelf.cellModels objectAtIndex:indexPath.row];
        if ([NSStringFromClass(model.modelClass)isEqualToString:@"NSNull"])return;
        if (   initSyncManager().isSyncConfigRun
            || initSyncManager().isSyncHealthRun) {
            [funcVc showToastWithText:lang(@"sync data...")];
            return;
        }
        FuncViewController * newFuncVc = [FuncViewController new];
        newFuncVc.model = [model.modelClass new];
        newFuncVc.title = [model.data firstObject];
        [funcVc.navigationController pushViewController:newFuncVc animated:YES];
    };
}

- (void)addNotice
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(languageNotice) name:LANG_NOTICE_NAME object:nil];
}

- (void)languageNotice
{
    self.buttonTitles = nil;
    [self getCellModels];
    NSArray * viewControllers = [IDODemoUtility getCurrentVC].navigationController.viewControllers;
    if (viewControllers.count == 0)return;
    FuncViewController * funcVc = (FuncViewController *)[viewControllers firstObject];
    [funcVc.menuView reloadData];
    funcVc.title = lang(@"function list");
    funcVc.statusLabel.text = IDO_BLUE_ENGINE.managerEngine.isConnected ? lang(@"connected") : IDO_BLUE_ENGINE.managerEngine.isConnecting ? lang(@"connecting") : lang(@"scanning");
    [funcVc.tableView reloadData];
}

@end
