//
//  BaseDatePickerView.h
//  SDKDemo
//
//  Created by hedongyang on 2018/6/20.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseDatePickerView : UIDatePicker
@property (nonatomic,copy) NSString * currentDateStr;
@property (nonatomic,copy)void(^datePickerViewCallback)(NSArray * dateArray);
- (void)show;
@end
