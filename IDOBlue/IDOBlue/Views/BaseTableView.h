//
//  BaseTableView.h
//  SDKDemo
//
//  Created by apple on 2018/6/17.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewControllerModel.h"

@interface BaseTableView : UITableView
@property (nonatomic,strong) BaseViewControllerModel * model;
@end
