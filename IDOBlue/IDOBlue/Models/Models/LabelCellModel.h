//
//  LabelCellModel.h
//  IDOBluetoothDemo
//
//  Created by hedongyang on 2018/9/17.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "BaseCellModel.h"

@interface LabelCellModel : BaseCellModel
@property (nonatomic,copy)void(^labelSelectCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,assign) BOOL isSelected;
@property (nonatomic,assign) BOOL isMultiSelect;
@property (nonatomic,assign) BOOL isCenter;
@property (nonatomic,assign) NSInteger fontSize;
@end
