//
//  SetV3ScheduleRemindItemViewModel.h
//  IDOBlue
//
//  Created by huangkunhe on 2021/9/4.
//  Copyright © 2021 hedongyang. All rights reserved.
//

#import "BaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SetV3ScheduleRemindItemViewModel : BaseViewModel

@property (nonatomic,strong,nullable) IDOSetRemindItemModel * remindItemModel;
@property (nonatomic,copy) void(^addRemindItemComplete)(BOOL isSuccess,IDOSetRemindItemModel * itemModel);

@end

NS_ASSUME_NONNULL_END
