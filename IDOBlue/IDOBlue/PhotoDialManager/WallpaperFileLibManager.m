//
//  IDOWallpaperFileLibManager.m
//  IDOBlueProtocol
//
//  Created by huangkunhe on 2023/2/7.
//  Copyright © 2023 何东阳. All rights reserved.
//

#import "WallpaperFileLibManager.h"
#import "WallpaperCloudLibModel.h"
#import "NewDialJsonFuncLibModel.h"
#import "NewDialJsonSelectedLibModel.h"
#import "NewDialJsonSelectedLibModel.h"
#import "NewDialJsonStylesFuncsLibModel.h"
#import "NewDialJsonCountTimerLibModel.h"
#import "NewDialJsonBackgroundLibModel.h"
#import "NewDialJsonStylesListLibModel.h"
#import "NewDialJsonFuncListLibModel.h"
#import "YYModel.h"
#import "SSZipArchive.h"

@interface WallpaperFileLibManager()

///表盘包存储的根路径
@property(nonatomic, readwrite, strong) NSString *dialRootPath;

///表盘包的固件名
@property(nonatomic, readwrite, strong) NSString *firmwareName;
@end

@implementation WallpaperFileLibManager

- (instancetype)initWithFirmwareName:(NSString *)firmwareName{
    if (self = [super init]) {
        self.firmwareName = firmwareName;
        self.dialRootPath = [WallpaperFileLibManager dialRootPath];
    }
    return self;
}


///沙盒中是否正在表盘包
+ (BOOL)isExistDialFileInSandBox:(NSString *)firmwareName{
    NSString *dailPath = [self dialZipRootPath:firmwareName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:dailPath]) {
        return YES;
    }
    return NO;
}

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
             callback:(InstallDialZipBlock)callback{
    //解压后文件路径
    //NSString *zipPath = [self.dialRootPath stringByAppendingFormat:@"/%@.zip",self.firmwareName];
    //NSString *destination = [self.dialRootPath stringByAppendingFormat:@"/%@",self.firmwareName];
    
    if (!shouldUpdateUnzip && [[NSFileManager defaultManager] fileExistsAtPath:destination]) {
        if (callback) {
            callback(DialZipStaus_UnZipIsExist, 0, 0,0);
        }
        return;
    }
    
    [self unzipFileAtPath:zipPath
            toDestination:destination
         checkUnzipResult:YES
                 callback:callback];
}

/**
 * 解压表盘压缩包
 * @param zipDownloadPath 表盘Zip包
 * @param toPath 表盘Zip包解压后存储的路径
 * @param checkResult 解压后判断解压的结果，如果不存在对应的表盘包，重新解压到表盘包文件夹
 * @param callback 回调结果
 */
- (void)unzipFileAtPath:(NSString *)zipDownloadPath
          toDestination:(NSString *)toPath
       checkUnzipResult:(BOOL)checkResult
                    callback:(InstallDialZipBlock)callback{
    [SSZipArchive unzipFileAtPath:zipDownloadPath
                    toDestination:toPath
                  progressHandler:^(double progress) {
        if (callback) {
            callback(DialZipStaus_UnZiping,progress, 0,0);
        }
    } completionHandler:^(NSString * _Nonnull path, BOOL succeeded, NSError * _Nullable error) {
        NSLog(@"解压Zip包 succeeded:%@ error:%@", @(succeeded), error);

        if (callback) {
            if (succeeded) {
                //解压文件的兼容
                if (checkResult && ![WallpaperFileLibManager isExistDialFileInSandBox:self.firmwareName]) {
                    NSString *destination = [toPath stringByAppendingFormat:@"%@",self.firmwareName];
                    [self unzipFileAtPath:zipDownloadPath
                            toDestination:destination
                         checkUnzipResult:NO
                                 callback:callback];
                }else{
                    DialZipStausType st = succeeded ? DialZipStaus_UnZipSucc: DialZipStaus_UnZipFailure;
                    callback(st, 0, 0,0);
                }
            }
        }
    }];
}

+ (nullable WallpaperCloudLibModel *)readAppJsonFile:(NSString *)rootPath
                                  firmwareName:(NSString *)firmwareName{
    //需要读取的json文件地址
    NSString *jsonPath = [NSString stringWithFormat:@"%@/app.json", rootPath];
    
    NSString*jsonlog = [NSString stringWithFormat:@"readAppJsonFile: %@",jsonPath];
    NSLog(@"%@",jsonlog);
    
    NSError *error = nil;
    NSData  *jsonData = [NSData dataWithContentsOfFile:jsonPath options:NSDataReadingMappedIfSafe error:&error];
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    if (!error) {
        //数据解压成功
        WallpaperCloudLibModel *jsonObj = [WallpaperCloudLibModel yy_modelWithJSON:jsonStr];
        
        NSString *imagesPath = [NSString stringWithFormat:@"%@/images", rootPath];
        UIImage *previewPathImg = [UIImage imageWithContentsOfFile:[imagesPath stringByAppendingPathComponent:@"preview.png"]];
        UIImage *bgPathImg = [UIImage imageWithContentsOfFile:[imagesPath stringByAppendingPathComponent:@"bg.png"]];

        if (previewPathImg) {
            jsonObj.imagePreviewize = previewPathImg.size;
        }
        if (bgPathImg) {
            jsonObj.imageBgsize = bgPathImg.size;
        }
        
        
        //兼容表盘包配置时，忽略配置了 select.function 的信息
        if (jsonObj.funcInfo.defaultFuncs.count != jsonObj.select.function.count && jsonObj.funcInfo.defaultFuncs.count > 0) {
            NSMutableArray *list = [NSMutableArray array];
            [jsonObj.funcInfo.defaultFuncs enumerateObjectsUsingBlock:^(NewDialJsonStylesFuncsLibModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (obj.funcType.length > 0) {
                    [list addObject:obj.funcType];
                }
            }];
            jsonObj.select.function = list;
        }
        
        jsonObj.select.funcLocationType = jsonObj.select.timeFuncLocation;
        
        if (jsonObj.counterTimers.count > 0 && jsonObj.select.counterTimers.count != jsonObj.counterTimers.count) {
            NSMutableArray *list = [NSMutableArray array];
            [jsonObj.counterTimers enumerateObjectsUsingBlock:^(NewDialJsonCountTimerLibModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (obj.defaultIndex) {
                    [list addObject:@(obj.defaultIndex)];
                }
            }];
            jsonObj.select.counterTimers = list;
            NSLog(@"list: %@", list);

        }
        if (jsonObj.backgrounds.count > 0 && jsonObj.select.selectBG.length <= 0) {
            jsonObj.select.selectBG = jsonObj.backgrounds.firstObject.image;
        }
        if (jsonObj.styles.count > 0 && jsonObj.select.style.length <= 0) {
            jsonObj.select.style = jsonObj.styles.firstObject.name;
        }
        NSLog(@"jsonObj.counterTimers: %@", jsonObj.counterTimers);

        for (NewDialJsonCountTimerLibModel *model in jsonObj.counterTimers) {
            NSLog(@"timers: %@", model.timers);
        }
        return jsonObj;
    }else{
        NSLog(@"照片云表盘 读取json%@", error);
        return nil;
    }
    
    
}

+ (void)creatCloudDialFolder {
    NSString * docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString * filePath = [docDir stringByAppendingPathComponent:@"CloudDial"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = NO;
    BOOL existed = [fileManager fileExistsAtPath:filePath isDirectory:&isDir];
   
    if (!(isDir == YES && existed == YES)) {
        [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    filePath = [filePath stringByAppendingPathComponent:IDO_BLUE_ENGINE.peripheralEngine.deviceId];
    isDir = NO;
    existed = [fileManager fileExistsAtPath:filePath isDirectory:&isDir];
    if (!(isDir == YES && existed == YES)) {
        [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

+ (void)setLocalImageWithImage:(UIImage *)image
                    folderName:(NSString *)folderName
                      fileName:(NSString *)fileName {
    NSData * data = UIImagePNGRepresentation(image);
    NSString * folderPath = [[WallpaperFileLibManager documentPath] stringByAppendingPathComponent:folderName];
    NSError * error = nil;
    BOOL exist = [WallpaperFileLibManager createDirectoryWithPath:folderPath error:&error];
    if (exist) {
        NSString *imagePath = [folderPath stringByAppendingPathComponent:fileName];
        [data writeToFile:imagePath atomically:YES];
    }
}

+ (BOOL)removeItemAtPath:(NSString *)path
                inCaches:(BOOL)cachesOrDocument {
    //不能为空
    if (path.length == 0) {
        return NO;
    }
    BOOL isSucceed = YES;
    NSFileManager * fileManager = [[NSFileManager alloc] init];
    NSString * documentsPath = cachesOrDocument?[WallpaperFileLibManager cachesPath]:[WallpaperFileLibManager documentPath];
    NSString * filePath = [documentsPath stringByAppendingPathComponent:path];
    NSError * error = nil;
    if (![fileManager fileExistsAtPath:filePath]) {//判断是否存在
        isSucceed = NO;
        return isSucceed;
    }
    
    if (![fileManager removeItemAtPath:filePath error:&error]) {
        isSucceed = NO;
        NSLog(@"[Error] %@ (%@)", error, filePath);
    }
    return isSucceed;
}

+ (NSString *)cachesPath {
    return [self pathForDirectory:NSCachesDirectory];
}

/// 壁纸图片路径
+ (NSString *)wallpaperDialFilePath {
    NSString *dialPath = [NSString stringWithFormat:@"%@/%@.png",[WallpaperFileLibManager dialRootPath], __IDO_MAC_ADDR__];
    return dialPath;
}


///表盘包下载解压后的根目录
+ (NSString *)dialZipRootPath:(NSString*)firmwareName{
    NSString *path = [NSString stringWithFormat:@"%@%@",[self dialRootPath], firmwareName];
    return path;
    
}

///表盘包的根目录
+ (NSString *)dialRootPath{
    NSString *path = [NSString stringWithFormat:@"%@/CloudDial/%@/",[WallpaperFileLibManager documentPath],IDO_BLUE_ENGINE.peripheralEngine.deviceId];
    [WallpaperFileLibManager createDirectoryWithPath:path error:nil];
    return path;
}

+ (NSString *)pathForDirectory:(NSSearchPathDirectory)directory
{
    return NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES)[0];
}

+ (NSString *)documentPath {
    return [self pathForDirectory:NSDocumentDirectory];
}

+ (BOOL)createDirectoryWithPath:(NSString *)path
                          error:(NSError **)error {
    NSFileManager * fileManager = [NSFileManager defaultManager];
    BOOL isDir = NO;
    BOOL isDirExist = [fileManager fileExistsAtPath:path isDirectory:&isDir];
    if (isDirExist && isDir)return YES;
    
    NSURL * fileUrl = [NSURL URLWithString:path];
    NSArray * pathComponents = fileUrl.pathComponents;
    NSMutableArray <NSString *>* noExistArray = [NSMutableArray array];
    if (pathComponents.count == 0)return NO;
    
    for (NSInteger i = pathComponents.count - 1; i > 0; i --) {
        NSString * component = [pathComponents objectAtIndex:i];
        //修复不同层级的相同目录名称出现无法创建问题
        NSArray * otherComponents = [pathComponents subarrayWithRange:NSMakeRange(1,i-1)];
        NSString * otherPath = [otherComponents componentsJoinedByString:@"/"];
        otherPath = [@"/"stringByAppendingString:otherPath];
        NSString * filePath = [otherPath stringByAppendingPathComponent:component];
        BOOL isDir;
        BOOL exist = [fileManager fileExistsAtPath:filePath isDirectory:&isDir];
        if (exist) continue;
        if (!exist || !isDir) {
            [noExistArray addObject:filePath];
        }
    }
    if (noExistArray.count == 0) return YES;
    NSInteger index = noExistArray.count - 1;
    NSMutableArray * boolArray = [NSMutableArray array];
    for (NSInteger i = index; i >= 0; i--) {
        NSString * filePath = [noExistArray objectAtIndex:i];
        BOOL isSuccess = [fileManager createDirectoryAtPath:filePath
                               withIntermediateDirectories:YES
                                                attributes:nil
                                                     error:error];
        [boolArray addObject:@(isSuccess)];
    }
    for (int i = 0; i < boolArray.count; i++) {
        BOOL isSuccess = [[boolArray objectAtIndex:i] boolValue];
        if (!isSuccess) {
            return NO;
        }
    }
    return YES;
}


+ (UIViewController *)getIDOCurrentVC
{
    UIWindow * window = [UIApplication sharedApplication].delegate.window;
    UIViewController *rootViewController = window.rootViewController;
    UIViewController *currentVC = [self getIDOCurrentVCFrom:rootViewController];
    return currentVC;
}

+ (UIViewController *)getIDOCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    if ([rootVC presentedViewController]) {
        rootVC = [rootVC presentedViewController];
    }
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        currentVC = [self getIDOCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        currentVC = [self getIDOCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    } else {
        currentVC = rootVC;
    }
    return currentVC;
}

@end
