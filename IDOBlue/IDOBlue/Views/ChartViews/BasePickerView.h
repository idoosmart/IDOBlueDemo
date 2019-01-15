//
//  BasePickerView.h
//  SDKDemo
//
//  Created by apple on 2018/6/18.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasePickerView : UIPickerView
@property (nonatomic,copy) NSArray * pickerArray;
@property (nonatomic,assign) NSInteger currentIndex;
@property (nonatomic,copy)void(^pickerViewCallback)(NSString * selectStr);
- (void)show;
@end
