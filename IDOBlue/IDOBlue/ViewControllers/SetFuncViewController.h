//
//  SetFuncViewController.h
//  SDKDemo
//
//  Created by apple on 2018/6/18.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "FuncViewController.h"
#import "BasePickerView.h"
#import "BaseDatePickerView.h"

@interface SetFuncViewController : FuncViewController
@property (nonatomic,strong) BasePickerView * pickerView;
@property (nonatomic,strong) BaseDatePickerView * datePickerView;
@end
