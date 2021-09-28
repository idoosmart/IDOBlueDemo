//
//  SetAppNotifyStateItemViewModel.h
//  IDOBlue
//
//  Created by huangkunhe on 2021/9/6.
//  Copyright © 2021 hedongyang. All rights reserved.
//

#import "BaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SetAppNotifyStateItemViewModel : BaseViewModel

@property (nonatomic,strong,nullable) IDOSetAppNotifyStateItemModel * stateItemModel;
@property (nonatomic,copy) void(^addAppNotifyStateItemModelmComplete)(BOOL isSuccess,IDOSetAppNotifyStateItemModel* itemModel);

@end

NS_ASSUME_NONNULL_END
