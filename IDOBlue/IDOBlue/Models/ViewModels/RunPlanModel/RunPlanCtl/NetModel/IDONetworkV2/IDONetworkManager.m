//
//  IDONetworkManager.m
//  IDOFoundation
//
//  Created by jianglincen on 2021/7/26.
//

#import "IDONetworkManager.h"
#import <objc/message.h>
#import <objc/runtime.h>

@interface IDONetworkManager()

@end

@implementation IDONetworkManager

+(IDONetworkManager *)sharedManager{
    
    static IDONetworkManager *sharedManager = nil;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate,^{
        sharedManager = [[self alloc] init];
        
        [IDONetworkManager  configDebugLog:YES];

        
    });
    return sharedManager;
}


#pragma mark - GET/Post请求

+(void)post:(IDORequest*)idoRequest success:(XMSuccessBlock)successBLock fail:(XMFailureBlock)failBLock{
    
    idoRequest.httpMethod = kXMHTTPMethodPOST;
    
    [self req:idoRequest success:successBLock fail:failBLock];
}

+(void)get:(IDORequest*)idoRequest success:(XMSuccessBlock)successBLock fail:(XMFailureBlock)failBLock{
    
    idoRequest.httpMethod = kXMHTTPMethodGET;
    
    [self req:idoRequest success:successBLock fail:failBLock];
    

}

+(void)req:(IDORequest*)idoRequest success:(XMSuccessBlock)successBLock fail:(XMFailureBlock)failBLock{
    
    __weak typeof(self) weakSelf = self;
    
    __block XMSuccessBlock _successBLock = successBLock;
    __block XMFailureBlock _failBLock = failBLock;

    [IDOCenter sendRequest:^(IDORequest * _Nonnull request) {
            
       request.server = idoRequest.server;
       request.api = idoRequest.api;
        
        if (idoRequest.url.length>0) {
            request.url = idoRequest.url;
        }
        
       request.httpMethod = kXMHTTPMethodGET;
       request.timeoutInterval = idoRequest.timeoutInterval;
       request.retryCount = idoRequest.retryCount;
       
       request.useGeneralEncryption = idoRequest.useGeneralEncryption;
        
    }onSuccess:^(id  _Nullable responseObject) {
        
        if (_successBLock) {
            _successBLock(responseObject);
            _successBLock =nil;
        }
        
        if (responseObject&&[responseObject isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary * dic = (NSDictionary*)responseObject;
            NSInteger status = [dic[@"status"]intValue];
            
            if (status!=200) {
                NSLog(@"requestError:requestUrl=%@,\n responseString=%@",[NSString stringWithFormat:@"%@/%@",idoRequest.server,idoRequest.api],responseObject);

            }
        }
        
    }onFailure:^(NSError * _Nullable error) {
                
        [weakSelf logServerError:error urlStr:[NSString stringWithFormat:@"%@/%@",idoRequest.server,idoRequest.api]];
        
        if (_failBLock) {
            _failBLock(error);
            _failBLock =nil;

        }
    }onFinished:nil];
}

///  postRequestUrl请求
///  @param url url路径
///  @param header 请求投
///  @param body 请求体字典
/// @param successBLock 成功block
/// @param failBLock 失败block


+(void)postRequestUrl:(NSString*)url
                  header:(NSDictionary*)header
                  body:(NSDictionary*)body
              success:(XMSuccessBlock)successBLock fail:(XMFailureBlock)failBLock{
    
    [self requestUrl:url header:header body:body method:kXMHTTPMethodPOST timeout:0 retryCount:0 requestSerializerType:kXMRequestSerializerJSON
        responseSerializerType:kXMResponseSerializerJSON
                success:successBLock fail:failBLock];
}


+(void)postRequestUrl:(NSString*)url
                  header:(NSDictionary*)header
                  body:(NSDictionary*)body
                requestSerializerType:(XMRequestSerializerType)requestSerializerType
              success:(XMSuccessBlock)successBLock fail:(XMFailureBlock)failBLock{
    
    [self requestUrl:url header:header body:body method:kXMHTTPMethodPOST timeout:0 retryCount:0 requestSerializerType:requestSerializerType
        responseSerializerType:kXMResponseSerializerJSON
                success:successBLock fail:failBLock];
}

///  postRequestUrl请求
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

              success:(XMSuccessBlock)successBLock fail:(XMFailureBlock)failBLock{
    
    [self requestUrl:url header:header body:body method:kXMHTTPMethodPOST timeout:timeout retryCount:retryCount requestSerializerType:requestSerializerType
        responseSerializerType:responseSerializerType
                success:successBLock fail:failBLock];
    
}

/// getRequestUrl请求
/// @param url 路径
/// @param header 请求投
/// @param body 请求体字典
/// @param successBLock 成功block
/// @param failBLock 失败block
+(void)getRequestUrl:(NSString*)url
                 header:(NSDictionary*)header
                 body:(NSDictionary*)body
                 success:(XMSuccessBlock)successBLock fail:(XMFailureBlock)failBLock{
    
    [self requestUrl:url header:header body:body method:kXMHTTPMethodGET timeout:0 retryCount:0  requestSerializerType:kXMRequestSerializerJSON
        responseSerializerType:kXMResponseSerializerJSON
                success:successBLock fail:failBLock];
}

+(void)getRequestUrl:(NSString*)url
                 header:(NSDictionary*)header
                 body:(NSDictionary*)body
                    requestSerializerType:(XMRequestSerializerType)requestSerializerType
                 success:(XMSuccessBlock)successBLock fail:(XMFailureBlock)failBLock{
    
    [self requestUrl:url header:header body:body method:kXMHTTPMethodGET timeout:0 retryCount:0  requestSerializerType:requestSerializerType
        responseSerializerType:kXMResponseSerializerJSON
                success:successBLock fail:failBLock];
}



/// getRequestUrl请求
/// @param url 路径
/// @param header 请求投
/// @param body 请求体字典
/// @param timeout 超时时间，0就是使用默认超时时间
/// @param retryCount 重试次数，默认0次
 /// @param retryCount 重试次数，默认0次

/// @param successBLock 成功block
/// @param failBLock 失败block
+(void)getRequestUrl:(NSString*)url
                 header:(NSDictionary*)header
                 body:(NSDictionary*)body
                timeout:(NSTimeInterval)timeout
              retryCount:(NSInteger)retryCount
            requestSerializerType:(XMRequestSerializerType)requestSerializerType
            responseSerializerType:(XMResponseSerializerType)responseSerializerType
              success:(XMSuccessBlock)successBLock fail:(XMFailureBlock)failBLock{
    
    [self requestUrl:url header:header body:body method:kXMHTTPMethodGET timeout:timeout retryCount:retryCount  requestSerializerType:requestSerializerType
        responseSerializerType:responseSerializerType
                success:successBLock fail:failBLock];
    
}

#pragma mark - 请求基类方法

+(void)requestUrl:(NSString*)url
                 header:(NSDictionary*)header
                 body:(NSDictionary*)body
                method:(XMHTTPMethodType)method
                timeout:(NSTimeInterval)timeout
                retryCount:(NSInteger)retryCount
    requestSerializerType:(XMRequestSerializerType)requestSerializerType
    responseSerializerType:(XMResponseSerializerType)responseSerializerType
              success:(XMSuccessBlock)successBLock fail:(XMFailureBlock)failBLock{
    
    __weak typeof(self) weakSelf = self;
    
    __block XMSuccessBlock _successBLock = successBLock;
    __block XMFailureBlock _failBLock = failBLock;

    [IDOCenter sendRequest:^(IDORequest * _Nonnull request) {
            
        if (url) {
            request.url = url;
        }
        
        request.httpMethod = method;
        
        if (timeout>0) {
            request.timeoutInterval = timeout;
        }
        
        request.requestSerializerType = requestSerializerType;
        request.responseSerializerType = responseSerializerType;
        request.headers = header;
        request.parameters = body;

                       
    }onSuccess:^(id  _Nullable responseObject) {
        
        if (_successBLock) {
            _successBLock(responseObject);
            _successBLock =nil;
        }
        
        if (responseObject&&[responseObject isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary * dic = (NSDictionary*)responseObject;
            NSString * statusString = dic[@"status"];
            
            NSInteger status = [statusString intValue];
            
            if (status != 200) {
                NSLog(@"requestError:requestUrl=%@,\n, responseString=%@",[NSString stringWithFormat:@"%@",url],responseObject);
                if (status!=200) {
                    [self throwErrorStatusCodeToBusinessLayer:status];
                }
            }
        }
        
    }onFailure:^(NSError * _Nullable error) {
        
        [weakSelf logServerError:error urlStr:url];

        if (_failBLock) {
            _failBLock(error);
            _failBLock =nil;

        }
    }onFinished:nil];
}


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
           success:(XMSuccessBlock)successBLock process:(XMProgressBlock)processBlock fail:(XMFailureBlock)failBLock{
    
    __weak typeof(self) weakSelf = self;
    
    __block XMSuccessBlock _successBLock = successBLock;
    __block XMFailureBlock _failBLock = failBLock;
    __block XMProgressBlock _processBlock = processBlock;

    NSData *fileData1 = UIImageJPEGRepresentation(image, 1.0);
    // `NSURL` form data.
 //   NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Documents/testImage.png"];
 //   NSURL *fileURL2 = [NSURL fileURLWithPath:path isDirectory:NO];

    [IDOCenter sendRequest:^(IDORequest *request) {
        request.server = domain;
        request.api = api;
        request.requestType = kXMRequestUpload;
        [request addFormDataWithName:@"image[]" fileName:@"temp.jpg" mimeType:@"image/jpeg" fileData:fileData1];
     //   [request addFormDataWithName:@"image[]" fileURL:fileURL2];
        // see `XMUploadFormData` for more details.
    } onProgress:^(NSProgress *progress) {
        // the progress block is running on the session queue.
        if (progress) {
            NSLog(@"onProgress: %f", progress.fractionCompleted);
            
            if (_processBlock) {
                _processBlock(progress);
                _processBlock =nil;
            }
            
        }
    } onSuccess:^(id responseObject) {
       
        if (_successBLock) {
            _successBLock(responseObject);
            _successBLock =nil;
        }
        
    } onFailure:^(NSError *error) {
       
        [weakSelf logServerError:error urlStr:api];

        if (_failBLock) {
            _failBLock(error);
            _failBLock =nil;

        }
        
    } onFinished:nil];
    
}

/// 下载文件请求
/// @param url 下载路径
/// @param header 请求投
/// @param body 请求体字典
/// @param timeout 超时时间，0就是使用默认超时时间
/// @param successBLock 成功block
/// @param failBLock 失败block
+(void)downloadFileUrl:(NSString*)url
               header:(NSDictionary*)header
               body:(NSDictionary*)body
               timeout:(NSTimeInterval)timeout
              downloadPath:(NSString*)downloadPath
           success:(XMSuccessBlock)successBLock process:(XMProgressBlock)processBlock fail:(XMFailureBlock)failBLock{
    
    __weak typeof(self) weakSelf = self;
    
    __block XMSuccessBlock _successBLock = successBLock;
    __block XMFailureBlock _failBLock = failBLock;
    __block XMProgressBlock _processBlock = processBlock;

    [IDOCenter sendRequest:^(IDORequest *request) {
        request.url = url;
//        request.downloadSavePath = [NSHomeDirectory() stringByAppendingString:@"/Documents/"];
        request.downloadSavePath = downloadPath;

        request.requestType = kXMRequestDownload;
        
    } onProgress:^(NSProgress *progress) {
        // the progress block is running on the session queue.
        if (progress) {
        
            NSLog(@"onProgress: %f", progress.fractionCompleted);
            
            if (_processBlock) {
                _processBlock(progress);
                _processBlock =nil;
            }
        }
        
    } onSuccess:^(id responseObject) {
      
        if (_successBLock) {
            _successBLock(responseObject);
            _successBLock =nil;
        }
        
    } onFailure:^(NSError *error) {
       
        [weakSelf logServerError:error urlStr:url];

        if (_failBLock) {
            _failBLock(error);
            _failBLock =nil;

        }
        
    }];
    
}


#pragma mark - 取消网络请求
+(void)cancelRequest:(IDORequest*)request{
    
    [IDOCenter cancelRequest:request.identifier onCancel:^(id  _Nullable request) {
       
        
    }];
}

#pragma mark - 全局配置网络请求公共信息

/// 全局配置网络请求公共信息
/// @param commonDomain 域名 domain
/// @param commonHeader 请求头 SDictionary.class
/// @param commonBody 请求体 NSDictionary.class
+(void)configCommonDomain:(NSString*)commonDomain
           commonHeader:(NSDictionary*)commonHeader
               commonbody:(NSDictionary*)commonBody
          commonUrlSuffix:(NSString*)commonUrlSuffix
     useGeneralEncryption:(BOOL)useGeneralEncryption
     {
    
    [IDOCenter setupConfig:^(XMConfig * _Nonnull config) {
       
        if (commonDomain) {
            config.generalServer = commonDomain;
        }
        if (commonHeader) {
            config.generalHeaders = commonHeader;
        }
        if (commonBody) {
            config.generalParameters = commonBody;
        }
        
        if (commonUrlSuffix) {
            //避免有中文，导致网络请求失败
            config.commonUrlSuffix = [commonUrlSuffix stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];;

        }
        
        config.useGeneralEncryption = useGeneralEncryption;
        
        config.callbackQueue = dispatch_get_main_queue();
        
        #ifdef DEBUG
                config.consoleLog = YES;
        #endif
        
    }];
}


+(void)configDebugLog:(BOOL)isDebugLog{
    
    [IDOCenter setupConfig:^(XMConfig * _Nonnull config) {
               
        config.callbackQueue = dispatch_get_main_queue();
        
        #if defined(DEBUG) && DEBUG
        config.consoleLog = isDebugLog;
        #endif

       
    }];
    
}

#pragma mark - 记录错误数据
+(void)logServerError:(NSError*)error urlStr:(NSString*)urlStr{

    if (!error) {
        return;
    }
    
    NSDictionary *errorInfo = error.userInfo;

    /*
     Printing description of errorInfo:
     {
         NSErrorFailingURLKey = "http://127.0.0.1:8888/test";
         NSErrorFailingURLStringKey = "http://127.0.0.1:8888/test";
         NSLocalizedDescription = "Could not connect to the server.";
         NSUnderlyingError = "Error Domain=kCFErrorDomainCFNetwork Code=-1004 \"(null)\" UserInfo={_kCFStreamErrorCodeKey=61, _kCFStreamErrorDomainKey=1}";
         "_NSURLErrorFailingURLSessionTaskErrorKey" = "LocalDataTask <A8B3E1D5-5DB0-4FE6-BF8B-7E7601F756AE>.<1>";
         "_NSURLErrorRelatedURLSessionTaskErrorKey" =     (
             "LocalDataTask <A8B3E1D5-5DB0-4FE6-BF8B-7E7601F756AE>.<1>"
         );
         "_kCFStreamErrorCodeKey" = 61;
         "_kCFStreamErrorDomainKey" = 1;
     }
     */
    
    NSDictionary *errorDic = nil;
    
    if (errorInfo[@"com.alamofire.serialization.response.error.data"]) {
        
        NSData *data = errorInfo[@"com.alamofire.serialization.response.error.data"];

        if (data.length > 0) {
    
            errorDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
            NSString * failUrlStringKey = errorInfo[@"NSErrorFailingURLStringKey"];

    #if defined(DEBUG) ||defined(_DEBUG)

            NSLog(@"requestError:request.domain=%@\n,errorInfo=%@ \n message=%@",failUrlStringKey,errorDic,errorDic[@"message"]);
    #endif

            NSLog(@"requestError:urlStr=%@,request.domain=%@\n,errorInfo=%@ \n message=%@", urlStr,failUrlStringKey,errorDic,errorDic[@"message"]);

            
            NSInteger   status = [errorDic[@"status"]intValue];
            
            if (status!=200) {
            
                [self throwErrorStatusCodeToBusinessLayer:status];
              
                
            }
            
            
        }
        
        
        
        
    }
    
    else{
        
        NSString * failUrlStringKey = errorInfo[@"NSErrorFailingURLStringKey"];
        NSString * localizedDescription = errorInfo[@"NSLocalizedDescription"];
        NSString * unnderlyingError = errorInfo[@"NSUnderlyingError"];

        
#if defined(DEBUG) ||defined(_DEBUG)

        NSLog(@"requestError:request.domain=%@\n,localizedDescription=%@ \n message=%@",failUrlStringKey,localizedDescription,unnderlyingError);
#endif

        NSLog(@"requestError:request.domain=%@\n,localizedDescription=%@ \n message=%@",failUrlStringKey,localizedDescription,unnderlyingError);
        
    }
    
    
}


#pragma mark- 错误码抛出到app业务层，主要用于监听退出登录的错误码
/// 抛出错误码
/// @param status 后台给的状态码
+(void)throwErrorStatusCodeToBusinessLayer:(NSInteger)status{
    
    
    Class loginTool  = NSClassFromString(@"IDOCoreLoginTool");
    
    if (loginTool&&[loginTool respondsToSelector:@selector(tokenExpiredAndLogout:)]) {
        
        [loginTool performSelector:@selector(tokenExpiredAndLogout:) withObject:@(status)];
                            
    }
}

#pragma mark - 网络状态监听
/// 网络是否可用
+(BOOL)isNetworkReachable{
    
    return [IDOCenter isNetworkReachable];
    
}

-(AFNetworkReachabilityStatus)netStatus{
    
    return [[IDOEngine sharedEngine]reachabilityStatus];
}

#pragma mark - other method

/// 返回对应json里面的网络请求状态是否200，200为YES
/// @param responceDic NSDictionary.class
+(BOOL)isStatusCodeSuccess:(NSDictionary*)responceDic{
    
    if (responceDic&&[responceDic isKindOfClass:[NSDictionary class]]) {
        
        NSDictionary * dic = (NSDictionary*)responceDic;
        NSInteger status = [dic[@"status"]intValue];
        
        if (status!=200) {
            
            return NO;
        }
        else{
            return YES;
        }
    }
    
    return NO;
    
}


/// 返回对应json里面的网络请求状态码
/// @param responceDic NSDictionary.class
+(NSInteger)statusCode:(NSDictionary*)responceDic{
    
    if (responceDic&&[responceDic isKindOfClass:[NSDictionary class]]) {
        
        NSDictionary * dic = (NSDictionary*)responceDic;
        NSInteger status = [dic[@"status"]intValue];
        
        return status;
    }
    
    return 0;
    
}

@end
