//
//  BaseCircle.m
//  IDOBlue
//
//  Created by apple on 2018/10/12.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "BaseCircle.h"

@implementation BaseCircle

- (void)drawCircle
{
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [[UIColor colorWithRed:142/255.0f green:91/255.0f blue:45/255.0f alpha:1.0]CGColor]; //边框颜色
    shapeLayer.fillColor = [UIColor whiteColor].CGColor;
    shapeLayer.lineWidth = 1.0f; //边框的宽度
    [self.layer addSublayer:shapeLayer];
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width/2,self.bounds.size.height/2) radius:3 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    shapeLayer.path = bezierPath.CGPath;
}

@end
