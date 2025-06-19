//
//  IDONewDataExchangeModel.h
//  IDOBlueProtocol
//
//  Created by hedongyang on 2022/4/21.
//  Copyright © 2022 何东阳. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IDONewDataExchangeModel : NSObject<NSCopying>
/**
 日 | day
 */
@property (nonatomic,assign) NSInteger day;
/**
 时 | hour
 */
@property (nonatomic,assign) NSInteger hour;
/**
 分 | minute
 */
@property (nonatomic,assign) NSInteger minute;
/**
 秒 | second
 */
@property (nonatomic,assign) NSInteger second;
/**
 * 运动模式 | Sport mode
 以前运动类型:
 0:无，1:走路，2:跑步，3:骑行，4:徒步，5:游泳，6:爬山，7:羽毛球，8:其他，
 9:健身，10:动感单车，11:椭圆机，12:跑步机，13:仰卧起坐，14:俯卧撑，15:哑铃，16:举重，
 17:健身操，18:瑜伽，19:跳绳，20:乒乓球，21:篮球，22:足球 ，23:排球，24:网球，
 25:高尔夫球，26:棒球，27:滑雪，28:轮滑，29:跳舞，31：室内划船/roller machine， 32：普拉提/pilates， 33:交叉训练/cross train,
 34:有氧运动/cardio，35：尊巴舞/Zumba, 36:广场舞/square dance, 37:平板支撑/Plank, 38:健身房/gym 48:户外跑步，49:室内跑步，
 50:户外骑行，51:室内骑行，52:户外走路，53:室内走路，54:泳池游泳，55:开放水域游泳，56:椭圆机，57:划船机，58:高强度间歇训练法，75:板球运动
 基础运动：
 101：功能性力量训练，102：核心训练，103：踏步机，104：整理放松
 健身（25种）
 110：传统力量训练，112：引体向上，114：开合跳，115：深蹲，116：高抬腿，117：拳击，118：杠铃，119：武术，
 120：太极，121：跆拳道，122：空手道，123：自由搏击，124：击剑，125：射箭，126：体操，127:单杠，128:双杠,129:漫步机,
 130:登山机
 球类:
 131:保龄球,132:台球,133:曲棍球,134:橄榄球,135:壁球,136:垒球,137:手球,138:毽球,139:沙滩足球,
 140:藤球,141:躲避球
 休闲运动
 152:街舞,153:芭蕾,154:社交舞,155:飞盘,156:飞镖,157:骑马,158:爬楼,159:放风筝,
 160:钓鱼
 冰雪运动
 161:雪橇,162:雪车,163:单板滑雪,164:雪上运动,165:高山滑雪,166:越野滑雪,167:冰壶,168:冰球,169:冬季两项
 水上运动（10种）
 170:冲浪,171:帆船,172:帆板,173:皮艇,174:摩托艇,175:划艇,176:赛艇,177:龙舟,178:水球,179:漂流,
 极限运动（5种）
 180:滑板,181:攀岩,182:蹦极,183:跑酷,184:BMX,
 kr01定制项目
 193:Outdoor Fun（户外玩耍）, 194:Other Activity（其他运动）
 计划类型：
 0x01：跑步计划3km ，0x02：跑步计划5km ， 0x03：跑步计划10km ，0x04：半程马拉松训练（二期） ，0x05：马拉松训练（二期）
 */
@property (nonatomic,assign) NSInteger sportType;

@end

#pragma mark ==== app 发起运动开始 ====
@interface IDOAppStartExchangeModel : IDONewDataExchangeModel
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

@end

#pragma mark ==== app 操作计划运动 ====
@interface IDOAppOperatePlanExchangeModel : IDONewDataExchangeModel

//0x01:开始运动 ，0x02：暂停运动 , 0x03:恢复运动 ，0x04：结束运动 0x05: 切换动作
@property (nonatomic,assign) NSInteger operate;

//训练的课程日期偏移 从0开始
@property (nonatomic,assign) NSInteger trainingOffset;
/**
 动作类型  1快走；2慢跑；3中速跑；4快跑  ；
 5结束课程运动 （还要等待用户是否有自由运动）；6课程结束后自由运动 （此字段当operate为0x05起作用）
 */
@property (nonatomic,assign) NSInteger actionType;
/**
 计划类型：0x01：跑步计划3km ，0x02：跑步计划5km ，
 0x03：跑步计划10km ，0x04：半程马拉松训练（二期） ，0x05：马拉松训练（二期）
 */
@property (nonatomic,assign) NSInteger planType;

//0x00:成功 其他失败
@property (nonatomic,assign) NSInteger errorCode;

@end

#pragma mark ==== ble 操作计划运动 ====
@interface IDOBleOperatePlanExchangeModel : IDONewDataExchangeModel
//0x01:开始运动 ，0x02：暂停运动 , 0x03:恢复运动 ，0x04：结束运动 ，0x05: 切换动作
@property (nonatomic,assign) NSInteger operate;
/**
 动作类型  1快走；2慢跑；3中速跑；4快跑  ；
 5结束课程运动 （还要等待用户是否有自由运动）；6课程结束后自由运动 （此字段当operate为0x05起作用）
 */
@property (nonatomic,assign) NSInteger actionType;
/**
 计划类型：0x01：跑步计划3km ，0x02：跑步计划5km ，
 0x03：跑步计划10km ，0x04：半程马拉松训练（二期） ，0x05：马拉松训练（二期）
 */
@property (nonatomic,assign) NSInteger planType;
//0x00:成功 其他失败
@property (nonatomic,assign) NSInteger errorCode;
//训练课程年份
@property (nonatomic,assign) NSInteger trainingYear;
//训练课程月份
@property (nonatomic,assign) NSInteger trainingMonth;
//训练课程日期
@property (nonatomic,assign) NSInteger trainingDay;
//动作目标时间  单位秒
@property (nonatomic,assign) NSInteger time;
//心率范围低值
@property (nonatomic,assign) NSInteger lowHeart;
//心率范围高值
@property (nonatomic,assign) NSInteger heightHeart;

@end

#pragma mark ==== ble 操作计划运动回复 ====
@interface IDOBleOperatePlanReplyExchangeModel : IDONewDataExchangeModel

//0x01:开始运动 ，0x02：暂停运动 , 0x03:恢复运动 ，0x04：结束运动，0x05: 切换动作
@property (nonatomic,assign) NSInteger operate;
/**
 动作类型  1快走；2慢跑；3中速跑；4快跑  ；
 5结束课程运动 （还要等待用户是否有自由运动）；6课程结束后自由运动 （此字段当operate为0x05起作用）
 */
@property (nonatomic,assign) NSInteger actionType;
/**
 计划类型：0x01：跑步计划3km ，0x02：跑步计划5km ，
 0x03：跑步计划10km ，0x04：半程马拉松训练（二期） ，0x05：马拉松训练（二期）
 */
@property (nonatomic,assign) NSInteger planType;

//0x00:成功 其他失败
@property (nonatomic,assign) NSInteger errorCode;

@end

#pragma mark ==== app 发起运动开始回复 ====
@interface IDOAppStartReplyExchangeModel : IDONewDataExchangeModel

/**
 * 0:成功; 1:设备已经进入运动模式失败;2: 设备电量低失败;3:手环正在充电4:正在使用Alexa 5:通话中
 * 0:success 1:into sport mode failed 2:Low power of equipment 3: the bracelet is charging 4:Using Alexa 5:In the call
 */
@property (nonatomic,assign) NSInteger retCode;

@end

#pragma mark ==== app 发起运动结束 ====
@interface IDOAppEndExchangeModel : IDONewDataExchangeModel
/**
 持续时间 (单位:秒钟) | durations
 */
@property (nonatomic,assign) NSInteger durations;
/**
 卡路里 (单位:J) | calories
 */
@property (nonatomic,assign) NSInteger calories;
/**
 距离 (单位:米) | distance
 */
@property (nonatomic,assign) NSInteger distance;
/**
 步数 (单位:步) | step
 */
@property (nonatomic,assign) NSInteger step;
/**
 是否存储 | is save
 */
@property (nonatomic,assign) BOOL isSave;

@end

#pragma mark ==== app 发起运动结束回复 ====
@interface IDOAppEndReplyExchangeModel : IDONewDataExchangeModel
/**
 0:成功; 1:设备已经进入运动模式失败 | 0:success 1:into sport mode failed
 */
@property (nonatomic,assign) NSInteger errorCode;
/**
 卡路里 (单位:J) | calories
 */
@property (nonatomic,assign) NSInteger calories;
/**
 距离 (单位:米) | distance
 */
@property (nonatomic,assign) NSInteger distance;
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

@end

#pragma mark ==== app 发起运动暂停回复 ====
@interface IDOAppPauseReplyExchangeModel : IDONewDataExchangeModel
/**
 0:成功; 1:设备已经进入运动模式失败 | 0:success 1:into sport mode failed
 */
@property (nonatomic,assign) NSInteger errorCode;

@end

#pragma mark ==== app 发起运动恢复回复 ====
@interface IDOAppRestoreReplyExchangeModel : IDONewDataExchangeModel
/**
 0:成功; 1:设备已经进入运动模式失败 | 0:success 1:into sport mode failed
 */
@property (nonatomic,assign) NSInteger errorCode;

@end

#pragma mark ==== app 发起运动蓝牙发起结束 ====
@interface IDOBleEndExchangeModel : IDONewDataExchangeModel
/**
 卡路里 (单位:J) | calories
 */
@property (nonatomic,assign) NSInteger calories;
/**
 距离 (单位:米) | distance
 */
@property (nonatomic,assign) NSInteger distance;
/**
 步数 (单位:步) | step
 */
@property (nonatomic,assign) NSInteger step;
/**
 是否存储 | is save
 */
@property (nonatomic,assign) BOOL isSave;
/**
 平均心率 | avg heart rate
 */
@property (nonatomic,assign) NSInteger avgHrValue;
/**
 最大心率 | max heart rate
 */
@property (nonatomic,assign) NSInteger maxHrValue;
/**
 脂肪燃烧时长 (分钟) | burn fat mins (mins)
 */
@property (nonatomic,assign) NSInteger burnFatMins;
/**
 有氧锻炼时长(分钟) | cardiopulmonary exercise mins
 */
@property (nonatomic,assign) NSInteger aerobicMins;
/**
 极限锻炼时长(分钟) | limit exercise mins
 */
@property (nonatomic,assign) NSInteger limitMins;

@end

#pragma mark ==== app 发起运动蓝牙发起结束回复 ====
@interface IDOBleEndReplyExchangeModel : IDONewDataExchangeModel
/**
 持续时间 (单位:秒钟) | durations
 */
@property (nonatomic,assign) NSInteger durations;
/**
 卡路里 (单位:J) | calories
 */
@property (nonatomic,assign) NSInteger calories;
/**
 距离 (单位:米) | distance
 */
@property (nonatomic,assign) NSInteger distance;
/**
 0:成功; 1:设备已经进入运动模式失败 | 0:success 1:into sport mode failed
 */
@property (nonatomic,assign) NSInteger errorCode;

@end

#pragma mark ==== ble 发起运动 ====
@interface IDOBleStartExchangeModel : IDONewDataExchangeModel
/**
 1 :请求app打开gps   2：发起运动请求
 */
@property (nonatomic,assign) NSInteger operate;

@end

#pragma mark ==== ble 发起运动app状态回复 ====
@interface IDOBleStartReplyExchangeModel : IDONewDataExchangeModel
/**
 * 0:成功; 1:设备已经进入运动模式失败;2: 设备电量低失败;3:手环正在充电4:正在使用Alexa 5:通话中
 * 0:success 1:into sport mode failed 2:Low power of equipment 3: the bracelet is charging 4:Using Alexa 5:In the call
 */
@property (nonatomic,assign) NSInteger retCode;

/**
 1 :请求app打开gps   2：发起运动请求
 */
@property (nonatomic,assign) NSInteger operate;

@end

#pragma mark ==== app 发起运动蓝牙发起暂停回复 ====
@interface IDOBlePauseReplyExchangeModel : IDONewDataExchangeModel
/**
 0:成功; 1:设备已经进入运动模式失败 | 0:success 1:into sport mode failed
 */
@property (nonatomic,assign) NSInteger errorCode;

@end

#pragma mark ==== app 发起运动蓝牙发起恢复回复 ====
@interface IDOBleRestoreReplyExchangeModel : IDONewDataExchangeModel
/**
 0:成功; 1:设备已经进入运动模式失败 | 0:success 1:into sport mode failed
 */
@property (nonatomic,assign) NSInteger errorCode;

@end

#pragma mark ==== v3数据交换中 ====
@interface IDOV3AppIngDataExchangeModel : IDONewDataExchangeModel
/**
 数据版本
 运动计划版本号为0x20,不需要传sportType
 */
@property (nonatomic,assign) NSInteger dataVersion;
/**
 持续时间 (单位:秒钟) | durations
 */
@property (nonatomic,assign) NSInteger durations;
/**
 卡路里 (单位:J) | calories
 */
@property (nonatomic,assign) NSInteger calories;
/**
 距离 (单位:米) | distance
 */
@property (nonatomic,assign) NSInteger distance;
/**
 * 信号强弱  0: 表示信号弱， 1: 表示信号强
 * Signal strength 0: means signal is weak, 1: means signal is strong
 */
@property (nonatomic,assign) NSInteger signalFlag;
/**
 * app计算显示实时速度 单位km/h 100倍 15秒一个记录
 * App calculates and displays real-time speed km/h 100 times
 */
@property (nonatomic,assign) NSInteger realTimeSpeed;

@end

#pragma mark ==== v3数据交换中回复 ====
@interface IDOV3AppIngReplyExchangeModel : IDONewDataExchangeModel
/**
 数据版本
 运动计划版本号为0x20
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
 平均公里配速
 */
@property (nonatomic,assign) NSInteger kmSpeed;
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
 无氧训练效果；  单位：无   范围 1.0 ~ 5.0 （*10倍）
 */
@property (nonatomic,assign) NSInteger anaerobicTrainingEffect;
/**
 有氧训练效果；  单位：无   范围 1.0 ~ 5.0 （*10倍）
 */
@property (nonatomic,assign) NSInteger trainingEffect;
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
 累计海拔上升 单位米
 功能表： __IDO_FUNCTABLE__.funcTable36Model.supportExchangeActivityGetAltitudeRiseLoss
 */
@property (nonatomic,assign) NSInteger cumulativeAltitudeRise;
/**
 累计海拔下降 单位米
 功能表： __IDO_FUNCTABLE__.funcTable36Model.supportExchangeActivityGetAltitudeRiseLoss
 */
@property (nonatomic,assign) NSInteger cumulativeAltitudeLoss;
/**
 GPS状态 0:无效 1:开启 2:未开启(未开启时展示`距离` 开启则展示`3D距离`)
 功能表： __IDO_FUNCTABLE__.funcTable36Model.supportExchangeActivityGetGpsStatus
 */
@property (nonatomic,assign) NSInteger gpsStatus;
/**
 平均速度 km/h 扩大100传
 */
@property (nonatomic,assign) NSInteger avgSpeed;


@end

#pragma mark ==== v2数据交换中 ====
@interface IDOV2AppIngDataExchangeModel : IDONewDataExchangeModel
/**
 status:0:全部有效, 1:距离无效， 2: gps 信号弱 | status 0:all effective 1:distance invalid 2:gps signal weak
 */
@property (nonatomic,assign) NSInteger status;
/**
 距离 (单位:米) | distance
 */
@property (nonatomic,assign) NSInteger distance;
/**
 卡路里 (单位:J) | calories
 */
@property (nonatomic,assign) NSInteger calories;
/**
 持续时间 (单位:秒钟) | durations
 */
@property (nonatomic,assign) NSInteger durations;

@end

#pragma mark ==== v2数据交换中回复 ====
@interface IDOV2AppIngReplyExchangeModel : IDONewDataExchangeModel
/**
 status:0:全部有效, 1:距离无效， 2: gps 信号弱 | status 0:all effective 1:distance invalid 2:gps signal weak
 */
@property (nonatomic,assign) NSInteger status;
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

#pragma mark ==== 心率数据交换 ====
@interface IDOHrDataExchangeModel : IDONewDataExchangeModel
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

@end

#pragma mark ==== v3运动结束数据交换 ====
@interface IDOV3SportEndDataExchangeModel : IDONewDataExchangeModel
/**
 年份
 */
@property (nonatomic,assign) NSInteger year;
/**
月份
 */
@property (nonatomic,assign) NSInteger month;
/**
 数据版本
 运动计划版本号为0x20
 */
@property (nonatomic,assign) NSInteger dataVersion;
/**
 计划类型：
 0x01：跑步计划3km ，0x02：跑步计划5km ，
 0x03：跑步计划10km ，0x04：半程马拉松训练（二期） ，0x05：马拉松训练（二期）
 */
@property (nonatomic,assign) NSInteger planType;
 /**
 心率间隔 | heart rate interval
 */
@property (nonatomic,assign) NSInteger intervalSecond;
/**
 步数 (单位:步) | step
 */
@property (nonatomic,assign) NSInteger step;
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

/**
 3d距离 单位m
 */
@property (nonatomic,assign) NSInteger distance3d;
/**
 平均3d速度 单位km/h ，PS：app收到需要 除于100，保存2位小数点。
 */
@property (nonatomic,assign) NSInteger avg3dSpeed;
/**
 平均垂直速度 单位m/h，PS：app收到需要 除于100，保存2位小数点。
 */
@property (nonatomic,assign) NSInteger avgVerticalSpeed;
/**
 平均坡度        单位度 0 ~ 90
 */
@property (nonatomic,assign) NSInteger avgSlope;
/**
 最高海拔高度 单位米 -500 ~ 9000
 */
@property (nonatomic,assign) NSInteger maxAltitude;
/**
 最低海拔高度 单位米 -500 ~ 9000
 */
@property (nonatomic,assign) NSInteger minAltitude;
/**
 累计海拔上升 单位米
 */
@property (nonatomic,assign) NSInteger cumulativeAltitudeRise;
/**
 累计海拔下降 单位米
 */
@property (nonatomic,assign) NSInteger cumulativeAltitudeLoss;
/**
 海拔高度详情个数
 */
@property (nonatomic,assign) NSInteger altitudeCount;
/**
 海拔高度数据 30s一组值 单位米 范围-500~9000 最大保存12小时
 */
@property (nonatomic,strong) NSMutableArray<NSNumber *> * altitudeItems;

/**
 平均海拔高度 单位米 -500 ~ 9000
 */
@property (nonatomic,assign) NSInteger avgAltitude;


//--------------- version=0x50新增字段 ---------------

/**
 GPS状态 0:无效 1:开启 2:未开启(未开启时展示`距离` 开启则展示`3D距离`)
 */
@property (nonatomic,assign) NSInteger gpsStatus;
/**
 无氧训练效果 单位：无 范围： 1.0 - 5.0（扩大10倍传输）
 */
@property (nonatomic,assign) NSInteger anaerobicTrainingEffect;
/**
 负荷 无单位
 */
@property (nonatomic,assign) NSInteger load;
/**
 跑力指数 一位小数 x10传输
 */
@property (nonatomic,assign) NSInteger runningEconomy;
/**
 最大跑步功率 单位瓦 0-1500W
 */
@property (nonatomic,assign) NSInteger maxRunningPower;
/**
 最小跑步功率 单位瓦 0-1500W
 */
@property (nonatomic,assign) NSInteger minRunningPower;
/**
 平均跑步功率 单位瓦 0-1500W
 */
@property (nonatomic,assign) NSInteger avgRunningPower;
/**
 跑步功率详情个数
 */
@property (nonatomic,assign) NSInteger runningPowerCount;
/**
 实时体力RTPE(real-time physical exertion)详情个数
 */
@property (nonatomic,assign) NSInteger rtpeCount;
/**
 最大实时摄氧量
 */
@property (nonatomic,assign) NSInteger maxRtoc;
/**
 最小实时摄氧量
 */
@property (nonatomic,assign) NSInteger minRtoc;
/**
 平均实时摄氧量
 */
@property (nonatomic,assign) NSInteger avgRtoc;
/**
 实时摄氧量RTOC(real-time oxygen consumption)详情个数
 */
@property (nonatomic,assign) NSInteger rtocCount;
/**
 最快跳绳频率
 */
@property (nonatomic,assign) NSInteger maxRopeFrequency;
/**
 最慢跳绳频率
 */
@property (nonatomic,assign) NSInteger minRopeFrequency;
/**
 平均跳绳频率
 */
@property (nonatomic,assign) NSInteger avgRopeFrequency;
/**
 最多跳绳连跳次数
 */
@property (nonatomic,assign) NSInteger maxRopeSkipCount;
/**
 绊绳次数
 */
@property (nonatomic,assign) NSInteger ropeTripCount;
/**
 总跳绳次数
 */
@property (nonatomic,assign) NSInteger totalRopeCount;
/**
 跳绳详情个数
 */
@property (nonatomic,assign) NSInteger ropeItemCount;

/**
 跑步功率详情 单位瓦 0-1500W
 */
@property (nonatomic,strong) NSMutableArray<NSNumber *> * runningPowerItems;
/**
 实时体力RTPE(real-time physical exertion)详情 0-100百分比
 */
@property (nonatomic,strong) NSMutableArray<NSNumber *> * rtpeItems;
/**
 实时摄氧量RTOC(real-time oxygen consumption)详情 0-9999 单位ml/min
 */
@property (nonatomic,strong) NSMutableArray<NSNumber *> * rtocItems;
/**
 跳绳详情
 每次连跳次数:  rope_skip_count;
 时长 单位秒: duration;
 */
@property (nonatomic,strong) NSMutableArray<NSDictionary *> * ropeItems;

/**
  0:无效 1:非智能陪跑运动 2:智能陪跑运动
  0: Invalid 1: Non intelligent running sports 2: Intelligent running sports
 */
@property (nonatomic,assign) NSInteger smartCompetitor;

/**
 ai形象ID
 AI Image ID
 */
@property (nonatomic,assign) NSInteger aiImageId;

/**
 用户形象ID
 user image id
 */
@property (nonatomic,assign) NSInteger userImageId;

/**
 背景形象ID
 bg image id
 */
@property (nonatomic,assign) NSInteger bgImageId;

/**
 智能陪跑对手配速
 Intelligent companion running at opponent's pace
 */
@property (nonatomic,assign) NSInteger smartCompetitorPace;

@end

NS_ASSUME_NONNULL_END
