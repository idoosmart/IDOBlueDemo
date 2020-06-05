//
//  IDOAgreementAlertView.h
//  IDOUIKitDemo
//
//  Created by 农大浒 on 2020/3/20.
//  Copyright © 2020 农大浒. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IDOAttributedView : UIView

/**
 显示的信息
 */
@property (nonatomic, copy) NSString *message;

/**
 显示可以点击的文字以及对应的key
   
 key,value是不能为空
  格式如下：
 {@"privacyPolicy" : "《隐私政策》",@"userAgreement" : "《用户协议》"}
 */
@property (nonatomic, copy) NSDictionary <NSString *, NSString *>*keyDic;


/**
 文字字体
 */
@property (nonatomic, strong) UIFont *textFont;

/**
 对齐方式
 */
@property (nonatomic, assign) NSTextAlignment alignment;

/**
 文字行间距
 */
@property (nonatomic, assign) NSUInteger lineSpace;

/**
 协议名称文字及下划线的颜色
 */
@property (nonatomic, strong) UIColor *keyTextColor;

/**
 所有文字的颜色
 */
@property (nonatomic, strong) UIColor *textColor;

/**
 点击指定的问题进行回调
 */
@property (nonatomic, copy) void (^clickKeyTextBlock)(NSString *key);

/**
 是否显示下划线
 */
@property (nonatomic, assign)  BOOL showUnderline;

@end

NS_ASSUME_NONNULL_END
