//
//  IDODataMigrationManager.h
//  IDOBluetooth
//
//  Created by 何东阳 on 2018/12/7.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDODataMigrationManager : NSObject

/**
 是否需要数据迁移,只有需要迁移才会有下面迁移的启动和回调,
 新的项目不需要执行数据迁移,注意的问题数据迁移是在异步操作,
 ⚠️在数据量大时比较耗时,尽量在执行完数据迁移再去执行其他工作.
 */
+ (BOOL)isNeedMigration;

/**
 迁移完数据库后，历史数据库存放目录路径 文件分别:Andriod_ios_local.db、Andriod_ios_cloud.db、jkdb.sqlite
 */
+ (NSString *)getHistoryDirePath;

/**
 启动数据迁移,传入迁移的数据是否来自云端,迁移完数据后会删除废弃目录及废弃的文件,旧的数据库将存放新的文件夹目录中
 */
+ (void)dataMigrationStart:(BOOL)isCloud;

/**
 数据迁移进度 (0-1)
 */
+ (void)dataMigrationProgressBlock:(void(^)(float progress))callback;

/**
 数据迁移完成 direNames 传入不能删除的目录名字集合，在Documents中其他的目录会在迁移完数据全部删除，
 ⚠️如果不传入目录集合，除了sdk新创建的目录不删除之外其他都会删除，所以根据开发需求自行传入目录名字集合
 */
+ (void)dataMigrationWithFileNames:(NSArray *)names
                     completeBlock:(void(^)(BOOL isSuccess))callback;


/**
 启动数据库转换json文件 ⚠️ 在数据量大时比较耗时,尽量在执行完数据迁移再去执行其他工作.
 1、若传入json文件路径存在,先把json文件数据同步到数据库中，然后合并的数据库再转成json文件
 2、若传入json文件路径为空,只把本地数据库转成json文件,并返回json文件目录路径
 3、jsonDirePath 是从云端下载的健康json文件目录路径，
 */
+ (void)dataToJsonFileStart:(NSString *)jsonDirePath;

/**
 数据转换json文件进度 (0-1)
 */
+ (void)dataToJsonFileProgressBlock:(void(^)(float progress))callback;

/**
 数据转换json文件完成
 newDirePath 本地数据库转换json文件目录路径
 */
+ (void)dataToJsonFileCompleteBlock:(void(^)(BOOL isSuccess,NSString * newDirePath))callback;

@end
