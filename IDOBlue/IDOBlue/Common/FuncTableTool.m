//
//  FuncTableTool.m
//  SDKDemo
//
//  Created by hedongyang on 2018/8/2.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "FuncTableTool.h"

@implementation FuncTableTool
+ (NSArray <NSArray *>*)arrayFromDic:(NSDictionary *)dic
{
    NSMutableArray * array = [NSMutableArray array];
    NSDictionary * langDic1 = [dic valueForKey:@"langModel"];
    NSDictionary * langDic2 = [dic valueForKey:@"langExtendModel"];
    NSMutableDictionary * langDic = [NSMutableDictionary dictionary];
    [langDic addEntriesFromDictionary:langDic1];
    [langDic addEntriesFromDictionary:langDic2];
    NSArray * langArray = [self arrayFromSubDic:langDic];
    [array addObject:langArray];
    
    NSDictionary * mainFuncDic1 = [dic valueForKey:@"mainFuncModel"];
    NSDictionary * mainFuncDic2 = [dic valueForKey:@"mainFunc1Model"];
    NSDictionary * mainFuncDic3 = [dic valueForKey:@"funcExtendModel"];
    NSMutableDictionary * mainFuncDic = [NSMutableDictionary dictionary];
    [mainFuncDic addEntriesFromDictionary:mainFuncDic1];
    [mainFuncDic addEntriesFromDictionary:mainFuncDic2];
    [mainFuncDic addEntriesFromDictionary:mainFuncDic3];
    NSArray * mainFuncArray = [self arrayFromSubDic:mainFuncDic];
    [array addObject:mainFuncArray];
    
    NSDictionary * otherDic1 = [dic valueForKey:@"otherFuncModel"];
    NSDictionary * otherDic2 = [dic valueForKey:@"smsTableModel"];
    NSDictionary * otherDic3 = [dic valueForKey:@"otherFuncExtendModel"];
    NSMutableDictionary * otherDic = [NSMutableDictionary dictionary];
    [otherDic addEntriesFromDictionary:otherDic1];
    [otherDic addEntriesFromDictionary:otherDic2];
    [otherDic addEntriesFromDictionary:otherDic3];
    NSArray * otherArray = [self arrayFromSubDic:otherDic];
    [array addObject:otherArray];
    
    NSDictionary * alarmDic = [dic valueForKey:@"alarmModel"];
    NSArray * alarmArray = [self arrayFromSubDic:alarmDic];
    [array addObject:alarmArray];
    
    NSDictionary * notifyDic1 = [dic valueForKey:@"tableCallModel"];
    NSDictionary * notifyDic2 = [dic valueForKey:@"notify0Model"];
    NSDictionary * notifyDic3 = [dic valueForKey:@"notify1Model"];
    NSDictionary * notifyDic4 = [dic valueForKey:@"notify2Model"];
    NSMutableDictionary * notifyDic = [NSMutableDictionary dictionary];
    [notifyDic addEntriesFromDictionary:notifyDic1];
    [notifyDic addEntriesFromDictionary:notifyDic2];
    [notifyDic addEntriesFromDictionary:notifyDic3];
    [notifyDic addEntriesFromDictionary:notifyDic4];
    NSArray * notifyArray = [self arrayFromSubDic:notifyDic];
    [array addObject:notifyArray];
    
    NSDictionary * sportTypeDic1 = [dic valueForKey:@"sportType0Model"];
    NSDictionary * sportTypeDic2 = [dic valueForKey:@"sportType1Model"];
    NSDictionary * sportTypeDic3 = [dic valueForKey:@"sportType2Model"];
    NSDictionary * sportTypeDic4 = [dic valueForKey:@"sportType3Model"];
    NSMutableDictionary * sportTypeDic = [NSMutableDictionary dictionary];
    [sportTypeDic addEntriesFromDictionary:sportTypeDic1];
    [sportTypeDic addEntriesFromDictionary:sportTypeDic2];
    [sportTypeDic addEntriesFromDictionary:sportTypeDic3];
    [sportTypeDic addEntriesFromDictionary:sportTypeDic4];
    NSArray * sportTypeArray = [self arrayFromSubDic:sportTypeDic];
    [array addObject:sportTypeArray];
    
    return array;
}

+ (NSArray <NSDictionary *>*)arrayFromSubDic:(NSDictionary *)dic
{
    NSMutableArray * array = [NSMutableArray array];
    if (!dic || ![dic isKindOfClass:[NSDictionary class]]) return array;
    NSArray * allKeys = [dic allKeys];
    NSArray * allVaules = [dic allValues];
    for (int i = 0; i < allKeys.count; i++) {
        NSString * key = [allKeys objectAtIndex:i];
        id value = [allVaules objectAtIndex:i];
        if (!value || !key) continue;
        NSDictionary * dic = [NSDictionary dictionaryWithObject:value forKey:key];
        [array addObject:dic];
    }
    NSArray * resultArray = [array sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSNumber *number1 = [[obj1 allValues]firstObject];
        NSNumber *number2 = [[obj2 allValues]firstObject];
        NSComparisonResult result = [number1 compare:number2];
        //            return result == NSOrderedDescending; // 升序
        return result == NSOrderedAscending;  // 降序
    }];
    return resultArray;
}

@end
