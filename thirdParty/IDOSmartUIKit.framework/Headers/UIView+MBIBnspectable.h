//
//  UIView+MBIBnspectable.h
//  YDCalculateTool
//
//  Created by xiongze on 2018/1/10.
//  Copyright © 2018年 aiju_huangjing1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MBIBnspectable)


/**
 圆角、边框颜色、边框宽度
 */
@property (assign,nonatomic) IBInspectable CGFloat cornerRadius;
@property (assign,nonatomic) IBInspectable CGFloat borderWidth;
@property (strong,nonatomic) IBInspectable UIColor *borderColor;

// set background hex color
//@property (assign,nonatomic) IBInspectable NSString *hexRgbColor;
//@property (assign,nonatomic) IBInspectable BOOL onePx;


/**
 xib文件中设置阴影
 */
@property (nonatomic, assign) IBInspectable BOOL masksToBounds;
@property (nonatomic, strong) IBInspectable UIColor *shadowColor;
@property (nonatomic, assign) IBInspectable CGSize shadowOffset;
@property (nonatomic, assign) IBInspectable CGFloat shadowRadius;
@property (nonatomic, assign) IBInspectable CGFloat shadowOpacity;



#pragma mark - 使用 UIBezierPath、 CAShapeLayer 绘制视图圆角
// 2020-02-25 农大浒 新增
/**
 使用 UIBezierPath、 CAShapeLayer 绘制视图圆角
 
 在绘制圆角时，需要注意的是，这个视图必须存在有frame
 
@param radius 圆角的半径，默认为四个角
 */
- (void)setUpViewRadius:(CGFloat)radius;
/**
 指定角进行圆角
 
 @param corners 圆角位置
 @param radius 圆角半径
 */
- (void)setUpVieworners:(UIRectCorner)corners radius:(CGFloat)radius;


@end
