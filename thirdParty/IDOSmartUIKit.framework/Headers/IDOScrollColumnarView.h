//
//  IDOScrollColumnarView.h
//  IDOEducation
//
//  Created by 农大浒 on 2019/12/5.
//  Copyright © 2019 TigerNong. All rights reserved.

//创建视图的时候，请使用 initWithFrame

#import <UIKit/UIKit.h>
#import "IDOScrollColumnarViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface IDOScrollColumnarView : UIView

/**
 数据模型
 */
@property (nonatomic, strong) IDOScrollColumnarViewModel *scrollColmnarViewModel;

/**
 回调数据
 */
@property (nonatomic, copy) void (^scrollColViewReturnValueBlock)(IDOValueModel *  _Nullable valueModel);

/**
 正在移动竖线,YES表示正在移动，NO表示停止移动
 */
@property (nonatomic, copy) void (^movingShowDataLineBlock)(BOOL move);

/**
 对否隐藏顶替标签和显示数据的竖线
 */
- (void)hiddenTipLabelAndDataLine;


@end

NS_ASSUME_NONNULL_END
