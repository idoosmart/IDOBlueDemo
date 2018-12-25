//
//  CurveChartView.m
//  IDOBlue
//
//  Created by hedongyang on 2018/10/11.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "CurveChartView.h"
#import "IDODemoUtility.h"
#import "BaseText.h"
#import "BaseLine.h"
#import "BaseDashLine.h"
#import "BasePoint.h"
#import "BaseOption.h"
#import "BaseCircle.h"
#import "BaseCurve.h"
#import "BasePolygon.h"
#import "BaseShowValue.h"

@interface CurveChartView()<BasePointDelegate>
@property (nonatomic,strong)BaseOption * currentOption;
@property (nonatomic,strong)BasePoint * beforPoint;
@property (nonatomic,strong)BaseShowValue * showValue;
@end

@implementation CurveChartView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setTitles:(NSArray *)titles
{
    for (UIView * view in self.subviews) {
        if ([view isKindOfClass:[BaseShowValue class]]
            || [view isKindOfClass:[BaseOption class]]) {
            view.hidden = YES;
            continue;
        }
        [view removeFromSuperview];
    }
    _titles = titles;
    BaseLine * xLine = [[BaseLine alloc]initWithFrame:CGRectMake(0,self.bounds.size.height - 20,self.bounds.size.width,0.5)];
    [self addSubview:xLine];
    [xLine drawLine];
    if (_titles.count > 12) {
        CGFloat itemWidth = (self.bounds.size.width - self.gap * 2) / (_titles.count - 1);
        int index = 1;
        for (NSString * str in _titles) {
            CGFloat x = itemWidth * (index - 1) + self.gap;
            CGFloat y = self.bounds.size.height - 15;
            BaseLine * yLine = [[BaseLine alloc]initWithFrame:CGRectMake(x,0,0.5,self.bounds.size.height - 20)];
            [self addSubview:yLine];
            [yLine drawLine];
            if (index == 7 || index == 13 || index == 19 || index == 25 || index == 1 || index == _titles.count) {
                BaseText * text = [[BaseText alloc]initWithFrame:CGRectMake(x-14/2,y,14,14)];
                text.titleStr = str;
                text.fontSize = 12.0;
                [self addSubview:text];
                [text drawText];
            }
            index++;
        }
    }else {
        CGFloat itemWidth = (self.bounds.size.width - self.gap * 2) / (_titles.count - 1);
        int index = 1;
        for (NSString * str in _titles) {
            CGFloat x = itemWidth * (index - 1) + self.gap;
            CGFloat y = self.bounds.size.height - 15;
            BaseLine * yLine = [[BaseLine alloc]initWithFrame:CGRectMake(x,0,0.5,self.bounds.size.height - 20)];
            [self addSubview:yLine];
            [yLine drawLine];
            BaseText * text = [[BaseText alloc]initWithFrame:CGRectMake(x-14/2,y,14,14)];
            text.titleStr = str;
            text.fontSize = 12.0;
            [self addSubview:text];
            [text drawText];
            index++;
        }
    }
}

- (void)setValues:(NSArray <NSNumber *>*)values
{
    _values = values;
    CGFloat maxValue = [[_values valueForKeyPath:@"@max.floatValue"] floatValue];
    CGFloat targetY = 0;
    CGFloat targetH = 0;
    CGFloat chartH = self.bounds.size.height - 20;
    CGFloat targetProportion = 0.0f;
    if (maxValue < [_target floatValue]) {
        targetProportion = 3/4.0;
        targetY = chartH * (1 - targetProportion);
        targetH = chartH * targetProportion;
    }else if (maxValue >= [_target floatValue]) {
        targetProportion = [_target floatValue] / (maxValue + [_target floatValue] / 4.0);
        targetY = chartH * (1 - targetProportion);
        targetH = chartH * targetProportion;
    }
    
    BaseDashLine * dashLine = [[BaseDashLine alloc]initWithFrame:CGRectMake(0,targetY,self.bounds.size.width,0.2)];
    [self addSubview:dashLine];
    [dashLine drawDashLine];
    
    CGFloat length = [IDODemoUtility getLabelWidth:_target height:14 font:[UIFont systemFontOfSize:12]];
    BaseText * text = [[BaseText alloc]initWithFrame:CGRectMake(16,targetY-14,length,14)];
    text.titleStr = _target;
    text.fontSize = 12.0;
    [self addSubview:text];
    [text drawText];
    
    int index = 0;
    CGFloat itemWidth = (self.bounds.size.width - self.gap * 2) / (_titles.count - 1);
    NSMutableArray * pointArray = [NSMutableArray array];
    for (NSNumber * number in _values) {
        CGFloat x = itemWidth * index + self.gap;
        CGFloat proportion = ([number floatValue]/[_target floatValue])*1.0f;
        if (proportion < 1 && proportion > 0) {
            CGFloat y = targetY + targetH*(1-proportion);
            [pointArray addObject:NSStringFromCGPoint(CGPointMake(x-3,y-3))];
        }else if (proportion >= 1) {
            CGFloat total = maxValue + [_target floatValue]/4;
            CGFloat actualProportion = ([number floatValue] - [_target floatValue])/total;
            CGFloat y = targetY - actualProportion * chartH;
            [pointArray addObject:NSStringFromCGPoint(CGPointMake(x-3,y-3))];
        }else {
            CGFloat y = chartH;
            [pointArray addObject:NSStringFromCGPoint(CGPointMake(x-3,y-3))];
        }
        index++;
    }

    NSArray * linePoints = [self linePointsWithPoints:pointArray];
    BaseCurve * curve = [[BaseCurve alloc]initWithFrame:self.bounds];
    curve.points = linePoints;
    [self addSubview:curve];
    [curve drawCurve];
    
    CGPoint point1 = CGPointMake(self.gap,chartH);
    CGPoint lastPoint = CGPointFromString([pointArray lastObject]);
    CGPoint point2 = CGPointMake(lastPoint.x + 3,chartH);
    NSMutableArray * polygonPoints = [NSMutableArray arrayWithArray:pointArray];
    [polygonPoints insertObject:NSStringFromCGPoint(point1) atIndex:0];
    [polygonPoints insertObject:NSStringFromCGPoint(point2) atIndex:polygonPoints.count];
    BasePolygon * polygon = [[BasePolygon alloc]initWithFrame:self.bounds];
    polygon.points = polygonPoints;
    [self addSubview:polygon];
    [polygon drawPolygon];
    
    index = 0;
    for (NSString * str in pointArray) {
        CGPoint point = CGPointFromString(str);
        CGFloat value = [_values[index] floatValue];
        if (value > 0) {
            BasePoint * pointv = [[BasePoint alloc]initWithFrame:CGRectMake(point.x-7,point.y-7,20,20)];
            pointv.delegate = self;
            pointv.dataValue = value;
            [self addSubview:pointv];
            [pointv drawPoint];
        }else {
            BaseCircle * circle = [[BaseCircle alloc]initWithFrame:CGRectMake(point.x-7,point.y-7,20,20)];
            circle.dataValue = value;
            [self addSubview:circle];
            [circle drawCircle];
        }
        index ++;
    }
}

- (NSArray <NSArray *>*)linePointsWithPoints:(NSArray *)points
{
    NSMutableArray * linePoints = [NSMutableArray array];
    for (int i = 0; i < points.count; i++) {
        NSMutableArray * oneLinePoints = [NSMutableArray array];
        if (i + 1 < points.count) {
            NSString * str1 = [points objectAtIndex:i];
            NSString * str2 = [points objectAtIndex:i+1];
            [oneLinePoints addObject:str1];
            [oneLinePoints addObject:str2];
        }
        [linePoints addObject:oneLinePoints];
    }
    return linePoints;
}

- (void)showValue:(NSString *)valueStr view:(BasePoint *)pointv
{
    self.beforPoint.hidden = NO;
    pointv.hidden = YES;
    self.currentOption.frame = pointv.frame;
    self.showValue.frame = CGRectMake(pointv.frame.origin.x - 40/2 + pointv.frame.size.width/2,pointv.frame.origin.y - 30,40,30);
    self.currentOption.dataValue = pointv.dataValue;
    self.showValue.dataValue = pointv.dataValue;
    self.currentOption.hidden = NO;
    self.showValue.hidden = NO;
    self.beforPoint = pointv;
}

- (BaseShowValue *)showValue
{
    if (!_showValue) {
        _showValue = [[BaseShowValue alloc]initWithFrame:CGRectMake(0, 0,40,30)];
        [self addSubview:_showValue];
        [_showValue drawShow];
    }
    _showValue.hidden = YES;
    return _showValue;
}

- (BaseOption *)currentOption
{
    if (!_currentOption) {
        _currentOption = [[BaseOption alloc]initWithFrame:CGRectMake(0,0,20,20)];
        [self addSubview:_currentOption];
        [_currentOption drawOption];
    }
    _currentOption.hidden = YES;
    return _currentOption;
}

@end
