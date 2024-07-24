//
//  IDOHomeDataLoadStateView.m
//  AFNetworking
//
//  Created by 农大浒 on 2021/11/12.
//

#import "IDOHomeDataLoadStateView.h"
#import "Masonry.h"
#import "IDOHomeDataLoadingStateView.h"
#import "IDOHomeDataLoadFailView.h"

@interface IDOHomeDataLoadStateView ()

/**
 <##>
 */
@property (nonatomic, strong) IDOHomeDataLoadingStateView *loadingView;

/**
 <##>
 */
@property (nonatomic, strong) IDOHomeDataLoadFailView *failView;

/**
 当前的状态
 */
@property (nonatomic, assign) BOOL loading;

@end

@implementation IDOHomeDataLoadStateView

- (IDOHomeDataLoadFailView *)failView{
    if (!_failView) {
        _failView = [[IDOHomeDataLoadFailView alloc] init];
    }
    return _failView;
}

- (IDOHomeDataLoadingStateView *)loadingView{
    if (!_loadingView) {
        _loadingView = [[IDOHomeDataLoadingStateView alloc] init];
    }
    return _loadingView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpDefault];
    }
    return self;
}

- (instancetype)init{
    if (self = [super init]) {
        [self setUpDefault];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder{
    if (self = [super initWithCoder:coder]) {
        [self setUpDefault];
    }
    return self;
}

- (void)setUpDefault{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillEnterForeground) name:UIApplicationWillEnterForegroundNotification object:nil];
    
    [self addSubview:self.loadingView];
    CGFloat w = [self getLabelWidth:@"加载中" height:20 font:[UIFont systemFontOfSize:14]];
    [self.loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.width.mas_equalTo(w + 35);
        make.height.mas_equalTo(20);
    }];
    self.loadingView.hidden = YES;
    
    
    [self addSubview:self.failView];
    CGFloat failW = [self getLabelWidth:@"重试" height:36 font:[UIFont systemFontOfSize:14]] + 44;
    CGFloat decsW = [self getLabelWidth:@"加载失败" height:20 font:[UIFont systemFontOfSize:14]];
    CGFloat max = MAX(failW, decsW);
    [self.failView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.width.mas_equalTo(max);
        make.height.mas_equalTo(75);
    }];
    self.failView.hidden = YES;
    
    __weak typeof(self) weakSelf = self;
    self.failView.clickRestartBlock = ^{
        weakSelf.loading = YES;
        [weakSelf.loadingView startAnimation:YES];
        weakSelf.failView.hidden = YES;
        weakSelf.loadingView.hidden = NO;
        if (weakSelf.clickRestartBlock) {
            weakSelf.clickRestartBlock();
        }
    };
}
- (CGFloat)getLabelWidth:(NSString*)text
                  height:(CGFloat)height
                    font:(UIFont*)font
{
    if(!text || text.length == 0)return 0;
    CGRect tempRect=[text boundingRectWithSize:CGSizeMake(MAXFLOAT,height)
                                       options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                    attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]
                                       context:nil];
    return  tempRect.size.width;
}

- (void)loading:(BOOL)loading{
    self.loading = loading;
    [self.loadingView startAnimation:loading];
    
    self.failView.hidden = loading;
    self.loadingView.hidden = !loading;
}

- (void)applicationWillEnterForeground{
    [self.loadingView startAnimation:self.loading];
    self.failView.hidden = self.loading;
    self.loadingView.hidden = !self.loading;
}

@end
