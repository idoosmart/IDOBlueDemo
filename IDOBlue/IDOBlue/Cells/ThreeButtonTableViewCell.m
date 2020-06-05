//
//  ThreeButtonTableViewCell.m
//  IDOBlue
//
//  Created by 何东阳 on 2018/10/22.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "ThreeButtonTableViewCell.h"
#import "IDODemoUtility.h"
#import "TabCellModel.h"

@interface ThreeButtonTableViewCell()
@property (nonatomic,strong) TabCellModel * tabModel;
@end

@implementation ThreeButtonTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        __weak typeof(self) weakSelf = self;
        self.button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        UIColor * colorNormal = [UIColor colorWithRed:236/255.0f green:236/255.0f blue:236/255.0f alpha:1.0f];
        UIColor * colorSelected = [UIColor colorWithRed:142/255.0f green:91/255.0f blue:45/255.0f alpha:1.0];
        [self.button1 setBackgroundImage:[IDODemoUtility imageWithColor:colorNormal] forState:UIControlStateNormal];
        [self.button1 setBackgroundImage:[IDODemoUtility imageWithColor:colorSelected] forState:UIControlStateSelected];
        [self.button1 addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
        self.button1.tag = 0;
        [self addSubview:self.button1];
        [self.button1 mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong typeof(self) strongSelf = weakSelf;
            make.left.equalTo(@5);
            make.centerY.equalTo(strongSelf.mas_centerY);
            make.width.equalTo(strongSelf.mas_width).multipliedBy(0.3);
            make.height.equalTo(@40);
        }];
        
        
        self.button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        colorNormal = [UIColor colorWithRed:236/255.0f green:236/255.0f blue:236/255.0f alpha:1.0f];
        colorSelected = [UIColor colorWithRed:142/255.0f green:91/255.0f blue:45/255.0f alpha:1.0];
        [self.button2 setBackgroundImage:[IDODemoUtility imageWithColor:colorNormal] forState:UIControlStateNormal];
        [self.button2 setBackgroundImage:[IDODemoUtility imageWithColor:colorSelected] forState:UIControlStateSelected];
        [self.button2 addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
        self.button2.tag = 1;
        [self addSubview:self.button2];
        
        [self.button2 mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong typeof(self) strongSelf = weakSelf;
            make.centerY.equalTo(strongSelf.mas_centerY);
            make.centerX.equalTo(strongSelf.mas_centerX);
            make.width.equalTo(strongSelf.mas_width).multipliedBy(0.3);
            make.height.equalTo(@40);
        }];
        
        self.button3 = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.button3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        colorNormal = [UIColor colorWithRed:236/255.0f green:236/255.0f blue:236/255.0f alpha:1.0f];
        colorSelected = [UIColor colorWithRed:142/255.0f green:91/255.0f blue:45/255.0f alpha:1.0];
        [self.button3 setBackgroundImage:[IDODemoUtility imageWithColor:colorNormal] forState:UIControlStateNormal];
        [self.button3 setBackgroundImage:[IDODemoUtility imageWithColor:colorSelected] forState:UIControlStateSelected];
        [self.button3 addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
        self.button3.tag = 2;
        [self addSubview:self.button3];
        
        [self.button3 mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong typeof(self) strongSelf = weakSelf;
            make.centerY.equalTo(strongSelf.mas_centerY);
            make.right.equalTo(@(-5));
            make.width.equalTo(strongSelf.mas_width).multipliedBy(0.3);
            make.height.equalTo(@40);
        }];
        
        self.button1.selected = YES;
    }
    return self;
}

- (void)setCellModel:(BaseCellModel *)model
{
    self.tabModel = (TabCellModel *)model;
    
    self.button1.selected = [self.tabModel.selectIndexs[0] boolValue];
    self.button2.selected = [self.tabModel.selectIndexs[1] boolValue];
    self.button3.selected = [self.tabModel.selectIndexs[2] boolValue];
    
    [self.button1 setTitle:self.tabModel.data[0] forState:UIControlStateNormal];
    [self.button2 setTitle:self.tabModel.data[1] forState:UIControlStateNormal];
    [self.button3 setTitle:self.tabModel.data[2] forState:UIControlStateNormal];
}

- (void)buttonSelected:(UIButton *)sender
{    
    if (self.tabModel.threeButtonCallback) {
        self.tabModel.threeButtonCallback(sender.tag,self);
    }
}


@end
