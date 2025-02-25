//
//  NewDialJsonClockLibModel.m
//  IDOBlue
//
//  Created by cyf on 2025/2/24.
//  Copyright © 2025 hedongyang. All rights reserved.
//

#import "NewDialJsonClockLibModel.h"
#import "YYModel.h"
#import <UIKit/UIKit.h>

@implementation NewDialJsonClockLibModel

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
    
    NSArray *cityLocations = dic[@"cityLocation"];
    if (![cityLocations isKindOfClass:[NSArray class]] && cityLocations.count == 4) return NO;
    _cityLocation = CGRectMake([cityLocations[0] floatValue],
                               [cityLocations[1] floatValue],
                               [cityLocations[2] floatValue],
                               [cityLocations[3] floatValue]);
    
    return YES;
}


- (BOOL)modelCustomTransformToDictionary:(NSMutableDictionary *)dic{
    dic[@"location"] = @[
        [@(_location.origin.x) stringValue],
        [@(_location.origin.y) stringValue],
        [@(_location.size.width) stringValue],
        [@(_location.size.height) stringValue],
    ];
    dic[@"cityLocation"] = @[
        [@(_cityLocation.origin.x) stringValue],
        [@(_cityLocation.origin.y) stringValue],
        [@(_cityLocation.size.width) stringValue],
        [@(_cityLocation.size.height) stringValue],
    ];
    return YES;
}

@end
