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
 1:请求app打开gps  2：发起运动请求
 */
@property (nonatomic,assign) NSInteger operate;
/**
 计划类型：
 0x01：跑步计划3km ，0x02：跑步计划5km ，
 0x03：跑步计划10km ，0x04：半程马拉松训练（二期） ，0x05：马拉松训练（二期）
 */
@property (nonatomic,assign) NSInteger planType;
/**
 动作类型  1快走；2慢跑；3中速跑；4快跑  ；
 5结束课程运动 （还要等待用户是否有自由运动）；6课程结束后自由运动 （此字段当operate为0x05起作用）
 */
@property (nonatomic,assign) NSInteger actionType;

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
 运动计划操作错误码，0为成功，其他为失败
 */
@property (nonatomic,assign) NSInteger errorCode;
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
 * 信号强弱  0: 表示信号弱， 1: 表示信号强
 * Signal strength 0: means signal is weak, 1: means signal is strong
 */
@property (nonatomic,assign) NSInteger signalFlag;
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
 无氧训练效果；  单位：无   范围 1.0 ~ 5.0 （*10倍）
 */
@property (nonatomic,assign) NSInteger anaerobicTrainingEffect;
/**
 最大摄氧量；  单位：毫升/公斤/分钟； 范围  0-80
 */
@property (nonatomic,assign) NSInteger vo2Max;
/**
 本次动作训练个数
 */
@property (nonatomic,assign) NSInteger actionDataCount;
/**
 课程内运动热量  单位千卡
 */
@property (nonatomic,assign) NSInteger inClassCalories;
/**
 动作完成率 0—100
 */
@property (nonatomic,assign) NSInteger completionRate;
/**
 心率控制率  0—100
 */
@property (nonatomic,assign) NSInteger hrCompletionRate;
/**
 恢复时长：单位小时(app收到该数据之后，每过一小时需要自减一)
 */
@property (nonatomic,assign) NSInteger recoverTime;
/**
 摄氧量等级  0x01:低等   0x02:业余   0x03:一般  0x04：平均    0x05：良好  0x06：优秀   0x07：专业
 */
@property (nonatomic,assign) NSInteger grade;
/**
 动作完成内容
 type : 动作类型  1快走；2慢跑; 3中速跑；4快跑
 heart_con_value : 每个动作心率控制
 time : 动作完成时间 单位秒
 goal_time ：动作目标时间
 */
@property (nonatomic,strong) NSMutableArray<NSDictionary *> * actionData;

/**
 训练的课程日期偏移 从0开始
 */
@property (nonatomic,assign) NSInteger trainingOffset;
/**
 运动倒计时
 */
@property (nonatomic,assign) NSInteger countHour;
/**
 运动倒计时分
 */
@property (nonatomic,assign) NSInteger countMinute;
/**
 运动倒计时秒
 */
@property (nonatomic,assign) NSInteger countSecond;
/**
 训练课程年份
 */
@property (nonatomic,assign) NSInteger trainingYear;
/**
 训练课程月份
 */
@property (nonatomic,assign) NSInteger trainingMonth;
/**
 训练课程日期
 */
@property (nonatomic,assign) NSInteger trainingDay;
/**
 动作目标时间  单位秒
 */
@property (nonatomic,assign) NSInteger time;
/**
 心率范围低值
 */
@property (nonatomic,assign) NSInteger lowHeart;
/**
 心率范围高值
 */
@property (nonatomic,assign) NSInteger heightHeart;

/**
 实时配速个数
 */
@property (nonatomic,assign) NSInteger paceSpeedCount;

/**
 实时配速数组  传过来的是 s 钟  每5S算一次
 */
@property (nonatomic,strong) NSMutableArray<NSNumber *> * paceSpeeds;

/**
 实时速度个数
 */
@property (nonatomic,assign) NSInteger realSpeedCount;

/**
 实时速度数组 传过来的是 s 钟  每5S算一次
 */
@property (nonatomic,strong) NSMutableArray<NSNumber *> * realSpeeds;

@end

NS_ASSUME_NONNULL_END
