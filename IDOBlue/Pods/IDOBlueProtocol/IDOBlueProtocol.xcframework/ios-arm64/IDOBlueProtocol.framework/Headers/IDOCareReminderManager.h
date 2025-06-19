//
//  CareReminderManager.h
//  IDOBlueProtocol
//
//  Created by cyf on 2024/10/25.
//  Copyright © 2024 何东阳. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IDOCareReminderManager : NSObject

/// 设置关爱提醒 | Set Care Reminder
/// @param model IDOSetCareReminderModel
/// __IDO_FUNCTABLE__.funcTable42Model.supportFamilyCareReminder
/// @param callback 设置后回调 (errorCode : 0 传输成功,其他值为错误,可以根据 IDOErrorCodeToStr 获取错误码str)
/// Set post callback (errorCode : 0 transfer succeeds, other values are wrong, you can get error code str according to IDOErrorCodeToStr)
+ (void)setCareReminderCommand:(IDOSetCareReminderModel *_Nullable)model callback:(void (^_Nullable)(int errorCode))callback;

/**
 * @brief  获取是否支持关爱提醒  | Get Care Reminder
 *  * 功能表 | Function Table :  __IDO_FUNCTABLE__.funcTable42Model.supportFamilyCareReminder
 */
+ (void)getCareReminderCommand:(void (^_Nullable)(int errorCode,NSInteger supportCareReminder,NSInteger supportSateChangeReminder,NSInteger supportSleepDeprivationReminder,NSInteger supportMenstrualStateReminder))callback;

@end

NS_ASSUME_NONNULL_END
