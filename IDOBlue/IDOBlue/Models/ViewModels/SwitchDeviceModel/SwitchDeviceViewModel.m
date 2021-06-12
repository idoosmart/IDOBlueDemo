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
#import "ScanViewController.h"
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
//    [IDOBluetoothManager shareInstance].delegate = nil;
    //退出添加设备需要把手动模式设置为No
    [IDOBluetoothManager shareInstance].isMandatoryManual = NO;
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
    funcVc.menuView.isLeftType = NO;
    funcVc.menuView.listArray = @[@{@"icon":@"add",@"title":lang(@"add devices")},@{@"icon":@"scan1",@"title":lang(@"scan add devices")}];
    __weak typeof(self) weakSelf = self;
    funcVc.menuView.selectMenuList = ^(NSInteger index) {
        if (index == 0) { //列表连接
            [IDOBluetoothManager shareInstance].isMandatoryManual = YES;
            ScanViewController * scanVC  = [[ScanViewController alloc]init];
            scanVC.selectList = YES;
            scanVC.selectDevice = ^(IDOPeripheralModel *model) {
                __strong typeof(self) strongSelf = weakSelf;
                strongSelf.isAdd = YES;
                [IDOBluetoothManager shareInstance].delegate = strongSelf;
                [IDOBluetoothManager connectDeviceWithModel:model];
            };
            UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:scanVC];
            [[IDODemoUtility getCurrentVC] presentViewController:nav animated:YES completion:nil];
        }else if (index == 1){ //扫描连接
            ScanDemoViewController * scan = [[ScanDemoViewController alloc]init];
            __weak typeof(self) weakSelf = self;
            FuncViewController * funvc = (FuncViewController *)[IDODemoUtility getCurrentVC];
            scan.scanQRcodeCallback = ^(NSString * _Nonnull str,UIViewController * vc) {
               NSRange range = [str rangeOfString:@"m="];
               if (range.location != NSNotFound) {
                   NSString * newStr = [str substringFromIndex:range.location + 2];
                   weakSelf.macStr = [newStr stringByReplacingOccurrencesOfString:@":" withString:@""];
                   weakSelf.isAdd = YES;
                   [IDOBluetoothManager shareInstance].isMandatoryManual = YES;
                   [IDOBluetoothManager startScan];
               }else {
                   [funvc showToastWithText:@"the mac address does not exist"];
               }
               [vc dismissViewControllerAnimated:YES completion:nil];
            };
            UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:scan];
            [funvc presentViewController:nav animated:YES completion:nil];
        }
    };
    funcVc.menuView.hidden = NO;
}

- (NSArray *)allDevices
{
    //查询所有绑定过或者连接过的设备
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
        //全局变量在连接的时候区分切换设备还是添加设备
        strongSelf.isAdd = NO;
        //已经绑定过的设备进行切换设备
        strongSelf.needConnectDeviceMode = model;
        [funcVc showLoadingWithMessage:lang(@"device switching")];
        [NSObject cancelPreviousPerformRequestsWithTarget:strongSelf selector:@selector(switchDeviceTimeout) object:nil];
        [strongSelf performSelector:@selector(switchDeviceTimeout) withObject:nil afterDelay:20];
        [IDOBluetoothManager shareInstance].delegate = strongSelf;
        //根据自身需求修改超时时长
        //传入的Mac地址是已经绑定过的设备的Mac地址
        [IDOFoundationCommand switchDeviceCommand:model.macAddr
                                      isMandatory:NO //NO: 只有绑定的设备才能切换，YES: 未绑定的设备也能切换
                                         callback:^(int errorCode) {
            if (errorCode == 0) {
                /**
                 成功初始化切换设备信息
                 蓝牙需要设置重连=>YES
                 连接鉴权设置=>NO
                 */
                [IDOBluetoothManager shareInstance].isReconnect = YES;
                [IDOBluetoothManager shareInstance].isDetectionAuthCode = NO;
                if (!__IDO_CONNECTED__) {//未连接则执行扫描
                    [IDOBluetoothManager startScan];
                }else {//已连接则断开连接，启动自动扫描连接
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
    IDOSetBindingInfoBluetoothModel * model = [[IDOSetBindingInfoBluetoothModel alloc]init];
    [IDOFoundationCommand bindingCommand:model waitForSure:^{
        FuncViewController * funcVc = (FuncViewController *)[IDODemoUtility getCurrentVC];
        [funcVc showLoadingWithMessage:[NSString stringWithFormat:@"%@...",lang(@"bind")]];
    } callback:^(IDO_BIND_STATUS status, int errorCode) {
        FuncViewController * funcVc = (FuncViewController *)[IDODemoUtility getCurrentVC];
        [IDOBluetoothManager shareInstance].delegate = nil;
        if (errorCode == 0) {
            if (status == IDO_BLUETOOTH_BIND_SUCCESS) { //绑定成功
                [funcVc showToastWithText:lang(@"bind success")];
            }else if (status == IDO_BLUETOOTH_BINDED) { //已经绑定
                [funcVc showToastWithText:lang(@"bind failed")];
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

#pragma mark === IDOBluetoothManagerDelegate ===
- (BOOL)bluetoothManager:(IDOBluetoothManager *)manager
           centerManager:(CBCentralManager *)centerManager
    didConnectPeripheral:(CBPeripheral *)peripheral
               isOatMode:(BOOL)isOtaMode
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(switchDeviceTimeout) object:nil];
    FuncViewController * funcVc = (FuncViewController *)[IDODemoUtility getCurrentVC];
    /******************⚠️切换手环成功后要发起绑定***********************/
    [IDOBluetoothManager shareInstance].delegate = nil;
    if (self.isAdd) {
        //添加设备连接成功后执行绑定即可
        [self bindDevice];
    }else {
        [funcVc showLoadingWithMessage:lang(@"start detection encryption auth...")];
       __weak typeof(self) weakSelf = self;
       /**
        切换设备连接成功，需要检测设备加密授权码，如果当前设备不支持鉴权，则返回错误码6，
        请按执行正常绑定操作。
        */
       [IDOFoundationCommand switchDeviceDetectionEncryptionAuthCallback:^(int errorCode) {
           __strong typeof(self) strongSelf = weakSelf;
           if(errorCode == 0) { // 切换成功
              [funcVc showToastWithText:lang(@"device switch success")];
           }else if(errorCode == 41) { //授权码不一致=>设备被其他手机绑定
              [funcVc showToastWithText:lang(@"device encryption auth code don't same")];
           }else if(errorCode == 35) { //没有绑定
              [funcVc showToastWithText:lang(@"device unbind")];
              [strongSelf bindDevice];
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
            ||[model.macAddr isEqualToString:self.macStr]) { //匹配对应的设备
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
    if (self.isAdd) {
        //在添加设备时连接失败需要重新设置手动模式
        [IDOBluetoothManager shareInstance].isMandatoryManual = YES;
    }
    if (error.code == IDO_BLUETOOTH_CONNECT_TIME_OUT_TYPE) {
        FuncViewController * funcVc = (FuncViewController *)[IDODemoUtility getCurrentVC];
        [funcVc showToastWithText:lang(@"connected failed")];
        [IDOBluetoothManager stopScan];
    }
}

@end
