//
//  FuncTableView.m
//  IDOBluetoothDemo
//
//  Created by apple on 2018/9/15.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "FuncTableView.h"
#import "IDODemoUtility.h"
#import "BaseCellModel.h"
#import "LabelCellModel.h"
#import "BaseTableViewCell.h"
#import "UITableView+cellSeparator.h"

@interface FuncTableView()<UITableViewDelegate,UITableViewDataSource>
@end

@implementation FuncTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.tableFooterView = [UIView new];
    }
    return self;
}

- (void)setModel:(BaseViewModel *)model
{
    _model = model;
    [self addRegisterClasss:_model];
}

- (void)addRegisterClasss:(BaseViewModel *)model
{
    NSMutableArray * newCellClasss = [NSMutableArray array];
    for (BaseCellModel * cellModel in model.cellModels) {
        if (![newCellClasss containsObject:cellModel.cellClass]) {
            [newCellClasss addObject:cellModel.cellClass];
        }
        if (!cellModel.isShowLine) {
            self.separatorStyle = UITableViewCellSeparatorStyleNone;
        }else {
            self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        }
    }
    for (Class class in newCellClasss) {
         [self registerClass:class forCellReuseIdentifier:NSStringFromClass(class)];
    }
}

#pragma mark- ****************** UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_model.is2dArray) {
        return _model.cellModels.count;
    }else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_model.is2dArray) {
        return [ [_model.cellModels objectAtIndex:section] count];
    }else {
        return _model.cellModels.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseCellModel * cellModel = nil;
    if (_model.is2dArray) {
        cellModel = _model.cellModels[indexPath.section][indexPath.row];
    }else {
        cellModel = _model.cellModels[indexPath.row];
    }
    BaseTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(cellModel.cellClass)
                                                               forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (cellModel.isShowLine) {
        [tableView separatorInsetsZero:cell];
    }
    
    [cell setCellModel:cellModel];
    return cell;
}

#pragma mark- ****************** UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseCellModel * cellModel = nil;
    if (_model.is2dArray) {
        cellModel = _model.cellModels[indexPath.section][indexPath.row];
    }else {
        cellModel = _model.cellModels[indexPath.row];
    }
    return cellModel.cellHeight;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseCellModel * cellModel = nil;
    if (_model.is2dArray) {
        cellModel = _model.cellModels[indexPath.section][indexPath.row];
    }else {
        cellModel = _model.cellModels[indexPath.row];
    }
    return cellModel.isDelete;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (_model.delectCellCallback) {
            _model.delectCellCallback([IDODemoUtility getCurrentVC], indexPath);
        }
     }
}
        
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self endEditing:YES];
}

@end