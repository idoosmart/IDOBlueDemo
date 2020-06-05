//
//  IDOUIKitDefine.h
//  IDOUIkit
//
//  Created by xiongze on 2018/8/2.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#ifndef IDOUIKitDefine_h
#define IDOUIKitDefine_h
#import "IDOUIHelp.h"

//tableView注册cell
#define kTableViewRegisterNib(tableView, className) [tableView registerNib:[UINib nibWithNibName:className bundle:[NSBundle bundleForClass:NSClassFromString(className)]] forCellReuseIdentifier:className];
#define kTableViewRegNib(tableView, className, identifier) [tableView registerNib:[UINib nibWithNibName:className bundle:[NSBundle bundleForClass:NSClassFromString(className)]] forCellReuseIdentifier:identifier];

//获取导航栏、状态栏、tabbar的高度
#define kStatusHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavHeight self.navigationController.navigationBar.frame.size.height
#define kNavAndStatusHeight ([[UIApplication sharedApplication] statusBarFrame].size.height+self.navigationController.navigationBar.frame.size.height)
#define kTabBarHeight(viewController) [[[viewController tabBarController] tabBar] size].height

//获取常用控件
#define KEYWINDOW [UIApplication sharedApplication].keyWindow


//imageView 根据Bundle设置image
#define IMAGEBUNDLE(NAME, CLASS) [UIImage imageNamed:NAME inBundle:[NSBundle bundleForClass:CLASS] compatibleWithTraitCollection:nil]

#define IMAGE(NAME) [UIImage imageNamed:NAME \
inBundle:[NSBundle bundleForClass:[self class]]\
compatibleWithTraitCollection:nil]

#define COLOR(HEXSTR) [IDOUIHelp colorWithHexString:HEXSTR]
#define HEXColor(_hex_)  [IDOUIHelp colorWithHexString:((__bridge NSString *)CFSTR(#_hex_))]
#define COLORANDALPHA(HEXSTR, ALPHA) [IDOUIHelp colorWithHexString:HEXSTR alpha:ALPHA]

//常用颜色
#define VIEWCONTROLLERBGCOLOR COLOR(@"#F0F0F0")
#define BTNCOLORNORMAL COLOR(@"#B2B2B2")
#define BTNCOLORHIGHLIGHT COLOR(@"#FC6732")
#define TITLECOLORNORMAL COLOR(@"#999999")
#define TITLECOLORHIGHLIGHT COLOR(@"#FC6732")

//字体
#define DEFAULT_FONTHelvetica(s)     [UIFont fontWithName:@"Avenir-Light" size:s]
#define DEFAULT_FONTMicrosoftYaHei(s)  [UIFont fontWithName:@"MicrosoftYaHei" size:s]
#define DEFAULT_FONTKhmerSangamMN(s) [UIFont fontWithName:@"Avenir-Light" size:s]
#define DEFAULT_FONTsize(s)     [UIFont systemFontOfSize:s]

#define K_SYSTEM_BOLD_FONT(S)  [UIFont boldSystemFontOfSize:s]
#define K_SYSTEM_FONT_WEIGHT(s,w) [UIFont systemFontOfSize:s weight:w]
#define K_PINGFANG_SC_MEDIUM_FONT(s) [UIFont fontWithName:@"PingFangSC-Medium" size:s]
#define K_PINGFANG_SC_REGULAR_FONT(s) [UIFont fontWithName:@"PingFangSC-Regular" size:s]
#define K_PINGFANG_SC_BOLD_FONT(s) [UIFont fontWithName:@"PingFangSC-Bold" size:s]
#define K_PINGFANG_SC_HEAVY_FONT(s) [UIFont fontWithName:@"PingFangSC-Semibold" size:s]
#define K_SIMSUN_SC_REGULAR_FONT(s) [UIFont fontWithName:@"SimSun-Regular" size:s]

#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width

#define WEAKSELF __weak typeof(self) weakSelf = self;

// 版本
#define SYS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]


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

//tabBar 的高度
#define IDO_TABBAR_HEIGHT (IDO_IS_iPhoneX ? 83.0f : 49.0f)

#define kBottomHeight (IDO_IS_iPhoneX ? 34.0f : 0.0f)


/**
 在强制退出app的时候，发出通知，需要处理数据的接受到通知后进行处理
 */
#define NNKEY_APPLICATION_WILL_EXIT_NOTIFICATION @"applicationWillExitNotifacation"


#endif /* IDOUIKitDefine_h */
