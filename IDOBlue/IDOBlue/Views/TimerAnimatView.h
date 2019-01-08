//
//  TimerAnimatView.h
//  IDOVFPTrajectorySport
//
//  Created by xiongze on 2018/8/29.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimerAnimatView : UIView


/**
 开始倒计时

 @param count 倒计时开始 3 秒
 */
-(void)countDown:(int)count;

@property (nonatomic, copy) void (^TimeOverBlock) (void);


@end
