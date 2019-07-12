

#import <Foundation/Foundation.h>

@interface IDOConsoleBoard : NSObject

/**
 日志展示控制
 */
@property (nonatomic,assign,readonly) BOOL isShow;

/**
 初始化单例 日志展示窗口
 */
+ (instancetype)borad;

/**
 展示日志
 */
- (void)show;

/**
 关闭日志
 */
- (void)close;

@end
