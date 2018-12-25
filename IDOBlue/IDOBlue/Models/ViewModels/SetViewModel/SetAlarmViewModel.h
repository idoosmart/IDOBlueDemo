//
//  SetAlarmViewModel.h
//  IDOBluetoothDemo
//
//  Created by hedongyang on 2018/9/26.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "BaseViewModel.h"

@interface SetAlarmViewModel : BaseViewModel
@property (nonatomic,strong) IDOSetAlarmInfoBluetoothModel * alarmModel;
@property (nonatomic,copy) void(^addAlarmComplete)(BOOL isSuccess);
@end
