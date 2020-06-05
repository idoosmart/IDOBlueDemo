//
//  IDOSAlertInforModel.h
//  IDOSmartUIKit
//
//  Created by 鲁鲁骁 on 2020/1/18.
//  Copyright © 2020 农大浒. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IDOSAlertInforModel : NSObject

/**
 *  显示的数值
 */
@property (nonatomic, strong) NSString * showNumber;

/**
 *  色差分界点  可以不设置，平均分配
 */
@property (nonatomic, assign) float colorPoint;

/**
 *  色值
 */
@property (nonatomic , strong) NSString *hexColor;

/**
 *  title
 */
@property (nonatomic , strong) NSString *title;
@end

NS_ASSUME_NONNULL_END
