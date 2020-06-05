//
//  IDOScanDemoViewController.m
//  IDOUIKitDemo
//
//  Created by 农大浒 on 2019/12/23.
//  Copyright © 2019 农大浒. All rights reserved.
//

#import "ScanDemoViewController.h"

@interface ScanDemoViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong)  DeviceNativeScanTool * scanTool;
@property (nonatomic, strong)  DeviceScanView * scanView;
@property (nonatomic, assign) BOOL isScanning;
@property (nonatomic, assign) BOOL viewIsAppear;

/**
 扫描获得Mac地址
 */
@property (nonatomic, copy) NSString *macString;

/**
 标记扫码绑定次数
 */
@property (nonatomic,assign) NSInteger scanCount;


@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ScanDemoViewController

#pragma mark ----- vc lift cycle 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.translucent=NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.ido_navigationBar.ido_backgroudColor = [UIColor whiteColor];
    self.ido_naviTitleColor = [UIColor blackColor];
    self.ido_navTintColor = [UIColor blackColor];
    self.ido_navigationBar.ido_naviBottomLineColor = [UIColor clearColor];
    self.ido_naviTitle = @"scan QR code";
    self.ido_naviTitleColor = [UIColor blackColor];
    self.ido_leftBarButtonItem = [UIBarButtonItem itemWithTitle:@"✖"
                                                    normolColor:[UIColor blackColor]
                                                 highLightColor:[UIColor blackColor]
                                                         target:self
                                                         action:@selector(back)];
}

- (void)back{
    [self ido_popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.viewIsAppear = YES;
    if (!self.isScanning) {
        self.isScanning = YES;
        [_scanView startScanAnimation];
        [_scanView restartScanDevice];
        [_scanTool sessionStartRunning];
        [self performSelector:@selector(scanDeviceTimeOut) withObject:nil afterDelay:30];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.viewIsAppear = NO;
    if (self.isScanning) {
        self.isScanning = NO;
        [_scanView stopScanAnimation];
        [_scanView finishedHandle];
        [_scanView showFlashSwitch:NO];
        [_scanTool sessionStopRunning];
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(scanDeviceTimeOut) object:nil];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)initUI {
    
    
    UIView *preView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:preView];
    
    [self.view addSubview:self.scanView];
    
    //初始化扫描工具
    _scanTool = [[DeviceNativeScanTool alloc] initWithPreview:preView andScanFrame:_scanView.scanRetangleRect];
    WEAKSELF
    _scanTool.scanFinishedBlock = ^(NSString *scanString) {
        
        if (weakSelf.scanQRcodeCallback) {
            weakSelf.scanQRcodeCallback(scanString,weakSelf);
        }
        
        weakSelf.isScanning = NO;
        [weakSelf.scanView stopScanAnimation];
        
        [weakSelf.scanTool sessionStopRunning];
        [weakSelf.scanTool openFlashSwitch:NO];
        [NSObject cancelPreviousPerformRequestsWithTarget:weakSelf selector:@selector(scanDeviceTimeOut) object:nil];
    };

    self.isScanning = YES;
    [_scanTool sessionStartRunning];
    [_scanView startScanAnimation];
    [self performSelector:@selector(scanDeviceTimeOut) withObject:nil afterDelay:30];
}

#pragma mark ----- 二维码扫描相关

- (void)scanDeviceTimeOut {
    self.isScanning = NO;
    [self.scanView stopScanAnimation];
    [self.scanView finishedHandle];
    [self.scanView showFlashSwitch:NO];
    [self.scanView scanDeviceFailed];
    [self.scanTool sessionStopRunning];
}

- (void)appWillEnterBackground{
    if (self.isScanning && self.viewIsAppear) {
        self.isScanning = NO;
        [_scanView stopScanAnimation];
        [_scanView finishedHandle];
        [_scanView showFlashSwitch:NO];
        [_scanTool sessionStopRunning];
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(scanDeviceTimeOut) object:nil];
    }
}

- (void)appWillEnterPlayGround{
    if (!self.isScanning  && self.viewIsAppear) {
        self.isScanning = YES;
        [_scanView startScanAnimation];
        [_scanView restartScanDevice];
        [_scanTool sessionStartRunning];
        [self performSelector:@selector(scanDeviceTimeOut) withObject:nil afterDelay:30];
    }
}

#pragma mark ----- get and set 属性的set和get方法

//构建扫描样式视图
-(DeviceScanView *)scanView{
    if (!_scanView) {
        _scanView = [[DeviceScanView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _scanView.colorAngle = [UIColor redColor];
        _scanView.photoframeAngleW = 15;
        _scanView.photoframeAngleH = 15;
        _scanView.photoframeLineW = 1;
        _scanView.isNeedShowRetangle = YES;
        [_scanView showFlashSwitch:YES];
        _scanView.colorRetangleLine = [UIColor clearColor];
        _scanView.notRecoginitonArea = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        _scanView.animationImage = IMAGE(@"device_scanLine");
        WEAKSELF
        _scanView.connectClickBlock = ^(NSString * _Nonnull title) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
        
        _scanView.flashSwitchBlock = ^(BOOL open) {
            [weakSelf.scanTool openFlashSwitch:open];
        };
    }
    return _scanView;
}

@end
