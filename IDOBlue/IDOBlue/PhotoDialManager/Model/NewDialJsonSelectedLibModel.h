//
//  NewDialJsonSelectedLibModel.h
//  IDOBlue
//
//  Created by cyf on 2025/2/24.
//  Copyright © 2025 hedongyang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewDialJsonSelectedLibModel: NSObject

///样式图
@property (nonatomic,   copy) NSString *style;

///选中的背景图
@property (nonatomic,   copy) NSString *selectBG;

///颜色索引
@property (nonatomic, assign) NSInteger color;//索引

///表盘样式索引 旧的自定表盘用到
@property (nonatomic, assign) NSInteger dialStyle;//索引


///功能表 如果某一项为空 表示关闭显示
@property (nonatomic, strong) NSArray<NSString *>  *function;

///调色板
@property (nonatomic, assign) NSInteger  paletteIndex;

///选中的背景图
@property (nonatomic,   strong) NSString *worldClock;

///照片表盘的时间颜色
@property (nonatomic, assign) NSInteger timeColorIndex;

///照片表盘的时间颜色
@property (nonatomic, assign) NSInteger funcColorIndex;

///照片表盘的时间、功能的位置
@property (nonatomic, assign) NSInteger timeFuncLocation;

///功能的位置类型
@property (nonatomic, assign) NSInteger funcLocationType;

///功能的颜色
@property (nonatomic, copy) NSString*  funcBgColor;

///功能的颜色
@property (nonatomic, copy) NSString* funcFgColor;

///选中的倒计时的值
@property (nonatomic, strong) NSArray<NSNumber *>  *counterTimers;

@end

NS_ASSUME_NONNULL_END
