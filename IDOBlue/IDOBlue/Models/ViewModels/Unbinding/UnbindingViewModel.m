//
//  UnbindingViewModel.m
//  IDOBlue
//
//  Created by hedongyang on 2018/10/10.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "UnbindingViewModel.h"
#import "FuncCellModel.h"
#import "OneButtonTableViewCell.h"
#import "FuncViewController.h"
#import "ComLogViewModel.h"
#import "SwitchDeviceViewModel.h"
#import "RestartLogViewModel.h"
#import "ScanViewController.h"

@interface UnbindingViewModel()
@property (nonatomic,strong) NSArray * buttonTitles;
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation UnbindingViewModel
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
        _buttonTitles = @[@[lang(@"device unbind")],@[lang(@"mandatory unbind")],@[lang(@"device switch")]];
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
        __block FuncViewController * funcVc = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVc.tableView indexPathForCell:tableViewCell];
        if (indexPath.row == 0) {
            [funcVc showLoadingWithMessage:lang(@"device unbinding")];
            [IDOFoundationCommand mandatoryUnbindingCommand:^(int errorCode) {
                if (errorCode == 0) {
                    [funcVc showToastWithText:lang(@"unbind success")];
                    IDOGetDeviceInfoBluetoothModel * model = [IDOGetDeviceInfoBluetoothModel currentModel];
                    if (!model.bindState) {
                        ScanViewController * scanVC  = [[ScanViewController alloc]init];
                        UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:scanVC];
                        [UIApplication sharedApplication].delegate.window.rootViewController = nav;
                    }else {
                       //if the current device is in a bound state, an automatic scan connection is started without any additional action
                    }
                }else {
                    [funcVc showToastWithText:lang(@"unbind failed")];
                }
            }];
        }else if(indexPath.row == 1){
            [funcVc showLoadingWithMessage:lang(@"device unbinding")];
            [IDOFoundationCommand mandatoryUnbindingCommand:^(int errorCode) {
                if (errorCode == 0) {
                    [funcVc showToastWithText:lang(@"unbind success")];
                    IDOGetDeviceInfoBluetoothModel * model = [IDOGetDeviceInfoBluetoothModel currentModel];
                    if (!model.bindState) {
                        ScanViewController * scanVC  = [[ScanViewController alloc]init];
                        UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:scanVC];
                        [UIApplication sharedApplication].delegate.window.rootViewController = nav;
                    }else {
                       //if the current device is in a bound state, an automatic scan connection is started without any additional action
                    }
                }else {
                    [funcVc showToastWithText:lang(@"unbind failed")];
                }
            }];
        }else if (indexPath.row == 2) {
            FuncViewController * newFuncVc = [FuncViewController new];
            newFuncVc.model = [SwitchDeviceViewModel new];
            newFuncVc.title = lang(@"device switch");
            [funcVc.navigationController pushViewController:newFuncVc animated:YES];
        }
    };
}
@end
