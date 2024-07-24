//
//  SetSportSwitchViewModel.m
//  IDOBlue
//
//  Created by hedongyang on 2020/4/23.
//  Copyright © 2020 hedongyang. All rights reserved.
//

#import "SetSportSwitchViewModel.h"
#import "SwitchCellModel.h"
#import "OneSwitchTableViewCell.h"
#import "FuncCellModel.h"
#import "OneButtonTableViewCell.h"
#import "FuncViewController.h"

@interface SetSportSwitchViewModel ()
@property (nonatomic,strong)IDOSetActivitySwitchBluetoothModel * sportModel;
@property (nonatomic,strong)NSArray * switchArray;
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^switchCallback)(UIViewController * viewController,UISwitch * onSwitch,UITableViewCell * tableViewCell);
@end

@implementation SetSportSwitchViewModel

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

- (NSArray *)switchArray
{
    if (!_switchArray) {
        _switchArray = @[@{@"title":lang(@"walk on off"),@"switch":@(self.sportModel.sportWalkOnOff)},
                         @{@"title":lang(@"run on off"),@"switch":@(self.sportModel.sportRunOnOff)},
                         @{@"title":lang(@"bicycle on off"),@"switch":@(self.sportModel.sportBicycleOnOff)},
                         @{@"title":lang(@"auto pause on off"),@"switch":@(self.sportModel.autoPauseOnOff)},
                         @{@"title":lang(@"end remind on off"),@"switch":@(self.sportModel.endRemindOnOff)},
                         @{@"title":lang(@"auto elliptical machine switch"),@"switch":@(self.sportModel.sportEllipticalOnOff)},
                         @{@"title":lang(@"auto rowing machine switch"),@"switch":@(self.sportModel.sportRowingOnOff)},
                         @{@"title":lang(@"auto swimming switch"),@"switch":@(self.sportModel.sportSwimOnOff)},
                        ];
    }
    return _switchArray;
}

- (IDOSetActivitySwitchBluetoothModel *)sportModel
{
    if (!_sportModel) {
        _sportModel = [IDOSetActivitySwitchBluetoothModel currentModel];
    }
    return _sportModel;
}

- (void)getSwitchCallback
{
    __weak typeof(self) weakSelf = self;
    self.switchCallback = ^(UIViewController *viewController, UISwitch *onSwitch, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        SwitchCellModel * switchCellModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
        if (indexPath.row == 0) {
            strongSelf.sportModel.sportWalkOnOff = onSwitch.isOn;
            switchCellModel.data = @[@(strongSelf.sportModel.sportWalkOnOff)];
        }else if (indexPath.row == 1) {
            strongSelf.sportModel.sportRunOnOff = onSwitch.isOn;
            switchCellModel.data = @[@(strongSelf.sportModel.sportRunOnOff)];
        }else if (indexPath.row == 2) {
            strongSelf.sportModel.sportBicycleOnOff = onSwitch.isOn;
            switchCellModel.data = @[@(strongSelf.sportModel.sportBicycleOnOff)];
        }else if (indexPath.row == 3) {
            strongSelf.sportModel.autoPauseOnOff = onSwitch.isOn;
            switchCellModel.data = @[@(strongSelf.sportModel.autoPauseOnOff)];
        }else if (indexPath.row == 4) {
            strongSelf.sportModel.endRemindOnOff = onSwitch.isOn;
            switchCellModel.data = @[@(strongSelf.sportModel.endRemindOnOff)];
        }else if (indexPath.row == 5) {
            strongSelf.sportModel.sportEllipticalOnOff = onSwitch.isOn;
            switchCellModel.data = @[@(strongSelf.sportModel.sportEllipticalOnOff)];
        }else if (indexPath.row == 6) {
            strongSelf.sportModel.sportRowingOnOff = onSwitch.isOn;
            switchCellModel.data = @[@(strongSelf.sportModel.sportRowingOnOff)];
        }else if (indexPath.row == 7) {
            strongSelf.sportModel.sportSwimOnOff = onSwitch.isOn;
            switchCellModel.data = @[@(strongSelf.sportModel.sportSwimOnOff)];
        }
    };
}

- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        if (!__IDO_FUNCTABLE__.funcTable23Model.activitySwitch) {
            [funcVC showToastWithText:@"feature is not supported on the current device"];
            return;
        }
        [funcVC showLoadingWithMessage:[NSString stringWithFormat:@"%@...",lang(@"set sport identify switch")]];
        [IDOFoundationCommand setActivitySwitchCommand:strongSelf.sportModel callback:^(int errorCode) {
            if(errorCode == 0) {
                [funcVC showToastWithText:lang(@"set sport identify switch success")];
            }else if (errorCode == 6) {
                [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
            }else {
                [funcVC showToastWithText:lang(@"set sport identify switch failed")];
            }
        }];
    };
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    
    for (NSDictionary * dic in self.switchArray) {
        SwitchCellModel * model = [[SwitchCellModel alloc]init];
        model.typeStr = @"oneSwitch";
        model.titleStr = [dic valueForKey:@"title"];
        model.data = @[@([[dic valueForKey:@"switch"] boolValue])];
        model.cellHeight = 70.0f;
        model.cellClass = [OneSwitchTableViewCell class];
        model.modelClass = [NSNull class];
        model.isShowLine = YES;
        model.switchCallback = self.switchCallback;
        [cellModels addObject:model];
    }
    
    FuncCellModel * model2 = [[FuncCellModel alloc]init];
    model2.typeStr = @"oneButton";
    model2.data = @[lang(@"set sport identify switch")];
    model2.cellHeight = 70.0f;
    model2.cellClass = [OneButtonTableViewCell class];
    model2.modelClass = [NSNull class];
    model2.isShowLine = YES;
    model2.buttconCallback = self.buttconCallback;
    [cellModels addObject:model2];
    
    self.cellModels = cellModels;
}

@end
