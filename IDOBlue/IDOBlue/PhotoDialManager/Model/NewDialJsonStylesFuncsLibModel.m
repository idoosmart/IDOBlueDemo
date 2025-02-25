//
//  NewDialJsonStylesFuncsLibModel.m
//  IDOBlue
//
//  Created by cyf on 2025/2/24.
//  Copyright © 2025 hedongyang. All rights reserved.
//

#import "NewDialJsonStylesFuncsLibModel.h"
#import <UIKit/UIKit.h>
#import "YYModel.h"

@implementation NewDialJsonStylesFuncsLibModel

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSArray *location = dic[@"location"];
    if (![location isKindOfClass:[NSArray class]] && location.count == 4) return NO;
    _location = CGRectMake([location[0] floatValue], [location[1] floatValue], [location[2] floatValue], [location[3] floatValue]);
    return YES;
}

- (BOOL)modelCustomTransformToDictionary:(NSMutableDictionary *)dic{
    dic[@"location"] = @[
        [@(_location.origin.x) stringValue],
        [@(_location.origin.y) stringValue],
        [@(_location.size.width) stringValue],
        [@(_location.size.height) stringValue],
    ];
    return YES;
}

@end
