//
//  IDOFanMenuView.h
//  IDOEducation
//
//  Created by TigerNong on 2019/11/5.
//  Copyright © 2019 TigerNong. All rights reserved.
//


/**
 
 扇形菜单
 
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^IDOFanMenuViewClickResultBlock)(NSInteger idx);

@interface IDOFanMenuView : UIView
/**取消按钮  默认状态的文字*/
@property (nonatomic, copy) NSString *dismissButtonNormalTitle;

/**取消按钮  高亮状态的文字*/
@property (nonatomic, copy) NSString *dismissButtonHighlightTitle;

/**取消按钮  默认状态的文字颜色*/
@property (nonatomic, copy) UIColor *dismissButtonNormalTitleColor;

/**取消按钮  高亮状态的文字颜色*/
@property (nonatomic, copy) UIColor *dismissButtonHighlightTitleColor;

/**取消按钮  默认状态的图片*/
@property (nonatomic, strong) UIImage *dismissButtonNormalImage;

/**取消按钮  高亮状态的图片*/
@property (nonatomic, strong) UIImage *dismissButtonHighlightImage;

/**
 字体大小
 */
@property (nonatomic, strong) UIFont *titleFont;

/**
 每个的宽高
 */
@property (nonatomic, assign) CGFloat itemWidth;
@property (nonatomic, assign) CGFloat itemHeight;

/**
 退出按钮的宽高
 */
@property (nonatomic, assign) CGFloat dismissBtnWidth;
@property (nonatomic, assign) CGFloat dismissBtnHeight;

/**
 与底部的距离
 */
@property (nonatomic, assign) CGFloat dismissBtnToBottom;

/**
 与退出按钮的距离
 */

@property (nonatomic, assign) CGFloat itemToDismissWidth;


/**
 取消按钮的圆角
 */
@property (nonatomic, assign) CGFloat dismissCornerRadius;

/**
 取消按钮的线条宽度
 */
@property (nonatomic, assign) CGFloat dismissBorderWidth;

/**
 取消按钮的线条颜色
 */
@property (nonatomic, strong) UIColor *dismissBorderColor;

/**
 点击回调
 */
@property (nonatomic, copy) IDOFanMenuViewClickResultBlock clickBlock;

- (instancetype)initWithFrame:(CGRect)frame images:(nullable NSArray <UIImage *>*)images titles:(nullable NSArray <NSString *>*)titles;

- (void)show;

@end

NS_ASSUME_NONNULL_END
