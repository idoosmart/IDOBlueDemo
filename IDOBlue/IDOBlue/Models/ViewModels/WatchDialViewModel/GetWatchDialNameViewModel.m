//
//  GetWatchDialNameViewModel.m
//  IDOBlue
//
//  Created by huangkunhe on 2021/12/20.
//  Copyright © 2021 hedongyang. All rights reserved.
//

#import "GetWatchDialNameViewModel.h"
#import "FuncCellModel.h"
#import "TextViewCellModel.h"
#import "IDODemoUtility.h"
#import "NSObject+DemoToDic.h"
#import "OneButtonTableViewCell.h"
#import "OneTextViewTableViewCell.h"
#import "FuncViewController.h"

@interface GetWatchDialNameViewModel()
@property (nonatomic,strong) UITextView * textView;
@property (nonatomic,copy)void(^textViewCallback)(UITextView * textView);
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation GetWatchDialNameViewModel
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
        [funcVC showLoadingWithMessage:[NSString stringWithFormat:@"%@...",lang(@"get watch dial name")] ];
 
        initWatchDialManager().getCurrentDialInfo(^(NSString * _Nullable fileName, int errorCode) {
            if (errorCode == 0) {
               [funcVC showToastWithText:lang(@"get watch dial name success")];

               strongSelf.textView.text = [NSString stringWithFormat:@"%@",fileName];
           }else if (errorCode == 6) {
               [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
           }else {
               [funcVC showToastWithText:lang(@"get watch dial name failed")];
           }
        });
        
    };
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    FuncCellModel * model = [[FuncCellModel alloc]init];
    model.typeStr = @"oneButton";
    model.data = @[lang(@"get watch dial list info")];
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
    model2.data = @[@""];
    [cellModels addObject:model2];
    self.cellModels = cellModels;
}
@end
