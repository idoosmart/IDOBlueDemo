//
//  IDOStatisticsModel.h
//  IDOBlueProtocol
//
//  Created by hedongyang on 2022/4/15.
//  Copyright © 2022 何东阳. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IDOStatisticsModel : NSObject

@end

@interface IDOBrowseModel : IDOStatisticsModel
//特性名称 0x01：跑步课程  ， 0x02：跑步计划 ，  0x03：设备睡眠   ，0x04体重
@property (nonatomic,assign) NSInteger type;
//事件  0x01：浏览跑步课程 ，0x02：浏览跑步计划 ，  0x03：浏览睡眠  ，0x04：睡眠呼吸  ，0x05：点击设备体重管理入口
@property (nonatomic,assign) NSInteger event;
//浏览年份
@property (nonatomic,assign) NSInteger year;
//浏览月份
@property (nonatomic,assign) NSInteger month;
//浏览日期
@property (nonatomic,assign) NSInteger day;
//浏览时钟
@property (nonatomic,assign) NSInteger hour;
//浏览分钟
@property (nonatomic,assign) NSInteger minute;
//浏览秒钟
@property (nonatomic,assign) NSInteger second;
//浏览次数
@property (nonatomic,assign) NSInteger count;

@end

@interface IDOImplementModel : IDOStatisticsModel
// 特性名称 0x01：跑步课程  ， 0x02：跑步计划 ，0x03：跑后拉伸
@property (nonatomic,assign) NSInteger type;
//事件 0x01：使用跑步课程  ，0x02：执行跑步计划 ，0x03：执行跑后拉伸
@property (nonatomic,assign) NSInteger event;
//执行年份
@property (nonatomic,assign) NSInteger startYear;
//执行月份
@property (nonatomic,assign) NSInteger startMonth;
//执行日期
@property (nonatomic,assign) NSInteger startDay;
//执行时钟
@property (nonatomic,assign) NSInteger startHour;
//执行分钟
@property (nonatomic,assign) NSInteger startMinute;
//执行秒钟
@property (nonatomic,assign) NSInteger startSecond;
//结束年份
@property (nonatomic,assign) NSInteger endYear;
//结束月份
@property (nonatomic,assign) NSInteger endMonth;
//结束日期
@property (nonatomic,assign) NSInteger endDay;
//结束时钟
@property (nonatomic,assign) NSInteger endHour;
//结束分钟
@property (nonatomic,assign) NSInteger endMinute;
//结束秒钟
@property (nonatomic,assign) NSInteger endSecond;
//点击次数
@property (nonatomic,assign) NSInteger count;
@end

@interface IDOUserHabitModel : IDOStatisticsModel
//版本
@property (nonatomic,assign) NSInteger version;
//size
@property (nonatomic,assign) NSInteger size;
//浏览个数
@property (nonatomic,assign) NSInteger browseCount;
//执行个数
@property (nonatomic,assign) NSInteger implementCount;
//浏览集合
@property (nonatomic,strong) NSArray<IDOBrowseModel *> * items1;
//执行集合
@property (nonatomic,strong) NSArray<IDOImplementModel *> * items2;

@end


NS_ASSUME_NONNULL_END
