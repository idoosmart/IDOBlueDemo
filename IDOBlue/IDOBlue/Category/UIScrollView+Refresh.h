//
//  UIScrollView+Refresh.h
//  IDOBlue
//
//  Created by 何东阳 on 2019/7/5.
//  Copyright © 2019 hedongyang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (Refresh)
- (void)addHeaderRefresh;
- (void)endSyncDataRefresh;
- (void)startSyncRefreshing;
- (void)syncTitleLableStr:(NSString *)str;
- (void)syncDataRefreshingBlock:(void (^)(void))block;
@end

NS_ASSUME_NONNULL_END
