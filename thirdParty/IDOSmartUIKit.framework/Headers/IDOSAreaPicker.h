//
//  IDOSAreaPicker.h
//  SinaCreditApp
//
//  Created by 鲁骁 on 2018/5/3.
//  Copyright © 2018年 新浪爱问普惠科技有限公司. All rights reserved.
//  省市区选择器

#import <UIKit/UIKit.h>
@class IDOSClassModel;
@interface IDOSAreaPicker : UIView

/**
 点击关闭pick回调
 */
@property (nonatomic , copy) void(^closeBlock)(void);

/**
 点击省市区回调
 */
@property (nonatomic , copy) void(^selectAreaBlcok)(NSMutableArray<IDOSClassModel *>* areaArr,NSString *locationStr);

@property (nonatomic , copy)  NSString *areaCode;//地区code

@property (nonatomic , strong)  UILabel *pickTitle;//默认‘请选择地址’

@property (nonatomic, copy) NSString *title;


-(IDOSAreaPicker *)initWithAreaCode:(NSMutableArray *)areaArr maxAreaLevel:(NSInteger)maxAreaLevel;


-(void)show;
-(void)hide;

@end
