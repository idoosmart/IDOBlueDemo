//
//  UpdateViewController.h
//  IDOBluetoothDemo
//
//  Created by hedongyang on 2018/9/14.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseTableView.h"
#import "UpdateViewControllerModel.h"

@interface UpdateViewController : BaseViewController
@property (nonatomic,strong) UpdateViewControllerModel * model;
@property (nonatomic,strong) BaseTableView * tableView;
@property (nonatomic,copy) NSString * filePath;
@end
