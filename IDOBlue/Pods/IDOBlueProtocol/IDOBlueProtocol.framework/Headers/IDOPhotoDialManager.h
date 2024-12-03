//
//  IDOPhotoDialManager.h
//  IDOBlueProtocol
//
//  Created by cyf on 2024/11/8.
//  Copyright © 2024 何东阳. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IDOPhotoDialManager : NSObject



/// 解压表盘zip压缩包,读取照片表盘zip压缩包中的app.json数据 ｜ Unzip the watch face zip package and read the app.json data in the photo watch face zip package
/// - Parameters:
///   - filePath: 表盘zip压缩包路径 ｜ Dial zip package path
///   - fileName: 表盘zip压缩包文件名 ｜ Dial zip file name
///   - callback: 返回 IDOWallpaperCloudLibModel｜ call back IDOWallpaperCloudLibModel
+ (void)readAppJsonFileWithDialPackageZipFilePath:(NSString *)filePath
                              fileName:(NSString *)fileName
                              callback:(void(^_Nullable)(IDOWallpaperCloudLibModel *_Nullable wallpaperCloudModel))callback;


/// 制作照片表盘和安装表盘 ｜ Make photo dial and install dial
/// - Parameters:
///   - wallpaperCloudModel: wallpaperCloudModel
///   - bgImage: 背景图 ｜ background image
///   - previewSetImage: 预览图 ｜ preview Image
///   - firmwareName: 制作的表盘包目录名称,跟表盘zip压缩包文件名一致 ｜ The name of the dial package directory must be the same as the name of the dial zip package
///   - zipName: 表盘zip压缩包文件名 ｜ Dial zip file name
///   - callback: 返回 表盘安装状态：IDOWallpaperWCInstallFaceLog, 制作的表盘包路径：wallpaperZipPath， 安装进度：progress   ｜ callback description   Dial dial install state: IDOWallpaperWCInstallFaceLog, Make the dial package path: wallpaperZipPath, Dial installation progress: progress
+ (void)makeAndInstallTheDialWtith:(IDOWallpaperCloudLibModel *)wallpaperCloudModel
                           bgImage:(UIImage *)bgImage
                   previewSetImage:(UIImage *)previewSetImage
                      firmwareName:(NSString *)firmwareName
                           zipName:(NSString *)zipName
                          callback:(void (^)(IDOWallpaperWCInstallFaceLog status, NSString* wallpaperZipPath,int progress))callback;

@end
NS_ASSUME_NONNULL_END
