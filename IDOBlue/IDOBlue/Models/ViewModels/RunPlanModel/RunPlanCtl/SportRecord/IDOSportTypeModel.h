//
//  IDOSportTypeModel.h
//  IDOVFResources
//
//  Created by Warp on 2022/3/1.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//【金山文档】 115种运动展示数据
//https://kdocs.cn/l/chSYoiDjbHSE

typedef NS_OPTIONS(NSInteger, IDOAllSportMainType) {
    IDOAllSportMainTypeBasic    = 1,    //基础运动
    IDOAllSportMainTypeFitness  = 2,    //健身
    IDOAllSportMainTypeBalls    = 3,    //球类
    IDOAllSportMainTypeLeisure  = 4,    //休闲运动
    IDOAllSportMainTypeWinter   = 5,    //冰雪运动
    IDOAllSportMainTypeWater    = 6,    //水上运动
    IDOAllSportMainTypeExtreme  = 7,    //极限运动
};

//运动计划的运动类型
typedef NS_OPTIONS(NSInteger, IDOPlanSportType) {
    IDOPlanSportType3km                = 1,    //跑步计划3公里
    IDOPlanSportType5km                = 2,    //跑步计划5公里
    IDOPlanSportType10km               = 3,    //跑步计划10公里
    IDOPlanSportTypeHalfMarathon       = 4,    //半程马拉松训练（二期）
    IDOPlanSportTypeMarathon           = 5,    //马拉松训练（二期）
    
    IDOPlanSportType6MinuteEasyRun     = 64,    //6分钟轻松跑
    IDOPlanSportType10MinuteEasyRun    = 65,    //10分钟轻松跑
    IDOPlanSportType15MinuteEasyRun    = 66,    //15分钟轻松跑
    
    IDOPlanSportTypePrimaryWalkAndRun  = 67,    //走跑结合初级
    IDOPlanSportTypeMediumWalkAndRun   = 68,    //走跑结合进阶
    IDOPlanSportTypeAdvanceWalkAndRun  = 69,    //走跑结合强化
    
    IDOPlanSportTypePostRunStretch     = 128, //跑步拉伸
    IDOPlanSportTypePostRunPreRunWarmUp     = 129, //跑前热身
};


/**
 运动类型 与SDK 对应
 */
typedef NS_OPTIONS(NSInteger, IDOAllSportType) {
    IDOAllSportTypeNone                           = 0,    //无运动
    IDOAllSportTypeWalk                           = 1,    //走路
    IDOAllSportTypeRun                            = 2,    //跑步
    IDOAllSportTypeBike                           = 3,    //骑行
    IDOAllSportTypeHike                           = 4,    //徒步
    IDOAllSportTypeSwim                           = 5,    //游泳
    IDOAllSportTypeClimb                          = 6,    //爬山
    IDOAllSportTypeBadminton                      = 7,    //羽毛球
    IDOAllSportTypeOther                          = 8,    //其他
    IDOAllSportTypeFitness                        = 9,    //健身
    IDOAllSportTypeSpinning                       = 10,   //动感单车
    IDOAllSportTypeElliptical                     = 11,   //椭圆机
    IDOAllSportTypeTreadmill                      = 12,   //跑步机
    IDOAllSportTypeSitUps                         = 13,   //仰卧起坐
    IDOAllSportTypePushUps                        = 14,   //俯卧撑
    IDOAllSportTypeDumbbells                      = 15,   //哑铃
    IDOAllSportTypeWeightlifting                  = 16,   //举重
    IDOAllSportTypeAerobics                       = 17,   //健身操
    IDOAllSportTypeYoga                           = 18,   //瑜伽
    IDOAllSportTypeJumpRope                       = 19,   //跳绳
    IDOAllSportTypeTableTennis                    = 20,   //乒乓球
    IDOAllSportTypeBasketball                     = 21,   //篮球
    IDOAllSportTypeFootball                       = 22,   //足球
    IDOAllSportTypeVolleyball                     = 23,   //排球
    IDOAllSportTypeTennis                         = 24,   //网球
    IDOAllSportTypeGolf                           = 25,   //高尔夫球
    IDOAllSportTypeBaseball                       = 26,   //棒球
    IDOAllSportTypeSkiing                         = 27,   //滑雪
    IDOAllSportTypeRollerSkating                  = 28,   //轮滑
    IDOAllSportTypedancing                        = 29,   //跳舞
    
    IDOAllSportTypePilates                        = 32,    //普拉提运动
    IDOAllSportTypeCrossTraining                  = 33,    //交叉训练
    IDOAllSportTypeAerobicExercise                = 34,    //有氧运动
    IDOAllSportTypeZunbaDance                     = 35,    //尊巴舞
    IDOAllSportTypeSquareDance                    = 36,    //广场舞
    IDOAllSportTypePlank                          = 37,    //平板支撑
    IDOAllSportTypeGym                            = 38,    //健身房
    
    IDOAllSportTypeOutsideRun                     = 48,    //户外跑步
    IDOAllSportTypeInsideRun                      = 49,    //室内跑步
    IDOAllSportTypeOutsideBike                    = 50,    //户外骑行
    IDOAllSportTypeIntsideBike                    = 51,    //室内骑行
    IDOAllSportTypeOutsideWalk                    = 52,    //户外步行
    IDOAllSportTypeInsideWalk                     = 53,    //室内步行
    IDOAllSportTypePoolSwimming                   = 54,    //泳池游泳
    IDOAllSportTypeOpenWaterSwimming              = 55,    //开放水域游泳
    IDOAllSportTypeEllipticalMachine              = 56,    //椭圆机
    IDOAllSportTypeRowingMachine                  = 57,    //划船机
    IDOAllSportTypeHighIntensityIntervalTraining  = 58,    //高强度间歇训练法
    IDOAllSportTypeOutsideCricket                 = 75,    //板球运动
    
    IDOAllSportTypeFreeTraining                   = 100,   //自由训练
    IDOAllSportTypeFunctionalStrengthTraining     = 101,   //整理放松
    IDOAllSportTypeCoreTraining                   = 102,   //核心训练
    IDOAllSportTypeStepper                        = 103,   //踏步机
    IDOAllSportTypeOrganizeAndRelax               = 104,   //整理放松
    
    
    IDOAllSportTypeTraditionalStrengthTraining    = 110,   //传统力量训练
    IDOAllSportTypePullUp                         = 112,   //引体向上
    IDOAllSportTypeOpeningAndClosingJump          = 114,   //开合跳
    IDOAllSportTypeSquat                          = 115,   //深蹲
    IDOAllSportTypeHighLegLift                    = 116,   //高抬腿
    IDOAllSportTypeBoxing                         = 117,   //拳击
    IDOAllSportTypeBarbell                        = 118,   //杠铃
    IDOAllSportTypeWushu                          = 119,   //武术
    IDOAllSportTypeTaiji                          = 120,   //太极
    IDOAllSportTypeKarate                         = 122,   //空手道
    IDOAllSportTypeTaekwondo                      = 121,   //跆拳道
    IDOAllSportTypeFreeFight                      = 123,   //自由搏击
    IDOAllSportTypeFencing                        = 124,   //击剑
    IDOAllSportTypeArchery                        = 125,   //射箭
    IDOAllSportTypeArtisticGymnastics             = 126,   //体操
    IDOAllSportTypeHorizontalBar                  = 127,   //单杠
    IDOAllSportTypeParallelBars                   = 128,   //双杠
    IDOAllSportTypeWalkingMachine                 = 129,   //漫步机
    IDOAllSportTypeMountaineeringMachine          = 130,   //登山机
    
    IDOAllSportTypeBowling                        = 131,   //保龄球
    IDOAllSportTypeBilliards                      = 132,   //台球
    IDOAllSportTypeHockey                         = 133,   //曲棍球
    IDOAllSportTypeRugby                          = 134,   //橄榄球
    IDOAllSportTypeSquash                         = 135,   //壁球
    IDOAllSportTypeSoftball                       = 136,   //垒球
    IDOAllSportTypeHandball                       = 137,   //手球
    IDOAllSportTypeShuttlecock                    = 138,   //毽球
    IDOAllSportTypeBeachSoccer                    = 139,   //沙滩足球
    IDOAllSportTypeSepaktakraw                    = 140,   //藤球
    IDOAllSportTypeDodgeball                      = 141,   //躲避球
    
    IDOAllSportTypeHiphop                         = 152,   //街舞
    IDOAllSportTypeBallet                         = 153,   //芭蕾
    IDOAllSportTypeSocialDance                    = 154,   //社交舞
    IDOAllSportTypeFrisbee                        = 155,   //飞盘
    IDOAllSportTypeDarts                          = 156,   //飞镖
    IDOAllSportTypeRiding                         = 157,   //骑马
    IDOAllSportTypeClimbbuilding                  = 158,   //爬楼
    IDOAllSportTypeflykite                        = 159,   //放风筝
    IDOAllSportTypeGofishing                      = 160,   //放风筝
    
    IDOAllSportTypeSled                           = 161,   //雪橇
    IDOAllSportTypeSnowmobile                     = 162,   //雪车
    IDOAllSportTypeSnowboarding                   = 163,   //单板滑雪
    IDOAllSportTypeSnowSports                     = 164,   //雪上运动
    IDOAllSportTypeAlpineskiing                   = 165,   //高山滑雪
    IDOAllSportTypeCrosscountryskiing             = 166,   //越野滑雪
    IDOAllSportTypeCurling                        = 167,   //冰壶
    IDOAllSportTypeIcehockey                      = 168,   //冰球
    IDOAllSportTypeWinterbiathlon                 = 169,   //冬季两项
    
    
    IDOAllSportTypeSurfing                        = 170,   //冲浪
    IDOAllSportTypeSailboat                       = 171,   //帆船
    IDOAllSportTypeSailboard                      = 172,   //帆板
    IDOAllSportTypeKayak                          = 173,   //皮艇
    IDOAllSportTypeMotorboat                      = 174,   //摩托艇
    IDOAllSportTypeRowboat                        = 175,   //划艇
    IDOAllSportTypeRowing                         = 176,   //赛艇
    IDOAllSportTypeDragonBoat                     = 177,   //龙舟
    IDOAllSportTypeWaterPolo                      = 178,   //水球
    IDOAllSportTypeDrift                          = 179,   //漂流
    
    IDOAllSportTypeSkate                          = 180,   //滑板
    IDOAllSportTypeRockClimbing                   = 181,   //攀岩
    IDOAllSportTypeBungeejumping                  = 182,   //蹦极
    IDOAllSportTypeParkour                        = 183,   //跑酷
    IDOAllSportTypeBMX                            = 184,   //BMX
    
    IDOAllSportTypeOutdoorFun                     = 193,   //户外玩耍
    IDOAllSportTypeOtherActivity                  = 194,   //其他运动
    
};

typedef NS_OPTIONS(NSInteger, IDOSportIconStyle) {
    IDOSportIconStyleDefault = 1,   //默认图标 0 也是默认图标，兼容旧数据
    IDOSportIconStyleSecond  = 2,   //第二套图标
    IDOSportIconStyleThird  = 3,   //第三套图标  运动图标按固件ID号兼容，为7606的设备 目前只有三张图（徒步 户外步行 泳池游泳 健身）不一样 其余都用默认图
};

NS_ASSUME_NONNULL_BEGIN

@class IDOSportTypeModel;

@interface IDOSportTypeManager : NSObject

///默认的顺序为SDK定义的apptye 顺序
@property (nonatomic, readonly, strong) NSArray<IDOSportTypeModel *> *allSportList;

///appKey : listIndex
@property (nonatomic, readonly, strong) NSDictionary<NSNumber *, NSNumber *> *allSportDict;


+ (instancetype)sharedInstance;

//刷新数据源，初始化时会调用加载（SportTypeList）文件
- (void)refershDataSource:(NSString *)jsonName;

//根据apptype 筛选Model类
- (IDOSportTypeModel *)sportModelForType:(IDOAllSportType)type;

//获取某种主类型的Models
- (NSArray<IDOSportTypeModel *> *)sportModelsForMainType:(IDOAllSportMainType)mainType;


//根据运动计划的类型获取对应的运动模型（目前运动计划类型中，只是使用了appType,name,nameKey,pngName）
- (IDOSportTypeModel *)planSportModelForActType:(IDOPlanSportType)actType;


@end

@interface IDOSportTypeModel : NSObject

//主类型，暂未用到
@property (nonatomic , assign) IDOAllSportMainType mainType;

//运动类型模型
@property (nonatomic , assign) IDOAllSportType appType;

//运动名称 备注
@property (nonatomic , strong) NSString *name;

//跑步计划的名称
@property (nonatomic , strong) NSString *planName;

//翻译用到的key
@property (nonatomic , strong) NSString *planNameKey;

//翻译用到的key
@property (nonatomic , strong) NSString *nameKey;

//bmp图标名
@property (nonatomic , strong) NSString *bmpName;

//png图标名
@property (nonatomic , strong) NSString *pngName;

//动画图标名
@property (nonatomic , strong) NSString *aiBmpName;

//动画图标帧数 > 1时 为动画图名
@property (nonatomic , assign) NSInteger aiBmpCount;

#pragma mark - 业务上使用

//是否已经添加运动
@property (nonatomic , assign)BOOL  isAddSport;

//图片是否安装
@property (nonatomic , assign)BOOL  imageIsLocal;

/**
 * 个位小图，十位大图 千位中图
 * 00 表示图标未下载
 * 01 001 表示小图标已下载；
 * 02 010 表示大图标已下载；
 * 03 011 表示小图标和大图表都已经下载；
 * 04 100 表示中等图片已经下载
 * 05 101,表示小图已下载，大图未下载，中图已下载
 * 06 110,表示小图未下载，大图已下载，中图已下载
 * 07 111,小中大图全部下载过了
 * 支持运动图标下发才有效
 */


@property (nonatomic, assign) NSInteger flag;

- (UIImage *)sportIconForTemplateMode;

//获取能渲染颜色的 运动图标
- (UIImage *)sportIconForTemplateMode:(IDOSportIconStyle)iconStyle;



@end

NS_ASSUME_NONNULL_END
