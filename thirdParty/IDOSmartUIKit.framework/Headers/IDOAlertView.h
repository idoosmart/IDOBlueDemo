//
//  IDOAlertView.h
//  IDOEducation
//
//  Created by TigerNong on 2019/11/14.
//  Copyright © 2019 TigerNong. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IDOAlertCommonHeader.h"

#warning 注意：如果在多个地方使用时，记得需要设置多次设置IDOAlertViewConfig的属性


NS_ASSUME_NONNULL_BEGIN

@interface IDOAlertView : UIView

#pragma mark - Sheet

/**
 sheet
 @param title 标题
 @param message 信息或者是副标题
 @param alignment 信息或者副标题的对齐方式
 @param items 数据数组
 @param gestureOut 手势退出，只有是底部弹出的时候可以使用
 @param itemitemAlignment 数据对齐方式
 @param cancelTitle 取消按钮的标题
 @param confirmTitle 确定按钮，如果不需要可以直接写nil
 @param type 主要显示在哪个位置，如果是在上边出来，则不会存在有标题和信息
 @param rightButtonType 表示右侧按钮的是可以进行什么动作
 @param rightBlock 点击右侧按钮的回调，只有点击删除和才会使用到,
 @param block 点击item的回调
 @param cancelBlock 取消按钮的回到
 */
+ (void)showSheetTitle:(nullable NSString *)title
               message:(nullable NSString *)message
      messageAlignment:(NSTextAlignment)alignment
                 items:(nullable NSArray <IDOAletViewItemModel *>*)items
            gestureOut:(BOOL)gestureOut
         itemAlignment:(NSTextAlignment)itemitemAlignment
       cancelItemTitle:(nullable NSString *)cancelTitle
     confirmItemTitle:(nullable NSString *)confirmTitle
 alertViewPositionType:(IDOAlertViewPositionType)type
       rightButtonType:(IDOAlertViewItemRightViewType)rightButtonType
 itemRightButtonAction:(nullable IDOAlertViewHandleBlock)rightBlock
          handleAction:(nullable IDOAlertViewHandleBlock)block
          cancelAction:(nullable IDOAlertViewHandleBlock)cancelBlock;

/**
 默认从底部弹出，需要设置item的对其方式，默认为不显示右侧按钮
 */
+ (void)showFromBottomSheetTitle:(nullable NSString *)title
                         message:(nullable NSString *)message
                           items:(NSArray <NSString *>*)items
                      gestureOut:(BOOL)gestureOut
                   itemAlignment:(NSTextAlignment)itemitemAlignment
                     cancelTitle:(NSString *)cancelTitle
                    confirmTitle:(nullable NSString *)confirmTitle
                    handleAction:(nullable IDOAlertViewHandleBlock)block
                    cancelAction:(nullable IDOAlertViewHandleBlock)cancelBlock;

/**
默认从底部弹出,文字默认中间，默认为不显示右侧按钮
*/
+ (void)showFromBottomSheetTitle:(nullable NSString *)title
                         message:(nullable NSString *)message
                           items:(NSArray <NSString *>*)items
                      gestureOut:(BOOL)gestureOut
                     cancelTitle:(NSString *)cancelTitle
                    confirmTitle:(nullable NSString *)confirmTitle
                    handleAction:(nullable IDOAlertViewHandleBlock)block
                    cancelAction:(nullable IDOAlertViewHandleBlock)cancelBlock;

/**
默认从底部弹出,文字默认靠左对齐，默认为显示右侧的删除按钮
*/
+ (void)showFromBottomWithRightDeleteButtonSheetTitle:(nullable NSString *)title
                                              message:(nullable NSString *)message
                                                items:(NSArray <NSString *>*)items
                                           gestureOut:(BOOL)gestureOut
                                          cancelTitle:(NSString *)cancelTitle
                                         confirmTitle:(nullable NSString *)confirmTitle
                                itemRightButtonAction:(nullable IDOAlertViewHandleBlock)rightBlock
                                         handleAction:(nullable IDOAlertViewHandleBlock)block
                                         cancelAction:(nullable IDOAlertViewHandleBlock)cancelBlock;

/**
 默认从顶部弹出，需要设置item的对其方式，默认为不显示右侧按钮
 */
+ (void)showFromTopSheetTitle:(nullable NSString *)title
                      message:(nullable NSString *)message
                        items:(NSArray <NSString *>*)items
                itemAlignment:(NSTextAlignment)itemitemAlignment
                  cancelTitle:(NSString *)cancelTitle
                 confirmTitle:(nullable NSString *)confirmTitle
                 handleAction:(nullable IDOAlertViewHandleBlock)block
                 cancelAction:(nullable IDOAlertViewHandleBlock)cancelBlock;

/**
默认从顶部弹出,文字默认中间,默认为不显示右侧按钮
*/
+ (void)showFromTopSheetTitle:(nullable NSString *)title
                      message:(nullable NSString *)message
                        items:(NSArray <NSString *>*)items
                  cancelTitle:(NSString *)cancelTitle
                 confirmTitle:(nullable NSString *)confirmTitle
                 handleAction:(nullable IDOAlertViewHandleBlock)block
                 cancelAction:(nullable IDOAlertViewHandleBlock)cancelBlock;

/**
 顶部弹出，显示右侧单选的按钮，默认item文字靠左
 */
+ (void)showFromTopWithRightButtonSingleSeletedSheetItems:(NSArray <NSString *>*)items
                                              cancelTitle:(NSString *)cancelTitle
                                             confirmTitle:(nullable NSString *)confirmTitle
                                             handleAction:(nullable IDOAlertViewHandleBlock)block
                                             cancelAction:(nullable IDOAlertViewHandleBlock)cancelBlock;

/**
 默认中间弹出，需要设置item的对其方式，默认为不显示右侧按钮
 */
+ (void)showFromCenterSheetTitle:(nullable NSString *)title
                         message:(nullable NSString *)message
                           items:(NSArray <NSString *>*)items
                   itemAlignment:(NSTextAlignment)itemitemAlignment
                     cancelTitle:(NSString *)cancelTitle
                    confirmTitle:(nullable NSString *)confirmTitle
                    handleAction:(nullable IDOAlertViewHandleBlock)block
                    cancelAction:(nullable IDOAlertViewHandleBlock)cancelBlock;

/**
默认从中间弹出,文字默认中间,默认为不显示右侧按钮
*/
+ (void)showFromCenterSheetTitle:(nullable NSString *)title
                         message:(nullable NSString *)message
                           items:(NSArray <NSString *>*)items
                     cancelTitle:(NSString *)cancelTitle
                    confirmTitle:(nullable NSString *)confirmTitle
                    handleAction:(nullable IDOAlertViewHandleBlock)block
                    cancelAction:(nullable IDOAlertViewHandleBlock)cancelBlock;


/**
默认从中间弹出,文字默认靠左，右侧默认为多选择按钮
*/
+ (void)showMulSeletedFromCenterSheetTitle:(nullable NSString *)title
                         message:(nullable NSString *)message
                           items:(NSArray <NSString *>*)items
                     cancelTitle:(NSString *)cancelTitle
                    confirmTitle:(nullable NSString *)confirmTitle
                    handleAction:(nullable IDOAlertViewHandleBlock)block
                    cancelAction:(nullable IDOAlertViewHandleBlock)cancelBlock;

#pragma mark - Alert
/**
 alert
 @param title 标题
 @param message 信息或者是副标题
 @param image 图片，比如是在提示app更新的时候，显示更新的图片
 @param hide 一般情况下这个都是YES，但是如果是强转更新app则，这里需要写NO
 @param cancelTitle 取消按钮
 @param confirmTitle 确定按钮
 @param type 取消按钮的放在位置，左，上，下，右
 @param confirmBlock 点击确定按钮回调,里面的数组都是nil
 @param cancelBlock 点击取消按钮回调,里面的数组都是nil
 */
+ (void)showAlertTitle:(nullable NSString *)title
               message:(nullable NSString *)message
                 image:(nullable UIImage *)image
         hideAlertView:(BOOL)hide
           cancelTitle:(NSString *)cancelTitle
          confirmTitle:(nullable NSString *)confirmTitle
cancelButtonPositionType:(IDOTwoItemLayoutType)type
         confirmAction:(nullable IDOAlertViewHandleBlock)confirmBlock
          cancelAction:(nullable IDOAlertViewHandleBlock)cancelBlock;


/**
 没有图片，默认取消按钮再左边，可以关闭提示框,
 */
+ (void)showAlertTitle:(nullable NSString *)title
               message:(nullable NSString *)message
      messageAlignment:(NSTextAlignment)messageAlignment
           cancelTitle:(NSString *)cancelTitle
          confirmTitle:(nullable NSString *)confirmTitle
         confirmAction:(nullable IDOAlertViewHandleBlock)confirmBlock
          cancelAction:(nullable IDOAlertViewHandleBlock)cancelBlock;

/**
 没有图片，默认取消按钮再左边，可以关闭提示框,文字默认居中
 */
+ (void)showAlertTitle:(nullable NSString *)title
               message:(nullable NSString *)message
           cancelTitle:(NSString *)cancelTitle
          confirmTitle:(nullable NSString *)confirmTitle
         confirmAction:(nullable IDOAlertViewHandleBlock)confirmBlock
          cancelAction:(nullable IDOAlertViewHandleBlock)cancelBlock;

/**
 没有标题，存在有图片,可以关闭提示框,文字默认居中
 */
+ (void)showAlertImage:(nullable UIImage *)image
               message:(nullable NSString *)message
           cancelTitle:(NSString *)cancelTitle
          confirmTitle:(nullable NSString *)confirmTitle
         confirmAction:(nullable IDOAlertViewHandleBlock)confirmBlock
          cancelAction:(nullable IDOAlertViewHandleBlock)cancelBlock;



@end

NS_ASSUME_NONNULL_END
