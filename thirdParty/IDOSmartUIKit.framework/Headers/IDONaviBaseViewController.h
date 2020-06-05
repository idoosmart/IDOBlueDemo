//
//  IDONaviBaseViewController.h
//  IDONaviDemo
//
//  Created by TigerNong on 2019/11/7.
//  Copyright © 2019 TigerNong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IDONavigationBar.h"

typedef NS_ENUM(NSInteger, IDONaviBackItemStyle) {
    IDONaviBackItemStyleDark   = 0, //黑色的返回按钮图片
    IDONaviBackItemStyleLight  = 1, //白色的返回按钮图片
};



NS_ASSUME_NONNULL_BEGIN

@interface IDONaviBaseViewController : UIViewController
/**
 导航栏,在隐藏导航栏的时候不要使用 ido_navigationBar 的hidden，要使用下面的ido_naviBarHidden
 */
@property (nonatomic, strong, readonly) IDONavigationBar *ido_navigationBar;

/**
 是否显示状态栏
 */
@property (nonatomic, assign) BOOL ido_statusBarHidden;

/**
 是否显示导航栏
 */
@property (nonatomic, assign) BOOL ido_naviBarHidden;

/**
 左侧导航按钮
 */
@property (nonatomic, strong) UIBarButtonItem *ido_leftBarButtonItem;

/**
 左侧的导航按钮数组
 */
@property (nonatomic, strong) NSArray <UIBarButtonItem *> *ido_leftBarButtonItems;

/**
 右侧导航按钮
 */
@property (nonatomic, strong) UIBarButtonItem *ido_rightBarButtonItem;

/**
 右侧的导航按钮数组
 */
@property (nonatomic, strong) NSArray <UIBarButtonItem *> *ido_rightBarButtonItems;

/**
 导航的标题
 */
@property (nonatomic, copy) NSString *ido_naviTitle;

/**
 导航栏按钮的颜色
 */
@property (nonatomic, strong) UIColor *ido_navTintColor;
/**
 导航栏中间的标题view
 */
@property (nonatomic, strong) UIView *ido_navTitleView;
/**
 导航栏标题的字体颜色
 */
@property (nonatomic, strong) UIColor *ido_naviTitleColor;
/**
 导航栏标题字体大小
 */
@property (nonatomic, strong) UIFont *ido_naviTitleFont;

/**
 是否禁止当前控制器的滑动返回(包括全屏返回和边缘返回)
 */
@property (nonatomic, assign) BOOL ido_interactivePopDisabled;

/**
 是否禁止当前控制器的全屏滑动返回
 */
@property (nonatomic, assign) BOOL ido_fullScreenPopDisabled;

/**
 全屏滑动时，滑动区域距离屏幕左边的最大位置，默认是0：表示全屏都可滑动
 */
@property (nonatomic, assign) CGFloat ido_popMaxAllowedDistanceToLeftEdge;

/**
 设置状态栏 的 颜色 ，默认 NO ，设置YES 时为白色
 */
@property (nonatomic, assign) BOOL ido_statusBarStyleLightContent;

/**
 导航栏底部距离顶部的距离
 */
@property (nonatomic, assign, readonly) CGFloat ido_naviBarBottomToTopHeight;

/**
 导航栏变化时，刷新控件
 */
@property (nonatomic,copy) void(^ido_naviBarChangeFreshFrame)(CGFloat toNaviBarBottom);

/**
 设置返回按钮的类型,如果不设置这个方法，则不显示返回按钮
 */

- (void)setUpBackItemWithBackItemStyle:(IDONaviBackItemStyle)backItemStyle target:(id)target action:(SEL)action;

/**
 根据传入的图片设置返回按钮
 */
- (void)setBackItemWithImage:(UIImage *)image target:(id)target action:(SEL)action;

/**
 返回上一层
 */
- (void)ido_popViewControllerAnimated:(BOOL)animated;

/**
 根据下标，返回到指定的控制器
 */
- (void)ido_popToViewControllerIndex:(NSInteger)index  animated:(BOOL)animated;

/**
 刷新一下导航栏的frame
 */
- (void)ido_refreshNavBarFrame;
@end

NS_ASSUME_NONNULL_END
