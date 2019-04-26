//
//  TipPoweredOffView.m
//  IDOBlue
//
//  Created by 何东阳 on 2019/1/14.
//  Copyright © 2019年 hedongyang. All rights reserved.
//

#import "TipPoweredOffView.h"
#import "IDODemoUtility.h"

@interface TipPoweredOffView ()

@property (nonatomic,strong) UIView * bgView;
@property (nonatomic,strong) UIImageView * iconView;
@property (nonatomic,strong) UILabel * tipLabel;

@end

@implementation TipPoweredOffView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.bgView = [[UIView alloc]initWithFrame:self.bounds];
        self.bgView.backgroundColor = [UIColor colorWithRed:255.0/255.0f green:255/255.0f blue:255.0/255.0f alpha:0.6];
        [self addSubview:self.bgView];
        self.iconView = [[UIImageView alloc]initWithFrame:CGRectMake((frame.size.width - 150)/2,(frame.size.height - 190)/2,150,150)];
        self.iconView.image = [UIImage imageNamed:@"bluetooth_off"];
        self.iconView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.iconView];
        self.tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.iconView.frame),frame.size.width,40)];
        self.tipLabel.font = [UIFont systemFontOfSize:18];
        self.tipLabel.textColor = [UIColor blackColor];
        self.tipLabel.textAlignment = NSTextAlignmentCenter;
        self.tipLabel.text = lang(@"please enable bluetooth to continue using the current app");
        [self addSubview:self.tipLabel];
    }
    return self;
}

+ (void)show
{
    UIWindow * window = [UIApplication sharedApplication].delegate.window;
    TipPoweredOffView * tipView = [[TipPoweredOffView alloc]initWithFrame:window.bounds];
    [window addSubview:tipView];
}

+ (void)hidView
{
    UIWindow * window = [UIApplication sharedApplication].delegate.window;
    for (UIView * view in window.subviews) {
        if ([view isKindOfClass:[TipPoweredOffView class]]) {
            view.hidden = YES;
            [view removeFromSuperview];
        }
    }
}


@end
