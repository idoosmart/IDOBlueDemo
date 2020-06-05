//
//  IDORulerView.h
//  IDOUIKitDemo
//
//  Created by 农大浒 on 2020/3/13.
//  Copyright © 2020 农大浒. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IDORulerViewConfig.h"

NS_ASSUME_NONNULL_BEGIN



@interface IDORulerView : UIView

/**
 配置数据的模型
 */
@property (nonatomic, strong) IDORulerViewConfig *rulerConfig;


/**
 初始化刻度盘
 
 @param frame 刻度盘尺寸
 @param maxValue 最大值
 @param minValue 最小值
 @param scaleSpace 刻度间距
 @param isInteger 是否为整数，如果不是整数只能是小数点后一位
 */
- (instancetype)initWithFrame:(CGRect)frame
                     maxValue:(NSInteger)maxValue
                     minValue:(NSInteger)minValue
                   scaleSpace:(CGFloat)scaleSpace
                    isInteger:(BOOL)isInteger
               directionStyle:(IDORulerDirectionStyle)directionStyle;

/**
 回调
 */
@property (nonatomic, copy) void (^rulerValueReturnBlcok) (CGFloat rulerVaue, BOOL isInteger);

@end

NS_ASSUME_NONNULL_END
