//
//  IDOH5Manager.h
//  IDOVFHome
//
//  Created by mac2019 on 2022/5/27.
//

#import <Foundation/Foundation.h>
#import "IDOSleepManagerVC.h"
#import "IDOH5FailView.h"

NS_ASSUME_NONNULL_BEGIN

#define k_run_plan_main_url(cmd)       [USER_DEFAULT getSleepManagerUrl:cmd]
#define k_sleep_manager_main_url(cmd)  [USER_DEFAULT getSleepManagerUrl:cmd]

//计划变更，更新首页的显示
static NSString *kUpdateRunPlan = @"updateRunPlan";

//把跑步计划生成的数据同步到云端
static NSString *kUploadRunDataToServer = @"uploadRunDataToServer";


//进入h5，睡眠管理页面
static NSString *K_HOME_HEALTH_SLEEP_MANAGER_URL = @"?planType=sleep";
//进入h5，查看睡眠计划
static NSString *K_HOME_HEALTH_SLEEP_PLAN_URL = @"?planType=seePlan";

//h5更新睡眠计划时间
static NSString *K_UPDATE_SLEEP_TIME_KEY = @"updateSleepTime";
//停止睡眠管理计划
static NSString *K_STOP_PLAN_KEY = @"stopSleepPlan";
//h5点击进入到睡眠管理页面
static NSString *K_UPDATE_SLEEP_WEEKLY_STATE_KEY = @"readWeeklyStatus";
//h5点击打开同步健康数据到云
static NSString *K_UPDATE_OPEN_SYNC_HEALTH_KEY = @"openSyncHealthInfo";

static NSString *kUpdateWeightPlanKey = @"Update_weitgh_plan";

/**
 运动状态类型
 */
typedef NS_OPTIONS(NSUInteger, IDOHomeRuningPlanType)
{
    IDOHomeRuningPlanTypeStartTraining = 1, //表示开始训练，通知 h5
    IDOHomeRuningPlanTypeSuspendTraining = 2,//表示暂停训练，通知 h5 暂停训练
    IDOHomeRuningPlanTypeRenewTraining = 3,//表示恢复训练，通知 h5 恢复训练
    IDOHomeRuningPlanTypeStopTraining = 4,//表示停止训练，通知 h5 停止训练
    IDOHomeRuningPlanTypeStartTrainingFail = 5,//表示开始训练失败，通知 h5
    IDOHomeRuningPlanTypeSuspendTrainingFail = 6,//表示暂停训练失败，通知 h5 暂停训练失败
    IDOHomeRuningPlanTypeRenewTrainingFail = 7,//表示恢复训练失败，通知 h5 恢复训练失败
    IDOHomeRuningPlanTypeStopTrainingFail = 8,//表示停止训练失败，通知 h5 停止训练失败
    IDOHomeRuningPlanTypeSyncDeviceData = 9,//表示同步设备数据到 app，通知 h5 弹窗提示用户，并禁止页面操作
    IDOHomeRuningPlanTypeIsSetPlanSuccess = 10,//表示设置计划成功，通知 h5 弹窗提示用户
    IDOHomeRuningPlanTypeIsSetPlanFail = 11,//表示设置计划失败，通知 h5 弹窗提示用户
    IDOHomeRuningPlanTypeIsSynchroPlanSuccess = 12,//表示同步计划成功，通知 h5 弹窗提示用户
    IDOHomeRuningPlanTypeIsSynchroPlanFail = 13,//表示同步计划失败，通知 h5 弹窗提示用户
    IDOHomeRuningPlanTypeIsEndPlanSuccess = 14,//表示结束计划成功，通知 h5 弹窗提示用户
    IDOHomeRuningPlanTypeIsEndPlanFail = 15,//表示结束计划失败，通知 h5 弹窗提示用户
    IDOHomeRuningPlanTypeConnectingDeviceSuccess = 17,//表示连接设备成功，通知 h5 弹窗提示用户
    IDOHomeRuningPlanTypeConnectingDeviceFail = 18,//表示连接设备失败，通知 h5 弹窗提示用户
    IDOHomeRuningPlanTypeConnectingBluetoothSuccess = 19,//表示蓝牙已连接，通知 h5弹窗提示用户
    IDOHomeRuningPlanTypeConnectingBluetoothFail = 20,//表示蓝牙未连接，通知 h5 关闭弹窗
    IDOHomeRuningPlanTypeAllDeviceStatus = 21,//设备已连接不支持跑步计划和设备未连接，app 需要返回的状态{'runningPlanAllDeviceStatus'：{}}
    IDOHomeRuningPlanTypeConnectingDeviceStatus = 22,//设备已连接且支持跑步计划，需要 app 返回的状态{'runningPlanConnectingDeviceStatus'：{}}
    
};


@interface IDOH5Manager : NSObject

+ (IDOH5Manager *)shareInstance;

/**
 跑步计划的回调
 */
@property (nonatomic,copy) void (^runningPlanSetPlanBlock)(NSDictionary *dic);

/**
 开始锻炼。停止，暂停，恢复的回调
 */
@property (nonatomic,copy) void (^runningPlanToggleTrainingBlock)(NSDictionary *dic);

/**
 当前的设备以及计划的情况回调
 */
@property (nonatomic,copy) void (^runningPlanAllDeviceStatusBlock)(void);


/**
 当前的设备以及计划的情况回调
 */
@property (nonatomic,copy) void (^musicInfoBlock)(NSDictionary *musicInfo);

/**
 点击返回按钮回调,使用这个回调主要是为了解决回到首页情况下，查询计划是否存在有变化
 
 因为目前，不支持跑步计划的设备，在开启和结束计划的情况，不会通知原生app，只能自己去查询是否存在有变化 ---- nongdahu 2022-07-08
 
 */
@property (nonatomic,copy) void (^clickBackBlock)(void);


/**
 注册h5相关的方法以及给h5传入对应的用户信息数据
 */
- (void)h5QueryUserInfoWithVC:(IDOSleepManagerVC *)vc;

/**
 状态发生变化，通知h5
 @param planType 当前的状态
 @param vc 健康管理的控制器
 @param data 数据，只有 planType = IDOHomeRuningPlanTypeConnectingDeviceStatus 的时候才会有用
 */
- (void)sendToH5State:(IDOHomeRuningPlanType)planType vc:(IDOSleepManagerVC *)vc data:(id)data;

/**
 状态发生变化，通知h5, 内部自己判断了当前控制器
 @param planType 当前的状态
 @param data 数据，只有 planType = IDOHomeRuningPlanTypeConnectingDeviceStatus 的时候才会有用
 */
- (void)sendToH5State:(IDOHomeRuningPlanType)planType data:(id)data;

/**
 根据h5制定的接口传值
 @param data 给h5传输的数据
 @param param h5 对应的接口名称
 */
- (void)sendDataToH5:(id)data param:(NSString *)param;

/**
 是否可以实现手势返回
 */
- (void)panDisableBack;

@end

NS_ASSUME_NONNULL_END
