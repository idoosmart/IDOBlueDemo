//
//  IDOMulDrawLineModel.h
//  IDOUIKitDemo
//
//  Created by TigerNong on 2020/2/20.
//  Copyright © 2020 农大浒. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class IDOMulCountsLineModel,IDOMulItemsModel;

@interface IDOMulDrawLinesModel : NSObject

/**
 绘制多少条线
 */
@property (nonatomic, strong)NSArray <IDOMulCountsLineModel *>*lines;

@end

@interface IDOMulCountsLineModel : NSObject
/**
 一条线，分成几段来绘制
 */
@property (nonatomic, strong)NSArray <IDOMulItemsModel *>*counts;

/**
 线的颜色
 */
@property (nonatomic, strong) UIColor *lineColor;

/**
 线的宽带
 */
@property (nonatomic, assign) CGFloat lineWidth;

@end

@interface IDOMulItemsModel : NSObject
/**
 每段里面有多少个数据,数组里面就是每个点的数值
  在外面进行传值时，请先把CGPoint 转换成NSValue
 */
@property (nonatomic, strong)NSArray <NSValue *>*items;

@end

NS_ASSUME_NONNULL_END
