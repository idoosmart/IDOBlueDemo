//
//  SwitchDeviceViewModel.m
//  IDOBlue
//
//  Created by 何东阳 on 2019/3/10.
//  Copyright © 2019年 hedongyang. All rights reserved.
//

#import "SwitchDeviceViewModel.h"
#import "FuncCellModel.h"
#import "OneButtonTableViewCell.h"
#import "FuncViewController.h"

@interface SwitchDeviceViewModel()<IDOBluetoothManagerDelegate>
@property (nonatomic,strong) NSArray * allDevices;
@property (nonatomic,strong) IDOGetDeviceInfoBluetoothModel * needConnectDeviceMode;
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation SwitchDeviceViewModel

- (void)dealloc
{
    [IDOBluetoothManager shareInstance].delegate = nil;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getButtonCallback];
        [self getCellModels];
        [IDOBluetoothManager shareInstance].delegate = self;
        [IDOBluetoothManager shareInstance].rssiNum  = 100;
    }
    return self;
}

- (NSArray *)allDevices
{
    if (!_allDevices) {
        _allDevices = [IDOGetDeviceInfoBluetoothModel queryAllDeviceModels];
    }
    return _allDevices;
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    for (int i = 0; i < self.allDevices.count; i++) {
        IDOGetDeviceInfoBluetoothModel * deviceModel = [self.allDevices objectAtIndex:i];
        FuncCellModel * model = [[FuncCellModel alloc]init];
        model.typeStr = @"oneButton";
        NSString * deviceName = [NSString stringWithFormat:@"%@:%@",deviceModel.deviceName?:@"null",deviceModel.macAddr];
        model.data    = @[deviceName];
        model.cellHeight = 70.0f;
        model.cellClass  = [OneButtonTableViewCell class];
        model.modelClass = [NSNull class];
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
        __block FuncViewController * funcVc = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVc.tableView indexPathForCell:tableViewCell];
        IDOGetDeviceInfoBluetoothModel * model = strongSelf.allDevices[indexPath.row];
        CBPeripheral * peripheral = [SwitchDeviceViewModel getPeripheralWithUUIDStr:model.uuidStr];
        if (peripheral.state == CBPeripheralStateConnected){
            [funcVc showToastWithText:lang(@"connected success")];
            return;
        }
        strongSelf.needConnectDeviceMode = model;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [funcVc showLoadingWithMessage:lang(@"device switching")];
        });
        [NSObject cancelPreviousPerformRequestsWithTarget:strongSelf selector:@selector(switchDeviceTimeout) object:nil];
        [strongSelf performSelector:@selector(switchDeviceTimeout) withObject:nil afterDelay:20]; //根据自身需求修改超时时长
        [IDOFoundationCommand switchDeviceCommand:^(int errorCode) {
            if (errorCode == 0) {
                [IDOBluetoothManager startScan];
            }else {
               [funcVc showToastWithText:lang(@"device switch failed")];
            }
        }];
    };
}

- (void)switchDeviceTimeout
{
    FuncViewController * funcVc = (FuncViewController *)[IDODemoUtility getCurrentVC];
    [funcVc showToastWithText:lang(@"device switch failed")];
    [IDOBluetoothManager stopScan];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(switchDeviceTimeout) object:nil];
}

+ (CBPeripheral *)getPeripheralWithUUIDStr:(NSString *)uuidStr
{
    NSUUID  * uuid = [[NSUUID alloc]initWithUUIDString:uuidStr];
    if (!uuid)return nil;
    NSArray <CBPeripheral *>* peripherals = [__IDO_MANAGER__ retrievePeripheralsWithIdentifiers:@[uuid]];
    return [peripherals firstObject];
}

- (void)bindDevice
{
    if(!__IDO_BIND__) {
        IDOSetBindingInfoBluetoothModel * model = [[IDOSetBindingInfoBluetoothModel alloc]init];
        [IDOFoundationCommand bindingCommand:model callback:^(IDO_BIND_STATUS status, int errorCode) {
            FuncViewController * funcVc = (FuncViewController *)[IDODemoUtility getCurrentVC];
            if (errorCode == 0) {
                if (status == IDO_BLUETOOTH_BIND_SUCCESS) { //绑定成功
                    [funcVc showToastWithText:lang(@"bind success")];
                    /*
                     [IDOSyncManager syncDataCompleteCallback:^(IDO_SYNC_COMPLETE_STATUS stateCode, NSString * _Nullable stateInfo) {
                     if (stateCode == IDO_SYNC_GLOBAL_COMPLETE) {
                     [funcVc showToastWithText:@"同步数据完成"];
                     }
                     } failCallback:^(int errorCode) {
                     [funcVc showToastWithText:@"同步失败"];
                     }];
                     [IDOSyncManager syncDataJsonCallback:^(IDO_CURRENT_SYNC_TYPE syncType, NSString * _Nullable jsonStr) {
                     
                     }];
                     [IDOSyncManager syncDataProgressCallback:^(float progress) {
                     [funcVc showSyncProgress:progress];
                     }];
                     IDOSyncManager.startSync(YES);
                     */
                }else if (status == IDO_BLUETOOTH_BINDED) { //已经绑定
                    
                }else if (status == IDO_BLUETOOTH_BIND_FAILED) { //绑定失败
                    
                }else if (status == IDO_BLUETOOTH_NEED_AUTH) { //需要授权绑定
                }else if (status == IDO_BLUETOOTH_REFUSED_BINDED) { //拒绝绑定
                    [funcVc showToastWithText:lang(@"rejected bind")];
                }
            }else { //绑定失败
                [funcVc showToastWithText:lang(@"bind failed")];
            }
        }];
    }
}

#pragma mark === IDOBluetoothManagerDelegate ===
- (BOOL)bluetoothManager:(IDOBluetoothManager *)manager
           centerManager:(CBCentralManager *)centerManager
    didConnectPeripheral:(CBPeripheral *)peripheral
               isOatMode:(BOOL)isOtaMode
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(switchDeviceTimeout) object:nil];
    FuncViewController * funcVc = (FuncViewController *)[IDODemoUtility getCurrentVC];
    [funcVc showToastWithText:lang(@"device switch success")];
    /******************⚠️切换手环成功后要发起绑定***********************/
    [self bindDevice];
    return YES;
}

- (void)bluetoothManager:(IDOBluetoothManager *)manager
              allDevices:(NSArray<IDOPeripheralModel *> *)allDevices
              otaDevices:(NSArray<IDOPeripheralModel *> *)otaDevices
{
    for (IDOPeripheralModel * model in allDevices) {
        if (  [model.macAddr isEqualToString:self.needConnectDeviceMode.macAddr]
            ||[model.uuidStr isEqualToString:self.needConnectDeviceMode.uuidStr]) {
            [IDOBluetoothManager connectDeviceWithModel:model];
        }
    }
}

- (void)bluetoothManager:(IDOBluetoothManager *)manager
          didUpdateState:(IDO_BLUETOOTH_MANAGER_STATE)state
{
    
}

- (void)bluetoothManager:(IDOBluetoothManager *)manager
  connectPeripheralError:(NSError *)error
{
    if (error.code != IDO_BLUETOOTH_MANUAL_DIS_CONNECT_TYPE) {
        FuncViewController * funcVc = (FuncViewController *)[IDODemoUtility getCurrentVC];
        [funcVc showToastWithText:lang(@"connected failed")];
        [IDOBluetoothManager stopScan];
    }
}

@end
