//
//  UINavigationController+Extension.h
//  IDONaviDemo
//
//  Created by TigerNong on 2019/11/7.
//  Copyright © 2019 TigerNong. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface UINavigationController (Extension)
/** 初始化一个导航栏，并设置push、pop 时是否有缩放功能 */
+ (instancetype)rootVC:(UIViewController *)rootVC translationScale:(BOOL)translationScale;

/** 初始化一个导航栏，并设置push、pop 时是否有缩放功能 */
- (instancetype)initWithRootVC:(UIViewController *)rootVC translationScale:(BOOL)translationScale;

/**
 导航栏转场时是否缩放
 */
@property (nonatomic, assign, readonly) BOOL translationScale; 

@end

NS_ASSUME_NONNULL_END
