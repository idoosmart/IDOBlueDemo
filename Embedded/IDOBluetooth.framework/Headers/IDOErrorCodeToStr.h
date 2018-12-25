//
//  IDOErrorCodeToStr.h
//  VeryfitSDK
//
//  Created by hedongyang on 2018/8/30.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDOErrorCodeToStr : NSObject

/**
 错误码转字符串

 @param errorCode 错误码
 @return 字符串
 */
+ (NSString *)errorCodeToStr:(NSInteger)errorCode;
@end
