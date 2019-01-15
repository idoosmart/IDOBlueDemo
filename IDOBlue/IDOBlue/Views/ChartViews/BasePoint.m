//
//  BasePoint.m
//  IDOBlue
//
//  Created by apple on 2018/10/12.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "BasePoint.h"

@interface BasePoint()

@end
@implementation BasePoint

- (void)drawPoint
{
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    shapeLayer.fillColor = [[UIColor colorWithRed:142/255.0f green:91/255.0f blue:45/255.0f alpha:1.0]CGColor]; //填充颜色
    [self.layer addSublayer:shapeLayer];
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width/2,self.bounds.size.height/2) radius:3 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    shapeLayer.path = bezierPath.CGPath;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (_delegate && [_delegate respondsToSelector:@selector(showValue:view:)]) {
        [_delegate showValue:[NSString stringWithFormat:@"%.2f",self.dataValue] view:self];
    }
}

@end

