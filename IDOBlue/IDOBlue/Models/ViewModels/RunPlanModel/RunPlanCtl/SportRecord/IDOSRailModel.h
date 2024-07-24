//
//  RailModel.h
//  IDOVFPTrajectory
//
//  Created by xiongze on 2018/10/25.
//  Copyright © 2018年 xiongze. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDOSRailModel : NSObject
/**
 *  userId
 */
@property (nonatomic , copy)  NSString *userId;
/**
 *  设备MAC地址
 */
@property (nonatomic , copy)  NSString *macAddr;
@property (nonatomic,  copy) NSString *latitude;
@property (nonatomic,  copy) NSString *longtitude;
@property (nonatomic,  copy) NSString *time_string;//记录当前经纬度时间
@property (nonatomic,  copy) NSString *contrailId;//轨迹ID

/*
 *  horizontalAccuracy
 *
 *  Discussion:
 *    Returns the horizontal accuracy of the location. Negative if the lateral location is invalid.
 */
@property(assign, nonatomic) double horizontalAccuracy;

/*
 *  verticalAccuracy
 *
 *  Discussion:
 *    Returns the vertical accuracy of the location. Negative if the altitude is invalid.
 */
@property(assign, nonatomic) double verticalAccuracy;

/*
 *  speed
 *
 *  Discussion:
 *    Returns the speed of the location in m/s. Negative if speed is invalid.
 */
@property(assign, nonatomic) double speed API_AVAILABLE(ios(2.2), macos(10.7));

/*
 *  speedAccuracy
 *
 *  Discussion:
 *    Returns the speed accuracy of the location in m/s. Returns -1 if invalid.
 */
@property(assign, nonatomic) double speedAccuracy API_AVAILABLE(macos(10.15), ios(10.0), watchos(3.0), tvos(10.0));

/*
 *  timestamp
 *
 *  Discussion:
 *    Returns the timestamp when this location was determined.
 */
@property(assign, nonatomic) NSInteger timestamp;

/*
 *  altitude 海拔
 *
 *  Discussion:
 *    Returns the altitude of the location. Can be positive (above sea level) or negative (below sea level).
 *    返回位置的高度。可以是正值（高于海平面）或负值（低于海平面）。
 */
@property(assign, nonatomic) CGFloat altitude;

@end
