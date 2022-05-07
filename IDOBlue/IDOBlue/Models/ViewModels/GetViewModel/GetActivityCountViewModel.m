//
//  GetActivityCountViewModel.m
//  IDOBlue
//
//  Created by apple on 2018/10/3.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "GetActivityViewModel.h"
#import "FuncCellModel.h"
#import "OneButtonTableViewCell.h"
#import "TextViewCellModel.h"
#import "OneTextViewTableViewCell.h"
#import "IDODemoUtility.h"
#import "FuncViewController.h"
#import "NSObject+DemoToDic.h"

@interface GetActivityViewModel()
@property (nonatomic,strong) UITextView * textView;
@property (nonatomic,copy)void(^textViewCallback)(UITextView * textView);
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation GetActivityViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getButtonCallback];
        [self getTextViewCallback];
        [self getCellModels];
    }
    return self;
}

- (void)getTextViewCallback
{
    __weak typeof(self) weakSelf = self;
    self.textViewCallback = ^(UITextView *textView) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)[IDODemoUtility getCurrentVC];
        funcVC.tableView.scrollEnabled = NO;
        strongSelf.textView = textView;
    };
}

- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        funcVC.progressHUD.color = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.3];
        [funcVC showLoadingWithMessage:@"获取活动数量..."];
        [IDOFoundationCommand getActivityCountCommand:^(int errorCode, IDOGetActivityCountBluetoothModel * _Nullable data) {
            if (errorCode == 0) {
                [funcVC showToastWithText:@"获取活动数量成功"];
                strongSelf.textView.text = [NSString stringWithFormat:@"%@",data.dicFromObject];
            }else {
                [funcVC showToastWithText:@"获取活动数量失败"];
            }
        }];
    };
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    FuncCellModel * model = [[FuncCellModel alloc]init];
    model.typeStr = @"oneButton";
    model.data = @[@"获取活动数量"];
    model.cellHeight = 70.0f;
    model.CellClass = [OneButtonTableViewCell class];
    model.modelClass = [NSNull class];
    model.isShowLine = YES;
    model.buttconCallback = self.buttconCallback;
    [cellModels addObject:model];
    
    TextViewCellModel * model2 = [[TextViewCellModel alloc]init];
    model2.typeStr = @"oneTextView";
    model2.cellHeight = [IDODemoUtility getCurrentVC].view.bounds.size.height-110;
    model2.CellClass  = [OneTextViewTableViewCell class];
    model2.textViewCallback = self.textViewCallback;
    IDOGetActivityCountBluetoothModel * activityModel = [IDOGetActivityCountBluetoothModel currentModel];
    NSString * str = [NSString stringWithFormat:@"%@",activityModel.dicFromObject];
    model2.data = @[str?:@""];
    [cellModels addObject:model2];
    
    self.cellModels = cellModels;
}
@end
