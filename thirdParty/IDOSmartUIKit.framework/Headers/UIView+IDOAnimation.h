//
//  UIView+IDOAnimation.h
//  IDOUIkit
//
//  Created by apple on 2018/7/14.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (IDOAnimation)

/**
 view 添加弹性动画
 view add elastic animation
 
 @param fromValue 初始值
 @param toValue 结束值
 */
- (void)elasticAnimationFromValue:(CGFloat)fromValue toValue:(CGFloat)toValue;

/**
 视图过渡动画从底部弹起
 */
- (void)transitionAnimationFromBottom;

/**
 视图过渡动画从顶部弹起
 */
- (void)transitionAnimationFromTop;

/**
 视图过渡动画淡化效果,
 */
- (void)transitionAnimationFade;

/**
 view 缩放动画
 
 @param fromValue 初始值
 @param toValue 结束值
 @param autoreverse 是否重复
 */
- (void)scaleAnimationFromValue:(CGFloat)fromValue toValue:(CGFloat)toValue autoreverses:(BOOL)autoreverse;



/**
 强制退出app,杀死app进程
 
    目前默认是以UIViewAnimationCurveEaseOut 的动画退出，动画时长为0.5秒；
    在退出的时候因为没有触发AppDelegate中的任何方法，所以在这里发出退出通知，通知的key为"applicationWillExitNotifacation"，在IDOUIKitDefine.h文件里面有它的宏定义，如下：
 #define NNKEY_APPLICATION_WILL_EXIT_NOTIFICATION @"applicationWillExitNotifacation"
 
 农大浒 2020/02/22  新增
 */
+ (void)exitApplication;

/**
 强制退出app,杀死app进程
 
=========描述开始=========

 在退出的时候因为没有触发AppDelegate中的任何方法，所以在这里发出退出通知，通知的key为"applicationWillExitNotifacation"，在IDOUIKitDefine.h文件里面有它的宏定义，如下：
 #define NNKEY_APPLICATION_WILL_EXIT_NOTIFICATION @"applicationWillExitNotifacation"
 
 农大浒 2020/02/22  新增
 
 =========描述结束========
 @param transition 动画的方式
 @param duration 动画时间
 
 */
+ (void)exitApplicationAnimationTransition:(UIViewAnimationTransition)transition duration:(CFTimeInterval)duration;
@end
