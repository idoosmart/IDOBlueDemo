//
//  QuerySportsViewModel.m
//  IDOBlue
//
//  Created by hedongyang on 2018/10/13.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "QuerySportsViewModel.h"
#import "FuncCellModel.h"
#import "FuncViewController.h"
#import "OneButtonTableViewCell.h"
#import "QueryDataDetailViewModel.h"
#import "NSObject+ModelToDic.h"

@interface QuerySportsViewModel()
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,strong) NSArray * buttonTitles;
@property (nonatomic,strong) NSArray * modelClasss;
@end

@implementation QuerySportsViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getButtonCallback];
        [self getCellModels];
    }
    return self;
}

- (NSArray *)buttonTitles
{
    if (!_buttonTitles) {
        _buttonTitles = @[@[lang(@"one year query")],@[lang(@"one month query")],@[lang(@"one week query")],@[lang(@"one day query")],@[lang(@"all data query")]];
    }
    return _buttonTitles;
}

- (NSArray *)modelClasss
{
    if (!_modelClasss) {
        _modelClasss = @[[QueryDataDetailViewModel class],[QueryDataDetailViewModel class],[QueryDataDetailViewModel class],
                         [QueryDataDetailViewModel class],[QueryDataDetailViewModel class],[QueryDataDetailViewModel class]];
    }
    return _modelClasss;
}


- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    for (int i = 0; i < self.buttonTitles.count; i++) {
        NSArray * data = [self.buttonTitles objectAtIndex:i];
        FuncCellModel * model = [[FuncCellModel alloc]init];
        model.typeStr = @"oneButton";
        model.data    = data;
        model.cellHeight = 70.0f;
        model.cellClass  = [OneButtonTableViewCell class];
        model.modelClass = self.modelClasss[i];
        model.buttconCallback = self.buttconCallback;
        [cellModels addObject:model];
    }
    self.cellModels = cellModels;
}

- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVc = (FuncViewController *)viewController;
        NSIndexPath * indexPath   = [funcVc.tableView indexPathForCell:tableViewCell];
        BaseCellModel * model = [strongSelf.cellModels objectAtIndex:indexPath.row];
        if ([NSStringFromClass(model.modelClass)isEqualToString:@"NSNull"])return;
        FuncViewController * newFuncVc = [FuncViewController new];
        QueryDataDetailViewModel * detailModel = [model.modelClass new];
        detailModel.timeType = indexPath.row;
        detailModel.dataType = 0;
        newFuncVc.model = detailModel;
        newFuncVc.title = [model.data firstObject];
        [funcVc.navigationController pushViewController:newFuncVc animated:YES];
    };
}

@end
