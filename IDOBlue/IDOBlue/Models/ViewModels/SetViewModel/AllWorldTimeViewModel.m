//
//  AllWorldTimeViewModel.m
//  IDOBlue
//
//  Created by huangkunhe on 2021/9/3.
//  Copyright © 2021 hedongyang. All rights reserved.
//

#import "AllWorldTimeViewModel.h"
#import "FuncViewController.h"
#import "EmpltyCellModel.h"
#import "FuncCellModel.h"
#import "LabelCellModel.h"
#import "EmptyTableViewCell.h"
#import "OneButtonTableViewCell.h"
#import "OneLabelTableViewCell.h"
#import "SetWorldTimeViewModel.h"
#import "TextFieldCellModel.h"
#import "OneTextFieldTableViewCell.h"


@interface AllWorldTimeViewModel()
@property (nonatomic,strong) IDOSetV3WorldTimeModel * V3WorldTimeModel;

@property (nonatomic,strong) NSMutableArray<IDOSetV3WorldTimeItemModel *>* items;

@property (nonatomic,copy)void(^labelSelectCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^setbuttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^textFeildDidEditCallback)(UIViewController * viewController,UITextField * textField,UITableViewCell * tableViewCell);
@end

@implementation AllWorldTimeViewModel


- (void)dealloc
{
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getButtonCallback];
        [self getSetButtonCallback];
        [self getLabelCallback];
        [self getDelectCellCallback];
        [self getCellModels];
    }
    return self;
}

- (IDOSetV3WorldTimeModel *)V3WorldTimeModel
{
    if (!_V3WorldTimeModel)
    {
        _V3WorldTimeModel = [IDOSetV3WorldTimeModel currentModel];
    }
    return _V3WorldTimeModel;
}

- (NSMutableArray <IDOSetV3WorldTimeItemModel *>*)items
{
    if (!_items)
    {
        _items = [NSMutableArray new];
        [_items addObjectsFromArray:self.V3WorldTimeModel.items];
    }
    return _items;
}


- (void)getButtonCallback
{
    if (self.items.count > 10 ) {
        FuncViewController * funcVC = (FuncViewController *)[IDODemoUtility getCurrentVC];
        [funcVC showToastWithText:lang(@"can not more than 10 time")];
    }
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVc = (FuncViewController *)viewController;
        FuncViewController * newFuncVc = [FuncViewController new];
        SetWorldTimeViewModel * setModel = [SetWorldTimeViewModel new];
        setModel.timeItemModel = nil;
        void(^addWorldTimeComplete)(BOOL isSuccess,IDOSetV3WorldTimeItemModel * itemModel) =^(BOOL isSuccess,IDOSetV3WorldTimeItemModel * itemModel) {
            if (isSuccess) {
                [strongSelf.items addObject:itemModel];
                [strongSelf getCellModels];
                [funcVc reloadData];
            }
        };
        setModel.addWorldTimeComplete = addWorldTimeComplete;
        newFuncVc.model = setModel;
        newFuncVc.title = lang(@"add world time");
        [viewController.navigationController pushViewController:newFuncVc animated:YES];
    };
}

- (void)getSetButtonCallback
{
    if (self.items.count < 0 ) {
        FuncViewController * funcVC = (FuncViewController *)[IDODemoUtility getCurrentVC];
        [funcVC showToastWithText:lang(@"please add world time")];
    }
    __weak typeof(self) weakSelf = self;
    self.setbuttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        [funcVC showLoadingWithMessage:[NSString stringWithFormat:@"%@...",lang(@"setup")]];
        strongSelf.V3WorldTimeModel.items = [strongSelf.items copy];
        strongSelf.V3WorldTimeModel.itemsNum = strongSelf.items.count;
        [IDOFoundationCommand setWorldTimeCommand:strongSelf.V3WorldTimeModel
                                           callback:^(int errorCode) {
            if(errorCode == 0) {
                [funcVC showToastWithText:lang(@"setup success")];
            }else if (errorCode == 6) {
                [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
            }else {
                [funcVC showToastWithText:lang(@"setup failed")];
            }
        }];
        
    };
}


- (void)getLabelCallback
{
    __weak typeof(self) weakSelf = self;
    self.labelSelectCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        IDOSetV3WorldTimeItemModel * itemModel  = [strongSelf.items objectAtIndex:indexPath.row];
        FuncViewController * newFuncVc = [FuncViewController new];
        SetWorldTimeViewModel *setViewModel = [SetWorldTimeViewModel new];
        setViewModel.timeItemModel = itemModel;
        void(^addWorldTimeComplete)(BOOL isSuccess,IDOSetV3WorldTimeItemModel * itemModel) =^(BOOL isSuccess,IDOSetV3WorldTimeItemModel * itemModel) {
            if (isSuccess) {
                [strongSelf getCellModels];
                [funcVC reloadData];
            }
        };
        setViewModel.addWorldTimeComplete  = addWorldTimeComplete;
        newFuncVc.model = setViewModel;
        [viewController.navigationController pushViewController:newFuncVc animated:YES];
    };
}

- (void)getTextFeildDidEditCallback {
    
    __weak typeof(self) weakSelf = self;
    self.textFeildDidEditCallback = ^(UIViewController *viewController, UITextField *textField, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        strongSelf.V3WorldTimeModel.worldVersion = [textField.text integerValue];
        TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
        textFieldModel.data = @[@(strongSelf.V3WorldTimeModel.worldVersion)];

    };
}



- (void)getDelectCellCallback
{
    __weak typeof(self) weakSelf = self;
    self.delectCellCallback = ^(UIViewController *viewController, NSIndexPath *indexPath) {
          __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        IDOSetV3WorldTimeItemModel * itemModel  = [strongSelf.items objectAtIndex:indexPath.row];
        [strongSelf.items removeObject:itemModel];
        [strongSelf getCellModels];
        [funcVC reloadData];

    };
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    int index = 0;
    for (IDOSetV3WorldTimeItemModel * item in self.items) {
        
            LabelCellModel * model = [[LabelCellModel alloc]init];
            model.typeStr = @"oneLabel";
            NSString * cityStr = [NSString stringWithFormat:@"%ld : %@",(long)item.cityId,item.cityName];
            model.data = @[cityStr];
            model.cellHeight = 40.0f;
            model.cellClass  = [OneLabelTableViewCell class];
            model.modelClass = [NSNull class];
            model.labelSelectCallback = self.labelSelectCallback;
            model.index = index;
            model.isShowLine = YES;
            model.isDelete   = YES;
            [cellModels addObject:model];
        
        index ++;
    }
    
    if (cellModels.count > 0) {
        EmpltyCellModel * model = [[EmpltyCellModel alloc]init];
        model.typeStr = @"empty";
        model.cellHeight = 30.0f;
        model.isShowLine = YES;
        model.cellClass  = [EmptyTableViewCell class];
        [cellModels addObject:model];
    }
    FuncCellModel * model1 = [[FuncCellModel alloc]init];
    model1.typeStr = @"oneButton";
    model1.data    = @[lang(@"add world time")];
    model1.cellHeight = 70.0f;
    model1.cellClass = [OneButtonTableViewCell class];
    model1.modelClass = [NSNull class];
    model1.isShowLine = YES;
    model1.buttconCallback = self.buttconCallback;
    [cellModels addObject:model1];
    self.cellModels = cellModels;
    
    TextFieldCellModel * model100 = [[TextFieldCellModel alloc]init];
    model100.typeStr = @"oneTextField";
    model100.titleStr = lang(@"version num");
    model100.data = @[@(self.V3WorldTimeModel.worldVersion)];
    model100.cellHeight = 70.0f;
    model100.cellClass = [OneTextFieldTableViewCell class];
    model100.modelClass = [NSNull class];
    model100.isShowLine = YES;
    model100.isShowKeyboard = YES;
    model100.keyType = UIKeyboardTypeNumberPad;
    model100.textFeildDidEditCallback = self.textFeildDidEditCallback;
    [cellModels addObject:model100];
    
    FuncCellModel * model101 = [[FuncCellModel alloc]init];
    model101.typeStr = @"oneButton";
    model101.data = @[@"setup"];
    model101.cellHeight = 70.0f;
    model101.cellClass = [OneButtonTableViewCell class];
    model101.modelClass = [NSNull class];
    model101.isShowLine = YES;
    model101.buttconCallback = self.setbuttconCallback;
    [cellModels addObject:model101];
}


@end
