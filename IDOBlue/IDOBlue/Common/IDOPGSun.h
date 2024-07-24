//
//  IDOPGSun.h
//  
//  根据经纬度计算日出日落的时间
//  Created by xiongjie on 2021/10/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface IDOPGSun : NSObject

- (NSDictionary *) sun:(double) longitude withLat:(double) latitude;

@end

NS_ASSUME_NONNULL_END
