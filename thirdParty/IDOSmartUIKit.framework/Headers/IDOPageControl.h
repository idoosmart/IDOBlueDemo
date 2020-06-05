//
//  IDOPageControl.h
//  IDOUIKitDemo
//
//  Created by 农大浒 on 2020/1/2.
//  Copyright © 2020 农大浒. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IDOPageControl : UIView
/**
 总的个数
 */
@property (nonatomic, assign) NSInteger numberOfPages;

/**
 当前的页数
 */
@property (nonatomic, assign) NSInteger currentPage;

/**
 当前选中的颜色
 */
@property (nonatomic, strong) UIColor *currentPageIndicatorTintColor;

/**
 当前未选中的颜色
 */
@property (nonatomic, strong) UIColor *pageIndicatorTintColor;

/**
 未选中时的宽度
 */
@property (nonatomic,assign) CGFloat pageIndicatorWidth;

/**
 高度
 */
@property (nonatomic,assign) CGFloat pageIndicatorHeight;

/**
 选中时的宽度
 */
@property (nonatomic,assign) CGFloat currentPageIndicatorWidth;

/**
 控件直接的距离
 */
@property (nonatomic,assign) CGFloat pageMargin;

/**
 每个的圆角，圆角不要超高度的一半
 */
@property (nonatomic, assign)CGFloat pageCornerRadius;

/**
 绘制边框的宽度
 */
@property (nonatomic, assign)CGFloat pageBorthWidth;

/**
 绘制边框的宽度
 */
@property (nonatomic, strong)UIColor *pageBorthColor;

/**
 绘制边框的宽度
 */
@property (nonatomic, strong)UIColor *currentPageBorthColor;

/**
 点击了返回的
 */
@property (nonatomic,copy) void (^ClickPageBlock)(NSInteger currentPage);

@end

NS_ASSUME_NONNULL_END
