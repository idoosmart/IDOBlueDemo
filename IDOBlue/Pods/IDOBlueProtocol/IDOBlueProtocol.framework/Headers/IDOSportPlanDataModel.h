//
//  IDOSportPlanDataModel.h
//  IDOBlueProtocol
//
//  Created by hedongyang on 2022/4/20.
//  Copyright © 2022 何东阳. All rights reserved.
//

#import <Foundation/Foundation.h>
#if __has_include(<IDOBlueProtocol/IDOBlueProtocol.h>)
#else
#import "IDOBluetoothBaseModel.h"
#endif

NS_ASSUME_NONNULL_BEGIN

@interface IDOSportPlanDataModel : IDOBluetoothBaseModel

//计划版本号 00
@property (nonatomic,assign) NSInteger planVersion;

//操作：0x01 ：开始计划 ， 0x02：计划数据下发  ， 0x03结束计划 ， 0x04查询跑步计划
@property (nonatomic,assign) NSInteger operate;

//计划类型：0x01：跑步计划3km ，0x02：跑步计划5km ， 0x03：跑步计划10km ，0x04：半程马拉松训练（二期） ，0x05：马拉松训练（二期）
@property (nonatomic,assign) NSInteger type;

//计划开始时间 年
@property (nonatomic,assign) NSInteger year;

//计划开始时间 月
@property (nonatomic,assign) NSInteger month;

//计划开始时间 日
@property (nonatomic,assign) NSInteger day;

//计划开始时间 时
@property (nonatomic,assign) NSInteger hour;

//计划开始时间 分
@property (nonatomic,assign) NSInteger minute;

//计划开始时间 秒
@property (nonatomic,assign) NSInteger second;

@end

@interface IDOSportActionDataModel : IDOBluetoothBaseModel
//动作类型  1快走；2慢跑；3中速跑；4快跑
@property (nonatomic,assign) NSInteger type;
//目标时间  单位秒
@property (nonatomic,assign) NSInteger time;
//心率范围低值
@property (nonatomic,assign) NSInteger lowHeart;
//心率范围高值
@property (nonatomic,assign) NSInteger heightHeart;

@end

@interface IDOSportContentDataModel : IDOBluetoothBaseModel
//训练类型 计划休息:186  , 计划户外跑步:187 ，计划室内跑步:188，计划室内健身:189
@property (nonatomic,assign) NSInteger type;
//动作个数
@property (nonatomic,assign) NSInteger num;
//动作集合
@property (nonatomic,strong) NSArray<IDOSportActionDataModel *> * items;

@end

@interface IDOSportPlanSetDataModel : IDOSportPlanDataModel

//计划天数(item)个数
@property (nonatomic,assign) NSInteger dayNum;

//计划集合
@property (nonatomic,strong) NSArray<IDOSportContentDataModel *> * items;

@end

@interface IDOBleNoticeAppPlanModel : IDOSportPlanDataModel
//动作类型  1快走；2慢跑；3中速跑；4快跑  ；5结束课程运动 （还要等待用户是否有自由运动）；6课程结束后自由运动 （此字段当operate为0x05起作用）
@property (nonatomic,assign) NSInteger actionType;
//目标时间  单位秒
@property (nonatomic,assign) NSInteger time;
//心率范围低值
@property (nonatomic,assign) NSInteger lowHeart;
//心率范围高值
@property (nonatomic,assign) NSInteger heightHeart;
@end

@interface IDOBleNoticeAppReplyPlanModel : IDOSportPlanDataModel
//动作类型  1快走；2慢跑；3中速跑；4快跑  ；5结束课程运动 （还要等待用户是否有自由运动）；6课程结束后自由运动 （此字段当operate为0x05起作用）
@property (nonatomic,assign) NSInteger actionType;
//00成功   其他失败
@property (nonatomic,assign) NSInteger errorCode;
@end

@interface IDOAppNoticeBlePlanModel : IDOSportPlanDataModel
//目标时间  单位秒
@property (nonatomic,assign) NSInteger time;
//心率范围低值
@property (nonatomic,assign) NSInteger lowHeart;
//心率范围高值
@property (nonatomic,assign) NSInteger heightHeart;

@end

@interface IDOAppNoticeBleReplyPlanModel : IDOSportPlanDataModel
//0x00:成功 其他失败
@property (nonatomic,assign) NSInteger errorCode;
//动作类型  1快走；2慢跑；3中速跑；4快跑  ；5结束课程运动 （还要等待用户是否有自由运动）；6课程结束后自由运动 （此字段当operate为0x05起作用）
@property (nonatomic,assign) NSInteger actionType;

@end

NS_ASSUME_NONNULL_END
