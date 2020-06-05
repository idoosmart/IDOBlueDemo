//
//  IDOAgreementAlertView.h
//  IDOUIKitDemo
//
//  Created by 农大浒 on 2020/3/20.
//  Copyright © 2020 农大浒. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IDOAttributedView.h"
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, IDOAgreementPositionType) {
    IDOAgreementPositionTypeFromCenter  = 0, //显示在中间
    IDOAgreementPositionTypeFromBottom  = 1,//显示在下边
};


@interface IDOAgreementContentView : UIView

#pragma mark - UI

/**
 顶部的标志线条，只有是从地下弹出的情况下，才会有
 */
@property (nonatomic, strong) UIView *topLineView;

/**
 标题
 */
@property (nonatomic, strong) UILabel *titleLabel;

/**
 信息描述的标签
 */
@property (nonatomic, strong) UILabel *messageLabel;

/**
 可以点击文字的标签
 */
@property (nonatomic, strong) IDOAttributedView *attributedView;

/**
 底部横线
 */
@property (nonatomic, strong) UIView *bottomHLineView;


/**
 取消按钮
 */
@property (nonatomic, strong) UIButton *cancelBtn;

/**
 底部竖线，主要是用来隔开两个按钮
 */
@property (nonatomic, strong) UIView *bottomVlineView;

/**
 确定按钮
 */
@property (nonatomic, strong) UIButton *confirmBtn;


#pragma mark - 传参

/**
 描述的信息，是对隐私政策和用户协议的一些描述
 */
@property (nonatomic, strong) NSString *message;

/**
 需要可以进行点击的文字，所在的字符串，比如像要点击“用户详细”和“隐私政策”，这可以
 */
@property (nonatomic, copy) NSString *keyString;

/**
 显示可以点击的文字以及对应的key
   
 key,value是不能为空
  格式如下：
 {@"privacyPolicy" : "《隐私政策》",@"userAgreement" : "《用户协议》"}
 */
@property (nonatomic, copy) NSDictionary <NSString *, NSString *>*keyDic;

/**
 显示的位置
 */
@property (nonatomic, assign) IDOAgreementPositionType positionType;


#pragma mark - 回调弹框的高度
@property (nonatomic, copy) void (^updateContentViewFrameBlock)(CGFloat height);

@end


@interface IDOAgreementAlertView : UIView

@property (nonatomic, strong) IDOAgreementContentView *agreementContentView;

//内容描述
@property (nonatomic, copy) NSString *message;

/**
 可以点击的文字藐视
 */
@property (nonatomic, copy) NSString *keyString;

/**
 显示可以点击的文字以及对应的key
   
 key,value是不能为空
  格式如下：
 {@"privacyPolicy" : "《隐私政策》",@"userAgreement" : "《用户协议》"}
 */
@property (nonatomic, copy) NSDictionary <NSString *, NSString *>*keyDic;

/**
 显示的位置
 */
@property (nonatomic, assign) IDOAgreementPositionType positionType;


/**
 点击取消回调
 */
@property (nonatomic, copy) void (^AgreementAlertViewClickCancelBtnBlock)(void);

/**
 点击确定回调
 */
@property (nonatomic, copy) void (^AgreementAlertViewClickConfirmBtnBlock)(void);

/**
 点击文字回调
 */
@property (nonatomic, copy) void (^AgreementAlertViewClickKeyTextBlock)(NSString *key);

/**
 显示弹框
 */
- (void)showInSuperView:(UIView *)superView;

/**
 销毁
 */
- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
