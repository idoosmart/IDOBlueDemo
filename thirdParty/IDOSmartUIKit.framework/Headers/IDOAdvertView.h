//
//  IDOAdvertView.h
//  IDOUIKitDemo
//
//  Created by 农大浒 on 2020/1/2.
//  Copyright © 2020 农大浒. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IDOPageControl.h"

typedef NS_ENUM(NSInteger, IDOAdvertViewStyle) {
    IDOAdvertViewStyleEdge,//四边缩进
    IDOAdvertViewStyleFull //全屏
};

NS_ASSUME_NONNULL_BEGIN

@interface IDOAdvertView : UIView
//显示样式
@property (nonatomic, assign) IDOAdvertViewStyle style;

//图片的网络url
@property (nonatomic, strong) NSArray <NSString *>*imageUrls;

//本地图片
@property (nonatomic, strong) NSArray <UIImage *>*images;

//指示器
@property (nonatomic, strong) IDOPageControl *pageControl;

/**
 设置多长时间自动跳过，单位为秒，这个只有是在 style == IDOAdvertViewStyleFull 才会有用,默认设置5秒
 */
@property (nonatomic, assign) NSInteger timeCount;

/**
 跳过按钮的标题，要这样赋值 closeBtnTitle = @“秒跳过” ,这个只有是在 style == IDOAdvertViewStyleFull 才会有用,默认为 "秒跳过"
 */
@property (nonatomic, copy) NSString *closeBtnTitle;

/**
 设置关闭按钮的图片，这个只有是在 style == IDOAdvertViewStyleEdge 才会有用，默认了一个白色的图片
 */
@property (nonatomic, strong) UIImage *closeBtnImage;

/**
 点击图片回调
 */
@property (nonatomic,copy) void (^ClickImageViewBlock)(NSInteger selectedIndex);

//显示那个父类中
- (void)showInSpuerView:(UIView *)superView;

@end

NS_ASSUME_NONNULL_END
