//
//  ModeSelectViewModel.h
//  IDOBlue
//
//  Created by 何东阳 on 2018/10/15.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "BaseViewModel.h"

@interface ModeSelectViewModel : BaseViewModel
@property (nonatomic,copy)void(^modeSelectCallback)(UIViewController * viewController,NSInteger type);
@end
