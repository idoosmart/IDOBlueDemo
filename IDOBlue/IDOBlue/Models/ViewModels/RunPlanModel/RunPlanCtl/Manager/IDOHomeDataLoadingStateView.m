//
//  IDOHomeDataLoadingStateView.m
//  IDOVFHome
//
//  Created by 农大浒 on 2021/11/12.
//

#import "IDOHomeDataLoadingStateView.h"
#import "Masonry.h"
@interface IDOHomeDataLoadingStateView ()

/**
 加载图标
 */
@property (nonatomic, strong) UIImageView *loadImageView;
@property (nonatomic, strong) UILabel *decsLabel;

@end

@implementation IDOHomeDataLoadingStateView

- (UIImageView *)loadImageView{
    if (!_loadImageView) {
        _loadImageView = [[UIImageView alloc] init];
        _loadImageView.image = [UIImage imageNamed:@"home_detail_loading"];
    }
    return _loadImageView;
}

- (UILabel *)decsLabel{
    if (!_decsLabel) {
        _decsLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _decsLabel.text = @"加载中";
        _decsLabel.textColor = [UIColor blackColor];
        _decsLabel.font = [UIFont systemFontOfSize:14];
        
    }
    return _decsLabel;
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
    
    [self addSubview:self.loadImageView];
    [self.loadImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.width.height.mas_equalTo(20);
    }];
    
    [self addSubview:self.decsLabel];
    [self.decsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(self.loadImageView.mas_right).mas_equalTo(10);
    }];
}

- (void)startAnimation:(BOOL)animation{
    if (self.loadImageView) {
        if (animation) {
            [self animation];
        }else{
            [self.loadImageView.layer removeAllAnimations];
        }
    }
}

- (void)animation{
    CABasicAnimation * rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI * 2.0];
    rotationAnimation.duration = 0.5;
    rotationAnimation.repeatCount = HUGE_VALF;
    [self.loadImageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

@end
