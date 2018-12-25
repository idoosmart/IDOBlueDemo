//
//  SexTableViewCell.m
//  SDKDemo
//
//  Created by hedongyang on 2018/6/8.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "SexTableViewCell.h"
#import "Masonry.h"
#import "IDODemoUtility.h"

@implementation SexTableViewCell

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
        
        self.manButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.manButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        UIColor * colorNormal = [UIColor colorWithRed:236/255.0f green:236/255.0f blue:236/255.0f alpha:1.0f];
        UIColor * colorSelected = [UIColor colorWithRed:142/255.0f green:91/255.0f blue:45/255.0f alpha:1.0];
        [self.manButton setBackgroundImage:[IDODemoUtility imageWithColor:colorNormal] forState:UIControlStateNormal];
        [self.manButton setBackgroundImage:[IDODemoUtility imageWithColor:colorSelected] forState:UIControlStateSelected];
        [self.manButton addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.manButton];
        [self.manButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.title.mas_right).offset(10);
            make.centerY.equalTo(self.mas_centerY);
            make.width.equalTo(@60);
            make.height.equalTo(@30);
        }];
        
        
        self.womanButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.womanButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        colorNormal = [UIColor colorWithRed:236/255.0f green:236/255.0f blue:236/255.0f alpha:1.0f];
        colorSelected = [UIColor colorWithRed:142/255.0f green:91/255.0f blue:45/255.0f alpha:1.0];
        [self.womanButton setBackgroundImage:[IDODemoUtility imageWithColor:colorNormal] forState:UIControlStateNormal];
        [self.womanButton setBackgroundImage:[IDODemoUtility imageWithColor:colorSelected] forState:UIControlStateSelected];
        [self.womanButton addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.womanButton];
        
        [self.womanButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.manButton.mas_right).offset(10);
            make.centerY.equalTo(self.mas_centerY);
            make.width.equalTo(@60);
            make.height.equalTo(@30);
        }];
        
        self.manButton.selected = YES;
    }
    return self;
}

- (void)buttonSelected:(UIButton *)sender
{
    if (sender == self.manButton) {
        self.manButton.selected = YES;
        self.womanButton.selected = NO;
    }else {
        self.manButton.selected = NO;
        self.womanButton.selected = YES;
    }
}


@end
