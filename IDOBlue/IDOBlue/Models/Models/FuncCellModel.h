//
//  FuncCellModel.h
//  IDOBluetoothDemo
//
//  Created by hedongyang on 2018/9/17.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "BaseCellModel.h"

@interface FuncCellModel : BaseCellModel
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)NSString * titleStr;
@property (nonatomic,assign) BOOL isClick;
@property (nonatomic,assign) BOOL isNoEnabled;
@end
