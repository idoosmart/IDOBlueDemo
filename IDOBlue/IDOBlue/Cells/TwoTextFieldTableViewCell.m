//
//  TwoTextFieldTableViewCell.m
//  SDKDemo
//
//  Created by hedongyang on 2018/6/14.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "TwoTextFieldTableViewCell.h"
#import "Masonry.h"
#import "IDODemoUtility.h"
#import "FuncViewController.h"
#import "TextFieldCellModel.h"

@interface TwoTextFieldTableViewCell()<UITextFieldDelegate>
@property (nonatomic,strong) TextFieldCellModel * textFieldCellModel;
@end


@implementation TwoTextFieldTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.title = [[UILabel alloc]init];
        self.title.textColor = [UIColor blackColor];
        self.title.textAlignment = NSTextAlignmentLeft;
        self.title.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.title];
        __weak typeof(self) weakSelf = self;
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong typeof(self) strongSelf = weakSelf;
            make.left.equalTo(@16);
            make.centerY.equalTo(strongSelf.mas_centerY);
            make.width.lessThanOrEqualTo(@100);
        }];
        
        self.textField1 = [[UITextField alloc]init];
        self.textField1.borderStyle = UITextBorderStyleRoundedRect;
        self.textField1.textColor = [UIColor blackColor];
        self.textField1.delegate = self;
        self.textField1.textAlignment = NSTextAlignmentCenter;
        self.textField1.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.textField1];
        [self.textField1 mas_makeConstraints:^(MASConstraintMaker *make) {
             __strong typeof(self) strongSelf = weakSelf;
            make.centerY.equalTo(strongSelf.mas_centerY);
            make.left.equalTo(strongSelf.title.mas_right).offset(10);
        }];
        
        self.textField2 = [[UITextField alloc]init];
        self.textField2.borderStyle = UITextBorderStyleRoundedRect;
        self.textField2.textColor = [UIColor blackColor];
        self.textField2.delegate = self;
        self.textField2.textAlignment = NSTextAlignmentCenter;
        self.textField2.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.textField2];
        [self.textField2 mas_makeConstraints:^(MASConstraintMaker *make) {
             __strong typeof(self) strongSelf = weakSelf;
            make.centerY.equalTo(strongSelf.mas_centerY);
            make.left.equalTo(strongSelf.textField1.mas_right).offset(10);
            make.right.equalTo(@(-16));
            make.width.equalTo(strongSelf.textField1.mas_width);
        }];
        
        [self.title setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [self.textField1 setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
        [self.textField2 setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    }
    return self;
}

- (void)setCellModel:(BaseCellModel *)model
{
    self.textFieldCellModel = (TextFieldCellModel *)model;
    self.title.text = self.textFieldCellModel.titleStr;
    if (self.textFieldCellModel.isShowKeyboard) {
        self.textField1.keyboardType = self.textFieldCellModel.keyType;
        self.textField2.keyboardType = self.textFieldCellModel.keyType;
    }
    if ([self.textFieldCellModel.data[0]isKindOfClass:[NSString class]]) {
        self.textField1.text = self.textFieldCellModel.data[0];
    }else {
        self.textField1.text = [NSString stringWithFormat:@"%ld",(long)[self.textFieldCellModel.data[0] integerValue]];
    }
    if ([self.textFieldCellModel.data[1]isKindOfClass:[NSString class]]) {
        self.textField2.text = self.textFieldCellModel.data[1];
    }else {
        self.textField2.text = [NSString stringWithFormat:@"%ld",(long)[self.textFieldCellModel.data[1] integerValue]];
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
    CGFloat keyMinY = funcVC.view.frame.size.height - 216;
    if (differ > keyMinY) {
        [funcVC.tableView setContentInset:UIEdgeInsetsMake(-(differ - keyMinY), 0, 0, 0)];
    }
}

@end
