//
//  NSArray+RemoveDuplicate.m
//  SDKDemo
//
//  Created by apple on 2018/6/17.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "NSArray+RemoveDuplicate.h"

@implementation NSArray (RemoveDuplicate)
- (NSArray *)arrayRemoveDuplicate
{
    return [self valueForKeyPath:@"@distinctUnionOfObjects.self"];
}
@end
