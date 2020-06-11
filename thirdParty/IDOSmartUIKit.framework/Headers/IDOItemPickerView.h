//
//  IDOItemPickerView.h
//  IDOSmartUIKit
//
//  Created by 农大浒 on 2020/5/22.
//  Copyright © 2020 农大浒. All rights reserved.
//

#import <IDOSmartUIKit/IDOSmartUIKit.h>
#import "IDOItemModel.h"

NS_ASSUME_NONNULL_BEGIN


@interface IDOItemPickerView : IDOBasePickerView

/**
 是否隐藏按钮
 */
@property (nonatomic, assign) BOOL hiddenToolBar;

/**
 显示几列，如果数量少于指定的列数，则按照事件的来显示，默认显示3列
 */
@property (nonatomic, assign) NSInteger colCount;


/**
 每个的高度
 */
@property (nonatomic, assign) CGFloat itemHeight;

/**
 左边缩减的距离
 */
@property (nonatomic, assign) CGFloat leftPadding;

/**
 collectionView 与上面顶部线条的距离
 */
@property (nonatomic, assign) CGFloat collectionViewTopLineViewHeight;

/**
 行间距
 */
@property (nonatomic, assign) CGFloat minimumLineSpacing;

/**
 列间距
 */
@property (nonatomic, assign) CGFloat minimumInteritemSpacing;

/**
 数据源数组，里面数图片
 */
@property (nonatomic, strong) NSArray <IDOItemModel *>*datas;

/**
 点击回调
 */
@property (nonatomic, copy) void (^didSelectItemAtIndexPathBlock)(NSInteger index);

@end

NS_ASSUME_NONNULL_END
