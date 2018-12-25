//
//  ViewController.m
//  IDOBluetoothDemo
//
//  Created by hedongyang on 2018/8/31.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
@end

@implementation BaseViewController

- (void)dealloc
{
    if (IDO_BLUE_ENGINE.managerEngine) {
        [IDO_BLUE_ENGINE.managerEngine removeObserver:self forKeyPath:@"idoManager.state"];
        [IDO_BLUE_ENGINE.managerEngine removeObserver:self forKeyPath:@"idoManager.errorCode"];
    }
}

- (UILabel *)statusLabel
{
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,40)];
        _statusLabel.textColor = [UIColor blackColor];
        _statusLabel.textAlignment = NSTextAlignmentLeft;
        _statusLabel.font = [UIFont boldSystemFontOfSize:16];
        _statusLabel.backgroundColor = [UIColor colorWithRed:236/255.0f green:236/255.0f blue:236/255.0f alpha:1.0f];
        _statusLabel.text = __IDO_PERIPHERAL__.state == CBPeripheralStateConnected ? @"  已连接  " : @"  已断开  ";
    }
    return _statusLabel;
}

- (void)showLoadingWithMessage:(NSString *)message
{
    self.progressHUD.mode = MBProgressHUDModeIndeterminate;
    self.progressHUD.label.text = message;
    [self.progressHUD showAnimated:YES];
}

- (void)showToastWithText:(NSString *)message
{
    self.progressHUD.mode = MBProgressHUDModeText;
    self.progressHUD.label.text = message;
    [self.progressHUD showAnimated:YES];
    [self.progressHUD hideAnimated:YES afterDelay:2];
}

- (void)showUpdateProgress:(float)progress
{
    self.progressHUD.mode = MBProgressHUDModeDeterminateHorizontalBar;
    self.progressHUD.label.text = [NSString stringWithFormat:@"文件升级:%.0f%@",progress*100.0f,@"%"];
    self.progressHUD.progress = progress;
    [self.progressHUD showAnimated:YES];
}

- (void)showSyncProgress:(float)progress
{
    self.progressHUD.mode = MBProgressHUDModeDeterminateHorizontalBar;
    self.progressHUD.label.text = [NSString stringWithFormat:@"同步数据:%.0f%@",progress*100.0f,@"%"];
    self.progressHUD.progress = progress;
    [self.progressHUD showAnimated:YES];
}

- (MBProgressHUD *)progressHUD
{
    if (!_progressHUD) {
        _progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:_progressHUD];
    }
    return _progressHUD;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self modificationNavigationBarStyle];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.translucent=NO;
    self.view.backgroundColor = [UIColor whiteColor];
    if (IDO_BLUE_ENGINE.managerEngine) {
        [IDO_BLUE_ENGINE.managerEngine addObserver:self forKeyPath:@"idoManager.state" options:NSKeyValueObservingOptionNew context:nil];
        [IDO_BLUE_ENGINE.managerEngine addObserver:self forKeyPath:@"idoManager.errorCode" options:NSKeyValueObservingOptionNew context:nil];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"idoManager.state"]) {
        IDO_BLUETOOTH_MANAGER_STATE state = (IDO_BLUETOOTH_MANAGER_STATE)[change[NSKeyValueChangeNewKey] integerValue];
        if (state == IDO_MANAGER_STATE_DID_CONNECT) {
            self.statusLabel.text = @"  已连接  ";
            [self showToastWithText:@"设备连接成功"];
        }
        else if(state == IDO_MANAGER_STATE_POWEREDOFF) {
            self.statusLabel.text = @"  已断开  ";
            [self showToastWithText:@"设备已断开"];
        }
        else if((   state == IDO_MANAGER_STATE_AUTO_OTA_CONNECT
                 || state == IDO_MANAGER_STATE_AUTO_CONNECT
                 || state == IDO_MANAGER_STATE_MANUAL_OTA_CONNECT
                 || state == IDO_MANAGER_STATE_MANUAL_CONNECT ) && (__IDO_BIND__ || __IDO_OTA__)){
            self.statusLabel.text = @"  正在连接...  ";
            [self showLoadingWithMessage:@"正在连接..."];
        }else if ((     state == IDO_MANAGER_STATE_POWEREDON
                     || state == IDO_MANAGER_STATE_AUTO_SCANING ) && (__IDO_BIND__ || __IDO_OTA__)) {
            self.statusLabel.text = @"  正在扫描...  ";
            [self showLoadingWithMessage:@"正在扫描..."];
        }
    }else if ([keyPath isEqualToString:@"idoManager.errorCode"]) {
        IDO_BLUETOOTH_CONNECT_ERROR_TYPE errorCode = (IDO_BLUETOOTH_CONNECT_ERROR_TYPE)[change[NSKeyValueChangeNewKey] integerValue];
        switch (errorCode) {
            case IDO_BLUETOOTH_UUID_EMPTY_TYPE:
                 [self showToastWithText:@"uuidStr为空蓝牙不能自动连接"];
                break;
            case IDO_BLUETOOTH_UNBOUND_TYPE:
                [self showToastWithText:@"未绑定设备蓝牙不能自动连接"];
                break;
            case IDO_BLUETOOTH_POWERED_OFF_TYPE:
                [self showToastWithText:@"蓝牙关闭不能自动连接"];
                break;
            case IDO_BLUETOOTH_PERIPHERAL_DON_EXIST:
                [self showToastWithText:@"外围设备不存在"];
                break;
            case IDO_BLUETOOTH_DIS_CONNECT_TYPE:
                [self showToastWithText:@"蓝牙断开连接"];
                break;
            case IDO_BLUETOOTH_CONNECT_FAIL_TYPE:
                [self showToastWithText:@"蓝牙连接失败"];
                break;
            case IDO_BLUETOOTH_CONNECT_TIME_OUT_TYPE:
                [self showToastWithText:@"蓝牙连接超时"];
                break;
            case IDO_BLUETOOTH_SCAN_CONNECT_TIME_OUT_TYPE:
                [self showToastWithText:@"蓝牙扫描连接超时"];
                break;
            case IDO_BLUETOOTH_DISCOVER_SERVICE_FAIL_TYPE:
                [self showToastWithText:@"蓝牙发现外围设备服务失败"];
                break;
            case IDO_BLUETOOTH_DISCOVER_CHARACTERISTICS_TYPE:
                [self showToastWithText:@"蓝牙发现外围设备特征失败"];
                break;
            case IDO_BLUETOOTH_DATA_EXCHANGE_ERROR_TYPE:
                [self showToastWithText:@"蓝牙数据交换错误"];
                break;
            default:
                break;
        }
    }
}

- (void)modificationNavigationBarStyle
{
    UIBarButtonItem * backButtonItem = [[UIBarButtonItem alloc] init];
    backButtonItem.style = UIBarButtonItemStyleDone;
    backButtonItem.title = @"";
    self.navigationItem.backBarButtonItem = backButtonItem;
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
}

- (BasePickerView *)pickerView
{
    if (!_pickerView) {
        _pickerView = [[BasePickerView alloc]init];
        [self.view addSubview:_pickerView];
        [_pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.right.equalTo(@0);
            make.top.equalTo(self.view.mas_bottom);
            make.height.equalTo(@216);
        }];
    }
    return _pickerView;
}

- (BaseDatePickerView *)datePickerView
{
    if (!_datePickerView) {
        _datePickerView = [[BaseDatePickerView alloc]init];
        [self.view addSubview:_datePickerView];
        [_datePickerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.right.equalTo(@0);
            make.top.equalTo(self.view.mas_bottom);
            make.height.equalTo(@216);
        }];
    }
    return _datePickerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

