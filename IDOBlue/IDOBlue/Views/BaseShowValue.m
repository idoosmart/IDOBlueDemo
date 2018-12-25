//
//  BaseShowValue.m
//  IDOBlue
//
//  Created by hedongyang on 2018/10/13.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "BaseShowValue.h"
#import "BaseText.h"
#import "IDODemoUtility.h"

@interface BaseShowValue()
@property (nonatomic,strong) BaseText * text;
@end

@implementation BaseShowValue

- (void)drawShow
{
    CGFloat viewWidth  = CGRectGetWidth(self.bounds);
    CGFloat viewHeight = CGRectGetHeight(self.bounds);
    CGFloat rightSpace = 10.;
    CGFloat topSpace = 10.;
    CGPoint point1 = CGPointMake(0, 0);
    CGPoint point2 = CGPointMake(viewWidth,0);
    CGPoint point3 = CGPointMake(viewWidth,viewHeight - topSpace);
    CGPoint point4 = CGPointMake(viewWidth/2+rightSpace,viewHeight - topSpace);
    CGPoint point5 = CGPointMake(viewWidth/2,viewHeight);
    CGPoint point6 = CGPointMake(viewWidth/2-rightSpace,viewHeight - topSpace);
    CGPoint point7 = CGPointMake(0,viewHeight - topSpace);
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:point1];
    [path addLineToPoint:point2];
    [path addLineToPoint:point3];
    [path addLineToPoint:point4];
    [path addLineToPoint:point5];
    [path addLineToPoint:point6];
    [path addLineToPoint:point7];
    [path closePath];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.fillColor   = [[UIColor colorWithRed:142/255.0f green:91/255.0f blue:45/255.0f alpha:0.3]CGColor];
    layer.strokeColor = [[UIColor clearColor] CGColor];
    layer.path = path.CGPath;
    [self.layer addSublayer:layer];
}

- (void)setDataValue:(CGFloat)dataValue
{
    _dataValue = dataValue;
    for (CALayer * layer in self.layer.sublayers) {
        if (layer == self.text.layer) {
            [layer removeFromSuperlayer];
        }
    }
    NSString * valueStr = [NSString stringWithFormat:@"%.2f",_dataValue];
    CGFloat length = [IDODemoUtility getLabelWidth:valueStr height:12 font:[UIFont systemFontOfSize:8]];
    self.text = [[BaseText alloc]initWithFrame:CGRectMake(0,0,length,12)];
    self.text.center = CGPointMake(self.bounds.size.width/2,(self.bounds.size.height - 10)/2);
    self.text.titleStr = valueStr;
    self.text.fontSize = 8.0;
    [self addSubview:self.text];
    [self.text drawText];
}

@end
