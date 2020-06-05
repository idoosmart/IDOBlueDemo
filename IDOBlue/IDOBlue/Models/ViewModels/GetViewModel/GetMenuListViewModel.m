//
//  GetMenuListViewModel.m
//  IDOBlue
//
//  Created by hedongyang on 2020/4/17.
//  Copyright © 2020 hedongyang. All rights reserved.
//

#import "GetMenuListViewModel.h"
#import "FuncCellModel.h"
#import "OneButtonTableViewCell.h"
#import "TextViewCellModel.h"
#import "OneTextViewTableViewCell.h"
#import "IDODemoUtility.h"
#import "FuncViewController.h"
#import "NSObject+DemoToDic.h"

@interface GetMenuListViewModel()
@property (nonatomic,strong) UITextView * textView;
@property (nonatomic,copy)void(^textViewCallback)(UITextView * textView);
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation GetMenuListViewModel
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
        [funcVC showLoadingWithMessage:[NSString stringWithFormat:@"%@...",lang(@"get menu list")]];
        [IDOFoundationCommand getMenuListInfoCommand:^(int errorCode, IDOGetMenuListInfoBluetoothModel * _Nullable data) {
            if (errorCode == 0) {
               [funcVC showToastWithText:lang(@"get menu list success")];
               strongSelf.textView.text = [NSString stringWithFormat:@"%@",data.dicFromObject];
            }else if (errorCode == 6) {
               [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
            }else {
               [funcVC showToastWithText:lang(@"get menu list failed")];
            }
        }];
    };
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    FuncCellModel * model = [[FuncCellModel alloc]init];
    model.typeStr = @"oneButton";
    model.data = @[lang(@"get menu list")];
    model.cellHeight = 70.0f;
    model.cellClass = [OneButtonTableViewCell class];
    model.modelClass = [NSNull class];
    model.isShowLine = YES;
    model.buttconCallback = self.buttconCallback;
    [cellModels addObject:model];
    
    TextViewCellModel * model2 = [[TextViewCellModel alloc]init];
    model2.typeStr = @"oneTextView";
    model2.cellHeight = [IDODemoUtility getCurrentVC].view.bounds.size.height-110;
    model2.cellClass  = [OneTextViewTableViewCell class];
    model2.textViewCallback = self.textViewCallback;
    IDOGetMenuListInfoBluetoothModel * menuListModel = [IDOGetMenuListInfoBluetoothModel currentModel];
    NSString * str = [NSString stringWithFormat:@"%@",menuListModel.dicFromObject?:@""];
    model2.data = @[str];
    [cellModels addObject:model2];
    
    self.cellModels = cellModels;
}

@end

