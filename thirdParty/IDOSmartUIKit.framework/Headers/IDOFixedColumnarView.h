//
//  IDOColumnarView.h
//  IDOEducation
//
//  Created by 农大浒 on 2019/12/3.
//  Copyright © 2019 TigerNong. All rights reserved.
//  不能滑动的

#import <UIKit/UIKit.h>
#import "IDOFixedColumnarViewModel.h"

typedef void(^columnaerReturnBlock)(IDOValueModel *  _Nullable valueModel);

NS_ASSUME_NONNULL_BEGIN

@interface IDOFixedColumnarView : UIView

@property (nonatomic, strong) IDOFixedColumnarViewModel *fixedColmnarViewModel;

/**
 回调
 */
@property (nonatomic, copy) columnaerReturnBlock returnBlock;

/**
 正在移动竖线,YES表示正在移动，NO表示停止移动
 */
@property (nonatomic, copy) void (^movingShowDataLineBlock)(BOOL move);

@end

NS_ASSUME_NONNULL_END
