//
//  IDOVFLoadDataBaseManager.h
//  IDOVFHome
//
//  Created by 农大浒 on 2021/1/19.
//

#import <Foundation/Foundation.h>

#define K_MAX_COUNT 3

#define K_GET_STOP_STATE(userId) ([[IDOSaveTempManager shareInstance] getStopStateUserId:userId])

#define K_SAVE_STOP_STATE(stop,uId) ([[IDOSaveTempManager shareInstance] saveStop:stop userId:uId])

NS_ASSUME_NONNULL_BEGIN


typedef NS_OPTIONS(NSUInteger, IDOHomeLoadResultType) {
    IDOHomeLoadResultTypeFail             = 0, //加载数据失败
    IDOHomeLoadResultTypeSuccess          = 1, //加载数据成功
};



@class IDOVFLoadDataBaseManager;

@protocol IDOVFLoadDataBaseManagerDelegate <NSObject>

@optional

/**
 下载返回数据
 
 @param loadTime 加载数据的时间，格式为yyyy-MM-dd/yyyy-MM-dd
 @param result 结果为成功还是失败
 @param obj 数据，返回的是对应类型的模型数组
 
 */
- (void)didFinishDownLoadWithStartTime:(NSString *)loadTime result:(BOOL)result obj:(id)obj userId:(NSString *)userId  manager:(IDOVFLoadDataBaseManager *)manager;

/**
 加载最新一次的数据的代理
 */
- (void)didFinishDownLoadLastOneDataWithManager:(IDOVFLoadDataBaseManager *)manager result:(BOOL)result obj:(id)obj userId:(NSString *)userId;


@end

@interface IDOVFLoadDataBaseManager : NSObject

/**
 代理
 */
@property (nonatomic, weak) id delegate;


/**
 是否已经退出
 */
@property (nonatomic, assign) BOOL isExit;

/**
 加载一个时间段内的压力数据,需要子类实现
 @param startTime 开始时间
 @param endTime 结束时间
 */
- (void)loadDatasWithStartTime:(NSString *)startTime endTime:(NSString *)endTime userId:(NSString *)userId block:(void(^)(BOOL result, id obj,NSString *loadTime))block;


/**
 加载一个时间段内的压力数据,需要子类实现,新街口，这个方法直接加载的数主账号的数据
 */
- (void)loadDatasBlock:(void(^)(BOOL result, id obj))block;

/**
 加载数据，这个是使用delegate的方式回调,需要子类实现,新接口
 */
- (void)loadDatasWithUserId:(NSString *)userId block:(void(^)(BOOL result, id obj))block;


/**
 加载最新的一条数据,需要子类实现,这个方法直接加载的数主账号的数据
 */
- (void)loadLastDataBlock:(void(^)(BOOL result, id obj))block;

/**
 根据指定的userId加载最新一次的数据
 */
- (void)loadLastDataWithUserId:(NSString *)userId block:(void(^)(BOOL result, id obj))block;

- (void)loadLastDataWithUserId:(NSString *)userId;

/**
 把未同步的数据，同步到服务器；需要子类实现
 */
- (void)updateDatasToServerWithDatas:(NSArray *)datas block:(void (^)(BOOL result, id obj))block;


/**
 加载数据，这个是使用delegate的方式回调,需要子类实现
 */
- (void)loadDatasWithStartTime:(NSString *)startTime endTime:(NSString *)endTime userId:(NSString *)userId;

/**
 加载数据，这个是使用delegate的方式回调,需要子类实现,新接口，这个方法直接加载的数主账号的数据
 */
- (void)loadDatas;

/**
 加载数据，这个是使用delegate的方式回调,需要子类实现,新接口
 */
- (void)loadDatasWithUserId:(NSString *)userId;


@end

NS_ASSUME_NONNULL_END
