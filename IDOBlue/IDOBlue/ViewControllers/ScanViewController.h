//
//  ScanViewController.h
//  IDOBluetoothDemo
//
//  Created by hedongyang on 2018/8/31.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScanViewController : UITableViewController
@property (nonatomic,assign) BOOL selectList;
@property (nonatomic,copy) void(^selectDevice)(IDOPeripheralModel * model);
@end
