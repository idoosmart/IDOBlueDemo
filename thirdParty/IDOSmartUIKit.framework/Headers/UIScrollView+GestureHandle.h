//
//  UIScrollView+GestureHandle.h
//  IDONaviDemo
//
//  Created by TigerNong on 2019/11/8.
//  Copyright © 2019 TigerNong. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (GestureHandle)

/**
 禁止手势处理，默认为NO，设置为YES表示不对手势冲突进行处理
 */
@property (nonatomic, assign) BOOL ido_disableGestureHandle;

@end

NS_ASSUME_NONNULL_END
