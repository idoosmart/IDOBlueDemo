//
//  NewDialJsonLocationLibModel.m
//  IDOBlue
//
//  Created by cyf on 2025/2/25.
//  Copyright © 2025 hedongyang. All rights reserved.
//

#import "NewDialJsonLocationLibModel.h"
#import "NewDialJsonFunctionCoordinateLibModel.h"
#import "DialJsonTimeWidgetLibModel.h"
#import <UIKit/UIKit.h>
#import "YYModel.h"

@implementation NewDialJsonLocationLibModel

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{
        @"function_coordinate": [NewDialJsonFunctionCoordinateLibModel class],
        @"time_widget": [DialJsonTimeWidgetLibModel class],
    };
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSArray *time = dic[@"time"];
    if (![time isKindOfClass:[NSArray class]] && time.count == 4) return NO;
    _time = CGRectMake([time[0] floatValue], [time[1] floatValue], [time[2] floatValue], [time[3] floatValue]);
    
    NSArray *day = dic[@"day"];
    if (![day isKindOfClass:[NSArray class]] && day.count == 4) return NO;
    _day = CGRectMake([day[0] floatValue], [day[1] floatValue], [day[2] floatValue], [day[3] floatValue]);

    
    NSArray *week = dic[@"week"];
    if (![week isKindOfClass:[NSArray class]] && week.count == 4) return NO;
    _week = CGRectMake([week[0] floatValue], [week[1] floatValue], [week[2] floatValue], [week[3] floatValue]);

    
    NSArray *func = dic[@"func"];
    if (![func isKindOfClass:[NSArray class]] && func.count == 4) return NO;
    _func = CGRectMake([func[0] floatValue], [func[1] floatValue], [func[2] floatValue], [func[3] floatValue]);

    return YES;
}

- (BOOL)modelCustomTransformToDictionary:(NSMutableDictionary *)dic{
    dic[@"time"] = @[
        @(_time.origin.x),
        @(_time.origin.y),
        @(_time.size.width),
        @(_time.size.height),
    ];
    dic[@"day"] = @[
        @(_day.origin.x),
        @(_day.origin.y),
        @(_day.size.width),
        @(_day.size.height),
    ];
    dic[@"week"] = @[
        @(_week.origin.x),
        @(_week.origin.y),
        @(_week.size.width),
        @(_week.size.height),
    ];
    dic[@"func"] = @[
        @(_func.origin.x),
        @(_func.origin.y),
        @(_func.size.width),
        @(_func.size.height),
    ];
    return YES;
}

@end
