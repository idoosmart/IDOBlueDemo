//
//  IDOHomeHealthManager.h
//  IDOVFHome
//
//  Created by 农大浒 on 2022/1/14.
//

#import <Foundation/Foundation.h>
#import "IDOVFNewRunPlanNetModel.h"
#import "IDORunPlanModel.h"

#define kSleepHealthManagerDataLoadFinishNotification @"SleepHealthManagerDataLoadFinishNotification"

#define kMusicPlayerStatusChangeNotification @"MusicPlayerStatusChangeNotification"

NS_ASSUME_NONNULL_BEGIN

@interface IDOHomeHealthManager : NSObject


/**
 跑步计划的模型
 */
@property (nonatomic,strong) IDORunPlanModel *runPlanModel;
//跑步计划的开启时间字符串
@property (nonatomic,strong) NSString *runPlanStr;
//tokenStr
@property (nonatomic,strong) NSString *tokenStr;
//userIDStr
@property (nonatomic,strong) NSString *userIDStr;

@property (nonatomic , assign)BOOL isSending;

+ (IDOHomeHealthManager *)shareInstance;


/**
 加载跑步计划
 */
- (void)loadRunplanManagerDataWithUserId:(NSString *)userId updateData:(BOOL)updateData block:(void (^)(BOOL result, id obj))block;

- (void)clearMemery;

- (void)calWeightMedcal;

- (void)blueToothConnectError;

@end

NS_ASSUME_NONNULL_END
