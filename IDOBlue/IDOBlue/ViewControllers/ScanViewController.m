//
//  ScanViewController.m
//  IDOBluetoothDemo
//
//  Created by hedongyang on 2018/8/31.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "ScanViewController.h"
#import "FuncViewController.h"
#import "UpdateMainViewModel.h"
#import "FuncViewModel.h"
#import "ModeSelectViewModel.h"
#import "AuthTextFieldView.h"
#import "BindDeviceView.h"
#import "ScanTableViewCell.h"
#import "MBProgressHUD.h"
#import "TimerAnimatView.h"
#import "TipPoweredOffView.h"
#import "IDOConsoleBoard.h"

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
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = lang(@"scan device");
    self.statusLabel.text = IDO_BLUE_ENGINE.managerEngine.isConnected ? lang(@"connected") : IDO_BLUE_ENGINE.managerEngine.isConnecting ? lang(@"connecting") : lang(@"scanning");
    self.navigationItem.rightBarButtonItem.title = lang(@"🔧");
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:lang(@"very hard scan")];
    
    [IDOBluetoothManager shareInstance].delegate = self;
    [IDOBluetoothManager shareInstance].rssiNum  = 100;
    [IDOBluetoothManager startScan];
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf refreshButtonState];
    });
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [IDOBluetoothManager shareInstance].delegate = nil;
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
    if ([IDOConsoleBoard borad].isShow) {
        [[IDOConsoleBoard borad] show];
    }
    self.tableView.tableFooterView = [UIView new];
    [self modificationNavigationBarStyle];
    self.view.backgroundColor = [UIColor whiteColor];

    [self addRightButton];
    [self creatRefreshing];
    
    UIView * headView = [[UIView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,40)];
    headView.backgroundColor = [UIColor colorWithRed:236/255.0f green:236/255.0f blue:236/255.0f alpha:1.0f];
    [headView addSubview:self.statusLabel];
    [headView addSubview:self.timerLabel];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = headView;
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(listenConnectState:)
                                                name:IDOBluetoothConnectStateNotifyName
                                              object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(listenConnectError:)
                                                name:IDOBluetoothConnectErrorNotifyName
                                              object:nil];
}

- (void)listenConnectState:(NSNotification *)notivication
{
    NSDictionary * dic = notivication.object;
    if (!dic)return;
    IDO_BLUETOOTH_MANAGER_STATE state = [[dic valueForKey:@"state"] integerValue];
    if (state == IDO_MANAGER_STATE_DID_CONNECT) {
        self.statusLabel.text = lang(@"connected");
        [self showToastWithText:lang(@"connected success")];
    }else if(   state == IDO_MANAGER_STATE_CONNECT_FAILED
            || state == IDO_MANAGER_STATE_DIS_CONNECT) {
        self.statusLabel.text = lang(@"disconnected");
    }else if (   state == IDO_MANAGER_STATE_AUTO_CONNECT
              || state == IDO_MANAGER_STATE_AUTO_OTA_CONNECT
              || state == IDO_MANAGER_STATE_MANUAL_CONNECT) {
        self.statusLabel.text = lang(@"connecting");
        [self showLoadingWithMessage:lang(@"connecting")];
    }else if (state == IDO_MANAGER_STATE_SCAN_STOP) {
        self.statusLabel.text = lang(@"suspend scan");
        [self showToastWithText: lang(@"device suspend scan")];
    }else if (state == IDO_MANAGER_STATE_POWEREDOFF) {
        self.statusLabel.text = lang(@"disconnected");
        [TipPoweredOffView show];
    }else if (state == IDO_MANAGER_STATE_POWEREDON) {
        [TipPoweredOffView hidView];
    }else if (state == IDO_MANAGER_STATE_MANUAL_SCANING) {
        self.statusLabel.text = lang(@"scanning");
        [self showToastWithText:lang(@"scanning")];
    }
}

- (void)listenConnectError:(NSNotification *)notivication
{
    [self showToastWithText: lang(@"connected failed")];
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
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:lang(@"very hard scan")];
    self.refreshControl.tintColor = [UIColor grayColor];
    [self.refreshControl addTarget:self action:@selector(refreshAction)forControlEvents:UIControlEventValueChanged];
    [self.refreshControl beginRefreshing];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.refreshControl endRefreshing];
    });
}

- (void)refreshAction
{
    self.statusLabel.text = lang(@"scanning");
    NSInteger rssiNum = [[NSUserDefaults standardUserDefaults]integerForKey:RSSI_KEY];
    [IDOBluetoothManager shareInstance].rssiNum = rssiNum > 0 ? rssiNum : 80;
    [IDOBluetoothManager cancelCurrentPeripheralConnection];
    [IDOBluetoothManager stopScan];
    [IDOBluetoothManager startScan];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.refreshControl endRefreshing];
    });
}

- (void)addRightButton
{
    UIBarButtonItem * rightButtonItem = [[UIBarButtonItem alloc] initWithTitle:lang(@"🔧")
                                                                         style:UIBarButtonItemStylePlain
                                                                        target:self
                                                                        action:@selector(rightAction)];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}

- (void)addLeftButton
{
    UIBarButtonItem * leftButtonItem = [[UIBarButtonItem alloc] initWithTitle:lang(@"unbind")
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
    vc.title = lang(@"parameter select");
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)leftAction
{
    if (!IDO_BLUE_ENGINE.managerEngine.isConnected)return;
    IDO_BLUE_ENGINE.peripheralEngine.isOta  = NO;
    IDO_BLUE_ENGINE.peripheralEngine.isBind = NO;
    [IDOBluetoothManager cancelCurrentPeripheralConnection];
    [self.tableView reloadData];
}

static BOOL BIND_STATE = NO;
- (void)bindAction:(UIButton *)sender
{
    BIND_STATE = NO;
    [self showLoadingWithMessage:[NSString stringWithFormat:@"%@...",lang(@"bind")]];
    IDOSetBindingInfoBluetoothModel * model = [[IDOSetBindingInfoBluetoothModel alloc]init];
    __weak typeof(self) weakSelf = self;
    [IDOFoundationCommand bindingCommand:model callback:^(IDO_BIND_STATUS status, int errorCode) {
        __strong typeof(self) strongSelf = weakSelf;
        if (errorCode == 0) {
            if (status == IDO_BLUETOOTH_BIND_SUCCESS) { //绑定成功
                [strongSelf showToastWithText:lang(@"bind success")];
                IDOSetBindingInfoBluetoothModel * model1 = [IDOSetBindingInfoBluetoothModel currentModel];
                if (model1.authLength > 0)return;
                [strongSelf setRootViewController];
            }else if (status == IDO_BLUETOOTH_BINDED) { //已经绑定
                
            }else if (status == IDO_BLUETOOTH_BIND_FAILED) { //绑定失败
                
            }else if (status == IDO_BLUETOOTH_NEED_AUTH) { //需要授权绑定
                [strongSelf showAuthView];
            }else if (status == IDO_BLUETOOTH_REFUSED_BINDED) { //拒绝绑定
                [strongSelf showToastWithText:lang(@"rejected bind")];
            }
        }else { //绑定失败
            [strongSelf showToastWithText:lang(@"bind failed")];
        }
    }];
}

- (void)updateAction:(UIButton *)sender
{
    FuncViewController * update = [[FuncViewController alloc]init];
    update.model = [UpdateMainViewModel new];
    update.title = lang(@"device update");
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:update];
    [UIApplication sharedApplication].delegate.window.rootViewController = nav;
}

- (void)setRootViewController
{
    if (BIND_STATE)return; //有些固件不稳定防止绑定多次回调
    BIND_STATE = YES;
    FuncViewController * funcVc = [[FuncViewController alloc]init];
    funcVc.model = [FuncViewModel new];
    funcVc.title = lang(@"function list");
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:funcVc];
    [UIApplication sharedApplication].delegate.window.rootViewController = nav;
}

- (void)showBindView
{
    if (!_bindView) {
        _bindView = [[BindDeviceView alloc]initWithFrame:self.view.bounds];
        _bindView.delegate = self;
        [self.view addSubview:_bindView];
    }
    
    int mode = (int)[[NSUserDefaults standardUserDefaults]integerForKey:PRODUCTION_MODE_KEY];
    NSString * str = (self.currentModel.isOta || mode == 1) ?  lang(@"update"):lang(@"bind");
    _bindView.tipLabel.text = [NSString stringWithFormat:lang(@"send bind or update"),str];
    [_bindView show];
}

- (void)cancelBindButton
{
    [self leftAction];
}

- (void)allowBinding
{
    int mode = (int)[[NSUserDefaults standardUserDefaults]integerForKey:PRODUCTION_MODE_KEY];
    if (self.currentModel.isOta || mode == 1) {
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
            [strongSelf showToastWithText:lang(@"bind success")];
            [strongSelf setRootViewController];
        }else {
            [strongSelf showToastWithText:lang(@"bind failed")];
        }
    }];
}

#pragma mark === IDOBluetoothManagerDelegate ===
- (BOOL)bluetoothManager:(IDOBluetoothManager *)manager
           centerManager:(CBCentralManager *)centerManager
    didConnectPeripheral:(CBPeripheral *)peripheral
               isOatMode:(BOOL)isOtaMode
{
    [self showToastWithText:lang(@"connected success")];
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
    [self showToastWithText:error.domain];//lang(@"connected failed")
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
    [IDOBluetoothManager connectDeviceWithModel:self.currentModel];
}


@end
