//
//  IDOSyncV3ActivityDataModel.h
//  IDOBlueProtocol
//
//  Created by hedongyang on 2020/6/1.
//  Copyright © 2020 何东阳. All rights reserved.
//

#if __has_include(<IDOBlueProtocol/IDOBlueProtocol.h>)
#else
#import "IDOBluetoothBaseModel.h"
#endif

@interface IDOSyncV3ActivityDataInfoBluetoothModel : IDOBluetoothBaseModel

/**
 年份 | Year
 */
@property (nonatomic,assign) NSInteger year;

/**
 月份 | Month
 */
@property (nonatomic,assign) NSInteger month;

/**
 日期 | Date
 */
@property (nonatomic,assign) NSInteger day;

/**
 时 | hour
 */
@property (nonatomic,assign) NSInteger hour;

/**
 分 | minutes
 */
@property (nonatomic,assign) NSInteger minute;

/**
 秒 | seconds
 */
@property (nonatomic,assign) NSInteger second;

/**
 日期 精确到日期 date interval since 1970 (如:1444361933) | Date time interval since 1970 (eg 14442361933)
 */
@property (nonatomic,copy) NSString * dateStr;

/**
 开始时间 精确到秒 | start time interval since 1970 (eg 14442361933)
 */
@property (nonatomic,copy) NSString * timeStr;

/**
 数据长度 | Data length
 */
@property (nonatomic,assign) NSInteger  dataLength;

/**
 心率数据产生间隔 (单位 : s) | Heart rate data generation interval (unit: s)
 */
@property (nonatomic,assign) NSInteger hrInterval;

/**
 心率项数据个数 | Heart rate item data
 */
@property (nonatomic,assign) NSInteger  hrItemCount;

/**
 包的总数 | Total number of packages
 */
@property (nonatomic,assign) NSInteger  packetCount;

/*
 * 运动模式 | Sport mode
 * 0:无，1:走路，2:跑步，3:骑行，4:徒步，5:游泳，6:爬山，7:羽毛球，8:其他，
 * 9:健身，10:动感单车，11:椭圆机，12:跑步机，13:仰卧起坐，14:俯卧撑，15:哑铃，16:举重，
 * 17:健身操，18:瑜伽，19:跳绳，20:乒乓球，21:篮球，22:足球 ，23:排球，24:网球，
 * 25:高尔夫球，26:棒球，27:滑雪，28:轮滑，29:跳舞，31：室内划船/roller machine， 32：普拉提/pilates， 33:交叉训练/cross train,
 * 34:有氧运动/cardio，35：尊巴舞/Zumba, 36:广场舞/square dance, 37:平板支撑/Plank, 38:健身房/gym 48:户外跑步，49:室内跑步，
 * 50:户外骑行，51:室内骑行，52:户外走路，53:室内走路，54:泳池游泳，55:开放水域游泳，56:椭圆机，57:划船机，58:高强度间歇训练法，75:板球运动
 基础运动：
 100：自由训练，101：功能性力量训练，102：核心训练，103：踏步机，104：整理放松
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
 */
@property (nonatomic,assign) NSInteger type;

/**
 *计划类型：1：跑步计划3km ，2：跑步计划5km ，3：跑步计划10km ， 4：半程马拉松训练（二期） ，5：马拉松训练（二期）
 *64 : 6分钟轻松跑 , 65：10分钟轻松跑  ，66：15分钟轻松跑 ，67：走跑结合初级 ，68：走跑结合进阶 ，69：走跑结合强化
 *128: 跑后拉伸
 */
@property (nonatomic,assign) NSInteger planType;

/**
 步数(骑行 时，步数为 0) | Number of steps (when riding, the number of steps is 0)
 */
@property (nonatomic,assign) NSInteger step;

/**
 持续时长 (单位:s) | Duration (unit: s)
 */
@property (nonatomic,assign) NSInteger durations;

/**
 卡路里(单 位:大卡) | Calories (Unit: Big Card)
 */
@property (nonatomic,assign) NSInteger calories;

/**
 距离(单位: 米) | Distance (in meters)
 */
@property (nonatomic,assign) NSInteger distance;

/**
 平均心率 | Average heart rate
 */
@property (nonatomic,assign) NSInteger  avgHrValue;

/**
 最大心率 | Maximum heart rate
 */
@property (nonatomic,assign) NSInteger  maxHrValue;

/**
 脂肪燃烧时长 | Fat burning time
 */
@property (nonatomic,assign) NSInteger burnFatMins;

/**
 心肺锻炼时长 [有氧运动时长] (分钟) | Cardio workout time (minutes)
 */
@property (nonatomic,assign) NSInteger aerobicMins;

/**
 极限锻炼时长 (分钟) | Extreme workout time (minutes)
 */
@property (nonatomic,assign) NSInteger limitMins;

/**
 无氧锻炼时长 (分钟) | Anaerobic workout time (minutes)
 */
@property (nonatomic,assign) NSInteger anaerobicMins;

/**
 热身锻炼时长 (分钟) | Warm up workout time (minutes)
 */
@property (nonatomic,assign) NSInteger warmUpMins;

/**
 有序列号的心率集合 json字符串 | Heart rate collection with serial number json string
 */
@property (nonatomic,copy) NSArray  * hrValuesStr;

/**
 每分钟保存数据集合 json字符串 最大保存6小时 | Save the data  of minute for a maximum of 6 hours
 @{@"steps":@(steps),@"calories":@(calories),@"distance":@(distance)}
 */
@property (nonatomic,copy) NSArray  * dataValuesStr;

/**
 是否需要保存数据 (用于数据交换) | Do you need to save data (for data exchange)
 */
@property (nonatomic,assign) BOOL isSave;

/**
 *0:无效， 1 : app发起的运动， 2：手表发起的运动
 */
@property (nonatomic,assign) NSInteger startFrom;

/*
 平均速度
 avg speed
 */
@property (nonatomic,assign) NSInteger avgSpeed;

/*
最大速度
max speed
*/
@property (nonatomic,assign) NSInteger maxSpeed;

/**
 平均配速
 avg km speed
 */
@property (nonatomic,assign) NSInteger avgKmSpeed;

/**
 最快配速
 fast km speed
 */
@property (nonatomic,assign) NSInteger fastKmSpeed;

/*
平均步频
avg step frequency
*/
@property (nonatomic,assign) NSInteger avgStepFrequency;

/*
最大步频
max step frequency
*/
@property (nonatomic,assign) NSInteger maxStepFrequency;

/*
平均步幅
avg step stride
*/
@property (nonatomic,assign) NSInteger avgStepStride;

/*
最大步幅
max step stride
*/
@property (nonatomic,assign) NSInteger maxStepStride;

/**
 热身锻炼时长 (秒钟) | Warm-up time (seconds)
 */
@property (nonatomic,assign) NSInteger warmUpHrTime;

/**
 脂肪锻炼时长 (秒钟) | Fat workout Duration (seconds)
 */
@property (nonatomic,assign) NSInteger burnFatHrTime;

/**
 心肺锻炼时长 (秒钟)  | Cardio duration (seconds)
 */
@property (nonatomic,assign) NSInteger aerobicHrTime;

/**
 无氧锻炼时长 (秒钟) | Duration of anaerobic exercise (seconds)
 */
@property (nonatomic,assign) NSInteger anaerobicHrTime;

/**
 极限锻炼时长 (秒钟) | Extreme workout Duration (seconds)
 */
@property (nonatomic,assign) NSInteger limitHrTime;

/**
  每公里的配速集合json，最大公里数100公里 s钟数据传输 一公里用了多少s
  Seconds per kilometer
 */
@property (nonatomic,strong)  NSArray * kmSpeedItems;

/**
  步频集合
  frequency items
 */
@property (nonatomic,strong)  NSArray * frequencyItems;

/**
 每英里的配速集合json
 */
@property (nonatomic,strong) NSArray * mileSpeedItems;

/**
 *手环是否连接app  1是连接，0是未连接
 *Whether the bracelet is connected to APP 1 is connected, 0 is not connected
 */
@property (nonatomic,assign) NSInteger connectApp;

/**
 平均配速 传过来的是s钟， 比如361  361/60=6分 余数是1s  6''1'  , 公里和英里是按照 英里= 公里*1609/1000f
 */
@property (nonatomic,assign) NSInteger avgPaceSpeed;

/**
 最快配速
 */
@property (nonatomic,assign) NSInteger fastPaceSpeed;

/**
 训练效果；  单位：无   范围 1.0 ~ 5.0 （*10倍）
 */
@property (nonatomic,assign) NSInteger trainingEffect;

/**
 最大摄氧量；  单位：毫升/公斤/分钟； 范围  0-80
 */
@property (nonatomic,assign) NSInteger vo2Max;

/**
 恢复时间点年
 */
@property (nonatomic,assign) NSInteger recoveryTimeYear;

/**
 恢复时间点月
 */
@property (nonatomic,assign) NSInteger recoveryTimeMon;

/**
 恢复时间点日
 */
@property (nonatomic,assign) NSInteger recoveryTimeDay;

/**
 恢复时间点时
 */
@property (nonatomic,assign) NSInteger recoveryTimeHour;

/**
 恢复时间点分
 */
@property (nonatomic,assign) NSInteger recoveryTimeMin;

/**
 恢复时间点秒
 */
@property (nonatomic,assign) NSInteger recoveryTimeSecond;

/**
 运动结束时间 月
 */
@property (nonatomic,assign) NSInteger endMonth;

/*
 运动结束时间 日
 */
@property (nonatomic,assign) NSInteger endDay;

/**
 运动结束时间 时
 */
@property (nonatomic,assign) NSInteger endHour;

/**
 运动结束时间 分
 */
@property (nonatomic,assign) NSInteger endMinute;

/**
 最少心率值
 */
@property (nonatomic,assign) NSInteger minHrValue;

/**
 实时配速数组  传过来的是 s 钟  每5s算一次
 */
@property (nonatomic,strong) NSArray * paceSpeedItems;

/**
 桨次数组 一分钟保存一次
 */
@property (nonatomic,strong) NSArray * paddleNumberItems;

/**
 桨频数组 一分钟保存一次 存平均值
 */
@property (nonatomic,strong) NSArray * paddleFrequencyItems;

/**
 踏频数组 一分钟保存一次 存平均值
 */
@property (nonatomic,strong) NSArray * treadFrequencyItems;

/**
 动作详情集合
 * type: 动作类型（十进制）  1快走；2慢跑；3中速跑；4快跑 ；
 * 71左腿前测拉伸；72右腿前测拉伸；73左腿后侧拉伸；74右腿后侧拉伸；75左腿弓步拉伸；76右腿弓步拉伸；
 * 77左腿内侧拉伸；78右腿内侧拉伸；79左侧小腿拉伸；80右侧小腿拉伸
 * actualTime : 实际运动时间
 * goalTime : 目标时间 单位 s
 * heartValue : 心率控制值
 */
@property (nonatomic,strong) NSArray<NSDictionary *> * actionItems;

@end

@interface IDOSyncV3ActivityDataModel : NSObject

/**
 * @brief 当前设备根据活动开始时间查询某个活动详情
 * The current device queries an event details based on the event start time
 * @param macAddr  mac地址 | Mac address
 * @param timeStr 活动开始时间 | Event start time
 * @return model IDOSyncV3ActivityDataInfoBluetoothModel
 */
+ (IDOSyncV3ActivityDataInfoBluetoothModel *)queryOneV3ActivityDataWithTimeStr:(NSString *)timeStr
                                                                       macAddr:(NSString *)macAddr;

/**
 * @brief 当前设备根据日期查询某天的活动集合
 * The current device queries the collection of events for a certain day based on the date
 * @param macAddr  mac地址 | Mac address
 * @param year  年份 | year
 * @param month 月份 | month
 * @param day   日期 | day
 * @return 活动集合 | Activity collection
 */
+ (NSArray <IDOSyncV3ActivityDataInfoBluetoothModel *>*)queryOneDayV3ActivityDataWithMacAddr:(NSString *)macAddr
                                                                                                 year:(NSInteger)year
                                                                                                month:(NSInteger)month
                                                                                                  day:(NSInteger)day;


/**
 * @brief 当前设备根据日期查询某月的活动集合
 * The current device queries the collection of events for a certain month based on the date
 * @param macAddr  mac地址 | Mac address
 * @param year  年份 | year
 * @param month 月份 | month
 * @return 活动集合 | Activity collection
 */
+ (NSArray <IDOSyncV3ActivityDataInfoBluetoothModel *>*)queryOneMonthV3ActivityDataWithMacAddr:(NSString *)macAddr
                                                                                                   year:(NSInteger)year
                                                                                                  month:(NSInteger)month;


/**
 * @brief 当前设备根据日期查询某年的活动集合
 * The current device queries the collection of events for a certain year based on the date
 * @param macAddr  mac地址 | Mac address
 * @param year  年份 | year
 * @return 活动集合 | Activity collection
 */
+ (NSArray <IDOSyncV3ActivityDataInfoBluetoothModel *>*)queryOneYearV3ActivityDataWithMacAddr:(NSString *)macAddr
                                                                                                  year:(NSInteger)year;


/**
 * @brief 当前设备活动分页查询活动集合 | Current Device Activity Paging Query Activity Collection
 * @param pageIndex 页码 第几页 (如 : 0,1,2,3,4,...) | Page Number of pages (eg : 0,1,2,3,4,...)
 * @param numOfPage 每页的数据个数 (如 : 10,20,30...) | The number of data per page (eg: 10, 20, 30...)
 * @param macAddr  mac地址 | Mac address
 * @return 活动集合
 */
+ (NSArray <IDOSyncV3ActivityDataInfoBluetoothModel *>*)queryOnePageV3ActivityDataWithPageIndex:(NSInteger)pageIndex
                                                                                               numOfPage:(NSInteger)numOfPage
                                                                                                 macAddr:(NSString *)macAddr;

/**
 * @brief 当前设备所有轨迹运动 | Current track motion of all devices
 * @param macAddr mac 地址 | mac address
 * @return 活动集合 | Activity collection
 */
+ (NSArray <IDOSyncV3ActivityDataInfoBluetoothModel *>*)queryAllTrajectorySportV3ActivitysWithMac:(NSString *)macAddr;

/**
 * @brief 当前设备所有轻运动 | Current equipment all light sports
 * @param macAddr mac 地址 | mac address
 * @return 活动集合 | Activity collection
 */
+ (NSArray <IDOSyncV3ActivityDataInfoBluetoothModel *>*)queryAllLightSportV3ActivitysWithMac:(NSString *)macAddr;

@end
