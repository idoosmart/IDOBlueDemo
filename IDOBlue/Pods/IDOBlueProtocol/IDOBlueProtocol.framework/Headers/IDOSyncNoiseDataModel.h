//
//  IDOSyncNoiseDataModel.h
//  IDOBlueProtocol
//
//  Created by hedongyang on 2021/7/6.
//  Copyright © 2021 何东阳. All rights reserved.
//

#if __has_include(<IDOBlueProtocol/IDOBlueProtocol.h>)
#else
#import "IDOBluetoothBaseModel.h"
#endif

@interface IDOSyncNoiseBluetoothItemDataModel : IDOBluetoothBaseModel
/**
 子时间偏移量 (单位:秒) | Total time offset (unit: second)
 */
@property (nonatomic,assign) NSInteger offset;
/**
 噪音值
 */
@property (nonatomic,assign) NSInteger value;
/**
 时间戳 精确到日期 date interval since 1970 (如:1444361933) | Timestamp date interval since 1970 (eg: 14443361933)
 */
@property (nonatomic,copy) NSString * dateStr;

@end

@interface IDOSyncNoiseBluetoothDataModel : IDOBluetoothBaseModel
/**
 年份
 */
@property (nonatomic,assign) NSInteger year;
/**
 月份
 */
@property (nonatomic,assign) NSInteger month;
/**
 日期
 */
@property (nonatomic,assign) NSInteger day;
/**
 日期时间戳
 */
@property (nonatomic,copy) NSString * dateStr;
/**
 起始时间 单位秒
 */
@property (nonatomic,assign) NSInteger startTime;
/**
 数据的间隔 秒钟、分钟
 */
@property (nonatomic,assign) NSInteger intervalMode;
/**
 平均的噪音
 */
@property (nonatomic,assign) NSInteger avgNoise;
/**
 最大的噪音
 */
@property (nonatomic,assign) NSInteger maxNoise;
/**
 最小的噪音
 */
@property (nonatomic,assign) NSInteger minNoise;
/**
 噪音个数
 */
@property (nonatomic,assign) NSInteger itemCount;
/**
 噪音集合
 */
@property (nonatomic,strong) NSArray <IDOSyncNoiseBluetoothItemDataModel *>* items;

@end

@interface IDOSyncNoiseDataModel : IDOBluetoothBaseModel

@end

