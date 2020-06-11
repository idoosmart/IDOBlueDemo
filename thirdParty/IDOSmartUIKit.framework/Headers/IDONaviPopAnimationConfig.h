//
//  IDONaviPopAnimationConfig.h
//  IDOSmartUIKit
//
//  Created by 农大浒 on 2020/5/29.
//  Copyright © 2020 农大浒. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IDONaviPopAnimationConfig : NSObject

+ (IDONaviPopAnimationConfig *)shareInstance;

/**
 设置缩放的参数
 
 iOS 11.0 之后可用
 
 transitionX  距离左边的距离
 transitionY  距离顶部的距离和距离顶部的距离
 */
@property (nonatomic, assign) CGFloat transitionX;
@property (nonatomic, assign) CGFloat transitionY;


/**
 设置缩放参数
 
 iOS 11 之前的可用
 
 */

@property (nonatomic, assign) CGFloat transitionScaleX;
@property (nonatomic, assign) CGFloat transitionScaleY;

@end

NS_ASSUME_NONNULL_END
