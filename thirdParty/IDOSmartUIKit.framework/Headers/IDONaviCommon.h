//
//  IDONaviCommon.h
//  IDONaviDemo
//
//  Created by TigerNong on 2019/11/7.
//  Copyright © 2019 TigerNong. All rights reserved.
//

#ifndef IDONaviCommon_h
#define IDONaviCommon_h

#define IDOViewControllerPropertyChangedNotification @"IDOViewControllerPropertyChangedNotification"

#define IDODeviceVersion [[[UIDevice currentDevice] systemVersion] floatValue]

// 判断是否是iPhone X系列
#define IDO_IS_iPhoneX      ([UIScreen instancesRespondToSelector:@selector(currentMode)] ?\
(\
CGSizeEqualToSize(CGSizeMake(375, 812),[UIScreen mainScreen].bounds.size)\
||\
CGSizeEqualToSize(CGSizeMake(812, 375),[UIScreen mainScreen].bounds.size)\
||\
CGSizeEqualToSize(CGSizeMake(414, 896),[UIScreen mainScreen].bounds.size)\
||\
CGSizeEqualToSize(CGSizeMake(896, 414),[UIScreen mainScreen].bounds.size))\
:\
NO)


#define IDO_SCREEN_WIDTH                 [UIScreen mainScreen].bounds.size.width
#define IDO_SCREEN_HEIGHT                [UIScreen mainScreen].bounds.size.height
#define IDO_STATUSBAR_HEIGHT        (IDO_IS_iPhoneX ? 44.0f : 20.0f)  // 状态栏高度
#define IDO_SAFEAREA_TOP                 (IDO_IS_iPhoneX ? 24.0f : 0.0f)   // 顶部安全区域

#define IDO_NAVBAR_HEIGHT                44.0f   // 导航栏高度
#define IDO_STATUSBAR_NAVBAR_HEIGHT      (IDO_STATUSBAR_HEIGHT + IDO_NAVBAR_HEIGHT) // 状态栏+导航栏高度

#define IDO_TABBAR_HEIGHT (IDO_IS_iPhoneX ? 83.0f : 49.0f)


#endif /* IDONaviCommon_h */
