//
//  NewDialJsonStylesListLibModel.m
//  IDOBlue
//
//  Created by cyf on 2025/2/24.
//  Copyright © 2025 hedongyang. All rights reserved.
//

#import "NewDialJsonStylesListLibModel.h"
#import "NewDialJsonStylesFuncsLibModel.h"
#import "YYModel.h"
#pragma mark - 样式表的对象

@implementation NewDialJsonStylesListLibModel

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{
        @"funcs": [NewDialJsonStylesFuncsLibModel class],
    };
}

@end
