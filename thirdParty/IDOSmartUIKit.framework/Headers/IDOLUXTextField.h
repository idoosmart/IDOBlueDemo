//
//  IDOLUXTextField.h
//  mianApp
//
//  Created by 汪大丸子 on 2019/11/26.
//  Copyright © 2019年 Mobile emergency. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITextField+IDOLimit.h"


NS_ASSUME_NONNULL_BEGIN

@interface IDOLUXTextField : UITextField<UITextFieldDelegate>
/**
 *  计时器
 */
@property (nonatomic , strong) NSTimer *timer;
/**
 左侧自定义的视图
 */
@property (nonatomic, strong) UIImage *leftImage;

/**
 *  光标起始位置
 */
@property (nonatomic, assign) CGFloat startRect;


#pragma mark - 短信倒计时
/**
 *  leftButton 必须调用addTimeButton
 */
@property (nonatomic , strong) UIButton *rightButton;

/**
 *  倒计时时间
 */
@property (nonatomic, assign) NSInteger countDown;


/**
 倒计时的回调
 */
@property (nonatomic,copy) void(^countDownTimeBlock)(id sender);


/**<
    添加计时器并设置倒计时时间
    timeBlock 点击button回调
 */
-(void)addTimeButton:(void(^)(void))timeBlock;

/**< 开始倒计时 */
-(void)beginTimerFrie;


@end

NS_ASSUME_NONNULL_END
