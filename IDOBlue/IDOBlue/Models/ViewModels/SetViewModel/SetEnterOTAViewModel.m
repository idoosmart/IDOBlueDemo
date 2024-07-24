//
//  SetEnterOTAViewModel.m
//  IDOBlue
//
//  Created by huangkunhe on 2022/12/19.
//  Copyright © 2022 hedongyang. All rights reserved.
//

#import "SetEnterOTAViewModel.h"
#import "SwitchCellModel.h"
#import "FuncCellModel.h"
#import "EmpltyCellModel.h"
#import "FuncViewController.h"
#import "OneButtonTableViewCell.h"
#import "OneSwitchTableViewCell.h"
#import "EmptyTableViewCell.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface SetEnterOTAViewModel()
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^switchCallback)(UIViewController * viewController,UISwitch * onSwitch,UITableViewCell * tableViewCell);
@property (nonatomic,strong) IDOSetFindPhoneInfoBuletoothModel * findPhoneModel;
@end

@implementation SetEnterOTAViewModel

- (void)dealloc
{
    
}

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

- (IDOSetFindPhoneInfoBuletoothModel *)findPhoneModel
{
    if (!_findPhoneModel) {
        _findPhoneModel = [IDOSetFindPhoneInfoBuletoothModel currentModel];
    }
    return _findPhoneModel;
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    
    EmpltyCellModel * model2 = [[EmpltyCellModel alloc]init];
    model2.typeStr = @"empty";
    model2.cellHeight = 30.0f;
    model2.isShowLine = YES;
    model2.cellClass  = [EmptyTableViewCell class];
    [cellModels addObject:model2];
    
    FuncCellModel * model3 = [[FuncCellModel alloc]init];
    model3.typeStr = @"oneButton";
    model3.data = @[lang(@"set enter OTA mode")];
    model3.cellHeight = 70.0f;
    model3.cellClass = [OneButtonTableViewCell class];
    model3.modelClass = [NSNull class];
    model3.isShowLine = YES;
    model3.buttconCallback = self.buttconCallback;
    [cellModels addObject:model3];
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
        strongSelf.findPhoneModel.isOpen = onSwitch.isOn;
        switchCellModel.data = @[@(strongSelf.findPhoneModel.isOpen)];
    };
}

- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        FuncViewController * funcVC = (FuncViewController *)viewController;
        [funcVC showLoadingWithMessage:lang(@"set enter OTA mode")];
        [IDOFoundationCommand setOtaCommand:^(int state, int errorCode) {
            if(errorCode == 0) {
                [funcVC showToastWithText:lang(@"set enter OTA mode successfully")];
            }else if (errorCode == 6) {
                [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
            }else {
                [funcVC showToastWithText:lang(@"set enter OTA mode failed")];
            }
        }];
        
    };
    

}
@end

