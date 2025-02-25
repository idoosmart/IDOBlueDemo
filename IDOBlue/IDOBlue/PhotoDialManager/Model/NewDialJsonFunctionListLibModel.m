//
//  IDONewDialJsonFunctionListLibModel.m
//  IDOBlue
//
//  Created by cyf on 2025/2/24.
//  Copyright © 2025 hedongyang. All rights reserved.
//

#import "NewDialJsonFunctionListLibModel.h"
#import "NewDialJsonFunctionListItemLibModel.h"
#import "YYModel.h"

@implementation NewDialJsonFunctionListLibModel: NSObject

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{
        @"item": [NewDialJsonFunctionListItemLibModel class],
    };
}

@end
