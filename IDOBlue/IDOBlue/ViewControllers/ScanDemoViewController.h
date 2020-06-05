//
//  IDOScanDemoViewController.h
//  IDOUIKitDemo
//
//  Created by 农大浒 on 2019/12/23.
//  Copyright © 2019 农大浒. All rights reserved.
//

#import <IDOSmartUIKit/IDOSmartUIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ScanDemoViewController : IDOBaseViewController
@property (nonatomic,copy) void(^scanQRcodeCallback)(NSString * str,UIViewController * vc);
@end

NS_ASSUME_NONNULL_END
