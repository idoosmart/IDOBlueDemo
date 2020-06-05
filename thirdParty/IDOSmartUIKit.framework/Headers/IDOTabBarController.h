//
//  IDOTabBarController.h
//  IDOEducation
//
//  Created by TigerNong on 2019/11/8.
//  Copyright © 2019 TigerNong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IDOCustomTabBar.h"

NS_ASSUME_NONNULL_BEGIN

@interface IDOTabBarController : UITabBarController

@property (nonatomic, strong) IDOCustomTabBar *ido_tabBar;

/**
 根据下标执行点击动画
 */
- (void)animationWithIndex:(NSInteger) index;

@end

NS_ASSUME_NONNULL_END
