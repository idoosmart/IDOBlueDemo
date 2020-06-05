//
//  IDOAppVersionUpdateView.h
//  IDOSMine
//
//  Created by 农大浒 on 2019/12/30.
//  Copyright © 2019 鲁鲁骁. All rights reserved.
//

#import <UIKit/UIKit.h>

//点击返回的回调
typedef void(^IDOAppVersionUpdateViewHandleBlock)(id _Nullable obj);

NS_ASSUME_NONNULL_BEGIN

@interface IDOAppVersionUpdateView : UIView

/**
 弹出app更新的提示框
  
 @param title 表示提示框的标题，如果发现新版本
 @param version 版本号 v1.0.0
 @param content 更新的信息
 @param newVersionSize 更新版本的大小，因为这个数据是拼接在更新信息后面的，所以在输入的时候最好是输入上”新版本大小:XXXMB“
 @param btnTitle 更新按钮的标题
 @param backImage 弹框的背景图片
 @param showCancelBtn 是否显示取消按钮，如果是强制更新的情况，请输入NO
 @param cancelBtnImage 取消按钮的图片
 @param confirmBlock 点击确认去更新的回调
 @param cancelBlock 点击取消按钮的回调
 */
+ (void)showAppVersionInfoWithTitle:(NSString *)title
                            version:(NSString *)version
                            content:(NSString *)content
                     newVersionSize:(NSString *)newVersionSize
                           btnTitle:(NSString *)btnTitle
                          backImage:(UIImage *)backImage
                      showCancelBtn:(BOOL)showCancelBtn
                     cancelBtnImage:(UIImage *)cancelBtnImage
                      confirmAction:( IDOAppVersionUpdateViewHandleBlock)confirmBlock
                       cancelAction:( IDOAppVersionUpdateViewHandleBlock)cancelBlock;

@end

NS_ASSUME_NONNULL_END
