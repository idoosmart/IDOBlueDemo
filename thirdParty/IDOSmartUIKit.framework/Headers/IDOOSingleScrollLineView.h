//
//  IDOMulScrollLineView.h
//  IDOUIKitDemo
//
//  Created by 农大浒 on 2020/4/16.
//  Copyright © 2020 农大浒. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IDOOSingleScrollLineViewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface IDOOSingleScrollLineView : UIView

/**
 数据模型
 */
@property (nonatomic, strong) IDOOSingleScrollLineViewModel *scrollLineViewModel;

/**
 回调数据
 */
@property (nonatomic, copy) void (^ReturnValueBlock) (IDOValueModel *model);

/**
 正在移动竖线,YES表示正在移动，NO表示停止移动
 */
@property (nonatomic, copy) void (^movingShowDataLineBlock)(BOOL move);


/**
 是否正在滑动滚动视图
 */
@property (nonatomic, copy) void (^scrollingScrollViewBlock)(BOOL scroll);
@end

NS_ASSUME_NONNULL_END
