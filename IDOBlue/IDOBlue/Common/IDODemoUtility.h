//
//  IDODemoUtility.h
//  IDOBluetoothDemo
//
//  Created by hedongyang on 2018/8/31.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define lang(key) [IDODemoUtility langWithKey:key]

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

/**
 时间字符串转时间戳
 
 @param timeStr 时间字符串
 @return 时间戳
 */
+ (NSString *)timeStampFromTimeStr:(NSString *)timeStr;

/**
 查询
 
 @param year 年
 @param month 月
 @return 当月的天数
 */
+ (NSInteger)getDaysInMonthWithYear:(NSInteger)year
                              month:(NSInteger)month;

/**
 设置语言
 
 @param key key value
 */
+ (NSString *)langWithKey:(NSString *)key;


/**
 年、月、日 转 time interval since 1970

 @param year 年份
 @param month 月份
 @param day 日期
 @return 1970 time temp
 */
+ (NSString *)get1970timeTempWithYear:(NSInteger)year
                             andMonth:(NSInteger)month
                               andDay:(NSInteger)day;

/**
 根据时区获取距离零时区时长
 */
+ (NSInteger)getZeroTimeWithZone:(NSString *)timeZoneName;

@end
