//
//  SexTableViewCell.m
//  SDKDemo
//
//  Created by hedongyang on 2018/6/8.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "TwoButtonTableViewCell.h"
#import "IDODemoUtility.h"
#import "FuncCellModel.h"

@interface TwoButtonTableViewCell()
@property (nonatomic,strong) FuncCellModel * funcCellModel;
@end

@implementation TwoButtonTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.title = [[UILabel alloc]init];
        self.title.textColor = [UIColor blackColor];
        self.title.textAlignment = NSTextAlignmentLeft;
        self.title.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.title];
        __weak typeof(self) weakSelf = self;
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong typeof(self) strongSelf = weakSelf;
            make.left.equalTo(@16);
            make.centerY.equalTo(strongSelf.mas_centerY);
        }];
        
        self.button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        UIColor * colorNormal = [UIColor colorWithRed:236/255.0f green:236/255.0f blue:236/255.0f alpha:1.0f];
        UIColor * colorSelected = [UIColor colorWithRed:142/255.0f green:91/255.0f blue:45/255.0f alpha:1.0];
        [self.button1 setBackgroundImage:[IDODemoUtility imageWithColor:colorNormal] forState:UIControlStateNormal];
        [self.button1 setBackgroundImage:[IDODemoUtility imageWithColor:colorSelected] forState:UIControlStateSelected];
        [self.button1 addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.button1];
        [self.button1 mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong typeof(self) strongSelf = weakSelf;
            make.left.equalTo(strongSelf.title.mas_right).offset(10);
            make.centerY.equalTo(strongSelf.mas_centerY);
            make.height.equalTo(@30);
        }];
        
        
        self.button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        colorNormal = [UIColor colorWithRed:236/255.0f green:236/255.0f blue:236/255.0f alpha:1.0f];
        colorSelected = [UIColor colorWithRed:142/255.0f green:91/255.0f blue:45/255.0f alpha:1.0];
        [self.button2 setBackgroundImage:[IDODemoUtility imageWithColor:colorNormal] forState:UIControlStateNormal];
        [self.button2 setBackgroundImage:[IDODemoUtility imageWithColor:colorSelected] forState:UIControlStateSelected];
        [self.button2 addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.button2];
        
        [self.button2 mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong typeof(self) strongSelf = weakSelf;
            make.left.equalTo(strongSelf.button1.mas_right).offset(10);
            make.centerY.equalTo(strongSelf.mas_centerY);
            make.right.equalTo(@(-16));
            make.width.equalTo(strongSelf.button1.mas_width);
            make.height.equalTo(@30);
        }];
        self.button1.selected = YES;
        
        [self.title setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [self.button1 setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
        [self.button2 setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    }
    return self;
}

- (void)setCellModel:(BaseCellModel *)model
{
    self.funcCellModel = (FuncCellModel *)model;
    self.title.text = self.funcCellModel.titleStr;
    NSDictionary * dic1 = self.funcCellModel.data[0];
    NSDictionary * dic2 = self.funcCellModel.data[1];
    NSString * title1 = [dic1 valueForKey:@"title"];
    NSString * title2 = [dic2 valueForKey:@"title"];
    BOOL isSelected1 = [[dic1 valueForKey:@"state"] boolValue];
    BOOL isSelected2 = [[dic2 valueForKey:@"state"] boolValue];
    [self.button1 setTitle:title1 forState:UIControlStateNormal];
    [self.button2 setTitle:title2 forState:UIControlStateNormal];
    self.button1.selected = isSelected1;
    self.button2.selected = isSelected2;
}

- (void)buttonSelected:(UIButton *)sender
{
    if (sender == self.button1) {
        self.button1.selected = YES;
        self.button2.selected = NO;
    }else {
        self.button1.selected = NO;
        self.button2.selected = YES;
    }
    if (self.funcCellModel.buttconCallback) {
        self.funcCellModel.buttconCallback([IDODemoUtility getCurrentVC],self);
    }
}


@end
