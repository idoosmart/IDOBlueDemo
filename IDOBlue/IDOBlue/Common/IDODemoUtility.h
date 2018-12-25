//
//  IDODemoUtility.h
//  IDOBluetoothDemo
//
//  Created by hedongyang on 2018/8/31.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface IDODemoUtility : NSObject
/**
 固定高度和字符大小计算字符串宽度
 
 @param text 字符串
 @param height 字符串高度
 @param font 字体大小
 @return 字符串宽度
 */
+ (CGFloat)getLabelWidth:(NSString*)text
                  height:(CGFloat)height
                    font:(UIFont*)font;

/**
 固定宽度和字符大小计算字符串高度
 
 @param text 字符串
 @param width 字符串宽度
 @param font 字体大小
 @return 字符串高度
 */
+ (CGFloat)getLabelheight:(NSString*)text
                    width:(CGFloat)width
                     font:(UIFont*)font;
/**
 颜色转图片
 
 @param color 颜色
 @return 图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;


/**
 十六进制字符串转换颜色
 
 @param color 十六进制字符串
 @return 颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)color;

/**
 获取当前控制器
 
 @return UIViewController
 */
+ (UIViewController *)getCurrentVC;

/**
 驼峰命名转下空格命名
 
 @param originString 驼峰名字
 @return 空格名字
 */
+ (NSString *)blankStyleStringFromHumpStyleString:(NSString *)originString;

/**
 时间戳转时间字符串
 
 @param timeStamp 时间戳
 @return 时间字符串
 */
+ (NSString *)timeStrFromTimeStamp:(NSString *)timeStamp;
@end
