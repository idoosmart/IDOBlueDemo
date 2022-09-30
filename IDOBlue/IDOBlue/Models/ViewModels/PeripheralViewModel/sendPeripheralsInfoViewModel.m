//
//  sendPeripheralsInfoViewModel.m
//  IDOBlue
//
//  Created by huangkunhe on 2022/9/30.
//  Copyright © 2022 hedongyang. All rights reserved.
//

#import "sendPeripheralsInfoViewModel.h"
#import "FuncCellModel.h"
#import "TextViewCellModel.h"
#import "IDODemoUtility.h"
#import "NSObject+DemoToDic.h"
#import "OneButtonTableViewCell.h"
#import "OneTextViewTableViewCell.h"
#import "FuncViewController.h"


@interface sendPeripheralsInfoViewModel()<IDOPeripheralsManagerDelegate>
@property (nonatomic,strong) UITextView * textView;
@property (nonatomic,copy)void(^textViewCallback)(UITextView * textView);
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation sendPeripheralsInfoViewModel

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
        
        //发送设备信息
        IDOPeripheralsSetDataModel*setmodel = [IDOPeripheralsSetDataModel new];
        IDOPeripheralsSetHeadModel* headmodel = [IDOPeripheralsSetHeadModel new];
        headmodel.cardInfoNum = 1;
        setmodel.headmodel = headmodel;

        IDOPeripheralsUserModel* userModel = [IDOPeripheralsUserModel new];
        userModel.gender = 1;
        userModel.height = 170;
        userModel.weight = 50;
        userModel.personType = 0;
        userModel.weightUnit = 1;
        userModel.heightUnit = 0;
        setmodel.userModel = userModel;

        IDOPeripheralsDeviceDataModel*deviceModel = [IDOPeripheralsDeviceDataModel new];
        deviceModel.timeStamp = 1664357914;
        deviceModel.dataUnit = 1;
        deviceModel.dataScale = 1;
        deviceModel.dataType = 0;
        deviceModel.deviceType = 1;
        deviceModel.mac = @"ABCD00000000";
        setmodel.deviceInfoItems = @[deviceModel];
        
        [IDOPeripheralsManager sendPeripheralsInfoData:setmodel];
    };
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    FuncCellModel * model = [[FuncCellModel alloc]init];
    model.typeStr = @"oneButton";
    model.data = @[lang(@"send Peripherals Info To Device")];
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
