//
//  IDOCalendarView.h
//  IDOSmartUIKit
//
//  Created by 农大浒 on 2020/1/14.
//  Copyright © 2020 农大浒. All rights reserved.
//

#import <UIKit/UIKit.h>



NS_ASSUME_NONNULL_BEGIN

@class IDOCalendarView;

typedef NS_OPTIONS(NSUInteger, IDOCalendarCaseOptions) {
    IDOCalendarCaseOptionsHeaderUsesDefaultCase      = 0,
    IDOCalendarCaseOptionsHeaderUsesUpperCase        = 1,
    
    IDOCalendarCaseOptionsWeekdayUsesDefaultCase     = 0 << 4,
    IDOCalendarCaseOptionsWeekdayUsesUpperCase       = 1 << 4,
    IDOCalendarCaseOptionsWeekdayUsesSingleUpperCase = 2 << 4,
    IDOCalendarCaseOptionsHeaderUsesShortChinese = 3, //显示周一
    IDOCalendarCaseOptionsHeaderUsesLongChinese = 4 //显示星期一
};

/**
 点击选中的日期
 */
typedef void(^IDOCalendarDidSelectedDateBlock)(NSDate *selectedDate);

/**
 点击切换月和周时，控件frame变化的回调
 */
typedef void(^IDOCalendarViewChangeFrameBlock)(IDOCalendarView *calendarView);


@interface IDOCalendarView : UIView

/**
 正常情况下文字显示的颜色
 */
@property (nonatomic, strong) UIColor *titleDefaultColor;

/**
 正常情况下，子标题的文字颜色
 */
@property (nonatomic, strong) UIColor *subTitleDefaultColor;

/**
 选中情况下，子标题的文字颜色
 */
@property (nonatomic, strong) UIColor *subTitleSelectionColor;

/**
 选中情况下文字显示的颜色
 */
@property (nonatomic, strong) UIColor *titleSelectedColor;

/**
 今天的背景颜色
 */
@property (nonatomic, strong) UIColor *todayColor;

/**
 今天文字的颜色
 */
@property (nonatomic, strong) UIColor *titleTodayColor;

/**
 今天子标题的文字颜色
 */

@property (nonatomic, strong) UIColor *subTitleTodayColor;

/**
 事件点正常情况下的背景颜色
 */
@property (nonatomic, strong) UIColor *eventPointDefaultColor;

/**
 事件点，选中情况下的背景颜色
 */
@property (nonatomic, strong) UIColor *eventPointSelectedColor;

/**
 选中时，cell的背景颜色
 */
@property (nonatomic, strong) UIColor *selectedColor;

/**
 正常情况下，cell边框的颜色
 */
@property (nonatomic, strong) UIColor *borderDefaultColor;

/**
 选中情况下，cell边框的颜色
 */
@property (nonatomic, strong) UIColor *borderSelectionColor;

/**
 cell 的文字大小
 */
@property (nonatomic, strong) UIFont *titleFont;

/**
 cell 的子标题文字大小，显示农历的标签的字体大小
 */
@property (nonatomic, strong) UIFont *subTitleFont;

/**
 顶部问题的大小，就是现实2020-01的文字字体
 */
@property (nonatomic, strong) UIFont *headerTitleFont;

/**
 星期的字体
 */
@property (nonatomic, strong) UIFont *weekdayFont;

/**
 星期的字体颜色
 */
@property (nonatomic, strong) UIColor *weekdayTextColor;

/**
 周末情况下，cell的文字颜色
 */
@property (nonatomic, strong) UIColor *titleWeekendColor;

/**
 周末情况下，cell的子标题文字颜色
 */
@property (nonatomic, strong) UIColor *subTitleWeekendColor;

/**
 头部的高度
 */
@property (nonatomic, assign) CGFloat headerHeight;

/**
 星期视图的高度
 */
@property (nonatomic, assign) CGFloat weekdayHeight;

/**
 是否显示农历
 */
@property (nonatomic, assign) BOOL showLunarDate;

/**
 当前选中的日期
 */
@property (nonatomic, strong) NSDate *selectedDate;

/**
 是否可以点击,默认YES
 */
@property (nonatomic, assign) BOOL canClick;

/**
 可以点击的日期数组，，格式为2020-01-14
 */
@property (nonatomic, strong) NSArray <NSString *>*canClickDates;


//最大和最小的日期
@property (nonatomic, strong) NSDate *maxDate;
@property (nonatomic, strong) NSDate *minDate;

/**
 时间日期数组，格式为2020-01-14
 */
@property (nonatomic, strong) NSArray <NSString *>*eventDates;

/**
 设置星期显示的样式
 */
@property (nonatomic, assign) IDOCalendarCaseOptions caseOptions;


/**
 点击选择时间的回调
 */
@property (nonatomic, copy) IDOCalendarDidSelectedDateBlock selectedDateBlock;

/**
 不能点击的时间回调，就是当点击在不可点击的item时的回调
 */
@property (nonatomic, copy) IDOCalendarDidSelectedDateBlock canNoClickSelectedDateBlock;

/**
 切换月和周的控件frame变化回调
 */
@property (nonatomic, copy) IDOCalendarViewChangeFrameBlock calendarViewChangeFrameBlock;

/**
 切换page的回调，可以用来判断当前page的时间与最大最小时间的关系
 */
@property (nonatomic, copy) IDOCalendarDidSelectedDateBlock currentPageFirstDateBlock;
/**
 切换月和周的UI
 */
- (void)showWeekStyle:(BOOL)showWeek animated:(BOOL)animated;

/**
 加载上一个月或者下一个月的数据
 */
- (void)loadNextsMonth;
- (void)loadPreviousMonth;
@end

NS_ASSUME_NONNULL_END
