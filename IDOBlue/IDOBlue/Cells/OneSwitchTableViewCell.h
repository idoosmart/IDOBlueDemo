//
//  OneSwitchTableViewCell.h
//  SDKDemo
//
//  Created by hedongyang on 2018/6/14.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"

@interface OneSwitchTableViewCell : BaseTableViewCell
@property (nonatomic,strong) UILabel * title;
@property (nonatomic,strong) UISwitch * switchButton;
@end
