//
//  NewDialJsonFunctionCoordinateLibModel.m
//  IDOBlue
//
//  Created by cyf on 2025/2/25.
//  Copyright © 2025 hedongyang. All rights reserved.
//

#import "NewDialJsonFunctionCoordinateLibModel.h"
#import "NewDialJsonFunctionItemLibModel.h"
#import "YYModel.h"

@implementation NewDialJsonFunctionCoordinateLibModel

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{
        @"item": [NewDialJsonFunctionItemLibModel class],
    };
}

@end
