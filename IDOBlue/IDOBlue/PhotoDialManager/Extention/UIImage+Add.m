//
//  UIImage+Add.m
//  IDOBlue
//
//  Created by cyf on 2025/2/24.
//  Copyright © 2025 hedongyang. All rights reserved.
//

#import "UIImage+Add.h"
#import <MobileCoreServices/MobileCoreServices.h>

@implementation UIImage (Add)


//保存为指定大小的图片
- (BOOL)convertPngToBmp:(CGSize)toSize toPath:(NSString *)toPath{
    UIImage * imageCopy = [self scaleToSize:toSize];
    
    NSMutableDictionary *properties = [NSMutableDictionary dictionary];
//    properties[(__bridge NSString *)kCGImageDestinationLossyCompressionQuality] = @(0.1);
    
    NSData *data = [self convertData:imageCopy options:properties type:kUTTypeBMP];
    
    return [data writeToFile:toPath atomically:YES];
}

//修改图片为指定的大小
- (UIImage *)scaleToSize:(CGSize)size{
    if (self.size.width == size.width && self.size.height == size.height) {
        return self;
    }
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

//转换BMP为Data类型
- (NSData *)convertData:(UIImage *)bmpImg options:(NSDictionary *)options type:(CFStringRef)type{
    CGImageRef cgImage = bmpImg.CGImage;
    
    NSMutableData *mutableData = [NSMutableData data];
    NSMutableData *imageData = [NSMutableData data];

    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)imageData, NULL);
    CGImageDestinationRef destination = CGImageDestinationCreateWithData(
        (__bridge CFMutableDataRef)mutableData, type, 1, nil);
    CGImageDestinationAddImage(destination, cgImage, (__bridge CFDictionaryRef)options);
    CGImageDestinationFinalize(destination);
    CFRelease(source);
    CFRelease(destination);
    return mutableData;
}
@end
