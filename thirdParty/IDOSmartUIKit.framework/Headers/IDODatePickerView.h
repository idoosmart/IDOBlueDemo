//
//  IDODatePickerView.h
//  IDOEducation
//
//  Created by TigerNong on 2019/11/4.
//  Copyright © 2019 TigerNong. All rights reserved.
//

/**
 
 点击弹出的时间选择
 
 */

#import "IDOBasePickerView.h"

NS_ASSUME_NONNULL_BEGIN

@interface IDODatePickerView : IDOBasePickerView

/**
 设置最大的时间
 */
@property (nonatomic, strong) NSDate *maximumDate;

/**
设置最小的时间
*/
@property (nonatomic, strong) NSDate *minimumDate;

/**
 设置时间模式
 */
@property (nonatomic,assign) UIDatePickerMode datePickerMode;

/**
 设置选择控制器初始选择的位置，如果没有设置，则表示位当前时间，格式为YYYY-MM-dd,在传参的时候，请注意设置的datePickerMode 的模式是什么；
 UIDatePickerModeDate   ---->   YYYY-MM-dd
 UIDatePickerModeDateAndTime ---->  YYYY-MM-dd HH:mm
 UIDatePickerModeTime  ---->  HH:mm
 UIDatePickerModeCountDownTimer  ---->  HH:mm
 */
@property (nonatomic, copy) NSString *iDateString;



@end

NS_ASSUME_NONNULL_END
