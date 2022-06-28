//
//  SetSportModeSortViewModel.m
//  IDOBlue
//
//  Created by 何东阳 on 2019/3/27.
//  Copyright © 2019年 hedongyang. All rights reserved.
//

#import "SetSportModeSortViewModel.h"
#import "EmpltyCellModel.h"
#import "EmptyTableViewCell.h"
#import "FuncCellModel.h"
#import "OneButtonTableViewCell.h"
#import "LabelCellModel.h"
#import "OneLabelTableViewCell.h"
#import "FuncViewController.h"

@interface SetSportModeSortViewModel()
@property (nonatomic,strong) NSMutableArray * allSportModes;
@property (nonatomic,strong) NSMutableArray * noSelectSportModes;
@property (nonatomic,strong) NSMutableArray * selectSportModes;
@property (nonatomic,strong) IDOSetSportSortingInfoBluetoothModel * sportModeSortModel;
@property (nonatomic,copy)void(^labelSelectCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation SetSportModeSortViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.rightButtonTitle = lang(@"edit");
        self.footButtonTitle  = lang(@"set sports mode sort");
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
        [self setSportModeSortWithVc:funcVc];
    }
}

- (void)setSportModeSortWithVc:(FuncViewController *)funcVc
{
    [funcVc showLoadingWithMessage:[NSString stringWithFormat:@"%@...",lang(@"set sports mode sort")]];
    [IDOFoundationCommand setSportModeSortCommand:self.sportModeSortModel
                                         callback:^(int errorCode) {
         if(errorCode == 0) {
             [funcVc showToastWithText:lang(@"set sports mode sort success")];
         }else if (errorCode == 6) {
             [funcVc showToastWithText:lang(@"feature is not supported on the current device")];
         }else {
             [funcVc showToastWithText:lang(@"set sports mode sort failed")];
         }
    }];
}

- (void)getMoveRowCallback
{
        __weak typeof(self) weakself = self;
    self.moveRowCellCallback = ^(UIViewController *viewController, NSIndexPath *sourceIndexPath, NSIndexPath *destinationIndexPath) {
        __strong typeof(self) strongself = weakself;
        if (destinationIndexPath.row >= strongself.selectSportModes.count) { //超过编辑范围
            FuncViewController * funcVc = (FuncViewController *)viewController;
            [funcVc.tableView setEditing:NO animated:YES];
            funcVc.navigationItem.rightBarButtonItem.title = lang(@"edit");
            [funcVc.tableView reloadData];
            return;
        }
        NSMutableDictionary * dic1 = [NSMutableDictionary dictionaryWithDictionary:[strongself.selectSportModes objectAtIndex:sourceIndexPath.row]];
        [dic1 setValue:@(destinationIndexPath.row + 1) forKey:@"index"];
        
        if (destinationIndexPath.row - sourceIndexPath.row > 0) { //往下拖移
            for (NSInteger i = sourceIndexPath.row; i < destinationIndexPath.row; i++) {
                NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:[strongself.selectSportModes objectAtIndex:i + 1]];
                [dic setValue:@(i + 1) forKey:@"index"];
                [strongself.selectSportModes replaceObjectAtIndex:i withObject:dic];
            }
        }else if (destinationIndexPath.row - sourceIndexPath.row < 0) { //往上拖移
            for (NSInteger i = sourceIndexPath.row; i > destinationIndexPath.row; i--) {
                NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:[strongself.selectSportModes objectAtIndex:i - 1]];
                [dic setValue:@(i + 1) forKey:@"index"];
                [strongself.selectSportModes replaceObjectAtIndex:i withObject:dic];
            }
        }
        
        [strongself.selectSportModes replaceObjectAtIndex:destinationIndexPath.row withObject:dic1];
        NSMutableArray * items = [NSMutableArray array];
        for (NSDictionary * dic in strongself.selectSportModes) {
            IDOSetSportSortingItemModel * item = [IDOSetSportSortingItemModel new];
            item.index = [[dic valueForKey:@"index"] integerValue];
            item.type  = [[dic valueForKey:@"type"] integerValue];
            [items addObject:item];
        }
        strongself.sportModeSortModel.sportSortingItems = items;
    };
}

- (void)getDelectCallback
{
    __weak typeof(self) weakSelf = self;
    self.delectCellCallback = ^(UIViewController *viewController, NSIndexPath *indexPath) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSMutableArray * sportItems = [NSMutableArray arrayWithArray:strongSelf.sportModeSortModel.sportSortingItems];
        [sportItems removeObjectAtIndex:indexPath.row];
        strongSelf.sportModeSortModel.sportSortingItems = sportItems;
        [strongSelf getCellModels];
        [funcVC reloadData];
        [strongSelf setSportModeSortWithVc:funcVC];
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
        NSDictionary * dic = strongSelf.noSelectSportModes[labelModel.index];
        NSMutableArray * sportItems = [NSMutableArray arrayWithArray:strongSelf.sportModeSortModel.sportSortingItems];
        IDOSetSportSortingItemModel * item = [IDOSetSportSortingItemModel new];
        item.index = sportItems.count + 1;
        item.type  = [[dic valueForKey:@"type"] integerValue];
        if (__IDO_FUNCTABLE__.funcTable28Model.v3SportsType) {
          if (sportItems.count >= 30) {
             [funcVC showToastWithText:lang(@"fourteen motion sequences have been set")];
             return;
          }
        }else if (__IDO_FUNCTABLE__.funcTable37Model.set100SportSort) {
            
        }else {
          if (sportItems.count >= 8) {
              [funcVC showToastWithText:lang(@"eight motion sequences have been set")];
              return;
          }
        }
        [sportItems addObject:item];
        NSInteger index = 1;
        for (IDOSetSportSortingItemModel * item1 in sportItems) {
            item1.index = index;
            index++;
        }
        strongSelf.sportModeSortModel.sportSortingItems = sportItems;
        [strongSelf getCellModels];
        [funcVC reloadData];
    };
}

- (NSInteger)getIndexOfSportType:(NSInteger)type
{
    NSInteger index = 0;
    if (type <= 75) {
        if (type <= 29) {
            index = type - 1;
        }else if (type >= 31 && type <= 38) {
            index = type - 3;
        }else if (type >= 48 && type <= 58) {
            index = type - 12;
        }else {
            index = 47;
        }
    }else if (type >= 100 && type < 110) {
        index = 48 + (type - 100);
    }else if (type >= 110 && type <= 141) {
        if (type == 110) {
            index = 53 + (type - 110);
        }else if (type == 112) {
            index = 53 + (type - 111);
        }else {
            index = 53 + (type - 112);
        }
    }else if (type >= 152 && type <= 160) {
        index = 83 + (type - 152);
    }else if (type >= 161 && type <= 169) {
        index = 92 + (type - 161);
    }else if (type >= 170 && type <= 179) {
        index = 101 + (type - 170);
    }else if (type >= 180 && type <= 184) {
        index = 111 + (type - 180);
    }else if (type == 193) {
        index = 116;
    }else if (type == 194) {
        index = 117;
    }
    return index;
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    [self getSortSportModes];
    int i = 0;
    for (NSDictionary * dic in self.selectSportModes) {
        NSString * sportName = lang(@"other activity");
        NSInteger type = [[dic valueForKey:@"type"] integerValue];
        NSInteger index = [self getIndexOfSportType:type];
        sportName = self.pickerDataModel.sportSortTitleArray[index];
        LabelCellModel * model = [[LabelCellModel alloc]init];
        model.typeStr = @"oneLabel";
        model.data = @[sportName];
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
    for (NSDictionary * dic in self.noSelectSportModes) {
        NSString * sportName = lang(@"other activity");
        NSInteger type = [[dic valueForKey:@"type"] integerValue];
        NSInteger index = [self getIndexOfSportType:type];
        sportName = self.pickerDataModel.sportSortTitleArray[index];
        LabelCellModel * model = [[LabelCellModel alloc]init];
        model.typeStr = @"oneLabel";
        model.data = @[sportName];
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

- (IDOSetSportSortingInfoBluetoothModel *)sportModeSortModel
{
    if (!_sportModeSortModel) {
        _sportModeSortModel = [IDOSetSportSortingInfoBluetoothModel currentModel];
    }
    return _sportModeSortModel;
}

- (NSMutableArray *)allSportModes
{
    if (!_allSportModes) {
        _allSportModes = [NSMutableArray array];
        for (int i = 1; i <= 75; i++) {
            if (i <= 29 || (i >= 48 && i <= 58) || i == 75 || (i >= 31 && i <= 38)) {
                [_allSportModes addObject:@{@"type":@(i),@"isSelected":@(0),@"index":@(0)}];
            }
        }
        for (int i = 0; i < 5; i++) {
            [_allSportModes addObject:@{@"type":@(i + 100),@"isSelected":@(0),@"index":@(0)}];
        }
        for (int i = 0; i < 20; i++) {
            if (i == 1 || i == 3) {
                continue;
            }
            [_allSportModes addObject:@{@"type":@(i + 110),@"isSelected":@(0),@"index":@(0)}];
        }
        for (int i = 1; i <= 11; i++) {
            [_allSportModes addObject:@{@"type":@(i + 130),@"isSelected":@(0),@"index":@(0)}];
        }
        for (int i = 2; i <= 10; i++) {
            [_allSportModes addObject:@{@"type":@(i + 150),@"isSelected":@(0),@"index":@(0)}];
        }
        for (int i = 1; i <= 9; i++) {
            [_allSportModes addObject:@{@"type":@(i + 160),@"isSelected":@(0),@"index":@(0)}];
        }
        for (int i = 0; i < 10; i++) {
            [_allSportModes addObject:@{@"type":@(i + 170),@"isSelected":@(0),@"index":@(0)}];
        }
        for (int i = 0; i < 5; i++) {
            [_allSportModes addObject:@{@"type":@(i + 180),@"isSelected":@(0),@"index":@(0)}];
        }
        [_allSportModes addObject:@{@"type":@(193),@"isSelected":@(0),@"index":@(0)}];
        [_allSportModes addObject:@{@"type":@(194),@"isSelected":@(0),@"index":@(0)}];
    }
    return _allSportModes;
}

- (NSMutableArray *)noSelectSportModes
{
    if (!_noSelectSportModes) {
        _noSelectSportModes = [NSMutableArray array];
    }
    return _noSelectSportModes;
}

- (NSMutableArray *)selectSportModes
{
    if (!_selectSportModes) {
        _selectSportModes = [NSMutableArray array];
    }
    return _selectSportModes;
}

- (void)getSortSportModes
{
    [self.selectSportModes removeAllObjects];
    [self.noSelectSportModes removeAllObjects];
    for (NSDictionary * dic in self.allSportModes) {
        NSInteger type  = [[dic valueForKey:@"type"] integerValue];
        IDOSetSportSortingItemModel * model = [self getCurrentSportModeItemWithType:type];
        if (model) {
            [self.selectSportModes addObject:@{@"type":@(model.type),@"isSelected":@(1),@"index":@(model.index)}];
        }else {
            [self.noSelectSportModes addObject:@{@"type":@(type),@"isSelected":@(0),@"index":@(0)}];
        }
    }
    [self sortSportModels:self.selectSportModes];
}

- (IDOSetSportSortingItemModel *)getCurrentSportModeItemWithType:(NSInteger)type
{
    for (IDOSetSportSortingItemModel * model in self.sportModeSortModel.sportSortingItems) {
        if (model.type == type) {
            return model;
        }
    }
    return nil;
}

- (void)sortSportModels:(NSMutableArray *)models
{
    if (models.count == 0) return;
    NSSortDescriptor * sort = [NSSortDescriptor sortDescriptorWithKey:@"index" ascending:YES];
    NSArray * otherModels = [models sortedArrayUsingDescriptors:@[sort]];
    [models removeAllObjects];
    [models addObjectsFromArray:otherModels];
}

@end
