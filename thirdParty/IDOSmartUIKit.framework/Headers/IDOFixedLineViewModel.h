//
//  IDOFixedLineViewModel.h
//  IDOEducation
//
//  Created by TigerNong on 2019/12/14.
//  Copyright © 2019 TigerNong. All rights reserved.
//

/**
 
 创建 dataDic 的样例1
 
 NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    //字典的key对应整形
    NSInteger index = 0;
 
    //在这里设置一个间隔时间，如果时间超过10分钟，则两点之间不连线
    NSInteger minDuration = 10;
 
    //计算每个点相对0点的偏移，用来计算正在的时间
    NSInteger totleTime = 0;
    for (NSInteger i = 0; i < items.count; i ++) {
        
        IDOValueModel *valueModel = [[IDOValueModel alloc] init];
        
        NSDictionary *currentItemDic = items[i];
        NSInteger currentTime = [currentItemDic[@"offset_minute"] integerValue];
        
        NSString *value = currentItemDic[@"heart_rate_value"];
                
        //这里index表示的是偏移多少个点
        valueModel.index = currentTime;
        valueModel.yValue = value;
        totleTime = totleTime + currentTime;
        
        NSInteger currentDateInt = zeroTime + totleTime * 60;
        NSDate *currentDate = [NSDate dateWithTimeIntervalSince1970:currentDateInt];
        NSString *currentDateStr = [[self minuthDateFormater] stringFromDate:currentDate];
        valueModel.xValue = currentDateStr;
        
        NSInteger nextTime = currentTime;
        if (i < items.count - 1) {
            NSDictionary *nextItemDic = items[i + 1];
            nextTime = [nextItemDic[@"offset_minute"] integerValue];
        }
        
        NSString *key = [NSString stringWithFormat:@"%ld",index];
                    
        //判断两点之间的时间间隔是否超过设定的数值
        if (nextTime - currentTime > minDuration) {
            index ++;
        }
        
        NSMutableArray *arr = dic[key];
        if (arr) {
            [arr addObject:valueModel];
        }else{
            arr = [NSMutableArray array];
            [arr addObject:valueModel];
            [dic setValue:arr forKey:key];
        }
    }
 
 
 样例2，正常不存在有断线情况下的数据拼装
    //创建一个可变数组，用来放置数据
     NSMutableArray *valueArr = [NSMutableArray array];
 
     //创建一个可变字典
     NSMutableDictionary *ddd = [NSMutableDictionary dictionary];
     NSInteger keyIndex = 0;
      NSString *key = [NSString stringWithFormat:@"%ld",keyIndex];
     for (NSInteger i = 0; i < 7; i ++) {
         NSInteger num = arc4random() % 150 + 10;
         NSString *numStr = [NSString stringWithFormat:@"%ld",num];
         IDOValueModel *xModel = [[IDOValueModel alloc] init];
         xModel.xValue = [NSString stringWithFormat:@"%ld",i];
        //这个位置需要传入1，因为这个需要去累计计算，如果这里不是传入1的话，计算的x轴会超过指定的范围
         xModel.index = 1;
        //如果第一个值需要从0开始，则需要把的值的index设置为0
         if (i == 0) {
             xModel.index = 0;
         }
 
         xModel.yValue = numStr;
         [valueArr addObject:xModel];
         [ddd setValue:valueArr forKey:key];
     }
 
 */




#import <Foundation/Foundation.h>
#import "IDOValueModel.h"
#import "IDOXAlexModel.h"
#import "IDOYAlexModel.h"
#import "IDOChartCommonHeader.h"

NS_ASSUME_NONNULL_BEGIN


@interface IDOFixedLineViewModel : NSObject

/**
@param dataDic 数据字典，字典的key为字符类型，这个key是根据NSinteger的类型转化来的，里面需要使用这个key去做判断

@param yAlexValues y轴数据
@param xAlexValues x轴数据
@param totlePoints 总的点数，这个用来计算每个点之间的间隔，及折线区域的宽度除于总个数即为点之间的间隔
 */
- (instancetype)initDataDic:(NSDictionary <NSString *,NSArray <IDOValueModel *>*>*)dataDic
                yAlexValues:(NSArray <IDOYAlexModel *>*)yAlexValues
                xAlexValues:(NSArray <IDOXAlexModel *>*)xAlexValues
                totlePoints:(NSInteger)totlePoints
              drawViewWidth:(CGFloat)drawViewWidth
             drawViewHeight:(CGFloat)drawViewHeight;

/**
 整个绘图区域的宽高，一般情况下就是与设置绘图的view一致，
 屏幕旋转的时候，请重新输入宽高，这个两个字段主要是用来重新确认点的位置
 */
@property (nonatomic, assign) CGFloat drawViewWidth;
@property (nonatomic, assign) CGFloat drawViewHeight;

/**
 数据的字典
 
 在里面的 valueModel.index 中的index，在这个dataDic中表示的相对上一个数据的偏移量，
 然后会根据这个index的累加来计算每个点的x坐标值，所以在这里传值的时候，需要注意。
 在这里之所以这样写，是为了解决数据部分缺失的情况，数据缺失的情况下，画的折线需要断开。
 
 具体组装字典数据，请看上面的例子
 
 */
@property (nonatomic, strong) NSDictionary <NSString *,NSArray <IDOValueModel *>*>*dataDic;

/**
 y轴之间的数组
 */
@property (nonatomic, strong) NSArray <IDOYAlexModel *>*yAlexValues;

/**
 y轴之间的数组
 */
@property (nonatomic, strong) NSArray <IDOXAlexModel *>*xAlexValues;


/**
 起始点
 
 如果是在绘制心率，则这个则为相对0点的开始时间，如果startIndex = 100，则表示心率从100分钟开始绘制
 */
@property (nonatomic, assign) NSInteger startIndex;

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
 曲线颜色的样式
 */
@property (nonatomic, assign) IDOLineColorStyle lineColorStyle;

/**
 线条的颜色，默认黑色
 */
@property (nonatomic, strong) UIColor *lineColor;

/**
 线条的宽度，默认1.0
 */
@property (nonatomic, assign) CGFloat lineWidth;

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
 自定义顶部的标签
 */
@property (nonatomic, strong) UILabel *customTipLabel;

/**
 在不自定义的情况下，设置frame
 */
@property (nonatomic, assign) CGRect tipLabelFrame;

/**
 tipLabel的文字内容,@"%@次 %@";，第一个为心率，第二个为时间
 */
@property (nonatomic, copy) NSString *tipLabelText;

/**
 顶部标签的背景颜色，默认亮灰色
 */
@property (nonatomic, strong) UIColor *tipLabelBackgroudColor;

/**
 显示数据的竖线颜色，默认红色
 */
@property (nonatomic, strong) UIColor *showDataLienColor;

/**
 显示数据的竖线大小，默认1.0
 */
@property (nonatomic, assign) CGFloat showDataLienWidth;

/**
 是否显示顶部的标签
 */
@property (nonatomic, assign) BOOL showTipLabel;

/**
 是否显示竖线
 */
@property (nonatomic, assign) BOOL showDataLine;

/**
 是否显示中心的圆圈,默认显示
 */
@property (nonatomic, assign) BOOL showLineCenterView;

/**
 中心圆圈的颜色，默认为红色
 */
@property (nonatomic, strong) UIColor *lineCenterViewColor;

/**
 中心圆外圈的颜色,默认为白色
 */
@property (nonatomic, strong) UIColor *lineCenterViewBorthColor;

/**
 中心圆圈，外圈的宽度,默认宽度1.5
 */
@property (nonatomic, assign) CGFloat lineCenterViewBorthWidth;

/**
 默认获取第一个，showDefaultLastValue 只能存在一个，如果两个都为YES，则只能去最后设置的那个
 */
@property (nonatomic, assign) BOOL showDefaultFisrtValue;

/**
 默认获取最后一个
 */
@property (nonatomic, assign) BOOL showDefaultLastValue;

/**
 是否显示折线区域的渐变色(渐变色只有两种颜色)
 */
@property (nonatomic, assign) BOOL showLineRectGradient;
/**
 折线区域渐变开始的颜色
 */
@property (nonatomic, strong) UIColor *lineRectGradientStartColor;

/**
折线区域渐变结束的颜色
*/
@property (nonatomic, strong) UIColor *lineRectGradientEndColor;

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
 标准值，数值
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



#pragma mark - ReadOnly
/**
 点总个数
 */
@property (nonatomic,assign,readonly) NSInteger totlePointCounts;

/**
 数据的最大值
 */
@property (nonatomic,assign,readonly) CGFloat maxValue;

/**
 数据的最小值
 */
@property (nonatomic,assign,readonly) CGFloat minValue;

/**
 y轴的最大值
 */
@property (nonatomic,assign,readonly) CGFloat maxYValue;

/**
 y轴的最小值
 */
@property (nonatomic,assign,readonly) CGFloat minYValue;

/**
 点的坐标数组
 */
@property (nonatomic, strong,readonly) NSArray *pointArray;

/**
 数据的数组
 */
@property (nonatomic, strong,readonly) NSArray *datas;

/**
 y轴的坐标值
 */
@property (nonatomic, strong,readonly) NSArray *yAlexArray;
@end

NS_ASSUME_NONNULL_END
