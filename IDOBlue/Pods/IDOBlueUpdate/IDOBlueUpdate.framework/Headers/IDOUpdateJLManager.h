//
//  IDOUpdateJLManager.h
//  IDOBlueUpdate
//
//  Created by hedongyang on 2024/4/22.
//  Copyright © 2024 何东阳. All rights reserved.
//

#import <Foundation/Foundation.h>
#

NS_ASSUME_NONNULL_BEGIN

@interface IDOUpdateJLManager : NSObject

/**
 根据参数组成新图片预览
  model ：布局参数
   error：错误信息
 */
+ (nonnull UIImage *)jlCompose:(IDOJLDialModel *)model
                     errorInfo:(NSError **)error;

/**
 根据参数生成新的bin的表盘数据
 model ：布局参数
  error：错误信息
 */
+ (nullable NSData *)jlDialBinFromParameter:(IDOJLDialModel *)model
                                  errorInfo:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
