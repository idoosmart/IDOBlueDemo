//
//  IDOTouchLineView.h
//  IDOUIKitDemo
//
//  Created by 农大浒 on 2020/3/28.
//  Copyright © 2020 农大浒. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//指示竖线的类型
typedef NS_ENUM(NSInteger, IDOTouchLineViewState) {
    IDOTouchLineViewStateBegan      = 0, //开始接触
    IDOTouchLineViewStateMoved      = 1, //移动中
    IDOTouchLineViewStateEnded      = 2, //结束
    IDOTouchLineViewStateCancelled  = 3, //取消
};

@interface IDOTouchLineView : UIView

@property (nonatomic, copy) void (^touchStateRrturnBlock)(IDOTouchLineViewState state, CGPoint point);

@end

NS_ASSUME_NONNULL_END
