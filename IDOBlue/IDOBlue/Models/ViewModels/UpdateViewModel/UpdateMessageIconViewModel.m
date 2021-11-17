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
    
    TextFieldCellModel * model2 = [[TextFieldCellModel alloc]init];
    model2.typeStr = @"oneTextField";
    model2.titleStr = @"输入包名:";
    model2.placeholders = @[@"com.tencent.xin"];
    model2.data    = @[@""];
    model2.isShowLine = YES;
    model2.isShowKeyboard = YES;
    model2.textFeildCallback = self.textFeildCallback;
    model2.cellHeight = 70.0f;
    model2.cellClass  = [OneTextFieldTableViewCell class];
    
    FuncCellModel * model3 = [[FuncCellModel alloc]init];
    model3.typeStr = @"oneButton";
    model3.data = @[@"添加包名"];
    model3.cellHeight = 70.0f;
    model3.cellClass = [OneButtonTableViewCell class];
    model3.modelClass = [NSNull class];
    model3.isShowLine = YES;
    model3.buttconCallback = self.buttconCallback;
    
    FuncCellModel * model5 = [[FuncCellModel alloc]init];
    model5.typeStr = @"oneButton";
    model5.data = @[@"删除包名"];
    model5.cellHeight = 70.0f;
    model5.cellClass = [OneButtonTableViewCell class];
    model5.modelClass = [NSNull class];
    model5.isShowLine = YES;
    model5.buttconCallback = self.buttconCallback;
    
    FuncCellModel * model4 = [[FuncCellModel alloc]init];
    model4.typeStr = @"oneButton";
    model4.data = @[@"清除日志显示"];
    model4.cellHeight = 70.0f;
    model4.cellClass = [OneButtonTableViewCell class];
    model4.modelClass = [NSNull class];
    model4.isShowLine = YES;
    model4.buttconCallback = self.buttconCallback;
    
    FuncCellModel * model6 = [[FuncCellModel alloc]init];
    model6.typeStr = @"oneButton";
    model6.data = @[@"获取固件包名"];
    model6.cellHeight = 70.0f;
    model6.cellClass = [OneButtonTableViewCell class];
    model6.modelClass = [NSNull class];
    model6.isShowLine = YES;
    model6.buttconCallback = self.buttconCallback;
    
    self.cellModels = @[model2,model3,model5,model4,model6,model1];
}

- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        if (indexPath.row == 1) {
            if (strongSelf.textField.text.length == 0) {
                [funcVC showToastWithText:@"请输入包名"];
                return;
            }
            NSMutableArray * items = [NSMutableArray arrayWithArray:strongSelf.appPackNameModel.items];
            IDOGetAppPackNameListItemModel * item = [[IDOGetAppPackNameListItemModel alloc]init];
            item.packName = strongSelf.textField.text;
            [items addObject:item];
            strongSelf.appPackNameModel.items = [items copy];
            [strongSelf getItemsjsonStr];
            [strongSelf getCellModels];
            [funcVC.tableView reloadData];
        }else if (indexPath.row == 2) {
            NSMutableArray * items = [NSMutableArray arrayWithArray:strongSelf.appPackNameModel.items];
            if (items.count == 0) {
                return;
            }
            [items removeLastObject];
            strongSelf.appPackNameModel.items = [items copy];
            [strongSelf getItemsjsonStr];
            [strongSelf getCellModels];
            [funcVC.tableView reloadData];
        }else if (indexPath.row == 3) {
            strongSelf.textView.text = @"";
        }else if (indexPath.row == 4) {
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
