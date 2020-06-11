//
//  IDOMulScrollLineDrawView.h
//  IDOUIKitDemo
//
//  Created by 农大浒 on 2020/4/16.
//  Copyright © 2020 农大浒. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IDOChartCommonHeader.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, IDOTouchState) {
    IDOTouchStateBegan      = 0, //开始接触
    IDOTouchStateMoved      = 1, //移动中
    IDOTouchStateEnded      = 2, //结束
    IDOTouchStateCancelled  = 3, //取消
};

@interface IDOOSingleScrollLineDrawView : UIScrollView

/**
 最小值情况下的y值
 */
@property (nonatomic, assign) CGFloat showMinY;

/**
 绘制曲线的宽度
 */
@property (nonatomic, assign) CGFloat lineWidth;

/**
 线条颜色
 */
@property (nonatomic, strong) UIColor *lineColor;

/**
 渐变的颜色数组,只能是两个元素
 */
@property (nonatomic, strong) NSArray <UIColor *>*gradientRectColors;

/**
 渐变色区域值数组，只能是两个元素,默认self.locations = @[@(0.0),@(1.0)];
 */
@property (nonatomic, strong) NSArray <NSNumber *>*locations;

/**
 指定绘制撞色区域的y值数组，假设现在的 mulColorValueArray = @[@"0-50",@"50-100",@"100-150"]，则要计算出数值对应的y值
 */
@property (nonatomic, strong) NSArray <NSString *>*mulColorYArray;

/**
 是否隐藏小于指定最小值的数据
 */
@property (nonatomic, assign) BOOL hiddenLessYAlexMinValueData;

/**
 曲线颜色的样式,要设置这个之前，请先设置好数组mulColorValueArray和mulColorArray
 */
@property (nonatomic, assign) IDOLineColorStyle lineColorStyle;

/**
 指定显示撞色的颜色数组,这个数组只有是在 lineColorStyle == IDOLineColorStyleMulColor,才会有用
 */
@property (nonatomic, strong) NSArray <UIColor *>*mulColorArray;

/**
 点击之间的距离
 */
@property (nonatomic, assign) CGFloat pointMargin;

/**
 覆盖的颜色
 */
@property (nonatomic, strong) UIColor *coverColor;

/**
 曲线是否添加控制点，默认是NO
 */
@property (nonatomic, assign) BOOL AddCurve;



/**
 点击回调
 */
@property (nonatomic, copy) void (^touchBlock)(IDOTouchState touchState,CGPoint touchPoint);

/**
 绘制折线
 */
- (void)drawLineWithPoints:(NSArray *)points sourcePoints:(NSArray *)sourcePoints;



@end

NS_ASSUME_NONNULL_END
