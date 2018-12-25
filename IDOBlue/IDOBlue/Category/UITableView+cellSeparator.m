//
//  UITableView+cell.m
//  GZMTRCAR
//
//  Created by apple on 2018/4/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "UITableView+cellSeparator.h"

@implementation UITableView (cellSeparator)

- (void)separatorInsetsZero:(UITableViewCell *)cell
{
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}

@end
