//
//  IDONetworkManager.h
//  IDOFoundation
//
//  Created by jianglincen on 2021/7/26.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

#import "IDONetworkingConst.h"
#import "IDOCenter.h"
#import "IDORequest.h"
#import "IDOEngine.h"

NS_ASSUME_NONNULL_BEGIN

@protocol IDONetworkManagerDelegate <NSObject>


@optional

///可变公共参数
-(NSString*)mutebleCommonUrlSuffix;


/// 如果当前返回了YES,则文件写入全部正常请求和响应
-(BOOL)requestFileLogAllRequestWithResponse;

@end

@interface IDONetworkManager : NSObject

@property(nonatomic,weak) id <IDONetworkManagerDelegate>delegate;

@property (nonatomic,assign) BOOL fileLogAllRequestWithResponse;

#pragma mark - 单例方法

+(IDONetworkManager *)sharedManager;

#pragma mark - GET/POST请求方法
/// post请求
/// @param idoRequest idoRequest
/// @param successBLock successBLock
/// @param failBLock failBLock
+(void)post:(IDORequest*)idoRequest success:(XMSuccessBlock)successBLock fail:(XMFailureBlock)failBLock;

/// get请求
/// @param idoRequest idoRequest
/// @param successBLock successBLock
/// @param failBLock failBLock
+(void)get:(IDORequest*)idoRequest success:(XMSuccessBlock)successBLock fail:(XMFailureBlock)failBLock;


/// normal请求,自行设置idoRequest的get或者post属性
/// @param idoRequest idoRequest
/// @param successBLock successBLock
/// @param failBLock failBLock
+(void)req:(IDORequest*)idoRequest success:(XMSuccessBlock)successBLock fail:(XMFailureBlock)failBLock;



///  postRequestUrl请求
///  @param url url路径
///  @param header 请求投
///  @param body 请求体字典
/// @param successBLock 成功block
/// @param failBLock 失败block


+(void)postRequestUrl:(NSString*)url
                  header:(NSDictionary*)header
                  body:(NSDictionary*)body
              success:(XMSuccessBlock)successBLock fail:(XMFailureBlock)failBLock;


+(void)postRequestUrl:(NSString*)url
                  header:(NSDictionary*)header
                  body:(NSDictionary*)body
                requestSerializerType:(XMRequestSerializerType)requestSerializerType
              success:(XMSuccessBlock)successBLock fail:(XMFailureBlock)failBLock;


//  postRequestUrl请求
///  @param url url路径
///  @param header 请求投
///  @param body 请求体字典
///  @param timeout 超时时间，0就是使用默认超时时间
///  @param retryCount 重试次数，默认0次
///  @param retryCount 重试次数，默认0次
///  @param retryCount 重试次数，默认0次

/// @param successBLock 成功block
/// @param failBLock 失败block

+(void)postRequestUrl:(NSString*)url
                  header:(NSDictionary*)header
                  body:(NSDictionary*)body
                 timeout:(NSTimeInterval)timeout
                 retryCount:(NSInteger)retryCount
                 requestSerializerType:(XMRequestSerializerType)requestSerializerType
                 responseSerializerType:(XMResponseSerializerType)responseSerializerType
                 success:(XMSuccessBlock)successBLock fail:(XMFailureBlock)failBLock;




/// getRequestUrl请求
/// @param url 路径
/// @param header 请求投
/// @param body 请求体字典
/// @param successBLock 成功block
/// @param failBLock 失败block
+(void)getRequestUrl:(NSString*)url
                 header:(NSDictionary*)header
                 body:(NSDictionary*)body
             success:(XMSuccessBlock)successBLock fail:(XMFailureBlock)failBLock;


+(void)getRequestUrl:(NSString*)url
                 header:(NSDictionary*)header
                 body:(NSDictionary*)body
                    requestSerializerType:(XMRequestSerializerType)requestSerializerType
             success:(XMSuccessBlock)successBLock fail:(XMFailureBlock)failBLock;

+(void)getRequestUrl:(NSString*)url
                 header:(NSDictionary*)header
                 body:(NSDictionary*)body
                timeout:(NSTimeInterval)timeout
              retryCount:(NSInteger)retryCount
            requestSerializerType:(XMRequestSerializerType)requestSerializerType
            responseSerializerType:(XMResponseSerializerType)responseSerializerType

             success:(XMSuccessBlock)successBLock fail:(XMFailureBlock)failBLock;



#pragma mark - 上传/下载
/// 上传图片请求
/// @param image 本地图片
/// @param domain 域名
/// @param api 接口api
/// @param header 请求投
/// @param body 请求体字典
/// @param timeout 超时时间，0就是使用默认超时时间
/// @param successBLock 成功block
/// @param failBLock 失败block
+(void)uploadImage:(UIImage*)image domain:(NSString*)domain
               api:(NSString*)api
               header:(NSDictionary*)header
               body:(NSDictionary*)body
               timeout:(NSTimeInterval)timeout
               success:(XMSuccessBlock)successBLock fail:(XMFailureBlock)failBLock;

#pragma mark - other Method

+(void)cancelRequest:(IDORequest*)request;

/// 网络是否可用
+(BOOL)isNetworkReachable;


/// 网络连接状态返回
-(AFNetworkReachabilityStatus)netStatus;


/// 返回对应json里面的网络请求状态是否200，200为YES
/// @param responceDic NSDictionary.class
+(BOOL)isStatusCodeSuccess:(NSDictionary*)responceDic;


/// 返回对应json里面的网络请求状态
/// @param responceDic NSDictionary.class
+(NSInteger)statusCode:(NSDictionary*)responceDic;


#pragma mark - 公共参数相关
/// 全局配置网络请求公共信息
/// @param commonDomain 域名 domain NSString.class
/// @param commonHeader 请求头 SDictionary.class
/// @param commonBody 请求体 NSDictionary.class
/// @param commonUrlSuffix 请求url后面的公共参数 NSString.class
/// @param useGeneralEncryption 是否使用加密 BOOL 默认否
//+(void)configCommonDomain:(NSString*)commonDomain
//           commonHeader:(NSDictionary*)commonHeader
//           commonbody:(NSDictionary*)commonBody
//           commonUrlSuffix:(NSString*)commonUrlSuffix
//           useGeneralEncryption:(BOOL)useGeneralEncryption;


/// 抛出错误码
/// @param status 后台给的状态码
+(void)throwErrorStatusCodeToBusinessLayer:(NSInteger)status;


@end

NS_ASSUME_NONNULL_END
