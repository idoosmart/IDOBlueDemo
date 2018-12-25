//
//  IDODemoUtility.m
//  IDOBluetoothDemo
//
//  Created by hedongyang on 2018/8/31.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "IDODemoUtility.h"

@implementation IDODemoUtility
+ (CGFloat)getLabelWidth:(NSString*)text
                  height:(CGFloat)height
                    font:(UIFont*)font
{
    if(!text || text.length == 0)return 0;
    CGRect tempRect=[text boundingRectWithSize:CGSizeMake(MAXFLOAT,height)
                                       options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                    attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]
                                       context:nil];
    return  tempRect.size.width;
}

+ (CGFloat)getLabelheight:(NSString*)text
                    width:(CGFloat)width
                     font:(UIFont*)font
{
    if(!text || text.length == 0)return 0;
    CGRect tempRect=[text boundingRectWithSize:CGSizeMake(width,MAXFLOAT)
                                       options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                    attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]
                                       context:nil];
    return  tempRect.size.height;
}

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIColor *)colorWithHexString:(NSString *)color
{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:1.0];
}

+ (UIViewController *)getCurrentVC
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    return currentVC;
}

+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    if ([rootVC presentedViewController]) {
        rootVC = [rootVC presentedViewController];
    }
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    } else {
        currentVC = rootVC;
    }
    return currentVC;
}

+ (NSString *)blankStyleStringFromHumpStyleString:(NSString *)originString {
    NSArray * separatedArray =  [originString componentsSeparatedByCharactersInSet:[NSCharacterSet uppercaseLetterCharacterSet]];
    NSMutableString * processedString = [[NSMutableString alloc]init];
    NSInteger loc = 0;
    for (NSInteger i = 0; i < separatedArray.count - 1; i ++) {
        NSString *item = [separatedArray objectAtIndex:i];
        [processedString appendString:item];
        NSString *upperCaseString = [originString substringWithRange:NSMakeRange(item.length + loc, 1)];
        [processedString appendFormat:@" %@",upperCaseString.lowercaseString];
        loc += item.length;
        loc += 1;
    }
    if (separatedArray.count > 0) {
        [processedString appendString:separatedArray.lastObject];
    }
    return processedString;
}

+ (NSDateFormatter *)obtainDateFormatter
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [formatter setLocale:locale];
    return formatter;
}

+ (NSString *)timeStrFromTimeStamp:(NSString *)timeStamp
{
    NSDateFormatter *formatter = [self obtainDateFormatter];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:[timeStamp integerValue]];
    return [formatter stringFromDate:date];
}

@end