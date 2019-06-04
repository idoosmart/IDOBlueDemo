//
//  IDODataExchangeModel.h
//  IDOBluetooth
//
//  Created by apple on 2018/10/5.
//  Copyright © 2018年 apple. All rights reserved.
//

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
 0:成功; 1:设备已经进入运动模式失败;2: 设备电量低失败 | 0:success 1:into sport mode failed 2:Low power of equipment
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


/**
 * @brief 根据结构体数据和事件类型为当前model赋值 （内部使用）
 * Assign values to the current model based on structure data and event type (internal use)
 * @param data 结构体数据 | Structure data
 * @param model 当前运动model | current sports model
 * @param type 事件类型 | Event type
 * @return IDODataExchangeModel
 */
+ (__kindof IDODataExchangeModel *)dataExchangeStructToModel:(void *)data
                                                currentModel:(IDODataExchangeModel *)model
                                                        type:(int)type;
/**
 * @brief model构建发送运开始命令结构体数据 （内部使用）|  model builds the transport start command structure data
 * @param data 运动开始命令的结构体数据 |  structure data of commands in sport start
 */
- (void)dataExchangeStartModelToStructure:(void *)data
                                     type:(int)type;

@end
