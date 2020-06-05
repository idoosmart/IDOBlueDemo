//
//  UIButton+MBIBnspectable.h
//  IDOUIkit
//
//  Created by xiongze on 2018/8/15.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIButton (MBIBnspectable)

/**
 用来保存imageStr
 */
@property (nonatomic, copy) NSString *bStr;

/**
 用来保存bundleClassStr
 */
@property (nonatomic, copy) NSString *bCStr;

/**
 图片名字
 */
@property (assign,nonatomic) IBInspectable NSString *imageStr;

/**
 图片所在Bundle 其中一个ViewController名称
 */
@property (assign,nonatomic) IBInspectable NSString *bundleClassStr;

@end
