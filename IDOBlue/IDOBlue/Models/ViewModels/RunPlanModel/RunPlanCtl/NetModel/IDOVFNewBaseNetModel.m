//
//  IDOVFBaseNewModel.m
//  AFNetworking
//
//  Created by 农大浒 on 2021/10/14.
//

#import "IDOVFNewBaseNetModel.h"
#import "IDONetworkManager.h"
@implementation IDOVFNewBaseNetModel

+ (IDOVFNewBaseNetModel *)getDefaultModel:(NSString *)token{
    IDOVFNewBaseNetModel *model = [[IDOVFNewBaseNetModel alloc] init];
    model.mainUrl = @"https://cn-health.idoocloud.com";
    NSMutableDictionary *he = [NSMutableDictionary dictionary];
    NSString *keystring = @"9ee5f0aed15e4641818c098376b82241";
    [he setValue:token forKey:@"Authorization"];
    [he setValue:keystring forKey:@"appKey"];
    model.header = he;
    return model;
}

+ (IDOVFNewBaseNetModel *)getUploadNetModelWithDatas:(NSArray *)datas adminToken:(NSString *)adminToken{
    IDOVFNewBaseNetModel *model = (IDOVFNewBaseNetModel *)[self getDefaultModel:adminToken];
    //表示存在有admintoken,表示为子账号上传数据
    if (adminToken.length > 10) {
        NSMutableDictionary *he = [NSMutableDictionary dictionaryWithDictionary:model.header];
        [he setValue:adminToken forKey:@"A-Authorization"];
        model.header = he;
    }
    return model;
}

+ (IDOVFNewBaseNetModel *)getSyncModelWithReadToken:(NSString *)readToken{
    return [self getSyncModelWithReadToken:readToken start:@"" end:@""];
}

+ (IDOVFNewBaseNetModel *)getSyncModelWithReadToken:(NSString *)readToken start:(NSString *)start end:(NSString *)end{
    IDOVFNewBaseNetModel *model = (IDOVFNewBaseNetModel *)[self getDefaultModel:readToken];
    //表示存在有admintoken,表示为子账号上传数据
    if (readToken.length > 10) {
        NSMutableDictionary *he = [NSMutableDictionary dictionaryWithDictionary:model.header];
        [he setValue:readToken forKey:@"R-Authorization"];
        model.header = he;
    }
    if (start.length > 0 && end.length > 0) {
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setValue:start forKey:@"start"];
        [param setValue:end forKey:@"end"];
        model.param = param;
    }
    return model;
}

+ (void)postWithModel:(IDOVFNewBaseNetModel *)model success:(XMSuccessBlock)successBLock fail:(XMFailureBlock)failBLock{
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",model.mainUrl,model.subUrl];
    
    //记录开始请求的日志
    NSLog(@"==========新接口============  network satart =================== \n url:%@  \n:header:%@ \n",url,model.header);
    [IDONetworkManager postRequestUrl:url header:model.header body:model.param success:^(id  _Nullable responseObject) {
        if (successBLock) {
            successBLock(responseObject);
        }
        
        //存储网络请求成功的日志
        id results = responseObject[@"result"];
        NSString *successMsg = @"";
        if ([results isKindOfClass:[NSArray class]]) {
            NSArray *arr = (NSArray *)results;
            successMsg = [NSString stringWithFormat:@"url:%@成功返回数据:%lu 个",url,(unsigned long)arr.count];
        }else{
            successMsg = [NSString stringWithFormat:@"数据加载成功:%@",responseObject];
        }

        NSString *errorStr = [NSString stringWithFormat:@"success网络请求成功:%@，返回结果:%@\n\n",url,successMsg];

        NSLog(@"===========新接口===========  network success ===================\n%@\n", errorStr);
        
    } fail:^(NSError * _Nullable error) {
        if (failBLock) {
            failBLock(error);
        }
        
        //存储网络请求失败的日志
        NSDictionary *errorInfo = error.userInfo;

        NSDictionary *dataDic = nil;
        NSString *message = @"";
        if (errorInfo[@"com.alamofire.serialization.response.error.data"]) {
            NSData *data = errorInfo[@"com.alamofire.serialization.response.error.data"];

            if (data.length > 0) {
                dataDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];

                if (dataDic[@"message"]) {
                    message = dataDic[@"message"];
                    NSLog(@"message:%@",message);
                }

                NSLog(@"dataDic:%@",dataDic);
            }
        }

        NSString *errorStr = [NSString stringWithFormat:@"fail网络请求失败:%@,失败原因:%@,具体的原因:%@ ----  %@  ---  %@ \n\n",url,error.localizedDescription,errorInfo,dataDic,message];
        
        NSLog(@"=========新接口=============  network fail ===================\n%@\n",errorStr);
        
    }];
}

+ (void)postFormatWithModel:(IDOVFNewBaseNetModel *)model success:(XMSuccessBlock)successBLock fail:(XMFailureBlock)failBLock{
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",model.mainUrl,model.subUrl];

    //记录开始请求的日志
    NSLog(@"==========新接口============  network satart =================== \n url:%@  \n:header:%@ \n",url,model.header);
    [IDONetworkManager postRequestUrl:url header:model.header body:model.param requestSerializerType:kXMRequestSerializerRAW success:^(id  _Nullable responseObject) {
        if (successBLock) {
            successBLock(responseObject);
        }
        
        //存储网络请求成功的日志
        id results = responseObject[@"result"];
        NSString *successMsg = @"";
        if ([results isKindOfClass:[NSArray class]]) {
            NSArray *arr = (NSArray *)results;
            successMsg = [NSString stringWithFormat:@"url:%@成功返回数据:%lu 个",url,(unsigned long)arr.count];
        }else{
            successMsg = [NSString stringWithFormat:@"数据加载成功:%@",responseObject];
        }

        NSString *errorStr = [NSString stringWithFormat:@"success网络请求成功:%@，返回结果:%@\n\n",url,successMsg];

        NSLog(@"===========新接口===========  network success ===================\n%@\n", errorStr);
    } fail:^(NSError * _Nullable error) {
        if (failBLock) {
            failBLock(error);
        }
        
        //存储网络请求失败的日志
        NSDictionary *errorInfo = error.userInfo;

        NSDictionary *dataDic = nil;
        NSString *message = @"";
        if (errorInfo[@"com.alamofire.serialization.response.error.data"]) {
            NSData *data = errorInfo[@"com.alamofire.serialization.response.error.data"];

            if (data.length > 0) {
                dataDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];

                if (dataDic[@"message"]) {
                    message = dataDic[@"message"];
                    NSLog(@"message:%@",message);
                }

                NSLog(@"dataDic:%@",dataDic);
            }
        }

        NSString *errorStr = [NSString stringWithFormat:@"fail网络请求失败:%@,失败原因:%@,具体的原因:%@ ----  %@  ---  %@ \n\n",url,error.localizedDescription,errorInfo,dataDic,message];
        
        NSLog(@"=========新接口=============  network fail ===================\n%@\n",errorStr);
    }];
}

+ (BOOL)isSucessWithRep:(NSDictionary *)responseObject{
    NSInteger state = [responseObject[@"status"] integerValue];
    return state == 200;
}

@end
