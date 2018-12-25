//
//  SetSportShortcutViewModel.m
//  IDOBlue
//
//  Created by hedongyang on 2018/9/29.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "SetSportShortcutViewModel.h"
#import "SwitchCellModel.h"
#import "FuncCellModel.h"
#import "EmpltyCellModel.h"
#import "FuncViewController.h"
#import "OneButtonTableViewCell.h"
#import "OneSwitchTableViewCell.h"
#import "EmptyTableViewCell.h"

@interface SetSportShortcutViewModel()
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^switchCallback)(UIViewController * viewController,UISwitch * onSwitch,UITableViewCell * tableViewCell);
@property (nonatomic,strong) NSArray * sportShortcutDataArray;
@property (nonatomic,assign) NSInteger selectedCount;
@property (nonatomic,strong) IDOSetSportShortcutInfoBluetoothModel * sportShortcutModel;
@end

@implementation SetSportShortcutViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getSwitchCallback];
        [self getButtonCallback];
        [self getCellModels];
    }
    return self;
}

- (IDOSetSportShortcutInfoBluetoothModel *)sportShortcutModel
{
    if (!_sportShortcutModel) {
        _sportShortcutModel = [IDOSetSportShortcutInfoBluetoothModel currentModel];
    }
    return _sportShortcutModel;
}

- (NSArray *)sportShortcutDataArray
{
    if (!_sportShortcutDataArray) {
        _sportShortcutDataArray = @[@[@(self.sportShortcutModel.isWalk),@(self.sportShortcutModel.isRun),
                                      @(self.sportShortcutModel.isByBike),@(self.sportShortcutModel.isOnFoot),
                                      @(self.sportShortcutModel.isSwim),@(self.sportShortcutModel.isMountainClimbing),
                                      @(self.sportShortcutModel.isBadminton),@(self.sportShortcutModel.isOther)],
                                    @[@(self.sportShortcutModel.isFitness),@(self.sportShortcutModel.isSpinning),
                                      @(self.sportShortcutModel.isEllipsoid),@(self.sportShortcutModel.isTreadmill),
                                      @(self.sportShortcutModel.isSitUp),@(self.sportShortcutModel.isPushUp),
                                      @(self.sportShortcutModel.isDumbbell),@(self.sportShortcutModel.isWeightlifting)],
                                    @[@(self.sportShortcutModel.isBodybuildingExercise),@(self.sportShortcutModel.isYoga),
                                      @(self.sportShortcutModel.isRopeSkipping),@(self.sportShortcutModel.isTableTennis),
                                      @(self.sportShortcutModel.isBasketball),@(self.sportShortcutModel.isFootball),
                                      @(self.sportShortcutModel.isVolleyball),@(self.sportShortcutModel.isTennis)],
                                    @[@(self.sportShortcutModel.isGolf),@(self.sportShortcutModel.isBaseball),
                                      @(self.sportShortcutModel.isSkiing),@(self.sportShortcutModel.isRollerSkating),
                                      @(self.sportShortcutModel.isDance)]];
    }
    return _sportShortcutDataArray;
}

- (void)getSwitchCallback
{
    __weak typeof(self) weakSelf = self;
    self.switchCallback = ^(UIViewController *viewController, UISwitch *onSwitch, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        SwitchCellModel * switchCellModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
        if (strongSelf.selectedCount >= __IDO_FUNCTABLE__.sportShowCount && onSwitch.isOn) {
            [funcVC showToastWithText:[NSString stringWithFormat:@"最多支持%ld种类型",__IDO_FUNCTABLE__.sportShowCount]];
            switchCellModel.data = @[@(NO)];
            [funcVC.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            return ;
        }
        BOOL isSupport = YES;
        if (switchCellModel.index == 0) {
            if (__IDO_FUNCTABLE__.sportType0Model.walk) {
                strongSelf.sportShortcutModel.isWalk = onSwitch.isOn;
            }else {
                isSupport = NO;
            }
        }else if (switchCellModel.index == 1) {
            if (__IDO_FUNCTABLE__.sportType0Model.run) {
                strongSelf.sportShortcutModel.isRun = onSwitch.isOn;
            }else {
              isSupport = NO;
            }
        }else if (switchCellModel.index == 2) {
            if (__IDO_FUNCTABLE__.sportType0Model.byBike) {
                strongSelf.sportShortcutModel.isByBike = onSwitch.isOn;
            }else {
               isSupport = NO;
            }
        }else if (switchCellModel.index == 3) {
            if (__IDO_FUNCTABLE__.sportType0Model.onFoot) {
                strongSelf.sportShortcutModel.isOnFoot = onSwitch.isOn;
            }else {
               isSupport = NO;
            }
        }else if (switchCellModel.index == 4) {
            if (__IDO_FUNCTABLE__.sportType0Model.swim) {
                strongSelf.sportShortcutModel.isSwim = onSwitch.isOn;
            }else {
               isSupport = NO;
            }
        }else if (switchCellModel.index == 5) {
            if (__IDO_FUNCTABLE__.sportType0Model.mountainClimbing) {
                strongSelf.sportShortcutModel.isMountainClimbing = onSwitch.isOn;
            }else {
               isSupport = NO;
            }
        }else if (switchCellModel.index == 6) {
            if (__IDO_FUNCTABLE__.sportType0Model.badminton) {
                strongSelf.sportShortcutModel.isBadminton = onSwitch.isOn;
            }else {
               isSupport = NO;
            }
        }else if (switchCellModel.index == 7) {
            if (__IDO_FUNCTABLE__.sportType0Model.other) {
                strongSelf.sportShortcutModel.isOther = onSwitch.isOn;
            }else {
                isSupport = NO;
            }
        }else if (switchCellModel.index == 8) {
            if (__IDO_FUNCTABLE__.sportType1Model.fitness) {
                strongSelf.sportShortcutModel.isFitness = onSwitch.isOn;
            }else {
              isSupport = NO;
            }
        }else if (switchCellModel.index == 9) {
            if (__IDO_FUNCTABLE__.sportType1Model.spinning) {
                strongSelf.sportShortcutModel.isSpinning = onSwitch.isOn;
            }else {
               isSupport = NO;
            }
        }else if (switchCellModel.index == 10) {
            if (__IDO_FUNCTABLE__.sportType1Model.ellipsoid) {
                strongSelf.sportShortcutModel.isEllipsoid = onSwitch.isOn;
            }else {
              isSupport = NO;
            }
        }else if (switchCellModel.index == 11) {
            if (__IDO_FUNCTABLE__.sportType1Model.treadmill) {
                strongSelf.sportShortcutModel.isTreadmill = onSwitch.isOn;
            }else {
              isSupport = NO;
            }
        }else if (switchCellModel.index == 12) {
            if (__IDO_FUNCTABLE__.sportType1Model.sitUp) {
                strongSelf.sportShortcutModel.isSitUp = onSwitch.isOn;
            }else {
                isSupport = NO;
            }
        }else if (switchCellModel.index == 13) {
            if (__IDO_FUNCTABLE__.sportType1Model.pushUp) {
                strongSelf.sportShortcutModel.isPushUp = onSwitch.isOn;
            }else {
               isSupport = NO;
            }
        }else if (switchCellModel.index == 14) {
            if (__IDO_FUNCTABLE__.sportType1Model.dumbbell) {
                strongSelf.sportShortcutModel.isDumbbell = onSwitch.isOn;
            }else {
               isSupport = NO;
            }
        }else if (switchCellModel.index == 15) {
            if (__IDO_FUNCTABLE__.sportType1Model.weightlifting) {
                strongSelf.sportShortcutModel.isWeightlifting = onSwitch.isOn;
            }else {
                isSupport = NO;
            }
        }else if (switchCellModel.index == 16) {
            if (__IDO_FUNCTABLE__.sportType2Model.bodybuildingExercise) {
                strongSelf.sportShortcutModel.isBodybuildingExercise = onSwitch.isOn;
            }else {
               isSupport = NO;
            }
        }else if (switchCellModel.index == 17) {
            if (__IDO_FUNCTABLE__.sportType2Model.yoga) {
                strongSelf.sportShortcutModel.isYoga = onSwitch.isOn;
            }else {
                isSupport = NO;
            }
        }else if (switchCellModel.index == 18) {
            if (__IDO_FUNCTABLE__.sportType2Model.ropeSkipping) {
                strongSelf.sportShortcutModel.isRopeSkipping = onSwitch.isOn;
            }else {
                isSupport = NO;
            }
        }else if (switchCellModel.index == 19) {
            if (__IDO_FUNCTABLE__.sportType2Model.tableTennis) {
                strongSelf.sportShortcutModel.isTableTennis = onSwitch.isOn;
            }else {
                isSupport = NO;
            }
        }else if (switchCellModel.index == 20) {
            if (__IDO_FUNCTABLE__.sportType2Model.basketball) {
                strongSelf.sportShortcutModel.isBasketball = onSwitch.isOn;
            }else {
               isSupport = NO;
            }
        }else if (switchCellModel.index == 21) {
            if (__IDO_FUNCTABLE__.sportType2Model.football) {
                strongSelf.sportShortcutModel.isFootball = onSwitch.isOn;
            }else {
               isSupport = NO;
            }
        }else if (switchCellModel.index == 22) {
            if (__IDO_FUNCTABLE__.sportType2Model.volleyball) {
                strongSelf.sportShortcutModel.isVolleyball = onSwitch.isOn;
            }else {
                isSupport = NO;
            }
        }else if (switchCellModel.index == 23) {
            if (__IDO_FUNCTABLE__.sportType2Model.tennis) {
                strongSelf.sportShortcutModel.isTennis = onSwitch.isOn;
            }else {
                isSupport = NO;
            }
        }else if (switchCellModel.index == 24) {
            if (__IDO_FUNCTABLE__.sportType3Model.golf) {
                strongSelf.sportShortcutModel.isGolf = onSwitch.isOn;
            }else {
                isSupport = NO;
            }
        }else if (switchCellModel.index == 25) {
            if (__IDO_FUNCTABLE__.sportType3Model.baseball) {
                strongSelf.sportShortcutModel.isBaseball = onSwitch.isOn;
            }else {
                isSupport = NO;
            }
        }else if (switchCellModel.index == 26) {
            if (__IDO_FUNCTABLE__.sportType3Model.skiing) {
                strongSelf.sportShortcutModel.isSkiing = onSwitch.isOn;
            }else {
                isSupport = NO;
            }
        }else if (switchCellModel.index == 27) {
            if (__IDO_FUNCTABLE__.sportType3Model.rollerSkating) {
                strongSelf.sportShortcutModel.isRollerSkating = onSwitch.isOn;
            }else {
                isSupport = NO;
            }
        }else if (switchCellModel.index == 28) {
            if (__IDO_FUNCTABLE__.sportType3Model.dance) {
                strongSelf.sportShortcutModel.isDance = onSwitch.isOn;
            }else {
                isSupport = NO;
            }
        }
        if (isSupport) {
            if (onSwitch.isOn) {
                strongSelf.selectedCount ++;
            }else {
                strongSelf.selectedCount --;
            }
            switchCellModel.data = @[@(onSwitch.isOn)];
        }else {
            [funcVC showToastWithText:@"当前设备不支持此功能"];
            switchCellModel.data = @[@(NO)];
            [funcVC.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }
    };
}

- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        [funcVC showLoadingWithMessage:@"设置运动快捷方式..."];
        [IDOFoundationCommand setSportModeSelectCommand:strongSelf.sportShortcutModel
                                               callback:^(int errorCode) {
            if(errorCode == 0) {
                [funcVC showToastWithText:@"设置运动快捷方式成功"];
            }else {
                [funcVC showToastWithText:@"设置运动快捷方式失败"];
            }
        }];
    };
}

- (void)getCellModels
{
    NSInteger index = 0;
    NSMutableArray * cellModels = [NSMutableArray array];
    for (int i = 0; i < self.pickerDataModel.sportShortcutTitleArray.count; i++) {
        NSArray * array1 = self.pickerDataModel.sportShortcutTitleArray[i];
        NSArray * array2 = self.sportShortcutDataArray[i];
        for (int j = 0; j < array1.count; j++) {
            NSString * titleStr = [array1 objectAtIndex:j];
            NSInteger data = [[array2 objectAtIndex:j] integerValue];
            SwitchCellModel * model = [[SwitchCellModel alloc]init];
            model.typeStr = @"oneSwitch";
            model.titleStr = titleStr;
            model.data = @[@(data)];
            model.cellHeight = 70.0f;
            model.index = index;
            model.cellClass = [OneSwitchTableViewCell class];
            model.modelClass = [NSNull class];
            model.isShowLine = YES;
            model.switchCallback = self.switchCallback;
            [cellModels addObject:model];
            index ++;
        }
        EmpltyCellModel * model2 = [[EmpltyCellModel alloc]init];
        model2.typeStr = @"empty";
        model2.cellHeight = 30.0f;
        model2.isShowLine = YES;
        model2.cellClass  = [EmptyTableViewCell class];
        [cellModels addObject:model2];
    }
    
    FuncCellModel * model3 = [[FuncCellModel alloc]init];
    model3.typeStr = @"oneButton";
    model3.data = @[@"设置运动快捷方式"];
    model3.cellHeight = 70.0f;
    model3.cellClass = [OneButtonTableViewCell class];
    model3.modelClass = [NSNull class];
    model3.isShowLine = YES;
    model3.buttconCallback = self.buttconCallback;
    [cellModels addObject:model3];
    self.cellModels = cellModels;
    
    self.selectedCount = 0;
    for (NSArray * array in self.sportShortcutDataArray) {
        for (NSNumber * number in array) {
            if ([number boolValue]) {
                self.selectedCount ++;
            }
        }
    }
}
@end
