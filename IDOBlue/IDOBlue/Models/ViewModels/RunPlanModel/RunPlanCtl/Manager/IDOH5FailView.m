//
//  IDOH5FailView.m
//  IDOVFHome
//
//  Created by mac2019 on 2022/9/21.
//

#import "IDOH5FailView.h"
#import "IDOHomeDataLoadStateView.h"
#import "Masonry.h"

//获取导航栏、状态栏、tabbar的高度
#define kStatusHeight [[UIApplication sharedApplication] statusBarFrame].size.height
@interface IDOH5FailView ()

@property (nonatomic,strong) UIButton *closeBtn;

@property (nonatomic,strong) UILabel *decsLabel;

@property (nonatomic,strong) IDOHomeDataLoadStateView *loadStateView;

@end

@implementation IDOH5FailView

- (IDOHomeDataLoadStateView *)loadStateView{
    if (!_loadStateView) {
        _loadStateView = [[IDOHomeDataLoadStateView alloc] initWithFrame:CGRectZero];
        _loadStateView.backgroundColor = UIColor.whiteColor;
    }
    return _loadStateView;
}

- (UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn = [[UIButton alloc] init];
        [_closeBtn setImage:[UIImage imageNamed:@"device_nav_back"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.whiteColor;
        
        [self addSubview:self.loadStateView];
        [self.loadStateView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];

        [self.loadStateView loading:NO];
        
        [self addSubview:self.closeBtn];
        [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(16);
            make.top.mas_equalTo(kStatusHeight + 10);
            make.width.height.mas_equalTo(30);
        }];
        
        __weak typeof(self) weakSelf = self;
        self.loadStateView.clickRestartBlock = ^{
            if (weakSelf.clickRestartBlock) {
                weakSelf.clickRestartBlock();
            }
        };
    }
    return self;
}

- (void)clickBack{
    if (self.clickBackBlock) {
        self.clickBackBlock();
    }
}

- (void)loading:(BOOL)loading{
    [self.loadStateView loading:loading];
}

@end
