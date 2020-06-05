//
//  UILabel+Style.h
//  IDOUIkit
//
//  Created by xiongze on 2018/8/28.
//  Copyright © 2018年 hedongyang. All rights reserved.
//  项目label类型富文本扩展

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UILabel (Style)

- (NSMutableAttributedString *)setWhiteColorfirstString:(NSString *)firstString secondString:(NSString *)secondString thirdString:(NSString *)thirdString fourString:(NSString *)fourString;

- (NSMutableAttributedString *)setWhiteColorfirstString:(NSString *)firstString secondString:(NSString *)secondString;

//主页运动数据
-(NSMutableAttributedString *)setDifferentColorfirstString:(NSString *)firstString secondString:(NSString *)secondString;

//主页睡眠和心率数据
-(NSMutableAttributedString *)setDifferentColorfirstString:(NSString *)firstString secondString:(NSString *)secondString thirdString:(NSString *)thirdString fourString:(NSString *)fourString;

-(NSMutableAttributedString *)setStepWhiteColorfirstString:(NSString *)firstString secondString:(NSString *)secondString;

-(NSMutableAttributedString *)setChatWhiteColorfirstString:(NSString *)firstString secondString:(NSString *)secondString thirdString:(NSString *)thirdString fourString:(NSString *)fourString;


/**
 轨迹运动-目标设置 前黑后灰label
 
 @param blackString 黑色部分文字
 @param grayString 灰色部分文字
 @return 返回富文本
 */
-(NSMutableAttributedString *)setBlackString:(NSString *)blackString GrayString:(NSString *)grayString;

/**
 血压校准页面 Label样式

 @param orangeString 血压值
 @param grayString /
 @param blueString mmHg
 @return 返回富文本
 */
-(NSMutableAttributedString *)setOrangeString:(NSString *)orangeString GrayString:(NSString *)grayString BlueString:(NSString *)blueString;


/**
 指定文本、高度、字体，返回Label宽度

 @param text 指定文本
 @param height 指定高度
 @param font 指定字体
 @return 返回Label宽度
 */
+ (CGFloat)getLabelWidth:(NSString*)text
                  height:(CGFloat)height
                    font:(UIFont*)font;

/**
 指定文本、宽度、字体，返回Label高度

 @param text 指定文本
 @param width 指定宽度
 @param font 指定字体
 @return 返回Label高度
 */
+ (CGFloat)getLabelheight:(NSString*)text
                    width:(CGFloat)width
                     font:(UIFont*)font;

/**
 富文本转换方法
 
 @param strArray 字符数组
 @param fontArray 字体大小数组
 @param colorArray 字体颜色数组
 @return 返回富文本
 */
+ (NSMutableAttributedString*) getAttributedStrings:(NSArray *) strArray
                                              fonts:(NSArray *) fontArray
                                             colors:(NSArray *) colorArray;

@end
