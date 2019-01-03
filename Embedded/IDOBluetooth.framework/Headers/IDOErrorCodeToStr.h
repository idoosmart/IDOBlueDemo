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
 * @brief 错误码转字符串 | Error code to string
 * @param errorCode 错误码 | Error code
 * @return 字符串 | string
 */
+ (NSString *)errorCodeToStr:(NSInteger)errorCode;
@end
