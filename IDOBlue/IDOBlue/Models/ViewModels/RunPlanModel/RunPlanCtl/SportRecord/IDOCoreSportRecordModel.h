//
//  IDOCoreSportRecordModel.h
//  IDOCoreResources
//
//  Created by 农大浒 on 2020/9/3.
//  Copyright © 2020 xiongze. All rights reserved.
//

#import <Foundation/Foundation.h>
// 数据发起终端类型：1APP应用 2手环手表设备 3App发起，设备联动 4 设备发起APP联动
typedef enum : NSUInteger {
    IDOSportSourceOnlyAPP = 1,
    IDOSportSourceOnlyDevice,
    IDOSportSourceAPPLinkageDevice,
    IDOSportSourceDeviceLinkageAPP
} IDOSportSourceType;

NS_ASSUME_NONNULL_BEGIN

@interface IDOCoreSportRecordModel : NSObject

/**
 用户的ID
 */
@property (nonatomic, copy) NSString *userId;

/**
 是否已经上传服务器
 */
@property (nonatomic, assign) BOOL isUpload;

///日期，yyyy-MM-dd
@property (nonatomic, copy)  NSString *date;

///日期时间戳,秒
@property (nonatomic, assign)  NSInteger dateTimestamp;
///手环同步到数据库的时间戳,单位毫秒
@property (nonatomic, assign) NSInteger timestamp;
/**
 数据源设备MAC地址：
 */
@property (nonatomic, copy) NSString *sourceMac;

/**
 设备名称
 */
@property (nonatomic, copy) NSString *deviceName;

/**
 数据来源系统，(1IOS 2Android 3Other)：
 */
@property (nonatomic, assign) NSInteger sourceOs;

/**
 数据产生的时间,格式：yyyy-MM-dd HH:mm:ss
 */
@property (nonatomic, copy) NSString *datetime;

/**
 运动类型，整型
 */
@property (nonatomic, assign) NSInteger type;

/**
 *  运动子类型 游泳数据类型 非游泳类型必须置0
 */
@property (nonatomic, assign) NSInteger subType;

/**
 运动总时长，秒
 */
@property (nonatomic, assign) NSInteger totalSeconds;

/**
 运动总消耗卡路里，卡
 */
@property (nonatomic, assign) NSInteger numCalories;

/**
 运动总步数
 */
@property (nonatomic, assign) NSInteger numSteps;

/**
 运动总距离,米
 */
@property (nonatomic, assign) NSInteger distance;

/**
 运动开始时间，格式：yyyy-MM-dd HH:mm:ss
 */
@property (nonatomic, copy) NSString *startTime;

/**
 运动结束时间，格式：yyyy-MM-dd HH:mm:ss
 */
@property (nonatomic, copy) NSString *endTime;

/**
 运动秒类型，范围0-4    类型：0未设置 1步数 2距离 3卡路里 4总时长
 */
@property (nonatomic, assign) NSInteger targetType;

/**
 运动目标值
 */
@property (nonatomic, assign) NSInteger targetValue;

/**
 热身时长,秒
 */
@property (nonatomic, assign) NSInteger warmupSeconds;

/**
 燃脂时长，秒
 */
@property (nonatomic, assign) NSInteger burnFatSeconds;

/**
 有氧时长，秒
 */
@property (nonatomic, assign) NSInteger aerobicSeconds;

/**
 无氧时长，秒
 */
@property (nonatomic, assign) NSInteger anaerobicSeconds;

/**
 极限时长，秒
 */
@property (nonatomic, assign) NSInteger extremeSeconds;

/**
 最小心率值：范围：0-220
 */
@property (nonatomic, assign) NSInteger minHrValue;

/**
 最大心率值：范围：0-220
 */
@property (nonatomic, assign) NSInteger maxHrValue;

/**
 平均心率值：范围：0-220
 */
@property (nonatomic, assign) NSInteger avgHrValue;

/**
 是否含轨迹：（1是 0否）
 */
@property (nonatomic, assign) NSInteger isLocus;

/**
 数据发起终端类型：1APP应用 2手环手表设备 3App发起，设备联动 4 设备发起APP联动
 */
@property (nonatomic, assign) IDOSportSourceType sourceType;

/**
 最小速度：
 */
@property (nonatomic, assign) NSInteger minSpeed;

/**
 最大速度：
 */
@property (nonatomic, assign) NSInteger maxSpeed;

/**
 平均速度
 */
@property (nonatomic, assign) NSInteger avgSpeed;

/**
 平均频率/步频
 */
@property (nonatomic, assign) NSInteger avgRate;

/**
 *  最小频率/步频
 */
@property (nonatomic, assign) NSInteger minRate;

/**
 *  最大频率/步频
 */
@property (nonatomic , assign) NSInteger maxRate;
@property (nonatomic, assign) NSInteger stepRate;

/**
(平均)步幅：
 */
@property (nonatomic, assign) NSInteger stepRange;

/**
 最小配速：
 */
@property (nonatomic, assign) NSInteger minPace;

/**
 最大配速：
 */
@property (nonatomic, assign) NSInteger maxPace;

/**
 平均配速
 */
@property (nonatomic, assign) NSInteger avgPace;


/**
 游泳姿势类型：(0无设置 1自由泳 2蛙泳 3仰泳 4蝶泳 5xxx)
 */
@property (nonatomic, assign) NSInteger swType;

/**
 游泳划水次数
 */
@property (nonatomic, assign) NSInteger swHitNums;

/**
 泳池长度（距离）
 */
@property (nonatomic, assign) NSInteger swPoolLength;

/**
 有用趟数
 */
@property (nonatomic, assign) NSInteger swTrips;

/**
 最小swolf（游泳效率）
 */
@property (nonatomic, assign) NSInteger minSwolfValue;

/**
 最大swolf（游泳效率
 */
@property (nonatomic, assign) NSInteger maxSwolfValue;

/**
 平均swolf（游泳效率）
 */
@property (nonatomic, assign) NSInteger avgSwolfValue;

/**
 总游泳时长  (单位:s),  若是0，有可能是固件不支持 | Total swimming time (unit:s) ，If it is 0, it is possible that the firmware does not support it
 */
@property (nonatomic,assign) NSInteger totalDuration;

/**
 总休息时长 (单位:s) ，若是0，有可能是固件不支持  | Total rest time (unit:s)，If it is 0, it is possible that the firmware does not support it
 */
@property (nonatomic,assign) NSInteger totalRestTime;

/**
 *  轨迹来源（0无轨迹 1app 2固件）
 */
@property (nonatomic, assign) NSInteger gpsSourceType;

/**
 <##>GPS轨迹 样本数据细项：
 
 "gps": {
     "interval": 1,时间间隔
     "items": "[[22.686400282118054,113.98086832682291,3000.0],[22.686400282118054,113.98086832682291,4000.0],[22.686400282118054,113.98086832682291,3000.0]]"/
 },
 
  //第一、二参数是经纬度数据
  //第三个参数是时间戳
 // 第四个参数 海拔
 
 */
@property (nonatomic, strong) NSDictionary *gps;

/**
心率 原始数据细项：
 "heartrate": {
     "items": "[85,85,85,85,85,85,85,85,85,85,85,85,85]"
 },
 
 */
@property (nonatomic, strong) NSDictionary *heartrate;

/**
 步频 原始数据细项：
 "rate": {
     "items": "[2,3,2,3,2,3,2,3,2,1,2]"
 },
 
 */
@property (nonatomic, strong) NSDictionary *rate;

/**
 步幅 样本数据细项
 "range": {
     "items": "[23,24,25,26,27,28,29,30]"
 },
 */
@property (nonatomic, strong) NSDictionary *range;


/**
 配速 样本数据细项
 "pace": {
     "items": "[1150,2000,3000,4000,5000]"
 },
 */
@property (nonatomic, strong) NSDictionary *pace;

/**
 游泳效率 游泳配速 游泳频率  样本数据细项 ：
 "swolf": {
     "items": [{"duration":123,"strokesNumber":123,"swolf":123,"frequency":123,"speed":123,"differenceTime":123,"stopTime":123}]
 }
 */
@property (nonatomic, strong) NSDictionary *swolf;


/**
 服务器存储当前数据的标识
 */
@property (nonatomic, copy) NSString *sid;

/**
 运动的icon
 */
@property (nonatomic, copy) NSString *icon;

/**
 *  是否简化数据
 */
@property (nonatomic , assign)  BOOL isSimpleData;

/**
 *  是否上传Strava 2021-06-04  修改之前鲁晓的bool改成NSInteger，因为今天测试的时候发现bool值的时候无法传值 --- nongdahu
 */
@property (nonatomic, assign) NSInteger uploadedStrava;


#pragma mark - add by nongdahu 2021-09-27 据说这几个是给多运动使用

/**
 心率区间
 */
@property (nonatomic, assign) NSInteger heartRateZone;

/**
 累积爬升
 */
@property (nonatomic, assign) NSInteger cumulativeClimb;

/**
 累计下降
 */
@property (nonatomic, assign) NSInteger cumulativeDecline;

/**
 训练效果，当前传值是乘以10，所以在显示的情况下，需要除于10
 */
@property (nonatomic, assign) CGFloat trainingEffectScore;

/**
 最大摄氧量
 */
@property (nonatomic, assign) NSInteger maximalOxygenUptake;

/**
 最大摄氧量等级
 */
@property (nonatomic, assign) NSInteger oxygenLevel;

/**
 是否支持训练效果
 */
@property (nonatomic, assign) NSInteger isSupportTrainingEffect;

/**
 恢复日期时间，格式：yyyy-MM-dd HH:mm:ss
 */
@property (nonatomic, copy) NSString *recoveDatetime;
//
///**
// 最低海拔，单位米
// */
//@property (nonatomic, copy) NSString *lowestAltitude;
//
///**
// 最高海拔，单位米
// */
//@property (nonatomic, copy) NSString *highestAltitude;

/**
 数据来源，PRO：代表来自pro同步；FIT：代表veryFit正常上报（可为空，默认为fit上报）
 */
@property (nonatomic, copy) NSString *syncDataType;

/**
 * 安卓那边定义的数据存放格式 ---
 * 跑步计划相关的数据,目前里面包含的参数如下，
 *
 *   [{"actual_time":60,"goal_time":60,"low_heart":0,"type":1},{"actual_time":60,"goal_time":60,"low_heart":22,"type":2},{"actual_time":60,"goal_time":60,"low_heart":100,"type":1},{"actual_time":60,"goal_time":60,"low_heart":27,"type":2},{"actual_time":60,"goal_time":60,"low_heart":100,"type":1},{"actual_time":65533,"goal_time":0,"low_heart":32,"type":5}]

 */
@property (nonatomic,copy) NSString *runningPullUp;

/*
 *
 *计划类型：1：跑步计划3km ，2：跑步计划5km ，3：跑步计划10km ， 4：半程马拉松训练（二期） ，5：马拉松训练（二期）
 *64 : 6分钟轻松跑 , 65：10分钟轻松跑  ，66：15分钟轻松跑 ，67：走跑结合初级 ，68：走跑结合进阶 ，69：走跑结合强化
 *128: 跑后拉伸 129 跑前热身
 *
 *
 *这个参数要起作用，type == 0，如果type > 0 的时候，planType 不起作用
 */
@property (nonatomic,assign) NSInteger actType;

/**
 动作完成率
 */
@property (nonatomic,assign) NSInteger completionRate;

/**
 课程内的卡路里
 */
@property (nonatomic,assign) NSInteger inClassCalories;

/**
 心率控制率
 */
@property (nonatomic,assign) NSInteger hrCompletionRate;

/**
 热身表现 0-100 需要功能表支持,bool supportWarmUpBeforeRun; //支持跑前热身
 */
@property (nonatomic,assign) NSInteger warmUpPerformance;

/**
 摄氧量等级  1:低等   2:业余   3:一般  4：平均    5：良好  6：优秀   7：专业
 */
@property (nonatomic,assign) NSInteger maximalOxygenLevel;

/**
 海拔的数据详情
 [[@"0",@"145.3"],[@"120",@"145.3"],[@"200",@"145.3"]]

 */
@property (nonatomic,copy) NSString *altitudeDetails;


/**
 实时步频的数据详情,json字符串
  “{
     "interval": 5,秒
     "items": "[100，200,300,400]"/
 }”

 */
@property (nonatomic,copy) NSString *currentTimeStrideRate;

/**
 实时配速的数据详情,json字符串
  “{
     "interval": 5,秒
     "items": "[100，200,300,400]"/
 }”

 */
@property (nonatomic,copy) NSString *currentTimePace;

/**
 实时速度的数据详情,json字符串
  “{
     "interval": 5,秒
     "items": "[100，200,300,400]"/
 }”
 */
@property (nonatomic,copy) NSString *currentTimeSpeed;

///IDOSportIconStyle 0:默认图标, 1第二套图标（IDW05）
@property (nonatomic,assign) NSInteger iconType;

///**
// 运动强度
// */
//@property (nonatomic,assign) NSString *exerciseIntensity;
/**
 踏频数据
 */
@property (nonatomic , strong) NSArray *cadenceItems;
/**
 踏频数据个数
 */
@property (nonatomic , assign) NSInteger cadenceCount;

/**
 桨次数组 一分钟保存一次
 */
@property (nonatomic,strong) NSArray * paddleNumberItems;

/**
 桨频数组 一分钟保存一次 存平均值
 */
@property (nonatomic,strong) NSArray * paddleFrequencyItems;

/**
 3d距离 单位km
 */
@property (nonatomic,assign) NSInteger distance3d;
/**
 平均3d速度 单位km/h
 */
@property (nonatomic,assign) NSInteger avg3dSpeed;
/**
 平均垂直速度 单位m/h
 */
@property (nonatomic,assign) NSInteger avgVerticalSpeed;

/**
 平均坡度        单位度 0 ~ 90
 */
@property (nonatomic,assign) NSInteger avgSlope;
/**
 最高海拔高度 单位米 -500 ~ 9000
 */
@property (nonatomic,assign) NSInteger highestAltitude;
/**
 最低海拔高度 单位米 -500 ~ 9000
 */
@property (nonatomic,assign) NSInteger lowestAltitude;
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
@property (nonatomic,strong) NSArray<NSNumber *> * altitudeItems;
/**
 海拔 原始数据细项：
 "altitudeItemsDic": {
     "items": "[85,85,85,85,85,85,85,85,85,85,85,85,85]"
 },
 
 */
@property (nonatomic, strong) NSDictionary *altitudeItemsDic;
/**
 平均海拔高度 单位米 -500 ~ 9000
 */
@property (nonatomic,assign) NSInteger avgAltitude;

/**
 GPS状态 0:无效 1:开启 2:未开启(未开启时展示`距离` 开启则展示`3D距离`)
 */
@property (nonatomic,assign) NSInteger gpsStatus;

@end

NS_ASSUME_NONNULL_END
