//
//  IDOSportIconModel.h
//  IDOBlueProtocol
//
//  Created by hedongyang on 2021/8/24.
//  Copyright © 2021 何东阳. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IDOSportIconModel : NSObject
//图片本地地址
@property (nonatomic,copy) NSString * filePath;
//图标类型 1:单张小运动图片 2:单张大运动图片 3:多运动动画图片 4:单张中运动图片
@property (nonatomic,assign) NSInteger iconType;
//运动类型
@property (nonatomic,assign) NSInteger sportType;
//图标个数 
@property (nonatomic,assign) NSInteger iconNum;

@end

NS_ASSUME_NONNULL_END
