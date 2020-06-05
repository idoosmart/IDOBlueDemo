//
//  IDOTableView.h
//  UIKitDemo
//
//  Created by 农大浒 on 2019/12/26.
//  Copyright © 2019 农大浒. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <IDOThirdParty/MJRefresh.h>

NS_ASSUME_NONNULL_BEGIN

@interface IDOTableView : UITableView


/**
 是否显示空数据情况的视图
 */
@property (nonatomic, assign) BOOL showEmptyView;

//显示的文字
@property (nonatomic, copy) NSString *emptyMessage;

//显示的图片
@property (nonatomic, strong) UIImage *emptyImage;

/**
 如果是存在有图片和文字一起，则表示图片距离顶部的高度，如果只有图片或者文字，则表示中心y轴的偏移
 */
@property (nonatomic, assign) CGFloat toTopMargin;

//自定义图片视图
@property (nonatomic, strong) UIImageView *customEmptyImageView;

//自定义信息标签
@property (nonatomic, strong) UILabel *customEmptyMessageLabel;



@end

NS_ASSUME_NONNULL_END
