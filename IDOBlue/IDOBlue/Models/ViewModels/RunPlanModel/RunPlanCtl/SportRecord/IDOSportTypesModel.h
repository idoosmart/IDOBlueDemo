//
//  IDOSportTypesModel.h
//  IDOCoreSport
//
//  Created by 鲁鲁骁 on 2020/7/27.
//  Copyright © 2020 xiongze. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IDOSportTypesModel : NSObject
/**
 *  userId
 */
@property (nonatomic , copy)  NSString *userId;
/**
 *  设备MAC地址
 */
@property (nonatomic , copy)  NSString *macAddr;
/**
 *  显示的运动
 */
@property (nonatomic , strong) NSArray <NSNumber *>*showSports;
/**
 *  隐藏的运动
 */
@property (nonatomic , strong) NSArray <NSNumber *>*hideSports;

@end

NS_ASSUME_NONNULL_END
