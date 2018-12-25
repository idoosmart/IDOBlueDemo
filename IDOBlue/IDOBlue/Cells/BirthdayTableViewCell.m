//
//  BirthdayTableViewCell.m
//  SDKDemo
//
//  Created by hedongyang on 2018/6/8.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "BirthdayTableViewCell.h"
#import "Masonry.h"

@implementation BirthdayTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.title = [[UILabel alloc]init];
        self.title.textColor = [UIColor blackColor];
        self.title.textAlignment = NSTextAlignmentLeft;
        self.title.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.title];
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@16);
            make.centerY.equalTo(self.mas_centerY);
        }];
        
        self.textField1 = [[UITextField alloc]init];
        self.textField1.borderStyle = UITextBorderStyleRoundedRect;
        self.textField1.textColor = [UIColor blackColor];
        self.textField1.textAlignment = NSTextAlignmentCenter;
        self.textField1.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.textField1];
        [self.textField1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(self.title.mas_right).offset(10);
            make.width.equalTo(@60);
        }];
        
        self.textField2 = [[UITextField alloc]init];
        self.textField2.borderStyle = UITextBorderStyleRoundedRect;
        self.textField2.textAlignment = NSTextAlignmentCenter;
        self.textField2.textColor = [UIColor blackColor];
        self.textField2.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.textField2];
        [self.textField2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(self.textField1.mas_right).offset(10);
            make.width.equalTo(@60);
        }];
        
        self.textField3 = [[UITextField alloc]init];
        self.textField3.borderStyle = UITextBorderStyleRoundedRect;
        self.textField3.textAlignment = NSTextAlignmentCenter;
        self.textField3.textColor = [UIColor blackColor];
        self.textField3.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.textField3];
        [self.textField3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(self.textField2.mas_right).offset(10);
            make.width.equalTo(@60);
        }];
        
    }
    return self;
}

@end
