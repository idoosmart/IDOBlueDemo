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
@property (nonatomic,strong) NSArray * allSportModes;
@property (nonatomic,strong) NSMutableArray * selectSportModes;
@property (nonatomic,strong) IDOSetSportShortcutInfoBluetoothModel * sportShortcutModel;
@property (nonatomic,strong) IDOSetSportSortingInfoBluetoothModel * sportModeSortModel;
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
        NSMutableArray * sportSortModels = [NSMutableArray array];
        for (NSDictionary * dic in self.selectSportModes) {
            NSInteger type  = [[dic valueForKey:@"type"] integerValue];
            NSInteger index = [[dic valueForKey:@"index"] integerValue];
            IDOSetSportSortingItemModel * item = [[IDOSetSportSortingItemModel alloc]init];
            item.index = index;
            item.type  = type;
            [sportSortModels addObject:item];
        }
        self.sportModeSortModel.sportSortingItems = sportSortModels;
        [funcVc showLoadingWithMessage:[NSString stringWithFormat:@"%@...",lang(@"set sports mode sort")]];
        [IDOFoundationCommand setSportModeSortCommand:self.sportModeSortModel
                                             callback:^(int errorCode) {
             if(errorCode == 0) {
                 [funcVc showToastWithText:lang(@"set sports mode sort success")];
             }else {
                 [funcVc showToastWithText:lang(@"set sports mode sort failed")];
             }
         }];
    }
}

- (void)getMoveRowCallback
{
        __weak typeof(self) weakself = self;
    self.moveRowCellCallback = ^(UIViewController *viewController, NSIndexPath *sourceIndexPath, NSIndexPath *destinationIndexPath) {
        __strong typeof(self) strongself = weakself;
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
        [strongself sortSportModels:strongself.selectSportModes];
        NSLog(@"slectsportModels2 == %@\n",strongself.selectSportModes);
    };
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    int i = 0;
    for (NSDictionary * dic in self.selectSportModes) {
        NSInteger type = [[dic valueForKey:@"type"] integerValue] - 1;
        NSString * sportName = self.pickerDataModel.sportTypes[type];
        LabelCellModel * model = [[LabelCellModel alloc]init];
        model.typeStr = @"oneLabel";
        model.data = @[sportName];
        model.cellHeight = 60.0f;
        model.cellClass = [OneLabelTableViewCell class];
        model.modelClass = [NSNull class];
        model.isShowLine = YES;
        model.isMoveRow  = YES;
        model.index = i;
        [cellModels addObject:model];
        i++;
    }
    self.cellModels = cellModels;
}

- (IDOSetSportShortcutInfoBluetoothModel *)sportShortcutModel
{
    if (!_sportShortcutModel) {
        _sportShortcutModel = [IDOSetSportShortcutInfoBluetoothModel currentModel];
    }
    return _sportShortcutModel;
}

- (IDOSetSportSortingInfoBluetoothModel *)sportModeSortModel
{
    if (!_sportModeSortModel) {
        _sportModeSortModel = [IDOSetSportSortingInfoBluetoothModel currentModel];
    }
    return _sportModeSortModel;
}

- (NSArray *)allSportModes
{
    if (!_allSportModes) {
        _allSportModes = @[@{@"type":@(1),@"isSelected":@(self.sportShortcutModel.isWalk),@"index":@(0)},
                           @{@"type":@(2),@"isSelected":@(self.sportShortcutModel.isRun),@"index":@(0)},
                           @{@"type":@(3),@"isSelected":@(self.sportShortcutModel.isByBike),@"index":@(0)},
                           @{@"type":@(4),@"isSelected":@(self.sportShortcutModel.isOnFoot),@"index":@(0)},
                           @{@"type":@(5),@"isSelected":@(self.sportShortcutModel.isSwim),@"index":@(0)},
                           @{@"type":@(6),@"isSelected":@(self.sportShortcutModel.isMountainClimbing),@"index":@(0)},
                           @{@"type":@(7),@"isSelected":@(self.sportShortcutModel.isBadminton),@"index":@(0)},
                           @{@"type":@(8),@"isSelected":@(self.sportShortcutModel.isOther),@"index":@(0)},
                           @{@"type":@(9),@"isSelected":@(self.sportShortcutModel.isFitness),@"index":@(0)},
                           @{@"type":@(10),@"isSelected":@(self.sportShortcutModel.isSpinning),@"index":@(0)},
                           @{@"type":@(11),@"isSelected":@(self.sportShortcutModel.isEllipsoid),@"index":@(0)},
                           @{@"type":@(12),@"isSelected":@(self.sportShortcutModel.isTreadmill),@"index":@(0)},
                           @{@"type":@(13),@"isSelected":@(self.sportShortcutModel.isSitUp),@"index":@(0)},
                           @{@"type":@(14),@"isSelected":@(self.sportShortcutModel.isPushUp),@"index":@(0)},
                           @{@"type":@(15),@"isSelected":@(self.sportShortcutModel.isDumbbell),@"index":@(0)},
                           @{@"type":@(16),@"isSelected":@(self.sportShortcutModel.isWeightlifting),@"index":@(0)},
                           @{@"type":@(17),@"isSelected":@(self.sportShortcutModel.isBodybuildingExercise),@"index":@(0)},
                           @{@"type":@(18),@"isSelected":@(self.sportShortcutModel.isYoga),@"index":@(0)},
                           @{@"type":@(19),@"isSelected":@(self.sportShortcutModel.isRopeSkipping),@"index":@(0)},
                           @{@"type":@(20),@"isSelected":@(self.sportShortcutModel.isTableTennis),@"index":@(0)},
                           @{@"type":@(21),@"isSelected":@(self.sportShortcutModel.isBasketball),@"index":@(0)},
                           @{@"type":@(22),@"isSelected":@(self.sportShortcutModel.isFootball),@"index":@(0)},
                           @{@"type":@(23),@"isSelected":@(self.sportShortcutModel.isVolleyball),@"index":@(0)},
                           @{@"type":@(24),@"isSelected":@(self.sportShortcutModel.isTennis),@"index":@(0)},
                           @{@"type":@(25),@"isSelected":@(self.sportShortcutModel.isGolf),@"index":@(0)},
                           @{@"type":@(26),@"isSelected":@(self.sportShortcutModel.isBaseball),@"index":@(0)},
                           @{@"type":@(27),@"isSelected":@(self.sportShortcutModel.isSkiing),@"index":@(0)},
                           @{@"type":@(28),@"isSelected":@(self.sportShortcutModel.isRollerSkating),@"index":@(0)},
                           @{@"type":@(29),@"isSelected":@(self.sportShortcutModel.isDance),@"index":@(0)},
                           ];
    }
    return _allSportModes;
}

- (NSMutableArray *)selectSportModes
{
    if (!_selectSportModes) {
        _selectSportModes = [NSMutableArray array];
        int i = 1;
        for (NSDictionary * dic in self.allSportModes) {
            NSInteger type  = [[dic valueForKey:@"type"] integerValue];
            BOOL isSelected = [[dic valueForKey:@"isSelected"] integerValue];
            if (!isSelected)continue;
            NSInteger index = [self getCurrentSportModeIndexWithType:type];
            if (index == 0)index = i;
            [_selectSportModes addObject:@{@"type":@(type),@"isSelected":@(isSelected),@"index":@(index)}];
            i++;
        }
        [self sortSportModels:_selectSportModes];
        NSLog(@"slectsportModels1 == %@\n",_selectSportModes);
    }
    return _selectSportModes;
}

- (NSInteger)getCurrentSportModeIndexWithType:(NSInteger)type
{
    for (IDOSetSportSortingItemModel * model in self.sportModeSortModel.sportSortingItems) {
        if (model.type == type) {
            return model.index;
        }
    }
    return 0;
}

- (void)sortSportModels:(NSMutableArray *)models
{
    NSSortDescriptor * sort = [NSSortDescriptor sortDescriptorWithKey:@"index" ascending:YES];
    NSArray * otherModels = [models sortedArrayUsingDescriptors:@[sort]];
    [models removeAllObjects];
    [models addObjectsFromArray:otherModels];
}

@end
