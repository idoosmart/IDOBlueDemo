//
//  IDOValueModel.h
//  IDOEducation
//
//  Created by 农大浒 on 2019/11/26.
//  Copyright © 2019 TigerNong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IDOValueModel : NSObject

//是在那个点显示x轴对应的数值，比如假设当吧整个横坐标分成100分，整个横坐标为24小时的间隔，则假设当前时间为12：00，则这个index为100/2 - 1
@property (nonatomic, assign) NSInteger index;

//对应于显示在x轴中的数据，比如时间
@property (nonatomic, copy) NSString *xValue;

//对应于y的值，具体的数值
@property (nonatomic, copy) NSString *yValue;

@end

NS_ASSUME_NONNULL_END
