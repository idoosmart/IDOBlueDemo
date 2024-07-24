//
//  IDOSportTypeEnum.h
//  IDOBlueProtocol
//
//  Created by hedongyang on 2022/6/27.
//  Copyright © 2022 何东阳. All rights reserved.
//

#ifndef IDOSportTypeEnum_h
#define IDOSportTypeEnum_h

typedef NS_ENUM(NSInteger,IDO_SPORT_TYPE) {
     /**
     *无运动类型
     */
      IDO_SPORT_TYPE_NULL=0,
     /**
     *走路
     */
      IDO_SPORT_TYPE_WALK=1,
     /**
     *跑步
     */
      IDO_SPORT_TYPE_RUN=2,
     /**
     *骑行
     */
      IDO_SPORT_TYPE_CYCLING=3,
     /**
     *徒步
     */
      IDO_SPORT_TYPE_ONFOOT=4,
     /**
     *游泳
     */
      IDO_SPORT_TYPE_SWIM=5,
     /**
     *爬山
     */
      IDO_SPORT_TYPE_CLIMB=6,
     /**
     *羽毛球
     */
      IDO_SPORT_TYPE_BADMINTON=7,
     /**
     *其他（自由锻炼 | Free exercise）
      __IDO_FUNCTABLE__.funcTable37Model.set100SportSort，若支持一百种运动，使用IDO_SPORT_TYPE_FREE_TRAINING=100,
     */
      IDO_SPORT_TYPE_OTHER=8,
     /**
     *健身 | workout
     */
      IDO_SPORT_TYPE_FITNESS=9,
     /**
     *动感单车 | Dynamic bicycle
     */
      IDO_SPORT_TYPE_DYNAMIC=10,
     /**
     *椭圆球
     */
      IDO_SPORT_TYPE_ELLIPOSID=11,
     /**
     *跑步机
     */
      IDO_SPORT_TYPE_TREADMILL=12,
     /**
     *仰卧起坐
     */
      IDO_SPORT_TYPE_SIT_UP=13,
     /**
     *俯卧撑
     */
      IDO_SPORT_TYPE_PUSHUP=14,
     /**
     *哑铃
     */
      IDO_SPORT_TYPE_DUMBBELLS=15,
     /**
     *举重
     */
      IDO_SPORT_TYPE_LIFTING=16,
     /**
     *健身操
     */
      IDO_SPORT_TYPE_AEROBICS=17,
     /**
     *瑜伽
     */
      IDO_SPORT_TYPE_YOGA=18,
     /**
     *跳绳
     */
      IDO_SPORT_TYPE_ROPE=19,
     /**
     *乒乓球
     */
      IDO_SPORT_TYPE_PINGPONG=20,
     /**
     *篮球
     */
      IDO_SPORT_TYPE_BASKETBALL=21,
     /**
     *足球
     */
      IDO_SPORT_TYPE_SOCKER=22,
     /**
     *排球
     */
      IDO_SPORT_TYPE_VOLLEYBALL=23,
     /**
     *网球
     */
      IDO_SPORT_TYPE_TENNISBALL=24,
     /**
     *高尔夫球
     */
      IDO_SPORT_TYPE_GOLF=25,
     /**
     *棒球
     */
      IDO_SPORT_TYPE_BASEBALL=26,
     /**
     *滑雪
     */
      IDO_SPORT_TYPE_SKI=27,
     /**
     *轮滑
     */
      IDO_SPORT_TYPE_ROLLER=28,
     /**
     *跳舞
     */
      IDO_SPORT_TYPE_DANCING=29,
     /**
     *室内划船 | roller machine
     */
      IDO_SPORT_TYPE_ROLLER_MACHINE=31,
     /**
     *普拉提 | pilates
     */
      IDO_SPORT_TYPE_PILATES=32,
     /**
     *交叉训练 | cross train
     */
      IDO_SPORT_TYPE_CROSS_TRAIN=33,
     /**
     *有氧训练 | cardio
     */
      IDO_SPORT_TYPE_CARDIO=34,
     /**
     *尊巴舞 | Zumba
     */
      IDO_SPORT_TYPE_ZUMBA=35,
     /**
     *广场舞 | square dance
     */
      IDO_SPORT_TYPE_SQUARE_DANCE=36,
     /**
     *平板支撑 | Plank
     */
      IDO_SPORT_TYPE_PLANK=37,
     /**
     *健身房 | gym
     */
      IDO_SPORT_TYPE_GYM=38,
     /**
     *有氧健身操
     */
      IDO_SPORT_TYPE_AEROBICS_OXYGEN=39,

     /**
     *户外跑步
     */
      IDO_SPORT_TYPE_OUTDOOR_RUN=48,
     /**
     *室内跑步
     */
      IDO_SPORT_TYPE_INDOOR_RUN=49,
     /**
     *户外骑行
     */
      IDO_SPORT_TYPE_OUTDOOR_CYCLE=50,
     /**
     *室内骑行
     */
      IDO_SPORT_TYPE_INDOOR_CYCLE=51,
     /**
     *户外走路
     */
      IDO_SPORT_TYPE_OUTDOOR_WALK=52,
     /**
     *室内走路
     */
      IDO_SPORT_TYPE_INDOOR_WALK=53,
     /**
     *泳池游泳(室内游泳)
     */
      IDO_SPORT_TYPE_POOL_SWIM=54,
     /**
     *开放水域游泳（室外游泳）
     */
      IDO_SPORT_TYPE_WATER_SWIM=55,
     /**
     *椭圆机
     */
      IDO_SPORT_TYPE_ELLIPTICAL=56,
     /**
     *划船机
     */
      IDO_SPORT_TYPE_ROWER=57,
     /**
     *高强度间歇训练法
     */
      IDO_SPORT_TYPE_HIIT=58,
     /**
     *板球运动cricket
     */
      IDO_SPORT_TYPE_CRICKET=75,
    
    //********基础运动*******************
     /**
     *自由训练
     __IDO_FUNCTABLE__.funcTable37Model.set100SportSort，支持一百种运动，若不支持，则使用IDO_SPORT_TYPE_OTHER=8,
     */
      IDO_SPORT_TYPE_FREE_TRAINING=100,
     /**
     *功能性力量训练
     */
      IDO_SPORT_TYPE_FUNCTIONAL_STRENGTH_TRAINING=101,
     /**
     *核心训练
     */
      IDO_SPORT_TYPE_CORE_TRAINING=102,
     /**
     *踏步机
     */
      IDO_SPORT_TYPE_STEPPER=103,
     /**
     *整理放松
     */
      IDO_SPORT_TYPE_ORGANIZE_AND_RELAX=104,
    
    //********健身（25种）*******************
     /**
     *传统力量训练
     */
      IDO_SPORT_TYPE_TRADITIONAL_STRENGTH_TRAINING=110,
     /**
     *引体向上
     */
      IDO_SPORT_TYPE_PULL_UP=112,
     /**
     *开合跳
     */
      IDO_SPORT_TYPE_OPENING_AND_CLOSING_JUMP=114,
     /**
     *深蹲
     */
      IDO_SPORT_TYPE_SQUAT=115,
     /**
     *高抬腿
     */
      IDO_SPORT_TYPE_HIGH_LEG_LIFT=116,
     /**
     *拳击
     */
      IDO_SPORT_TYPE_BOXING=117,
     /**
     *杠铃
     */
      IDO_SPORT_TYPE_BARBELL=118,
     /**
     *武术
     */
      IDO_SPORT_TYPE_MARTIAL_ART=119,
     /**
     *太极
     */
      IDO_SPORT_TYPE_TAI_CHI=120,
     /**
     *跆拳道
     */
      IDO_SPORT_TYPE_TAEKWONDO=121,
     /**
     *空手道
     */
      IDO_SPORT_TYPE_KARATE=122,
     /**
     *自由搏击
     */
      IDO_SPORT_TYPE_FREE_FIGHT=123,
     /**
     *击剑
     */
      IDO_SPORT_TYPE_FENCING=124,
     /**
     *射箭
     */
      IDO_SPORT_TYPE_ARCHERY=125,
     /**
     *体操
     */
      IDO_SPORT_TYPE_ARTISTIC_GYMNASTICS=126,
     /**
     *单杠
     */
      IDO_SPORT_TYPE_HORIZONTAL_BAR=127,
     /**
     *双杠
     */
      IDO_SPORT_TYPE_PARALLEL_BARS=128,
     /**
     *漫步机
     */
      IDO_SPORT_TYPE_WALKING_MACHINE=129,
     /**
     *登山机
     */
      IDO_SPORT_TYPE_MOUNTAINEERING_MACHINE=130,
    
    //********球类*******************
     /**
     *保龄球
     */
      IDO_SPORT_TYPE_BOWLING=131,
     /**
     *台球
     */
      IDO_SPORT_TYPE_BILLIARDS=132,
     /**
     *曲棍球
     */
      IDO_SPORT_TYPE_HOCKEY=133,
     /**
     *橄榄球
     */
      IDO_SPORT_TYPE_RUGBY=134,
     /**
     *壁球
     */
      IDO_SPORT_TYPE_SQUASH=135,
     /**
     *垒球
     */
      IDO_SPORT_TYPE_SOFTBALL=136,
     /**
     *手球
     */
      IDO_SPORT_TYPE_HANDBALL=137,
     /**
     *毽球
     */
      IDO_SPORT_TYPE_SHUTTLECOCK=138,
     /**
     *沙滩足球
     */
      IDO_SPORT_TYPE_BEACH_SOCCER=139,
     /**
     *藤球
     */
      IDO_SPORT_TYPE_SEPAKTAKRAW=140,
     /**
     *躲避球
     */
      IDO_SPORT_TYPE_DODGEBALL=141,
    
    //********休闲运动*******************
     /**
     *街舞
     */
      IDO_SPORT_TYPE_HIP_HOP=152,
     /**
     *芭蕾
     */
      IDO_SPORT_TYPE_BALLET=153,
     /**
     *社交舞
     */
      IDO_SPORT_TYPE_SOCIAL_DANCE=154,
     /**
     *飞盘
     */
      IDO_SPORT_TYPE_FRISBEE=155,
     /**
     *飞镖
     */
      IDO_SPORT_TYPE_DARTS=156,
     /**
     *骑马
     */
      IDO_SPORT_TYPE_RIDING=157,
     /**
     *爬楼
     */
      IDO_SPORT_TYPE_CLIMB_BUILDING=158,
     /**
     *放风筝
     */
      IDO_SPORT_TYPE_KITE_FLYING=159,
     /**
     *钓鱼
     */
      IDO_SPORT_TYPE_GO_FISHING=160,
    
    //********冰雪运动*******************
     /**
     *雪橇
     */
      IDO_SPORT_TYPE_SLED=161,
     /**
     *雪车
     */
      IDO_SPORT_TYPE_SNOWMOBILE=162,
     /**
     *单板滑雪
     */
      IDO_SPORT_TYPE_SNOWBOARDING=163,
     /**
     *雪上运动
     */
      IDO_SPORT_TYPE_SNOW_IDO_SPORTS=164,
     /**
     *高山滑雪
     */
      IDO_SPORT_TYPE_ALPINE_SKIING=165,
     /**
     *越野滑雪
     */
      IDO_SPORT_TYPE_CROSS_COUNTRY_SKIING=166,
     /**
     *冰壶
     */
      IDO_SPORT_TYPE_CURLING=167,
     /**
     *冰球
     */
      IDO_SPORT_TYPE_ICE_HOCKEY=168,
     /**
     *冬季两项
     */
      IDO_SPORT_TYPE_WINTER_BIATHLON=169,
    
    //********水上运动（10种）*******************
     /**
     *冲浪
     */
      IDO_SPORT_TYPE_SURFING=170,
     /**
     *帆船
     */
      IDO_SPORT_TYPE_SAILBOAT=171,
     /**
     *帆板
     */
      IDO_SPORT_TYPE_SAILBOARD=172,
     /**
     *皮艇
     */
      IDO_SPORT_TYPE_KAYAK=173,
     /**
     *摩托艇
     */
      IDO_SPORT_TYPE_MOTORBOAT=174,
     /**
     *划艇
     */
      IDO_SPORT_TYPE_ROWBOAT=175,
     /**
     *赛艇
     */
      IDO_SPORT_TYPE_ROWING=176,
     /**
     *龙舟
     */
      IDO_SPORT_TYPE_DRAGON_BOAT=177,
     /**
     *水球
     */
      IDO_SPORT_TYPE_WATER_POLO=178,
     /**
     *漂流
     */
      IDO_SPORT_TYPE_DRIFT=179,
    
    //********极限运动（5种）*******************
     /**
     *滑板
     */
      IDO_SPORT_TYPE_SKATE=180,
     /**
     *攀岩
     */
      IDO_SPORT_TYPE_ROCK_CLIMBING=181,
     /**
     *蹦极
     */
      IDO_SPORT_TYPE_BUNGEE_JUMPING=182,
     /**
     *跑酷
     */
      IDO_SPORT_TYPE_PARKOUR=183,
     /**
     *BMX越野自行车
     */
      IDO_SPORT_TYPE_BMX=184,
    /**
    *足排球
    */
     IDO_SPORT_TYPE_FOOTVOLLEY=187,
    /**
    *站立滑水
    */
     IDO_SPORT_TYPE_STAND_WATER_SKIING=188,
    /**
    *越野跑
    */
     IDO_SPORT_TYPE_CROSSCOUNTRY_RUN=189,
    /**
    *卷腹
    */
     IDO_SPORT_TYPE_ROLLED_ABDOMEN=190,
    /**
    *波比跳
    */
     IDO_SPORT_TYPE_BOBBY_JUMP=191,
    /**
    *卡巴迪
    */
     IDO_SPORT_TYPE_KABADDI=192,
    /**
    *户外玩耍 | Outdoor Fun (kr01定制项目)
    */
     IDO_SPORT_TYPE_OUTDOOR_FUN=193,
    /**
    *其他运动 | Other Activity (kr01定制项目)
    */
     IDO_SPORT_TYPE_OTHER_ACTIVITY=194,
    /**
    *蹦床
    */
     IDO_SPORT_TYPE_TRAMPOLINE=195,
    /**
    *呼啦圈
    */
     IDO_SPORT_TYPE_HULA_HOOP=196,
    /**
    *赛车
    */
     IDO_SPORT_TYPE_RACING=197,
    /**
    *战绳
    */
     IDO_SPORT_TYPE_BATTLE_ROPE=198,
    
    //********MT01项目*******************
    /**
    *跳伞| Parachuting
    */
     IDO_SPORT_TYPE_PARACHUTING = 199,
    /**
    *定向越野 | Orienteering
    */
     IDO_SPORT_TYPE_ORIENTEERING = 200,
    /**
    *山地骑行 | Mountain biking
    */
     IDO_SPORT_TYPE_MOUNTAIN_BIKING=201,
    /**
    *沙滩网球 | Beach tennis
    */
     IDO_SPORT_TYPE_BEACH_TENNIS=202,
    /**
    *匹克球 | Pickleball
    */
     IDO_SPORT_TYPE_PICKLEBALL=204,
    /**
    *轮椅运动 | wheelchair sport
    */
     IDO_SPORT_TYPE_WHEELCHAIR =205,
 };

typedef NS_ENUM(NSInteger,IDO_SPORT_PAR_TYPE) {
    //无运动类型
    IDO_SPORT_PAR_NULL          = 0,
    //音乐
    IDO_SPORT_PAR_MUSCI         = 1,
    //运动时⻓
    IDO_SPORT_PAR_SPORT_DUR     = 2,
    //卡路⾥
    IDO_SPORT_PAR_CALORIE       = 3,
    //距离
    IDO_SPORT_PAR_DISTANCE      = 4,
    //趟数
    IDO_SPORT_PAR_TRIPNUM       = 5,
    //主泳姿
    IDO_SPORT_PAR_MAINSTROKE    = 6,
    //最近⼀趟SWOLF
    IDO_SPORT_PAR_LASTSWOLF     = 7,
    //实时配速
    IDO_SPORT_PAR_REALTIMESPACE = 8,
    //平均配速
    IDO_SPORT_PAR_AVERPACE      = 9,
    //滚动配速
    IDO_SPORT_PAR_ROLLPACE      = 10,
    //⼼率+图表
    IDO_SPORT_PAR_RATECHART     = 11,
    //步频
    IDO_SPORT_PAR_STEPFREQ      = 12,
    //步数
    IDO_SPORT_PAR_STEPS         = 13,
    //踏频
    IDO_SPORT_PAR_CADENCE       = 14,
    //浆次
    IDO_SPORT_PAR_PULPTIME      = 15,
    //浆频
    IDO_SPORT_PAR_PILPFREQ      = 16,
    //有氧训练效果
    IDO_SPORT_PAR_AEROBICTRAINEFF = 17,
    //智能陪跑
    IDO_SPORT_PAR_INTELLRUN     = 18,
    //实时速度
    IDO_SPORT_PAR_REALTIMESPEED = 19,
    //平均速度
    IDO_SPORT_PAR_AVERSPEED     = 20,
    //⽬标
    IDO_SPORT_PAR_GOAL          = 21,
    //最快配速
    IDO_SPORT_PAR_FASTESTPACE   = 22,
    //平均步频
    IDO_SPORT_PAR_AVERSTEPFREQ  = 23,
    //平均步幅
    IDO_SPORT_PAR_AVERSTRIDE    = 24,
    //平均⼼率
    IDO_SPORT_PAR_AVERHEART     = 25,
    //最⼤⼼率
    IDO_SPORT_PAR_MAXHEART      = 26,
    //恢复时间
    IDO_SPORT_PAR_RECOVERYTIME  = 27,
    //最⼤摄氧
    IDO_SPORT_PAR_MAXOXUPTAKE   = 28,
    //累计爬升
    IDO_SPORT_PAR_CUMUCLIMB     = 29,
    //累计下降
    IDO_SPORT_PAR_CUMUDEC       = 30,
    //平均海拔⾼度
    IDO_SPORT_PAR_AVERALTITUDE  = 31,
    //最快速度
    IDO_SPORT_PAR_FASTESTSPEED  = 32,
    //最⼤步频
    IDO_SPORT_PAR_MAXSTEPFREQ   = 33,
    //最低海拔
    IDO_SPORT_PAR_LOWESTALTITUDE = 34,
    //最⾼海拔
    IDO_SPORT_PAR_MAXALTITUDE    = 35,
    //3D距离
    IDO_SPORT_PAR_3DDISTANCE    = 36,
    //平均3D速度
    IDO_SPORT_PAR_AVER3DDISTANCE = 37,
    //平均垂直速度
    IDO_SPORT_PAR_AVERVERSPEED = 38,
    
};

//app监听固件主动的通知 | The app listens for active notifications from the firmware
typedef NS_ENUM(NSInteger,IDO_LISTEN_TYPE) {
     /**
     *无效类型
     | Invalid type
     */
    IDO_LISTEN_TYPE_NULL=0,
    /**
    *手环已经解绑
     | The bracelet has been untied
    */
   IDO_LISTEN_TYPE_DEVICE_UNBIND = 1,
    /**
    *心率模式改变
     | Heart rate pattern change
    */
   IDO_LISTEN_TYPE_HEART_CHANGE = 2,
    /**
    *血氧产生数据，发生改变
     | Blood oxygen production data, changed
    */
   IDO_LISTEN_TYPE_BOX_CHANGE = 3,
    /**
    *压力产生数据，发生改变
     |Pressure generates data and changes
    */
   IDO_LISTEN_TYPE_PRESSURE_CHANGE = 4,
    /**
    *Alexa识别过程中退出
     |Exit during Alexa identification
    */
   IDO_LISTEN_TYPE_ALEXA_EXIT_IDEN = 5,
    /**
    *固件发起恢复出厂设置，通知app弹框提醒
     | Firmware initiates factory reset and notifies app to pop up
    */
   IDO_LISTEN_TYPE_FACTORY_RESET_APP_POPUP = 6,
    /**
    *app需要进入相机界面（TIT01定制）
     | The app needs to enter the camera interface (TIT01 customization)
    */
   IDO_LISTEN_TYPE_ENTER_CAMERA = 7,
    /**
    *sos事件通知（205土耳其定制）
     | Sos event notification (205 customized in Türkiye)
    */
   IDO_LISTEN_TYPE_SOS_EVENT_NOTI = 8,
    /**
    *alexa设置的闹钟，固件修改，需要发送对应的通知位给app，app收到后发送获取V3的闹钟命令
     | For alarm clock set by alexa and firmware modification, it is necessary to send the corresponding notification bit to the app,
     and the app will send the command to acquire V3 alarm clock after receiving it
    */
   IDO_LISTEN_TYPE_ALEXA_ALARM_SETTING_NEED_APP_UPDATE = 9,
    /**
    *固件有删除日程提醒，app这边需要更新对应的列表数据
     |The firmware has a reminder to delete the schedule, and the app needs to update the corresponding list data
    */
   IDO_LISTEN_TYPE_SCHEDULE_NEED_APP_UPDATE = 10,
    /**
    *固件端有修改对应的表盘子样式，通知app获取（command\_id为0x33， key为 0x5000）
     |The firmware side modifies the corresponding table tray style, and notifies the app to obtain it
    */
   IDO_LISTEN_TYPE_DIAL_NEED_APP_GET = 11,
    /**
    *固件通知ios更新通知图标和名字
     |Firmware notification ios update notification icon and name
    */
   IDO_LISTEN_TYPE_UPDATE_ICON_NAME = 12,
    /**
    *固件通知app图标已经更新，通知app获取已经更新的图标状态
     | Firmware notifies the app that the icon has been updated, and notifies the app to obtain the updated icon status
    */
   IDO_LISTEN_TYPE_ICON_STATE_UPDATE = 13,
    /**
    *固件请求重新设置天气，app收到收，下发天气数据
     | Firmware requests to reset the weather, and the app receives and sends the weather data
    */
   IDO_LISTEN_TYPE_UPDATE_WEATHER = 14,
    /**
    *步数每次增加2000步，设备请求app同步数据，app调用同步接口
     | The number of steps increases by 2000 each time, the device requests the app to synchronize data,
     and the app calls the synchronization interface
    */
   IDO_LISTEN_TYPE_STEP_STANDARD_SYN_DATA = 15,
    /**
    *探测到睡眠结束，请求app同步睡眠数据，app调用同步接口同步
     |When the end of sleep is detected, the app is requested to synchronize the sleep data,
     and the app calls the synchronization interface to synchronize
    */
   IDO_LISTEN_TYPE_SLEEP_END_SYN_DATA = 16,
    /**
    *固件三环数据修改，通知app更新三环数据
     |Firmware three ring data modification, notify the app to update the three ring data
    */
   IDO_LISTEN_TYPE_THREE_RING_CHANGE_NEED_UPDATE = 17,
    /**
    *固件充满电完成发送提醒，app收到后通知栏显示设备充电完成
     | When the firmware is fully charged, it sends a reminder. After the app receives it,
     the notification bar displays that the device is fully charged
    */
   IDO_LISTEN_TYPE_FULLY_CHARGED = 18,
    /**
    *结束运动后，手动测量心率后，手动测量血氧后，手动测量压力后，设备自动请求同步，
     先检查链接状态，未连接本次同步不执行，满足下个自动同步条件后再次判断发起同步请求
     |After the exercise, the device automatically requests synchronization after manually measuring the heart rate,
     blood oxygen and pressure,Check the link status first. If the link is not connected, this synchronization will not be
     executed. If the next automatic synchronization condition is met, judge again to initiate a synchronization request
    */
   IDO_LISTEN_TYPE_SPORT_END_NEED_SYN_DATA = 19,
    /**
    *固件修改 心率通知状态类型、压力通知状态类型、血氧通知状态类型、生理周期通知状态类型、
     健康指导通知状态类型、提醒事项通知状态类型通知app更新心率、压力、血氧、生理周期、健康指导、
     提醒事项通知状态类型
     |Firmware modifies heart rate notification status type, pressure notification status type, blood oxygen notification status type,
     physiological cycle notification status type Health guidance notification status type, reminder notification status type, notification
     app to update heart rate, pressure, blood oxygen, physiological cycle, health guidance Reminder notification status type
    */
   IDO_LISTEN_TYPE_CARD_DATA_CHANGE = 20,
    /**
    *固件压力值计算完成，通知app获取压力值
     |After the firmware pressure value is calculated, notify the app to obtain the pressure value
    */
   IDO_LISTEN_TYPE_APP_GET_PRESSURE = 21,
    /**
    *固件通知app，固件压力校准失败(固件退出测量界面/检测失败/检测超时/未佩戴)
     |Firmware notifies app that firmware pressure calibration fails (firmware exits the measurement interface/detection fails/detection timeout/is not worn)
    */
   IDO_LISTEN_TYPE_MEASURE_DETECTION_FAIL = 22,
    /**
    *固件通知app bt蓝牙已连接
     |Firmware notifies app bt that Bluetooth is connected
    */
   IDO_LISTEN_TYPE_BT_CONNECTED = 24,
    /**
    *固件通知app bt蓝牙断开连接
     |Firmware notifies app bt bluetooth to disconnect
    */
   IDO_LISTEN_TYPE_BT_DISCONNECT = 25,
    /**
    *固件蓝牙通话开始
     |Firmware Bluetooth call start
    */
   IDO_LISTEN_TYPE_BLUETOOTH_CALL_START = 26,
    /**
    *固件蓝牙通话结束
     |Firmware Bluetooth call ended
    */
    IDO_LISTEN_TYPE_BLUETOOTH_CALL_END = 27,
    /**
    *新版本固件每隔4分30秒发送一个通知命令用于修复ios 会显示离线的问题
     | The new version firmware sends a notification command every 4 minutes and 30 seconds to fix the problem that ios will show offline
    */
   IDO_LISTEN_TYPE_ALEXA_PING = 28,
    /**
    *通知app运动开始（作用于拦截表盘传输同26）
     |Notify app of the start of movement (the same as 26 for blocking dial transmission)
    */
   IDO_LISTEN_TYPE_SPORT_START = 29,
    /**
    *通知app运动结束（作用于拦截表盘传输同27）
     | Notify the app of the end of movement (the same as 27 for blocking dial transmission)
    */
    IDO_LISTEN_TYPE_SPORT_END = 30,
    /**
    *固件重启发送通知给app  （app收到通知需要获取固件版本信息）
     | Firmware restart sends notification to app (app needs to obtain firmware version information after receiving notification)
    */
   IDO_LISTEN_TYPE_RESTART_GET_FIRMWARE_VERSION = 31,
    /**
    *设备空闲时（没有使用aleax），需要上报通知给app（时间间隔为1小时）
     | When the device is idle (aleax is not used), it needs to report to the app (the time interval is 1 hour)
    */
   IDO_LISTEN_TYPE_IDLE_NOE_HOUR_NOT_USER_ALEXA_ = 32,
    /**
    *固件整理空间完成通知app继续下传表盘文件
     | Notify the app to continue downloading the dial file after the firmware finishes sorting the space
    */
    IDO_LISTEN_TYPE_SORT_SPACE_NOTIFY_CONTINUE = 33,
    /**
    *固件通知app结束寻找手环指令 （对应6.3寻找手环）
     | Firmware notifies the app to end the command of looking for the bracelet (corresponding to 6.3 looking for the bracelet)
    */
    IDO_LISTEN_TYPE_END_LOOKING_DEVICE = 34,
    /**
    *固件进入省电模式通知app
     | Notify app when firmware enters power-saving mode
    */
    IDO_LISTEN_TYPE_ENTER_POWER_SAVING_MODE = 35,
    /**
    *固件退出省电模式通知app
     | Firmware exit power-saving mode notification app
    */
    IDO_LISTEN_TYPE_EXIT_POWER_SAVING_MODE = 36,
    /**
    *固件通知请求app下发设置gps热启动参数
     | Firmware notification requests the app to issue a request to set the gps hot start parameters
    */
    IDO_LISTEN_TYPE_SET_GPS_HOT_START_PARA = 37,
    /**
    *固件传输原始数据完成，通知app获取特性向量信息
     | Firmware transfers the original data and notifies the app to obtain the feature vector information
    */
    IDO_LISTEN_TYPE_TRAN_ORIG_DATA_OVER_GET_VER_INFO = 38,
    /**
    *固件通知app，固件血压校准失败(固件退出测量界面/检测失败/检测超时/未佩戴)
     | Firmware notifies app that firmware blood pressure calibration fails
     (firmware exits the measurement interface/detection fails/detection timeout/is not worn)
    */
    IDO_LISTEN_TYPE_BLOOD_PRESSURE_CALIBRATION_FAIL = 39,
    /**
    *固件传输原始数据完成，没有特性向量信息，通知app数据采集结束
     | Firmware transmission of original data is completed, no characteristic
     vector information is available, and the app is notified of the end of data collection
    */
    IDO_LISTEN_TYPE_TRAN_ORIG_DATA_OVER = 40,
    /**
    *固件整理gps数据空间完成通知app下发gps文件
     | Firmware sorting gps data space completion notification app sends gps file
    */
    IDO_LISTEN_TYPE_SORT_GPS_SPACE_OVER = 42,
    /**
    *固件升级EPO.dat文件失败，通知app再次下发一次该文件
    | Firmware upgrade of EPO.dat file failed, notify the app to issue the file again
    */
    IDO_LISTEN_TYPE_UPDATE_EPO_FAIL = 43,
    /**
    *固件升级EPO.dat文件成功
     | Firmware upgrade EPO.dat file succeeded
    */
    IDO_LISTEN_TYPE_UPDATE_EPO_SUC = 44,
    /**
    *固件升级GPS失败，通知app重新传输
     | Firmware upgrade GPS failed, notify app to retransmit
    */
    IDO_LISTEN_TYPE_UPDATE_GPS_FAIL = 45,
    /**
    *固件升级GPS成功
     | Firmware upgrade GPS successful
    */
    IDO_LISTEN_TYPE_UPDATE_GPS_SUC = 46,
    /**
    *发起运动时, 固件GPS异常
     | Firmware upgrade GPS successful
    */
    IDO_LISTEN_TYPE_GPS_ABNORMAL_STARTING_SPORT = 47,
    /**
    * runpho外设信息更新通知
     | Runho peripheral information update notification
    */
    IDO_LISTEN_TYPE_PERIPHERAL_INFO_UPDATE= 48,
    /**
    *固件通知app，取消BT配对
     | Firmware notification app, cancel BT  pairing
    */
    IDO_LISTEN_TYPE_CANCLE_BT_PAIRING = 49,
    /**
    *固件通知app，BT配对成功
     | Firmware notification app, BT pairing successful
    */
    IDO_LISTEN_TYPE_BT_PAIRING_SUCCESS = 50,
    /**
    *固件设置运动排序，通知app获取运动排序信息，及时更新App UI
     | Firmware setting for motion sorting, notifying the app to obtain motion sorting information,
      and updating the app UI in a timely manner
    */
    IDO_LISTEN_TYPE_SPORT_MODE_SORT_UPDATE = 51,
    /**
    *固件全天步数目标参数有更改,通知app获取全天步数目标
     | The firmware all day step target parameter has been changed, notify the app to obtain the all day step target
    */
    IDO_LISTEN_TYPE_All_DAY_STEP_TARGET_UPDATE = 52,
    /**
    *固件通知app固件进入血压校准界面
     | Firmware notification app firmware enters the blood pressure calibration interface
    */
    IDO_LISTEN_TYPE_NEED_ENTER_BLOOD_PRESSURE_CALIBRATION = 53,
    /**
    *固件自动识别开关状态更新,通知app获取运动自动识别开关状态
     | Firmware automatic recognition switch status update, notify app to obtain motion automatic recognition switch status
    */
    IDO_LISTEN_TYPE_AUTO_RECOGNITION_SWITCH_UPDATE = 54,
    /**
    *固件慢速模式切换慢速模式
     | Firmware fast mode switching to slow mode
    */
    IDO_LISTEN_TYPE_FIRMWARE_SLOW_MODE = 55,
    /**
    *固件慢速模式切换快速模式
     | Firmware fast mode switching to fast mode
    */
    IDO_LISTEN_TYPE_FIRMWARE_FAST_MODE = 56,
    /**
    *固件更新mtu，APP下发获取mtu更新本地记录的mtu
     | Firmware update MTU, APP issue to obtain MTU update local record MTU
    */
    IDO_LISTEN_TYPE_FIRMWARE_UPDATE_MTU = 57,
    /**
    *固件电量变化，APP下发获取电量信息
     | Firmware power changes, APP issues to obtain power information
    */
    IDO_LISTEN_TYPE_FIRMWARE_POWER_CHANGES = 58,
    /**
    *当前处于DFU模式(思澈平台)
     | Currently in DFU mode (Siche platform)
    */
    IDO_LISTEN_TYPE_FIRMWARE_SICHE_IN_DFU = 59,
    /**
    *APP收到固件通知，获取固件单位
     | APP receives firmware notification and obtains firmware units
    */
    IDO_LISTEN_TYPE_OBTAIN_FIRMWARE_UNITS = 60,
    /**
    *固件修改菜单列表(快捷列表)，通知APP获取(02A8)
     | Firmware modification menu list (shortcut list), notify APP to obtain (02A8)
    */
    IDO_LISTEN_TYPE_FIRMWARE_MENU_LIST_CHANGES = 61,
    /**
    *固件修改本地语言，通知APP获取(0222)
     | Firmware modification local language, notify APP to obtain (0222)
    */
    IDO_LISTEN_TYPE_FIRMWARE_LOCAL_LANGUAGE_CHANGES = 62,
    /**
    *固件修改当前表盘，通知APP获取固件修改当前表盘，通知APP获取
     | Firmware modification of current dial, notify APP to obtain
    */
    IDO_LISTEN_TYPE_FIRMWARE_CURRENT_DIAL_CHANGES = 63,
    /**
    *固件测量完成后，通知APP获取（0606）
     | After the firmware measurement is completed, notify the APP to obtain it
    */
    IDO_LISTEN_TYPE_FIRMWARE_MEASUREMENT_COMPLETE = 64, 
};

//自定义数据类型 | Custom data type
typedef NS_ENUM(NSInteger,IDO_CUSTOMDATA_TYPE) {
    IDO_CUSTOMDATA_TYPE_TARGET_STEPS = 0,//目标步数
    IDO_CUSTOMDATA_TYPE_STEPS   = 1,//步数 | steps
    IDO_CUSTOMDATA_TYPE_CALORIE = 2,//卡路里 | CALORIE
    IDO_CUSTOMDATA_TYPE_DISTANCE = 3,//距离 | DISTANCE
    IDO_CUSTOMDATA_TYPE_ELEC = 7,//电量 | quantity of electricity
    IDO_CUSTOMDATA_TYPE_TODAY_DURATION = 8,//当天时长 | Duration of today
    IDO_CUSTOMDATA_TYPE_ACTIVE_DURATION = 9,//活跃时长| Active duration
    IDO_CUSTOMDATA_TYPE_MOTION_STEPS = 16,//运动中步数 | Number of steps in motion
    IDO_CUSTOMDATA_TYPE_MOTION_HR = 17,//运动中心率 | Number of HR in motion
    IDO_CUSTOMDATA_TYPE_MOTION_PACE = 18,//运动中配速 | Number of pace in motion
    IDO_CUSTOMDATA_TYPE_MOTION_DISTANCE = 19,//运动中距离 | Number of DISTANCE in motion
    IDO_CUSTOMDATA_TYPE_MOTION_CALORIE = 20,//运动中卡路里 | Number of CALORIE in motion
    IDO_CUSTOMDATA_TYPE_MOTION_AVG_PACE = 21,//运动中平均配速 | Number of Average pace in motion
    IDO_CUSTOMDATA_TYPE_DEEP_SLEEP_DURATION = 22,//深度睡眠时长 | Duration of deep sleep
    IDO_CUSTOMDATA_TYPE_LIGHT_SLEEP_DURATION = 23,//浅度睡眠时长 | Duration of light sleep
    IDO_CUSTOMDATA_TYPE_AWAKENING_DURATION = 24,//清醒时长 | Duration of Awakening
    IDO_CUSTOMDATA_TYPE_EYE_MOVE = 25,//快速眼动 | Rapid eye movement
    IDO_CUSTOMDATA_TYPE_PRESSURE_VALUE_SETTING = 32,//压力值设置 | Pressure value setting
    IDO_CUSTOMDATA_TYPE_PRESSURE_VALUE_Eixt = 33,//压力值退出 | Pressure value Eixt
    IDO_CUSTOMDATA_TYPE_PRESSURE_VALUE_TOOHIGH = 34,//压力值退出 | Pressure value too high
    
    IDO_CUSTOMDATA_TYPE_START_OPEN = 99,//自定义指令开关（进入页面的时候可以发送一次） | Custom command switch (can be sent once when entering the page)

};

//语言类型 | Language Type
typedef NS_ENUM(NSInteger,IDO_LANGUAGE_TYPE) {
    /**
    *无效类型 | Invalid type
    */
    IDO_LANGUAGE_TYPE_INVALID = 0,
    /**
    *中文 | Chinese
    */
    IDO_LANGUAGE_TYPE_CHINESE = 1,
    /**
    *英文 | English
    */
    IDO_LANGUAGE_TYPE_ENGLISH = 2,
    /**
    *法语 | French
    */
    IDO_LANGUAGE_TYPE_FRENCH = 3,
    /**
    *德语 | German
    */
    IDO_LANGUAGE_TYPE_GERMAN = 4,
    /**
    *意大利语 | Italian
    */
    IDO_LANGUAGE_TYPE_ITALIAN = 5,
    /**
    *西班牙语 | Spanish
    */
    IDO_LANGUAGE_TYPE_SPANISH = 6,
    /**
    *日语 | Japanese
    */
    IDO_LANGUAGE_TYPE_JAPANESE = 7,
    /**
    *波兰语 | Polish
    */
    IDO_LANGUAGE_TYPE_POLISH = 8,
    /**
    *捷克语 | Czech
    */
    IDO_LANGUAGE_TYPE_CZECH = 9,
    /**
    *罗马尼亚 | Romania
    */
    IDO_LANGUAGE_TYPE_ROMANIA = 10,
    /**
    *立陶宛语 | Lithuanian
    */
    IDO_LANGUAGE_TYPE_LITHUANIAN = 11,
    /**
    *荷兰语 | Dutch
    */
    IDO_LANGUAGE_TYPE_DUTCH = 12,
    /**
    *斯洛文尼亚 | Slovenia
    */
    IDO_LANGUAGE_TYPE_SLOVENIA = 13,
    /**
    *匈牙利语 | Hungarian
    */
    IDO_LANGUAGE_TYPE_HUNGARIAN = 14,
    /**
    *俄罗斯语 | Russian
    */
    IDO_LANGUAGE_TYPE_RUSSIAN = 15,
    /**
    *乌克兰语 | Ukrainian
    */
    IDO_LANGUAGE_TYPE_UKRAINIAN = 16,
    /**
    *斯洛伐克语 | Slovak
    */
    IDO_LANGUAGE_TYPE_SLOVAK = 17,
    /**
    *丹麦语 | Danish
    */
    IDO_LANGUAGE_TYPE_DANISH = 18,
    /**
    *克罗地亚 | Croatia
    */
    IDO_LANGUAGE_TYPE_CROATIA = 19,
    /**
    *印尼语 | Indonesian
    */
    IDO_LANGUAGE_TYPE_INDONESIAN = 20,
    /**
    *韩语 | korean
    */
    IDO_LANGUAGE_TYPE_KOREAN = 21,
    /**
    *印地语 | hindi
    */
    IDO_LANGUAGE_TYPE_HINDI = 22,
    /**
    *葡萄牙语 | portuguese
    */
    IDO_LANGUAGE_TYPE_PORTUGUESE = 23,
    /**
    *土耳其 | turkish
    */
    IDO_LANGUAGE_TYPE_TURKISH = 24,
    /**
    *泰国语 | thai
    */
    IDO_LANGUAGE_TYPE_THAI = 25,
    /**
    *越南语 | vietnamese
    */
    IDO_LANGUAGE_TYPE_VIETNAMESE = 26,
    /**
    *缅甸语 | burmese
    */
    IDO_LANGUAGE_TYPE_BURMESE = 27,
    /**
    *菲律宾语 | filipino
    */
    IDO_LANGUAGE_TYPE_FILIPINO = 28,
    /**
    *繁体中文 | traditional Chinese
    */
    IDO_LANGUAGE_TYPE_TRADITIONAL_CHINESE = 29,
    /**
    *希腊语 | greek
    */
    IDO_LANGUAGE_TYPE_GREEK = 30,
    /**
    *阿拉伯语 | arabic
    */
    IDO_LANGUAGE_TYPE_ARABIC = 31,
    /**
    *瑞典语 | sweden
    */
    IDO_LANGUAGE_TYPE_SWEDEN = 32,
    /**
    *芬兰语 | finland
    */
    IDO_LANGUAGE_TYPE_FINLAND = 33,
    /**
    *波斯语 | persia
    */
    IDO_LANGUAGE_TYPE_PERSIA = 34,
    /**
    *挪威语 | norwegian
    */
    IDO_LANGUAGE_TYPE_NORWEGIAN = 35,
    /**
    *马来语 | malay
    */
    IDO_LANGUAGE_TYPE_MALAY = 36,
    /**
    *巴西葡语 | brazilian_portuguese
    */
    IDO_LANGUAGE_TYPE_BRAZILIAN_PORTUGUESE = 37,
    /**
    *孟加拉语 | bengali
    */
    IDO_LANGUAGE_TYPE_BENGALI = 38,
    /**
    *高棉语 | khmer
    */
    IDO_LANGUAGE_TYPE_KHMER = 39,

};

#endif /* IDOSportTypeEnum_h */
