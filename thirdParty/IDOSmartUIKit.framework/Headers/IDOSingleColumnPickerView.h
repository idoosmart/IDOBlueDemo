//
//  IDOSingleColumnPickerView.h
//  IDOEducation
//
//  Created by TigerNong on 2019/11/5.
//  Copyright © 2019 TigerNong. All rights reserved.
//

#import "IDOBasePickerView.h"

NS_ASSUME_NONNULL_BEGIN

@interface IDOSingleColumnPickerView : IDOBasePickerView

/**
 传进来的字符串数组，数据源
 */
@property (nonatomic, strong) NSArray <NSString *>*datas;

/**
 之前选中的数据
 */
@property (nonatomic, copy) NSString *lastSeletedString;

/**
 单位
 */
@property (nonatomic, copy) NSString *unit;

/**
 单位的字体颜色
 */

@property (nonatomic, strong) UIColor *textColor;

/**
 字体的大小
 */
@property (nonatomic, strong) UIFont *textFont;


/**
 自定义单位标签
 */
@property (nonatomic, strong) UILabel *customUnitLabel;


/**
 行高,默认是44
 */
@property (nonatomic, assign) CGFloat rowHeight;

@end

NS_ASSUME_NONNULL_END
