//
//  IDOHomeDataLoadFailView.m
//  IDOVFHome
//
//  Created by 农大浒 on 2021/11/12.
//

#import "IDOHomeDataLoadFailView.h"
#import "Masonry.h"
#define COLOR(HEXSTR) [IDOUIHelp colorWithHexString:HEXSTR]
@interface IDOHomeDataLoadFailView ()
@property (nonatomic, strong) UILabel *decsLabel;
/**
 按钮
 */
@property (nonatomic, strong) UIButton *btn;

@end

@implementation IDOHomeDataLoadFailView

- (UIButton *)btn{
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_btn setTitle:@"重试" forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _btn.backgroundColor = [UIColor lightGrayColor];
        [_btn addTarget:self action:@selector(restart) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

- (UILabel *)decsLabel{
    if (!_decsLabel) {
        _decsLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _decsLabel.text = @"加载失败";
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
    
    [self addSubview:self.decsLabel];
    [self.decsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(0);
    }];
    
    CGFloat w = [self getLabelWidth:@"重试" height:36 font:[UIFont systemFontOfSize:14]] + 44;
    [self addSubview:self.btn];
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(self.decsLabel.mas_bottom).mas_equalTo(16);
        make.width.mas_equalTo(w);
    }];
    
    self.btn.layer.cornerRadius = 8;
    self.btn.layer.masksToBounds = YES;
    
    
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
- (void)restart{
    if (self.clickRestartBlock) {
        self.clickRestartBlock();
    }
}

@end
