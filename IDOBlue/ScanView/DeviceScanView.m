//
//  DHDeviceScanView.m
//  DHDevice
//
//  Created by cq on 2019/5/8.
//  Copyright © 2019 cq. All rights reserved.
//

#import "DeviceScanView.h"
#import "IDODemoUtility.h"

@interface DeviceScanView ()

//动画线条
@property (nonatomic,strong) UIImageView * scanLine;
//网络状态提示语
@property (nonatomic,strong) UILabel * netLabel;

@property (nonatomic,strong) UILabel *descLabel1;

@property (nonatomic,strong) UILabel *descLabel2;

@property (nonatomic,strong) UILabel *rightLabel;


/**
 导航栏按钮
 */


@property (nonatomic, strong) UIButton *leftButton;

@property (nonatomic, strong) UIButton *rightButton;

@property (nonatomic, strong) UIImageView *failImageView;
/**
 菊花等待
 */
@property(nonatomic,strong) UIActivityIndicatorView * activityView;
/**
 扫描结果处理中
 */
@property(nonatomic,strong) UIView * handlingView;
/**
 是否正在动画
 */
@property(nonatomic,assign) BOOL isAnimating;

//手电筒开关
@property(nonatomic,strong) UIButton * flashBtn;
/**
 闪光灯开关的状态
 */
@property (nonatomic, assign) BOOL flashOpen;

@end
@implementation DeviceScanView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        _isNeedShowRetangle = YES;
        _photoframeLineW = 1;
        _notRecoginitonArea = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        CGFloat width = [UIApplication sharedApplication].delegate.window.frame.size.width;
        _scanRetangleRect = CGRectMake(80, 192, (width - 160) , (width - 160));
        _photoframeAngleW = 15;
        _photoframeAngleH = 15;
        _colorAngle = [UIColor yellowColor];
        _colorAngleFailed = [IDODemoUtility colorWithHexString:@"#D82121"];
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    
    [super drawRect:rect];
    
    [self drawScanRect];
    [self drawAngleRect];
    [self addSubview:self.scanLine];
    
    
    self.descLabel1  = [[UILabel alloc] initWithFrame:CGRectMake(0, self.scanRetangleRect.origin.y - 40, rect.size.width, 20)];
    self.descLabel1.font = [UIFont systemFontOfSize:14];
    self.descLabel1.textAlignment = NSTextAlignmentCenter;
    self.descLabel1.textColor = [IDODemoUtility colorWithHexString:@"#B1B1B1"];
//    self.descLabel1.text = Lang(@"Align QR code within the frame");
    self.descLabel1.text = @"Align QR code within the frame";
    [self addSubview:self.descLabel1];
    
    self.descLabel2  = [[UILabel alloc] initWithFrame:CGRectMake(0, self.descLabel1.frame.origin.y - 40, rect.size.width, 22)];
    self.descLabel2.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
    self.descLabel2.textAlignment = NSTextAlignmentCenter;
    self.descLabel2.textColor = [IDODemoUtility colorWithHexString:@"#FFFFFF"];
//    self.descLabel2.text = Lang(@"Please scan QR code to connect.");
     self.descLabel2.text = @"Please scan QR code to connect.";
    
    [self addSubview:self.descLabel2];
    
//    UILabel * promptLab = [[UILabel alloc] initWithFrame:CGRectMake(0, _scanRetangleRect.origin.y + _scanRetangleRect.size.height + 50, self.width, 60)];
//    promptLab.text = Lang(@"提示：要链接设备名称，请确保手机已链接至无线局域网\n或蜂窝网络，并打开蓝牙。");
//    promptLab.font = [UIFont systemFontOfSize:13];
//    promptLab.textAlignment = NSTextAlignmentCenter;
//    promptLab.numberOfLines = 0;
//    promptLab.textColor = COLOR(@"#FFFFFF");
//    [self addSubview:promptLab];
    
    
    UIButton *bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bottomBtn.frame = CGRectMake(0, self.frame.size.height - 164, 132, 36);
    bottomBtn.center = CGPointMake(self.center.x, bottomBtn.center.y);
    
    NSString *bottomTitle = @"Bind manually";
    [bottomBtn setTitle:bottomTitle forState:UIControlStateNormal];
    bottomBtn.titleLabel.font = [UIFont systemFontOfSize: 13.0];
    
    //MJColor(227, 83, 40)
    
    [bottomBtn setTitleColor:[UIColor colorWithRed:227.0/255 green:83.0/255 blue:40.0/255 alpha:1.0] forState:UIControlStateNormal];
    [bottomBtn addTarget:self action:@selector(bottomBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:bottomBtn];
}


- (void)drawAngleRect {
    
    CGSize sizeRetangle = self.scanRetangleRect.size;
    //扫码区域Y轴最小坐标
    CGFloat YMinRetangle = self.scanRetangleRect.origin.y;
    CGFloat YMaxRetangle = YMinRetangle + sizeRetangle.height;
    CGFloat XRetangleLeft = self.scanRetangleRect.origin.x;
    CGFloat XRetangleRight = self.frame.size.width - XRetangleLeft;
    
    //画中间扫描失败的红X
    UIImage *failIcon = [UIImage new];
    self.failImageView = [[UIImageView alloc] initWithImage:failIcon];
    self.failImageView.frame = CGRectMake(XRetangleLeft + (XRetangleRight-XRetangleLeft-failIcon.size.width)/2.0, YMinRetangle+(YMaxRetangle-YMinRetangle-failIcon.size.height)/2.0, failIcon.size.width, failIcon.size.height);
    self.failImageView.hidden = YES;
    [self addSubview:self.failImageView];
    
    //画矩形框4格外围相框角
    //相框角的宽度和高度
    int wAngle = self.photoframeAngleW;
    int hAngle = self.photoframeAngleH;
    //4个角的 线的宽度
    CGFloat linewidthAngle = self.photoframeLineW;// 经验参数：6和4
    
    
    //顶点位置
    CGFloat leftX = XRetangleLeft;
    CGFloat topY = YMinRetangle;
    CGFloat rightX = XRetangleRight;
    CGFloat bottomY = YMaxRetangle;
    
    CGFloat lineSpace = 5.0;
    //左上角水平线
    UIView *leftTopHLine = [[UIView alloc] initWithFrame:CGRectMake(leftX   +lineSpace, topY+lineSpace, wAngle, linewidthAngle)];
    leftTopHLine.backgroundColor = self.colorAngle;
    leftTopHLine.tag = 100;
    [self addSubview:leftTopHLine];
    
    //左上角垂直线
    UIView *leftTopVLine = [[UIView alloc] initWithFrame:CGRectMake(leftX+lineSpace, topY+lineSpace+linewidthAngle, linewidthAngle, hAngle-linewidthAngle)];
    leftTopVLine.backgroundColor = self.colorAngle;
    leftTopVLine.tag = 101;
    [self addSubview:leftTopVLine];
    
    //左下角水平线
    UIView *leftBottomHLine = [[UIView alloc] initWithFrame:CGRectMake(leftX+lineSpace, bottomY-lineSpace-linewidthAngle, wAngle, linewidthAngle)];
    leftBottomHLine.backgroundColor = self.colorAngle;
    leftBottomHLine.tag = 102;
    [self addSubview:leftBottomHLine];
    
    //左下角垂直线
    UIView *leftBottomVLine = [[UIView alloc] initWithFrame:CGRectMake(leftX+lineSpace, bottomY-lineSpace-hAngle, linewidthAngle, hAngle-linewidthAngle)];
    leftBottomVLine.backgroundColor = self.colorAngle;
    leftBottomVLine.tag = 103;
    [self addSubview:leftBottomVLine];
    
    //右上角水平线
    UIView *rightTopHLine = [[UIView alloc] initWithFrame:CGRectMake(rightX-lineSpace-wAngle, topY+lineSpace, wAngle, linewidthAngle)];
    rightTopHLine.backgroundColor = self.colorAngle;
    rightTopHLine.tag = 104;
    [self addSubview:rightTopHLine];
    
    //右上角垂直线
    UIView *rightTopVLine = [[UIView alloc] initWithFrame:CGRectMake(rightX-lineSpace-linewidthAngle, topY+lineSpace+linewidthAngle, linewidthAngle, hAngle-linewidthAngle)];
    rightTopVLine.backgroundColor = self.colorAngle;
    rightTopVLine.tag = 105;
    [self addSubview:rightTopVLine];
    
    //右下角水平线
    UIView *rightBottomHLine = [[UIView alloc] initWithFrame:CGRectMake(rightX-lineSpace-wAngle, bottomY-lineSpace-linewidthAngle, wAngle, linewidthAngle)];
    rightBottomHLine.backgroundColor = self.colorAngle;
    rightBottomHLine.tag = 106;
    [self addSubview:rightBottomHLine];
    //右下角垂直线
    UIView *rightBottomVLine = [[UIView alloc] initWithFrame:CGRectMake(rightX-lineSpace-linewidthAngle, bottomY-lineSpace-hAngle, linewidthAngle, hAngle-linewidthAngle)];
    rightBottomVLine.backgroundColor = self.colorAngle;
    rightBottomVLine.tag = 107;
    [self addSubview:rightBottomVLine];
}



//绘制扫描区域
- (void)drawScanRect{
    
    CGSize sizeRetangle = self.scanRetangleRect.size;
    //扫码区域Y轴最小坐标
    CGFloat YMinRetangle = self.scanRetangleRect.origin.y;
    CGFloat YMaxRetangle = YMinRetangle + sizeRetangle.height;
    CGFloat XRetangleLeft = self.scanRetangleRect.origin.x;
    CGFloat XRetangleRight = self.frame.size.width - XRetangleLeft;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //非扫码区域半透明
    {
        //设置非识别区域颜色
        const CGFloat *components = CGColorGetComponents(self.notRecoginitonArea.CGColor);
        
        CGFloat red_notRecoginitonArea = components[0];
        CGFloat green_notRecoginitonArea = components[1];
        CGFloat blue_notRecoginitonArea = components[2];
        CGFloat alpa_notRecoginitonArea = components[3];
        
        CGContextSetRGBFillColor(context, red_notRecoginitonArea, green_notRecoginitonArea,
                                 blue_notRecoginitonArea, alpa_notRecoginitonArea);
        
        //填充矩形
        
        //扫码区域上面填充
        CGRect rect = CGRectMake(0, 0, self.frame.size.width, YMinRetangle);
        CGContextFillRect(context, rect);
        
        //扫码区域左边填充
        rect = CGRectMake(0, YMinRetangle, XRetangleLeft,sizeRetangle.height);
        CGContextFillRect(context, rect);
        
        //扫码区域右边填充
        rect = CGRectMake(XRetangleRight, YMinRetangle, XRetangleLeft,sizeRetangle.height);
        CGContextFillRect(context, rect);
        
        //扫码区域下面填充
        rect = CGRectMake(0, YMaxRetangle, self.frame.size.width,self.frame.size.height - YMaxRetangle);
        CGContextFillRect(context, rect);
        //执行绘画
        CGContextStrokePath(context);
    }
    
    if (self.isNeedShowRetangle){
        //中间画矩形(正方形)
        CGContextSetStrokeColorWithColor(context, self.colorRetangleLine.CGColor);
        CGContextSetLineWidth(context, 1);
        
        CGContextAddRect(context, CGRectMake(XRetangleLeft, YMinRetangle, sizeRetangle.width, sizeRetangle.height));
        CGContextStrokePath(context);
    }
}

#pragma mark -- Events Handle

- (void)startScan{
    
    if (_isAnimating == NO) {
        return;
    }
    self.scanLine.hidden = NO;
    
    CGRect scanLineStartFrame = CGRectMake(self.scanRetangleRect.origin.x, self.scanRetangleRect.origin.y + self.scanRetangleRect.size.height - self.scanRetangleRect.size.width*30/392.0, self.scanRetangleRect.size.width, self.scanRetangleRect.size.width*30/392.0);
    
    CGRect endFrame = CGRectMake(self.scanRetangleRect.origin.x, self.scanRetangleRect.origin.y, self.scanRetangleRect.size.width, self.scanRetangleRect.size.width*30/392.0);
    
    
    
    [UIView animateWithDuration:3.0 animations:^{
        self.scanLine.frame = scanLineStartFrame;
    } completion:^(BOOL finished){
        self.scanLine.frame = endFrame;
        [self performSelector:@selector(startScan) withObject:nil afterDelay:0.03];
    }];
}

- (void)startScanAnimation{
    if(_isAnimating){
        return;
    }
    self.leftButton.hidden = YES;
    self.rightButton.hidden = NO;
    _isAnimating = YES;
    [self startScan];
}

- (void)stopScanAnimation{
    self.scanLine.hidden = YES;
    self.scanLine.frame = CGRectMake(self.scanRetangleRect.origin.x, self.scanRetangleRect.origin.y, self.scanRetangleRect.size.width, self.scanRetangleRect.size.width*30/392.0);
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(startScan) object:nil];
    _isAnimating = NO;
    [self.scanLine.layer removeAllAnimations];
}

- (void)handlingResultsOfScan{
    self.handlingView.center = CGPointMake(self.frame.size.width/2.0, self.scanRetangleRect.origin.y + self.scanRetangleRect.size.height/2);
    [self addSubview:self.handlingView];
    [self.activityView startAnimating];
}

- (void)finishedHandle{
    [self.activityView stopAnimating];
    [self.activityView removeFromSuperview];
    self.activityView = nil;
    [self.handlingView removeFromSuperview];
    self.handlingView = nil;
}

- (void)flashBtnClicked:(UIButton *)flashBtn{
    if (self.flashSwitchBlock != nil) {
        self.flashOpen = !self.flashOpen;
        self.flashSwitchBlock(self.flashOpen);
    }
}

- (void)showFlashSwitch:(BOOL)show{
    if (show == YES) {
        self.flashBtn.hidden = NO;
        [self addSubview:self.flashBtn];
    }else{
        self.flashBtn.hidden = YES;
        [self.flashBtn removeFromSuperview];
    }
}

- (void)reconnectButtonClick:(UIButton *)sender {
    if(self.connectClickBlock){
        self.connectClickBlock(self.rightLabel.text);
    }
}

- (void) bottomBtnAction:(UIButton *) sender
{
    if(self.connectClickBlock)
    {
        self.connectClickBlock(@"");
    }
}

- (void)restartScanDevice {
    //改变视图
    self.failImageView.hidden = YES;
    self.descLabel1.hidden = NO;
    //    self.descLabel2.text = Lang(@"Please scan QR code to connect.");
    //    self.descLabel2.textColor = COLOR(@"#FFFFFF");
    //    self.rightLabel.text = Lang(@"Connect manually")
    
    self.descLabel2.text = @"Please scan QR code to connect.";
    self.descLabel2.textColor = [IDODemoUtility colorWithHexString:@"#FFFFFF"];
    self.rightLabel.text = @"Connect manually";
    
    for (int i = 100; i < 108; i++) {
        UIView *line = [self viewWithTag:i];
        if (line) {
            line.backgroundColor = self.colorAngle;
        }
    }
}

- (void)scanDeviceFailed {
    self.leftButton.hidden = NO;
    self.rightButton.hidden = YES;
    //改变视图
    self.failImageView.hidden = NO;
    self.descLabel1.hidden = YES;
//    self.descLabel2.text = Lang(@"No relevant devices have been found.");
//    self.descLabel2.textColor = [UIColor yellowColor];
//    self.rightLabel.text = Lang(@"Reconnect");
    
    self.descLabel2.text = @"No relevant devices have been found.";
    self.descLabel2.textColor = [UIColor yellowColor];
    self.rightLabel.text = @"Reconnect";
    
    for (int i = 100; i < 108; i++) {
        UIView *line = [self viewWithTag:i];
        if (line) {
            line.backgroundColor = self.colorAngleFailed;
        }
    }
}

#pragma mark -- Getter

- (UIImageView *)scanLine{
    if (_scanLine == nil) {
        _scanLine = [[UIImageView alloc] initWithFrame:CGRectMake(self.scanRetangleRect.origin.x, self.scanRetangleRect.origin.y, self.scanRetangleRect.size.width, self.scanRetangleRect.size.width*30/392.0)];
        _scanLine.image = self.animationImage ? self.animationImage : [UIImage imageNamed:@"device_scanLine"];
        _scanLine.contentMode = UIViewContentModeScaleToFill;
    }
    return _scanLine;
}
// 加载中指示器
- (UIActivityIndicatorView *)activityView{
    if (_activityView == nil) {
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [_activityView startAnimating];
        _activityView.frame = CGRectMake(0, 0, self.scanRetangleRect.size.width, 40);
    }
    return _activityView;
}
//正在处理视图
- (UIView *)handlingView{
    
    if (_handlingView == nil) {
        _handlingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.scanRetangleRect.size.width, 40 + 40)];
        [_handlingView addSubview:self.activityView];
        
        UILabel * handleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, _handlingView.frame.size.width, 40)];
        handleLabel.font = [UIFont systemFontOfSize:12];
        handleLabel.textAlignment = NSTextAlignmentCenter;
        handleLabel.textColor = [UIColor whiteColor];
//        handleLabel.text = Lang(@"Processing…");
         handleLabel.text = @"Processing…";
        [_handlingView addSubview:handleLabel];
    }
    return _handlingView;
}

- (UIButton *)flashBtn{
    if (_flashBtn == nil) {
        _flashBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        [_flashBtn setImage:[UIImage new] forState:UIControlStateNormal];
        [_flashBtn addTarget:self action:@selector(flashBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        _flashBtn.center = CGPointMake(self.frame.size.width/2.0, self.scanRetangleRect.origin.y + self.scanRetangleRect.size.height - 40);
    }
    return _flashBtn;
}


- (void)dealloc{
    [self stopScanAnimation];
    [self finishedHandle];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
