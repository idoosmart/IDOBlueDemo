//
//  TextFieldCellModel.h
//  IDOBluetoothDemo
//
//  Created by apple on 2018/9/24.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "BaseCellModel.h"

@interface TextFieldCellModel : BaseCellModel
@property (nonatomic,copy)void(^textFeildCallback)(UIViewController * viewController,UITextField * textField,UITableViewCell * tableViewCell);
@property (nonatomic,copy)   NSString * titleStr;
@property (nonatomic,copy)   NSArray * placeholders;
@property (nonatomic,assign)  BOOL isShowKeyboard;
@end
