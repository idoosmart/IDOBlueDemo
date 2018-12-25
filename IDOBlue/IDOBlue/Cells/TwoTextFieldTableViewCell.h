//
//  TwoTextFieldTableViewCell.h
//  SDKDemo
//
//  Created by hedongyang on 2018/6/14.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"

@interface TwoTextFieldTableViewCell : BaseTableViewCell
@property (nonatomic,strong) UILabel * title;
@property (nonatomic,strong) UITextField * textField1;
@property (nonatomic,strong) UITextField * textField2;

@end
