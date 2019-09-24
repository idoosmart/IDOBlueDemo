//
//  SelectDefaultTableViewCell.m
//  SDKDemo
//
//  Created by hedongyang on 2018/6/15.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "OneLabelTableViewCell.h"
#import "LabelCellModel.h"
#import "IDODemoUtility.h"
#import "FuncViewController.h"
#import "Masonry.h"

@interface OneLabelTableViewCell()
@property (nonatomic,strong) LabelCellModel * labelCellModel;
@end

@implementation OneLabelTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer * recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelAction:)];
        [self addGestureRecognizer:recognizer];
        self.title = [[UILabel alloc]init];
        self.title.textColor = [UIColor blackColor];
        self.title.textAlignment = NSTextAlignmentLeft;
        self.title.font = [UIFont systemFontOfSize:14];
        self.title.numberOfLines = 0;
        [self addSubview:self.title];
        __weak typeof(self) weakSelf = self;
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong typeof(self) strongSelf = weakSelf;
            make.left.equalTo(@16);
            make.right.equalTo(@(-16));
            make.centerY.equalTo(strongSelf.mas_centerY);
        }];
    }
    return self;
}

- (void)setCellModel:(BaseCellModel *)model
{
    self.labelCellModel = (LabelCellModel *)model;
    id objc = [model.data firstObject];
    if ([objc isKindOfClass:[NSURL class]]) {
         self.title.text = [objc lastPathComponent];
    }else if ([objc isKindOfClass:[NSString class]]) {
         self.title.text = objc;
    }
    
    if (self.labelCellModel.isSelected) {
        self.accessoryType = UITableViewCellAccessoryCheckmark;
    }else {
        self.accessoryType = UITableViewCellAccessoryNone;
    }
    if (self.labelCellModel.isCenter) {
        self.title.textAlignment = NSTextAlignmentCenter;
    }else {
        self.title.textAlignment = NSTextAlignmentLeft;
    }
}

- (void)labelAction:(UITapGestureRecognizer *)recognizer
{
    if (self.labelCellModel.labelSelectCallback) {
        self.labelCellModel.labelSelectCallback([IDODemoUtility getCurrentVC], self);
    }
}

@end
