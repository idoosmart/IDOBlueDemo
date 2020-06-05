//
//  IDOTextField.h
//  IDOEducation
//
//  Created by TigerNong on 2019/11/10.
//  Copyright © 2019 TigerNong. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, IDOTextBorderStyle) {
    IDOTextBorderStyleNone,
    IDOTextBorderStyleLine, //四边都是线
    IDOTextBorderStyleButtomLine,//只有底部有线
    IDOTextBorderStyleRoundedRect // 圆角线条
};

NS_ASSUME_NONNULL_BEGIN


@interface IDOTextField : UIView
/**
 *  限制输入位数
 */
@property (nonatomic, assign) NSInteger limitMax;
/**
 内容
 */
@property (nonatomic, copy) NSString *text;
/**
 内容的颜色
 */
@property (nonatomic, strong) UIColor *textColor;

/**
 字体大小
 */
@property (nonatomic, strong) UIFont *textFont;

/**
 占位字符
 */
@property (nonatomic, copy) NSString *placeholder;

/**
 占位符的颜色p
 */
@property (nonatomic, strong) UIColor *placeholderColor;

/**
 占位符字体大小
 */
@property (nonatomic, strong) UIFont *placeholderFont;

/**
 文字对其
 */
@property (nonatomic, assign) NSTextAlignment textAlignment;

/**
 光标的颜色
 */
@property (nonatomic, strong) UIColor *tintColor;

/**
 左侧自定义的视图
 */
@property (nonatomic, strong) UIImage *leftImage;

/**
 自定义的最左侧图片距离左侧的间距,默认间距20
 */
@property (nonatomic, assign) CGFloat leftImageViewMarginleft;

/**
 自定义的右侧视图距离右侧的间距,默认间距20
 */
@property (nonatomic, assign) CGFloat rightViewMarginRight;

/**
自定义的最侧图片距离左侧的间距,默认间距20
*/
@property (nonatomic, assign) CGFloat leftImageViewWidth;

/**
自定义的最侧图片距离左侧的间距,默认间距20
*/
@property (nonatomic, assign) CGFloat leftImageViewHeight;

/**
 右侧自定义的视图，一般主要是获取验证码，或者图片验证码
 */
@property (nonatomic, strong) UIView *rightView;

/**
右侧清除按钮的显示
*/
@property (nonatomic, assign) UITextFieldViewMode clearButtonMode;

/**
 输入框的样式
 */
@property (nonatomic, assign) IDOTextBorderStyle borderStyle;

/**
 未编辑情况下边框线条的颜色
 */
@property (nonatomic, strong) UIColor *nomalBorderColor;

/**
 编辑情况下边框线条的颜色
 */
@property (nonatomic, strong) UIColor *editBorderColor;

/**
 边框线条的宽度
 */
@property (nonatomic, assign) CGFloat borthWidth;

/**
 圆角半径,这个只有在borderStyle == IDOTextBorderStyleRoundedRect 才会有效
 */
@property (nonatomic, assign) CGFloat cornerRadius;

/**
是否安全输入
*/
@property (nonatomic, assign) BOOL secureTextEntry;

/**
键盘的类型
*/
@property (nonatomic, assign) UIKeyboardType keyboardType;

/**
 返回键的类型
 */
@property (nonatomic, assign) UIReturnKeyType returnKeyType;

/**
 输入框距离左侧间距
 */
@property (nonatomic, assign) CGFloat textFieldMerginLeft;

/**
 输入框距离当前视图右侧间距
 */
@property (nonatomic, assign) CGFloat textFieldMerginRight;

#pragma mark - 方法或者block的回调
/**
 点击了return键
 */
@property (nonatomic,copy) BOOL (^ido_textFieldShouldReturnBlock)(IDOTextField *textField);

/**
 监听输入框的变化
 */
@property (nonatomic,copy) void (^ido_textFieldDidChangeBlock)(IDOTextField *textField);

/**
 即将要编辑
 */
@property (nonatomic,copy) BOOL (^ido_textFieldShouldBeginEditingBlock)(IDOTextField *textField);

/**
 即将要结束编辑
 */
@property (nonatomic,copy) BOOL (^ido_textFieldShouldEndEditingBlock)(IDOTextField *textField);

/**
 已经完成编辑
 */
@property (nonatomic,copy) void (^ido_textFieldDidEndEditingBlock)(IDOTextField *textField);

/**
 已经开始编辑
 */
@property (nonatomic,copy) void (^ido_textFieldDidBeginEditingBlock)(IDOTextField *textField);

/**
 替换文字
 */
@property (nonatomic,copy) BOOL (^ido_shouldChangeCharactersInRangeReplacementStringBlock)(IDOTextField *textField,NSRange range ,NSString *replacementString);

/**
 结束编辑的原因
 */
@property (nonatomic,copy) void (^ido_textFieldDidEndEditingReasonBlock)(IDOTextField *textField,UITextFieldDidEndEditingReason reason) API_AVAILABLE(ios(10.0));

/**
 失去焦点
 */
- (void)ido_resignFirstResponder;

/**
成为焦点
*/
- (void)ido_becomeFirstResponder;

@end

NS_ASSUME_NONNULL_END
