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
#import "ScanDemoViewController.h"

@interface SwitchDeviceViewModel()<IDOBluetoothManagerDelegate>
@property (nonatomic,strong) NSArray * allDevices;
@property (nonatomic,copy) NSString * macStr;
@property (nonatomic,assign) BOOL isAdd;
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
        self.rightButtonTitle = lang(@"🔍");
        self.isRightButton = YES;
        self.rightButton   = @selector(actionButton:);
        [self getButtonCallback];
        [self getCellModels];
        [IDOBluetoothManager shareInstance].delegate = self;
        [IDOBluetoothManager shareInstance].rssiNum  = 100;
        
    }
    return self;
}

- (void)actionButton:(UIButton *)sender
{
    FuncViewController * funcVc = (FuncViewController *)[IDODemoUtility getCurrentVC];
    ScanDemoViewController * scan = [[ScanDemoViewController alloc]init];
    WEAKSELF
    scan.scanQRcodeCallback = ^(NSString * _Nonnull str,UIViewController * vc) {
       NSRange range = [str rangeOfString:@"m="];
       if (range.location != NSNotFound) {
           NSString * newStr = [str substringFromIndex:range.location + 2];
           weakSelf.macStr = [newStr stringByReplacingOccurrencesOfString:@":" withString:@""];
           weakSelf.isAdd = YES;
           [IDOBluetoothManager shareInstance].isMandatoryManual = YES;
           [IDOBluetoothManager startScan];
       }else {
           [funcVc showToastWithText:@"the mac address does not exist"];
       }
       [vc dismissViewControllerAnimated:YES completion:nil];
    };
    [funcVc presentViewController:scan animated:YES completion:nil];
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
        strongSelf.isAdd = NO;
        strongSelf.needConnectDeviceMode = model;
        [funcVc showLoadingWithMessage:lang(@"device switching")];
        [NSObject cancelPreviousPerformRequestsWithTarget:strongSelf selector:@selector(switchDeviceTimeout) object:nil];
        [strongSelf performSelector:@selector(switchDeviceTimeout) withObject:nil afterDelay:20]; //根据自身需求修改超时时长
        [IDOFoundationCommand switchDeviceCommand:model.macAddr
                                      isMandatory:NO
                                         callback:^(int errorCode) {
            if (errorCode == 0) {
                [IDOBluetoothManager shareInstance].isReconnect = YES;
                [IDOBluetoothManager shareInstance].isDetectionAuthCode = NO;
                if (!__IDO_CONNECTED__) {
                    [IDOBluetoothManager startScan];
                }else {
                   [IDOBluetoothManager cancelCurrentPeripheralConnection];
                }
            }else {
               [NSObject cancelPreviousPerformRequestsWithTarget:strongSelf selector:@selector(switchDeviceTimeout) object:nil];
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
        [IDOFoundationCommand bindingCommand:model waitForSure:^{
            FuncViewController * funcVc = (FuncViewController *)[IDODemoUtility getCurrentVC];
            [funcVc showLoadingWithMessage:[NSString stringWithFormat:@"%@...",lang(@"bind")]];
        } callback:^(IDO_BIND_STATUS status, int errorCode) {
            FuncViewController * funcVc = (FuncViewController *)[IDODemoUtility getCurrentVC];
            if (errorCode == 0) {
                if (status == IDO_BLUETOOTH_BIND_SUCCESS) { //绑定成功
                    [funcVc showToastWithText:lang(@"bind success")];
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
    /******************⚠️切换手环成功后要发起绑定***********************/
    if (self.isAdd) {
        [self bindDevice];
    }else {
        [funcVc showLoadingWithMessage:@"start detection encryption auth..."];
       __weak typeof(self) weakSelf = self;
       [IDOFoundationCommand switchDeviceDetectionEncryptionAuthCallback:^(int errorCode) {
           __strong typeof(self) strongSelf = weakSelf;
           if(errorCode == 0) { // 切换成功
              [funcVc showToastWithText:lang(@"device switch success")];
           }else if(errorCode == 41) { //授权码不一致=>设备被其他手机绑定
              [funcVc showToastWithText:lang(@"device encryption auth code don't same")];
           }else if(errorCode == 35) { //没有绑定
              [funcVc showToastWithText:lang(@"device unbind")];
           }else if(errorCode == 6){ //设备不支持
              [strongSelf bindDevice];
           }else { //失败
              [funcVc showToastWithText:lang(@"device switch failed")];
           }
       }];
    }
    return YES;
}

- (void)bluetoothManager:(IDOBluetoothManager *)manager
              allDevices:(NSArray<IDOPeripheralModel *> *)allDevices
              otaDevices:(NSArray<IDOPeripheralModel *> *)otaDevices
{
    for (IDOPeripheralModel * model in allDevices) {
        if (  [model.macAddr isEqualToString:self.needConnectDeviceMode.macAddr]
            ||[model.uuidStr isEqualToString:self.needConnectDeviceMode.uuidStr]
            ||[model.macAddr isEqualToString:self.macStr]) {
            [IDOBluetoothManager connectDeviceWithModel:model];
            [IDOBluetoothManager stopScan];
            break;
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
    if (error.code == IDO_BLUETOOTH_CONNECT_TIME_OUT_TYPE) {
        FuncViewController * funcVc = (FuncViewController *)[IDODemoUtility getCurrentVC];
        [funcVc showToastWithText:lang(@"connected failed")];
        [IDOBluetoothManager stopScan];
    }
}

@end
