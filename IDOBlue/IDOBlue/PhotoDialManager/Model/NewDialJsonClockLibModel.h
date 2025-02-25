//
//  NewDialJsonClockLibModel.h
//  IDOBlue
//
//  Created by cyf on 2025/2/24.
//  Copyright © 2025 hedongyang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - 时间指针的对象

@interface NewDialJsonClockLibModel: NSObject

///是否支持根据选中的颜色 子功能项button 来渲染前景色
@property (nonatomic, assign) BOOL canChangeColor;//是否支持修改颜色

@property (nonatomic,   copy) NSString *image;//图片名

//时间的样式  0默认的时间  1世界时钟
@property (nonatomic, assign) NSInteger type;

///时间的位置
@property (nonatomic, assign) CGRect location;

///世界时钟的 定位城市名的位置， type=1时 有用
@property (nonatomic, assign) CGRect cityLocation;

@end
NS_ASSUME_NONNULL_END
