//
//  IDOSportSettingModel.h
//  IDOCoreSport
//
//  Created by 鲁鲁骁 on 2020/7/20.
//  Copyright © 2020 xiongze. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, IDOSPortTargetType) {
    IDOSPortTargetTypeNull  = 0,
    IDOSPortTargetTypeStep,
    IDOSPortTargetTypeDistance,
    IDOSPortTargetTypeCalories,
    IDOSPortTargetTypeTime,
};


@interface IDOSportSettingModel : NSObject
/**
 *  userId
 */
@property (nonatomic , copy)  NSString *userId;
/**
 *  设备MAC地址
 */
@property (nonatomic , copy)  NSString *macAddr;
/**
 *  时间戳
 */
@property (nonatomic, strong) NSString *timestamp;
/**
 *  目标
 */
@property (nonatomic , copy) NSString *sportTarget;
/**
 *  目标类型
 */
@property (nonatomic, assign) IDOSPortTargetType targetType;
/**
 *  声音提醒
 */
@property (nonatomic, copy) NSString *voiceReminder;
/**
 *  是否声音提醒
 */
@property (nonatomic , assign) BOOL isVoiceReminder;
/**
 *  心率提醒
 */
@property (nonatomic , copy)  NSString *hrReminder;
/**
 *  最大心率
 */
@property (nonatomic , copy)  NSString *maxHr;
/**
 *  是否心率提醒
 */
@property (nonatomic, assign) BOOL isHrReminder;

@end

NS_ASSUME_NONNULL_END
