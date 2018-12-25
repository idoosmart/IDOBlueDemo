//
//  TextViewTableViewCell.m
//  IDOBluetoothDemo
//
//  Created by hedongyang on 2018/9/14.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "TextViewTableViewCell.h"
#import "Masonry.h"

@implementation TextViewTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textView = [[UITextView alloc] init];
        self.textView.textColor = [UIColor whiteColor];
        self.textView.backgroundColor = [UIColor blackColor];
        self.textView.font = [UIFont systemFontOfSize:10];
        self.textView.textAlignment = NSTextAlignmentLeft;
        self.textView.editable = NO;
        self.textView.layoutManager.allowsNonContiguousLayout = YES;
        [self addSubview:self.textView];
        [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

@end
