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

@interface IDOMulScrollLineDrawView : UIScrollView

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
 绘制折线
 */
- (void)drawLineWithPoints:(NSArray *)points;

@end

NS_ASSUME_NONNULL_END
