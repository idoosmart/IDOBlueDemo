//
//  BirthdayTableViewCell.h
//  SDKDemo
//
//  Created by hedongyang on 2018/6/8.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"

@interface ThreeTextFieldTableViewCell : BaseTableViewCell
@property (nonatomic,strong) UILabel * title;
@property (nonatomic,strong) UITextField * textField1;
@property (nonatomic,strong) UITextField * textField2;
@property (nonatomic,strong) UITextField * textField3;
@end
