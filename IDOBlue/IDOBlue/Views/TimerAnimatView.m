//
//  TimerAnimatView.m
//  IDOVFPTrajectorySport
//
//  Created by xiongze on 2018/8/29.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "TimerAnimatView.h"

@implementation TimerAnimatView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)countDown:(int)count{
    if(count <=0){
        //倒计时已到，作需要作的事吧。
        if (_TimeOverBlock) {
            _TimeOverBlock();
        }
        [self removeFromSuperview];
    }else{
        UILabel* lblCountDown  = [[UILabel alloc] initWithFrame:self.bounds];
        lblCountDown.textColor = [UIColor colorWithRed:142/255.0f green:91/255.0f blue:45/255.0f alpha:1.0];
        lblCountDown.font   = [UIFont boldSystemFontOfSize:200];
        lblCountDown.backgroundColor = [UIColor clearColor];
        lblCountDown.textAlignment   = NSTextAlignmentCenter;
        lblCountDown.text = [NSString stringWithFormat:@"%d",count];
        [self addSubview:lblCountDown];
        
        [UIView animateWithDuration:1
                              delay:0
                            options:UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             lblCountDown.alpha = 0;
                             lblCountDown.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.5, 0.5);
                         }
                         completion:^(BOOL finished) {
                             [lblCountDown removeFromSuperview];
                             //递归调用，直到计时为零
                             [self countDown:count -1];
                         }
         ];
    }
}

@end
