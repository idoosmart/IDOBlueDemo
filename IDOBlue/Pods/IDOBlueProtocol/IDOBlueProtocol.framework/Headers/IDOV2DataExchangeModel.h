//
//  IDOV2DataExchangeModel.h
//  IDOBlueProtocol
//
//  Created by hedongyang on 2022/4/28.
//  Copyright © 2022 何东阳. All rights reserved.
//

#import <IDOBlueProtocol/IDONewDataExchangeModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface IDOV2DataExchangeModel : IDONewDataExchangeModel
/**
 目标类型 | target type
 0x00:无目标， 0x01:重复次数，单位：次，
 0x02:距离,单位：米,  0x03：卡路里, 单位：大卡,
 0x04:时长,单位：分钟, 0x05:  步数, 单位：步
 */
@property (nonatomic,assign) NSInteger targetType;
/**
 目标数值 | target value
 */
@property (nonatomic,assign) NSInteger targetValue;
/**
 是否强制开始 0:不强制,1:强制 | is mandatory start
 */
@property (nonatomic,assign) NSInteger forceStart;
/**
 * 0:成功; 1:设备已经进入运动模式失败;2: 设备电量低失败;3:手环正在充电4:正在使用Alexa 5:通话中
 * 0:success 1:into sport mode failed 2:Low power of equipment 3: the bracelet is charging 4:Using Alexa 5:In the call
 */
@property (nonatomic,assign) NSInteger retCode;
/**
 卡路里 (单位:J) | calories
 */
@property (nonatomic,assign) NSInteger calories;
/**
 距离 (单位:米) | distance
 */
@property (nonatomic,assign) NSInteger distance;
/**
 持续时间 (单位:秒钟) | durations
 */
@property (nonatomic,assign) NSInteger durations;
/**
 步数 (单位:步) | step
 */
@property (nonatomic,assign) NSInteger step;
/**
 平均心率
 */
@property (nonatomic,assign) NSInteger avgHrValue;
/**
 最大心率
 */
@property (nonatomic,assign) NSInteger maxHrValue;
/**
 燃烧脂肪时长
 */
@property (nonatomic,assign) NSInteger burnFatMins;
/**
 有氧时长
 */
@property (nonatomic,assign) NSInteger aerobicMins;
/**
 极限时长
 */
@property (nonatomic,assign) NSInteger limitMins;
/**
 是否存储 | is save
 */
@property (nonatomic,assign) BOOL isSave;
/**
 status:0:全部有效, 1:距离无效， 2: gps 信号弱 | status 0:all effective 1:distance invalid 2:gps signal weak
 */
@property (nonatomic,assign) NSInteger status;
/**
 当前心率 | current heart rate
 */
@property (nonatomic,assign) NSInteger curHrValue;
/**
 序列号 | heart rate value serial
 */
@property (nonatomic,assign) NSInteger hrValueSerial;
/**
 心率间隔 | heart rate interval
 */
@property (nonatomic,assign) NSInteger intervalSecond;
/**
 心率数据 | heart rate data
 */
@property (nonatomic,strong) NSMutableArray<NSNumber *> * hrValues;

@end

NS_ASSUME_NONNULL_END
