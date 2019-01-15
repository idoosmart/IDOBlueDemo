//
//  BaseOption.m
//  IDOBlue
//
//  Created by apple on 2018/10/12.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "BaseOption.h"

@implementation BaseOption

- (void)drawOption
{
    CAShapeLayer * shapeLayer1 = [CAShapeLayer layer];
    shapeLayer1.fillColor = [[UIColor colorWithRed:142/255.0f green:91/255.0f blue:45/255.0f alpha:1.0]CGColor]; //填充颜色
    shapeLayer1.strokeColor = [[UIColor clearColor] CGColor];
    [self.layer addSublayer:shapeLayer1];
    UIBezierPath *bezierPath1 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width/2,self.bounds.size.height/2) radius:3 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    shapeLayer1.path = bezierPath1.CGPath;
    
    CAShapeLayer * shapeLayer2 = [CAShapeLayer layer];
    shapeLayer2.strokeColor = [[UIColor colorWithRed:142/255.0f green:91/255.0f blue:45/255.0f alpha:1.0]CGColor]; //边框颜色
    shapeLayer2.fillColor = [[UIColor clearColor]CGColor]; //填充颜色
    shapeLayer2.lineWidth = 1.0f; //边框的宽度
    [self.layer addSublayer:shapeLayer2];
    UIBezierPath *bezierPath2 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width/2,self.bounds.size.height/2) radius:6 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    shapeLayer2.path = bezierPath2.CGPath;
}

@end
