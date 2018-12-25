//
//  ViewController.h
//  SDKDemo
//
//  Created by hedongyang on 2018/6/6.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "BaseViewModel.h"
#import "FuncTableView.h"

@interface FuncViewController : BaseViewController
@property (nonatomic,strong) BaseViewModel * model;
@property (nonatomic,strong) FuncTableView * tableView;
- (void)reloadData;
@end

