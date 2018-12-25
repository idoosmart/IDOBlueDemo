//
//  BaseLine.m
//  IDOBlue
//
//  Created by apple on 2018/10/12.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "BaseLine.h"

@interface BaseLine()

@end

@implementation BaseLine

- (void)drawLine
{
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    [linePath moveToPoint:CGPointMake(0,0)];
    [linePath addLineToPoint:CGPointMake(self.bounds.size.width,self.bounds.size.height)];
    
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.lineWidth = 0.5;
    lineLayer.strokeColor = [[UIColor colorWithRed:142/255.0f green:91/255.0f blue:45/255.0f alpha:1.0]CGColor];
    lineLayer.path = linePath.CGPath;
    lineLayer.lineCap = kCALineCapRound;
    lineLayer.fillColor = [[UIColor colorWithRed:142/255.0f green:91/255.0f blue:45/255.0f alpha:1.0]CGColor];
    [self.layer addSublayer:lineLayer];
}
@end
