//
//  ControlNotifyViewModel.m
//  IDOBlue
//
//  Created by apple on 2018/10/4.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "ControlNotifyViewModel.h"
#import "FuncCellModel.h"
#import "OneButtonTableViewCell.h"
#import "FuncViewController.h"

@interface ControlNotifyViewModel()
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation ControlNotifyViewModel
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
    model1.data = @[lang(@"open ANCS notification")];
    model1.cellHeight = 70.0f;
    model1.cellClass = [OneButtonTableViewCell class];
    model1.modelClass = [NSNull class];
    model1.isShowLine = YES;
    model1.buttconCallback = self.buttconCallback;
    [cellModels addObject:model1];
    
    FuncCellModel * model2 = [[FuncCellModel alloc]init];
    model2.typeStr = @"oneButton";
    model2.data = @[lang(@"close ANCS notification")];
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
        if (indexPath.row == 0) {
          [funcVC showLoadingWithMessage:lang(@"open ANCS notification...")];
          [IDOFoundationCommand belOpenAncsCommand:^(int errorCode) {
              if (errorCode == 0) {
                  [funcVC showToastWithText:lang(@"open ANCS notification success")];
              }else if (errorCode == 6) {
                  [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
              }else {
                  [funcVC showToastWithText:lang(@"oepn ANCS notification failed")];
              }
          }];
        }else {
            [funcVC showLoadingWithMessage:lang(@"close ANCS notification...")];
            [IDOFoundationCommand belCloseAncsCommand:^(int errorCode) {
                if (errorCode == 0) {
                    [funcVC showToastWithText:lang(@"close ANCS notification success")];
                }else if (errorCode == 6) {
                    [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
                }else {
                    [funcVC showToastWithText:lang(@"close ANCS notification failed")];
                }
            }];
        }
    };
}
@end
