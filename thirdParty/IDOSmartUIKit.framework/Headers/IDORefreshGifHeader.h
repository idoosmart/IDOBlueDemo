//
//  CustomGifHeader.h
//  CustomGifRefresh
//
//  Created by WXQ on 2018/8/20.
//  Copyright © 2018年 JingBei. All rights reserved.
//

#import <IDOThirdParty/MJRefresh.h>
#import "IDORefreshConfig.h"

/**
 在使用这个之前，请先配置好 IDORefreshConfig
 
 样例如下配置：
 if (!self.refreshGitHeader) {
     NSArray * idleImages = [self getRefreshingImageArrayWithStartIndex:1 endIndex:9];
     
     [IDORefreshConfig shareInstance].headerRefreshingImages = [idleImages copy];
     [IDORefreshConfig shareInstance].headerIdleImages = [idleImages copy];
     
     [IDORefreshConfig shareInstance].hiddenStateLabel = NO;
     [IDORefreshConfig shareInstance].hiddenLastUpdatedTimeLabel = YES;
     [IDORefreshConfig shareInstance].duration = 0.15;
     [IDORefreshConfig shareInstance].labelLeftInset = 8;
     
     self.refreshGitHeader = [IDORefreshGifHeader headerWithRefreshingBlock:^{
         if (completionBlock) {
             completionBlock();
         }
     }];
     
     [self.refreshGitHeader setTitle:@"下拉加载" forState:MJRefreshStateIdle];
     [self.refreshGitHeader setTitle:@"松开刷新" forState:MJRefreshStatePulling];
     [self.refreshGitHeader setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
     [self.refreshGitHeader setTitle:@"即将刷新的状态" forState:MJRefreshStateWillRefresh];
     [self.refreshGitHeader setTitle:@"没有更多的数据了" forState:MJRefreshStateNoMoreData];
     
     if (type == IDORefreshGifHeaderTypeLight) {
         self.refreshGitHeader.stateLabel.textColor = [UIColor whiteColor];
         self.refreshGitHeader.lastUpdatedTimeLabel.textColor = [UIColor whiteColor];
     }else{
         self.refreshGitHeader.stateLabel.textColor = COLOR(@"#B1B4B9");
         self.refreshGitHeader.lastUpdatedTimeLabel.textColor = COLOR(@"#B1B4B9");
     }
     
     self.refreshGitHeader.stateLabel.font = K_PINGFANG_SC_MEDIUM_FONT(12);
 }
 
 */

@interface IDORefreshGifHeader : MJRefreshGifHeader


@end
