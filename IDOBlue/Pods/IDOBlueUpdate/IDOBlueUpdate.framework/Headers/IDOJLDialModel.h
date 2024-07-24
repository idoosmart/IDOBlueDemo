//
//  IDOJLDialModel.h
//  IDOBlueUpdate
//
//  Created by hedongyang on 2024/4/22.
//  Copyright © 2024 何东阳. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, JL_FONT_TYPE) {
    JL_FONT_TYPE_ONE = 109,//默认字体
    JL_FONT_TYPE_TWO, //2号字体
    JL_FONT_TYPE_THREE, //3号字体
    JL_FONT_TYPE_MAX //大号字体
};

typedef NS_ENUM(NSInteger, JL_PLACEMENT_TYPE) {
    JL_PLACEMENT_LEFT_TOP = 100,//时间左边顶部 （当前支持）
    JL_PLACEMENT_CENTER_TOP, //时间中心顶部 （当前支持）
    JL_PLACEMENT_RIGHT_TOP, //时间右边顶部 （暂不支持）
    JL_PLACEMENT_LEFT_CENTER, //时间左边居中 （暂不支持）
    JL_PLACEMENT_CENTER_CENTER, //时间中心居中 （暂不支持）
    JL_PLACEMENT_RIGHT_CENTER, //时间右边居中 （暂不支持）
    JL_PLACEMENT_LEFT_BOTTOM, //时间左边底部 （暂不支持）
    JL_PLACEMENT_CENTER_BOTTOM, //时间中心底部 （当前支持）
    JL_PLACEMENT_RIGHT_BOTTOM, //时间右边底部 （暂不支持）
    JL_PLACEMENT_MAX //全屏 （暂不支持）
};

NS_ASSUME_NONNULL_BEGIN

@interface IDOJLDialModel : NSObject
//背景图片
@property (nonatomic, strong) UIImage * backgroundImage;
//字体颜色
@property (nonatomic, assign) UInt32 textColor;
//字体大小
@property (nonatomic, assign) JL_FONT_TYPE fontType;
//布局类型
@property (nonatomic, assign) JL_PLACEMENT_TYPE placementType;
@end

NS_ASSUME_NONNULL_END
