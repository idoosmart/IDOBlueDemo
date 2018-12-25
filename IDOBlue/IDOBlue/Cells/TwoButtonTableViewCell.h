//
//  SexTableViewCell.h
//  SDKDemo
//
//  Created by hedongyang on 2018/6/8.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"

@interface TwoButtonTableViewCell : BaseTableViewCell
@property (nonatomic,strong) UILabel * title;
@property (nonatomic,strong) UIButton * button1;
@property (nonatomic,strong) UIButton * button2;

@end
