//
//  IDOPhotoDialManager.m
//  IDOBlueProtocol
//
//  Created by cyf on 2024/11/8.
//  Copyright © 2024 何东阳. All rights reserved.
//

#import "PhotoDialManager.h"

@interface PhotoDialManager()


@end

@implementation PhotoDialManager

- (instancetype)init{
    self = [super init];
    if(self){
    }
    return self;
}

///读取app.json文件
+ (void)readAppJsonFileWithDialPackageZipFilePath:(NSString *)filePath
                              fileName:(NSString *)fileName
                              callback:(void(^_Nullable)(WallpaperCloudLibModel *_Nullable wallpaperCloudModel))callback{
    [WallpaperFileLibManager creatCloudDialFolder];
    WallpaperFileLibManager*dialManager = [[WallpaperFileLibManager alloc] initWithFirmwareName:fileName];
    NSString *destination = dialManager.dialRootPath;
    
    NSString*unzipPath = [WallpaperFileLibManager dialZipRootPath:fileName];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:unzipPath]) {
        
        WallpaperCloudLibModel* wallpaperCloudModel = [WallpaperFileLibManager readAppJsonFile:[WallpaperFileLibManager dialZipRootPath:fileName] firmwareName:fileName];
        if(callback){
            callback(wallpaperCloudModel);
        }
    }else{
       
        [dialManager unzipFileAtPath:filePath destination:destination shouldUpdateUnzip:YES callback:^(DialZipStausType status, CGFloat progress, NSInteger errorCode, NSInteger finishTime) {
            if (status == DialZipStaus_UnZipSucc) {
                WallpaperCloudLibModel* wallpaperCloudModel = [WallpaperFileLibManager readAppJsonFile:[WallpaperFileLibManager dialZipRootPath:fileName] firmwareName:fileName];

                if(callback){
                    callback(wallpaperCloudModel);
                }
            }else if(status == DialZipStaus_UnZipFailure){
            
                if(callback){
                    callback(nil);
                }
            }
        }];
    }

}

+ (void)makeAndInstallTheDialWtith:(WallpaperCloudLibManager *)wallpaperCloudLibManager
                           bgImage:(UIImage *)bgImage
                   previewSetImage:(UIImage *)previewSetImage
                      firmwareName:(NSString *)firmwareName
                           zipName:(NSString *)zipName
                          callback:(void (^)(WallpaperWCInstallFaceLog status, NSString* wallpaperZipPath,int progress))callback{
    if(!wallpaperCloudLibManager){
        if(callback){
            callback(WallpaperWCInstallFaceLogUpgradeFail,nil,0);
        }
        NSLog(@"The wallpaperCloudLibManager parameter is nil");
        return;
    }
       
    if(![wallpaperCloudLibManager isKindOfClass:[WallpaperCloudLibManager class]]){
        if(callback){
            callback(WallpaperWCInstallFaceLogUpgradeFail,nil,0);
        }
        NSLog(@"Object wallpaperCloudLibManager not IDOWallpaperCloudLibManager this class instance");
        return;
    }
    [wallpaperCloudLibManager unZipFirmwareWithReplaceBgImage:bgImage withPreviewSetImage:previewSetImage withFirmwareName:firmwareName withZipName:zipName callback:^(WallpaperWCInstallFaceLog status, NSString * _Nonnull wallpaperZipPath, int progress) {
        if(callback){
            callback(status,wallpaperZipPath,progress);
        }
    }];
    
}
@end

