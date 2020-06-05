//
//  IDOSAlertInforView.h
//  IDOSmartUIKit
//
//  Created by 鲁鲁骁 on 2020/1/17.
//  Copyright © 2020 农大浒. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IDOSAlertInforModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface IDOSAlertInforView : UIView

/**
 *  title 
 */
@property (nonatomic , strong) UILabel *titleLabel;

/**
 *  内容Label
 */
@property (nonatomic , strong) UILabel *detailLabel;

/**
 *  关闭
 */
@property (nonatomic , strong) UIButton *closeBtn;

/**
 *  infor:颜色，标准model
 *  title:title
 *  detail：内容介绍
 */
- (instancetype)initWithInfor:(nonnull NSArray <IDOSAlertInforModel *>*)infor title:(NSString *)title detail:(NSString *)detail;

-(void)show;

-(void)dismiss;

@end

NS_ASSUME_NONNULL_END
