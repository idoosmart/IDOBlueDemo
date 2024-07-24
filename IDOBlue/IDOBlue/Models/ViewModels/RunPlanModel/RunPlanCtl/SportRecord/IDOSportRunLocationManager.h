//
//  IDOSportRunViewModel.h
//  IDOVFHome
//
//  Created by mac2019 on 2022/5/25.
//

#import <Foundation/Foundation.h>
#import "IDOSRailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface IDOSportRunLocationManager : NSObject

/**
 gps 数据数组
 */
@property (nonatomic,strong, readonly) NSArray <IDOSRailModel *>*railModels;

/**
 总距离，m
 */
@property (nonatomic,assign,readonly) CGFloat totalDistances;

/**
 信号强度  0 表示信号弱， 1：表示信号强
 
 在手机发起的运动过程中，如果信号强度为1的情况下，进行数据交换时候，就不会去获取固件中的距离
 
 */
@property (nonatomic,assign,readonly) NSInteger signalFlag;

+ (IDOSportRunLocationManager *)shareInstance;

/**
 进行定位
 @param startRunTimestamp 运动开始的时间戳
 */
- (void)startUpdatingLocationWithTimestamp:(NSInteger)startRunTimestamp;

/**
 停止定位
 */
- (void)stopLocation;

/**
 清除一些定位过程中，内存保存的一些数据
 */
- (void)clearAllData;

@end

NS_ASSUME_NONNULL_END
