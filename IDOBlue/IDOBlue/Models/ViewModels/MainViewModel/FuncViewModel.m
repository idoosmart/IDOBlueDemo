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
#import "ScanViewController.h"

@interface FuncViewModel()
@property (nonatomic,strong) NSArray * buttonTitles;
@property (nonatomic,strong) NSArray * modelClasss;
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation FuncViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.leftButtonTitle = lang(@"mandatory unbind");
        self.isLeftButton = YES;
        self.leftButton   = @selector(actionButton:);
        [self getButtonCallback];
        [self getCellModels];
    }
    return self;
}

- (void)actionButton:(UIButton *)sender
{
    [IDOFoundationCommand mandatoryUnbindingCommand:^(int errorCode) {
        if (errorCode == 0) {
            ScanViewController * scanVC  = [[ScanViewController alloc]init];
            UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:scanVC];
            [UIApplication sharedApplication].delegate.window.rootViewController = nav;
            for (UIView * view in [UIApplication sharedApplication].keyWindow.subviews) {
                if ([NSStringFromClass([view class]) isEqualToString:@"UITransitionView"]) {
                    [view removeFromSuperview];
                }
            }
        }
    }];
}

- (NSArray *)buttonTitles
{
    if (!_buttonTitles) {
        _buttonTitles = @[@[lang(@"device unbind")],@[lang(@"set function")],@[lang(@"get function")],@[lang(@"control function")],@[lang(@"sync function")],
                          @[lang(@"data interchange")],@[lang(@"device update")],@[lang(@"data query")],@[lang(@"log query")],@[lang(@"data migration")],@[lang(@"measure data")]];
    }
    return _buttonTitles;
}

- (NSArray *)modelClasss
{
    if (!_modelClasss) {
        _modelClasss = @[[UnbindingViewModel class],[SetViewModel class],[GetViewModel class],[ControlViewModel class],
                         [SyncViewModel class],[DataInterchangeModel class],[UpdateMainViewModel class],[QueryViewModel class],
                         [LogViewModel class],[DataMigrationViewModel class],[MainMeasureViewModel class]];
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
        FuncViewController * newFuncVc = [FuncViewController new];
        newFuncVc.model = [model.modelClass new];
        newFuncVc.title = [model.data firstObject];
        [funcVc.navigationController pushViewController:newFuncVc animated:YES];
    };
}

@end
