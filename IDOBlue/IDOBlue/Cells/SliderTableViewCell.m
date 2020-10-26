//
//  SliderTableViewCell.m
//  IDOBlue
//
//  Created by 何东阳 on 2018/11/14.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "SliderTableViewCell.h"
#import "IDODemoUtility.h"
#import "SliderCellModel.h"

@interface SliderTableViewCell()
@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) UISlider * slider;
@property (nonatomic,strong) UILabel * valueLabel;
@property (nonatomic,strong) SliderCellModel * sliderModel;
@end

@implementation SliderTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.titleLabel];
        __weak typeof(self) weakSelf = self;
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong typeof(self) strongSelf = weakSelf;
            make.left.equalTo(@16);
            make.centerY.equalTo(strongSelf.mas_centerY);
        }];
        
        self.slider = [[UISlider alloc]init];
        self.slider.minimumValue = 0;
        self.slider.maximumValue = 100;
        [self.slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
        UIColor * color = [UIColor colorWithRed:142/255.0f green:91/255.0f blue:45/255.0f alpha:1.0];
        self.slider.thumbTintColor = color;
        [self.contentView addSubview:self.slider];
        [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong typeof(self) strongSelf = weakSelf;
            make.left.equalTo(strongSelf.titleLabel.mas_right).offset(10);
            make.centerY.equalTo(strongSelf.mas_centerY);
        }];
        
        self.valueLabel = [[UILabel alloc]init];
        self.valueLabel.textColor = [UIColor blackColor];
        self.valueLabel.textAlignment = NSTextAlignmentRight;
        self.valueLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.valueLabel];
        [self.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong typeof(self) strongSelf = weakSelf;
            make.left.equalTo(strongSelf.slider.mas_right).offset(10);
            make.right.equalTo(@(-16));
            make.centerY.equalTo(strongSelf.mas_centerY);
        }];
        
        [self.titleLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [self.slider setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
        [self.valueLabel setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    }
    return self;
}

- (void)setCellModel:(BaseCellModel *)model
{
    self.sliderModel = (SliderCellModel *)model;
    self.titleLabel.text = @"RSSI:";
    [self.slider setValue:[model.data[0]intValue] animated:YES];
    self.valueLabel.text = [NSString stringWithFormat:@"%ddBm",[model.data[0]intValue]];
}

- (void)sliderAction:(UISlider *)slider
{
    self.valueLabel.text = [NSString stringWithFormat:@"%ddBm",(int)slider.value];
    if (self.sliderModel.sliderCallback) {
        self.sliderModel.sliderCallback([IDODemoUtility getCurrentVC],slider,self);
    }
}

@end
