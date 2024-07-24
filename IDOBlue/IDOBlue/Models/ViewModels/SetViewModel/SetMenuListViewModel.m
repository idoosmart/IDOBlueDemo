//
//  SetMenuListViewModel.m
//  IDOBlue
//
//  Created by hedongyang on 2020/4/17.
//  Copyright © 2020 hedongyang. All rights reserved.
//

#import "SetMenuListViewModel.h"
#import "EmpltyCellModel.h"
#import "EmptyTableViewCell.h"
#import "FuncCellModel.h"
#import "OneButtonTableViewCell.h"
#import "LabelCellModel.h"
#import "OneLabelTableViewCell.h"
#import "FuncViewController.h"

@interface SetMenuListViewModel()
@property (nonatomic,strong) NSMutableArray * allMenuLists;
@property (nonatomic,strong) NSMutableArray * noSelectMenuLists;
@property (nonatomic,strong) NSMutableArray * selectMenuLists;
@property (nonatomic,strong) IDOGetMenuListInfoBluetoothModel * getMenuListModel;
@property (nonatomic,copy)void(^labelSelectCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation SetMenuListViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.rightButtonTitle = lang(@"edit");
        self.footButtonTitle  = lang(@"set menu list");
        self.isRightButton = YES;
        self.rightButton   = @selector(actionButton:);
        [self getMoveRowCallback];
        [self getDelectCallback];
        [self getLabelCallback];
        [self getCellModels];
    }
    return self;
}

- (void)actionButton:(UIBarButtonItem *)sender
{
    if (self.cellModels.count == 0)return;
    FuncViewController * funcVc = (FuncViewController *)[IDODemoUtility getCurrentVC];
    BOOL isEditing =  !funcVc.tableView.isEditing;
    sender.title = isEditing ? lang(@"complete") : lang(@"edit");
    [funcVc.tableView setEditing:isEditing animated:YES];
    if (!isEditing) {
        [self setMenuListWithVc:funcVc];
    }
}

- (void)setMenuListWithVc:(FuncViewController *)funcVc
{
    [funcVc showLoadingWithMessage:[NSString stringWithFormat:@"%@...",lang(@"set menu list")]];
    [IDOFoundationCommand setMenuListCommand:self.getMenuListModel callback:^(int errorCode) {
        if(errorCode == 0) {
            [funcVc showToastWithText:lang(@"set menu list success")];
        }else if (errorCode == 6) {
            [funcVc showToastWithText:lang(@"feature is not supported on the current device")];
        }else {
            [funcVc showToastWithText:lang(@"set menu list failed")];
        }
    }];
}

- (void)getMoveRowCallback
{
        __weak typeof(self) weakself = self;
    self.moveRowCellCallback = ^(UIViewController *viewController, NSIndexPath *sourceIndexPath, NSIndexPath *destinationIndexPath) {
        __strong typeof(self) strongself = weakself;
        if (destinationIndexPath.row >= strongself.selectMenuLists.count) { //超过编辑范围
            FuncViewController * funcVc = (FuncViewController *)viewController;
            [funcVc.tableView setEditing:NO animated:YES];
            funcVc.navigationItem.rightBarButtonItem.title = lang(@"edit");
            [funcVc.tableView reloadData];
            return;
        }
        NSMutableDictionary * dic1 = [NSMutableDictionary dictionaryWithDictionary:[strongself.selectMenuLists objectAtIndex:sourceIndexPath.row]];
        [dic1 setValue:@(destinationIndexPath.row + 1) forKey:@"index"];
        
        if (destinationIndexPath.row - sourceIndexPath.row > 0) { //往下拖移
            for (NSInteger i = sourceIndexPath.row; i < destinationIndexPath.row; i++) {
                NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:[strongself.selectMenuLists objectAtIndex:i + 1]];
                [dic setValue:@(i + 1) forKey:@"index"];
                [strongself.selectMenuLists replaceObjectAtIndex:i withObject:dic];
            }
        }else if (destinationIndexPath.row - sourceIndexPath.row < 0) { //往上拖移
            for (NSInteger i = sourceIndexPath.row; i > destinationIndexPath.row; i--) {
                NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:[strongself.selectMenuLists objectAtIndex:i - 1]];
                [dic setValue:@(i + 1) forKey:@"index"];
                [strongself.selectMenuLists replaceObjectAtIndex:i withObject:dic];
            }
        }
        
        [strongself.selectMenuLists replaceObjectAtIndex:destinationIndexPath.row withObject:dic1];
        NSMutableArray * items = [NSMutableArray array];
        for (NSDictionary * dic in strongself.selectMenuLists) {
            NSInteger type  = [[dic valueForKey:@"type"] integerValue];
            [items addObject:@(type)];
        }
        strongself.getMenuListModel.itemList = items;
    };
}

- (void)getDelectCallback
{
    __weak typeof(self) weakSelf = self;
    self.delectCellCallback = ^(UIViewController *viewController, NSIndexPath *indexPath) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSMutableArray * menuItems = [NSMutableArray arrayWithArray:strongSelf.getMenuListModel.itemList];
        [menuItems removeObjectAtIndex:indexPath.row];
        strongSelf.getMenuListModel.itemList = menuItems;
        [strongSelf getCellModels];
        [funcVC reloadData];
        [strongSelf setMenuListWithVc:funcVC];
    };
}

- (void)getLabelCallback
{
    __weak typeof(self) weakSelf = self;
    self.labelSelectCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        [funcVC.tableView setEditing:YES animated:YES];
        funcVC.navigationItem.rightBarButtonItem.title = lang(@"complete");
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        LabelCellModel * labelModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
        NSDictionary * dic = strongSelf.noSelectMenuLists[labelModel.index];
        NSArray * itemList = strongSelf.getMenuListModel.itemList;
        NSMutableArray * menuItems = [NSMutableArray arrayWithArray:itemList];
        NSInteger type  = [[dic valueForKey:@"type"] integerValue];
        [menuItems addObject:@(type)];
        strongSelf.getMenuListModel.itemList = menuItems;
        [strongSelf getCellModels];
        [funcVC reloadData];
    };
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    [self getSortMenuList];
    int i = 0;
    for (NSDictionary * dic in self.selectMenuLists) {
        NSInteger type = [[dic valueForKey:@"type"] integerValue] - 1;
        NSString * menuName = self.pickerDataModel.menuListTypes[type];
        LabelCellModel * model = [[LabelCellModel alloc]init];
        model.typeStr = @"oneLabel";
        model.data = @[menuName];
        model.cellHeight = 60.0f;
        model.cellClass = [OneLabelTableViewCell class];
        model.modelClass = [NSNull class];
        model.isShowLine = YES;
        model.isMoveRow  = YES;
        model.isDelete   = YES;
        model.index = i;
        [cellModels addObject:model];
        i++;
    }
    
    if (cellModels.count > 0) {
        EmpltyCellModel * model2 = [[EmpltyCellModel alloc]init];
        model2.typeStr = @"empty";
        model2.cellHeight = 30.0f;
        model2.isShowLine = YES;
        model2.cellClass  = [EmptyTableViewCell class];
        [cellModels addObject:model2];
    }
    
    i = 0;
    for (NSDictionary * dic in self.noSelectMenuLists) {
        NSInteger type = [[dic valueForKey:@"type"] integerValue] - 1;
        NSString * menuName = self.pickerDataModel.menuListTypes[type];
        LabelCellModel * model = [[LabelCellModel alloc]init];
        model.typeStr = @"oneLabel";
        model.data = @[menuName];
        model.cellHeight = 60.0f;
        model.cellClass = [OneLabelTableViewCell class];
        model.modelClass = [NSNull class];
        model.isShowLine = YES;
        model.index = i;
        model.labelSelectCallback = self.labelSelectCallback;
        [cellModels addObject:model];
        i++;
    }
    self.cellModels = cellModels;
}

- (IDOGetMenuListInfoBluetoothModel *)getMenuListModel
{
    if (!_getMenuListModel) {
        _getMenuListModel = [IDOGetMenuListInfoBluetoothModel currentModel];
    }
    return _getMenuListModel;
}

- (NSMutableArray *)allMenuLists
{
    if (!_allMenuLists) {
        _allMenuLists = [NSMutableArray array];
        for (int i = 1; i <= 20; i++) {
            NSDictionary * dic = @{@"type":@(i),@"isSelected":@(0),@"index":@(0)};
            [_allMenuLists addObject:dic];
        }
    }
    return _allMenuLists;
}

- (NSMutableArray *)noSelectMenuLists
{
    if (!_noSelectMenuLists) {
        _noSelectMenuLists = [NSMutableArray array];
    }
    return _noSelectMenuLists;
}

- (NSMutableArray *)selectMenuLists
{
    if (!_selectMenuLists) {
        _selectMenuLists = [NSMutableArray array];
    }
    return _selectMenuLists;
}

- (void)getSortMenuList
{
    [self.selectMenuLists removeAllObjects];
    [self.noSelectMenuLists removeAllObjects];
    int index = 0;
    for (NSDictionary * dic in self.allMenuLists) {
        NSInteger type  = [[dic valueForKey:@"type"] integerValue];
        BOOL isSlected = [self getSelectStateMenuListWithType:type];
        if (isSlected) {
            [self.selectMenuLists addObject:@{@"type":@(type),@"isSelected":@(1),@"index":@(index)}];
        }else {
            [self.noSelectMenuLists addObject:@{@"type":@(type),@"isSelected":@(0),@"index":@(0)}];
        }
        index ++;
    }
    [self sortSelectMenuList:self.selectMenuLists];
}

- (BOOL)getSelectStateMenuListWithType:(NSInteger)type
{
    for (NSNumber * number in self.getMenuListModel.itemList) {
        if (number.integerValue == type) {
            return YES;
        }
    }
    return NO;
}

- (void)sortSelectMenuList:(NSMutableArray *)menuList
{
    if (menuList.count == 0) return;
    NSSortDescriptor * sort = [NSSortDescriptor sortDescriptorWithKey:@"index" ascending:YES];
    NSArray * others = [menuList sortedArrayUsingDescriptors:@[sort]];
    [menuList removeAllObjects];
    [menuList addObjectsFromArray:others];
}

@end
