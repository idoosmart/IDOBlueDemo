//
//  TableViewFootView.m
//  IDOBlue
//
//  Created by 何东阳 on 2018/10/24.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "TableViewFootView.h"
#import "Masonry.h"
#import "IDODemoUtility.h"

@interface TableViewFootView()
@property (nonatomic,strong) UIView * lineView;
@end

@implementation TableViewFootView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.lineView = [[UIView alloc]init];
        self.lineView.backgroundColor = [IDODemoUtility colorWithHexString:@"#c8c8c8"];
        [self addSubview:self.lineView];
        
        self.setButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.setButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.setButton setTitle:lang(@"query data") forState:UIControlStateNormal];
        UIColor * color = [UIColor colorWithRed:142/255.0f green:91/255.0f blue:45/255.0f alpha:1.0];
        [self.setButton setBackgroundImage:[IDODemoUtility imageWithColor:color] forState:UIControlStateNormal];
        [self addSubview:self.setButton];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(@0);
        make.height.equalTo(@0.5);
    }];
    
    [self.setButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.right.equalTo(@(-16));
        make.height.equalTo(@40);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
}


@end
