//
//  OneTextFieldTableViewCell.m
//  SDKDemo
//
//  Created by hedongyang on 2018/6/14.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "OneTextFieldTableViewCell.h"
#import "TextFieldCellModel.h"
#import "IDODemoUtility.h"
#import "FuncViewController.h"

@interface OneTextFieldTableViewCell()<UITextFieldDelegate>
@property (nonatomic,strong) TextFieldCellModel * textFieldCellModel;
@end

@implementation OneTextFieldTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.title = [[UILabel alloc]init];
        self.title.textColor = [UIColor blackColor];
        self.title.textAlignment = NSTextAlignmentLeft;
        self.title.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.title];
        
        self.textField = [[UITextField alloc]init];
        self.textField.borderStyle = UITextBorderStyleRoundedRect;
        self.textField.textColor = [UIColor blackColor];
        self.textField.textAlignment = NSTextAlignmentCenter;
        self.textField.delegate = self;
        self.textField.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.textField];
        __weak typeof(self) weakSelf = self;
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong typeof(self) strongSelf = weakSelf;
            make.left.equalTo(@16);
            make.centerY.equalTo(strongSelf.mas_centerY);
            make.width.lessThanOrEqualTo(@200);
        }];
        
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong typeof(self) strongSelf = weakSelf;
            make.centerY.equalTo(strongSelf.mas_centerY);
            make.left.equalTo(strongSelf.title.mas_right).offset(10);
            make.right.equalTo(@(-16));
        }];
        
        [self.textField setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
        [self.title setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    }
    return self;
}

- (void)setCellModel:(BaseCellModel *)model
{
    self.textFieldCellModel = (TextFieldCellModel *)model;
    self.title.text     = self.textFieldCellModel.titleStr;
    self.textField.placeholder = [self.textFieldCellModel.placeholders firstObject];
    if (self.textFieldCellModel.isShowKeyboard) {
        self.textField.keyboardType = self.textFieldCellModel.keyType;
    }
    if ([self.textFieldCellModel.data[0]isKindOfClass:[NSString class]]) {
        self.textField.text = self.textFieldCellModel.data[0];
    }else {
         self.textField.text = [NSString stringWithFormat:@"%ld",(long)[self.textFieldCellModel.data[0] integerValue]];
    }
}

#pragma mark - ****************** UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (self.textFieldCellModel.isShowKeyboard) {
        [self tableViewContentInset];
        return YES;
    }else {
        if (self.textFieldCellModel.textFeildCallback) {
            self.textFieldCellModel.textFeildCallback([IDODemoUtility getCurrentVC],textField,self);
            [self tableViewContentInset];
        }
        return NO;
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    FuncViewController * funcVC = (FuncViewController *)[IDODemoUtility getCurrentVC];
     [funcVC.tableView setContentInset:UIEdgeInsetsZero];
    return self.textFieldCellModel.isShowKeyboard;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (self.textFieldCellModel.textFeildCallback) {
        self.textFieldCellModel.textFeildCallback([IDODemoUtility getCurrentVC],textField,self);
    }
     return self.textFieldCellModel.isShowKeyboard;
}

- (void)tableViewContentInset
{
    FuncViewController * funcVC = (FuncViewController *)[IDODemoUtility getCurrentVC];
    NSIndexPath * currentIndexPath = [funcVC.tableView indexPathForCell:self];
    CGRect rectInTableView = [funcVC.tableView rectForRowAtIndexPath:currentIndexPath];
    CGRect rect = [funcVC.tableView convertRect:rectInTableView toView:funcVC.view];
    CGFloat differ = 0.0f;
    if (rect.origin.y + rect.size.height > rectInTableView.origin.y + rectInTableView.size.height) {
        differ = rect.origin.y + rect.size.height;
    }else {
        differ = rectInTableView.origin.y + rectInTableView.size.height;
    }
    CGFloat keyMinY = funcVC.view.frame.size.height - (self.textFieldCellModel.isShowKeyboard ? 240 : 216);
    if (differ > keyMinY) {
        [funcVC.tableView setContentInset:UIEdgeInsetsMake(-(differ - keyMinY), 0, 0, 0)];
    }
}


@end
