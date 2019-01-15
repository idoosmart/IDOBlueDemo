//
//  ScanViewController.m
//  IDOBluetoothDemo
//
//  Created by hedongyang on 2018/8/31.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "ScanViewController.h"
#import "FuncViewController.h"
#import "UpdateFirmwareViewModel.h"
#import "FuncViewModel.h"
#import "ModeSelectViewModel.h"
#import "AuthTextFieldView.h"
#import "BindDeviceView.h"
#import "ScanTableViewCell.h"
#import "MBProgressHUD.h"
#import "TimerAnimatView.h"
#import "TipPoweredOffView.h"

@interface ScanViewController ()<UITableViewDelegate,UITableViewDataSource,IDOBluetoothManagerDelegate,AuthTextFieldViewDelegate,BindDeviceViewDelegate>
@property (nonatomic,strong)  NSArray * devices;
@property (nonatomic,strong)  CBCentralManager * centralManager;
@property (nonatomic,strong)  IDOPeripheralModel * currentModel;
@property (nonatomic,strong)  AuthTextFieldView * authView;
@property (nonatomic,strong)  BindDeviceView * bindView;
@property (nonatomic,strong)  MBProgressHUD * progressHUD;
@property (nonatomic,strong)  UILabel * statusLabel;
@property (nonatomic,strong)  UILabel * timerLabel;
@property (nonatomic,copy)    void(^modeSelectCallback)(UIViewController * viewController,NSInteger type);
@end

@implementation ScanViewController

- (void)dealloc
{
    if (IDO_BLUE_ENGINE.managerEngine) {
        [IDO_BLUE_ENGINE.managerEngine removeObserver:self forKeyPath:@"idoManager.state"];
        [IDO_BLUE_ENGINE.managerEngine removeObserver:self forKeyPath:@"idoManager.errorCode"];
        [IDO_BLUE_ENGINE.managerEngine removeObserver:self forKeyPath:@"idoManager.manualConnectTotalTime"];
        [IDO_BLUE_ENGINE.managerEngine removeObserver:self forKeyPath:@"idoManager.autoConnectTotalTime"];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.statusLabel.text = __IDO_PERIPHERAL__.state == CBPeripheralStateConnected ? @"已连接" : @"已断开";
}

- (UILabel *)statusLabel
{
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc]initWithFrame:CGRectMake(16,0,(self.view.frame.size.width - 32)/2,40)];
        _statusLabel.textColor = [UIColor blackColor];
        _statusLabel.textAlignment = NSTextAlignmentLeft;
        _statusLabel.font = [UIFont boldSystemFontOfSize:16];
        _statusLabel.backgroundColor = [UIColor clearColor];
    }
    return _statusLabel;
}

- (UILabel *)timerLabel
{
    if (!_timerLabel) {
        _timerLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2,0,(self.view.frame.size.width - 32)/2,40)];
        _timerLabel.textColor = [UIColor blackColor];
        _timerLabel.textAlignment = NSTextAlignmentCenter;
        _timerLabel.font = [UIFont boldSystemFontOfSize:16];
        _timerLabel.backgroundColor = [UIColor clearColor];
    }
    return _timerLabel;
}


- (void)refreshButtonState
{
    self.currentModel = nil;
    self.bindView.hidden = YES;
    self.authView.hidden = YES;
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height - 40);
    TimerAnimatView * timerAnimatView = [[TimerAnimatView alloc]initWithFrame:frame];
    __weak typeof(self) weakSelf = self;
    timerAnimatView.TimeOverBlock = ^{
        __strong typeof(self) strongSelf = weakSelf;
        strongSelf.tableView.tableFooterView = [UIView new];
    };
    self.tableView.tableFooterView = timerAnimatView;
    [timerAnimatView countDown:3];
    
    [self modificationNavigationBarStyle];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"扫描设备";
    
    if (IDO_BLUE_ENGINE.managerEngine) {
        [IDO_BLUE_ENGINE.managerEngine addObserver:self forKeyPath:@"idoManager.state" options:NSKeyValueObservingOptionNew context:nil];
        [IDO_BLUE_ENGINE.managerEngine addObserver:self forKeyPath:@"idoManager.errorCode" options:NSKeyValueObservingOptionNew context:nil];
        [IDO_BLUE_ENGINE.managerEngine addObserver:self forKeyPath:@"idoManager.manualConnectTotalTime" options:NSKeyValueObservingOptionNew context:nil];
        [IDO_BLUE_ENGINE.managerEngine addObserver:self forKeyPath:@"idoManager.autoConnectTotalTime" options:NSKeyValueObservingOptionNew context:nil];
    }
    
    [self addRightButton];
    [self creatRefreshing];
    
    UIView * headView = [[UIView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,40)];
    headView.backgroundColor = [UIColor colorWithRed:236/255.0f green:236/255.0f blue:236/255.0f alpha:1.0f];
    [headView addSubview:self.statusLabel];
    [headView addSubview:self.timerLabel];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = headView;
    
    [IDOBluetoothManager registerWtihDelegate:self];
    [IDOBluetoothManager shareInstance].rssiNum = 100;

}


- (MBProgressHUD *)progressHUD
{
    if (!_progressHUD) {
        _progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:_progressHUD];
    }
    return _progressHUD;
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
    self.progressHUD.label.numberOfLines = 2;
    [self.progressHUD showAnimated:YES];
    [self.progressHUD hideAnimated:YES afterDelay:2];
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

- (void)creatRefreshing {
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"拼命扫描……"];
    self.refreshControl.tintColor = [UIColor grayColor];
    [self.refreshControl addTarget:self action:@selector(refreshAction)forControlEvents:UIControlEventValueChanged];
}

- (void)refreshAction
{
    NSInteger rssiNum = [[NSUserDefaults standardUserDefaults]integerForKey:RSSI_KEY];
    [IDOBluetoothManager shareInstance].rssiNum = rssiNum > 0 ? rssiNum : 80;
    [IDOBluetoothManager startScan];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.refreshControl endRefreshing];
    });
}

- (void)addRightButton
{
    UIBarButtonItem * rightButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"参数选择"
                                                                         style:UIBarButtonItemStylePlain
                                                                        target:self
                                                                        action:@selector(rightAction)];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}

- (void)addLeftButton
{
    UIBarButtonItem * leftButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"解绑"
                                                                         style:UIBarButtonItemStylePlain
                                                                        target:self
                                                                        action:@selector(leftAction)];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
}

- (void)rightAction
{
    FuncViewController * vc = [[FuncViewController alloc]init];
    ModeSelectViewModel * selectModel = [ModeSelectViewModel new];
    vc.model = selectModel;
    vc.title = @"参数选择";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)leftAction
{
    if (!IDO_BLUE_ENGINE.managerEngine.isConnected)return;
    [IDOBluetoothManager cancelCurrentPeripheralConnection];
    [self.tableView reloadData];
}

- (void)bindAction:(UIButton *)sender
{
    IDOSetBindingInfoBluetoothModel * model = [[IDOSetBindingInfoBluetoothModel alloc]init];
    __weak typeof(self) weakSelf = self;
    [IDOFoundationCommand bindingCommand:model callback:^(IDO_BIND_STATUS status, int errorCode) {
        __strong typeof(self) strongSelf = weakSelf;
        if (errorCode == 0) {
            if (status == IDO_BLUETOOTH_BIND_SUCCESS) { //绑定成功
                [strongSelf showToastWithText:@"绑定成功"];
                IDOSetBindingInfoBluetoothModel * model1 = [IDOSetBindingInfoBluetoothModel currentModel];
                if (model1.authLength > 0)return;
                [strongSelf setRootViewController];
            }else if (status == IDO_BLUETOOTH_BINDED) { //已经绑定
                
            }else if (status == IDO_BLUETOOTH_BIND_FAILED) { //绑定失败
                
            }else if (status == IDO_BLUETOOTH_NEED_AUTH) { //需要授权绑定
                [strongSelf showAuthView];
            }else if (status == IDO_BLUETOOTH_REFUSED_BINDED) {
                [strongSelf showToastWithText:@"拒绝绑定"];
            }
        }else { //绑定失败
            [strongSelf showToastWithText:@"绑定失败"];
        }
    }];
}

- (void)updateAction:(UIButton *)sender
{
    UINavigationController * rootvc =  (UINavigationController *)[UIApplication sharedApplication].delegate.window.rootViewController;
    UIViewController * firstvc = [rootvc.viewControllers firstObject];
    if ([firstvc isKindOfClass:[ScanViewController class]]) {
        [IDOFoundationCommand getMacAddrCommand:nil];
        FuncViewController * update = [[FuncViewController alloc]init];
        update.model = [UpdateFirmwareViewModel new];
        update.title = @"固件升级";
        UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:update];
        [self presentViewController:nav animated:YES completion:nil];
    }else {
        FuncViewController * update = (FuncViewController *) firstvc;
        UpdateFirmwareViewModel * updateModel = [UpdateFirmwareViewModel new];
        updateModel.isLeftButton = NO;
        update.model = updateModel;
        update.title = @"固件升级";
        [update reloadData];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)setRootViewController
{
    UINavigationController * rootvc =  (UINavigationController *)[UIApplication sharedApplication].delegate.window.rootViewController;
    UIViewController * firstvc = [rootvc.viewControllers firstObject];
    if ([firstvc isKindOfClass:[ScanViewController class]]) {
        FuncViewController * funcVc = [[FuncViewController alloc]init];
        funcVc.model = [FuncViewModel new];
        funcVc.title = @"功能列表";
        UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:funcVc];
        [self presentViewController:nav animated:YES completion:nil];
    }else {
        FuncViewController * funcVc = (FuncViewController *) firstvc;
        funcVc.title = @"功能列表";
        FuncViewModel * funcModel = [FuncViewModel new];
        funcModel.isRightButton = NO;
        funcVc.model = funcModel;
        [funcVc reloadData];
       [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)showBindView
{
    if (!_bindView) {
        _bindView = [[BindDeviceView alloc]initWithFrame:self.view.bounds];
        _bindView.delegate = self;
        [self.view addSubview:_bindView];
    }
    NSInteger mode = [[NSUserDefaults standardUserDefaults]integerForKey:PRODUCTION_MODE_KEY];
    _bindView.tipLabel.text = [NSString stringWithFormat:@"设备已连接成功\n是否需要%@设备",mode == 0 ? @"升级":self.currentModel.isOta ? @"升级":@"绑定"];
    [_bindView show];
}

- (void)cancelBindButton
{
    [self leftAction];
}

- (void)allowBinding
{
    NSInteger mode = [[NSUserDefaults standardUserDefaults]integerForKey:PRODUCTION_MODE_KEY];
    if (mode == 0 || self.currentModel.isOta) {
        [self updateAction:nil];
    }else {
        [self bindAction:nil];
    }
}

- (void)showAuthView
{
    if (!_authView) {
        _authView = [[AuthTextFieldView alloc]initWithFrame:self.view.bounds];
        _authView.delegate = self;
        [self.view addSubview:_authView];
    }
    [_authView show];
}

- (void)cancelButton
{
    [self leftAction];
}

- (void)authBindingWithCode:(NSString *)codeStr
{
    if (codeStr.length == 0)return;
    __weak typeof(self) weakSelf = self;
    IDOSetBindingInfoBluetoothModel * model = [IDOSetBindingInfoBluetoothModel currentModel];
    model.authCode = codeStr;
    [IDOFoundationCommand setAuthCodeCommand:model callback:^(int errorCode) {
        __strong typeof(self) strongSelf = weakSelf;
        if (errorCode == 0) {
            [strongSelf showToastWithText:@"绑定成功"];
            [strongSelf setRootViewController];
        }else {
            [strongSelf showToastWithText:@"绑定失败"];
        }
    }];
}

#pragma mark === IDOBluetoothManagerDelegate ===
- (BOOL)bluetoothManager:(IDOBluetoothManager *)manager
           centerManager:(CBCentralManager *)centerManager
    didConnectPeripheral:(CBPeripheral *)peripheral
               isOatMode:(BOOL)isOtaMode
{
    [self showToastWithText:@"设备连接成功"];
    [self showBindView];
    return YES;
}

- (void)bluetoothManager:(IDOBluetoothManager *)manager
              allDevices:(NSArray<IDOPeripheralModel *> *)allDevices
              otaDevices:(NSArray<IDOPeripheralModel *> *)otaDevices
{
    self.devices = allDevices;
    self.currentModel = nil;
    [self.tableView reloadData];
}

- (void)bluetoothManager:(IDOBluetoothManager *)manager
          didUpdateState:(IDO_BLUETOOTH_MANAGER_STATE)state
{
    
}

- (void)bluetoothManager:(IDOBluetoothManager *)manager
  connectPeripheralError:(NSError *)error
{
    [self showToastWithText:@"设备连接失败"];
    [self.refreshControl endRefreshing];
}

#pragma mark === UITableViewDataSource ===
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.devices.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"cellIdentifier";
    ScanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[ScanTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    }
    
    IDOPeripheralModel * model =  [self.devices objectAtIndex:indexPath.row];
    cell.peripheralModel = model;
    return cell;
}

#pragma mark === UITableViewDelegate ===
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.currentModel = self.devices[indexPath.row];
    [self showLoadingWithMessage:@"设备连接中..."];
    [IDOBluetoothManager connectDeviceWithModel:self.currentModel];
}


- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"idoManager.state"]) {
        IDO_BLUETOOTH_MANAGER_STATE state = (IDO_BLUETOOTH_MANAGER_STATE)[change[NSKeyValueChangeNewKey] integerValue];
        if (state == IDO_MANAGER_STATE_DID_CONNECT) {
            self.statusLabel.text = @"已连接";
            [self showToastWithText:@"设备连接成功"];
        }
        else if(state == IDO_MANAGER_STATE_CONNECT_FAILED) {
            self.statusLabel.text = @"已断开";
            [self showToastWithText:@"设备已断开"];
        }else if (state == IDO_MANAGER_STATE_POWEREDOFF) {
            [TipPoweredOffView show];
        }else if (state == IDO_MANAGER_STATE_POWEREDON) {
            [TipPoweredOffView hidView];
        }
    }else if ([keyPath isEqualToString:@"idoManager.manualConnectTotalTime"]) {
        NSInteger totalTime = [change[NSKeyValueChangeNewKey] integerValue];
        if (totalTime <= 0)return;
        self.timerLabel.text = [NSString stringWithFormat:@"手动连接时长：%ld",totalTime];
    }else if ([keyPath isEqualToString:@"idoManager.autoConnectTotalTime"]) {
        NSInteger totalTime = [change[NSKeyValueChangeNewKey] integerValue];
        if (totalTime <= 0)return;
        self.timerLabel.text = [NSString stringWithFormat:@"自动连接时长：%ld",totalTime];
    }
}


@end
