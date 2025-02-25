//
//  NewDialJsonBackgroundLibModel.h
//  IDOBlue
//
//  Created by cyf on 2025/2/24.
//  Copyright © 2025 hedongyang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - 背景图的对象

@interface NewDialJsonBackgroundLibModel: NSObject

@property (nonatomic, assign) BOOL canChangeColor;//是否支持修改颜色

@property (nonatomic,   copy) NSString *image;//图片名

//默认的背景色
@property (nonatomic,   copy) NSString *backgroundColor;

//边框的颜色
@property (nonatomic, strong) NSString *borderColor;

//边框的宽度
@property (nonatomic, assign) CGFloat borderWidth;


//2.1.2 角标的颜色，和背景色绑定
@property (nonatomic, strong) NSString *funcTintColor;

@end


NS_ASSUME_NONNULL_END
