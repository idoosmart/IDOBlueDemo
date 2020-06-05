//
//  IDOSAreaListView.h
//  SinaCreditApp
//
//  Created by 鲁骁 on 2018/5/4.
//  Copyright © 2018年 新浪爱问普惠科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IDOSClassModel;
@interface IDOSAreaListView : UIView

@property (nonatomic, assign) NSInteger currentPlace;//当前滑块要移动的位子

@property(nonatomic , strong)NSMutableArray <IDOSClassModel *>*selectArr;//手动设置显示的省市区

@property (nonatomic , copy) void(^tapBlock)(NSMutableArray <IDOSClassModel *>*areaArr);//点击回调

@property (nonatomic , copy) void(^scrollToBlock)(NSInteger currentPage);//当前滑块已移动的位子

/**
 初始化

 @param selectArr 显示的省市区 可nil
 @return
 */
-(IDOSAreaListView *)initWithSelectArea:(NSMutableArray <IDOSClassModel *>*)selectArr maxAreaLevel:(NSInteger)maxAreaLevel;


@end
