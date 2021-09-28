//
//  IDOMusicFileManager.h
//  IDOBlueProtocol
//
//  Created by hedongyang on 2021/9/13.
//  Copyright © 2021 何东阳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IDOBlueProtocol/IDOMusicInfoModel.h>

NS_ASSUME_NONNULL_BEGIN

@protocol IDOMusicFileManagerDelegate <NSObject>
//操作音乐回调状态
- (void)operatMusicFileReplyErrorCode:(int)errorCode;
//获取音乐信息回调数据
- (void)getMusicFileInfoReplyModel:(IDOMusicInfoModel *)model
                         errorCode:(int)errorCode;
//传输进度 0-1
- (void)musicFileTransferProgress:(float)progress;

//传输完成 非0为错误
- (void)musicFileTransferComplete:(int)errorCode;

@end

@interface IDOMusicFileManager : NSObject
//音乐操作代理对象
@property (nonatomic,weak)id<IDOMusicFileManagerDelegate> delegate;
//音乐集合
@property (nonatomic,strong) NSArray <IDOMusicFileTransferModel *>* models;
//单例对象初始化
+ (instancetype)shareInstance;
//添加音乐文件
+ (BOOL)addMusicFiles:(NSArray <IDOMusicFileModel *>*)modes;
//删除音乐文件
+ (BOOL)deleteMusicFiles:(NSArray <IDOMusicFileModel *>*)modes;
//添加音乐关联文件夹
+ (BOOL)addMusicFolders:(NSArray <IDOMusicDirectoryModel *>*)modes;
//删除音乐关联文件夹
+ (BOOL)deleteMusicFolders:(NSArray <IDOMusicDirectoryModel *>*)modes;
//获取音乐信息
+ (BOOL)getMusicInfo;
//开始传输
- (BOOL)startTransfer;

@end

NS_ASSUME_NONNULL_END
