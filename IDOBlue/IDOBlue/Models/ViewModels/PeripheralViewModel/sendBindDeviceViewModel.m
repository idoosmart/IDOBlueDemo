//
//  sendBindDeviceViewModel.m
//  IDOBlue
//
//  Created by huangkunhe on 2022/9/30.
//  Copyright © 2022 hedongyang. All rights reserved.
//

#import "sendBindDeviceViewModel.h"
#import "FileViewModel.h"
#import "NSObject+DemoToDic.h"
#import "FuncCellModel.h"
#import "EmpltyCellModel.h"
#import "TextFieldCellModel.h"
#import "TextViewCellModel.h"
#import "FuncViewController.h"
#import "EmptyTableViewCell.h"
#import "OneButtonTableViewCell.h"
#import "OneTextViewTableViewCell.h"
#import "OneTextFieldTableViewCell.h"

@interface sendBindDeviceViewModel()<IDOPeripheralsManagerDelegate>
@property (nonatomic,copy) IDOPeripheralsBindModel * bindModel;

@property (nonatomic,copy) NSString * logStr;
@property (nonatomic,strong) UITextView * textView;
@property (nonatomic,strong) NSString * filePath;
@property (nonatomic,copy)void(^textViewCallback)(UITextView * textView);
@property (nonatomic,copy)void(^labelSelectCallback)(UIViewController * viewController,NSString * titleStr);
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^textFeildCallback)(UIViewController * viewController,UITextField * textField,UITableViewCell * tableViewCell);
@property (nonatomic,strong) NSMutableArray <IDOMusicFileTransferModel *>* models;
@property (nonatomic,strong) UITextField * textField1;
@property (nonatomic,strong) UITextField * textField2;
@property (nonatomic,strong) UITextField * textField3;
@end

@implementation sendBindDeviceViewModel


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getTextFeildCallback];
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
-(IDOPeripheralsBindModel *)bindModel{
    if (!_bindModel) {
        IDOPeripheralsBindModel*bindModel = [IDOPeripheralsBindModel new];
        bindModel.version = 1;
        bindModel.deviceTableNum = 1;

        IDOPeripheralsBindItemModel*bindItem = [IDOPeripheralsBindItemModel new];
        bindItem.mac = @"ABCDEFDDCCEE";;
        bindItem.deviceModelId = @"1234567";
        bindModel.deviceTableItems = @[bindItem];
        
        _bindModel = bindModel;
    }
    return _bindModel;
}

- (NSMutableArray <IDOMusicFileTransferModel *>*)models
{
    if (!_models) {
         _models = [NSMutableArray new];
    }
    return _models;
}

- (void)getCellModels
{
  
    
    TextFieldCellModel * model2 = [[TextFieldCellModel alloc]init];
    model2.typeStr = @"oneTextField";
    model2.titleStr = lang(@"music name");
    model2.data = @[@""];
    model2.cellHeight = 70.0f;
    model2.cellClass = [OneTextFieldTableViewCell class];
    model2.modelClass = [NSNull class];
    model2.isShowLine = YES;
    model2.isShowKeyboard = YES;
    model2.textFeildCallback  = self.textFeildCallback;
    
    TextFieldCellModel * model3 = [[TextFieldCellModel alloc]init];
    model3.typeStr = @"oneTextField";
    model3.titleStr = lang(@"singer name");
    model3.data = @[@""];
    model3.cellHeight = 70.0f;
    model3.cellClass = [OneTextFieldTableViewCell class];
    model3.modelClass = [NSNull class];
    model3.isShowLine = YES;
    model3.isShowKeyboard = YES;
    model3.textFeildCallback  = self.textFeildCallback;
    
    TextFieldCellModel * model4 = [[TextFieldCellModel alloc]init];
    model4.typeStr = @"oneTextField";
    model4.titleStr = lang(@"music id");
    model4.data = @[@(0)];
    model4.cellHeight = 70.0f;
    model4.cellClass = [OneTextFieldTableViewCell class];
    model4.modelClass = [NSNull class];
    model4.isShowLine = YES;
    model4.isShowKeyboard = YES;
    model4.keyType = UIKeyboardTypeNumberPad;
    model4.textFeildCallback  = self.textFeildCallback;
    
    TextViewCellModel * model5 = [[TextViewCellModel alloc]init];
    model5.typeStr = @"oneTextView";
    model5.data    = @[self.logStr ?: @""];
    model5.textViewCallback = self.textViewCallback;
    model5.cellHeight = [UIScreen mainScreen].bounds.size.height / 2 - 20;
    model5.cellClass  = [OneTextViewTableViewCell class];
    
    FuncCellModel * model1 = [[FuncCellModel alloc]init];
    model1.typeStr = @"oneButton";
    model1.data    = @[lang(@"start transfer music file")];
    model1.cellHeight = 70.0f;
    model1.index = 0;
    model1.buttconCallback = self.buttconCallback;
    model1.cellClass  = [OneButtonTableViewCell class];
    
    self.cellModels = @[model2,model3,model4,model1,model5];
}


- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        if (!IDO_BLUE_ENGINE.managerEngine.isConnected)return ;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath =  [funcVC.tableView indexPathForCell:tableViewCell];
        BaseCellModel * model = [strongSelf.cellModels objectAtIndex:indexPath.row];
        if (model.index == 0) {
            [IDOMusicFileManager shareInstance].models = strongSelf.models;
            if ([[IDOMusicFileManager shareInstance] startTransfer]) {
                [funcVC showLoadingWithMessage:[NSString stringWithFormat:@"%@...",lang(@"transfer music file")]];
            }else {
                [funcVC showToastWithText:lang(@"transfer music file failed")];
            }
        }else {
            [[IDOMusicFileManager shareInstance] stopTransfer];
        }
        
    };
}

- (void)getTextFeildCallback {
    __weak typeof(self) weakSelf = self;
    self.textFeildCallback = ^(UIViewController *viewController, UITextField *textField, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        if (indexPath.row == 0) {
            strongSelf.textField1 = textField;
        }else if (indexPath.row == 1) {
            strongSelf.textField2 = textField;
        }else if (indexPath.row == 2) {
            strongSelf.textField3 = textField;
        }
        TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
        textFieldModel.data = @[textField.text];
    };
}


- (void)getTextViewCallback
{
    __weak typeof(self) weakSelf = self;
    self.textViewCallback = ^(UITextView *textView) {
        __strong typeof(self) strongSelf = weakSelf;
        strongSelf.textView = textView;
    };
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


