//
//  SVIndefiniteAnimatedView.h
//  SVProgressHUD, https://github.com/SVProgressHUD/SVProgressHUD
//
//  Copyright (c) 2014-2018 Guillaume Campagna. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SVIndefiniteAnimatedView : UIView
/**
 *  自定义图片
 */
@property (nonatomic , strong) UIImage *customImageIDO;

@property (nonatomic, assign) CGFloat strokeThickness;
@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, strong) UIColor *strokeColor;

@end

