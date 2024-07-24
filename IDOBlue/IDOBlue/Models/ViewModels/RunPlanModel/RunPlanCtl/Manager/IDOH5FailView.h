//
//  IDOH5FailView.h
//  IDOVFHome
//
//  Created by mac2019 on 2022/9/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IDOH5FailView : UIView

@property (nonatomic, copy) void (^clickRestartBlock) (void);

@property (nonatomic, copy) void (^clickBackBlock) (void);

- (void)loading:(BOOL)loading;

@end

NS_ASSUME_NONNULL_END
