//
//  IDOSleepViewModel.h
//  IDOEducation
//
//  Created by 农大浒 on 2019/12/11.
//  Copyright © 2019 TigerNong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IDOChartCommonHeader.h"
#import "IDOSleepModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface IDOSleepViewModel : NSObject

/**
 显示的UI类型
 */
@property (nonatomic, assign) IDOSleepUIStyle sleepUIType;

//实际模型
@property (nonatomic, strong) NSArray <IDOSleepModel *>*sleeps;

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
 x轴的高度,默认30
 */
@property (nonatomic,assign) CGFloat xAlexHeight;

/**
 绘制柱状图区域的颜色，不能穿alpha为1.0的颜色，不然会遮挡住折线,默认白色，alpha 0.6
 */
@property (nonatomic, strong) UIColor *drawColumnarBackgroudColor;

/**
 显示顶部提示标签，默认显示YES
 */
@property (nonatomic, assign) BOOL showTopTipLabel;

/**
 显示竖线，默认显示YES
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
 自定义顶部的标签
 */
@property (nonatomic, strong) UILabel *tipLabel;

/**
在不是自定义标签的情况下下，文字的内容,
 tipContentStr = @" 睡眠状态:%@ \n  开始时间:%@ \n 结束时间:%@ \n 持续时长:%ld分钟"
 */
@property (nonatomic, copy) NSString *tipContentStr;

/**
 睡眠状态对应的文字数组，这个数组的主要目前是用来显示对应的问题，假如1表示深睡，2表示浅睡，3表示REM，4表示清醒睡眠，则数组为[@"深睡睡眠"，@"浅睡睡眠"，@"REM睡眠"，@"清醒睡眠"]
 */
@property (nonatomic,strong) NSArray *sleepStutaStrs;

/**
 显示数据的竖线的颜色，默认是灰色
 */
@property (nonatomic, strong) UIColor *showDataLineColor;

/**
 显示数据竖线的宽度，默认是1，最大不能超过10
 */
@property (nonatomic, assign) CGFloat showDataLineWidth;

/**
 设置x轴文字的颜色，默认黑色
 */
@property (nonatomic, strong) UIColor *xAlexTitleColor;

/**
 设置x轴文字的大小，默认10
 */
@property (nonatomic, strong) UIFont *xAlexTitleFont;

/**
 圆角半径
 sleepUIType 为rect的情况下才会有用
 */
@property (nonatomic,assign) CGFloat radiu;

/**
 睡眠模式上下的间距
 sleepUIType 为rect的情况下才会有用
 */
@property (nonatomic,assign) CGFloat itemMargin;

/**
 头部锁紧
 */
@property (nonatomic, assign) CGFloat headerEdge;

/**
 尾部锁紧
 */
@property (nonatomic, assign) CGFloat footerEdge;

/**
 选中是的颜色,这个只有是在 IDOSleepUIStyleRect 和 IDOSleepUIStyleColumnar有效,默认为红色
 */
@property (nonatomic, strong) UIColor *selectColor;

/**
 是否显示x轴，默认为YES
 */
@property (nonatomic, assign) BOOL showXAlexView;

/**
 x轴横线的高度,默认是1.0
 */
@property (nonatomic, assign) CGFloat xAlexLineViewHeight;

/**
 x轴横线的颜色,默认灰色
 */
@property (nonatomic, strong) UIColor *xAlexLineViewColor;

/**
 是否设置默认选中的cell
 */
@property (nonatomic, assign) BOOL showDefaultSelectedCell;

/**
 设置默认选中的cell的下标
 */
@property (nonatomic, strong) NSIndexPath *defaultSelectedCellIndexPath;



#pragma mark - ReadOnly
//最早一次入睡的时间
@property (nonatomic, copy, readonly) NSString *fisrtSleepTimeStr;

//最后一次睡醒的时间
@property (nonatomic, copy, readonly) NSString *lastWakeUpTimeStr;

//最后一次醒来的时间与最早一次入睡的时间的总时长
@property (nonatomic, assign, readonly) NSInteger totleSleepTimes;


//清醒时长
@property (nonatomic, assign, readonly) NSInteger wakeTimeDuration;

//浅睡时长
@property (nonatomic, assign, readonly) NSInteger lightTimeDuration;

//深睡时长
@property (nonatomic, assign, readonly) NSInteger deepTimeDuration;

@end

NS_ASSUME_NONNULL_END
