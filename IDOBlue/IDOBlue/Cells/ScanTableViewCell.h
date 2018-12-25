//
//  ScanTableViewCell.h
//  IDOBlue
//
//  Created by hedongyang on 2018/10/28.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScanTableViewCell : UITableViewCell
@property (nonatomic,strong) UIButton * updateButton;
@property (nonatomic,strong) UIButton * bindButton;
@property (nonatomic,strong) IDOPeripheralModel * peripheralModel;
@end
