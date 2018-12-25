//
//  BaseCurve.m
//  IDOBlue
//
//  Created by hedongyang on 2018/10/13.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "BaseCurve.h"

@implementation BaseCurve

- (void)drawCurve
{
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    
    for (NSArray * array in self.points) {
        CGPoint point1 = CGPointFromString([array firstObject]);
        CGPoint point2 = CGPointFromString([array lastObject]);
        [linePath moveToPoint:CGPointMake(point1.x + 3, point1.y + 3)];
        [linePath addLineToPoint:CGPointMake(point2.x + 3, point2.y + 3)];
    }
    
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.lineWidth = 0.5;
    lineLayer.strokeColor = [[UIColor colorWithRed:142/255.0f green:91/255.0f blue:45/255.0f alpha:1.0]CGColor];
    lineLayer.path = linePath.CGPath;
    lineLayer.lineCap = kCALineCapRound;
    lineLayer.fillColor = [[UIColor colorWithRed:142/255.0f green:91/255.0f blue:45/255.0f alpha:1.0]CGColor];
    [self.layer addSublayer:lineLayer];
}

@end
