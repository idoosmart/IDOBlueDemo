//
//  OneSwitchTableViewCell.m
//  SDKDemo
//
//  Created by hedongyang on 2018/6/14.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "OneSwitchTableViewCell.h"
#import "SwitchCellModel.h"
#import "IDODemoUtility.h"

@interface OneSwitchTableViewCell()
@property (nonatomic,strong) SwitchCellModel * switchCellModel;
@end

@implementation OneSwitchTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel * label = [[UILabel alloc]init];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14];
        [self addSubview:label];
        self.title = label;
        
        UISwitch * switchButton = [[UISwitch alloc]init];
        [switchButton addTarget:self action:@selector(switchButtonAction:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:switchButton];
        self.switchButton = switchButton;
        __weak typeof(self) weakSelf = self;
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong typeof(self) strongSelf = weakSelf;
            make.left.equalTo(@16);
            make.centerY.equalTo(strongSelf.mas_centerY);
        }];
        
        [self.switchButton mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong typeof(self) strongSelf = weakSelf;
            make.right.equalTo(@(-16));
            make.centerY.equalTo(strongSelf.mas_centerY);
        }];
    }
    return self;
}

- (void)setCellModel:(BaseCellModel *)model
{
    self.switchCellModel = (SwitchCellModel *)model;
    self.title.text = self.switchCellModel.titleStr;
    self.switchButton.on = [self.switchCellModel.data[0] boolValue];
}

- (void)switchButtonAction:(UISwitch *)sender
{
    if (self.switchCellModel.switchCallback) {
        self.switchCellModel.switchCallback([IDODemoUtility getCurrentVC],sender,self);
    }
}

@end
