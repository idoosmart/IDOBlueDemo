//
//  SetWorldTimeViewModel.h
//  IDOBlue
//  设置世界时间
//  Created by xiongjie on 2021/8/11.
//  Copyright © 2021 hedongyang. All rights reserved.
//

#import "BaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SetWorldTimeViewModel : BaseViewModel

@property (nonatomic,strong,nullable) IDOSetV3WorldTimeItemModel * timeItemModel;
@property (nonatomic,copy) void(^addWorldTimeComplete)(BOOL isSuccess,IDOSetV3WorldTimeItemModel * itemModel);

@end

NS_ASSUME_NONNULL_END
