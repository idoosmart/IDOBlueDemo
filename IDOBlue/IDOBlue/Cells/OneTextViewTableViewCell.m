//
//  TextViewTableViewCell.m
//  IDOBluetoothDemo
//
//  Created by hedongyang on 2018/9/14.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "OneTextViewTableViewCell.h"
#import "TextViewCellModel.h"

@interface OneTextViewTableViewCell()
@property (nonatomic,strong) TextViewCellModel * textViewModel;
@end

@implementation OneTextViewTableViewCell
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
        self.textView.layoutManager.allowsNonContiguousLayout = NO;
        [self.contentView addSubview:self.textView];
        __weak typeof(self) weakSelf = self;
        [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong typeof(self) strongSelf = weakSelf;
            make.edges.equalTo(strongSelf);
        }];
    }
    return self;
}

- (void)setCellModel:(BaseCellModel *)model
{
    self.textViewModel = (TextViewCellModel *)model;
    if (self.textViewModel.data) {
        self.textView.text = [self.textViewModel.data firstObject];
    }
    if (self.textViewModel.textViewCallback) {
        self.textViewModel.textViewCallback(self.textView);
    }
}

@end
