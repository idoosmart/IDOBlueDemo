//
//  DHDeviceScanView.h
//  DHDevice
//
//  Created by cq on 2019/5/8.
//  Copyright © 2019 cq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^DHDeviceConnectClickBlock)(NSString *title);

typedef void(^DHDeviceFlashSwitchBlock)(BOOL open);

@interface DeviceScanView : UIView

/**
 点击按钮回调
 */
@property (nonatomic,copy) DHDeviceConnectClickBlock connectClickBlock;

/**
 打开/关闭闪光灯的回调
 */
@property (nonatomic,copy) DHDeviceFlashSwitchBlock flashSwitchBlock;

#pragma mark - 扫码区域

/**
 扫码区域 默认为正方形,x = 60, y = 100
 */
@property (nonatomic,assign)CGRect scanRetangleRect;
/**
 @brief  是否需要绘制扫码矩形框，默认YES
 */
@property (nonatomic, assign) BOOL isNeedShowRetangle;
/**
 @brief  矩形框线条颜色
 */
@property (nonatomic, strong, nullable) UIColor *colorRetangleLine;

#pragma mark - 矩形框(扫码区域)周围4个角

//4个角的颜色
@property (nonatomic, strong, nullable) UIColor* colorAngle;

//扫描失败时，4个角的颜色
@property (nonatomic, strong, nullable) UIColor* colorAngleFailed;

//扫码区域4个角的宽度和高度 默认都为20
@property (nonatomic, assign) CGFloat photoframeAngleW;
@property (nonatomic, assign) CGFloat photoframeAngleH;
/**
 @brief  扫码区域4个角的线条宽度,默认6
 */
@property (nonatomic, assign) CGFloat photoframeLineW;



#pragma mark --动画效果

/**
 *  动画效果的图像
 */
@property (nonatomic,strong, nullable) UIImage * animationImage;
/**
 非识别区域颜色,默认 RGBA (0,0,0,0.5)
 */
@property (nonatomic, strong, nullable) UIColor * notRecoginitonArea;


/**
 *  开始扫描动画
 */
- (void)startScanAnimation;
/**
 *  结束扫描动画
 */
- (void)stopScanAnimation;

/**
 正在处理扫描到的结果
 */
- (void)handlingResultsOfScan;

/**
 完成扫描结果处理
 */
- (void)finishedHandle;


/**
 是否显示闪光灯开关
 @param show YES or NO
 */
- (void)showFlashSwitch:(BOOL)show;


/**
 扫描失败/超时
 */
- (void)scanDeviceFailed;

/**
 重新扫描
 */
- (void)restartScanDevice;

@end

NS_ASSUME_NONNULL_END
