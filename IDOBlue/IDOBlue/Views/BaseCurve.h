//
//  BaseCurve.h
//  IDOBlue
//
//  Created by hedongyang on 2018/10/13.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCurve : UIView
@property (nonatomic,strong) NSArray <NSArray *>* points;
- (void)drawCurve;
@end
