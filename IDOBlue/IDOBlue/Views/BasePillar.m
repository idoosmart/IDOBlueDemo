//
//  BasePi.m
//  IDOBlue
//
//  Created by apple on 2018/10/12.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "BasePillar.h"

@interface BasePillar()

@end

@implementation BasePillar

- (void)drawPillar
{
    UIBezierPath *beziPath = [UIBezierPath bezierPath];
    beziPath.lineWidth = 0.0;//线的宽度
    //起点坐标
    [beziPath moveToPoint:self.startPoint];
    //终点坐标
    [beziPath addLineToPoint:self.endPoint];
    beziPath.lineCapStyle = kCGLineCapRound;
    beziPath.lineJoinStyle = kCGLineJoinRound;
    [beziPath stroke];
    //画图
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.fillColor = [[UIColor colorWithRed:142/255.0f green:91/255.0f blue:45/255.0f alpha:1.0]CGColor];
    shapeLayer.strokeColor = [[UIColor colorWithRed:142/255.0f green:91/255.0f blue:45/255.0f alpha:1.0]CGColor];
    shapeLayer.lineWidth = self.width;
    shapeLayer.strokeStart = 0;//起始点
    shapeLayer.strokeEnd = self.dataValue;//结束点
    shapeLayer.path = beziPath.CGPath;//产生联系
    [self.superview.layer addSublayer:shapeLayer];
    //动画
    CABasicAnimation*pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 1.0f;
    pathAnimation.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue = @(0.0f);
    pathAnimation.toValue = @(self.dataValue);
    [shapeLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}

@end
