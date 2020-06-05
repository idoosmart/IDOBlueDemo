//
//  IDOSegmentViewController.h
//  IDOEducation
//
//  Created by TigerNong on 2019/11/11.
//  Copyright © 2019 TigerNong. All rights reserved.
//

#import "IDONaviBaseViewController.h"
#import "IDOSegmentView.h"

typedef NS_ENUM(NSInteger, IDOTitleViewAddToSuperViewType) {
    IDOTitleViewAddToSuperViewTypeNavigationBar,        //设置为导航栏的titleView
    IDOTitleViewAddToSuperViewTypeControllerViewTop,   //放在控制器的view的顶部
};

NS_ASSUME_NONNULL_BEGIN

@interface IDOSegmentViewController : IDONaviBaseViewController

/**
 创建一个segment的控制器
 
 @param titles 标题数组
 @param controllers 控制器数组
 @param titleViewFrame 标题视图的frame
 @param selectedIndex 选中的下标
 @param type 把标题视图添加到那个地方
 */
- (instancetype)initWithTitles:(NSArray <NSString *>*)titles controllers:(NSArray <UIViewController *>*) controllers titleViewFrame:(CGRect)titleViewFrame selectedIndex:(NSInteger)selectedIndex segmentToType:(IDOTitleViewAddToSuperViewType)type segmentViewType:(IDOSegmentViewType)segmentType;

/**
 内容的滚动视图
 */
@property (nonatomic, strong) UIScrollView *containerScrollView;

/**
 设置标题视图中标题的默认颜色
 */
@property (nonatomic, strong) UIColor *titleViewTextNormalColor;

/**
设置标题视图中标题的选中颜色
*/
@property (nonatomic, strong) UIColor *titleViewTextSelectedColor;

/**
 标题视图的背景颜色
 */
@property (nonatomic, strong) UIColor *titleViewBackgroupColor;

/**
 提示背景颜色
 */
@property (nonatomic, strong) UIColor *indicatorViewColor;

/**
 默认标题的文字大小
 */
@property (nonatomic, strong) UIFont *titleNormalFont;

/**
 选中标题的文字大小
 */
@property (nonatomic, strong) UIFont *titleSelectedFont;

/**
 点击回调
 */
@property (nonatomic, copy) IDOSegmentDidClickBlock segmentDidClickBlock;



@end

NS_ASSUME_NONNULL_END
