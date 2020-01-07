//
//  ModeSelectViewModel.m
//  IDOBlue
//
//  Created by 何东阳 on 2018/10/15.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "ModeSelectViewModel.h"
#import "LabelCellModel.h"
#import "FuncCellModel.h"
#import "EmpltyCellModel.h"
#import "SliderCellModel.h"
#import "SwitchCellModel.h"
#import "LabelCellModel.h"
#import "OneLabelTableViewCell.h"
#import "TwoButtonTableViewCell.h"
#import "OneSwitchTableViewCell.h"
#import "OneLabelTableViewCell.h"
#import "SliderTableViewCell.h"
#import "EmptyTableViewCell.h"
#import "FuncViewController.h"
#import "HtmlViewController.h"

@interface ModeSelectViewModel()
@property (nonatomic,assign) int rssiValue;
@property (nonatomic,assign) int modeValue;
@property (nonatomic,assign) int langValue;
@property (nonatomic,assign) BOOL isHomeSync;
@property (nonatomic,assign) BOOL isResponse;
@property (nonatomic,assign) BOOL isSetConnect;
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^sliderCallback)(UIViewController * viewController,UISlider * slider,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^switchCallback)(UIViewController * viewController,UISwitch * onSwitch,UITableViewCell * tableViewCell);
@end

@implementation ModeSelectViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getButtonCallback];
        [self getSliderCallback];
        [self getSwitchCallback];
        [self getWillDisappearCallback];
        [self getCellModels];
    }
    return self;
}

- (void)getCellModels
{
    self.modeValue = (int)[[NSUserDefaults standardUserDefaults]integerForKey:PRODUCTION_MODE_KEY];
    self.rssiValue = (int)[[NSUserDefaults standardUserDefaults]integerForKey:RSSI_KEY];
    self.isHomeSync = [[NSUserDefaults standardUserDefaults]boolForKey:HOME_NEED_SYNC];
    self.langValue = (int)[[NSUserDefaults standardUserDefaults]integerForKey:LANG_KEY] == 0 ? 1 : (int)[[NSUserDefaults standardUserDefaults]integerForKey:LANG_KEY];
    self.isResponse = [[NSUserDefaults standardUserDefaults]boolForKey:IS_RESPONSE_KEY];
    self.isSetConnect = [[NSUserDefaults standardUserDefaults]boolForKey:IS_SET_CONNECT_PARAMSERS];
    
    if (self.rssiValue == 0)self.rssiValue = 80;
    
    NSMutableArray * cellModels = [NSMutableArray array];
    
    FuncCellModel * model1 = [[FuncCellModel alloc]init];
    model1.typeStr  = @"twoButton";
    model1.titleStr = lang(@"mode");
    BOOL isFactory  = self.modeValue == 1 ? YES : NO;
    model1.data = @[@{@"title":lang(@"update mode"),@"state":[NSNumber numberWithBool:isFactory]},
                    @{@"title":lang(@"normal mode"),@"state":[NSNumber numberWithBool:!isFactory]}];
    model1.cellHeight = 70.0f;
    model1.cellClass = [TwoButtonTableViewCell class];
    model1.modelClass = [NSNull class];
    model1.isShowLine = YES;
    model1.buttconCallback = self.buttconCallback;
    [cellModels addObject:model1];
    
    EmpltyCellModel * model2 = [[EmpltyCellModel alloc]init];
    model2.typeStr = @"empty";
    model2.cellHeight = 10.0f;
    model2.isShowLine = YES;
    model2.cellClass  = [EmptyTableViewCell class];
    [cellModels addObject:model2];
    
    SliderCellModel * model3 = [[SliderCellModel alloc]init];
    model3.typeStr = @"slider";
    model3.cellHeight = 70.0f;
    model3.isShowLine = YES;
    model3.data = @[@(self.rssiValue)];
    model3.cellClass  = [SliderTableViewCell class];
    model3.sliderCallback = self.sliderCallback;
    [cellModels addObject:model3];
    
    EmpltyCellModel * model4 = [[EmpltyCellModel alloc]init];
    model4.typeStr = @"empty";
    model4.cellHeight = 10.0f;
    model4.isShowLine = YES;
    model4.cellClass  = [EmptyTableViewCell class];
    [cellModels addObject:model4];
    
    FuncCellModel * model5 = [[FuncCellModel alloc]init];
    model5.typeStr = @"twoButton";
    model5.titleStr = lang(@"lang");
    isFactory = self.langValue == 1 ? YES : NO;
    model5.data = @[@{@"title":lang(@"chinese"),@"state":[NSNumber numberWithBool:isFactory]},
                    @{@"title":lang(@"english"),@"state":[NSNumber numberWithBool:!isFactory]}];
    model5.cellHeight = 70.0f;
    model5.cellClass = [TwoButtonTableViewCell class];
    model5.modelClass = [NSNull class];
    model5.isShowLine = YES;
    model5.buttconCallback = self.buttconCallback;
    [cellModels addObject:model5];
    
    EmpltyCellModel * model7 = [[EmpltyCellModel alloc]init];
    model7.typeStr = @"empty";
    model7.cellHeight = 10.0f;
    model7.isShowLine = YES;
    model7.cellClass  = [EmptyTableViewCell class];
    [cellModels addObject:model7];
    
    SwitchCellModel * model6 = [[SwitchCellModel alloc]init];
    model6.typeStr = @"oneSwitch";
    model6.titleStr = lang(@"show log");
    model6.data = @[@([IDOConsoleBoard borad].isShow)];
    model6.cellHeight = 60.0f;
    model6.cellClass = [OneSwitchTableViewCell class];
    model6.modelClass = [NSNull class];
    model6.isShowLine = YES;
    model6.switchCallback = self.switchCallback;
    [cellModels addObject:model6];
    
    EmpltyCellModel * model10 = [[EmpltyCellModel alloc]init];
    model10.typeStr = @"empty";
    model10.cellHeight = 10.0f;
    model10.isShowLine = YES;
    model10.cellClass  = [EmptyTableViewCell class];
    [cellModels addObject:model10];
    
    SwitchCellModel * model11 = [[SwitchCellModel alloc]init];
    model11.typeStr = @"oneSwitch";
    model11.titleStr = lang(@"home need sync");
    model11.data = @[@(self.isHomeSync)];
    model11.cellHeight = 60.0f;
    model11.cellClass = [OneSwitchTableViewCell class];
    model11.modelClass = [NSNull class];
    model11.isShowLine = YES;
    model11.switchCallback = self.switchCallback;
    [cellModels addObject:model11];
    
    EmpltyCellModel * model15 = [[EmpltyCellModel alloc]init];
    model15.typeStr = @"empty";
    model15.cellHeight = 10.0f;
    model15.isShowLine = YES;
    model15.cellClass  = [EmptyTableViewCell class];
    [cellModels addObject:model15];
    
    SwitchCellModel * model13 = [[SwitchCellModel alloc]init];
    model13.typeStr = @"oneSwitch";
    model13.titleStr = lang(@"is response");
    model13.data = @[@(self.isResponse)];
    model13.cellHeight = 60.0f;
    model13.cellClass = [OneSwitchTableViewCell class];
    model13.modelClass = [NSNull class];
    model13.isShowLine = YES;
    model13.switchCallback = self.switchCallback;
    [cellModels addObject:model13];
    
    EmpltyCellModel * model16 = [[EmpltyCellModel alloc]init];
    model16.typeStr = @"empty";
    model16.cellHeight = 10.0f;
    model16.isShowLine = YES;
    model16.cellClass  = [EmptyTableViewCell class];
    [cellModels addObject:model16];
    
    SwitchCellModel * model14 = [[SwitchCellModel alloc]init];
    model14.typeStr = @"oneSwitch";
    model14.titleStr = lang(@"is set connection parameters");
    model14.data = @[@(self.isSetConnect)];
    model14.cellHeight = 60.0f;
    model14.cellClass = [OneSwitchTableViewCell class];
    model14.modelClass = [NSNull class];
    model14.isShowLine = YES;
    model14.switchCallback = self.switchCallback;
    [cellModels addObject:model14];
    
    if(   IDO_BLUE_ENGINE.managerEngine.isConnected
       && (__IDO_FUNCTABLE__.funcTable22Model.v3HrData
       ||  __IDO_FUNCTABLE__.funcTable22Model.v3SwimData))
    {
        EmpltyCellModel * model8 = [[EmpltyCellModel alloc]init];
        model8.typeStr = @"empty";
        model8.cellHeight = 10.0f;
        model8.isShowLine = YES;
        model8.cellClass  = [EmptyTableViewCell class];
        [cellModels addObject:model8];
        
        SwitchCellModel * model9 = [[SwitchCellModel alloc]init];
        model9.typeStr = @"oneSwitch";
        model9.titleStr = lang(@"simulator data");
        model9.data = @[@(0)];
        model9.cellHeight = 60.0f;
        model9.cellClass  = [OneSwitchTableViewCell class];
        model9.modelClass = [NSNull class];
        model9.isShowLine = YES;
        model9.switchCallback = self.switchCallback;
        [cellModels addObject:model9];
    }
    
    LabelCellModel * model12 = [[LabelCellModel alloc]init];
    model12.typeStr = @"oneLabel";
    NSString * version = [NSString stringWithFormat:@"--v %@--",IDO_BLUE_ENGINE.appEngine.sdkVersion];
    model12.data = @[version];
    model12.cellHeight = 60.0f;
    model12.cellClass  = [OneLabelTableViewCell class];
    model12.modelClass = [NSNull class];
    model12.isShowLine = YES;
    model12.isCenter   = YES;
    [cellModels addObject:model12];
    
    self.cellModels = cellModels;
}

- (void)getWillDisappearCallback
{
    __weak typeof(self) weakSelf = self;
    self.viewWillDisappearCallback = ^(UIViewController *viewController) {
        __strong typeof(self) strongSelf = weakSelf;
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:strongSelf.rssiValue] forKey:RSSI_KEY];
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:strongSelf.modeValue] forKey:PRODUCTION_MODE_KEY];
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:strongSelf.isHomeSync] forKey:HOME_NEED_SYNC];
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:strongSelf.isResponse] forKey:IS_RESPONSE_KEY];
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:strongSelf.isSetConnect] forKey:IS_SET_CONNECT_PARAMSERS];
    };
}

- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVc = (FuncViewController *)viewController;
        TwoButtonTableViewCell * twoCell = (TwoButtonTableViewCell *)tableViewCell;
        NSIndexPath * indexPath = [funcVc.tableView indexPathForCell:tableViewCell];
        FuncCellModel * funcCellModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
        if (indexPath.row == 0) {
            strongSelf.modeValue = twoCell.button1.isSelected ? 1 : 0;
            funcCellModel.data   = @[@{@"title":lang(@"update mode"),@"state":[NSNumber numberWithBool:twoCell.button1.isSelected]},
                                     @{@"title":lang(@"normal mode"),@"state":[NSNumber numberWithBool:twoCell.button2.isSelected]}];
        }else {
            strongSelf.langValue = twoCell.button1.isSelected ? 1 : 2;
            [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:strongSelf.langValue] forKey:LANG_KEY];
            [[NSNotificationCenter defaultCenter]postNotificationName:LANG_NOTICE_NAME object:nil];
            funcVc.title = lang(@"parameter select");
            NSString * stateStr = IDO_BLUE_ENGINE.managerEngine.isConnected ? lang(@"connected") : IDO_BLUE_ENGINE.managerEngine.isConnecting ? lang(@"connecting") : lang(@"scanning");
            funcVc.statusLabel.text = stateStr;
            [strongSelf getCellModels];
            [funcVc reloadData];
        }
    };
}

- (void)getSliderCallback
{
    __weak typeof(self) weakSelf = self;
    self.sliderCallback = ^(UIViewController *viewController, UISlider *slider, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVc = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVc.tableView indexPathForCell:tableViewCell];
        SliderCellModel * sliderCellModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
        strongSelf.rssiValue = (int)slider.value;
        sliderCellModel.data = @[@(slider.value)];
    };
}

- (void)getSwitchCallback
{
    __weak typeof(self) weakSelf = self;
    self.switchCallback = ^(UIViewController *viewController, UISwitch *onSwitch, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        SwitchCellModel * switchCellModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
        switchCellModel.data = @[@(onSwitch.isOn)];
        [funcVC.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        if (indexPath.row == 6) {
            if (onSwitch.isOn) {
                [[IDOConsoleBoard borad]show];
            }else {
                [[IDOConsoleBoard borad]close];
            }
        }else if (indexPath.row == 8) {
            strongSelf.isHomeSync = onSwitch.isOn;
        }else if (indexPath.row == 10) {
            strongSelf.isResponse = onSwitch.isOn;
        }else if (indexPath.row == 12) {
            strongSelf.isSetConnect = onSwitch.isOn;
        }else {
            if (onSwitch.isOn) {
                Byte bytes[] = {0XF1,0XF2};
                NSData * sendData = [[NSData alloc] initWithBytes:bytes length:2];
                //commandCharacteristic
                [__IDO_PERIPHERAL__ writeValue:sendData
                             forCharacteristic:IDO_BLUE_ENGINE.managerEngine.commandCharacteristic
                                          type:CBCharacteristicWriteWithResponse];
                NSString * filePath = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
                filePath = [filePath stringByAppendingPathComponent:@"IDODB"];
                filePath = [filePath stringByAppendingPathComponent:@"v3_health"];
                [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
            }
        }
    };
}

@end
