//
//  IDOListPickerView.h
//  IDOSmartUIKit
//
//  Created by 农大浒 on 2020/5/6.
//  Copyright © 2020 农大浒. All rights reserved.
//

#import <IDOSmartUIKit/IDOSmartUIKit.h>
#import "IDOListPickerModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, IDOListPickerCellStyle) {
    IDOListPickerCellStyleDefault,    // Simple cell with text label and optional image view (behavior of UITableViewCell in iPhoneOS 2.x)
    IDOListPickerCellStyleValue1,        // Left aligned label on left and right aligned label on right with blue text (Used in Settings)
    IDOListPickerCellStyleSubtitle    // Left aligned label on top and left aligned label on bottom with gray text (Used in iPod).
};


typedef NS_ENUM(NSInteger, IDOListPickerCellSelectedStyle) {
    IDOListPickerCellSelectedStyleSingle ,
    IDOListPickerCellSelectedStyleMul,
    IDOListPickerCellSelectedStyleNone,
};


@interface IDOListPickerView : IDOBasePickerView

/**
 标题的样式
 */
@property (nonatomic, assign) IDOListPickerCellStyle cellStyle;

/**
 标题的样式
 */
@property (nonatomic, assign) IDOListPickerCellStyle selectStyle;

/**
 是否必须存在有一个选中的，默认是YES
 */
@property (nonatomic, assign) BOOL defaultOneSelected;

/**
 是否隐藏按钮
 */
@property (nonatomic, assign) BOOL hiddenToolBar;

/**
 默认是44
 */
@property (nonatomic, assign) CGFloat cellRowHeight;

/**
 几个控件的frame
 */
@property (nonatomic, assign) CGRect itemTitleLabelFrame;
@property (nonatomic, assign) CGRect itemDetailTitleLabelFrame;
@property (nonatomic, assign) CGRect itemRightImageViewFrame;
@property (nonatomic, assign) CGRect itemBottomLineFrame;

/**
 列表的背景颜色
 */
@property (nonatomic, strong) UIColor *listbackGroundColor;

/**
 底部线条的背景颜色
 */
@property (nonatomic, strong) UIColor *itemBottomLineColor;

/**
 主标题的颜色
 */
@property (nonatomic, strong) UIColor *itemTitleTextColor;

/**
 子标题的颜色
 */
@property (nonatomic, strong) UIColor *itemDetailTitleTextColor;


/**
 主标题的字体
 */
@property (nonatomic, strong) UIFont *itemTitleFont;

/**
 子标题的字体
 */
@property (nonatomic, strong) UIFont *itemDetailTitleFont;

/**
 传进来的字符串数组，数据源
 */
@property (nonatomic, strong) NSArray <IDOListPickerModel *>*datas;


/**
 选择回调
 */
@property (nonatomic, copy) void(^didSelectedAction)(NSArray <NSString *>*indexs);


@end

NS_ASSUME_NONNULL_END
