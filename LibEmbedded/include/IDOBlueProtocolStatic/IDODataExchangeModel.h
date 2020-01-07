//
//  IDODataExchangeModel.h
//  IDOBluetooth
//
//  Created by apple on 2018/10/5.
//  Copyright © 2018年 apple. All rights reserved.
//

#if __has_include(<IDOBluetoothInternal/IDOBluetoothInternal.h>)
#elif __has_include(<IDOBlueProtocol/IDOBlueProtocol.h>)
#else
#import "IDOBluetoothBaseModel.h"
#endif

@interface IDODataExchangeModel : IDOBluetoothBaseModel
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
 运动类型 | sport type
 * 0:无，1:走路，2:跑步，3:骑行，4:徒步，5:游泳，6:爬山，7:羽毛球，8:其他，
 * 9:健身，10:动感单车，11:椭圆机，12:跑步机，13:仰卧起坐，14:俯卧撑，15:哑铃，16:举重，
 * 17:健身操，18:瑜伽，19:跳绳，20:乒乓球，21:篮球，22:足球 ，23:排球，24:网球，
 * 25:高尔夫球，26:棒球，27:滑雪，28:轮滑，29:跳舞，48:户外跑步，49:室内跑步，50:户外骑行，51:室内骑行，
 * 52:户外走路，53:室内走路，54:泳池游泳，55:开放水域游泳，56:椭圆机，57:划船机，58:高强度间歇训练法
 * 0: none, 1: walk, 2: run, 3: ride, 4: hike, 5: swim, 6: climb, 7: badminton, 8: others,
 * 9: fitness, 10: spinning, 11: elliptical, 12: treadmill, 13: sit-ups, 14: push-ups, 15: dumbbells, 16: weightlifting,
 * 17: aerobics, 18: yoga, 19: jump rope, 20: table tennis, 21: basketball, 22: football, 23: volleyball, 24: tennis,
 * 25: golf, 26: baseball, 27: skiing, 28: roller skating, 29: dancing，48: outdoor running, 49: indoor running, 50: outdoor cycling, 51: indoor cycling,
 * 52: outdoor walking, 53: indoor walking, 54: pool swimming, 55: open water swimming, 56: elliptical machine, 57: rowing machine, 58: high-intensity interval training
 */
@property (nonatomic,assign) NSInteger sportType;
/**
 目标类型 | target type
 */
@property (nonatomic,assign) NSInteger targetType;
/**
 目标数值 | target value
 */
@property (nonatomic,assign) NSInteger targetValue;
/**
 是否强制开始 | is mandatory start
 */
@property (nonatomic,assign) NSInteger forceStart;
/**
 * 0:成功; 1:设备已经进入运动模式失败;2: 设备电量低失败;3:手环正在充电
 * 0:success 1:into sport mode failed 2:Low power of equipment 3: the bracelet is charging
 */
@property (nonatomic,assign) NSInteger retCode;
/**
 status:0:全部有效， 1:距离无效， 2: gps 信号弱 | status 0:all effective 1:distance invalid 2:gps signal weak
 */
@property (nonatomic,assign) NSInteger status;
/**
 0:成功; 1:设备已经进入运动模式失败 | 0:success 1:into sport mode failed
 */
@property (nonatomic,assign) NSInteger errorCode;
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
 持续时间 (单位:分钟) | durations
 */
@property (nonatomic,assign) NSInteger durations;
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
 心肺锻炼时长(分钟) | cardiopulmonary exercise mins
 */
@property (nonatomic,assign) NSInteger aerobicMins;
/**
 极限锻炼时长(分钟) | limit exercise mins
 */
@property (nonatomic,assign) NSInteger limitMins;
/**
 当前心率 | current heart rate
 */
@property (nonatomic,assign) NSInteger curHrValue;
/**
 心率间隔 | heart rate interval
 */
@property (nonatomic,assign) NSInteger intervalSecond;
/**
 序列号 | heart rate value serial
 */
@property (nonatomic,assign) NSInteger hrValueSerial;
/**
 心率数据 | heart rate data
 */
@property (nonatomic,copy) NSArray<NSNumber *> * hrValues;

@end
