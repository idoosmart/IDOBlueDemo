//
//  GetDeviceViewModel.m
//  IDOBlue
//
//  Created by apple on 2018/10/3.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "GetDeviceViewModel.h"
#import "FuncCellModel.h"
#import "OneButtonTableViewCell.h"
#import "TextViewCellModel.h"
#import "OneTextViewTableViewCell.h"
#import "IDODemoUtility.h"
#import "FuncViewController.h"
#import "NSObject+DemoToDic.h"

@interface GetDeviceViewModel()
@property (nonatomic,strong) UITextView * textView;
@property (nonatomic,copy)void(^textViewCallback)(UITextView * textView);
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation GetDeviceViewModel
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
        [funcVC showLoadingWithMessage:[NSString stringWithFormat:@"%@...",lang(@"get device information")]];
        [IDOFoundationCommand getDeviceInfoCommand:^(int errorCode, IDOGetDeviceInfoBluetoothModel * _Nullable data) {
            if (errorCode == 0) {
                [funcVC showToastWithText:lang(@"get device information success")];
                NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:data.dicFromObject];
                [dic setValue:data.deviceId?:@"" forKey:@"deviceId"];
                [dic setValue:data.version?:@"" forKey:@"version"];
                strongSelf.textView.text = [NSString stringWithFormat:@"%@",dic];
            }else if (errorCode == 6) {
                [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
            }else {
                [funcVC showToastWithText:lang(@"get device information failed")];
            }
        }];
    };
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    FuncCellModel * model = [[FuncCellModel alloc]init];
    model.typeStr = @"oneButton";
    model.data = @[lang(@"get device information")];
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
    IDOGetDeviceInfoBluetoothModel * deviceModel = [IDOGetDeviceInfoBluetoothModel currentModel];
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:deviceModel.dicFromObject];
    [dic setValue:deviceModel.deviceId?:@"" forKey:@"deviceId"];
    [dic setValue:deviceModel.version?:@"" forKey:@"version"];
    NSString * str = [NSString stringWithFormat:@"%@",dic];
    model2.data = @[str?:@""];
    [cellModels addObject:model2];
    
    self.cellModels = cellModels;
}
@end
