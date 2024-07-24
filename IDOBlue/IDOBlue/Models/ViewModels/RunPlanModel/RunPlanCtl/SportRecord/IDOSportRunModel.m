//
//  IDOSportRunModel.m
//  AFNetworking
//
//  Created by mac2019 on 2022/5/24.
//

#import "IDOSportRunModel.h"
#import "IDOSportTypeModel.h"
#import "YYModel.h"
@implementation IDOSportRunModel


+ (NSDate *)getRecoverTime:(NSInteger)recoverTime
{
//    NSString *dateStr = [NSDate currentTimeStamp];
//    
//    NSInteger addTime = recoverTime * 60 * 60;
//    
//    long long newTime = dateStr.longLongValue + addTime;
    
    return [NSDate date];//[NSDate dateWithTimeIntervalSince1970:newTime];
}

/**< 运动结束 数据小节转业务数据 存业务数据库 */
+ (IDOCoreSportRecordModel *)exchangeToResource:(IDODataExchangeModel *)exchageModel
                                     timestamp:(NSInteger)timestamp
                                        target:(IDOSportSettingModel *)targetModel
                                      hrValues:(NSArray  *)hrValues
                                     sourceType:(IDOSportSourceType)sourceType
                                     railArray:(NSArray <IDOSRailModel *>*)railArray
                                   kmPaceArray:(NSMutableArray *)kmPaceArray
                                 milePaceArray:(NSMutableArray *)milePaceArray
                                    stepsArray:(NSMutableArray *)stepsArray
                                         userId:(NSString *)userId{
    IDOCoreSportRecordModel *record = [IDOCoreSportRecordModel new];
    record.userId = userId;
    record.dateTimestamp = timestamp;
    record.timestamp = timestamp *1000;
    record.isUpload = NO;
//    record.date = [NSDate br_getDateString:[NSDate dateWithTimeIntervalSince1970:timestamp] format:@"yyyy-MM-dd"];
    record.sourceMac = exchageModel.macAddr;
    record.deviceName = exchageModel.deviceName;
    record.sourceOs = 1;
//    record.datetime = [NSDate br_getDateString:[NSDate dateWithTimeIntervalSince1970:timestamp] format:@"yyyy-MM-dd HH:mm:ss"];
    record.type = exchageModel.sportType;
    record.totalSeconds = exchageModel.durations;
    record.numCalories = exchageModel.calories;
    record.numSteps = exchageModel.step;
    record.distance = exchageModel.distance;
    record.startTime = record.datetime;
//    record.endTime = [NSDate br_getDateString:[NSDate dateWithTimeIntervalSince1970:timestamp + exchageModel.durations] format:@"yyyy-MM-dd HH:mm:ss"];
    record.targetType = targetModel.targetType;
    record.targetValue = targetModel.sportTarget.integerValue;
    record.warmupSeconds = exchageModel.warmUpSecond;
    record.burnFatSeconds = exchageModel.fatBurnSecond;
    record.aerobicSeconds = exchageModel.aerobicSecond;
    record.anaerobicSeconds = exchageModel.anaeroicSecond;
    record.extremeSeconds = exchageModel.limitSecond;
    record.maxHrValue = exchageModel.maxHrValue;
    record.avgHrValue = exchageModel.avgHrValue;
    record.sourceType = sourceType;
    record.maxSpeed = exchageModel.maxSpeed;
    record.avgSpeed = exchageModel.avgSpeed;
    record.avgRate = exchageModel.avgStepFrequency;
    record.maxRate = exchageModel.maxStepFrequency;
    record.stepRange = exchageModel.avgStepStride;
    record.minPace = exchageModel.fastKmSpeed;
    record.isSupportTrainingEffect = __IDO_FUNCTABLE__.funcTable38Model.syncV3ActivityAddParam;
    //新增指标
    record.avg3dSpeed = exchageModel.avg3dSpeed;
    record.distance3d = exchageModel.distance3d;
    record.avgVerticalSpeed = exchageModel.avgVerticalSpeed;
    record.avgSlope = exchageModel.avgSlope;
    record.highestAltitude = exchageModel.maxAltitude;
    record.lowestAltitude = exchageModel.minAltitude;
    record.cumulativeClimb = exchageModel.cumulativeAltitudeRise;
    record.cumulativeDecline = exchageModel.cumulativeAltitudeLoss;
    record.altitudeCount = exchageModel.altitudeCount;
    record.altitudeItems = exchageModel.altitudeItems;
    record.avgAltitude = exchageModel.avgAltitude;
    record.isLocus = [exchageModel.altitudeItems isKindOfClass:[NSArray class]] ? exchageModel.altitudeItems.count > 0 ? YES : NO : NO;
    record.gpsSourceType = 2;
    //end
    record.isSupportTrainingEffect = __IDO_FUNCTABLE__.funcTable38Model.syncV3ActivityAddParam;
    //    record.maximalOxygenUptake = exchageModel.vo2Max / 100;
    record.trainingEffectScore = exchageModel.trainingEffect;
    if (__IDO_FUNCTABLE__.funcTable34Model.supportGrade) {
        record.maximalOxygenUptake = exchageModel.vo2Max;
        record.oxygenLevel = exchageModel.grade;
    } else {
        record.maximalOxygenUptake = exchageModel.vo2Max / 100;
    }
    record.trainingEffectScore = exchageModel.trainingEffect;
    if (exchageModel.recoverTime > 0) {
        NSDate *nDate = [self getRecoverTime:exchageModel.recoverTime];
//        record.recoveDatetime = [NSString stringWithFormat:@"%04ld-%02ld-%02ld %02ld:%02ld:%02ld",nDate.year,nDate.month,nDate.day,nDate.hour,nDate.minute,nDate.second];
    }
    
    if ([kmPaceArray isKindOfClass:NSArray.class]) {
        if ([kmPaceArray.firstObject isKindOfClass:NSNumber.class]) {
            record.maxPace = [[kmPaceArray valueForKeyPath:@"@max.integerValue"] integerValue];
        }
    }
    
    record.avgPace = exchageModel.kmSpeed;
    record.swType = exchageModel.swimPosture;
    
    if (railArray.count > 0) {
        record.isLocus = YES;
        record.gpsSourceType = 1;
        NSMutableArray *gpsArr = [NSMutableArray array];
        
        //最低海拔和最高海拔
        CGFloat lowestAtitude = 10000;
        CGFloat highestAtitude = -10000;
        
        //累计爬升
        CGFloat cumulativeClimb = 0;
        
        //累计下降
        CGFloat cumulativeDecline = 0;
        
        NSInteger idx = 0;
        CGFloat lastAltitude = 0;
        
        for (IDOSRailModel *item in railArray) {
            if (idx != 0) {
                CGFloat marAltitude = item.altitude - lastAltitude;
                if (marAltitude > 0) {//爬升
                    cumulativeClimb += marAltitude;
                }else{//下降
                    cumulativeDecline += ABS(marAltitude);
                }
            }
            
            lowestAtitude = MIN(lowestAtitude, item.altitude);
            highestAtitude = MAX(highestAtitude, item.altitude);
            
            lastAltitude = item.altitude;
            
            idx ++;
            if (item.time_string.length == 10) {
                item.time_string = @(item.time_string.integerValue * 1000).stringValue;
            }
            
            [gpsArr addObject:@[@(item.latitude.doubleValue),@(item.longtitude.doubleValue),@(item.time_string.integerValue),@(item.altitude)]];
        }
        
//        record.lowestAltitude = [NSString stringWithFormat:@"%.1lf",lowestAtitude];
//        record.highestAltitude = [NSString stringWithFormat:@"%.1lf",highestAtitude];
//        record.cumulativeClimb = round(cumulativeClimb * 10);
//        record.cumulativeDecline = round(cumulativeDecline * 10);
        record.gps = (NSDictionary *)@{@"interval":@(2),@"items":gpsArr.yy_modelToJSONString}.yy_modelToJSONString;
    }else{
        record.isLocus = NO;
        record.gpsSourceType = 0;
//        record.lowestAltitude = @"0";
//        record.highestAltitude = @"0";
    }
    if ([hrValues isKindOfClass:NSString.class]) {
//        hrValues = [(NSString *)hrValues transToObject];
    }
    /**< 适配安卓数据做强转 */
    if ([hrValues isKindOfClass:NSArray.class]) {
        if (hrValues.count > 0) {
//            record.heartrate = (NSDictionary *)@{@"interval":@(exchageModel.intervalSecond),@"items":hrValues.yy_modelToJSONString}.yy_modelToJSONString;
        }
    }
    if ([stepsArray isKindOfClass:NSArray.class]) {
        if (stepsArray.count > 0) {
//            record.rate = (NSDictionary *)@{@"interval":@1,@"items":stepsArray.yy_modelToJSONString}.yy_modelToJSONString;
        }
    }
    if ([milePaceArray isKindOfClass:NSArray.class] && [kmPaceArray isKindOfClass:NSArray.class]) {
        if (kmPaceArray.count > 0) {
//            record.pace = (NSDictionary *)@{@"metricItems":kmPaceArray.yy_modelToJSONString,@"britishItems":milePaceArray.yy_modelToJSONString}.yy_modelToJSONString;
        }
    }
    record.uploadedStrava = NO;
    record.maximalOxygenLevel =  exchageModel.grade;//保存 摄氧量等级
    
    return record;
}

+ (IDOCoreSportRecordModel *)v3_exchangeModelToResource:(IDOV3DataExchangeModel *)exchageModel
                                              timestamp:(NSInteger)timestamp
                                               hrValues:(NSArray *)hrValues
                                             sourceType:(IDOSportSourceType)sourceType
                                              railArray:(NSArray <IDOSRailModel *>*)railArray
                                                 userId:(NSString *)userId{
    
    
    
    IDOCoreSportRecordModel *record = [IDOCoreSportRecordModel new];
    record.userId = userId;
    record.dateTimestamp = timestamp;
    record.timestamp = timestamp * 1000;
    record.isUpload = NO;
    record.date = [[self YMDDateFormater] stringFromDate:[NSDate dateWithTimeIntervalSince1970:timestamp]];
    record.sourceMac = __IDO_MAC_ADDR__;
    record.deviceName = __IDO_NAME__;
    record.sourceOs = 1;
    record.datetime = [[self YMDHMSDateFormater] stringFromDate:[NSDate dateWithTimeIntervalSince1970:timestamp]];
    record.type = exchageModel.sportType;
    record.totalSeconds = exchageModel.durations;
    record.numCalories = exchageModel.calories;
    record.numSteps = exchageModel.step;
    record.distance = exchageModel.distance;
    record.startTime = record.datetime;
    record.endTime = [[self YMDHMSDateFormater] stringFromDate:[NSDate dateWithTimeIntervalSince1970:timestamp + exchageModel.durations]];
    record.warmupSeconds = exchageModel.warmUpSecond;
    record.burnFatSeconds = exchageModel.fatBurnSecond;
    record.aerobicSeconds = exchageModel.aerobicSecond;
    record.anaerobicSeconds = exchageModel.anaeroicSecond;
    record.extremeSeconds = exchageModel.limitSecond;
    record.maxHrValue = exchageModel.maxHrValue;
    record.avgHrValue = exchageModel.avgHrValue;
    record.sourceType = sourceType;
    record.maxSpeed = exchageModel.maxSpeed;
    record.avgSpeed = exchageModel.avgSpeed;
    record.avgRate = exchageModel.avgStepFrequency;
    record.maxRate = exchageModel.maxStepFrequency;
    record.stepRange = exchageModel.avgStepStride;
    record.minPace = exchageModel.fastKmSpeed;
    record.isSupportTrainingEffect = __IDO_FUNCTABLE__.funcTable38Model.syncV3ActivityAddParam;
    //新增指标
    record.avg3dSpeed = exchageModel.avg3dSpeed;
    record.distance3d = exchageModel.distance3d;
    record.avgVerticalSpeed = exchageModel.avgVerticalSpeed;
    record.avgSlope = exchageModel.avgSlope;
    record.highestAltitude = exchageModel.maxAltitude;
    record.lowestAltitude = exchageModel.minAltitude;
    record.cumulativeClimb = exchageModel.cumulativeAltitudeRise;
    record.cumulativeDecline = exchageModel.cumulativeAltitudeLoss;
    record.altitudeCount = exchageModel.altitudeCount;
    record.altitudeItems = exchageModel.altitudeItems;
    record.avgAltitude = exchageModel.avgAltitude;
    record.isLocus = [exchageModel.altitudeItems isKindOfClass:[NSArray class]] ? exchageModel.altitudeItems.count > 0 ? YES : NO : NO;
    record.gpsSourceType = 2;
    //end
    record.isSupportTrainingEffect = __IDO_FUNCTABLE__.funcTable38Model.syncV3ActivityAddParam;
    //    record.maximalOxygenUptake = exchageModel.vo2Max / 100;
    record.trainingEffectScore = exchageModel.trainingEffect;
    if (__IDO_FUNCTABLE__.funcTable34Model.supportGrade) {
        record.maximalOxygenUptake = exchageModel.vo2Max;
        record.oxygenLevel = exchageModel.grade;
    } else {
        record.maximalOxygenUptake = exchageModel.vo2Max / 100;
    }
    
    NSInteger minValue = 0;
    for (NSNumber *num in exchageModel.hrValues) {
        if (num.integerValue == 0) {
            continue;
        }
        if (minValue == 0) {
            minValue = num.integerValue;
        }else{
            minValue = MIN(minValue, num.integerValue);
        }
    }
    
    record.minHrValue = minValue;

    record.actType = exchageModel.planType;
    if (exchageModel.planType > 0) {
        if (__IDO_FUNCTABLE__.funcTable34Model.supportSportPlan) {
            record.type = IDOAllSportTypeOutsideRun;
        }
        NSMutableArray *actionItems = [NSMutableArray array];
        for (NSDictionary *dic in exchageModel.actionData) {
            NSMutableDictionary *nDic = [NSMutableDictionary dictionary];
            [nDic setValue:dic[@"time"] forKey:@"actual_time"];
            [nDic setValue:dic[@"goal_time"] forKey:@"goal_time"];
            [nDic setValue:dic[@"type"] forKey:@"type"];
            [nDic setValue:dic[@"heart_con_value"] forKey:@"heart_value"];
            
            NSString *nDicStr = [nDic yy_modelToJSONString];
            [actionItems addObject:nDicStr];
        }
        
        NSString *str = [actionItems yy_modelToJSONString];
//        if ([str containsString:@"\\"]) {
//            str = [str stringByReplacingOccurrencesOfString:@"\\" withString:@""];
//        }
        
        NSLog(@"exchageModel.actionData====:%ld  exchageModel.actionDataCount:%ld  str:%@",exchageModel.actionData.count,exchageModel.actionDataCount,str);
        record.runningPullUp = str;
        record.completionRate = exchageModel.completionRate;
        record.inClassCalories = exchageModel.inClassCalories;
        record.hrCompletionRate = exchageModel.hrCompletionRate;
    }else{
        record.runningPullUp = @"";
    }
    
    if (exchageModel.recoverTime > 0) {
        NSDate *nDate = [self getRecoverTime:exchageModel.recoverTime];
//        record.recoveDatetime = [NSString stringWithFormat:@"%04ld-%02ld-%02ld %02ld:%02ld:%02ld",nDate.year,nDate.month,nDate.day,nDate.hour,nDate.minute,nDate.second];
    }
    
    NSArray *kmPaceArray = exchageModel.kmSpeeds;
    if ([kmPaceArray isKindOfClass:NSArray.class]) {
        if ([kmPaceArray.firstObject isKindOfClass:NSNumber.class]) {
            record.maxPace = [[kmPaceArray valueForKeyPath:@"@max.integerValue"] integerValue];
        }
    }
    
    record.avgPace = exchageModel.kmSpeed;
    record.swType = exchageModel.swimPosture;
    
    if (railArray.count > 0) {
        record.isLocus = YES;
        record.gpsSourceType = 1;
        NSMutableArray *gpsArr = [NSMutableArray array];
        
        //最低海拔和最高海拔
        CGFloat lowestAtitude = 10000;
        CGFloat highestAtitude = -10000;
        
        //累计爬升
        CGFloat cumulativeClimb = 0;
        
        //累计下降
        CGFloat cumulativeDecline = 0;
        
        NSInteger idx = 0;
        CGFloat lastAltitude = 0;
        
        for (IDOSRailModel *item in railArray) {
            if (idx != 0) {
                CGFloat marAltitude = item.altitude - lastAltitude;
                if (marAltitude > 0) {//爬升
                    cumulativeClimb += marAltitude;
                }else{//下降
                    cumulativeDecline += ABS(marAltitude);
                }
            }
            
            lowestAtitude = MIN(lowestAtitude, item.altitude);
            highestAtitude = MAX(highestAtitude, item.altitude);
            
            lastAltitude = item.altitude;
            
            idx ++;
            if (item.time_string.length == 10) {
                item.time_string = @(item.time_string.integerValue * 1000).stringValue;
            }
            
            [gpsArr addObject:@[@(item.latitude.doubleValue),@(item.longtitude.doubleValue),@(item.time_string.integerValue),@(item.altitude)]];
        }
        
//        record.lowestAltitude = [NSString stringWithFormat:@"%.1lf",lowestAtitude];
//        record.highestAltitude = [NSString stringWithFormat:@"%.1lf",highestAtitude];
//        record.cumulativeClimb = round(cumulativeClimb * 10);
//        record.cumulativeDecline = round(cumulativeDecline * 10);
        record.gps = (NSDictionary *)@{@"interval":@(2),@"items":gpsArr.yy_modelToJSONString}.yy_modelToJSONString;
    }else{
        record.isLocus = NO;
        record.gpsSourceType = 0;
//        record.lowestAltitude = @"0";
//        record.highestAltitude = @"0";
    }
    if ([hrValues isKindOfClass:NSString.class]) {
//        hrValues = [(NSString *)hrValues transToObject];
    }
    /**< 适配安卓数据做强转 */
    if ([hrValues isKindOfClass:NSArray.class]) {
        if (hrValues.count > 0) {
            record.heartrate = (NSDictionary *)@{@"interval":@(exchageModel.intervalSecond),@"items":hrValues.yy_modelToJSONString}.yy_modelToJSONString;
        }else{
            NSArray *nHrs = exchageModel.hrValues;
            if ([nHrs isKindOfClass:NSString.class]) {
//                nHrs = [(NSString *)nHrs transToObject];
            }
            if ([nHrs isKindOfClass:[NSArray class]] && nHrs.count > 0) {
                record.heartrate = (NSDictionary *)@{@"interval":@(exchageModel.intervalSecond),@"items":nHrs.yy_modelToJSONString}.yy_modelToJSONString;
            }
        }
    }
    
    NSArray *stepsArray = exchageModel.stepsFrequencys;
    if ([stepsArray isKindOfClass:NSArray.class]) {
        if (stepsArray.count > 0) {
            record.rate = (NSDictionary *)@{@"interval":@1,@"items":stepsArray.yy_modelToJSONString}.yy_modelToJSONString;
        }
    }
    
    NSArray *milePaceArray = exchageModel.mileSpeeds;
    if ([milePaceArray isKindOfClass:NSArray.class] && [kmPaceArray isKindOfClass:NSArray.class]) {
        if (kmPaceArray.count > 0) {
            record.pace = (NSDictionary *)@{@"metricItems":kmPaceArray.yy_modelToJSONString,@"britishItems":milePaceArray.yy_modelToJSONString}.yy_modelToJSONString;
        }
    }
    
    if (__IDO_FUNCTABLE__.funcTable31Model.activitySyncRealTime && __IDO_CONNECTED__){

        NSInteger paceMax = [[exchageModel.paceSpeeds valueForKeyPath:@"@max.integerValue"] integerValue];
        NSInteger speedMax = [[exchageModel.realSpeeds valueForKeyPath:@"@max.integerValue"] integerValue];
        NSInteger stepMax = [[exchageModel.stepsFrequencys valueForKeyPath:@"@max.integerValue"] integerValue];

        if (exchageModel.paceSpeeds.count > 0 && paceMax > 0) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setValue:@"5" forKey:@"interval"];
            [dic setValue:exchageModel.paceSpeeds forKey:@"items"];
            record.currentTimePace = [dic yy_modelToJSONString];
        }else{
            record.currentTimePace = @"";
        }

        if (exchageModel.realSpeeds.count > 0 && speedMax > 0) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setValue:@"5" forKey:@"interval"];
            [dic setValue:exchageModel.realSpeeds forKey:@"items"];
            record.currentTimeSpeed = [dic yy_modelToJSONString];
        }else{
            record.currentTimeSpeed = @"";
        }

        if (exchageModel.stepsFrequencys.count > 0 && stepMax > 0) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setValue:@"5" forKey:@"interval"];
            [dic setValue:exchageModel.stepsFrequencys forKey:@"items"];
            record.currentTimeStrideRate = [dic yy_modelToJSONString];
        }else{
            record.currentTimeStrideRate = @"";
        }
    }
    
    record.uploadedStrava = NO;
    record.isSimpleData = NO;
    record.maximalOxygenLevel =  exchageModel.grade;//保存 摄氧量等级
    record.sourceType = 3;
    
    record.iconType = [self getIconStyle];
    
//    record.exerciseIntensity = [[IDOVFSportRecordDBManager shareInstance] culMetsWithCalorise:record.numCalories weight:weight durations:record.totalSeconds];
    
    return record;
}

+(IDOSportIconStyle)getIconStyle{
    if (__IDO_FUNCTABLE__.funcTable31Model.secondSportIcon) {
        return IDOSportIconStyleSecond;
    }else{
        if ([IDO_BLUE_ENGINE.peripheralEngine.deviceId isEqualToString:@"7606"]) {
            return IDOSportIconStyleThird;
        }else{
            return IDOSportIconStyleDefault;
        }
    }
  
}

+ (NSDateFormatter *)YMDHMSDateFormater{
    static NSDateFormatter *_YMDHMSDateFormater = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(!_YMDHMSDateFormater){
            _YMDHMSDateFormater = [NSDateFormatter new];
            _YMDHMSDateFormater.dateFormat = @"yyyy-MM-dd HH:mm:ss";
            _YMDHMSDateFormater.locale = [NSLocale systemLocale];
            _YMDHMSDateFormater.timeZone = [NSTimeZone systemTimeZone];;
        }
    });
    
    return _YMDHMSDateFormater;
}
+ (NSDateFormatter *)YMDDateFormater{
    static NSDateFormatter *_ymdDateFormater = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(!_ymdDateFormater){
            _ymdDateFormater = [NSDateFormatter new];
            _ymdDateFormater.dateFormat = @"yyyy-MM-dd";
        }
    });
    
    if (_ymdDateFormater) {
        _ymdDateFormater.locale = [NSLocale systemLocale];
        _ymdDateFormater.timeZone = [NSTimeZone systemTimeZone];
    }
    
    return _ymdDateFormater;
}
@end
