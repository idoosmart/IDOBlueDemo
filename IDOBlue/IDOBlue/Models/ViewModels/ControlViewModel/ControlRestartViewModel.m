//
//  ControlRestartViewModel.m
//  IDOBlue
//
//  Created by apple on 2018/10/4.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "ControlRestartViewModel.h"
#import "FuncCellModel.h"
#import "OneButtonTableViewCell.h"
#import "FuncViewController.h"
#import "FuncViewModel.h"

@interface ControlRestartViewModel()
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end


@implementation ControlRestartViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getButtonCallback];
        [self getCellModels];
    }
    return self;
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    
    FuncCellModel * model1 = [[FuncCellModel alloc]init];
    model1.typeStr = @"oneButton";
    model1.data = @[lang(@"reboot device")];
    model1.cellHeight = 70.0f;
    model1.cellClass = [OneButtonTableViewCell class];
    model1.modelClass = [NSNull class];
    model1.isShowLine = YES;
    model1.buttconCallback = self.buttconCallback;
    [cellModels addObject:model1];
    
    self.cellModels = cellModels;
}

- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        FuncViewController * funcVC = (FuncViewController *)viewController;
        [funcVC showLoadingWithMessage:lang(@"reboot device...")];
        [IDOFoundationCommand setAppRebootCommand:^(int errorCode) {
            __strong typeof(self) strongSelf = weakSelf;
            if (errorCode == 0) {
                [funcVC showToastWithText:lang(@"successful restart of equipment")];
                [strongSelf setRootViewController];
            }else if (errorCode == 6) {
                [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
            }else {
                [funcVC showToastWithText:lang(@"failure to restart equipment")];
            }
        }];
    };
}

- (void)setRootViewController
{
    FuncViewController * funcVc = [[FuncViewController alloc]init];
    funcVc.model = [FuncViewModel new];
    funcVc.title = lang(@"function list");
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:funcVc];
    [UIApplication sharedApplication].delegate.window.rootViewController = nav;
}

@end
