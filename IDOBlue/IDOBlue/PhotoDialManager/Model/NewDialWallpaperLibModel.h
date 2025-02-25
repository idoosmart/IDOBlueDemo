//
//  NewDialWallpaperLibModel.h
//  IDOBlue
//
//  Created by cyf on 2025/2/25.
//  Copyright © 2025 hedongyang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

///照片云表盘LibModel  2.2.0添加
@interface NewDialWallpaperLibModel: NSObject

///是否支持功能 默认0不支持，  1：支持功能切换
@property (nonatomic, assign) BOOL  function_support;

///是否支持修改时间显示位置，默认0支持 1表盘不支持
@property (nonatomic, assign) BOOL  no_support_location;

///是否支持修改颜色，默认0支持 1表盘不支持
@property (nonatomic, assign) BOOL  no_support_colors;

@end


NS_ASSUME_NONNULL_END
