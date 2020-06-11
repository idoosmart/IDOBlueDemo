//
//  IDOSegmentedControl.h
//  UIKitDemo
//
//  Created by 农大浒 on 2020/1/4.
//  Copyright © 2020 农大浒. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IDOSegmentedControl : UIView

/**
 初始化
 */
- (instancetype)initWithFrame:(CGRect)frame items:(NSArray <NSString *>*)items;

/**
 选中的下标，默认为0
 */
@property (nonatomic, assign) NSInteger selectedSegmentIndex;

/**
 圆角，默认是控件高度的一半
 */
@property (nonatomic, assign) CGFloat cornerRadius;

/**
 边框线条的宽度。1.0
 */
@property (nonatomic, assign) CGFloat borderWidth;

/**
 边框的颜色
 */
@property (nonatomic, strong) UIColor *borderColor;

/**
 选中的背景颜色
 */
@property (nonatomic, strong) UIColor *selectedSegmentColor;

/**
 未选中的背景颜色
 */
@property (nonatomic, strong) UIColor *defaultSegmentColor;

/**
 选中的文字颜色
 */
@property (nonatomic, strong) UIColor *selectedSegmentTitleColor;

/**
 未选中的文字颜色
 */
@property (nonatomic, strong) UIColor *defaultSegmentTitleColor;

/**
 未选中的文字颜色
 */
@property (nonatomic, strong) UIFont *segmentTitleFont;

/**
 点击回调,在创建好了对象之后，就先调用这个回调，然后在设置 selectedSegmentIndex 这样才会制动调用 selectedSegmentInde指定的item
 */
@property (nonatomic, copy) void (^segmentClickReturnBlock)(NSInteger selectedSegmentIndex);

@end

NS_ASSUME_NONNULL_END
