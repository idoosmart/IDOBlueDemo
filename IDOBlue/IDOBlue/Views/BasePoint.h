//
//  BasePoint.h
//  IDOBlue
//
//  Created by apple on 2018/10/12.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BasePoint;
@protocol BasePointDelegate<NSObject>
- (void)showValue:(NSString *)valueStr view:(BasePoint *)pointv;
@end

@interface BasePoint : UIView
@property (nonatomic,assign) id<BasePointDelegate>  delegate;
@property (nonatomic,assign) CGFloat dataValue;//数据
- (void)drawPoint;
@end
