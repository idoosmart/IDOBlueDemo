//
//  NewDialJsonFuncListLibModel.m
//  IDOBlue
//
//  Created by cyf on 2025/2/24.
//  Copyright © 2025 hedongyang. All rights reserved.
//

#import "NewDialJsonFuncListLibModel.h"
#import "NewDialJsonFuncListItemLibModel.h"
#import "YYModel.h"

@implementation NewDialJsonFuncListLibModel


+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{
        @"items": [NewDialJsonFuncListItemLibModel class],
    };
}


+ (NSArray <NewDialJsonFuncListLibModel *>*)getWallperDialDefaultsFuncs{
    NSMutableArray *list = [NSMutableArray array];
    
    //健康
    NewDialJsonFuncListLibModel *healthObj = [[NewDialJsonFuncListLibModel alloc] init];
    healthObj.type = @"health";
    [list addObject:healthObj];
    
    NewDialJsonFuncListItemLibModel *heartItemObj = [[NewDialJsonFuncListItemLibModel alloc] init];
    heartItemObj.type = @"heartrate";
    heartItemObj.icon = @"icon_dail_heartrate";
    heartItemObj.widgetType = 5;
    
    NewDialJsonFuncListItemLibModel *kcalObj = [[NewDialJsonFuncListItemLibModel alloc] init];
    kcalObj.type = @"calorie";
    kcalObj.icon = @"icon_dail_kcal";
    kcalObj.widgetType = 4;

    healthObj.items = @[heartItemObj, kcalObj];
    
    //运动
    NewDialJsonFuncListLibModel *sportObj = [[NewDialJsonFuncListLibModel alloc] init];
    sportObj.type = @"sport";
    [list addObject:sportObj];
    
    NewDialJsonFuncListItemLibModel *stepItemObj = [[NewDialJsonFuncListItemLibModel alloc] init];
    stepItemObj.type = @"step";
    stepItemObj.icon = @"icon_dail_step";
    stepItemObj.widgetType = 2;
    
    NewDialJsonFuncListItemLibModel *distanceObj = [[NewDialJsonFuncListItemLibModel alloc] init];
    distanceObj.type = @"distance";
    distanceObj.icon = @"icon_dail_distance";
    distanceObj.widgetType = 3;

    sportObj.items = @[stepItemObj, distanceObj];
    
    //工具
    NewDialJsonFuncListLibModel *toolsObj = [[NewDialJsonFuncListLibModel alloc] init];
    toolsObj.type = @"tools";
    [list addObject:toolsObj];
    
    NewDialJsonFuncListItemLibModel *date_weekItemObj = [[NewDialJsonFuncListItemLibModel alloc] init];
    date_weekItemObj.type = @"date";
    date_weekItemObj.icon = @"icon_dail_date_week";
    date_weekItemObj.widgetType = 1;
    
    NewDialJsonFuncListItemLibModel *batteryObj = [[NewDialJsonFuncListItemLibModel alloc] init];
    batteryObj.type = @"battery";
    batteryObj.icon = @"icon_dail_battery";
    batteryObj.widgetType = 6;

    toolsObj.items = @[date_weekItemObj, batteryObj];
    
    
    return list;
}

- (NSString *)getTypeName{
    static NSDictionary *kDialFuncTitleDict = nil;
    if (!kDialFuncTitleDict) {
        kDialFuncTitleDict = @{
            @"kDefaultCloseFuncKey":  @"Functions on the watch face",
            @"healthtitle": @"Health",
            @"health": @"Health",
            @"sport": @"Exercise",
            @"dial_function_voice": @"Voice",
            @"communication": @"Phone contacts",
            @"tools": @"Tools",
            @"sounds": @"Voice",
        };
    }
    return [kDialFuncTitleDict valueForKey:_type];
}

@end
