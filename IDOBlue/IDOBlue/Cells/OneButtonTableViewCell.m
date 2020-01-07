//
//  FunListTableViewCell.m
//  SDKDemo
//
//  Created by hedongyang on 2018/6/6.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "OneButtonTableViewCell.h"
#import "FuncCellModel.h"
#import "IDODemoUtility.h"
#import "Masonry.h"

@interface OneButtonTableViewCell()
@property (nonatomic,strong) FuncCellModel * funcCellModel;
@end

@implementation OneButtonTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:236/255.0f green:236/255.0f blue:236/255.0f alpha:1.0f];
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        UIColor * color = [UIColor colorWithRed:142/255.0f green:91/255.0f blue:45/255.0f alpha:1.0];
        [self.button setBackgroundImage:[IDODemoUtility imageWithColor:color] forState:UIControlStateNormal];
        [self.button addTarget:self action:@selector(actionButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.button];
        [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.right.equalTo(@0);
            make.top.equalTo(@0);
            make.height.equalTo(@40);
        }];
    }
    return self;
}

- (void)setCellModel:(BaseCellModel *)model
{
    self.funcCellModel = (FuncCellModel *)model;
    if (self.funcCellModel.isClick) {
        UIColor * color = [UIColor colorWithRed:142/255.0f green:91/255.0f blue:45/255.0f alpha:0.5];
        [self.button setBackgroundImage:[IDODemoUtility imageWithColor:color] forState:UIControlStateNormal];
    }else {
        UIColor * color = [UIColor colorWithRed:142/255.0f green:91/255.0f blue:45/255.0f alpha:1.0];
        [self.button setBackgroundImage:[IDODemoUtility imageWithColor:color] forState:UIControlStateNormal];
    }
    [self.button setTitle:[model.data firstObject] forState:UIControlStateNormal];
    self.button.enabled = !self.funcCellModel.isNoEnabled;
}

- (void)actionButton:(UIButton *)sender
{
    if (self.funcCellModel.buttconCallback) {
        self.funcCellModel.buttconCallback([IDODemoUtility getCurrentVC],self);
    }
}


@end
