//
//  IDOTranningManager.h
//  IDOVFHome
//
//  Created by mac2019 on 2022/5/27.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

/**
 运动状态类型
 */
typedef NS_OPTIONS(NSUInteger, IDOHomeStartRuningType)
{
    IDOHomeStartRuningTypeSuc = 0, //开始运动成功
    IDOHomeStartRuningTypeFialCharging = 4, //充电中
    IDOHomeStartRuningTypeFialRunning = 5, //正在运动中
    IDOHomeStartRuningTypeFialLowPower = 6, //低电量
    IDOHomeStartRuningTypeFialUseAlexa = 7, //正在使用alexa
    IDOHomeStartRuningTypeFialIsCall = 8, //正在通话中
    IDOHomeStartRuningTypeFialIsDisconnect = 9, //蓝牙断开
    IDOHomeStartRuningTypeFailOther = 10, //其他失败
    
    
    IDOHomeStartRuningTypePauceSuc = 11,//暂停成功
    IDOHomeStartRuningTypePauceFail = 12,//暂停失败
    
    IDOHomeStartRuningTypeRestartSuc = 13,//恢复训练成功
    IDOHomeStartRuningTypeRestartFail = 14,//恢复训练失败
    
    IDOHomeStartRuningTypeStopSuc = 15,//停止训练成功
    IDOHomeStartRuningTypeStopFail = 16,//停止训练失败
    
    IDOHomeStartRuningTypeStartSuc = 17,//开始成功
    IDOHomeStartRuningTypeStartFail = 18,//开始失败
};


@interface IDOTranningManager : NSObject

+ (IDOTranningManager *)shareInstance;

/**
 运动结果回调
 
 */
@property (nonatomic,copy) void (^tranningExeModelResultBlock)(NSDictionary *dic);

/**
 开始跑步计划训练
 @param dic h5传过来的数据
 */
- (void)startPlanTranningWithDic:(NSDictionary *)dic;

/**
 暂停跑步计划训练
 */
- (void)pancePlanTranning;

/**
 恢复跑步计划训练
 */
- (void)restorePlanTranning;

/**
 停止跑步计划训练
 */
- (void)stopPlanTranning;

@end

NS_ASSUME_NONNULL_END
