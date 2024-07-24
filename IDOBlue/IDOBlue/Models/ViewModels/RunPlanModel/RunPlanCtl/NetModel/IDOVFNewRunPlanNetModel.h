//
//  IDOVFNewRunPlanNetModel.h
//  AFNetworking
//
//  Created by mac2019 on 2022/5/27.
//

#import "IDOVFNewBaseNetModel.h"
#import "IDOCoreSportRecordModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface IDOVFNewRunPlanNetModel : IDOVFNewBaseNetModel

/**
 获取大概的训练计划
 */
+ (IDOVFNewRunPlanNetModel *)getRunPlan:(NSString *)token;

/**
 获取详细的训练计划
 */
+ (IDOVFNewRunPlanNetModel *)getDetailRunPlan:(NSString *)token;

/**
 获取服务器上具体的训练计划，这个计划用户下发到设备
 */
+ (IDOVFNewRunPlanNetModel *)getDetailPlanExecutingIssued:(NSString *)token;


/**
 查询当前用户是否存在有训练的报告或者今天是否为训练日
 */
+ (void)loadRunPlanNotiInfoWith:(NSString *)token Block:(void (^)(BOOL isExistReport, NSInteger reportType, BOOL isTrainDay, NSInteger runType))compeleter;

/**
 发送已读
 */
+ (void)sendHavedReadedRunReport:(NSString *)token;


+ (NSDictionary *)runPlanDicWithSportModel:(IDOCoreSportRecordModel *)sportModel planId:(NSInteger)planId;

+ (void)updatePlanToken:(NSString *)token Datas:(NSArray <NSDictionary *>*)datas block:(void (^)(BOOL result))compeleter;

@end


NS_ASSUME_NONNULL_END
