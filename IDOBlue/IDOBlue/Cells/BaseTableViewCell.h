//
//  BaseTableViewCell.h
//  IDOBluetoothDemo
//
//  Created by apple on 2018/9/14.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCellModel.h"

@interface BaseTableViewCell : UITableViewCell
- (void)setCellModel:(BaseCellModel *)model;
@end
