//
//  UIScrollView+Refresh.m
//  IDOBlue
//
//  Created by 何东阳 on 2019/7/5.
//  Copyright © 2019 hedongyang. All rights reserved.
//

#import "UIScrollView+Refresh.h"
#import "IDODemoUtility.h"
#import <objc/runtime.h>

@interface RefreshHeader : UIView
@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) UIActivityIndicatorView * activityView;
@property (nonatomic,assign) BOOL isRefreshIng;
@property (nonatomic,copy) void(^refreshingBlock)(void);
- (void)endSyncDataRefresh;
- (void)startSyncRefreshing;
@end

@implementation RefreshHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        __weak typeof(self) weakSelf = self;
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong typeof(self) strongSelf = weakSelf;
            make.left.equalTo(strongSelf.mas_centerX).offset(-40);
            make.right.equalTo(@(-16));
            make.top.bottom.equalTo(@0);
        }];
        [self.activityView mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong typeof(self) strongSelf = weakSelf;
            make.centerY.equalTo(strongSelf.mas_centerY);
            make.right.equalTo(strongSelf.titleLabel.mas_left);
            make.width.height.equalTo(@40);
        }];
        
    }
    return self;
}

- (UIActivityIndicatorView *)activityView
{
    if (!_activityView) {
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self addSubview:activityView];
        _activityView = activityView;
    }
    return _activityView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:titleLabel];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    [self.superview removeObserver:self forKeyPath:@"contentOffset" context:nil];
    if (newSuperview) {
        [newSuperview addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (!self.userInteractionEnabled || self.alpha <= 0.01 || self.hidden) return;
    id newChange = [change objectForKey:NSKeyValueChangeNewKey];
    if ([newChange isKindOfClass:[NSValue class]]) {
        CGPoint point = [newChange CGPointValue];
        if (point.y <= -55.0 && !self.isRefreshIng) {
            [self startSyncRefreshing];
        }else if (point.y < 0 && !self.isRefreshIng) {
            self.titleLabel.text = lang(@"prepare sync data");
            [self.activityView startAnimating];
        }
    }
}

- (void)endSyncDataRefresh
{
    __block UIScrollView * scrollerView = (UIScrollView *)self.superview;
    __weak typeof(self) weakSelf = self;
    if (scrollerView.contentInset.top >= 50) {
        [UIView animateWithDuration:0.25 delay:0.0
                            options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
             UIEdgeInsets inset = scrollerView.contentInset;
             inset.top = 0;
             scrollerView.contentInset = inset;
             CGPoint offset = scrollerView.contentOffset;
             offset.y  = 0;
             scrollerView.contentOffset = offset;
         } completion:^(BOOL finished) {
             __strong typeof(self) strongSelf = weakSelf;
             strongSelf.isRefreshIng = NO;
             strongSelf.titleLabel.text = @"";
             [strongSelf.activityView stopAnimating];
         }];
    }
}

- (void)startSyncRefreshing
{
    self.isRefreshIng = YES;
    __block UIScrollView * scrollerView = (UIScrollView *)self.superview;
    __weak typeof(self) weakSelf = self;
    if (scrollerView.contentInset.top == 0) {
        [UIView animateWithDuration:0.25 delay:0.0
                            options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
             UIEdgeInsets inset = scrollerView.contentInset;
             inset.top = 50;
             scrollerView.contentInset = inset;
             CGPoint offset = scrollerView.contentOffset;
             offset.y = -50;
             scrollerView.contentOffset = offset;
         } completion:^(BOOL finished) {
             __strong typeof(self) strongSelf = weakSelf;
             if (strongSelf.refreshingBlock) {
                 strongSelf.refreshingBlock();
             }
             strongSelf.titleLabel.text = lang(@"sync data...");
             [strongSelf.activityView startAnimating];
         }];
    }
}

@end

@implementation UIScrollView (Refresh)

+ (void)load
{
    Method method1 = class_getInstanceMethod([self class], NSSelectorFromString(@"dealloc"));
    Method method2 = class_getInstanceMethod([self class], @selector(deallocSwizzle));
    method_exchangeImplementations(method1, method2);
}

- (void)deallocSwizzle
{
    self.header = nil;
}

static char RefreshHeaderKey;
- (void)setHeader:(RefreshHeader *)header
{
    if (header != self.header) {
        [self.header removeFromSuperview];
        
        [self willChangeValueForKey:@"header"];
        objc_setAssociatedObject(self, &RefreshHeaderKey,
                                 header,
                                 OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"header"];
        [self addSubview:header];
        [header mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self.mas_width);
            make.top.equalTo(@(-50));
            make.height.equalTo(@50);
        }];
    }
}

- (RefreshHeader *)header
{
    return objc_getAssociatedObject(self, &RefreshHeaderKey);
}

- (void)addHeaderRefresh
{
    RefreshHeader * header = [[RefreshHeader alloc]init];
    self.header = header;
}

- (void)syncDataRefreshingBlock:(void (^)(void))block
{
    self.header.refreshingBlock = block;
}

- (void)endSyncDataRefresh
{
    [self.header endSyncDataRefresh];
}

- (void)startSyncRefreshing
{
    [self.header startSyncRefreshing];
}

- (void)syncTitleLableStr:(NSString *)str
{
    self.header.titleLabel.text = str;
}

@end
