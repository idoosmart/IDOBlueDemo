//
//  IDOSegmentView.h
//  IDOEducation
//
//  Created by TigerNong on 2019/11/11.
//  Copyright © 2019 TigerNong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^IDOSegmentDidClickBlock)(NSInteger selectedIndex);

typedef NS_ENUM(NSInteger, IDOSegmentViewType) {
    IDOSegmentViewTypeHalfLine,   //底部下划线，只有按钮的宽度一半
    IDOSegmentViewTypeWholeLine,   //底部下划线，与按钮一样的宽
    IDOSegmentViewTypeRect,   //背景图片
};


@interface IDOSegmentView : UIView

/**
 初始化， 为了能够兼容在导航栏里面也能够使用，在初始化的时候要使用frame
 */
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray <NSString *>*)titles type:(IDOSegmentViewType)type handleClickIndexCompleter:(IDOSegmentDidClickBlock)block;

/**
 当前选中的是哪一个位置的下标，这个必须得进行赋值
 */
@property (nonatomic, assign) NSInteger selectedIndex;

/**
 默认标题的颜色
 */
@property (nonatomic, strong) UIColor *titleNormalColor;

/**
 选中标题的颜色
 */
@property (nonatomic, strong) UIColor *titleSelectedColor;

/**
 默认标题的文字大小
 */
@property (nonatomic, strong) UIFont *titleNormalFont;

/**
 选中标题的文字大小
 */
@property (nonatomic, strong) UIFont *titleSelectedFont;

/**
 指示器的颜色
 */
@property (nonatomic, strong) UIColor *indicatorViewColor;

/**
 滚动到下标已经滚动的偏移量
 */
- (void)scrollToIndex:(NSInteger)index offset:(CGFloat)offset;

@end

NS_ASSUME_NONNULL_END
