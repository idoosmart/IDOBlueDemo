//
//  IDOMusicInfoModel.h
//  IDOBlueProtocol
//
//  Created by hedongyang on 2021/9/13.
//  Copyright © 2021 何东阳. All rights reserved.
//

#import <IDOBlueProtocol/IDOBluetoothBaseModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface IDOMusicFileModel : IDOBluetoothBaseModel
/**
 音乐id
 */
@property (nonatomic,assign) NSInteger musicId;
/**
 音乐占用的空间 单位 字节
 */
@property (nonatomic,assign) NSInteger musicMemory;
/**
 音乐名称
 */
@property (nonatomic,copy) NSString * musicName;
/**
 歌手名
 */
@property (nonatomic,copy) NSString * singerName;

@end

@interface IDOMusicDirectoryModel : IDOBluetoothBaseModel
/**
歌单ID 1-10
 */
@property (nonatomic,assign) NSInteger folderId;
/**
 歌单名
 */
@property (nonatomic,copy) NSString * folderName;
/**
 歌单中的歌曲数量
 */
@property (nonatomic,assign) NSInteger musicNum;
/**
 歌单中对应歌曲的id，按照添加的先后顺序，依次排列
 */
@property (nonatomic,copy) NSArray<NSNumber *> * musicIdArray;

@end

@interface IDOMusicInfoModel : IDOBluetoothBaseModel
/**
 当前使用的空间 单位 字节
 */
@property (nonatomic,assign) NSInteger usedMemory;
/**
 总的空间
 */
@property (nonatomic,assign) NSInteger allMemory;
/**
 可用的空间
 */
@property (nonatomic,assign) NSInteger usefulMemory;
/**
 文件夹数量
 */
@property (nonatomic,assign) NSInteger folderNum;
/**
 音乐数量
 */
@property (nonatomic,assign) NSInteger musicNum;
/**
 歌单 集合
 */
@property (nonatomic,copy) NSArray<IDOMusicDirectoryModel *> * folderItems;
/**
 歌曲 集合
 */
@property (nonatomic,copy) NSArray<IDOMusicFileModel *> * musicItems;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOMusicInfoModel
 */
+ (IDOMusicInfoModel *)currentModel;

@end

@interface IDOMusicFileTransferModel : IDOMusicFileModel
//音乐沙盒地址
@property (nonatomic,copy) NSString * filePath;
//音乐名称 xxx.mp3 添加音乐文件和传输文件名称要保持一致
@property (nonatomic,copy) NSString * fileName;

@end

NS_ASSUME_NONNULL_END
