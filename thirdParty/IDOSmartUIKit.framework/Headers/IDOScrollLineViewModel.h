//
//  IDOScrollLineViewModel.h
//  IDOEducation
//
//  Created by 农大浒 on 2019/12/6.
//  Copyright © 2019 TigerNong. All rights reserved.
//

#import "IDOFixedColumnarViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface IDOScrollLineViewModel : IDOFixedColumnarViewModel

/**
 点之间的距离
 */
@property (nonatomic, assign) CGFloat pointMarginWidth;

/**
 曲线的颜色
 */
@property (nonatomic, strong) UIColor *lineColor;

/**
 线条的宽度
 */
@property (nonatomic, assign) CGFloat lineWidth;

@end

NS_ASSUME_NONNULL_END
