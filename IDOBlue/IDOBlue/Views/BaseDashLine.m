//
//  BaseDashLine.m
//  IDOBlue
//
//  Created by apple on 2018/10/12.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "BaseDashLine.h"

@interface BaseDashLine()

@end

@implementation BaseDashLine

- (void)drawDashLine
{
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    shapeLayer.lineWidth = 0.2;
    shapeLayer.strokeColor = [[UIColor colorWithRed:142/255.0f green:91/255.0f blue:45/255.0f alpha:1.0]CGColor];
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.fillColor = [[UIColor colorWithRed:142/255.0f green:91/255.0f blue:45/255.0f alpha:1.0]CGColor];
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:@(2),@(1), nil]];
    
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    [linePath moveToPoint:CGPointMake(0,0)];
    [linePath addLineToPoint:CGPointMake(self.bounds.size.width,self.bounds.size.height)];
    shapeLayer.path = linePath.CGPath;
    
    [self.layer addSublayer:shapeLayer];
}

@end
