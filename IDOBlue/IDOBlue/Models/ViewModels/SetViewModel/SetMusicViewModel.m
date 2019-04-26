//
//  SetMusicViewModel.m
//  IDOBlue
//
//  Created by hedongyang on 2018/9/30.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "SetMusicViewModel.h"
#import "SwitchCellModel.h"
#import "FuncCellModel.h"
#import "EmpltyCellModel.h"
#import "FuncViewController.h"
#import "OneButtonTableViewCell.h"
#import "OneSwitchTableViewCell.h"
#import "EmptyTableViewCell.h"

@interface SetMusicViewModel()
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^switchCallback)(UIViewController * viewController,UISwitch * onSwitch,UITableViewCell * tableViewCell);
@property (nonatomic,strong) IDOSetMusicOpenInfoBuletoothModel * musicModel;
@property (nonatomic,strong) IDOSetPairingInfoBuletoothModel * pairingModel;
@end

@implementation SetMusicViewModel
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

- (IDOSetMusicOpenInfoBuletoothModel *)musicModel
{
    if (!_musicModel) {
        _musicModel = [IDOSetMusicOpenInfoBuletoothModel currentModel];
    }
    return _musicModel;
}

- (IDOSetPairingInfoBuletoothModel *)pairingModel
{
    if (!_pairingModel) {
        _pairingModel = [IDOSetPairingInfoBuletoothModel currentModel];
    }
    return _pairingModel;
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    
    if (!self.pairingModel.isPairing) {
        FuncCellModel * model = [[FuncCellModel alloc]init];
        model.typeStr = @"oneButton";
        model.data = @[lang(@"first pairing bluetooth")];
        model.cellHeight = 70.0f;
        model.cellClass = [OneButtonTableViewCell class];
        model.modelClass = [NSNull class];
        model.isShowLine = YES;
        model.buttconCallback = self.buttconCallback;
        [cellModels addObject:model];
    }else {
        SwitchCellModel * model1 = [[SwitchCellModel alloc]init];
        model1.typeStr = @"oneSwitch";
        model1.titleStr = [NSString stringWithFormat:@"%@:",lang(@"set music open off")];
        model1.data = @[@(self.musicModel.isOpen)];
        model1.cellHeight = 70.0f;
        model1.cellClass = [OneSwitchTableViewCell class];
        model1.modelClass = [NSNull class];
        model1.isShowLine = YES;
        model1.switchCallback = self.switchCallback;
        [cellModels addObject:model1];
        
        EmpltyCellModel * model2 = [[EmpltyCellModel alloc]init];
        model2.typeStr = @"empty";
        model2.cellHeight = 30.0f;
        model2.isShowLine = YES;
        model2.cellClass  = [EmptyTableViewCell class];
        [cellModels addObject:model2];
        
        FuncCellModel * model3 = [[FuncCellModel alloc]init];
        model3.typeStr = @"oneButton";
        model3.data = @[lang(@"set music open off")];
        model3.cellHeight = 70.0f;
        model3.cellClass = [OneButtonTableViewCell class];
        model3.modelClass = [NSNull class];
        model3.isShowLine = YES;
        model3.buttconCallback = self.buttconCallback;
        [cellModels addObject:model3];
    }
    self.cellModels = cellModels;
}

- (void)getSwitchCallback
{
    __weak typeof(self) weakSelf = self;
    self.switchCallback = ^(UIViewController *viewController, UISwitch *onSwitch, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        SwitchCellModel * switchCellModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
        strongSelf.musicModel.isOpen = onSwitch.isOn;
        switchCellModel.data = @[@(strongSelf.musicModel.isOpen)];
    };
}

- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        if (indexPath.row == 0) {
            [funcVC showLoadingWithMessage:lang(@"set pairing...")];
            [IDOFoundationCommand setBluetoothPairingCommandWithCallback:^(int errorCode) {
                if(errorCode == 0) {
                    [funcVC showToastWithText:lang(@"current device pairing success")];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        strongSelf.pairingModel = [IDOSetPairingInfoBuletoothModel currentModel];
                        [strongSelf getCellModels];
                        [funcVC reloadData];
                    });
                }else {
                    [funcVC showToastWithText:lang(@"current device pairing failed")];
                }
            }];
        }else {
            [funcVC showLoadingWithMessage:[NSString stringWithFormat:@"%@...",lang(@"set music open off")]];
            [IDOFoundationCommand setOpenMusicCommand:strongSelf.musicModel
                                             callback:^(int errorCode) {
                 if(errorCode == 0) {
                     [IDOFoundationCommand musicStartCommand:^(int errorCode) {
                         if (errorCode == 0) {
                              [funcVC showToastWithText:lang(@"set music open off success")];
                         }else {
                           [funcVC showToastWithText:lang(@"set music open off failed")];
                         }
                     }];
                 }else {
                     [funcVC showToastWithText:lang(@"set music open off failed")];
                 }
                                             }];
        }
    };
}
@end
