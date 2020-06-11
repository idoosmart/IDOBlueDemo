//
//  IDOMaxMinColumnarViewModel.h
//  IDOEducation
//
//  Created by TigerNong on 2019/12/8.
//  Copyright © 2019 TigerNong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "IDOMaxMinModel.h"
#import "IDOChartCommonHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface IDOMaxMinColumnarViewModel : NSObject

/**
 数据数组
 */
@property (nonatomic,strong) NSArray <IDOMaxMinModel *>*dataValues;

/**
 y轴数据数组
 */
@property (nonatomic,strong) NSArray <NSString *>*yValues;

/**
 x轴数据数组,这个数组的个数与dataValues的个数一致，如果只想显示其中的几个，则需要在对应的位置设置为 @“”
 */
@property (nonatomic,strong) NSArray <NSString *>*xValues;

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
 显示x轴的横线，默认YES
 */
@property (nonatomic, assign) BOOL showXAleLine;

/**
 显示x轴的横线的大小，默认1.0
 */
@property (nonatomic, assign) BOOL xAlexLineWidth;

/**
 x轴文字的大小
 */
@property (nonatomic, strong) UIFont *xAlexTitleFont;


/**
 x轴的横线的颜色，默认黑色
 */
@property (nonatomic, strong) UIColor *xAlexLineColor;

/**
 设置x轴文字的颜色，默认黑色
 */
@property (nonatomic, strong) UIColor *xAlexTitleColor;

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
 柱状图的颜色，默认蓝色
 */
@property (nonatomic, strong) UIColor *columnarColor;

/**
 绘制柱状图区域的颜色，不能穿alpha为1.0的颜色，不然会遮挡住折线,默认白色，alpha 0.6
 */
@property (nonatomic, strong) UIColor *drawColumnarBackgroudColor;


/**
 显示顶部的标签
 */
@property (nonatomic, assign) BOOL showTopTipLabel;

/**
 是否显示竖线
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
 自定义标签
 */
@property (nonatomic, strong) UILabel *custemTipLabel;

/**
 top标签的frame
 */
@property (nonatomic, assign) CGRect topTipLabelFrame;

/**
 单位
 */
@property (nonatomic, copy) NSString *unit;

/**
 显示单位标签
 */
@property (nonatomic, assign) BOOL showUnitLabel;

/**
 单位标签的颜色
 */
@property (nonatomic, strong) UIColor *unitTitleColor;

/**
 党委标签的字体
 */
@property (nonatomic, strong) UIFont *unitFont;

/**
 两个柱状图的间距，默认10,
 */
@property (nonatomic, assign) CGFloat columnarMarginWidth;

/**
 柱状的宽度，默认30，如果柱状过小，可能就会出现x坐标轴文字重叠，这种情况下，选择这个位置来显示，其他的x为空
 
 这个参数主要是给可以滚动的情况下使用，在固定的情况下不能使用
 */
@property (nonatomic, assign) CGFloat columnarWidth;

/**
 柱状图的圆角
 */
@property (nonatomic, assign) CGFloat columnarRadius;

/**
 圆角的位置
 */
@property (nonatomic, assign) UIRectCorner corner;

/**
 第一个柱状左边缩进的宽度
 */
@property (nonatomic, assign) CGFloat headerEdge;

/**
 最后一个柱状左边缩进的宽度
 */
@property (nonatomic, assign) CGFloat footerEdge;

/**
 显示数据的竖线颜色,这个颜色只有在 showDataLineType =  IDOShowDataLineTypeTotleSolidLine ||  showDataLineType =  IDOShowDataLineTypeTotleDottedLine 才会有效，默认红色,
 */
@property (nonatomic, strong) UIColor *showDataTotleLineColor;


/**
 显示数据的竖线，顶部的颜色，只有在  showDataLineType =  IDOShowDataLineTypeUpSolidLineAndDownDottedLine ||  showDataLineType =  IDOShowDataLineTypeUpDottedLineAndDownDottedLine | IDOShowDataLineTypeUpSolidLine 有效，默认灰色
 */
@property (nonatomic, strong) UIColor *showDataDownLineColor;

/**
 显示数据的竖线大小，默认1.0
 */
@property (nonatomic, assign) CGFloat showDataLienWidth;

/**
 显示数据的数据样式,默认为整体实现，IDOShowDataLineTypeTotleSolidLine
 */
@property (nonatomic, assign) IDOShowDataLineType showDataLineType;

/**
 是否可以进行手势移动，默认YES
 */
@property (nonatomic, assign) BOOL gestureMove;

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
