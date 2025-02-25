//
//  NewDialInstallLibModel.h
//  IDOBlue
//
//  Created by cyf on 2025/2/25.
//  Copyright © 2025 hedongyang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewDialInstallLibModel : NSObject

/// 表盘名字
@property(nonatomic, strong) NSString * dialName;

/// 表盘ID+

@property(nonatomic, strong) NSString * dialId;

/// 表盘固件名字
@property(nonatomic, strong) NSString * firmwareName;

/// 表盘图片的URL 路径
@property(nonatomic, strong) NSString * imageUrl;

/// 表盘包下载地址
@property(nonatomic, strong) NSString * linkUrl;

/// 表盘描述
@property(nonatomic, strong) NSString * dialInfo;

/// sid
@property(nonatomic, strong) NSString * sid;

/// 新增云表盘version
//@property(nonatomic ,strong) IDOVFWatchDialFaceVersion * otaFaceVersion;

#pragma mark - 表盘是否是收藏
///表盘是否是已收藏 2.0.0添加
@property(nonatomic, assign) BOOL collected;

//true表示上架，false表示下架 1.2.1版本添加
@property(nonatomic, assign) BOOL enabled;

//表盘类型
@property(nonatomic, copy) NSString *faceType;

/// 2.0.0添加 自定义常规类型 "CUSTOM_FUNCTION",:固定字段表示自定义功能类型  除自定义表盘外其他类型该字段为null
/// 2.1.8 CUSTOM_FIXED_PHOTO 照片固定表盘
@property(nonatomic, copy) NSString *customFaceType;

@end
NS_ASSUME_NONNULL_END
