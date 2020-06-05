//
//  BindDeviceView.m
//  IDOBlue
//
//  Created by 何东阳 on 2018/11/14.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "BindDeviceView.h"
#import "IDODemoUtility.h"

@interface BindDeviceView()
@property (nonatomic,strong)UIView * boxView;
@property (nonatomic,strong)UIButton * cancelButton;
@property (nonatomic,strong)UIButton * okButton;
@end

@implementation BindDeviceView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.boxView = [[UIView alloc]init];
        self.boxView.layer.borderWidth = 0.5;
        self.boxView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.boxView];
        [self.boxView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.centerY.equalTo(self.mas_centerY).offset(-32);
            make.width.equalTo(@240);
            make.height.equalTo(@150);
        }];
        
        UILabel * title = [[UILabel alloc]init];
        title.text = lang(@"tip");
        title.font = [UIFont systemFontOfSize:20];
        title.textAlignment = NSTextAlignmentCenter;
        [self.boxView addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@10);
            make.left.equalTo(@0);
            make.right.equalTo(@0);
            make.height.equalTo(@30);
        }];
        
        self.tipLabel = [[UILabel alloc]init];
        self.tipLabel.font = [UIFont systemFontOfSize:16];
        self.tipLabel.textAlignment = NSTextAlignmentCenter;
        self.tipLabel.numberOfLines = 2;
        self.tipLabel.textColor = [UIColor colorWithRed:142/255.0f green:91/255.0f blue:45/255.0f alpha:1.0];
        [self.boxView addSubview:self.tipLabel];
        [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.boxView.mas_centerX);
            make.centerY.equalTo(self.boxView.mas_centerY).offset(-5);
            make.width.equalTo(@180);
            make.height.equalTo(@40);
        }];
        
        UIView * line1 = [[UIView alloc]init];
        line1.backgroundColor = [UIColor blackColor];
        [self.boxView addSubview:line1];
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.right.equalTo(@0);
            make.bottom.equalTo(@(-40.5));
            make.height.equalTo(@0.5);
        }];
        
        self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.cancelButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.cancelButton setTitle:lang(@"cancel") forState:UIControlStateNormal];
        [self.cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
        [self.boxView addSubview:self.cancelButton];
        [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.bottom.equalTo(@0);
            make.height.equalTo(@40);
            make.width.equalTo(@120);
        }];
        
        UIView * line2 = [[UIView alloc]init];
        line2.backgroundColor = [UIColor blackColor];
        [self.boxView addSubview:line2];
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.cancelButton.mas_right);
            make.width.equalTo(@0.5);
            make.bottom.equalTo(@0);
            make.height.equalTo(@40);
        }];
        
        self.okButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.okButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [self.okButton setTitle:lang(@"ok") forState:UIControlStateNormal];
        [self.okButton addTarget:self action:@selector(okAction) forControlEvents:UIControlEventTouchUpInside];
        [self.boxView addSubview:self.okButton];
        [self.okButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.boxView.mas_centerX).offset(0.5);
            make.bottom.equalTo(@0);
            make.height.equalTo(@40);
            make.width.equalTo(@119.5);
        }];
        self.hidden = YES;
    }
    return self;
}

- (void)show
{
    self.hidden = NO;
}

- (void)cancelAction
{
    self.hidden = YES;
    if (_delegate && [_delegate respondsToSelector:@selector(cancelBindButton)]) {
        [_delegate cancelBindButton];
    }
}

- (void)okAction
{
    self.hidden = YES;
    if (_delegate && [_delegate respondsToSelector:@selector(allowBinding)]) {
        [_delegate allowBinding];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self cancelAction];
}

@end
