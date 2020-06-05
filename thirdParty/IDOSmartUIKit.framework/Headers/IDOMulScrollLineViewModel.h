//
//  IDOMulScrollLineViewModel.h
//  IDOUIKitDemo
//
//  Created by 农大浒 on 2020/4/16.
//  Copyright © 2020 农大浒. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IDOValueModel.h"
#import "IDOXAlexModel.h"
#import "IDOYAlexModel.h"
#import "IDOChartCommonHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface IDOMulScrollLineViewModel : NSObject

/**
 绘制滚定的曲线
 @param datas 运动的数据数组
 @param yAlexTitles y轴的标题数组
 @param xAlexTitles x轴的标题数组
 @param perPageCount 每一页可绘制的点数
 @param drawViewWidth 长度
 @param drawViewHeight 宽度
 */
- (id)initWithDatas:(NSArray <IDOValueModel *>*)datas
        yAlexTitles:(nullable NSArray <NSString *>*)yAlexTitles
        xAlexTitles:(nullable NSArray *)xAlexTitles
       perPageCount:(NSInteger)perPageCount
      drawViewWidth:(CGFloat)drawViewWidth
     drawViewHeight:(CGFloat)drawViewHeight;

/**
 数据数组
 */
@property (nonatomic, strong) NSArray <IDOValueModel *>*datas;

/**
 y轴标题
 */
@property (nonatomic, strong) NSArray <NSString *>*yAlexTitles;

/**
 x轴标题
 */
@property (nonatomic, strong) NSArray <NSString *>*xAlexTitles;

/**
 每一页可绘制的点数
 */
@property (nonatomic, assign) NSInteger perPageCount;

/**
 宽度
 */
@property (nonatomic, assign) CGFloat drawViewWidth;

/**
 高度
 */
@property (nonatomic, assign) CGFloat drawViewHeight;

/**
 柱状图与顶部的距离，默认20
 */
@property (nonatomic,assign) CGFloat topMargin;
/**
 柱状图与左边的距离，默认20
 */
@property (nonatomic,assign) CGFloat leftMargin;

/**
 柱状图与右边的距离，默认20
 */
@property (nonatomic,assign) CGFloat rightMargin;

/**
 y轴的位置,默认为IDOYAlexPositionStyleLeft
 */
@property (nonatomic,assign) IDOYAlexPositionStyle positionType;

/**
 y轴的宽度，默认30
 */
@property (nonatomic,assign) CGFloat yAlexWidth;

/**
 x轴标题文字的字体
 */
@property (nonatomic, strong) UIFont *xAlexTitleFont;

/**
 x轴标题文字的颜色
 */
@property (nonatomic, strong) UIColor *xAlexTextColor;

/**
 是否隐藏x轴的横线
 */
@property (nonatomic, assign) BOOL hiddenXAlexLine;

/**
 x轴横线的高度
 */
@property (nonatomic, assign) CGFloat xAlexLineHeight;

/**
 x轴横线的背景颜色
 */
@property (nonatomic, strong) UIColor *xAlexLineColor;

/**
 x轴的高度,默认30
 */
@property (nonatomic,assign) CGFloat xAlexHeight;


/**
 显示最大和最小值，默认NO
 */
@property (nonatomic, assign) BOOL showMaxAndMinValue;


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
设置y轴文字的大小，默认[UIFont systemFontOfSize:10]
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
 只显示绘制区域的头和尾坐标值,默认NO
 */
@property (nonatomic, assign) BOOL onlyShowHeaderAndFooter;

/**
 曲线颜色的样式,要设置这个之前，请先设置好数组mulColorValueArray和mulColorArray
 */
@property (nonatomic, assign) IDOLineColorStyle lineColorStyle;

/**
 当数值小于纵坐标最小值时，数值按照最小纵坐标数值显示还是隐藏，默认为NO，NO的情况下就是显示最纵坐标最小的刻度值的数据，YES则表示过滤掉低于最小纵坐标值
 */
@property (nonatomic, assign) BOOL hiddenLessYAlexMinValueData;

/**
 指定显示撞色范围数组,这个数组只有是在 lineColorStyle == IDOLineColorStyleMulColor,才会有用,数据格式如下：@[@"0-50",@"50-100",@"100-150"]
 */
@property (nonatomic, strong) NSArray <NSString *>*mulColorValueArray;

/**
 指定显示撞色的颜色数组,这个数组只有是在 lineColorStyle == IDOLineColorStyleMulColor,才会有用
 */
@property (nonatomic, strong) NSArray <UIColor *>*mulColorArray;

/**
 折线的颜色
 */
@property (nonatomic, strong) UIColor *lineColor;

/**
 折线的大小
 */
@property (nonatomic, assign) CGFloat lineWidth;

/**
 绘制曲线区域的颜色，如果hiddenLessYAlexMinValueData == YES的情况下，只能使用纯色的，不能带有不是1的alpha
 */
@property (nonatomic, strong) UIColor *drawBackColor;

/**
 渐变的颜色数组,只能是两个元素,如果这个数组为空，则表示不进行渐变色，如果存在有两个颜色，则表示默认显示背景渐变色
 */
@property (nonatomic, strong) NSArray <UIColor *>*gradientRectColors;

/**
 指定不显示小于某个值得数据
 */
@property (nonatomic, copy) NSString *limitMinDataValue;



#pragma mark - Readonly

/**
 返回处理好的数据点的数组(这个数据是没有经过添加点的数)
 */
@property (nonatomic, strong, readonly) NSArray <NSNumber *>*pointArray;
/**
 设置撞色情况下，组成点的数组,如果不是撞色，则这个数组没有使用
 */
@property (nonatomic, strong, readonly) NSArray <NSNumber *>*mulColorLinePointArray;

/**
 指定绘制撞色区域的y值数组，假设现在的 mulColorValueArray = @[@"0-50",@"50-100",@"100-150"]，则要计算出数值对应的y值
 */
@property (nonatomic, strong, readonly) NSArray <NSString *>*mulColorYArray;

/**
 撞色的数据数组
 */
@property (nonatomic, strong, readonly) NSArray <IDOValueModel *>*mulDatas;

/**
 返回曲线的可会绘制区域
 */
@property (nonatomic, assign, readonly) CGRect drawLineFrame;

/**
 y轴坐标点的y值数组
 */
@property (nonatomic, strong, readonly) NSArray *yAlexYArray;

/**
 最小值显示的y值
 */
@property (nonatomic, assign, readonly) CGFloat showMinValueY;

/**
 最大值
 */
@property (nonatomic, assign, readonly) CGFloat max;

/**
 最小值
 */
@property (nonatomic, assign, readonly) CGFloat min;

@end

NS_ASSUME_NONNULL_END
