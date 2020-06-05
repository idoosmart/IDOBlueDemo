//
//  BaseDatePickerView.m
//  SDKDemo
//
//  Created by hedongyang on 2018/6/20.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "BaseDatePickerView.h"
#import "IDODemoUtility.h"

@interface BaseDatePickerView()
@property (nonatomic,strong) UIView * coverView;
@end

@implementation BaseDatePickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView * lineView = [[UIView alloc]init];
        lineView.backgroundColor = [IDODemoUtility colorWithHexString:@"#8c8c8c"];
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.right.equalTo(@0);
            make.height.equalTo(@0.5);
            make.top.equalTo(@0);
        }];
        self.datePickerMode = UIDatePickerModeDate;
        self.maximumDate = [NSDate date];
        self.backgroundColor = [UIColor whiteColor];
        NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat = @"yyyy-MM-dd";
        NSDate * date =  [formatter dateFromString:@"1993-01-01"];
        self.date =  date;
        self.hidden = YES;
        [self addTarget:self action:@selector(selectDate:) forControlEvents:UIControlEventValueChanged];
    }
    return self;
}

- (void)selectDate:(UIDatePicker *)picker
{
    if (_datePickerViewCallback) {
        NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat = @"yyyy-MM-dd";
        NSString * dateStr = [formatter stringFromDate:picker.date];
        NSArray * dateArray = [dateStr componentsSeparatedByString:@"-"]?:@[];
        _datePickerViewCallback(dateArray);
    }
}

- (void)setCurrentDateStr:(NSString *)currentDateStr
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSDate * date =  [formatter dateFromString:currentDateStr];
    self.date =  date;
}

- (void)show
{
    self.coverView.hidden = YES;
    self.hidden = NO;
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.superview.mas_bottom).offset(-216);
    }];
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.25f animations:^{
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf setNeedsLayout];
    } completion:^(BOOL finished) {
        __strong typeof(self) strongSelf = weakSelf;
        strongSelf.coverView.hidden = NO;
    }];
}

- (UIView *)coverView
{
    if (!_coverView) {
        _coverView = [[UIView alloc]init];
        _coverView.backgroundColor = [UIColor clearColor];
        _coverView.userInteractionEnabled = YES;
        UIGestureRecognizer * recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenPickView:)];
        [_coverView addGestureRecognizer:recognizer];
        [self.superview addSubview:_coverView];
        __weak typeof(self) weakSelf = self;
        [_coverView mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong typeof(self) strongSelf = weakSelf;
            make.left.equalTo(@0);
            make.right.equalTo(@0);
            make.top.equalTo(@0);
            make.bottom.equalTo(strongSelf.mas_bottom).offset(-216);
        }];
    }
    return _coverView;
}

- (void)hiddenPickView:(UITapGestureRecognizer *)recognizer
{
    UITableView * tableView = [self getSuperScrollView];
    if (tableView) {
        [tableView setContentInset:UIEdgeInsetsZero];
    }
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.superview.mas_bottom);
    }];
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.25f animations:^{
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf setNeedsLayout];
    } completion:^(BOOL finished) {
        __strong typeof(self) strongSelf = weakSelf;
        strongSelf.hidden = YES;
        strongSelf.coverView.hidden = YES;
    }];
}

- (UITableView *)getSuperScrollView
{
    for (UIView * view in self.superview.subviews) {
        if ([view isKindOfClass:[UITableView class]]) {
            return (UITableView *)view;
        }
    }
    return nil;
}

@end
