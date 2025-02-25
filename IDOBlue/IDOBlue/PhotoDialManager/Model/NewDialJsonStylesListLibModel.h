//
//  NewDialJsonStylesListLibModel.h
//  IDOBlue
//
//  Created by cyf on 2025/2/24.
//  Copyright © 2025 hedongyang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - 样式表的类型

@interface NewDialJsonStylesListLibModel: NSObject

///类型
@property (nonatomic,   copy) NSString *name;

///是否支持根据选中的颜色 子功能项button 来渲染前景色
@property (nonatomic, assign) BOOL canChangeColor;

///图片列表
@property (nonatomic, strong) NSArray<NSString *> *images;

//默认的背景色
@property (nonatomic,   copy) NSString *backgroundColor;

//边框的颜色
@property (nonatomic, strong) NSString *borderColor;

//边框的宽度
@property (nonatomic, assign) CGFloat borderWidth;

@end


NS_ASSUME_NONNULL_END
