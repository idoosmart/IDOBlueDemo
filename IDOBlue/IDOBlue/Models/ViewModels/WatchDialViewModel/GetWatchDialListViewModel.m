//
//  GetWatchDialListViewModel.m
//  IDOBlue
//
//  Created by 何东阳 on 2019/8/28.
//  Copyright © 2019 hedongyang. All rights reserved.
//

#import "GetWatchDialListViewModel.h"
#import "FuncCellModel.h"
#import "TextViewCellModel.h"
#import "IDODemoUtility.h"
#import "NSObject+DemoToDic.h"
#import "OneButtonTableViewCell.h"
#import "OneTextViewTableViewCell.h"
#import "FuncViewController.h"

@interface GetWatchDialListViewModel()
@property (nonatomic,strong) UITextView * textView;
@property (nonatomic,copy)void(^textViewCallback)(UITextView * textView);
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation GetWatchDialListViewModel
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
        [funcVC showLoadingWithMessage:[NSString stringWithFormat:@"%@...",lang(@"get watch dial list info")] ];
        if (__IDO_FUNCTABLE__.funcTable35Model.getNewWatchList) {
            initWatchDialManager().getV3WatchListInfo(^(IDOV3WatchDialInfoModel * _Nullable model, int errorCode) {
                if (errorCode == 0) {
                   [funcVC showToastWithText:lang(@"get watch dial list info success")];
                   NSDictionary * dic = model.dicFromObject;
                   NSMutableArray * array = [NSMutableArray array];
                   for (IDOWatchDialInfoItemModel * itemModel in model.dialArray) {
                       NSDictionary * dic = itemModel.dicFromObject;
                       [array addObject:dic];
                   }
                   strongSelf.textView.text = [NSString stringWithFormat:@"%@\n%@",dic,array];
               }else if (errorCode == 6) {
                   [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
               }else {
                   [funcVC showToastWithText:lang(@"get watch dial list info failed")];
               }
            });
        }else {
            initWatchDialManager().getDialListInfo(^(IDOWatchDialInfoModel * _Nullable model, int errorCode) {
                if (errorCode == 0) {
                   [funcVC showToastWithText:lang(@"get watch dial list info success")];
                   NSDictionary * dic = model.dicFromObject;
                   NSMutableArray * array = [NSMutableArray array];
                   for (IDOWatchDialInfoItemModel * itemModel in model.dialArray) {
                       NSDictionary * dic = itemModel.dicFromObject;
                       [array addObject:dic];
                   }
                   strongSelf.textView.text = [NSString stringWithFormat:@"%@\n%@",dic,array];
               }else if (errorCode == 6) {
                   [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
               }else {
                   [funcVC showToastWithText:lang(@"get watch dial list info failed")];
               }
            });
        }
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
