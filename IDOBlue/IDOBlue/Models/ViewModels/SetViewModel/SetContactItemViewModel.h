//
//  SetContactItemViewModel.h
//  IDOBlue
//
//  Created by huangkunhe on 2021/9/6.
//  Copyright © 2021 hedongyang. All rights reserved.
//

#import "BaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SetContactItemViewModel : BaseViewModel


@property (nonatomic,strong,nullable) IDOSetContactItemModel * contactItemModel;
@property (nonatomic,copy) void(^addContactItemComplete)(BOOL isSuccess,IDOSetContactItemModel * itemModel);

@end

NS_ASSUME_NONNULL_END
