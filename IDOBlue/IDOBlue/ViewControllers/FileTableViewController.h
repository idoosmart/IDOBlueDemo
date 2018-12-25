//
//  FileTableViewController.h
//  IDOBluetoothDemo
//
//  Created by hedongyang on 2018/9/14.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "BaseViewController.h"

@interface FileTableViewController : UITableViewController
@property (nonatomic,copy) void(^selectFile)(NSString * filePath);
@end
