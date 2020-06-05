//
//  IDOFixedHeartView.h
//  IDOEducation
//
//  Created by TigerNong on 2019/12/14.
//  Copyright © 2019 TigerNong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IDOFixedLineViewModel.h"

typedef void(^ReturnBlock)(IDOValueModel *  _Nullable valueModel);

NS_ASSUME_NONNULL_BEGIN

@interface IDOFixedLineView : UIView

@property (nonatomic, strong) IDOFixedLineViewModel *fixedLineViewModel;

//选中的数据回调
@property (nonatomic, copy) ReturnBlock returnBlock;

/**
 正在移动
 */
@property (nonatomic, copy) ReturnBlock moveingLineBlock;

/**
 结束移动
 */
@property (nonatomic, copy) ReturnBlock endMoveLineBlock;

@end

NS_ASSUME_NONNULL_END
