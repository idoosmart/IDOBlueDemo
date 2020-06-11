//
//  IDOCircleView.h
//  IDOEducation
//
//  Created by 农大浒 on 2019/12/3.
//  Copyright © 2019 TigerNong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IDOCircleView : UIView

//圆环的宽高
@property (nonatomic, assign) CGFloat circleWidthHeight;

/**
 圆环距离顶部的距离
 */
@property (nonatomic, assign) CGFloat circleTopMargin;

/**
 背景圆环的颜色
 */
@property (nonatomic, strong) UIColor *backCircleColor;

/**
 背景圆环的线的宽度
 */
@property (nonatomic, assign) CGFloat backCircleLineWidth;

/**
 圆环的线的宽度
 */
@property (nonatomic, assign) CGFloat circleLineWidth;

/**
 圆环进度的颜色,在不需要进行渐变的情况下，进度的颜色
 */
@property (nonatomic, strong) UIColor *circleColor;

/**
 是否进行渐变色,设置这个会启用下面的两个数组
 */
@property (nonatomic, assign) BOOL gradient;

/**
 渐变的颜色，只有在设置了gradient的情况下，才会可以实现(这个颜色只能是两种颜色)
 */
@property (nonatomic, strong) NSArray <UIColor *>*leftGradientColors;
@property (nonatomic, strong) NSArray <UIColor *>*rightGradientColors;

/**
 自定义渐变layer
 */
@property (nonatomic, strong) CAGradientLayer *gradientLayer;

/**
 是否显示起始点的位置
 */
@property (nonatomic, assign) BOOL showStartSign;

/**
 起始点的半径
 */
@property (nonatomic, assign) CGFloat startSignRadius;

/**
 起始点的图片
 */
@property (nonatomic, strong) UIImage *startPointImage;

/**
 是否动画绘制
 */
@property (nonatomic, assign) BOOL animation;

/**
 动画时间
 */
@property (nonatomic, assign) CGFloat animationDuration;

/**
 当前数值的百分比
 */
@property (nonatomic, assign) CGFloat value;

@end

NS_ASSUME_NONNULL_END
