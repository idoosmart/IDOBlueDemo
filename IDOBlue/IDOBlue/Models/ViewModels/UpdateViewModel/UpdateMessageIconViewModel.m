//
//  UpdateMessageIconViewModel.m
//  IDOBlue
//
//  Created by hedongyang on 2021/8/18.
//  Copyright © 2021 hedongyang. All rights reserved.
//

#import "UpdateMessageIconViewModel.h"
#import "FuncViewController.h"
#import "FuncCellModel.h"
#import "OneButtonTableViewCell.h"
#import "TextFieldCellModel.h"
#import "OneTextFieldTableViewCell.h"
#import "TextViewCellModel.h"
#import "OneTextViewTableViewCell.h"
#import "NSObject+DemoToDic.h"

@interface UpdateMessageIconViewModel ()<IDOMessageIconManagerDelegate>
@property (nonatomic,copy) NSString * logStr;
@property (nonatomic,strong) UITextView * textView;
@property (nonatomic,strong) UITextField * textField;
@property (nonatomic,strong) IDOGetAppPackNameModel * appPackNameModel;
@property (nonatomic,copy)void(^textViewCallback)(UITextView * textView);
@property (nonatomic,copy)void(^textFeildCallback)(UIViewController * viewController,UITextField * textField,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);

@end

@implementation UpdateMessageIconViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.logStr = @"";
        [self getItemsjsonStr];
        [self getTextViewCallback];
        [self getTextFieldCallback];
        [self getButtonCallback];
        [self getCellModels];
        [IDOMessageIconManager listenForUpdate].delegate = self;
    }
    return self;
}

- (void)handleIconLogMessage:(NSString *)message
{
    self.logStr = [NSString stringWithFormat:@"%@\n\n%@",self.textView.text,message];
    TextViewCellModel * model = [self.cellModels lastObject];
    model.data = @[self.logStr?:@""];
    self.textView.text = self.logStr;
    [self.textView scrollRangeToVisible:NSMakeRange(self.textView.text.length,1)];
}

- (void)handleIconAndNameComplete
{
    self.logStr = [NSString stringWithFormat:@"%@\n\n%@",self.textView.text,@"get package name complete."];
    TextViewCellModel * model = [self.cellModels lastObject];
    model.data = @[self.logStr?:@""];
    self.textView.text = self.logStr;
    [self.textView scrollRangeToVisible:NSMakeRange(self.textView.text.length,1)];
}

- (IDOGetAppPackNameModel *)appPackNameModel
{
    if (!_appPackNameModel) {
         _appPackNameModel = [IDOGetAppPackNameModel currentModel];
    }
    return _appPackNameModel;
}

- (void)getItemsjsonStr
{
    self.logStr = @"";
    for (IDOGetAppPackNameListItemModel * item in self.appPackNameModel.items) {
        NSDictionary * dic = item.dicFromObject;
        self.logStr = [NSString stringWithFormat:@"%@\n%@",self.logStr,dic];
    }
}

- (void)getCellModels
{
    TextViewCellModel * model1 = [[TextViewCellModel alloc]init];
    model1.typeStr = @"oneTextView";
    model1.data    = @[self.logStr];
    model1.textViewCallback = self.textViewCallback;
    model1.cellHeight = [UIScreen mainScreen].bounds.size.height / 2 - 20;
    model1.cellClass  = [OneTextViewTableViewCell class];
        
    FuncCellModel * model4 = [[FuncCellModel alloc]init];
    model4.typeStr = @"oneButton";
    model4.data = @[lang(@"clear log display")];
    model4.cellHeight = 70.0f;
    model4.cellClass = [OneButtonTableViewCell class];
    model4.modelClass = [NSNull class];
    model4.isShowLine = YES;
    model4.buttconCallback = self.buttconCallback;
    
    FuncCellModel * model6 = [[FuncCellModel alloc]init];
    model6.typeStr = @"oneButton";
    model6.data = @[lang(@"get firmware package name")];
    model6.cellHeight = 70.0f;
    model6.cellClass = [OneButtonTableViewCell class];
    model6.modelClass = [NSNull class];
    model6.isShowLine = YES;
    model6.buttconCallback = self.buttconCallback;
    
    self.cellModels = @[model4,model6,model1];
}

- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        if (indexPath.row == 0) {
            strongSelf.textView.text = @"";
            [funcVC showToastWithText:lang(@"log complete clearing")];
        }else if (indexPath.row == 1) {
            if (!__IDO_FUNCTABLE__.funcTable38Model.setNotifyAddAppName) {
                [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
                return;
            }
            [[IDOMessageIconManager listenForUpdate] getAppIconAndName];
        }
    };
}

- (void)getTextFieldCallback
{
    __weak typeof(self) weakSelf = self;
    self.textFeildCallback = ^(UIViewController *viewController, UITextField *textField, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        strongSelf.textField = textField;
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

@end
