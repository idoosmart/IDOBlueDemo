//
//  NewDialJsonCountTimerLibModel.m
//  IDOBlue
//
//  Created by cyf on 2025/2/25.
//  Copyright © 2025 hedongyang. All rights reserved.
//

#import "NewDialJsonCountTimerLibModel.h"
#import "YYModel.h"
#import <UIKit/UIKit.h>

@implementation NewDialJsonCountTimerLibModel

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSArray *locations = dic[@"location"];
    if (![locations isKindOfClass:[NSArray class]]) {
        return NO;
    }
    if (locations.count != 4) {
        return NO;
    }
    _location = CGRectMake([locations[0] floatValue],
                           [locations[1] floatValue],
                           [locations[2] floatValue],
                           [locations[3] floatValue]);
    
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
