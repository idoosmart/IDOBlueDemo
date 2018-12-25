//
//  BindDeviceView.h
//  IDOBlue
//
//  Created by 何东阳 on 2018/11/14.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BindDeviceViewDelegate<NSObject>

- (void)cancelBindButton;

- (void)allowBinding;

@end

@interface BindDeviceView : UIView
@property (nonatomic,assign) id<BindDeviceViewDelegate> delegate;
@property (nonatomic,strong) UILabel * tipLabel;
- (void)show;
@end
