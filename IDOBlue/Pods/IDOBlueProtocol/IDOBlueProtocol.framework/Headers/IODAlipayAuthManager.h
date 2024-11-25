//
//  IODAlipayAuth Manager.h
//  IDOBlueProtocol
//
//  Created by cyf on 2024/11/12.
//  Copyright © 2024 何东阳. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IODAlipayAuthManager : NSObject

@property (nonatomic, copy) void(^receivedDataCallback)(NSData *data);

+ (instancetype)shareInstance;


/// 发送alipay auth 认证数据
/// - Parameters:
///   - data: 认证发送的指令
///   - callback: 固件返回数据
- (void)sendData:(NSData* _Nullable)data;

- (void)receivedData:(NSData* _Nullable)data;

@end

NS_ASSUME_NONNULL_END
