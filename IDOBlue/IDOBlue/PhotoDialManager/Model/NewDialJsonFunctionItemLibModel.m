//
//  NewDialJsonFunctionItemLibModel.m
//  IDOBlue
//
//  Created by cyf on 2025/2/25.
//  Copyright © 2025 hedongyang. All rights reserved.
//

#import "NewDialJsonFunctionItemLibModel.h"
#import <UIKit/UIKit.h>
#import "YYModel.h"

@implementation NewDialJsonFunctionItemLibModel

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSArray *coordinate = dic[@"coordinate"];
    if (![coordinate isKindOfClass:[NSArray class]] && coordinate.count == 4) return NO;
    _coordinate = CGRectMake([coordinate[0] floatValue], [coordinate[1] floatValue], [coordinate[2] floatValue], [coordinate[3] floatValue]);
    return YES;
}

- (BOOL)modelCustomTransformToDictionary:(NSMutableDictionary *)dic{
    dic[@"coordinate"] = @[
        @(_coordinate.origin.x),
        @(_coordinate.origin.y),
        @(_coordinate.size.width),
        @(_coordinate.size.height),
    ];
    return YES;
}

@end
