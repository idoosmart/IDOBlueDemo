//
//  NewDialJsonFuncListItemLibModel.m
//  IDOBlue
//
//  Created by cyf on 2025/2/24.
//  Copyright © 2025 hedongyang. All rights reserved.
//

#import "NewDialJsonFuncListItemLibModel.h"

//健康：健身、心率、卡路里、睡眠、压力、血氧、呼吸、环境音量、经期跟踪、体温
//运动：运动、步数、距离
//语音：amazon alexa
//通讯：电话、常用联系人、快捷拨号
//工具：天气、音乐、闹钟、秒表、计时器、事项提醒、手电筒、拍照、星期/日期、电量

@implementation NewDialJsonFuncListItemLibModel

+ (NSString *)getWidgetImageNameFromFuncListItem:(NSInteger)widgetType{
//    1:星期/日期 2:步数 3:距离 4:卡路里 5:心率 6:电量
    switch (widgetType) {
        case 1: return @"icon_dail_date_week";
        case 2: return @"icon_dail_step_unit";
        case 3: return @"icon_dail_distance";
        case 4: return @"icon_dail_kcal";
        case 5: return @"icon_dail_heartrate";
        case 6: return @"icon_dail_battery";
    }
    return @"";
}

+ (NSString *)convertWidgetTypeToFuncListItem:(NSInteger)widgetType{
//    1:星期/日期 2:步数 3:距离 4:卡路里 5:心率 6:电量
    switch (widgetType) {
        case 1: return @"date";
        case 2: return @"step";
        case 3: return @"distance";
        case 4: return @"calorie";
        case 5: return @"heartrate";
        case 6: return @"battery";
    }
    return @"";
}

+ (NSInteger)convertToWidgetTypeFromTypeName:(NSString *)typeName{
//    1:星期/日期 2:步数 3:距离 4:卡路里 5:心率 6:电量
    if ([typeName isEqualToString:@"date"]) {
        return 1;
    }
    
    if ([typeName isEqualToString:@"step"]) {
        return 2;
    }
    
    if ([typeName isEqualToString:@"distance"]) {
        return 3;
    }
    
    if ([typeName isEqualToString:@"calorie"]) {
        return 4;
    }
    
    if ([typeName isEqualToString:@"heartrate"]) {
        return 5;
    }
    
    if ([typeName isEqualToString:@"battery"]) {
        return 6;
    }
    return 0;
}

+ (nullable NSArray<NSString *> *)modelPropertyBlacklist{
    return @[@"widgetType"];
}


+ (NSString *)getTypeNameWithType:(NSString *)typeName{
    static NSDictionary *kDialFunctemTitleDict = nil;
    if (!kDialFunctemTitleDict) {
        kDialFunctemTitleDict = @{
            @"kDefaultCloseFuncItemKey": @"Turn off display",
            //健康(10)：健身、心率、卡路里、睡眠、压力、血氧、呼吸、环境音量、经期跟踪、体温
            @"health": @"Fitness",//健身--对应活动，三环
            @"heartrate": @"Heart rate",
            @"calorie": @"Calories",
            @"sleep": @"Sleep",
            @"stress": @"Stress",
            @"oxygen": @"SpO2",
            @"breathe": @"Breathe",
            @"noise": @"Ambient sound level",//固件定义：噪声
            @"liv": @"Period tracking",
            @"LIV": @"Period tracking",
            @"temperature": @"Skin temperature",
            @"temperture": @"Skin temperature",//@"皮肤温度"

            //运动(3)：运动、步数、距离
            @"sport": @"Exercise",
            @"step": @"Steps",
            @"distance": @"Distance",
            
            //语音(1)：amazon alexa
            @"alexa": @"Alexa",
            
            //通讯(3)：电话、常用联系人、快捷拨号
            @"call_list": @"Calls",
            @"bt_call": @"Speed dial",
            @"contacts": @"Frequent contacts",
            @"speed_dial": @"Speed dial",
            @"call_logs": @"Call history",

            //工具(10)：天气、音乐、闹钟、秒表、计时器、事项提醒、手电筒、拍照、星期/日期、电量
            @"weather": @"Weather",
            @"music": @"Music",
            @"clock": @"Alarm Clock",
            @"chronograph": @"Stopwatch",
            @"timer": @"Timer",
            @"schedule": @"Event reminder",//固件的定义：日程
            @"light": @"Flashlight",
            @"camera": @"Take a photo",
            @"date": @"Week/Date",
            @"battery": @"Battery level",

            
            @"kcal_sport_walk": @"Fitness",
            @"date_week": @"Week/Date",
            @"day_week": @"Week/Date",
            @"distance_unit": @"Distance",
            @"hr_unit": @"Heart rate",
            @"step_unit": @"Steps",
            
            //备用 固件定义的一些key
            @"exercise": @"Fitness",//固件的定义：锻炼
            @"UT": @"World clock",
                        
            @"records": @"records",
            @"relxa": @"Rest",
        };
    }
    return [kDialFunctemTitleDict valueForKey:typeName];

}

- (NSString *)getTypeName{
    return [NewDialJsonFuncListItemLibModel getTypeNameWithType:_type];
}

@end
