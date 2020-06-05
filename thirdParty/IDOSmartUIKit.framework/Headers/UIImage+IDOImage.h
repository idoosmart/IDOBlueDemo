//
//  UIImage+IDOImage.h
//  IDOUIkit
//
//  Created by hedongyang on 2018/7/17.
//  Copyright © 2018年 hedongyang. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface UIImage (IDOImage)

/**
 截取当前image对象rect区域内的图像

 @param rect 截取区域
 @return 图片
 */
- (UIImage *)subImageWithRect:(CGRect)rect;

/**
 压缩图片
 
 2020-02-25 农大浒 新增
 
 @param sourceImage 原图
 @param maxSize 图片允许的最大kB
 
 @return 二进制数据流
 */
+ (NSData *)reSizeImageData:(UIImage *)sourceImage maxSizeWithKB:(CGFloat)maxSize;
@end
