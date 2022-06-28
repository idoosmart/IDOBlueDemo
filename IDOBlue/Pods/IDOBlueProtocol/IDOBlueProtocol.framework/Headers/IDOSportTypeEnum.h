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
         * 无运动类型
         */
          IDO_SPORT_TYPE_NULL=0,
        /**
         * 走路
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
         *其他
         */
          IDO_SPORT_TYPE_OTHER=8,
        /**
         *健身
         */
          IDO_SPORT_TYPE_FITNESS=9,
        /**
         *动感单车
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
         *室内划船
         */
          IDO_SPORT_TYPE_ROLLER_MACHINE=31,
        /**
         *普拉提
         */
          IDO_SPORT_TYPE_PILATES=32,
        /**
         *交叉训练
         */
          IDO_SPORT_TYPE_CROSS_TRAIN=33,
        /**
         *有氧训练
         */
          IDO_SPORT_TYPE_CARDIO=34,
        /**
         *尊巴舞
         */
          IDO_SPORT_TYPE_ZUMBA=35,
        /**
         *广场舞
         */
          IDO_SPORT_TYPE_SQUARE_DANCE=36,
        /**
         *平板支撑
         */
          IDO_SPORT_TYPE_PLANK=37,

        /**
         * 健身房
         */
          IDO_SPORT_TYPE_GYM=38,

        /**
         * 有氧健身操
         */
          IDO_SPORT_TYPE_AEROBICS_OXYGEN=39,

        /**
         * 户外跑步
         */
          IDO_SPORT_TYPE_OUTDOOR_RUN=48,
        /**
         * 室内跑步
         */
          IDO_SPORT_TYPE_INDOOR_RUN=49,
        /**
         * 户外骑行
         */
          IDO_SPORT_TYPE_OUTDOOR_CYCLE=50,
        /**
         * 室内骑行
         */
          IDO_SPORT_TYPE_INDOOR_CYCLE=51,
        /**
         * 户外走路
         */
          IDO_SPORT_TYPE_OUTDOOR_WALK=52,
        /**
         * 室内走路
         */
          IDO_SPORT_TYPE_INDOOR_WALK=53,
        /**
         * 泳池游泳(室内游泳)
         */
          IDO_SPORT_TYPE_POOL_SWIM=54,
        /**
         * 开放水域游泳（室外游泳）
         */
          IDO_SPORT_TYPE_WATER_SWIM=55,
        /**
         * 椭圆机
         */
          IDO_SPORT_TYPE_ELLIPTICAL=56,
        /**
         * 划船机
         */
          IDO_SPORT_TYPE_ROWER=57,
        /**
         * 高强度间歇训练法
         */
          IDO_SPORT_TYPE_HIIT=58,
        /**
         * 板球运动cricket
         */
          IDO_SPORT_TYPE_CRICKET=75,
        /**
         * 自由训练
         */
          IDO_SPORT_TYPE_FREE_TRAINING=100,
        /**
         * 功能性力量训练
         */
          IDO_SPORT_TYPE_FUNCTIONAL_STRENGTH_TRAINING=101,
        /**
         * 核心训练
         */
          IDO_SPORT_TYPE_CORE_TRAINING=102,
        /**
         * 踏步机
         */
          IDO_SPORT_TYPE_STEPPER=103,
        /**
         * 整理放松
         */
          IDO_SPORT_TYPE_ORGANIZE_AND_RELAX=104,
        /**
         * 传统力量训练
         */
          IDO_SPORT_TYPE_TRADITIONAL_STRENGTH_TRAINING=110,
        /**
         * 引体向上
         */
          IDO_SPORT_TYPE_PULL_UP=112,
        /**
         * 开合跳
         */
          IDO_SPORT_TYPE_OPENING_AND_CLOSING_JUMP=114,
        /**
         * 深蹲
         */
          IDO_SPORT_TYPE_SQUAT=115,
        /**
         * 高抬腿
         */
          IDO_SPORT_TYPE_HIGH_LEG_LIFT=116,
        /**
         * 拳击
         */
          IDO_SPORT_TYPE_BOXING=117,
        /**
         * 杠铃
         */
          IDO_SPORT_TYPE_BARBELL=118,
        /**
         * 武术
         */
          IDO_SPORT_TYPE_MARTIAL_ART=119,
        /**
         * 太极
         */
          IDO_SPORT_TYPE_TAI_CHI=120,
        /**
         * 跆拳道
         */
          IDO_SPORT_TYPE_TAEKWONDO=121,
        /**
         * 空手道
         */
          IDO_SPORT_TYPE_KARATE=122,
        /**
         * 自由搏击
         */
          IDO_SPORT_TYPE_FREE_FIGHT=123,
        /**
         * 击剑
         */
          IDO_SPORT_TYPE_FENCING=124,
        /**
         * 射箭
         */
          IDO_SPORT_TYPE_ARCHERY=125,
        /**
         * 体操
         */
          IDO_SPORT_TYPE_ARTISTIC_GYMNASTICS=126,
        /**
         * 单杠
         */
          IDO_SPORT_TYPE_HORIZONTAL_BAR=127,
        /**
         * 双杠
         */
          IDO_SPORT_TYPE_PARALLEL_BARS=128,
        /**
         * 漫步机
         */
          IDO_SPORT_TYPE_WALKING_MACHINE=129,
        /**
         * 登山机
         */
          IDO_SPORT_TYPE_MOUNTAINEERING_MACHINE=130,
        /**
         * 保龄球
         */
          IDO_SPORT_TYPE_BOWLING=131,
        /**
         * 台球
         */
          IDO_SPORT_TYPE_BILLIARDS=132,
        /**
         * 曲棍球
         */
          IDO_SPORT_TYPE_HOCKEY=133,
        /**
         * 橄榄球
         */
          IDO_SPORT_TYPE_RUGBY=134,
        /**
         * 壁球
         */
          IDO_SPORT_TYPE_SQUASH=135,
        /**
         * 垒球
         */
          IDO_SPORT_TYPE_SOFTBALL=136,
        /**
         * 手球
         */
          IDO_SPORT_TYPE_HANDBALL=137,
        /**
         * 毽球
         */
          IDO_SPORT_TYPE_SHUTTLECOCK=138,
        /**
         * 沙滩足球
         */
          IDO_SPORT_TYPE_BEACH_SOCCER=139,
        /**
         * 藤球
         */
          IDO_SPORT_TYPE_SEPAKTAKRAW=140,
        /**
         * 躲避球
         */
          IDO_SPORT_TYPE_DODGEBALL=141,
        /**
         * 街舞
         */
          IDO_SPORT_TYPE_HIP_HOP=152,
        /**
         * 芭蕾
         */
          IDO_SPORT_TYPE_BALLET=153,
        /**
         * 社交舞
         */
          IDO_SPORT_TYPE_SOCIAL_DANCE=154,
        /**
         * 飞盘
         */
          IDO_SPORT_TYPE_FRISBEE=155,
        /**
         * 飞镖
         */
          IDO_SPORT_TYPE_DARTS=156,
        /**
         * 骑马
         */
          IDO_SPORT_TYPE_RIDING=157,
        /**
         * 爬楼
         */
          IDO_SPORT_TYPE_CLIMB_BUILDING=158,
        /**
         * 放风筝
         */
          IDO_SPORT_TYPE_KITE_FLYING=159,
        /**
         * 钓鱼
         */
          IDO_SPORT_TYPE_GO_FISHING=160,
        /**
         * 雪橇
         */
          IDO_SPORT_TYPE_SLED=161,
        /**
         * 雪车
         */
          IDO_SPORT_TYPE_SNOWMOBILE=162,
        /**
         * 单板滑雪
         */
          IDO_SPORT_TYPE_SNOWBOARDING=163,
        /**
         * 雪上运动
         */
          IDO_SPORT_TYPE_SNOW_IDO_SPORTS=164,
        /**
         * 高山滑雪
         */
          IDO_SPORT_TYPE_ALPINE_SKIING=165,
        /**
         * 越野滑雪
         */
          IDO_SPORT_TYPE_CROSS_COUNTRY_SKIING=166,
        /**
         * 冰壶
         */
          IDO_SPORT_TYPE_CURLING=167,
        /**
         * 冰球
         */
          IDO_SPORT_TYPE_ICE_HOCKEY=168,
        /**
         * 冬季两项
         */
          IDO_SPORT_TYPE_WINTER_BIATHLON=169,
        /**
         * 冲浪
         */
          IDO_SPORT_TYPE_SURFING=170,
        /**
         * 帆船
         */
          IDO_SPORT_TYPE_SAILBOAT=171,
        /**
         * 帆板
         */
          IDO_SPORT_TYPE_SAILBOARD=172,
        /**
         * 皮艇
         */
          IDO_SPORT_TYPE_KAYAK=173,
        /**
         * 摩托艇
         */
          IDO_SPORT_TYPE_MOTORBOAT=174,
        /**
         * 划艇
         */
          IDO_SPORT_TYPE_ROWBOAT=175,
        /**
         * 赛艇
         */
          IDO_SPORT_TYPE_ROWING=176,
        /**
         * 龙舟
         */
          IDO_SPORT_TYPE_DRAGON_BOAT=177,
        /**
         * 水球
         */
          IDO_SPORT_TYPE_WATER_POLO=178,
        /**
         * 漂流
         */
          IDO_SPORT_TYPE_DRIFT=179,
        /**
         * 滑板
         */
          IDO_SPORT_TYPE_SKATE=180,
        /**
         * 攀岩
         */
          IDO_SPORT_TYPE_ROCK_CLIMBING=181,
        /**
         * 蹦极
         */
          IDO_SPORT_TYPE_BUNGEE_JUMPING=182,
        /**
         * 跑酷
         */
          IDO_SPORT_TYPE_PARKOUR=183,
        /**
         * BMX 越野自行车
         */
          IDO_SPORT_TYPE_BMX=184,
};

#endif /* IDOSportTypeEnum_h */
