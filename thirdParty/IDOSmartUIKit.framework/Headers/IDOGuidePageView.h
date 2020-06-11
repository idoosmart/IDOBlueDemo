//
//  IDOGuidePageView.h
//  IDOSmartUIKit
//
//  Created by 鲁鲁骁 on 2020/4/26.
//  Copyright © 2020 农大浒. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IDOGuidePageModel;
NS_ASSUME_NONNULL_BEGIN

@interface IDOGuidePageView : UIView
/**
 *  scrollview
 */
@property (nonatomic , strong) UIScrollView *scrollView;
/**
 *  label
 */
@property (nonatomic , strong) UILabel *mainLabel;
/**
 *  subLabel
 */
@property (nonatomic , strong) UILabel *subLabel;
/**
 *  pagectr
 */
@property (nonatomic , strong) UIPageControl *pageCtr;
/**
 *  closeBtn
 */
@property (nonatomic , strong) UIButton *closeBtn;
/**
 *  beginBtn
 */
@property (nonatomic , strong) UIButton *beginBtn;
/**
 *  jump进入主页
 */
@property (nonatomic , copy) void(^jumpBlcok)(void);


+(IDOGuidePageView *)makeGuidePageViewWithModels:(NSArray <IDOGuidePageModel *>*)models;
@end

@interface IDOGuidePageModel : NSObject
/**
 *  image
 */
@property (nonatomic , strong) UIImage *image;
/**
 *  title
 */
@property (nonatomic , copy)  NSString *title;
/**
 *  subTitle
 */
@property (nonatomic , copy)  NSString *subTitle;
@end

NS_ASSUME_NONNULL_END
