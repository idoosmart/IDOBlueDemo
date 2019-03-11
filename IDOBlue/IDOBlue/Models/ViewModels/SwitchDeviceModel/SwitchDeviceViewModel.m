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
@property (nonatomic,strong) NSString * needConnectDeviceMac;
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
        [IDOBluetoothManager shareInstance].rssiNum = 100;
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
        NSString * deviceName = [NSString stringWithFormat:@"%@:%@",deviceModel.deviceName,deviceModel.macAddr];
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
            [funcVc showToastWithText:@"设备已经连接"];
            return;
        }
        strongSelf.needConnectDeviceMac = model.macAddr;
        [IDOFoundationCommand switchDeviceCommand:^(int errorCode) {
            if (errorCode == 0) {
                [funcVc showLoadingWithMessage:@"设备切换中..."];
                [IDOBluetoothManager startScan];
            }else {
               [funcVc showToastWithText:@"切换设备失败"];
            }
        }];
    };
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
    IDOSetBindingInfoBluetoothModel * model = [[IDOSetBindingInfoBluetoothModel alloc]init];
    [IDOFoundationCommand bindingCommand:model callback:^(IDO_BIND_STATUS status, int errorCode) {
        FuncViewController * funcVc = (FuncViewController *)[IDODemoUtility getCurrentVC];
        if (errorCode == 0) {
            if (status == IDO_BLUETOOTH_BIND_SUCCESS) { //绑定成功
                [funcVc showToastWithText:@"绑定成功"];
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
                [funcVc showToastWithText:@"拒绝绑定"];
            }
        }else { //绑定失败
            [funcVc showToastWithText:@"绑定失败"];
        }
    }];
}

#pragma mark === IDOBluetoothManagerDelegate ===
- (BOOL)bluetoothManager:(IDOBluetoothManager *)manager
           centerManager:(CBCentralManager *)centerManager
    didConnectPeripheral:(CBPeripheral *)peripheral
               isOatMode:(BOOL)isOtaMode
{
    FuncViewController * funcVc = (FuncViewController *)[IDODemoUtility getCurrentVC];
    [funcVc showToastWithText:@"设备切换成功"];
    /******************⚠️切换手环成功后要发起绑定***********************/
    [self bindDevice];
    return YES;
}

- (void)bluetoothManager:(IDOBluetoothManager *)manager
              allDevices:(NSArray<IDOPeripheralModel *> *)allDevices
              otaDevices:(NSArray<IDOPeripheralModel *> *)otaDevices
{
    for (IDOPeripheralModel * model in allDevices) {
        if ([model.macAddr isEqualToString:self.needConnectDeviceMac]) {
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
  
}

@end
