//
//  ControlViewModel.m
//  IDOBluetoothDemo
//
//  Created by apple on 2018/9/16.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "ControlViewModel.h"
#import "FuncCellModel.h"
#import "OneButtonTableViewCell.h"
#import "FuncViewController.h"
#import "TakePictureViewModel.h"
#import "ControlMusicViewModel.h"
#import "ControlNotifyViewModel.h"
#import "ControlRestoreViewModel.h"
#import "ControlRestartViewModel.h"
#import "ListenVoiceDataViewModel.h"
#import "ControlResetViewModel.h"

@interface ControlViewModel()
@property (nonatomic,strong) NSArray * buttonTitles;
@property (nonatomic,strong) NSArray * modelClasss;
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation ControlViewModel
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
        _buttonTitles = @[@[lang(@"photo control")],@[lang(@"music control")],@[lang(@"notification control")],
                          @[lang(@"recovery control")],@[lang(@"reboot control")],@[lang(@"voice control")],
        @[lang(@"factory reset")]];
    }
    return _buttonTitles;
}

- (NSArray *)modelClasss
{
    if (!_modelClasss) {
        _modelClasss = @[[TakePictureViewModel class],[ControlMusicViewModel class],[ControlNotifyViewModel class],
                         [ControlRestoreViewModel class],[ControlRestartViewModel class],[ListenVoiceDataViewModel class],[ControlResetViewModel class]];
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
        BaseCellModel * model = [strongSelf.cellModels objectAtIndex:indexPath.row];
        if ([NSStringFromClass(model.modelClass)isEqualToString:@"NSNull"])return;
        FuncViewController * newFuncVc = [FuncViewController new];
        newFuncVc.model = [model.modelClass new];
        newFuncVc.title = [model.data firstObject];
        [funcVc.navigationController pushViewController:newFuncVc animated:YES];
    };
}

@end
