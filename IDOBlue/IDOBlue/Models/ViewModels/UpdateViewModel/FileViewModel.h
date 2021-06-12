//
//  FileViewModel.h
//  IDOBluetoothDemo
//
//  Created by apple on 2018/9/16.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "BaseViewModel.h"

@interface FileViewModel : BaseViewModel
@property (nonatomic,assign) NSInteger type; /*0:固件 1:AGPS 2:沙盒文件*/
@property (nonatomic,assign) BOOL isCanSelectDir;
@end
