//
//  IDOAlertCommonHeader.h
//  IDOEducation
//
//  Created by TigerNong on 2019/11/16.
//  Copyright © 2019 TigerNong. All rights reserved.
//

#ifndef IDOAlertCommonHeader_h
#define IDOAlertCommonHeader_h
#import "IDOAlertViewConfig.h"
#import "IDOAletViewItemModel.h"

#define IDOAlertViewConfigShareInstance [IDOAlertViewConfig shareInstance]


#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width


#define SCREEN_WIDTH_Size   kScreenWidth/375

#define IPHONEXPLUSORNOT  (kScreenHeight >= 812.0)

#define ButtonHeigth  39.0f
#define MARGIN        25 // 坐标轴与画布间距

#define SafeAreaTopHeight (kScreenHeight == 812.0 ? 88 : 64)
#define SafeAreatabHeight (kScreenHeight == 812.0 ? 34 : 0)


#define kTableViewBackgroudColor [UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1.0]


//selectedArr 只有在多选的情况下才会有值，其他情况都是nil,存放的是穿进去的下标
typedef void(^IDOAlertViewHandleBlock)(NSInteger index, NSArray <NSNumber *>*selectedArr);

//提示框显示的位置
typedef NS_ENUM(NSInteger, IDOAlertViewPositionType) {
    IDOAlertViewPositionTypeFromTop     = 0, //显示在上边
    IDOAlertViewPositionTypeFromCenter  = 1, //显示在中间
    IDOAlertViewPositionTypeFromBottom  = 2,//显示在下边
};

//多个item情况下，右侧是否显示按钮，右侧的按钮根据类型显示不同的图片
typedef NS_ENUM(NSInteger, IDOAlertViewItemRightViewType) {
    IDOAlertViewItemRightViewTypeNone              = 0, //不显示右侧按钮
    IDOAlertViewItemRightViewTypeSingleSelected    = 1, //显示选中和未选中的图片,只能进行单选
    IDOAlertViewItemRightViewTypeMultipleSelected  = 2, //显示选中和未选中的图片,可以进行多选
    IDOAlertViewItemRightViewTypeDelete            = 3,//删除
};

//两个按钮的情况的布吉
typedef NS_ENUM(NSInteger, IDOTwoItemLayoutType) {
    IDOTwoItemLayoutTypeCancelLeft     = 0, //取消按钮在左边
    IDOTwoItemLayoutTypeCancelRight    = 1, //取消按钮在右边
    IDOTwoItemLayoutTypeCancelTop      = 2,//取消按钮在上边
    IDOTwoItemLayoutTypeCancelBottom   = 3 // 取消按钮在下边
};





#endif /* IDOAlertCommonHeader_h */
