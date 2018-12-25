//
//  BaseText.m
//  IDOBlue
//
//  Created by apple on 2018/10/12.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "BaseText.h"

@interface BaseText()

@end

@implementation BaseText

- (void)drawText
{
    CATextLayer * textLayer = [[CATextLayer alloc]init];
    textLayer.string = self.titleStr;
    UIFont * font = [UIFont systemFontOfSize:self.fontSize];
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    textLayer.font = fontRef;
    textLayer.fontSize = font.pointSize;
    textLayer.frame = self.bounds;
    [textLayer setAlignmentMode:kCAAlignmentCenter];
    [textLayer setForegroundColor:[[UIColor colorWithRed:142/255.0f green:91/255.0f blue:45/255.0f alpha:1.0]CGColor]];
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    [self.layer addSublayer:textLayer];
}

@end
