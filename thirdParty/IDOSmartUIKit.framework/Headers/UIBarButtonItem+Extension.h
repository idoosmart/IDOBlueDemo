//
//  UIBarButtonItem+Extension.h
//  IDONaviDemo
//
//  Created by TigerNong on 2019/11/7.
//  Copyright © 2019 TigerNong. All rights reserved.
//


#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (Extension)
/**
 设置按钮，图片和文字都有的情况
 @param title 标题
 @param normolColor 正常情况下文字的颜色
 @param highLightColor 按住时文字的颜色
 @param imageName 正常情况下图片的名称
 @param highLightImageName 按住时图片的名称
 @param bundle 图片所在的项目，可以随便填写当前的控制器
 @param target 在那个位置使用
 @param action 实现的点击方法
 @return 返回一个UIBarButtonItem
 */
+ (instancetype)itemWithTitle:(nullable NSString *)title
                  normolColor:(nullable UIColor *)normolColor
               highLightColor:(nullable UIColor *)highLightColor
                    imageName:(nullable NSString *)imageName
           highLightImageName:(nullable NSString *)highLightImageName
                  imageBundle:(nullable NSBundle *)bundle
                       target:(id)target
                       action:(SEL)action;

/**
 设置按钮，只有文字的情况下，区分正常和按住的情况
 @param title 标题
 @param normolColor 正常情况下文字的颜色
 @param highLightColor 按住时文字的颜色
 @param target 在那个位置使用
 @param action 实现的点击方法
 @return 返回一个UIBarButtonItem
 */

+ (instancetype)itemWithTitle:(nullable NSString *)title normolColor:(nullable UIColor *)normolColor highLightColor:(nullable UIColor *)highLightColor target:(id)target action:(SEL)action;

/**
设置按钮，只有文字的情况下，只有正常的文字
@param title 标题
@param normolColor 正常情况下文字的颜色
@param target 在那个位置使用
@param action 实现的点击方法
@return 返回一个UIBarButtonItem
*/
+ (instancetype)itemWithTitle:(nullable NSString *)title
                  normolColor:(nullable UIColor *)normolColor
                       target:(id)target
                       action:(SEL)action;


/**
设置按钮，只有图片的情况下，只有正常的图片
@param imageName 图片名称
@param bundle 图片所在的项目，可以随便填写当前的控制器
@param target 在那个位置使用
@param action 实现的点击方法
@return 返回一个UIBarButtonItem
*/
+ (instancetype)itemWithImageName:(nullable NSString *)imageName
                      imageBundle:(nullable NSBundle *)bundle
                           target:(id)target
                           action:(SEL)action;


/**
设置按钮，只有图片的情况下，正常和按住时的图片
@param imageName 图片名称
@param highLightImageName 图片名称
@param bundle 图片所在的项目，可以随便填写当前的控制器
@param target 在那个位置使用
@param action 实现的点击方法
@return 返回一个UIBarButtonItem
*/
+ (instancetype)itemWithImageName:(nullable NSString *)imageName highLightImageName:(nullable NSString *)highLightImageName imageBundle:(nullable NSBundle *)bundle target:(id)target action:(SEL)action;

/**
设置按钮，只有文字，使用默认的文字颜色
@param title 标题
@param target 在那个位置使用
@param action 实现的点击方法
@return 返回一个UIBarButtonItem
*/
+ (instancetype)itemWithTitle:(NSString *)title target:(id)target action:(SEL)action;

/**
设置按钮，只有图片
@param image 图片
@param target 在那个位置使用
@param action 实现的点击方法
@return 返回一个UIBarButtonItem
*/
+ (instancetype)itemWithImage:(UIImage *)image target:(id)target action:(SEL)action;

/**
设置返回按钮，只有图片
@param image 图片
@param target 在那个位置使用
@param action 实现的点击方法
@return 返回一个UIBarButtonItem
*/
+ (instancetype)backItemWithImage:(UIImage *)image target:(id)target action:(SEL)action;

@end

NS_ASSUME_NONNULL_END
