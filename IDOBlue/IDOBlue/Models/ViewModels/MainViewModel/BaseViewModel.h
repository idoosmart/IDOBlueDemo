//
//  BaseViewModel.h
//  IDOBluetoothDemo
//
//  Created by apple on 2018/9/15.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PickerDataModel.h"

@interface BaseViewModel : NSObject
@property (nonatomic,strong) PickerDataModel * pickerDataModel;
@property (nonatomic,strong) NSArray * cellModels;
@property (nonatomic,assign) BOOL is2dArray;
@property (nonatomic,assign) BOOL isRightButton;
@property (nonatomic,assign) BOOL isLeftButton;
@property (nonatomic,assign) BOOL isFootButton;
@property (nonatomic,assign) SEL  rightButton;
@property (nonatomic,assign) SEL  leftButton;
@property (nonatomic,copy)   void(^viewWillDisappearCallback)(UIViewController * viewController);
@property (nonatomic,copy)   void(^viewWillAppearCallback)(UIViewController * viewController);
@property (nonatomic,copy)   void(^delectCellCallback)(UIViewController * viewController,NSIndexPath * indexPath);
@property (nonatomic,copy)   void(^footButtonCallback)(UIViewController * viewController);
@end
