//
//  NSObject+objectToJsonStr.m
//  SDKDemo
//
//  Created by hedongyang on 2018/8/9.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "NSObject+ObjectToJsonStr.h"
#import "NSObject+ModelToDic.h"

@implementation NSObject (ObjectToJsonStr)

- (NSString *)jsonStrFromDic
{
    NSDictionary * dic = [self dicFromObject];
    NSString * jsonString = nil;
    NSError * error;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dic
                                                        options:NSJSONWritingPrettyPrinted
                                                          error:&error];
    if (! jsonData) {
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

@end
