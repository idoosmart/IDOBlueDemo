//
//  IDOFixedMaxMinColumnarView.h
//  IDOEducation
//
//  Created by 农大浒 on 2019/12/10.
//  Copyright © 2019 TigerNong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IDOChartCommonHeader.h"
#import "IDOMaxMinColumnarViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface IDOFixedMaxMinColumnarView : UIView

@property (nonatomic, strong) IDOMaxMinColumnarViewModel *maxMinViewModel;

/**
回调数据
*/
@property (nonatomic, copy) void (^ReturnValueBlock) (IDOMaxMinModel *model);

/**
 正在移动竖线,YES表示正在移动，NO表示停止移动
 */
@property (nonatomic, copy) void (^movingShowDataLineBlock)(BOOL move);

@end

NS_ASSUME_NONNULL_END