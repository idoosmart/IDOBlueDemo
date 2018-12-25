//
//  UINavigationItem+Button.h
//  SDKDemo
//
//  Created by hedongyang on 2018/6/13.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationItem (Button)
- (void)addRightButtonWitTitle:(NSString *)title target:(id)target action:(SEL)selector;
@end
