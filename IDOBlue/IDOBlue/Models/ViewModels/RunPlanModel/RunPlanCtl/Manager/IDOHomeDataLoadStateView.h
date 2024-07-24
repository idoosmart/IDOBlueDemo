//
//  IDOHomeDataLoadStateView.h
//  AFNetworking
//
//  Created by 农大浒 on 2021/11/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IDOHomeDataLoadStateView : UIView

@property (nonatomic, copy) void (^clickRestartBlock) (void);

- (void)loading:(BOOL)loading;

@end

NS_ASSUME_NONNULL_END
