//
//  IDOSleepColumnarView.h
//  IDOEducation
//
//  Created by 农大浒 on 2019/12/11.
//  Copyright © 2019 TigerNong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IDOSleepViewModel.h"

typedef void(^SleepReturnBlock)(IDOSleepItemModel *  _Nullable sleepItem);
NS_ASSUME_NONNULL_BEGIN

@interface IDOSleepColumnarView : UIView

/**
 数据模型
 */
@property (nonatomic, strong) IDOSleepViewModel *sleepViewModel;

//选中的数据回调
@property (nonatomic, copy) SleepReturnBlock returnBlock;

@end

NS_ASSUME_NONNULL_END
