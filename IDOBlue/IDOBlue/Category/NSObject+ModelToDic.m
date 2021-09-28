//
//  NSObject+IDOModelToDic.m
//  VeryfitSDK
//
//  Created by hedongyang on 2018/7/21.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "NSObject+ModelToDic.h"
#import <objc/runtime.h>

@implementation NSObject (ModelToDic)

- (NSDictionary *)dicFromObject{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int count;
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        objc_property_t property = propertyList[i];
        const char *cName = property_getName(property);
        NSString *name = [NSString stringWithUTF8String:cName];
        NSObject *value = [self valueForKey:name];
        if ([value isKindOfClass:[NSString class]]
            || [value isKindOfClass:[NSNumber class]]) {
            [dic setObject:value forKey:name];
        } else if ([value isKindOfClass:[NSArray class]]
                   || [value isKindOfClass:[NSDictionary class]]) {
            [dic setObject:[self arrayOrDicWithObject:value] forKey:name];
            
        } else if (value == nil) {
            [dic setObject:[NSNull null] forKey:name];
        }else {
            if ([value isKindOfClass:[NSNull class]]) {
                [dic setObject:[NSNull null] forKey:name];
            }else {
                [dic setObject:[value dicFromObject] forKey:name];
            }
            
        }
    }
    free(propertyList);
    return [dic copy];
}

- (id)arrayOrDicWithObject:(id)origin {
    if ([origin isKindOfClass:[NSArray class]]) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSObject *object in origin) {
            if ([object isKindOfClass:[NSString class]]
                || [object isKindOfClass:[NSNumber class]]) {
                [array addObject:object];
            } else if ([object isKindOfClass:[NSArray class]]
                       || [object isKindOfClass:[NSDictionary class]]) {
                [array addObject:[self arrayOrDicWithObject:object]];
            } else {
                [array addObject:[object dicFromObject]];
            }
        }
        return [array copy];
    } else if ([origin isKindOfClass:[NSDictionary class]]) {
        NSDictionary *originDic = (NSDictionary *)origin;
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        for (NSString *key in originDic.allKeys) {
            id object = [originDic objectForKey:key];
            if ([object isKindOfClass:[NSString class]]
                || [object isKindOfClass:[NSNumber class]]) {
                [dic setObject:object forKey:key];
            } else if ([object isKindOfClass:[NSArray class]]
                       || [object isKindOfClass:[NSDictionary class]]) {
                [dic setObject:[self arrayOrDicWithObject:object] forKey:key];
            } else {
                [dic setObject:[object dicFromObject] forKey:key];
            }
        }
        return [dic copy];
    }
    return [NSNull null];
}

@end
