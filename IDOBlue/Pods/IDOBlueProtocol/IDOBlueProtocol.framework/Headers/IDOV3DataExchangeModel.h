//
//  IDOV3DataExchangeModel.h
//  IDOBlueProtocol
//
//  Created by hedongyang on 2022/4/28.
//  Copyright © 2022 何东阳. All rights reserved.
//

#import <IDOBlueProtocol/IDONewDataExchangeModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface IDOV3DataExchangeModel : IDONewDataExchangeModel
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
 数据版本
 */
@property (nonatomic,assign) NSInteger dataVersion;
/**
 当前心率 | current heart rate
 */
@property (nonatomic,assign) NSInteger curHrValue;
/**
 距离 (单位:米) | distance
 */
@property (nonatomic,assign) NSInteger distance;
/**
 卡路里 (单位:J) | calories
 */
@property (nonatomic,assign) NSInteger calories;
/**
 步数 (单位:步) | step
 */
@property (nonatomic,assign) NSInteger step;
/**
 持续时间 (单位:秒钟) | durations
 */
@property (nonatomic,assign) NSInteger durations;
/**
 * 0x00 : 混合泳; 0x01 : 自由泳; 0x02 : 蛙泳; 0x03 : 仰泳; 0x04 : 蝶泳;
 * 0x00: medley; 0x01: freestyle; 0x02: breaststroke; 0x03: backstroke; 0x04: butterfly stroke;
 */
@property (nonatomic,assign) NSInteger swimPosture;
/**
 status 手环返回的状态 开始:1,暂停:2, 结束:3,0:无效状态
 starts with :1, pauses :2, ends with :3,0: invalid status
 */
@property (nonatomic,assign) NSInteger status;
/**
 是否存储 | is save
 */
@property (nonatomic,assign) BOOL isSave;
/**
 * app计算显示实时速度 单位km/h 100倍 15秒一个记录
 * App calculates and displays real-time speed km/h 100 times
 */
@property (nonatomic,assign) NSInteger realTimeSpeed;
/**
 * app计算显示实时配速 单位 s
 * App calculates and displays real-time pace unit second
 */
@property (nonatomic,assign) NSInteger realTimePace;
/**
 心率间隔 | heart rate interval
 */
@property (nonatomic,assign) NSInteger intervalSecond;
/**
 心率个数
 */
@property (nonatomic,assign) NSInteger heartRateCount;
/**
 心率数据 | heart rate data
 */
@property (nonatomic,strong) NSMutableArray<NSNumber *> * hrValues;
/**
 热身锻炼时长(秒钟) | warm up exercise second
 */
@property (nonatomic,assign) NSInteger warmUpSecond;
/**
 无氧锻炼时长(秒钟) | anaeroic exercise second
 */
@property (nonatomic,assign) NSInteger anaeroicSecond;
/**
 燃脂锻炼时长(秒钟) | anaeroic exercise second
 */
@property (nonatomic,assign) NSInteger fatBurnSecond;
/**
 有氧锻炼时长(秒钟) | anaeroic exercise second
 */
@property (nonatomic,assign) NSInteger aerobicSecond;
/**
 极限锻炼时长(秒钟) | anaeroic exercise second
 */
@property (nonatomic,assign) NSInteger limitSecond;
/**
 平均心率 | avg heart rate
 */
@property (nonatomic,assign) NSInteger avgHrValue;
/**
 最大心率 | max heart rate
 */
@property (nonatomic,assign) NSInteger maxHrValue;
/**
 热身运动值
 */
@property (nonatomic,assign) NSInteger warmUpValue;
/**
脂肪燃烧运动值
*/
@property (nonatomic,assign) NSInteger burnFatValue;
/**
有氧运动值
*/
@property (nonatomic,assign) NSInteger aerobicValue;
/**
极限运动值
*/
@property (nonatomic,assign) NSInteger limitValue;
/**
无氧运动值
*/
@property (nonatomic,assign) NSInteger anaerobicValue;
/**
 平均速度 km/h
 */
@property (nonatomic,assign) NSInteger avgSpeed;
/**
 最大速度 km/h
 */
@property (nonatomic,assign) NSInteger maxSpeed;
/**
 平均步频
 */
@property (nonatomic,assign) NSInteger avgStepFrequency;
/**
 最大步频
 */
@property (nonatomic,assign) NSInteger maxStepFrequency;
/**
 平均步幅
 */
@property (nonatomic,assign) NSInteger avgStepStride;
/**
 最大步幅
 */
@property (nonatomic,assign) NSInteger maxStepStride;
/**
 平均公里配速
 */
@property (nonatomic,assign) NSInteger kmSpeed;
/**
 最快公里配速
 */
@property (nonatomic,assign) NSInteger fastKmSpeed;
/**
 公里配速个数
 */
@property (nonatomic,assign) NSInteger kmSpeedCount;
/**
 公里配速集合
 */
@property (nonatomic,strong) NSMutableArray<NSNumber *> * kmSpeeds;
/**
 英里配速 个数
 */
@property (nonatomic,assign) NSInteger mileCount;
/**
 英里配速集合
 */
@property (nonatomic,strong) NSMutableArray<NSNumber *> * mileSpeeds;
/**
 步频个数
 */
@property (nonatomic,assign) NSInteger stepsFrequencyCount;
/**
 步频集合
 */
@property (nonatomic,strong) NSMutableArray<NSNumber *> * stepsFrequencys;
/**
 训练效果；  单位：无   范围 1.0 ~ 5.0 （*10倍）
 */
@property (nonatomic,assign) NSInteger trainingEffect;
/**
 最大摄氧量；  单位：毫升/公斤/分钟； 范围  0-80
 */
@property (nonatomic,assign) NSInteger vo2Max;

@end

NS_ASSUME_NONNULL_END
