//
//  ScanTableViewCell.m
//  IDOBlue
//
//  Created by hedongyang on 2018/10/28.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "ScanTableViewCell.h"

@interface ScanTableViewCell()
@property (nonatomic,strong) UIImageView * iconView;
@property (nonatomic,strong) UILabel * nameLabel;
@property (nonatomic,strong) UILabel * subtitleLabel;
@property (nonatomic,strong) UIImageView * signalView;
@property (nonatomic,strong) UILabel * signalLabel;
@property (nonatomic,strong) UIImageView * distanceView;
@property (nonatomic,strong) UILabel * distanceLabel;
@end

@implementation ScanTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.iconView = [[UIImageView alloc]init];
        self.iconView.contentMode = UIViewContentModeScaleAspectFit;
        self.iconView.image = [UIImage imageNamed:@"bluetooth"];
        [self addSubview:self.iconView];
        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(@16);
            make.width.equalTo(@28);
            make.height.equalTo(@28);
        }];
        
        self.subtitleLabel = [[UILabel alloc]init];
        self.subtitleLabel.font = [UIFont systemFontOfSize:10];
        self.subtitleLabel.textColor = [UIColor grayColor];
        self.subtitleLabel.numberOfLines = 2;
        [self addSubview:self.subtitleLabel];
        [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconView.mas_right).offset(8);
            make.centerY.equalTo(self.iconView.mas_centerY);
            make.right.equalTo(@(-5));
        }];
        
        self.nameLabel = [[UILabel alloc]init];
        self.nameLabel.font = [UIFont systemFontOfSize:14];
        self.nameLabel.textColor = [UIColor blackColor];
        [self addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconView.mas_right).offset(8);
            make.bottom.equalTo(self.subtitleLabel.mas_top);
            make.right.equalTo(@(-5));
        }];
        
        self.signalView = [[UIImageView alloc]init];
        self.signalView.contentMode = UIViewContentModeScaleAspectFit;
        self.signalView.image = [UIImage imageNamed:@"signal"];
        [self addSubview:self.signalView];
        [self.signalView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconView.mas_right).offset(8);
            make.top.equalTo(self.subtitleLabel.mas_bottom).offset(5);
            make.width.equalTo(@15);
            make.height.equalTo(@15);
        }];
        
        self.signalLabel = [[UILabel alloc]init];
        self.signalLabel.font = [UIFont systemFontOfSize:14];
        self.signalLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:self.signalLabel];
        [self.signalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.signalView.mas_right).offset(5);
            make.centerY.equalTo(self.signalView.mas_centerY);
        }];
        
        self.distanceView = [[UIImageView alloc]init];
        self.distanceView.contentMode = UIViewContentModeScaleAspectFit;
        self.distanceView.image = [UIImage imageNamed:@"distance"];
        [self addSubview:self.distanceView];
        [self.distanceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.signalLabel.mas_right).offset(8);
            make.top.equalTo(self.subtitleLabel.mas_bottom).offset(5);
            make.width.equalTo(@15);
            make.height.equalTo(@15);
        }];
        
        self.distanceLabel = [[UILabel alloc]init];
        self.distanceLabel.font = [UIFont systemFontOfSize:14];
        self.distanceLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:self.distanceLabel];
        [self.distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.distanceView.mas_right).offset(5);
            make.centerY.equalTo(self.signalView.mas_centerY);
        }];
        
        self.updateButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.updateButton setTitle:@"升级设备" forState:UIControlStateNormal];
        UIColor * color1 = [UIColor colorWithRed:142/255.0f green:91/255.0f blue:45/255.0f alpha:1.0];
        UIColor * color2 = [UIColor colorWithRed:236/255.0f green:236/255.0f blue:236/255.0f alpha:1.0f];
        [self.updateButton setTitleColor:color1 forState:UIControlStateNormal];
        [self.updateButton setTitleColor:color2 forState:UIControlStateHighlighted];
        self.updateButton.titleLabel.font = [UIFont systemFontOfSize:12];
        self.updateButton.layer.borderWidth = 0.5;
        self.updateButton.layer.borderColor = color1.CGColor;
        [self addSubview:self.updateButton];
        [self.updateButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-16));
            make.bottom.equalTo(@(-5));
            make.height.equalTo(@20);
            make.width.equalTo(@60);
        }];
        
        self.bindButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.bindButton setTitle:@"绑定设备" forState:UIControlStateNormal];
        [self.bindButton setTitleColor:color1 forState:UIControlStateNormal];
        [self.bindButton setTitleColor:color2 forState:UIControlStateHighlighted];
        self.bindButton.titleLabel.font = [UIFont systemFontOfSize:12];
        self.bindButton.layer.borderWidth = 0.5;
        self.bindButton.layer.borderColor = color1.CGColor;
        [self addSubview:self.bindButton];
        [self.bindButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-16));
            make.bottom.equalTo(@(-5));
            make.height.equalTo(@20);
            make.width.equalTo(@60);
        }];
        
        self.updateButton.hidden = YES;
        self.bindButton.hidden   = YES;
    }
    return self;
}

- (void)setPeripheralModel:(IDOPeripheralModel *)peripheralModel
{
    _peripheralModel = peripheralModel;
    self.nameLabel.text = _peripheralModel.name;
    self.subtitleLabel.text = [NSString stringWithFormat:@"MAC  : %@ \nUUID : %@",_peripheralModel.macAddr?:@"",_peripheralModel.uuidStr];
    self.signalLabel.text   = [NSString stringWithFormat:@"%ld", (long)_peripheralModel.rssi];
    self.distanceLabel.text = [NSString stringWithFormat:@"%.2f m",_peripheralModel.distance];
}

@end
