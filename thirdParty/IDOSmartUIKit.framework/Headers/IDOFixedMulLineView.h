//
//  IDOFixedMulLineView.h
//  IDOUIKitDemo
//
//  Created by TigerNong on 2020/2/20.
//  Copyright © 2020 农大浒. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IDOFixedMulLineViewModel.h"

NS_ASSUME_NONNULL_BEGIN

/**
 选择的下标
 */
typedef void(^SelectedReturnBlock)(NSInteger selectedIndex);

@interface IDOFixedMulLineView : UIView

/**
 数据模型
 */
@property (nonatomic, strong) IDOFixedMulLineViewModel *fixMulLineViewModel;

//选中的数据回调
@property (nonatomic, copy) SelectedReturnBlock returnBlock;

/**
 正在移动竖线,YES表示正在移动，NO表示停止移动
 */
@property (nonatomic, copy) void (^movingShowDataLineBlock)(BOOL move);

@end

NS_ASSUME_NONNULL_END
