//
//  IDORunPlanManager.h
//  IDOVFHome
//
//  Created by mac2019 on 2022/5/20.
//

#import <Foundation/Foundation.h>
#import "IDOH5Manager.h"
#import "IDOTranningManager.h"
#import <IDOBluetooth/IDOBluetooth.h>
#import <IDOBlueUpdate/IDOBlueUpdate.h>
#import <IDOBlueProtocol/IDOBlueProtocol.h>

NS_ASSUME_NONNULL_BEGIN

@interface IDORunPlanManager : NSObject

/**
 点击返回按钮回调,使用这个回调主要是为了解决回到首页情况下，查询计划是否存在有变化
 
 因为目前，不支持跑步计划的设备，在开启和结束计划的情况，不会通知原生app，只能自己去查询是否存在有变化 ---- nongdahu 2022-07-08
 
 */
@property (nonatomic,copy) void (^clickBackBlock)(void);

/**
 检测当前设备的计划
 
 */
@property (nonatomic,copy) void (^runPlanDetailBlock)(IDOSportPlanDataModel *model);

/**
 设置跑步计划返回成功
 */
@property (nonatomic,copy) void (^setRunPlanDetailBlock)(IDOSportPlanDataModel *model);

/**
 当前计划的时间，主要使用于判断当前的计划于固件的计划是否一致
 */
@property (nonatomic,copy) NSString *currentPlanTimeStr;

+ (IDORunPlanManager *)shareInstance;

/**
 注册h5相关的方法以及给h5传入对应的用户信息数据
 对外功能的入口
 */
- (void)h5QueryUserInfoWithVC:(IDOSleepManagerVC *)vc;
/**
 状态发生变化，通知h5 data 数据，只有 planType = IDOHomeRuningPlanTypeConnectingDeviceStatus 的时候才会有用
 目前主要使用于外面蓝牙状态发生变化时候使用
 */
- (void)sendToH5State:(IDOHomeRuningPlanType)planType vc:(IDOSleepManagerVC *)vc data:(id)data;

/**
 状态发生变化，通知h5 data 数据，只有 planType = IDOHomeRuningPlanTypeConnectingDeviceStatus 的时候才会有用
 目前主要使用于外面蓝牙状态发生变化时候使用
 */
- (void)sendToH5State:(IDOHomeRuningPlanType)planType data:(id)data;


/**
 检测设备中的跑步计划
 */
- (void)checkDeviceRunPlan;

- (void)setRunPlanToDeviceWithDic:(NSDictionary *)dic;

- (NSString *)timeStrWithDic:(NSDictionary *)paramDic;
- (NSString *)timeStrWithPlanModel:(IDOSportPlanDataModel *)model;

@end

NS_ASSUME_NONNULL_END
