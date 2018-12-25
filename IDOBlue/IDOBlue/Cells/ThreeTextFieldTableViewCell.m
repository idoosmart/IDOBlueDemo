//
//  BirthdayTableViewCell.m
//  SDKDemo
//
//  Created by hedongyang on 2018/6/8.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "ThreeTextFieldTableViewCell.h"
#import "TextFieldCellModel.h"
#import "IDODemoUtility.h"
#import "FuncViewController.h"
#import "Masonry.h"

@interface ThreeTextFieldTableViewCell()<UITextFieldDelegate>
@property (nonatomic,strong) TextFieldCellModel * textFieldCellModel;
@end

@implementation ThreeTextFieldTableViewCell

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
        }];
        
        self.textField1 = [[UITextField alloc]init];
        self.textField1.borderStyle = UITextBorderStyleRoundedRect;
        self.textField1.textColor = [UIColor blackColor];
        self.textField1.textAlignment = NSTextAlignmentCenter;
        self.textField1.font = [UIFont systemFontOfSize:14];
        self.textField1.delegate = self;
        [self addSubview:self.textField1];
        [self.textField1 mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong typeof(self) strongSelf = weakSelf;
            make.centerY.equalTo(strongSelf.mas_centerY);
            make.left.equalTo(strongSelf.title.mas_right).offset(10);
            make.width.equalTo(@60);
        }];
        
        self.textField2 = [[UITextField alloc]init];
        self.textField2.borderStyle = UITextBorderStyleRoundedRect;
        self.textField2.textAlignment = NSTextAlignmentCenter;
        self.textField2.textColor = [UIColor blackColor];
        self.textField2.font = [UIFont systemFontOfSize:14];
        self.textField2.delegate = self;
        [self addSubview:self.textField2];
        [self.textField2 mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong typeof(self) strongSelf = weakSelf;
            make.centerY.equalTo(strongSelf.mas_centerY);
            make.left.equalTo(strongSelf.textField1.mas_right).offset(10);
            make.width.equalTo(@60);
        }];
        
        self.textField3 = [[UITextField alloc]init];
        self.textField3.borderStyle = UITextBorderStyleRoundedRect;
        self.textField3.textAlignment = NSTextAlignmentCenter;
        self.textField3.textColor = [UIColor blackColor];
        self.textField3.font = [UIFont systemFontOfSize:14];
        self.textField3.delegate = self;
        [self addSubview:self.textField3];
        [self.textField3 mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong typeof(self) strongSelf = weakSelf;
            make.centerY.equalTo(strongSelf.mas_centerY);
            make.left.equalTo(strongSelf.textField2.mas_right).offset(10);
            make.width.equalTo(@60);
        }];
        
    }
    return self;
}

- (void)setCellModel:(BaseCellModel *)model
{
    self.textFieldCellModel = (TextFieldCellModel *)model;
    self.title.text = self.textFieldCellModel.titleStr;
    self.textField1.text = [NSString stringWithFormat:@"%ld",(long)[self.textFieldCellModel.data[0]integerValue]];
    self.textField2.text = [NSString stringWithFormat:@"%ld",(long)[self.textFieldCellModel.data[1]integerValue]];
    self.textField3.text = [NSString stringWithFormat:@"%ld",(long)[self.textFieldCellModel.data[2]integerValue]];
}

#pragma mark - ****************** UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (self.textFieldCellModel.textFeildCallback) {
        self.textFieldCellModel.textFeildCallback([IDODemoUtility getCurrentVC],textField,self);
        [self tableViewContentInset];
    }
    return NO;
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
