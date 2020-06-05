//
//  IDORulerViewConfig.h
//  IDOUIKitDemo
//
//  Created by 农大浒 on 2020/3/14.
//  Copyright © 2020 农大浒. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, IDORulerDirectionStyle) {
    IDORulerDirectionStyleBottom  = 0, //刻度的数字在下面
    IDORulerDirectionStyleTop     = 1, //刻度的数字在上面
    IDORulerDirectionStyleLeft    = 2, //刻度的数字在左边
    IDORulerDirectionStyleRight   = 3, //刻度的数字在右边
};

@interface IDORulerViewConfig : NSObject



/**
 三角形控件与顶部的距离,如果是左右放在，则表示与坐标的距离
 */
@property (nonatomic, assign) CGFloat topPadding;

/**
 三角形标识的size
 */
@property (nonatomic, assign) CGSize triangleSize;

/**
 三角形的背景颜色，默认情况下使用颜色
 */
@property (nonatomic, strong) UIColor *triangleBackgroudColor;

/**
 三角形的图片，可以使用triangleBackgroudColor ，也可以使用颜色
 */
@property (nonatomic, strong) UIImage *triangleImage;

/**
 是否显示三角形
 */
@property (nonatomic, assign) BOOL hiddenTriangleView;


/**
 刻度与控件顶部的距离，默认情况下是 self.topPadding + self.triangleSize.height + 5;
 */
@property (nonatomic, assign) CGFloat rulerTopPadding;

/**
 长刻度的高（被10整除的），比如0，10，20，30
 */
@property (nonatomic, assign) CGFloat longScaleHeight;

/**
 长刻度的宽被（10整除的），比如0，10，20，默认值1
 */
@property (nonatomic, assign) CGFloat longScaleWidth;

/**
 刻度的颜色
 */
@property (nonatomic, strong) UIColor *scaleColor;

/**
 中间刻度的高(被5整除的），比如5，15，25，默认值25
 */
@property (nonatomic, assign) CGFloat minScaleHeight;

/**
 中间刻度的宽(被5整除的），比如5，15，25，默认值1
 */
@property (nonatomic, assign) CGFloat minScaleWidth;


/**
 短刻度的高(被5整除的），比如2，3，4，默认值20
 */
@property (nonatomic, assign) CGFloat shortScaleHeight;

/**
 端刻度的宽(被5整除的），比如6，7，8，默认值1
 */
@property (nonatomic, assign) CGFloat shortScaleWidth;


/**
 标签的高度，默认20，标签的y值为，刻度盘CollectionView的高度减去20
 */
@property (nonatomic, assign) CGFloat numberLabelHeight;

/**
 标签的字体，默认字体[UIFont systemFontOfSize:10]
 */
@property (nonatomic, strong) UIFont *numberLabelFont;

/**
 标签文字的颜色，默认颜色黑色
 */
@property (nonatomic, strong) UIColor *numberLabelTextColor;

/**
 是否显示标签,默认NO
 */
@property (nonatomic, assign) BOOL hiddenNumberLabel;


/**
 默认选中的值,如果这个默认选中的值，小于最小值，则为最小值，大于最大值则为最大值
 */
@property (nonatomic, assign) CGFloat defaultValue;


/**
 cell居中时，是否显示选中,选中时，刻度显示与三角形一样的颜色，默认是YES
 */
@property (nonatomic, assign) BOOL showSelected;

/**
 设置中间竖线与父控件顶部的距离，默认情况下为self.rulerTopPadding
 */
@property (nonatomic, assign) CGFloat centerLineViewToTop;

/**
 中间竖线的size,初始化默认是与长刻度一致
 */
@property (nonatomic, assign) CGSize centerLineViewSize;

/**
 是否一直显示中间竖线，默认NO，目前默认情况是，在没有取到cell的情况，才会显示出来，并且中间竖线的高度，会与刻度的高度一致,如果设置为YES，则表示一直显示，不进行隐藏；
 */
@property (nonatomic, assign) BOOL showCenterLineView;

/**
 中间线条的颜色，默认与三角形的背景颜色一致
 */
@property (nonatomic, strong) UIColor *centerLineViewColor;


/**
 取默认值
 */
+ (IDORulerViewConfig *)defaultConfig;

@end

NS_ASSUME_NONNULL_END
