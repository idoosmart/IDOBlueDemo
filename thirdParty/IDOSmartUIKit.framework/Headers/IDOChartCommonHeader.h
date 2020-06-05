//
//  IDOChartCommonHeader.h
//  IDOEducation
//
//  Created by TigerNong on 2019/12/1.
//  Copyright © 2019 TigerNong. All rights reserved.
//

#ifndef IDOChartCommonHeader_h
#define IDOChartCommonHeader_h

#define IDO_IS_iPhoneX      ([UIScreen instancesRespondToSelector:@selector(currentMode)] ?\
(\
CGSizeEqualToSize(CGSizeMake(375, 812),[UIScreen mainScreen].bounds.size)\
||\
CGSizeEqualToSize(CGSizeMake(812, 375),[UIScreen mainScreen].bounds.size)\
||\
CGSizeEqualToSize(CGSizeMake(414, 896),[UIScreen mainScreen].bounds.size)\
||\
CGSizeEqualToSize(CGSizeMake(896, 414),[UIScreen mainScreen].bounds.size))\
:\
NO)

//坐标轴的位置
typedef NS_ENUM(NSInteger, IDOYAlexPositionStyle) {
    IDOYAlexPositionStyleLeft,//坐标轴放在左边
    IDOYAlexPositionStyleRight,//坐标轴放在坐标轴放在右边
    IDOYAlexPositionStyleNone,//没有坐标轴
};

//睡眠图标显示的类型
typedef NS_ENUM(NSInteger, IDOSleepUIStyle) {
    IDOSleepUIStyleRect,//块状方式
    IDOSleepUIStyleRectRadiu,//块状方式带有弧度
    IDOSleepUIStyleColumnar,//柱状方式
};

//睡眠的类型
typedef NS_ENUM(NSInteger, IDOSleepType) {
    IDOSleepTypeDeep  = 3, //深睡
    IDOSleepTypeLight = 2, //浅睡
    IDOSleepTypeSober = 1, //清醒
};

//y轴标题与刻度线的位置
typedef NS_ENUM(NSInteger, IDOYAlexTextPosition) {
    IDOYAlexTextPositionLineUp     = 0, //刻度值位于刻度线上面
    IDOYAlexTextPositionLineCenter = 1, //刻度值位于刻度线中间
    IDOYAlexTextPositionLineDown   = 2, //刻度值位于刻度线下面
};

//指示竖线的类型
typedef NS_ENUM(NSInteger, IDOShowDataLineType) {
    IDOShowDataLineTypeTotleSolidLine                = 0, //整个为实线
    IDOShowDataLineTypeUpSolidLine                   = 1, //位于数据的上面的实现，最大的y值与数据的最小y值一致
    IDOShowDataLineTypeUpSolidLineAndDownDottedLine  = 2, //数据的顶部为实线，底部的虚线
    IDOShowDataLineTypeUpDottedLineAndDownDottedLine = 3, //数据的顶部为虚线，底部的虚线
    IDOShowDataLineTypeTotleDottedLine               = 4, //整个为虚线
};

typedef NS_ENUM(NSInteger, IDOLineColorStyle) {
    IDOLineColorStyleSingleColor    = 1,//单色
    IDOLineColorStyleMulColor       = 2,//撞色
    IDOLineColorStyleGradientColor  = 3,//渐变色
};


#define kPointKey  @"point"
#define kXValueKey @"xValue"
#define kYValueKey @"yValue"

#define kCurrentIndexKey  @"currentIndex"
#define kPreIndexKey @"preIndex"
#define kCurrentIndexXKey  @"currentIndexX"
#define kPreIndexXKey @"preIndexX"

#define IPHONE_X_MARGIN 34

#define kViewWidth(v) v.frame.size.width
#define kViewHeight(v) v.frame.size.height

#endif /* IDOChartCommonHeader_h */
