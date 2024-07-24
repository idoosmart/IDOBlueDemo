//
//  IDOVFBaseNewModel.h
//  AFNetworking
//
//  Created by 农大浒 on 2021/10/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void ( ^XMSuccessBlock)(id _Nullable responseObject);
typedef void (^XMFailureBlock)(NSError * _Nullable error);
@interface IDOVFNewBaseNetModel : NSObject

/**
 请求头
 */
@property (nonatomic, copy) NSDictionary *header;

/**
 主的hrl
 */
@property (nonatomic, copy) NSString *mainUrl;

/**
 子的hrl
 */
@property (nonatomic, copy) NSString *subUrl;

/**
 参数
 */
@property (nonatomic, strong) NSDictionary *param;

+ (IDOVFNewBaseNetModel *)getDefaultModel:(NSString *)token;

+ (IDOVFNewBaseNetModel *)getUploadNetModelWithDatas:(NSArray *)datas adminToken:(NSString *)adminToken;

+ (IDOVFNewBaseNetModel *)getSyncModelWithReadToken:(NSString *)readToken;

+ (IDOVFNewBaseNetModel *)getSyncModelWithReadToken:(NSString *)readToken start:(NSString *)start end:(NSString *)end;

+ (void)postWithModel:(IDOVFNewBaseNetModel *)model success:(XMSuccessBlock)successBLock fail:(XMFailureBlock)failBLock;

+ (void)postFormatWithModel:(IDOVFNewBaseNetModel *)model success:(XMSuccessBlock)successBLock fail:(XMFailureBlock)failBLock;

+ (BOOL)isSucessWithRep:(NSDictionary *)responseObject;

@end

NS_ASSUME_NONNULL_END
