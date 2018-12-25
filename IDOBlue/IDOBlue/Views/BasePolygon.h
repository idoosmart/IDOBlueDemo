//
//  BasePolygon.h
//  IDOBlue
//
//  Created by hedongyang on 2018/10/13.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasePolygon : UIView
@property (nonatomic,strong) NSArray * points;
- (void)drawPolygon;
@end
