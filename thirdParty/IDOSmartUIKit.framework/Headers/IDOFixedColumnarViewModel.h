//
//  IDOFixedColomnarViewModel.h
//  IDOEducation
//
//  Created by 农大浒 on 2019/12/4.
//  Copyright © 2019 TigerNong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "IDOChartCommonHeader.h"
#import "IDOXAlexModel.h"
#import "IDOValueModel.h"
#import "IDOYAlexModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface IDOFixedColumnarViewModel : NSObject

/**
 数据数组
 */
@property (nonatomic,strong) NSArray <IDOValueModel *>*dataValues;

/**
 y轴数据数组,如果只是显示一种颜色的情况下，y轴中的颜色数组要写成与columnarColor一致
 */
@property (nonatomic,strong) NSArray <IDOYAlexModel *>*yValues;

/**
 x轴数据数组
 */
@property (nonatomic,strong) NSArray <IDOXAlexModel *>*xValues;

/**
 柱状图与顶部的距离，默认20
 */
@property (nonatomic,assign) CGFloat topMargin;
/**
 柱状图与左边的距离，默认0
 */
@property (nonatomic,assign) CGFloat leftMargin;

/**
 柱状图与右边的距离，默认20
 */
@property (nonatomic,assign) CGFloat rightMargin;

/**
 y轴的宽度，默认30
 */
@property (nonatomic,assign) CGFloat yAlexWidth;

/**
 x轴的高度,默认30
 */
@property (nonatomic,assign) CGFloat xAlexHeight;

/**
 y轴的位置,默认为IDOYAlexPositionStyleLeft
 */
@property (nonatomic,assign) IDOYAlexPositionStyle positionType;

/**
 显示最大最小值的间隔线，默认为NO
 */
@property (nonatomic,assign) BOOL showMaxAndMinValue;

/**
 显示间隔线，默认YES
 */
@property (nonatomic, assign) BOOL showYAlexSeptalLine;

/**
 显示间隔线为虚线，默认YES
 */
@property (nonatomic, assign) BOOL showYAlexSeptalLineDashPattern;

/**
 间隔线的大小，默认1
 */
@property (nonatomic,assign) CGFloat yAlexSeptalLineWidth;

/**
 间隔显示的颜色,默认黑色
 */
@property (nonatomic, strong) UIColor *yAlexSeptalLineColor;

/**
 y轴竖线的颜色，默认黑色
 */
@property (nonatomic, strong) UIColor *yAlexLineColor;

/**
 显示y轴竖线，默认YES
 */
@property (nonatomic, assign) BOOL showYAlexLine;

/**
 y轴竖线的大小,默认1.0
 */
@property (nonatomic, assign) CGFloat yAlexLineWidth;

/**
 设置y轴文字的颜色，默认黑色
 */
@property (nonatomic, strong) UIColor *yAlexTitleColor;

/**
 y轴标签的字体大小
 */
@property (nonatomic, strong) UIFont *yAlexTitleFont;

/**
 y轴标签的对齐方式，默认居中
 */
@property (nonatomic, assign) NSTextAlignment yAlexTitleTextAlignment;

/**
 y轴刻度值与刻度线的位置,默认是位于刻度线上面
 */
@property (nonatomic, assign) IDOYAlexTextPosition yAlexTextPosition;

/**
 显示x轴的横线，默认YES
 */
@property (nonatomic, assign) BOOL showXAleLine;

/**
 显示x轴的横线的大小，默认1.0
 */
@property (nonatomic, assign) CGFloat xAlexLineWidth;


/**
 x轴的横线的颜色，默认黑色
 */
@property (nonatomic, strong) UIColor *xAlexLineColor;

/**
 设置x轴文字的颜色，默认黑色
 */
@property (nonatomic, strong) UIColor *xAlexTitleColor;

/**
 x轴坐标文字的字体
 */
@property (nonatomic, strong) UIFont *xAlexTitleFont;

/**
 柱状图的颜色，存在有目标值，且当前数值不超过目标值时的颜色，默认蓝色
 */
@property (nonatomic, strong) UIColor *columnarColor;

/**
 存在有目标值时，超过目标值情况下，柱状图的颜色
 */
@property (nonatomic, strong) UIColor *columnarTargetValueColor;

/**
 绘制柱状图区域的颜色，不能穿alpha为1.0的颜色，不然会遮挡住折线,默认白色，alpha 0.6
 */
@property (nonatomic, strong) UIColor *drawColumnarBackgroudColor;

/**
 显示顶部提示标签，默认显示YES
 */
@property (nonatomic, assign) BOOL showTopTipLabel;

/**
 显示滑动竖线，默认显示YES
 */
@property (nonatomic, assign) BOOL showDataLine;

/**
 顶部提示标签的文字颜色,默认黑色
 */
@property (nonatomic, strong) UIColor *topTipLabelTextColor;

/**
 顶部提示标签背景颜色,默认亮灰色
 */
@property (nonatomic, strong) UIColor *topTipLabelBackgroudColor;

/**
 顶部提示标签文字大小,默认 [UIFont systemFontOfSize:13];
 */
@property (nonatomic, strong) UIFont *topTipLabelFont;

/**
 顶部tipLabel的frame,默认 CGRectMake(self.yAlexWidth, 5, 80, 30)
 */
@property (nonatomic, assign) CGRect topTipLabelFrame;

/**
 自定义的顶部标签
 */
@property (nonatomic, strong) UILabel *customTipLabel;

/**
 显示数据的竖线的颜色，默认是灰色
 */
@property (nonatomic, strong) UIColor *showDataLineColor;

/**
 显示数据的竖线，顶部的颜色，只有在  showDataLineType =  IDOShowDataLineTypeUpSolidLineAndDownDottedLine ||  showDataLineType =  IDOShowDataLineTypeUpDottedLineAndDownDottedLine | IDOShowDataLineTypeUpSolidLine 有效，默认灰色
 */
@property (nonatomic, strong) UIColor *showDataDownLineColor;

/**
 显示数据的数据样式,默认为整体实现，IDOShowDataLineTypeTotleSolidLine
 */
@property (nonatomic, assign) IDOShowDataLineType showDataLineType;

/**
 显示数据竖线的宽度，默认是1，最大不能超过10
 */
@property (nonatomic, assign) CGFloat showDataLineWidth;

/**
 显示渐变色，默认显示NO
 */
@property (nonatomic, assign) BOOL gradient;

/**
 柱状图的圆角,默认0
 */
@property (nonatomic, assign) CGFloat columnarRadius;

/**
 圆角的地方
 */
@property (nonatomic, assign) UIRectCorner corner;

/**
 柱状图之间的间距，默认5
 */
@property (nonatomic,assign) CGFloat colViewMarginWidth;

/**
 柱状的宽度，优先选中减去每个柱状之间的距离的结果，除以个数得到的宽度，如果这个宽度小于colViewWidth ，则以除以的结果为准，如果大于colViewWidth，则以colViewWidth为准
 */
@property (nonatomic, assign) CGFloat colViewWidth;

/**
 头部缩进的距离
 */
@property (nonatomic, assign) CGFloat headerEdgeWidth;

/**
 尾部缩进的距离
 */
@property (nonatomic, assign) CGFloat footerEdgeWidth;

/**
 选中时，柱状图的颜色
 */
@property (nonatomic, strong) UIColor *selectedColColor;

/**
 选中情况下，cell的背景颜色
 */
@property (nonatomic, strong) UIColor *cellSelectedBackColor;

/**
 标准值
 */
@property (nonatomic, copy) NSString *targetValue;

/**
 是否显示目标线
 */
@property (nonatomic, assign) BOOL showTargetLine;

/**
 目标线的颜色值
 */
@property (nonatomic, strong) UIColor *tagetLineColor;

/**
 目标线的线宽
 */
@property (nonatomic, assign) CGFloat targetLinwHeight;

/**
 目标线是否显示虚线
 */
@property (nonatomic, assign) BOOL tagerLineShowDashPattern;


/**
 是否设置默认选中的cell
 */
@property (nonatomic, assign) BOOL showDefaultSelectedCell;

/**
 设置默认选中的cell的下标
 */
@property (nonatomic, strong) NSIndexPath *defaultSelectedCellIndexPath;

/**
 是否显示单位
 */
@property (nonatomic, assign) BOOL showUnitLabel;

/**
 单位
 */
@property (nonatomic, copy) NSString *unit;

/**
 单位字体的颜色
 */
@property (nonatomic, strong) UIColor *unitTitleColor;

/**
 单位字体
 */
@property (nonatomic, strong) UIFont *unitFont;

/**
 是否可以进行手势移动，默认YES
 */
@property (nonatomic, assign) BOOL gestureMove;

/**
 是否显示targetValues数组中的值对应的颜色，默认是NO,使用这个时，y坐标轴需要重0开始
 */
@property (nonatomic, assign) BOOL showYAlexValueColor;

/**
 范围值数组,这个数组用来判断柱状图的颜色，颜色的颜色值重从yValues的数组中取，这个数组只有在存在有3中颜色以上的时候才能使用,如果这个为空，并且showYAlexValueColor == YES时，按照y轴坐标值去颜色
 数值标准数组,元素的个数要与yValues一致,数据格式：[@"0-30",@"30-60",@"60-90"],这样的格式，如果有小数点，则只能去小数点后面一位，如[@"0-30.5",@"30.5-60.1",@"60.1-90"]
 */
@property (nonatomic, strong) NSArray <NSString *>*targetValues;


#pragma mark - ReadOnly
//数值的最大值
@property (nonatomic,assign, readonly) CGFloat maxValue;
//数值的最小值
@property (nonatomic,assign, readonly) CGFloat minValue;

//y轴刻度的最小值
@property (nonatomic,assign, readonly) CGFloat minYValue;
//y轴刻度的最大值
@property (nonatomic,assign, readonly) CGFloat maxYValue;


@end

NS_ASSUME_NONNULL_END
