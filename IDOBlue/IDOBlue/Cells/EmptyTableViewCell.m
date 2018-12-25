//
//  EmptyTableViewCell.m
//  SDKDemo
//
//  Created by hedongyang on 2018/7/10.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "EmptyTableViewCell.h"

@implementation EmptyTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:236/255.0f green:236/255.0f blue:236/255.0f alpha:1.0f];
    }
    return self;
}

- (void)setCellModel:(BaseCellModel *)model
{
    
}

@end

