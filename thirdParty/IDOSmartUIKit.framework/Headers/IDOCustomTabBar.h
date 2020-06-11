//
//  IDOCustomTabBar.h
//  IDOEducation
//
//  Created by TigerNong on 2019/11/6.
//  Copyright © 2019 TigerNong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IDOCustomTabBar : UITabBar
/**
 是否显示中间凸起的按钮
 */
@property (nonatomic, assign) BOOL ido_addCenterButton;
/**
中间按钮的中心Y点
*/
@property (nonatomic, assign) CGFloat ido_centerButtonCenterY;

/**
 中间按钮的尺寸
 */
@property (nonatomic, assign) CGFloat ido_centerButtonHeigth;
/**
 设置中间按钮的标题
 */
@property (nullable, nonatomic, copy) NSString *ido_centerButtonTitle;

/**
 设置中间按钮的正常图片
 */
@property (nullable, nonatomic, strong) UIImage *ido_centerButtonNomalImage;

/**
 设置中间按钮的高亮图片
 */
@property (nullable, nonatomic, strong) UIImage *ido_centerButtonHighlightImage;

/**
 背景颜色，这个是设置背景图片的颜色
 */
@property (nullable, nonatomic, strong) UIColor *ido_backgroudColor;

/**
 中间  + 号 文字的大小
 */
@property (nonatomic, strong) UIFont *ido_centerButtonFont;

/**
 中间  + 号 文字正常的颜色
 */
@property (nonatomic, strong) UIColor *ido_centerButtonTitleNomalColor;

/**
 中间  + 号 文字高亮的颜色
 */
@property (nonatomic, strong) UIColor *ido_centerButtonTitleHighlightColor;

/**
 是否隐藏顶部线条
 */
@property (nonatomic, assign) BOOL ido_hiddenTabBarTopLine;


/**
 如果要设置阴影或者圆角的情况，请把backgroundColor设置为clearColor，即self.ido_tabBar.backgroundColor = [UIColor clearColor];
 */
/**
 圆角的大小
 */
@property (nonatomic, assign) CGFloat ido_cornerRadius;

/**
 进行圆角设置时的背景颜色
 */
@property (nonatomic, strong) UIColor *ido_cornerBackgroudColor;

/**
 阴影的颜色
 */
@property (nonatomic, strong) UIColor *ido_shadowColor;

/**
 阴影的透过率
 */
@property (nonatomic, assign) CGFloat ido_shadowOpacity;

/**
 阴影的偏移尺寸
 */
@property (nonatomic, assign) CGSize ido_shadowOffset;


/**
 根据下标显示红点
 */
- (void)ido_showRedDotIndex:(NSInteger)index;

/**
 根据下标，隐藏红点
 */
- (void)ido_hideRedDotIndex:(NSInteger)index;

/**
 中间加号的点击
 */
@property (nonatomic,copy) void(^ido_didClickCenterButton)(UIButton *button);
@end

NS_ASSUME_NONNULL_END
