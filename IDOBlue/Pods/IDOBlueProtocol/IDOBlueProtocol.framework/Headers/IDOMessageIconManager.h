//
//  IDOMessageIconManager.h
//  IDOBlueProtocol
//
//  Created by hedongyang on 2021/8/2.
//  Copyright © 2021 何东阳. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, IDO_GETTING_APPPACKNAME_TYPE) {
    /**
     * 获取包名结束
     * End of obtaining package name
     */
    IDO_GETTING_APPPACKNAME_END = 0,
    /**
     * 获取包名开始
     * Get Package Name Start
     */
    IDO_GETTING_APPPACKNAME_START,
};

@protocol IDOMessageIconManagerDelegate <NSObject>

@optional
/**
 处理应用图标和名字日志回调
 */
- (void)handleIconLogMessage:(NSString *)message;
/**
 处理完成应用图标和名字回调
 */
- (void)handleIconAndNameComplete;

/**
 处理获取包名回调
 */
- (void)handleGettingAppPackNameMessage:(IDO_GETTING_APPPACKNAME_TYPE)gettingAppPackNameType;

@end

@interface IDOMessageIconManager : NSObject

//代理对象
@property (nonatomic,weak) id<IDOMessageIconManagerDelegate> delegate;

//处理完成应用图标和名字block回调
@property (nonatomic,copy) void(^handleIconAndNameComplete)(void);

//base url 地址 如果未赋值则走Apple 接口
@property (nonatomic,copy) NSString * baseUrlPath;

//当前本地缓存的第三方应用信息，每次读取本地数据库
@property (nonatomic,strong) IDOGetAppPackNameModel * currentModel;

//是否在获取包名
@property (nonatomic,assign) BOOL isGettingAppPackName;

//初始化消息通知图标和名字更新
+ (instancetype)listenForUpdate;

//消息图标存储目录地址
+ (NSString *)iconPath;

//主动获取图标和名字
- (BOOL)getAppIconAndName;

//是否需要获取包名
- (BOOL)isNeetGetAppIconAndName;

//解绑后，sdk会主动清除获取的包名数据
-(void)unbindAfterCleanCacheAppName;

@end

NS_ASSUME_NONNULL_END
