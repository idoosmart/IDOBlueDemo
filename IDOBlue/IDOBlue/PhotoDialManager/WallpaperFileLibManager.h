//
//  IDOWallpaperFileLibManager.h
//  IDOBlueProtocol
//
//  Created by chenhuili on 2024/1/22.
//  Copyright © 2024 何东阳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WallpaperCloudLibModel.h"

typedef NS_ENUM(NSUInteger, DialZipStausType) {
    DialZipStaus_ZipIsExist,      //Zip已经存在
    DialZipStaus_DownLoading,     //下载Zip中
    DialZipStaus_DownLoadSucc,    //下载Zip成功
    DialZipStaus_DownLoadFailure, //下载Zip失败
    DialZipStaus_ZipNoExist,      //Zip包不存在

    DialZipStaus_UnZipIsExist,    //解压包已经存在
    DialZipStaus_UnZiping,        //解压Zip中
    DialZipStaus_UnZipSucc,       //解压Zip成功
    DialZipStaus_UnZipFailure,    //解压Zip失败
    DialZipStaus_UnZipNoExist,    //解压包不存在
};

typedef void (^InstallDialZipBlock)(DialZipStausType status, CGFloat progress, NSInteger errorCode, NSInteger finishTime);

NS_ASSUME_NONNULL_BEGIN
@class WallpaperCloudLibModel;
@interface WallpaperFileLibManager : UIView

///表盘包存储的根路径
@property(nonatomic, readonly, strong) NSString *dialRootPath;

///表盘包的固件名
@property(nonatomic, readonly, strong) NSString *firmwareName;

- (instancetype)initWithFirmwareName:(NSString *)firmwareName;

///表盘包下载解压后的根目录
+ (NSString *)dialZipRootPath:(NSString*)firmwareName;

+ (NSString *)documentPath;

///表盘包的根目录
+ (NSString *)dialRootPath;

+ (void)creatCloudDialFolder;

/// 壁纸图片路径
+ (NSString *)wallpaperDialFilePath;

+ (UIViewController *)getIDOCurrentVC;

/// 删除一个目录/文件
/// @param path 目录名/文件名
/// @param cachesOrDocument caches or document
+ (BOOL)removeItemAtPath:(NSString *)path inCaches:(BOOL)cachesOrDocument;

/**
 保存本地图片
 
 @param image 图片image
 @param folderName 文件夹名
 @param fileName 文件名
 */
+ (void)setLocalImageWithImage:(UIImage *)image
                folderName:(NSString *)folderName
                  fileName:(NSString *)fileName;

/**
 * 解压表盘压缩包
 * @param zipPath 表盘Zip包
 * @param destination 表盘Zip包解压后存储的路径
 * @param shouldUpdateUnzip Zip包存在的情况下 更新表盘包
 * @param callback 回调结果
 */
- (void)unzipFileAtPath:(NSString *)zipPath
            destination:(NSString *)destination
      shouldUpdateUnzip:(BOOL)shouldUpdateUnzip
               callback:(InstallDialZipBlock)callback;

///读取app.json文件
+ (nullable WallpaperCloudLibModel *)readAppJsonFile:(NSString *)rootPath
                                  firmwareName:(NSString *)firmwareName;

@end

NS_ASSUME_NONNULL_END

