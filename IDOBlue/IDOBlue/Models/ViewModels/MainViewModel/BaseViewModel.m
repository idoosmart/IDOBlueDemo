//
//  BaseViewModel.m
//  IDOBluetoothDemo
//
//  Created by apple on 2018/9/15.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "BaseViewModel.h"

@implementation BaseViewModel

- (PickerDataModel *)pickerDataModel
{
    if (!_pickerDataModel) {
        _pickerDataModel = [[PickerDataModel alloc]init];
    }
    return _pickerDataModel;
}

@end
