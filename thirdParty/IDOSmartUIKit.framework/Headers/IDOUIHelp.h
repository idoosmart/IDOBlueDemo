//
//  IDOUIHelp.h
//  IDOUIkit
//
//  Created by hedongyang on 2018/7/16.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface IDOUIHelp : NSObject

/**
 十六进制字符串转颜色
 HexStr strings to color
 
 @param color 十六进制字符串
 @return color
 */
+ (UIColor *_Nullable)colorWithHexString:(NSString *_Nonnull)color;


/**
 十六进制字符串转颜色 加透明度

 @param color 十六进制字符串
 @param alpha 透明度
 @return color
 */
+ (UIColor *_Nullable)colorWithHexString:(NSString *_Nonnull)color alpha:(CGFloat)alpha;

/**
 获取当前显示的控制器

 @return UIViewController
 */
+ (UIViewController *_Nullable)currentViewController;

/**
 获取 IDOSmartUIKit.bundle 中的图片
 
 @param imageName 图片的名称
 @param imageFile 图片位于哪个文件夹下，可以为空，为空的情况下就是读取不在文件夹下面的图片
 */
+ (UIImage *_Nullable)imageWithImageName:(NSString *_Nonnull)imageName imageFile:(nullable NSString *)imageFile;

@end
