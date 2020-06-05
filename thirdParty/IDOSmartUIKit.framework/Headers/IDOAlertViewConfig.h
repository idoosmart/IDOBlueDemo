//
//  IDOAlertViewConfig.h
//  IDOSmartUIKit
//
//  Created by 农大浒 on 2020/3/10.
//  Copyright © 2020 农大浒. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IDOAlertViewConfig : NSObject

/**
 弹框与左右两边的距离，默认是60；
 */
@property (nonatomic, assign) CGFloat contentMerginLeft;

/**
 title的字体,默认[UIFont boldSystemFontOfSize:18]
 */
@property (nonatomic, strong) UIFont *titleFont;

/**
 title的字体颜色,默认[UIColor blackColor];
 */
@property (nonatomic, strong) UIColor *titleTextColor;

/**
 title的对齐方式
 */
@property (nonatomic, assign) NSTextAlignment titleTextAlignment;

/**
 控件之间的间距，默认10
 */
@property (nonatomic, assign) CGFloat margin;

/**
 title标签与弹框顶部的距离，默认与margin 相等
 */
@property (nonatomic, assign) CGFloat titleLabelToTop;

/**
 图片的宽高，默认45
 */
@property (nonatomic, assign) CGFloat imageViewWidthHeight;

/**
 图片顶部与其他控件的距离，默认49
 */
@property (nonatomic, assign) CGFloat imageToTop;

/**
 图片底部与其他控件的距离，默认27
 */
@property (nonatomic, assign) CGFloat imageToBottom;

/**
 内部控件与弹框左侧的距离，默认36
 */
@property (nonatomic, assign) CGFloat marginLeft;

/**
 内容标签的字体,默认[UIFont systemFontOfSize:15]
 */
@property (nonatomic, strong) UIFont *contentFont;

/**
 内容字体的颜色,默认是[UIColor grayColor]
 */
@property (nonatomic, strong) UIColor *messageContentTextColor;

/**
 内容的对齐方式
 */
@property (nonatomic, assign) NSTextAlignment messageTextAlignment;

/**
 alert底部线条的颜色
 */
@property (nonatomic, strong) UIColor *alertBottonLineColor;

/**
 alert底部线条的高度
 */
@property (nonatomic, assign) CGFloat alertBottonLineHeight;

/**
 alert底部线条与上一个控件的距离
 */
@property (nonatomic, assign) CGFloat alertBottomLineToTop;

/**
 取消按钮的颜色,默认
 */
@property (nonatomic, strong) UIColor *cancelBtnTitleColor;

/**
 取消按钮的字体
 */
@property (nonatomic, strong) UIFont *cancelBtnFont;

/**
 确认按钮的颜色,默认
 */
@property (nonatomic, strong) UIColor *confirmBtnTitleColor;

/**
 确认按钮的字体
 */
@property (nonatomic, strong) UIFont *confirmBtnFont;

/**
 取消按钮的背景颜色
 */
@property (nonatomic, strong) UIColor *cancelBtnBackgroudColor;

/**
 确定按钮的背景颜色
 */
@property (nonatomic, strong) UIColor *confirmBtnBackgroudColor;



#pragma mark - sheet

/**
 每一行的高度
 */
@property (nonatomic, assign) CGFloat rowHeight;

/**
 主标题的字体大小
 */
@property (nonatomic, strong) UIFont *itemTextFont;

/**
 子标题的字体大小
 */
@property (nonatomic, strong) UIFont *itemSubTextFont;

/**
 主标题的文字颜色
 */
@property (nonatomic, strong) UIColor *itemTextColor;

/**
 子标题的文字颜色
 */
@property (nonatomic, strong) UIColor *itemSubTextColor;

/**
 item 的线的颜色
 */
@property (nonatomic, strong) UIColor *itemLineColor;

+ (IDOAlertViewConfig *)shareInstance;

@end

NS_ASSUME_NONNULL_END
