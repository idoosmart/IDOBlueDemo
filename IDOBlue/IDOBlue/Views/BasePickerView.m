//
//  BasePickerView.m
//  SDKDemo
//
//  Created by apple on 2018/6/18.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "BasePickerView.h"
#import "IDODemoUtility.h"
#import "Masonry.h"

@interface BasePickerView()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic,strong) UIView * coverView;
@end

@implementation BasePickerView

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
        self.backgroundColor = [UIColor whiteColor];
        self.delegate = self;
        self.dataSource = self;
        self.hidden = YES;
    }
    return self;
}

- (void)setPickerArray:(NSArray *)pickerArray
{
    _pickerArray = pickerArray;
    [self reloadAllComponents];
}

- (void)setCurrentIndex:(NSInteger)currentIndex
{
    _currentIndex = currentIndex;
    [self selectRow:_currentIndex inComponent:0 animated:YES];
}

- (void)show
{
    self.coverView.hidden = YES;
    self.hidden = NO;
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.25f animations:^{
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(strongSelf.superview.mas_bottom).offset(-216);
        }];
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
        UIGestureRecognizer * recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                                  action:@selector(hiddenPickView:)];
        [_coverView addGestureRecognizer:recognizer];
        [self.superview addSubview:_coverView];
        [_coverView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.right.equalTo(@0);
            make.top.equalTo(@0);
            make.bottom.equalTo(self.mas_bottom).offset(-216);
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

#pragma mark ==== UIPickerViewDataSource ====
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _pickerArray.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30.0f;
}

#pragma mark ==== UIPickerViewDelegate ====
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    id text = _pickerArray[row];
    if ([text isKindOfClass:[NSNumber class]]) {
        return [NSString stringWithFormat:@"%d",[_pickerArray[row] intValue]];
    }else if ([text isKindOfClass:[NSString class]]) {
        return _pickerArray[row];
    }
    return [NSString stringWithFormat:@"%d",[_pickerArray[row] intValue]];
}

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component {
    
    id text = _pickerArray[row];
    NSString * selectStr = @"";
    if ([text isKindOfClass:[NSNumber class]]) {
        selectStr = [NSString stringWithFormat:@"%d",[_pickerArray[row] intValue]];
    }else if ([text isKindOfClass:[NSString class]]) {
        selectStr = _pickerArray[row];
    }
    if (_pickerViewCallback) {
        _pickerViewCallback(selectStr);
    }
}



@end
