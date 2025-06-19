//
//  HistoricalMenstruationManager.h
//  IDOBlueProtocol
//
//  Created by cyf on 2024/10/14.
//  Copyright © 2024 何东阳. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// V3 经期历史
@interface IDOHistoricalMenstruationManager : NSObject


/// 单例
+ (instancetype)shareInstance;

/**
 * @brief //设置经期历史数据 Vesion3
 * 功能表： __IDO_FUNCTABLE__.funcTable42Model.supportHistoricalMenstruationExchange
 * 若功能表支持，则支持排卵期相关字段的设置
 * @param historyModel 经期历史数据模型
 * @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
 */
- (void)setMenstrualHistoryVesion3DataCommand:(IDOMenstrualHistoryDataVesion3Model *_Nullable)historyModel
                              callback:(void (^ _Nullable)(int errorCode))callback;

/**
 * @brief 查询经期历史Vesion3  |Get Menstrual History Vesion3 Data
 *  * 功能表 | Function Table :  __IDO_FUNCTABLE__.funcTable42Model.supportHistoricalMenstruationExchange
 * @param callback 执行后回调 data (IDOMenstrualHistoryDataVesion3Model) (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
 * callback data (IDOMenstrualHistoryDataVesion3Model) (errorCode : 0 The transfer was successful, the other values are errors, and the error code str can be obtained according to IDOErrorCodeToStr)
 */
- (void)getMenstrualHistoryVesion3DataCommand:(void (^ _Nullable)(int errorCode,IDOMenstrualHistoryDataVesion3Model *_Nullable model))callback;


/// 设置V3经期配置项 | set V3 Menstruation Config
/// __IDO_FUNCTABLE__.funcTable42Model.supportProtocolV3MemstruationConfig
/// @param model IDOSetV3MenstruationConfigModel
/// @param callback (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
- (void)setV3MenstruationConfigData:(IDOSetV3MenstruationConfigModel *_Nullable )model callback:(void (^ _Nullable)(int errorCode))callback;

/// 查询V3经期配置项 | get V3 Menstruation Config
/// __IDO_FUNCTABLE__.funcTable42Model.supportProtocolV3MemstruationConfig
/// @param callback 执行后回调 dataIDOSetV3MenstruationConfigModel (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
- (void)getV3MenstruationConfigData:(void (^ _Nullable)(int errorCode,IDOSetV3MenstruationConfigModel *_Nullable model))callback;

@end

NS_ASSUME_NONNULL_END
