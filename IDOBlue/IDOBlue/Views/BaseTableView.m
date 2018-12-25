//
//  BaseTableView.m
//  SDKDemo
//
//  Created by apple on 2018/6/17.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "BaseTableView.h"
#import "TableViewFootView.h"
#import "UITableView+cellSeparator.h"
#import "NSArray+RemoveDuplicate.h"

@interface BaseTableView()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@end

@implementation BaseTableView

- (void)dealloc
{
    if (_model.isTime) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(timeAfter) object:nil];
    }
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

- (void)setModel:(BaseViewControllerModel *)model
{
    _model = model;
    if (_model.isTime) {
        [self performSelector:@selector(timeAfter) withObject:nil afterDelay:0];
    }
    [self addRegisterClasss:_model.cellClassArray];
    [self addFootButton];
    [self reloadData];
}

- (void)addRegisterClasss:(NSArray *)cellClasss
{
    NSMutableArray * newCellClasss = [NSMutableArray array];
    for (id array in cellClasss) {
        if ([array isKindOfClass:[NSArray class]]) {
            [newCellClasss addObjectsFromArray:array];
        }else {
            [newCellClasss addObject:array];
        }
    }
    for (Class class in [newCellClasss arrayRemoveDuplicate]) {
        [self registerClass:class forCellReuseIdentifier:NSStringFromClass(class)];
    }
}

- (void)timeAfter
{
     [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(timeAfter) object:nil];
    if (_model.timeCallback) {
        _model.timeCallback(self);
    }
     [self performSelector:@selector(timeAfter) withObject:nil afterDelay:1];
}

- (void)addFootButton
{
    if(_model.isSetFootButton) {
        TableViewFootView * tableViewFoot = [[TableViewFootView alloc]initWithFrame:CGRectMake(0, 0,self.frame.size.width,80)];
        if (_model.footButtonTitle.length > 0) {
            [tableViewFoot.setButton setTitle:_model.footButtonTitle forState:UIControlStateNormal];
        }
        [tableViewFoot.setButton addTarget:self action:@selector(setButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        self.tableFooterView = tableViewFoot;
    }else {
        self.tableFooterView = [UIView new];
    }
}

#pragma mark- ****************** UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([self is2DArray]) {
        return _model.dataArray.count;
    }else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self is2DArray]) {
        return [[_model.dataArray objectAtIndex:section] count];
    }else {
        return [_model.dataArray count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Class cellClass = nil;
    NSDictionary * dic = nil;
    if ([self is2DArray]) {
        cellClass = _model.cellClassArray[indexPath.section][indexPath.row];
        dic = _model.dataArray[indexPath.section][indexPath.row];
    }else {
        cellClass = _model.cellClassArray[indexPath.row];
        dic = _model.dataArray[indexPath.row];
    }
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(cellClass) forIndexPath:indexPath];
    if (_model.isSelection) {
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    }else {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (_model.isSeparatorZero) {
        [tableView separatorInsetsZero:cell];
    }else {
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    if ([NSStringFromClass([cell class])isEqualToString:@"EmptyTableViewCell"]) {
        return cell;
    }
    if ((_model.isTick || _model.isClick) &&
        [NSStringFromClass([cell class])isEqualToString:@"SelectDefaultTableViewCell"]) {
        if ([self isShowArrow:indexPath]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    NSArray * textFieldArray    = [dic valueForKey:@"textField"];
    NSArray * buttonArray       = [dic valueForKey:@"button"];
    NSArray * switchButtonArray = [dic valueForKey:@"switch"];
    NSArray * textViewArray     = [dic valueForKey:@"textView"];
    
    int textFieldIndex = 0;
    int buttonIndex = 0;
    int switchIndex = 0;
    int textViewIndex = 0;
    
    for (UIView * view in cell.subviews) {
        if ([view isKindOfClass:[UITextField class]]) {
            UITextField * textField = (UITextField *)view;
            textField.delegate = self;
            if (textFieldIndex <= textFieldArray.count -1) {
                id text =  textFieldArray[textFieldIndex];
                if ([text isKindOfClass:[NSNumber class]]) {
                    textField.text = [NSString stringWithFormat:@"%d",[textFieldArray[textFieldIndex] intValue]];
                }else if ([text isKindOfClass:[NSString class]]) {
                    textField.text = textFieldArray[textFieldIndex];
                }
            }
            textFieldIndex ++;
        }if ([view isKindOfClass:[UISwitch class]]) {
            UISwitch * switchButton = (UISwitch *)view;
            if (switchIndex <= switchButtonArray.count - 1) {
                switchButton.on = [switchButtonArray[switchIndex]boolValue];
            }
            switchIndex ++;
            [switchButton addTarget:self action:@selector(switchButton:) forControlEvents:UIControlEventValueChanged];
        }if ([view isKindOfClass:[UILabel class]]) {
            UILabel * titleLabel = (UILabel *)view;
            titleLabel.textAlignment = _model.isTitleCenter ? NSTextAlignmentCenter : NSTextAlignmentLeft;
            titleLabel.text = dic[@"title"];
        }else if ([view isKindOfClass:[UIButton class]]) {
            UIButton * button = (UIButton *)view;
            if (buttonIndex <= buttonArray.count - 1) {
                [button setTitle:buttonArray[buttonIndex] forState:UIControlStateNormal];
            }
            buttonIndex ++;
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        }else if ([view isKindOfClass:[UITextView class]]){
            UITextView * textView = (UITextView *)view;
            if (textViewIndex <= textViewArray.count - 1) {
                [BaseTableView textView:textView messageText:textViewArray[textViewIndex]];
            }
            textViewIndex ++;
        }
    }
    return cell;
}

+ (void)textView:(UITextView *)textView messageText:(NSString *)message
{
    NSString * newStr = [NSString stringWithFormat:@"%@\n%@",textView.text,message];
    textView.text = newStr;
    [textView scrollRangeToVisible:NSMakeRange(textView.text.length, 1)];
}

#pragma mark- ****************** UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [_model cellHeightWithIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    BOOL isSelect = [NSStringFromClass([cell class])isEqualToString:@"SelectDefaultTableViewCell"];
    if (!_model.isClick || !isSelect) return;
    if ([self isAddIndexPath:indexPath]) {
        NSMutableArray * array = [NSMutableArray arrayWithArray:_model.currentIndexPaths];
        [array addObject:indexPath];
        _model.currentIndexPaths = array;
    }
    if (_model.buttconCallback) {
        NSDictionary * dic = nil;
        if ([self is2DArray]) {
            dic = _model.dataArray[indexPath.section][indexPath.row];
        }else {
            dic = _model.dataArray[indexPath.row];
        }
         _model.buttconCallback([self viewController],dic[@"title"],indexPath);
    }
    [tableView reloadData];
}

#pragma mark - ****************** UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSIndexPath * indexPath = [self indexPathForCell:(UITableViewCell *)textField.superview];
    if (_model.textFieldCallback) {
        _model.textFieldCallback([self viewController],textField,indexPath);
    }
    [self tableViewContentInsetWithIndexPath:indexPath];
    return NO;
}

- (void)tableViewContentInsetWithIndexPath:(NSIndexPath *)indexPath
{
    CGRect rectInTableView = [self rectForRowAtIndexPath:indexPath];
    CGRect rect = [self convertRect:rectInTableView toView:[self viewController].view];
    CGFloat differ = 0.0f;
    if (rect.origin.y + rect.size.height > rectInTableView.origin.y + rectInTableView.size.height) {
        differ = rect.origin.y + rect.size.height;
    }else {
        differ = rectInTableView.origin.y + rectInTableView.size.height;
    }
    CGFloat keyMinY = [self viewController].view.frame.size.height - 216;
    if (differ > keyMinY) {
        [self setContentInset:UIEdgeInsetsMake(-(differ - keyMinY), 0, 0, 0)];
    }
}

- (void)switchButton:(UISwitch *)sender
{
    NSIndexPath * indexPath = [self indexPathForCell:(UITableViewCell *)sender.superview];
    if (_model.switchCallback) {
        _model.switchCallback(self,indexPath,sender);
    }
}

- (void)buttonAction:(UIButton *)sender
{
    NSIndexPath * indexPath = [self indexPathForCell:(UITableViewCell *)sender.superview];
    if (_model.buttconCallback) {
        _model.buttconCallback([self viewController],sender.titleLabel.text,indexPath);
    }
}

- (void)setButtonAction:(UIButton *)sender
{
    if (_model.setButtconCallback) {
        _model.setButtconCallback([self viewController],self);
    }
}

- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (BOOL)is2DArray
{
    for (id array in _model.cellClassArray) {
        if ([array isKindOfClass:[NSArray class]]) {
            return YES;
        }else {
            return NO;
        }
    }
    return NO;
}

- (BOOL)isShowArrow:(NSIndexPath *)currentIndexPath
{
    for (NSIndexPath * indexPath in _model.currentIndexPaths) {
        if (indexPath.section == currentIndexPath.section
            && indexPath.row == currentIndexPath.row) {
           return YES;
        }
    }
    return NO;
}

- (BOOL)isAddIndexPath:(NSIndexPath *)currentIndexPath
{
    for (NSIndexPath * indexPath in _model.currentIndexPaths) {
        if (indexPath.section == currentIndexPath.section) {
            if (indexPath.row == currentIndexPath.row) {
                return NO;
            }else {
                NSMutableArray * array = [NSMutableArray arrayWithArray:_model.currentIndexPaths];
                [array removeObject:indexPath];
                _model.currentIndexPaths = array;
                return YES;
            }
        }
    }
    return YES;
}

@end
