//
//  GetOtaAuthInfoViewModel.m
//  IDOBlue
//
//  Created by 何东阳 on 2019/9/9.
//  Copyright © 2019 hedongyang. All rights reserved.
//

#import "GetOtaAuthInfoViewModel.h"
#import "FuncCellModel.h"
#import "TextViewCellModel.h"
#import "IDODemoUtility.h"
#import "NSObject+DemoToDic.h"
#import "OneButtonTableViewCell.h"
#import "OneTextViewTableViewCell.h"
#import "FuncViewController.h"


@interface GetOtaAuthInfoViewModel()
@property (nonatomic,strong) UITextView * textView;
@property (nonatomic,copy)void(^textViewCallback)(UITextView * textView);
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation GetOtaAuthInfoViewModel
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
        [funcVC showLoadingWithMessage:[NSString stringWithFormat:@"%@...",lang(@"get ota auth information")]];
        //0x00:校验成功,0x01:ID号校验失败,0x02:版本号校验失败,0x03:电量不足,0x04:其他错误
        //0x00: verification success,0x01:ID number verification failure,0x02: version number verification failure,0x03: insufficient power,0x04: other errors
        [IDOFoundationCommand getOtaAuthInfoCommand:^(int errorCode, int stateCode) {
            if (errorCode == 0) {
                [funcVC showToastWithText:lang(@"get ota auth info success")];
                if (stateCode == 0x00) {
                    strongSelf.textView.text = [NSString stringWithFormat:@"%@\n",lang(@"verification success")];
                }else if (stateCode == 0x01) {
                    strongSelf.textView.text = [NSString stringWithFormat:@"%@\n",lang(@"id number verification failure")];
                }else if (stateCode == 0x02) {
                    strongSelf.textView.text = [NSString stringWithFormat:@"%@\n",lang(@"version number verification failure")];
                }else if (stateCode == 0x03) {
                    strongSelf.textView.text = [NSString stringWithFormat:@"%@\n",lang(@"insufficient power")];
                }else if (stateCode == 0x04) {
                    strongSelf.textView.text = [NSString stringWithFormat:@"%@\n",lang(@"other errors")];
                }
            }else if (errorCode == 6) {
                [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
            }else {
                [funcVC showToastWithText:lang(@"get ota auth info failed") ];
            }
        }];
    };
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    FuncCellModel * model = [[FuncCellModel alloc]init];
    model.typeStr = @"oneButton";
    model.data = @[lang(@"get ota auth information")];
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
