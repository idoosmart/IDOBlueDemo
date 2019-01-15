//
//  BasePolygon.m
//  IDOBlue
//
//  Created by hedongyang on 2018/10/13.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "BasePolygon.h"

@implementation BasePolygon
- (void)drawPolygon
{
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    int index = 0;
    for (NSString * str in self.points) {
         CGPoint point = CGPointFromString(str);
        if (index == 0) {
              [linePath moveToPoint:CGPointMake(point.x, point.y)];
        }else {
            if (index == self.points.count - 1) {
                [linePath addLineToPoint:CGPointMake(point.x, point.y)];
            }else {
                [linePath addLineToPoint:CGPointMake(point.x + 3, point.y + 3)];
            }
        }
        index++;
    }
    [linePath closePath];
    
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.strokeColor = [[UIColor clearColor]CGColor];
    lineLayer.lineCap = kCALineCapRound;
    lineLayer.fillColor = [[UIColor colorWithRed:142/255.0f green:91/255.0f blue:45/255.0f alpha:0.3]CGColor];
    lineLayer.path = linePath.CGPath;
    [self.layer addSublayer:lineLayer];
}
@end
