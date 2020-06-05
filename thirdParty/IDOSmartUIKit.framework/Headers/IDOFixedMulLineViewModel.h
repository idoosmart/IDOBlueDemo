//
//  IDOFixedMulLineViewModel.h
//  IDOUIKitDemo
//
//  Created by TigerNong on 2020/2/20.
//  Copyright © 2020 农大浒. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IDOValueModel.h"
#import "IDOXAlexModel.h"
#import "IDOYAlexModel.h"
#import "IDOChartCommonHeader.h"

#import "IDOMulDrawLinesModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface IDOFixedMulLineViewModel : NSObject

//指示竖线的类型
typedef NS_ENUM(NSInteger, IDOFixedMulShowDataLineType) {
    IDOFixedMulShowDataLineTypeAllLine                = 0, //整个为实线
    IDOFixedMulShowDataLineTypeNoTopLine              = 1, //不显示上面的部分，但是显示上面的点到下面的所有的线
    IDOFixedMulShowDataLineTypeCenterLine             = 2, //只显示中间部分
    IDOFixedMulShowDataLineTypeNoBottomLine           = 3, //不显示最底下那部分，其余的都显示
};



/**
 初始化数据
 
 @param dataArray 数据数组，指里面存在有多少条折线的数据，数组的每个元素是一个字典，字典的key是经过NSInteger转换成NSString，这个key是用来确定顺序的，所以不能乱写，value是NSArray ,这里value之所以是数组，是因为需要对没有没有数据的点进行隔离，隔离之后就表示一条线分成了几段；
 
 @param lineColors 每条折线的颜色，这个颜色的个数必须与dataArray的个数一至,如果两条折线的颜色一至，也要写，比如两个折线的宽度都是3，则lineColors = @[UIColor.redColor，UIColor.redColor]
 @param lineWidths 每条折线的宽度，这个宽度的个数必须与dataArray的个数一至，如果两条折线的宽度一至，也要写，比如两个折线的宽度都是3，则lineWidths = @[@(3),@(3)]
 
 @param yAlexValues y轴数据数组,如果传的是时间，则IDOYAlexModel 中的 yValue 要使用这样的格式"06:00"，如果不是时间则就直接“6”
 @param xAlexValues x轴数据数组
 
 @param yTotlePoint y轴方向可以显示的最多数据个数，也就是y的数据范围。假设y轴为一天的时间轴,以分钟为单位，则一天最大只有1440分钟，则yTotlePoint = 1440，这个也是相当于最大值
 
 @param xTotlePoint x轴方向可以显示的最多数据个数,也就是x的范围。假设以天为单位，一周的为7天，则 xTotlePoint = 7，这个可以根据实际进行设置，也可以跟dataArray的个数一致，相当于最大值
 
 @param drawViewWidth 绘制的区域宽度，与View的宽度一致
 @param drawViewHeight 绘制的区域高度，与View的高度一致
 
 */
- (instancetype)initLineDataArray:(NSArray <NSDictionary <NSString *,NSArray <IDOValueModel *>*>*>*)dataArray
                       lineColors:(NSArray <UIColor *>*)lineColors
                       lineWidths:(NSArray <NSNumber *>*)lineWidths
                      yAlexValues:(NSArray <IDOYAlexModel *>*)yAlexValues
                      xAlexValues:(NSArray <IDOXAlexModel *>*)xAlexValues
                      yTotlePoint:(NSUInteger)yTotlePoint
                      xTotlePoint:(NSUInteger)xTotlePoint
                    drawViewWidth:(CGFloat)drawViewWidth
                   drawViewHeight:(CGFloat)drawViewHeight;

/**
 数据数组，这个参数主要是在数据有变化的情况下，给于赋值
 */
@property (nonatomic, strong) NSArray <NSDictionary <NSString *,NSArray <IDOValueModel *>*>*>*dataArray;
/**
 y轴数据数组,如果传的是时间，则IDOYAlexModel 中的 yValue 要使用这样的格式"06:00"，如果不是时间则就直接“6”
 */
@property (nonatomic, strong) NSArray <IDOYAlexModel *>*yAlexValues;
@property (nonatomic, strong) NSArray <IDOXAlexModel *>*xAlexValues;
@property (nonatomic, assign) CGFloat drawViewWidth;
@property (nonatomic, assign) CGFloat drawViewHeight;
@property (nonatomic, assign) NSUInteger yTotlePoint;
@property (nonatomic, assign) NSUInteger xTotlePoint;

/**
 y轴的起始值，比如如果y轴表示的是时间，则y轴的最大值为1440分钟，假设y轴从06:00开始算起，则yStartValue = 360
 */
@property (nonatomic, assign) NSUInteger yStartValue;

/**
 折线的宽度的宽度数组
 */
@property (nonatomic, strong) NSArray <NSNumber *>*lineWidths;

/**
 折线的颜色数组
 */
@property (nonatomic, strong) NSArray <UIColor *>*lineColors;

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
 横坐标的横线宽度
 */
@property (nonatomic, assign) CGFloat xAlexLineWidth;

/**
 y轴的位置,默认为IDOYAlexPositionStyleLeft
 */
@property (nonatomic,assign) IDOYAlexPositionStyle positionType;

/**
 第一个点距离0点的距离，也就是这里可以设置第一个点不是从0点开始.默认为0。如果y轴在左侧，那么这里指的第一个点距离y坐标轴的距离,
 距离左边的总的宽带就是 leftMargin + yAlexWidth + fisrtPointMarginLeft
 */
@property (nonatomic,assign) CGFloat fisrtPointMarginLeft;

/**
 最后一个点距离右侧的距离，意思也是跟上面的类型,
 距离左边的总的宽带就是 leftMargin + yAlexWidth + fisrtPointMarginLeft
 */
@property (nonatomic,assign) CGFloat lastPointMarginRight;


/**
 绘制曲线区域的背景颜色,默认是白色，alpha为0.6
 */
@property (nonatomic, strong) UIColor *drawLinesBackgroudColor;

/**
 选中时的背景颜色
 */
@property (nonatomic, strong) UIColor *selectedColor;

/**
 是否可以进行点击
 */
@property (nonatomic, assign) BOOL canClick;

/**
 是否显示y轴的竖线
 */
@property (nonatomic, assign) BOOL showYAlexLine;

/**
 y轴竖线的宽度
 */
@property (nonatomic, assign) CGFloat yAlexLineWidth;

/**
 y轴竖线的颜色
 */
@property (nonatomic, strong) UIColor *yAlexLineColor;

/**
 y轴标签的文字颜色
 */
@property (nonatomic, strong) UIColor *yAlexTitleColor;

/**
 y轴标签的文字大小
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
 x轴到文字颜色
 */
@property (nonatomic, strong) UIColor *xAlexTitleColor;

/**
 x轴横线线的颜色
 */
@property (nonatomic, strong) UIColor *xAlexLineColor;

/**
 显示x轴横线
 */
@property (nonatomic, assign) BOOL showXAlexLine;


/**
 默认选中的下标,如果canClick为NO的情况下，及时设置了 showDefaultIndex 也不会起作用
 */
@property (nonatomic, assign) NSUInteger showDefaultIndex;

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
 是否显示圆点
 */
@property (nonatomic, assign) BOOL showCenterPoint;

/**
 是否显示圆环的外圈，默认YES
 */
@property (nonatomic, assign) BOOL showCenterPointLineWidth;

/**
 外圈的宽度，默认1
 */
@property (nonatomic, assign) CGFloat centerPointLineWidth;

/**
 外圈的颜色,默认白色
 */
@property (nonatomic, strong) UIColor *centerPointLineColor;

/**
 点击时显示的圆点的直径数组，如果为空，则圆点的直径默认为折线的宽度+1,数组个数要与折线条数一致，如果个数不一致，则会默认显示线宽的数组
 */
@property (nonatomic, strong) NSArray <NSNumber *>*centerViewRadius;

/**
 点击时圆点的颜色数组，如果为空是。则颜色为线条的颜色,数组个数要与折线条数一致，如果个数不一致，则会默认显示线颜色的数组
 */
@property (nonatomic, strong) NSArray <UIColor *>*centerViewColors;

/**
 选中时是否显示背景颜色
 */
@property (nonatomic, assign) BOOL showSelectedBackColor;

/**
 是否显示竖线，默认NO
 */
@property (nonatomic, assign) BOOL showDataLine;

/**
 竖线的颜色,默认红色
 */
@property (nonatomic, strong) UIColor *showDataLineColor;

/**
 默认1.0
 */
@property (nonatomic, assign) CGFloat showDataLineWidth;

/**
 显示竖线的样式,默认为IDOFixedMulShowDataLineTypeAllLine
 */
@property (nonatomic, assign) IDOFixedMulShowDataLineType dataLineType;

/**
 是否可以进行手势移动，默认YES
 */
@property (nonatomic, assign) BOOL gestureMove;



#pragma mark - ReadOnly
/**
 绘制折线的模型
 */
@property (nonatomic, strong, readonly) IDOMulDrawLinesModel *drawLineModel;

/**
 绘制折线的区域
 */
@property (nonatomic, assign, readonly) CGRect drawLineFrame;

/**
 每个点对应的CGPoint的数组
 */
@property (nonatomic, assign, readonly) NSArray *pointArr;


@end

NS_ASSUME_NONNULL_END
