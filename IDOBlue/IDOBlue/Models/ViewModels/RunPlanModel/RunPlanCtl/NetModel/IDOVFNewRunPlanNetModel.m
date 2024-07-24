//
//  IDOVFNewRunPlanNetModel.m
//  AFNetworking
//
//  Created by mac2019 on 2022/5/27.
//

#import "IDOVFNewRunPlanNetModel.h"

@implementation IDOVFNewRunPlanNetModel

+ (IDOVFNewBaseNetModel *)getDefaultModel:(NSString *)token{
    IDOVFNewBaseNetModel *model = [super getDefaultModel:token];
    model.mainUrl = @"https://cn-running-api.idoocloud.com";
    return model;
}

+ (IDOVFNewRunPlanNetModel *)getRunPlan:(NSString *)token{
    IDOVFNewRunPlanNetModel *model = (IDOVFNewRunPlanNetModel *)[self getDefaultModel:token];
    model.subUrl = @"api/running/plan/getByUser";
    return model;
}

+ (IDOVFNewRunPlanNetModel *)getDetailRunPlan:(NSString *)token{
    IDOVFNewRunPlanNetModel *model = (IDOVFNewRunPlanNetModel *)[self getDefaultModel:token];
    model.subUrl = @"api/running/train/batchUpload";
    return model;
}

+ (IDOVFNewRunPlanNetModel *)getPlanNotice:(NSString *)token{
    IDOVFNewRunPlanNetModel *model = (IDOVFNewRunPlanNetModel *)[self getDefaultModel:token];
    model.subUrl = @"api/running/train/checkNow";
    return model;
}

+ (IDOVFNewRunPlanNetModel *)sendCloseNotice:(NSString *)token{
    IDOVFNewRunPlanNetModel *model = (IDOVFNewRunPlanNetModel *)[self getDefaultModel:token];
    model.subUrl = @"api/running/plan/updateReadStatus";
    return model;
}

+ (IDOVFNewRunPlanNetModel *)getDetailPlanExecutingIssued:(NSString *)token{
    IDOVFNewRunPlanNetModel *model = (IDOVFNewRunPlanNetModel *)[self getDefaultModel:token];
    model.subUrl = @"api/running/plan/queryExecutingIssued";
    return model;
}

+ (void)loadRunPlanNotiInfoWith:(NSString *)token Block:(void (^)(BOOL isExistReport, NSInteger reportType, BOOL isTrainDay, NSInteger runType))compeleter{
    [IDOVFNewRunPlanNetModel postFormatWithModel:[self getPlanNotice:token] success:^(id  _Nullable responseObject) {
        NSInteger status = [responseObject[@"status"] integerValue];
        if (status == 200) {
            NSDictionary *result = responseObject[@"result"];
            if (![result isKindOfClass:[NSDictionary class]]) {
                if (compeleter) {
                    compeleter(NO,0,NO,0);
                }
                return;
            }
            
            NSDictionary *reportData = result[@"reportData"];
            NSDictionary *trainData = result[@"trainData"];
            
            BOOL isExistReport = [reportData[@"reportData"] boolValue];
            BOOL isTrainDay = [trainData[@"isTrainDay"] boolValue];
            
            BOOL reportType = [reportData[@"type"] integerValue];
            BOOL runType = [trainData[@"type"] integerValue];
            
            if (compeleter) {
                compeleter(isExistReport,reportType,isTrainDay,runType);
            }
        }else{
            if (compeleter) {
                compeleter(NO,0,NO,0);
            }
        }
    } fail:^(NSError * _Nullable error) {
        if (compeleter) {
            compeleter(NO,0,NO,0);
        }
    }];
}

+ (void)sendHavedReadedRunReport:(NSString *)token{
    [IDOVFNewRunPlanNetModel postFormatWithModel:[self sendCloseNotice:token] success:^(id  _Nullable responseObject) {
        NSLog(@"发送已读运动报告成功");
    } fail:^(NSError * _Nullable error) {
        NSLog(@"发送已读运动报告失败");
    }];
}

+ (void)updatePlanToken:(NSString *)token Datas:(NSArray <NSDictionary *>*)datas block:(nonnull void (^)(BOOL result))compeleter{
    if (datas.count == 0) {
        if (compeleter) {
            compeleter(NO);
        }
        return;
    }
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:datas forKey:@"datas"];
    
    IDOVFNewRunPlanNetModel *model = (IDOVFNewRunPlanNetModel *)[self getDetailRunPlan:token];
    model.param = param;
    NSLog(@"上传跑步计划开始:%@",param);
    [IDOVFNewRunPlanNetModel postWithModel:model success:^(id  _Nullable responseObject) {
        NSLog(@"上传跑步计划结果返回:%@",responseObject);
        if (compeleter) {
            compeleter(YES);
        }
    } fail:^(NSError * _Nullable error) {
        NSLog(@"上传跑步计划失败:%@",error);
        if (compeleter) {
            compeleter(NO);
        }
    }];
}

+ (NSDictionary *)runPlanDicWithSportModel:(IDOCoreSportRecordModel *)sportModel planId:(NSInteger)planId{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    
    NSArray *actItems = [self transToObject:sportModel.runningPullUp];
    if (![actItems isKindOfClass:[NSArray class]]) {
        return dic;
    }
    
    NSMutableArray *items = [NSMutableArray array];
    for (NSString *itemStr in actItems) {
        NSDictionary *sDic = nil;
        if ([itemStr isKindOfClass:[NSDictionary class]]) {
            sDic = (NSDictionary *)itemStr;
        }else{
            if ([itemStr isKindOfClass:[NSString class]]) {
                sDic = [self transToObject:itemStr];
            }
        }
        
        NSMutableDictionary *nDic = [NSMutableDictionary dictionary];
        [nDic setValue:sDic[@"actual_time"] forKey:@"actualTime"];
        [nDic setValue:sDic[@"heart_value"] forKey:@"heartRate"];
        [nDic setValue:sDic[@"type"] forKey:@"type"];
        [nDic setValue:sDic[@"goal_time"] forKey:@"targetTime"];
        [items addObject:nDic];
    }
    
    [dic setValue:@(sportModel.numCalories) forKey:@"calories"];
    [dic setValue:@(sportModel.distance) forKey:@"distance"];
    [dic setValue:@(sportModel.totalSeconds) forKey:@"durations"];
    [dic setValue:@(planId) forKey:@"planId"];
    [dic setValue:@(sportModel.numSteps) forKey:@"step"];
    [dic setValue:sportModel.startTime forKey:@"trainTime"];
    [dic setValue:@(sportModel.hrCompletionRate) forKey:@"heartConRate"];
    [dic setValue:@(sportModel.completionRate) forKey:@"completeRate"];
    
    [dic setValue:items forKey:@"runningDetail"];
    return dic;
    
}
+ (id)transToObject:(NSString *)jsonStr {
    if (jsonStr.length <= 0) {
        NSLog(@"[NSString transToObject:] string is nil");
        return nil;
    }
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    id object = [NSJSONSerialization JSONObjectWithData:jsonData
                                             options:NSJSONReadingMutableContainers
                                               error:&error];
    if(error) {
        NSLog(@"[NSString transToObject:] Got an error: %@", error);
        return nil;
    }
    return object;

}

@end
