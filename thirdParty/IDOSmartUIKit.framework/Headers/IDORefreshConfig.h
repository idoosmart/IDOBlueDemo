//
//  IDORefreshConfig.h
//  CustomGifRefresh
//
//  Created by 农大浒 on 2020/3/5.
//  Copyright © 2020 JingBei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface IDORefreshConfig : NSObject

+ (IDORefreshConfig *)shareInstance;

/**
 头部正常情况下的图片数组
 */

@property (nonatomic, strong) NSArray <UIImage *>*headerIdleImages;

/**
 头部刷新时的图片
 */
@property (nonatomic, strong) NSArray <UIImage *>*headerRefreshingImages;

/**
 底部正常情况下的图片数组
 */
@property (nonatomic, strong) NSArray <UIImage *>*footerIdleImages;

/**
 底部刷新时的图片
 */
@property (nonatomic, strong) NSArray <UIImage *>*footerRefreshingImages;


/**
 是否隐藏刷新的状态标签
 */
@property (nonatomic, assign) BOOL hiddenStateLabel;

/**
 是否隐藏最后一次刷新的时间标签
 */
@property (nonatomic, assign) BOOL hiddenLastUpdatedTimeLabel;

/**
 动画时间
 */
@property (nonatomic, assign) NSTimeInterval duration;

/**
 图片距离文字的距离
 */
@property (nonatomic, assign) CGFloat labelLeftInset;

/**
 下拉时是否进行alpha值变化
 */
@property (nonatomic, assign) BOOL automaticallyChangeAlpha;

/**
 footer 刷新时，是否隐藏状态文字
 */
@property (nonatomic, assign) BOOL footerRefreshingTitleHidden;

@end

NS_ASSUME_NONNULL_END
