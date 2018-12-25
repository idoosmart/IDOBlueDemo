//
//  SelectDefaultTableViewCell.m
//  SDKDemo
//
//  Created by hedongyang on 2018/6/15.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "OneLabelTableViewCell.h"
#import "Masonry.h"

@implementation OneLabelTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.title = [[UILabel alloc]init];
        self.title.textColor = [UIColor blackColor];
        self.title.textAlignment = NSTextAlignmentLeft;
        self.title.font = [UIFont systemFontOfSize:14];
        self.title.numberOfLines = 0;
        [self addSubview:self.title];
        
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@16);
            make.right.equalTo(@(-16));
            make.centerY.equalTo(self.mas_centerY);
        }];
    }
    return self;
}


@end
