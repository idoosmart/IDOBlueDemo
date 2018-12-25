//
//  ControlMusicViewModel.m
//  IDOBlue
//
//  Created by apple on 2018/10/4.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "ControlMusicViewModel.h"
#import "FuncCellModel.h"
#import "OneButtonTableViewCell.h"
#import "FuncViewController.h"

@interface ControlMusicViewModel()
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation ControlMusicViewModel
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
    model1.data = @[@"设置音乐开启"];
    model1.cellHeight = 70.0f;
    model1.cellClass = [OneButtonTableViewCell class];
    model1.modelClass = [NSNull class];
    model1.isShowLine = YES;
    model1.buttconCallback = self.buttconCallback;
    [cellModels addObject:model1];
    
    FuncCellModel * model2 = [[FuncCellModel alloc]init];
    model2.typeStr = @"oneButton";
    model2.data = @[@"设置音乐结束"];
    model2.cellHeight = 70.0f;
    model2.cellClass = [OneButtonTableViewCell class];
    model2.modelClass = [NSNull class];
    model2.isShowLine = YES;
    model2.buttconCallback = self.buttconCallback;
    [cellModels addObject:model2];
    
    self.cellModels = cellModels;
}

- (void)getButtonCallback
{
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        [funcVC showLoadingWithMessage:@"设置音乐开启..."];
        if (indexPath.row == 0) {
            [IDOFoundationCommand musicStartCommand:^(int errorCode) {
                if (errorCode == 0) {
                    [funcVC showToastWithText:@"设置音乐开启成功"];
                }else {
                    [funcVC showToastWithText:@"设置音乐开启失败"];
                }
            }];
        }else {
            [IDOFoundationCommand musicStopCommand:^(int errorCode) {
                if (errorCode == 0) {
                    [funcVC showToastWithText:@"设置音乐结束成功"];
                }else {
                    [funcVC showToastWithText:@"设置音乐结束失败"];
                }
            }];
        }
    };
}
@end
