//
//  MJRefreshAnimationHeader.h
//  IDOThirdParty
//
//  Created by 鲁鲁骁 on 2020/1/20.
//  Copyright © 2020 鲁鲁骁. All rights reserved.
//

#import <IDOThirdParty/IDOThirdParty.h>

NS_ASSUME_NONNULL_BEGIN

@interface MJRefreshAnimationHeader : MJRefreshStateHeader
/**
 *  动画imageview
 */
@property (nonatomic , strong) UIImageView *animatImageView;

/**
 *  加载image
 */
@property (nonatomic , strong) UIImage *loadingImage;

/**
 *  加载成功image
 */
@property (nonatomic , strong) UIImage *completeImage;

/**< 设置加载成功 */
-(void)setStateComplete;
@end

NS_ASSUME_NONNULL_END
