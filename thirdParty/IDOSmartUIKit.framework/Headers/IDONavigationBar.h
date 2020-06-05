//
//  IDONavigationBar.h
//  IDONaviDemo
//
//  Created by TigerNong on 2019/11/7.
//  Copyright © 2019 TigerNong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IDONavigationBar : UINavigationBar

/**
 是否隐藏状态栏
 */
@property (nonatomic, assign) BOOL ido_statusBarHidden;

/**
 导航栏背景色透明度，默认是1.0
 */
@property (nonatomic, assign) CGFloat  ido_navBarBackgroundAlpha;

/**
 是否隐藏底部的线条 (隐藏或者显示，不能和导航栏底部线条的颜色一起使用)
 */
@property (nonatomic, assign) BOOL ido_navLineHidden;

/**
 导航栏底部线条的颜色(隐藏或者显示，不能和导航栏底部线条的颜色一起使用)
 */
@property (nonatomic, strong) UIColor *ido_naviBottomLineColor;

/**
 设置背景颜色 (颜色和图片只能使用一个)
 */
@property (nonatomic, strong) UIColor *ido_backgroudColor;

/**
 设置背景图片（图片和颜色只能使用一个）
 */
@property (nonatomic, strong) UIImage *ido_backgroundImage;

/**
 如果是 self.modalPresentationStyle == UIModalPresentationPageSheet || self.modalPresentationStyle == UIModalPresentationFormSheet || self.modalPresentationStyle == UIModalPresentationPopover 是这三种情况，则需要重新刷新一下内部空间
 */
@property (nonatomic, assign) BOOL ido_needRefreshModalPresentationStyle;

@end

NS_ASSUME_NONNULL_END
