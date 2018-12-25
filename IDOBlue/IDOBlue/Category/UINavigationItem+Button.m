//
//  UINavigationItem+Button.m
//  SDKDemo
//
//  Created by hedongyang on 2018/6/13.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "UINavigationItem+Button.h"

@implementation UINavigationItem (Button)

- (void)addRightButtonWitTitle:(NSString *)title target:(id)target action:(SEL)selector
{
    UIBarButtonItem * rightBarItem = [[UIBarButtonItem alloc] initWithTitle:title
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:target action:selector];
    self.rightBarButtonItem = rightBarItem;
}
@end
