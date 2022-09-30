//
//  sendBindDeviceViewModel.m
//  IDOBlue
//
//  Created by huangkunhe on 2022/9/30.
//  Copyright © 2022 hedongyang. All rights reserved.
//

#import "sendBindDeviceViewModel.h"
#import "FuncCellModel.h"
#import "TextViewCellModel.h"
#import "IDODemoUtility.h"
#import "NSObject+DemoToDic.h"
#import "OneButtonTableViewCell.h"
#import "OneTextViewTableViewCell.h"
#import "FuncViewController.h"


@interface sendBindDeviceViewModel()<IDOPeripheralsManagerDelegate>
@property (nonatomic,strong) UITextView * textView;
@property (nonatomic,copy)void(^textViewCallback)(UITextView * textView);
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation sendBindDeviceViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getButtonCallback];
        [self getTextViewCallback];
        [self getCellModels];
        [self initDelegate];
    }
    return self;
}

-(void)initDelegate
{
    [IDOPeripheralsManager shareInstance].delegate = self;
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
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        FuncViewController * funcVC = (FuncViewController *)viewController;
        [funcVC showLoadingWithMessage:[NSString stringWithFormat:@"%@...",funcVC.title]];
        
        //绑定设备
        IDOPeripheralsBindModel*bindModel = [IDOPeripheralsBindModel new];
        bindModel.version = 1;
        bindModel.deviceTableNum = 1;

        IDOPeripheralsBindItemModel*bindItem = [IDOPeripheralsBindItemModel new];
        bindItem.mac = @"ABCDEFDDCCEE";;
        bindItem.deviceModelId = @"1234567";
        bindModel.deviceTableItems = @[bindItem];

        [IDOPeripheralsManager sendBindDeviceInfoData:bindModel];
    };
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    FuncCellModel * model = [[FuncCellModel alloc]init];
    model.typeStr = @"oneButton";
    model.data = @[lang(@"send bind Info To Device")];
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

//信息回调数据
-(void)operatePeripheralsCompleteWithErrorCode:(int)errorCode operateType:(int)operateType{
    NSLog(@"errorCode------->%d  operateType:%ld",errorCode,operateType);
    FuncViewController * funcVC = (FuncViewController *)[IDODemoUtility getCurrentVC];
    
    if (errorCode == 0) {
        [funcVC showToastWithText:lang(@"Data sent successfully")];
        self.textView.text = [NSString stringWithFormat:@"errorCode = %d",errorCode];
    }else if (errorCode == 6) {
        [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
    }else {
        [funcVC showToastWithText:lang(@"Data sending failed")];
    }
}


@end

