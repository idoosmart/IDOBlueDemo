//
//  IDODataExchangeManager.h
//  IDOBlueProtocol
//
//  Created by hedongyang on 2022/4/21.
//  Copyright © 2022 何东阳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IDOBlueProtocol/IDONewDataExchangeModel.h>
#import <IDOBlueProtocol/IDOV2DataExchangeModel.h>
#import <IDOBlueProtocol/IDOV3DataExchangeModel.h>

/**
 * 数据交换状态
 */
typedef NS_ENUM(NSInteger, IDO_EXCHANGE_DATA_STATUS) {
    //数据交互状态初始化
    IDO_EXCHANGE_DATA_INIT = 0,
    //运动开始
    IDO_EXCHANGE_DATA_START = 1,
    //运动结束
    IDO_EXCHANGE_DATA_END,
    //运动暂停
    IDO_EXCHANGE_DATA_PAUSE,
    //运动恢复
    IDO_EXCHANGE_DATA_RESTORE,
    //运动进行中
    IDO_EXCHANGE_DATA_ING,
    //运动获取心率
    IDO_EXCHANGE_DATA_GET_HR,
    //运动活动数据
    IDO_EXCHANGE_DATA_GET_ACTIVITY
    
};

NS_ASSUME_NONNULL_BEGIN

@protocol IDODataExchangeManagerDelegate <NSObject>

//app运动开始ble回复
- (void)appStartSportReplyWithModel:(IDOAppStartReplyExchangeModel *)model errorCode:(int)errorCode;
//app运动暂停ble回复
- (void)appPauseSportReplyWithModel:(IDOAppPauseReplyExchangeModel *)model errorCode:(int)errorCode;
//app运动回复ble回复
- (void)appRestoreSportReplyWithModel:(IDOAppRestoreReplyExchangeModel *)model errorCode:(int)errorCode;
//v2 app运动结束ble回复
- (void)v2_appEndSportReplyWithModel:(IDOAppEndReplyExchangeModel *)model errorCode:(int)errorCode;
//v2 app运动交互中ble回复
- (void)v2_appIngSportReplyWithModel:(IDOV2AppIngReplyExchangeModel *)model errorCode:(int)errorCode;
//v3 app运动交互中ble回复
- (void)v3_appIngSportReplyWithModel:(IDOV3AppIngReplyExchangeModel *)model errorCode:(int)errorCode;
//v3 app运动结束后获取心率数据
- (void)v3_appSportHrReplyWithModel:(IDOHrDataExchangeModel *)model errorCode:(int)errorCode;
//v3 app运动结束后返回数据
- (void)v3_appEndSportReplyWithModel:(IDOV3SportEndDataExchangeModel *)model errorCode:(int)errorCode;
//ble停止app运动
- (void)bleEndAppSportWithModel:(IDOBleEndExchangeModel *)model errorCode:(int)errorCode;
//ble暂停app运动
- (void)blePauseAppSportWithModel:(IDONewDataExchangeModel *)model errorCode:(int)errorCode;
//ble恢复app运动
- (void)bleRestoreAppSportWithModel:(IDONewDataExchangeModel *)model errorCode:(int)errorCode;
//设备断开
- (void)bleDisconnect;
//设备连接
- (void)bleDidconnect;

@end

@interface IDODataExchangeManager : NSObject

//当前交互v2数据模型
@property (nonatomic,strong,readonly) IDOV2DataExchangeModel * v2Model;
//当前交互v3数据模型
@property (nonatomic,strong,readonly) IDOV3DataExchangeModel * v3Model;
//是否为v3活动数据交换
@property (nonatomic,assign,readonly) BOOL isV3ActivityExchange;
//数据交换过程状态
@property (nonatomic,assign,readonly)IDO_EXCHANGE_DATA_STATUS exchangeStatus;
//是否使用新的数据交互
@property (nonatomic,assign)BOOL isNewDataExchange;
//代理对象
@property (nonatomic,weak) id<IDODataExchangeManagerDelegate> delegate;

//单例
+ (instancetype)shareInstance;

//app 发起运动开始
+ (BOOL)appStartSportCommandWithModel:(IDOAppStartExchangeModel *)model
                                error:(NSError **)error;
//app 发起运动结束
+ (BOOL)appEndSportCommandWithModel:(IDOAppEndExchangeModel *)model
                              error:(NSError **)error;
//app 发起运动暂停
+ (BOOL)appPauseSportCommandWithModel:(IDONewDataExchangeModel *)model
                                error:(NSError **)error;
//app 发起运动恢复
+ (BOOL)appRestoreSportCommandWithModel:(IDONewDataExchangeModel *)model
                                  error:(NSError **)error;
//app 发起v2运动交换过程
+ (BOOL)v2_appIngSportCommandWithModel:(IDOV2AppIngDataExchangeModel *)model
                                 error:(NSError **)error;
//app 发起v3运动交换过程
+ (BOOL)v3_appIngSportCommandWithModel:(IDOV3AppIngDataExchangeModel *)model
                                 error:(NSError **)error;
//ble 发起运动结束回复
+ (BOOL)bleEndSportReplyCommandWithModel:(IDOBleEndReplyExchangeModel *)model
                                   error:(NSError **)error;
//ble 发起运动暂停回复
+ (BOOL)blePauseSportReplyCommandWithModel:(IDOBlePauseReplyExchangeModel *)model
                                     error:(NSError **)error;
//ble 发起运动恢复回复
+ (BOOL)bleRestoreSportReplyCommandWithModel:(IDOBleRestoreReplyExchangeModel *)model
                                       error:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
