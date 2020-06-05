//
//  IDOBasePickerView.h
//  IDOEducation
//
//  Created by TigerNong on 2019/11/5.
//  Copyright © 2019 TigerNong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IDOUIKitDefine.h"
#import "IDOTouchLineView.h"
#define kToolBarHeight 44

NS_ASSUME_NONNULL_BEGIN

typedef void(^IDOPickerResultBlock)(NSString *pickerText);

typedef NS_ENUM(NSInteger, IDOPickerViewToolBarPosition) {
    IDOPickerViewToolBarPositionTop,    //位于顶部
    IDOPickerViewToolBarPositionBottom, //位于底部
};

typedef NS_ENUM(NSInteger, IDOPickerViewToolBarItemPosition) {
    IDOPickerViewToolBarItemPositionEdge,    //靠近边上
    IDOPickerViewToolBarItemPositionCneter, //靠近中间
};


@interface IDOBasePickerView : UIView
/**
左侧按钮的标题，及取消按钮的标题，在这里给出主要是为了国际化
*/
@property (nonatomic, copy) NSString *cancelBtnTitle;

/**
 取消按钮的文字颜色
 */
@property (nonatomic, strong) UIColor *cancelBtnTextColor;

/**
 右侧按钮的标题，及确定按钮的标题，在这里给出主要是为了国际化
 */
@property (nonatomic, copy) NSString *confirmBtnTitle;

/**
 确定按钮的文字颜色
 */
@property (nonatomic, strong) UIColor *confirmBtnTextColor;

/**
 按钮所在的工具bar
 */
@property (nonatomic, strong) UIToolbar *toolBar;

/**
 工具条所在位置，默认情况下是在顶部，让子类进行重写
 */
@property (nonatomic, assign) IDOPickerViewToolBarPosition toolBarPosition;

/**
 工具条的背景颜色
 */
@property (nonatomic, strong) UIColor *toolBarBackgroudColor;

/**
 显示toolBar顶部的线的颜色,如果不想显示，则把颜色设置成与背景颜色一致
 */
@property (nonatomic, strong) UIColor *toolBarTopLineBackgroudColor;

/**
 toolBar中间竖线的颜色
 */
@property (nonatomic, strong) UIColor *toolBarCenterVLineBackgroudColor;

/**
 按钮是靠近中间还是靠近边
 */
@property (nonatomic, assign) IDOPickerViewToolBarItemPosition itemPositon;

/**
 中间的竖线，可以进行自定义
 */
@property (nonatomic, strong) UIView *centerVlineView;

/**
 弹出的框，上面的44已经是toolBar，所以要在这个上面添加视图，则只能从y为44开始
 */
@property (nonatomic, strong) IDOTouchLineView *contentView;

/**
弹框的高度，默认是350
*/
@property (nonatomic, assign) CGFloat contentViewHeight;

/**
 顶部横线,只有是按钮在下面的情况下才会出现
 */
@property (nonatomic, strong) IDOTouchLineView *lineView;

/**
 自定义lineView的frame,让子类进行重写
 */
@property (nonatomic, assign) CGRect lineViewFrame;

/**
 隐藏选中时的上下两条线
 */
@property (nonatomic, assign) BOOL hiddenSelectedLine;

/**
 手势下滑到一定距离后退出，默认是1/3 contentView的高度,这里 touchLong = 0.5
 */
@property (nonatomic, assign) CGFloat touchLong;

/**
 标题标签
 */
@property (nonatomic, strong) UILabel *titleLabel;

/**
 自定义titleLabel的frame,让子类进行重写
 */
@property (nonatomic, assign) CGRect titleLabelFrame;

/**
 选择结果回调
 */
@property (nonatomic, copy) IDOPickerResultBlock pickerResultBlock;

/**
 点击取消回调
 */
@property (nonatomic, copy) void (^cancelPickerResultBlock)(void);

/**
显示选择框
*/
- (void)show;

/**
 取消按钮点击
 */
- (void)cancelSelect;

/**
确定按钮点击，需要子类进行重写
*/
- (void)confirmSelect;

@end

NS_ASSUME_NONNULL_END
