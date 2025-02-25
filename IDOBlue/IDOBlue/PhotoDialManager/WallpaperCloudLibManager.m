//
//  IDOWallpaperCloudLibManager.m
//  IDOBlueProtocol
//
//  Created by huangkunhe on 2023/2/7.
//  Copyright © 2023 何东阳. All rights reserved.
//

#import "WallpaperCloudLibManager.h"
#import "WallpaperFileLibManager.h"
#import "SSZipArchive.h"
#import "YYModel.h"
#import "UIImage+Add.h"
#import "UIColor+Add.h"
#import "WallpaperCloudLibModel.h"
#import "NewDialInstallLibModel.h"
#import "NewDialJsonFuncListItemLibModel.h"
#import "NewDialJsonFunctionListLibModel.h"
#import "NewDialJsonFunctionListItemLibModel.h"
#import "NewDialInstallLibModel.h"
#import "NewDialWallpaperLibModel.h"
#import "NewDialJsonSelectedLibModel.h"
#import "DialJsonTimeListLibModel.h"
#import "NewDialJsonFunctionCoordinateLibModel.h"
#import "NewDialJsonFunctionItemLibModel.h"
#import "NewDialJsonLocationLibModel.h"
#import "DialJsonTimeWidgetLibModel.h"
#import "NewDialJsonFuncListLibModel.h"
///是否支持 照片表盘 设置组件、位置
#define IDOkIsWidgetWallpaper          (__IDO_FUNCTABLE__.funcTable37Model.watchPhotoPositionMove )
#define WC_COLOR(HEXSTR) [UIColor colorObjWithHexString:HEXSTR]

@implementation WallpaperCloudLibManager

- (instancetype)init{
    self = [super init];
    if (self) {
        //默认值
        [WallpaperFileLibManager creatCloudDialFolder];
        
        self.timeSelectedColorIndex = 0;
        self.funcSelectedColorIndex = 0;
        //是否是修改壁纸表盘颜色值
        self.setWallpaperColor = YES;
        BOOL isRoundShape = [self isShapeRoundDevice];
        self.selectLocationIndex = isRoundShape ? 2 : 3;
        NSLog(@"默认位置值：%@", @(self.selectLocationIndex));
        
        //        if (self.installModel.dialId) {
        //            [self getWallpaperRecordNetList:self.installModel.dialId];
        //        }else{
        //            [self getWallpaperRecordNetList:@""];
        //
        //        }
        {
            IDOV3WallpaperDialInfoModel  *wallpaperModel = [IDOV3WallpaperDialInfoModel currentModel];
            if (wallpaperModel.location > 0 && wallpaperModel.location < 10) {
                self.selectLocationIndex = wallpaperModel.location;
            }
            NSLog(@"固件返回位置值：%@", @(wallpaperModel.location));
            if (wallpaperModel.widgetType > 0) {
                // 1:星期/日期 2:步数 3:距离 4:卡路里 5:心率 6:电量
                NSString *typeName = [NewDialJsonFuncListItemLibModel convertWidgetTypeToFuncListItem:wallpaperModel.widgetType];
                if (typeName.length > 0) {
                    self.funcSelectedTypes= @[typeName];
                }
            }else{
                self.funcSelectedTypes= @[[NewDialJsonFuncListItemLibModel convertWidgetTypeToFuncListItem:2]];
            }
            
            for (NSInteger i = 0; i < self.stringColorArray.count; i++) {
                NSString *obj = self.stringColorArray[i];
                
                //获取照片表盘 时间的颜色
                if (self.setWallpaperColor &&
                    wallpaperModel.timeColor.length > 0 &&
                    [obj isEqualToString:wallpaperModel.timeColor]) {
                    self.timeSelectedColorIndex = i;
                }
                
                //获取照片表盘 功能的颜色
                if ((IDOkIsWidgetWallpaper || _dialJsonObj.cloudWallpaper.function_support) &&
                    wallpaperModel.widgetIconColor.length > 0 &&
                    [obj isEqualToString:wallpaperModel.widgetIconColor]) {
                    self.funcSelectedColorIndex = i;
                }
            }
        }
        
        UIImage *img = [[UIImage alloc]initWithContentsOfFile:[WallpaperFileLibManager wallpaperDialFilePath]];
        self.selectImage = img;
    }
    return self;
}

///解压固件的压缩包
- (void)unZipFirmwareWithReplaceBgImage:(UIImage *)bgImage
                    withPreviewSetImage:(UIImage *)previewSetImage
                       withFirmwareName:(NSString *)firmwareName
                            withZipName:(NSString *)zipName
                               callback:(void (^)(WallpaperWCInstallFaceLog status, NSString* wallpaperZipPath,int progress))callback{
    NSLog(@"准备修改表盘的iwf.json文件，然后打包 %@", zipName);
    //zip 文件解压后的路径
    NSString *zipPath = [NSString stringWithFormat:@"%@/%@",[WallpaperFileLibManager dialZipRootPath:firmwareName], zipName];
    
    NSString*unzipLogTip = [NSString stringWithFormat:@"unZipFirmwareWithReplaceBgImage --> bgImage size:(w:%f h:%f) previewSetImage size:(w:%f h:%f), selectModel:%@ ",bgImage.size.width,bgImage.size.height,previewSetImage.size.width,previewSetImage.size.height,self.dialJsonObj.select.yy_modelToJSONObject];
    NSLog(@"%@",unzipLogTip);
    
    
    IDOWatchScreenInfoModel *modelScreen = [IDOWatchScreenInfoModel currentModel];
    if (modelScreen.width > 0 && modelScreen.height > 0) {
        NSString*logText  = @"";
        BOOL irregularImageBool = NO;
        if (bgImage.size.width != modelScreen.width || bgImage.size.height != modelScreen.height) {
            logText  = @"bgImage irregular imageSize";
            irregularImageBool = YES;
        }
        if (self.dialJsonObj.imageBgsize.width > 0 && self.dialJsonObj.imageBgsize.height > 0) {
            if (bgImage.size.width == self.dialJsonObj.imageBgsize.width && bgImage.size.height == self.dialJsonObj.imageBgsize.height) {
                logText  = @"bgImage regular imageBgSize ";
                irregularImageBool = NO;
            }else{
                logText  = @"bgImage irregular imageBgSize ";
                irregularImageBool = YES;
            }
        }
        
        
        if (previewSetImage.size.width != modelScreen.width || previewSetImage.size.height != modelScreen.height){
            logText  = @"previewSetImage irregular imageSize";
            irregularImageBool = YES;
        }
        if (self.dialJsonObj.imagePreviewize.width > 0 && self.dialJsonObj.imagePreviewize.height > 0) {
            if (previewSetImage.size.width == self.dialJsonObj.imagePreviewize.width && previewSetImage.size.height == self.dialJsonObj.imagePreviewize.height) {
                logText  = @"previewSetImage regular imageBgSize";
                irregularImageBool = NO;
            }else{
                logText  = @"previewSetImage irregular imageBgSize";
                irregularImageBool = YES;
            }
        }
        
        if (irregularImageBool) {
            if (callback) {
                callback(WallpaperWCInstallFaceLogUpgradeFail_IrregularImageSize, nil,0);
            }
            return;
        }
    }
    
    if (bgImage) {
        NSString *dialPath = [NSString stringWithFormat:@"/CloudDial/%@/%@/images", IDO_BLUE_ENGINE.peripheralEngine.deviceId, firmwareName];
        
        NSString *bgPath = [dialPath stringByAppendingPathComponent:@"bgSet.png"];
        [WallpaperFileLibManager removeItemAtPath:bgPath inCaches:NO];
        [WallpaperFileLibManager setLocalImageWithImage:bgImage folderName:dialPath fileName:@"bgSet.png"];
        
        UIImage *previewImage = previewSetImage;
        
        NSString *previewPath = [dialPath stringByAppendingPathComponent:@"previewSet.png"];
        
        UIImage *sandboxImg = [UIImage imageWithContentsOfFile:[[WallpaperFileLibManager documentPath] stringByAppendingPathComponent:previewPath]];
        if (sandboxImg) {
            NSString*logSandboxText  = @"";
            CGSize sandboxImgSize = sandboxImg.size;
            if (modelScreen.width > 0 && modelScreen.height > 0) {
                if (sandboxImg.size.width != modelScreen.width || sandboxImg.size.height != modelScreen.height) {
                    sandboxImgSize = CGSizeMake(modelScreen.width, modelScreen.height);
                    logSandboxText  = @"sandboxImgSize irregular";
                }
                if (self.dialJsonObj.imageBgsize.width > 0 && self.dialJsonObj.imageBgsize.height > 0) {
                    if (sandboxImg.size.width != self.dialJsonObj.imageBgsize.width || sandboxImg.size.height != self.dialJsonObj.imageBgsize.height) {
                        sandboxImgSize = CGSizeMake(self.dialJsonObj.imageBgsize.width, self.dialJsonObj.imageBgsize.height);
                        logSandboxText  = @"sandboxImgSize irregular imageBgSize";
                    }
                }
                
            }
            
            NSString*logSandboxTip = [NSString stringWithFormat:@"unZipFirmwareWithReplaceBgImage --> %@ sandboxImgSize:(w:%f h:%f) ",logSandboxText,sandboxImgSize.width,sandboxImgSize.height];
            NSLog(@"%@",logSandboxTip);
            
            //根据沙盒中生成的图片大小，缩小当前图片，不缩小 会导致208的设备，卡顿
            previewImage = [self scaleImage:previewImage size:sandboxImgSize];
        }
        
        [WallpaperFileLibManager setLocalImageWithImage:previewImage folderName:dialPath fileName:@"previewSet.png"];
    }
        
    if ([[NSFileManager defaultManager] fileExistsAtPath:zipPath]) {
        [self chageWatchJsonWithFirmwareName:firmwareName withZipName:zipName callback:callback];
        
    }else{
        //第一次解压
        __weak typeof(self) weakSelf = self;
        NSString *destination = [NSString stringWithFormat:@"%@/",[WallpaperFileLibManager dialZipRootPath:firmwareName]];
        NSLog(@"destination = %@", destination);
        NSString *unzipPath = [NSString stringWithFormat:@"%@.zip",zipPath];
        [SSZipArchive unzipFileAtPath:unzipPath toDestination:destination progressHandler:^(double progress) {
            
        } completionHandler:^(NSString * _Nonnull path, BOOL succeeded, NSError * _Nullable error) {
            if (succeeded) {
                //解压成功 需要兼容解压的结果
                NSString *targetPath = [destination stringByAppendingPathComponent:zipName];
                NSLog(@"targetPath = %@", destination);
                if (![[NSFileManager defaultManager] fileExistsAtPath:targetPath]) {
                    [SSZipArchive unzipFileAtPath:unzipPath toDestination:targetPath progressHandler:nil completionHandler:^(NSString * _Nonnull path, BOOL succeeded, NSError * _Nullable error) {
                        NSLog(@"兼容解压完成");
                        if (succeeded) {
                            [self chageWatchJsonWithFirmwareName:firmwareName withZipName:zipName callback:callback];

                        }else{
                            NSLog(@"照片云表盘 兼容解压失败需要传给表盘的zip包 :%@", [error description]);
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"installdialFail" object:nil];
                        }
                    }];
                }else{
                    [self chageWatchJsonWithFirmwareName:firmwareName withZipName:zipName callback:callback];
                    
                }
                
            }else{
                NSLog(@"照片云表盘 解压失败需要传给表盘的zip包 :%@", [error description]);
                [[NSNotificationCenter defaultCenter] postNotificationName:@"installdialFail" object:nil];
            }
        }];
    }
}

//替换需要传输的表盘资源中的json文件
- (void)chageWatchJsonWithFirmwareName:(NSString *)firmwareName
                           withZipName:(NSString *)zipName
                              callback:(void (^)(WallpaperWCInstallFaceLog status, NSString* wallpaperZipPath, int progress))callback{
    //先读取表盘资源文件json
    
    NSString *jsonPath =[NSString stringWithFormat:@"%@/%@/iwf.json",[WallpaperFileLibManager dialZipRootPath:firmwareName], zipName];
    
    
    NSError *error = nil;
    NSData  *jsonData = [NSData dataWithContentsOfFile:jsonPath options:NSDataReadingMappedIfSafe error:&error];
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    if (!error) {
        //数据解压成功
        NSMutableDictionary *iwfDict = [NSMutableDictionary dictionaryWithDictionary:[self stringToDictionary:jsonStr]];
        
        //        //固件放置快捷键的数组
        NSMutableArray *itemArray = [NSMutableArray arrayWithArray:[iwfDict valueForKey:@"item"]];
        NSMutableArray *saveArray = [NSMutableArray arrayWithArray:[iwfDict valueForKey:@"item"]];
        NewDialJsonSelectedLibModel *selectedObj = self.dialJsonObj.select;
        
        NSArray *selectedFuncs = selectedObj.function;
        //写入选择的功能 iwf.Json文件
        
        NSInteger changeAppIndex = -1;
        NSInteger changeContentIndex = -1;
        
        
        CGRect widgetTime  = CGRectNull;
        BOOL isSelctTime = NO;
        BOOL isSelctWidgetTime = NO;
        if (selectedFuncs.count > 0) {
            for (NSMutableDictionary *chageDict in itemArray){
                NSString*type = chageDict[@"type"];
                NSString*widget = chageDict[@"widget"];
                BOOL isSame = NO;
                for (NewDialJsonFunctionListLibModel*itemModel in self.dialJsonObj.function_list) {
                    for (NewDialJsonFuncListItemLibModel *funcitemModel in itemModel.item) {
                        if ([type isEqualToString:funcitemModel.type] && [widget isEqualToString:funcitemModel.widget] ) {
                            [saveArray removeObject:chageDict];
                        }
                    }
                }
                
                for (DialJsonTimeListLibModel*itemModel in self.dialJsonObj.time_widget_list) {
                    if ([type isEqualToString:itemModel.type] && [widget isEqualToString:itemModel.widget] ) {
                        [saveArray removeObject:chageDict];
                    }
                }
            }
            
            NSInteger funcType = [selectedFuncs.firstObject intValue];
            NSString* bgcolor = selectedObj.funcBgColor;
            
            for (NewDialJsonFunctionListLibModel*itemModel in self.dialJsonObj.function_list) {
                if(funcType == itemModel.function){
                    
                    for (NewDialJsonFunctionListItemLibModel*funcitemModel in itemModel.item) {
                        NSMutableDictionary*itemDic = [NSMutableDictionary dictionaryWithDictionary:funcitemModel.yy_modelToJSONObject];
                        NSString*itemTypeName = funcitemModel.type;
                        NSString*itemWidgetName = funcitemModel.widget;
                        
                        //位置
                        for (NewDialJsonLocationLibModel*locModel in self.dialJsonObj.locations) {
                            if(selectedObj.funcLocationType == locModel.type){
                                for (NewDialJsonFunctionCoordinateLibModel*functionModle in locModel.function_coordinate) {
                                    
                                    if(functionModle.function == funcType){
                                        for (NewDialJsonFunctionItemLibModel*funLocModel in functionModle.item) {
                                            if([itemTypeName isEqualToString:funLocModel.type]&&[itemWidgetName isEqualToString:funLocModel.widget]){
                                                [self addForRect:funLocModel.coordinate withDict:itemDic];
                                                isSelctTime = YES;
                                            }
                                            
                                        }
                                    }
                                }
                                
                                if(locModel.time_widget.count > 0){
                                    if(!isSelctWidgetTime){
                                        isSelctWidgetTime = YES;
                                        for (DialJsonTimeWidgetLibModel*timeModle in locModel.time_widget) {
                                            NSMutableDictionary*itemTimeDic = [NSMutableDictionary dictionaryWithDictionary:timeModle.yy_modelToJSONObject];
                                            [itemTimeDic setObject:[self hexFormatColor:self.timeSelectedColorHex] forKey:@"fgcolor"];
                                            [itemTimeDic setObject:[self hexFormatColor:self.timeSelectedColorHex] forKey:@"fgrender"];
                                            [saveArray addObject:itemTimeDic];
                                        }
                                    }
                                }else{
                                    widgetTime = locModel.time;
                                }
                            }
                            
                        }
                        
                        if(bgcolor.length > 0){
                            [itemDic setObject:[self hexFormatColor:bgcolor] forKey:@"bgcolor"];
                            [itemDic setObject:[self hexFormatColor:bgcolor] forKey:@"fgcolor"];
                            
                        }
                        
                        [saveArray addObject:itemDic];
                    }
                }
                
            }
            
            [itemArray removeAllObjects];
            [itemArray addObjectsFromArray:saveArray];
        }
        
        
        //self.viewModel.timeSelectedColorHex
        //写入选择的调色板的索引
        if ([self.timeSelectedColorHex length] > 0 ) {
            
            NSLog(@"修改时间或功能的颜色");
            if(CGRectIsEmpty(widgetTime) && !isSelctTime){
                NewDialJsonLocationLibModel *locationObj = [self.dialJsonObj getSelectedLocation];
                for (NSInteger i = 0; i < itemArray.count; i++) {
                    NSMutableDictionary *chageDict = [NSMutableDictionary dictionaryWithDictionary:itemArray[i]] ;
                    if ([[chageDict allKeys] containsObject:@"fgcolor"]) {
                        if ([chageDict objectForKey:@"type"] &&
                            [[chageDict objectForKey:@"type"] isKindOfClass:[NSString class]]) {
                            NSString *typeStr = [chageDict objectForKey:@"type"];
                            
                            //选择了功能的颜色
                            if ([self.funcSelectedColorHex length] > 0 && [typeStr isEqualToString:@"icon"] ) {
                                //                            [chageDict setObject:[self hexFormatColor:self.funcSelectedColorHex] forKey:@"fgcolor"];
                            } else if ([typeStr isEqualToString:@"day"] ||
                                       [typeStr isEqualToString:@"week"] ||
                                       [typeStr isEqualToString:@"time"]) {
                                //修改时间的位置
                                if ([typeStr isEqualToString:@"day"]) {
                                    [self updateForRect:locationObj.day withDict:chageDict];
                                }else if ([typeStr isEqualToString:@"week"]) {
                                    [self updateForRect:locationObj.week withDict:chageDict];
                                }else if ([typeStr isEqualToString:@"time"]) {
                                    [self updateForRect:locationObj.time withDict:chageDict];
                                }
                                
                                [chageDict setObject:[self hexFormatColor:self.timeSelectedColorHex] forKey:@"fgcolor"];
                            }
                            [saveArray replaceObjectAtIndex:i withObject:chageDict];
                        }
                    }
                }
            }else if(!isSelctWidgetTime){
                for (NSInteger i = 0; i < itemArray.count; i++) {
                    NSMutableDictionary *chageDict = [NSMutableDictionary dictionaryWithDictionary:itemArray[i]] ;
                    if ([[chageDict allKeys] containsObject:@"fgcolor"]) {
                        if ([chageDict objectForKey:@"type"] &&
                            [[chageDict objectForKey:@"type"] isKindOfClass:[NSString class]]) {
                            NSString *typeStr = [chageDict objectForKey:@"type"];
                            
                            //选择了功能的颜色
                            if ([self.funcSelectedColorHex length] > 0 && [typeStr isEqualToString:@"icon"] ) {
                                //                            [chageDict setObject:[self hexFormatColor:self.funcSelectedColorHex] forKey:@"fgcolor"];
                            } else if ([typeStr isEqualToString:@"time"]) {
                                //修改时间的位置
                                if (!CGRectIsEmpty(widgetTime)) {
                                    [self updateForRect:widgetTime withDict:chageDict];
                                }
                                
                                [chageDict setObject:[self hexFormatColor:self.timeSelectedColorHex] forKey:@"fgcolor"];
                            }
                            [saveArray replaceObjectAtIndex:i withObject:chageDict];
                        }
                    }
                }
            }
            
        }
        
        //需要移动的预览图
        NSString *dialPath = [NSString stringWithFormat:@"%@/images",[WallpaperFileLibManager dialZipRootPath:firmwareName]];
        NSString *bgPath = [dialPath stringByAppendingPathComponent:@"bgSet.png"];
        NSString *previewPath = [dialPath stringByAppendingPathComponent:@"previewSet.png"];
        
        NSString *previewName = nil;
        NSString *bgName = @"bg.bmp";
        
        if ([[iwfDict objectForKey:@"preview"] isKindOfClass:[NSString class]]) {
            //设备直接在外面的Json表里
            previewName = [iwfDict objectForKey:@"preview"];
        }
        
        if ([[iwfDict objectForKey:@"bkground"] isKindOfClass:[NSString class]]) {
            //206等设备直接在外面的Json表里
            bgName = [iwfDict objectForKey:@"bkground"];
        }
        
        if ([[iwfDict objectForKey:@"item"] isKindOfClass:[NSArray class]]) {
            //titan设备直接在外面的Json表里
            NSArray*items = [iwfDict objectForKey:@"item"];
            for (NSDictionary*itemDic in items) {
                NSString*type = [itemDic objectForKey:@"type"];
                if([type isEqualToString:@"icon"]){
                    bgName = [itemDic objectForKey:@"bg"];
                    break;
                }
            }
        }
        
        
        //拷贝预览图
        NSString *copyPreviewPath = [previewPath copy];
        NSString*previewPathImageLogtip = @"";
        if ([previewName hasSuffix:@"bmp"]) {
            UIImage *img = [UIImage imageWithContentsOfFile:previewPath];
            previewPathImageLogtip = [NSString stringWithFormat:@"previewSetImage bmp size:(w:%f h:%f)",img.size.width,img.size.height];
            NSString *toPath = [previewPath stringByReplacingOccurrencesOfString:@".png" withString:@".bmp"];
            if ([img convertPngToBmp:img.size toPath:toPath]) {
                copyPreviewPath = toPath;
            }
        }else{
            UIImage *img = [UIImage imageWithContentsOfFile:previewPath];
            previewPathImageLogtip = [NSString stringWithFormat:@"previewSetImage size:(w:%f h:%f)",img.size.width,img.size.height];
        }
        [self copyItemAtPath:copyPreviewPath withFirmwareName:firmwareName withZipName:zipName withImageName:previewName];
        [[NSFileManager defaultManager] removeItemAtPath:copyPreviewPath error:nil];
        
        //拷贝背景图
        NSString *copyBgPath = [bgPath copy];
        NSString*bgPathImageLogtip = @"";
        if ([bgName hasSuffix:@"bmp"]) {
            UIImage *img = [UIImage imageWithContentsOfFile:bgPath];
            bgPathImageLogtip = [NSString stringWithFormat:@"bgImage bmp size:(w:%f h:%f)",img.size.width,img.size.height];
            NSString *toPath = [bgPath stringByReplacingOccurrencesOfString:@".png" withString:@".bmp"];
            if ([img convertPngToBmp:img.size toPath:toPath]) {
                copyBgPath = toPath;
            }
        }else{
            UIImage *img = [UIImage imageWithContentsOfFile:bgPath];
            bgPathImageLogtip = [NSString stringWithFormat:@"bgImage size:(w:%f h:%f)",img.size.width,img.size.height];
        }
        [self copyItemAtPath:copyBgPath withFirmwareName:firmwareName withZipName:zipName withImageName:bgName];
        
        [[NSFileManager defaultManager] removeItemAtPath:copyBgPath error:nil];
        
        
        NSString*unzipLogTip = [NSString stringWithFormat:@"unZipFirmwareWithReplaceBgImage Lastest --> %@ %@)",bgPathImageLogtip,previewPathImageLogtip];
        NSLog(@"%@",unzipLogTip);
        
        //修改完要替换的json文件
        [iwfDict setObject:saveArray  forKey:@"item"];
        
        //开始写入本地
        [self writeFile:iwfDict filePath:jsonPath];
        
        
        //更新选中的appjson文件
        NSString *appJsonPath =[NSString stringWithFormat:@"%@/app.json",[WallpaperFileLibManager dialZipRootPath:firmwareName]];
        
        NSError *error = nil;
        NSData  *jsonData = [NSData dataWithContentsOfFile:appJsonPath options:NSDataReadingMappedIfSafe error:&error];
        NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        if (!error) {
            //数据解压成功
            NSMutableDictionary *appMutDic = [NSMutableDictionary dictionaryWithDictionary:[self stringToDictionary:jsonStr]];
            
            NSMutableDictionary*selectDic =  [NSMutableDictionary dictionaryWithDictionary:[appMutDic objectForKey:@"select"]];
            
            [selectDic setObject:selectedFuncs forKey:@"function"];
            [selectDic setObject:@(self.timeSelectedColorIndex) forKey:@"timeColorIndex"];
            [selectDic setObject:@(self.funcSelectedColorIndex) forKey:@"funcColorIndex"];
            [selectDic setObject:@(selectedObj.funcLocationType) forKey:@"timeFuncLocation"];
            
            [appMutDic setObject:selectDic forKey:@"select"];
            
            self.dialJsonObj.select.timeColorIndex = self.timeSelectedColorIndex;
            self.dialJsonObj.select.funcColorIndex = self.funcSelectedColorIndex;
            self.dialJsonObj.select.function = self.funcSelectedTypes;
            
            [self writeFile:appMutDic filePath:appJsonPath];
        }
        
        //开始打包
        
        //需要打包的文件路径
        NSString *zipPath = [NSString stringWithFormat:@"%@/%@/",[WallpaperFileLibManager dialZipRootPath:firmwareName], zipName];
        //打包成功的目标路径
        
        NSString *endPath = [NSString stringWithFormat:@"%@/%@.zip",[WallpaperFileLibManager dialZipRootPath:firmwareName], firmwareName];
        BOOL isSuccess = [SSZipArchive createZipFileAtPath:endPath withContentsOfDirectory:zipPath];
        if (isSuccess) {
            //开始传输
            NSLog(@"开始传输");
            
            [self deleteDial:firmwareName block:^(NSInteger errorCode) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    IDOWatchScreenInfoModel *modelScreen = [IDOWatchScreenInfoModel currentModel];
                    __block int progressValue = 0;
                    initWatchDialManager().addDialProgress(^(int progress) {
                        NSLog(@"云照片表盘安装进度%d",progress);
                        progressValue = progress;
                        if (callback) {
                            callback(WallpaperWCInstallFaceLogUpgradIng, endPath, progress);
                        }
                        
                    }).addDialTransfer(^(int errorCode, int finishingTime) {
                        
                        if (errorCode == 0) {
                            //成功
                            if (callback) {
                                callback(WallpaperWCInstallFaceLogUpgradIng, endPath, 100);
                            }
                            NSLog(@"照片云表盘安装成功");
                            
                            //设为当前表盘
                            [self setCurrentDial:firmwareName block:^(NSInteger errorCode) {
                                NSLog(@"设为当前表盘结果：%@", [IDOErrorCodeToStr errorCodeToStr:errorCode]);
                                if (callback) {
                                    callback(WallpaperWCInstallFaceLogUpgradeSucc, endPath, 100);
                                }
                            }];
                            
                            
                            
                            NSLog(@"壁纸表盘安装成功 使用记录接口/GetByNameV2请求权限重设置");
                        }else{
                            //失败
                            if (callback) {
                                callback(WallpaperWCInstallFaceLogUpgradeFail, endPath, progressValue);
                            }
                            NSLog(@"照片云表盘安装失败 errorCode %@ %@",@(errorCode), [IDOErrorCodeToStr errorCodeToStr:errorCode]);
                        }
                        
                    });
                    initWatchDialManager().colorFormat = modelScreen.colorFormat;
                    initWatchDialManager().filePath = endPath;
                    initWatchDialManager().blockSize = modelScreen.blockSize;
                    
                    NSLog(@"endPath----------:%@",endPath);
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [IDOWatchDialManager startDialTransfer];
                    });
                    
                    
                });
            }];
            
        }else{
            if (callback) {
                callback(WallpaperWCInstallFaceLogUpgradeFail, nil,0);
            }
        }
        
    }else{
        //解压失败 传输中断
        if (callback) {
            callback(WallpaperWCInstallFaceLogUpgradeFail, nil,0);
        }
    }
}

/// 是否是圆形
- (BOOL)isShapeRoundDevice{
    
    
    IDOGetDeviceInfoBluetoothModel * deviceModel = [IDOGetDeviceInfoBluetoothModel currentModel];
    BOOL flag = deviceModel.deviceShapeType == 1 || ([deviceModel.deviceId isEqualToString:@"353"]);
    
    return NO;
}

////转换成RGB  （思澈GTX12专用）
//- (void)updateForColor:(NSString*)hexFormatColor andRect:(CGRect)rect withDict:(NSMutableDictionary *)dict{
//    if (hexFormatColor.length == 0 || CGRectIsEmpty(rect)) {
//        NSLog(@"思澈平台 颜色或者位置为空");
//        return;
//    }
//    NSLog(@"思澈平台 颜色和位置改之前:%@",dict);
//    //设置位置
//    if ([dict objectForKey:@"x"]) {
//        [dict setObject:@(rect.origin.x) forKey:@"x"];
//    }
//    if ([dict objectForKey:@"y"]) {
//        [dict setObject:@(rect.origin.y) forKey:@"y"];
//    }
//    //设置颜色
//    UIColor *color = [IDOSDKUtility colorObjWithHexString:hexFormatColor];
//    NSArray *rgbArray = [self convertColorToRGB:color];
//    if (rgbArray.count == 3){
//        NSInteger red = [rgbArray[0] integerValue];
//        NSInteger green = [rgbArray[1] integerValue];
//        NSInteger blue = [rgbArray[2] integerValue];
//        NSLog(@"color:%@ 转换成 RGB:red=%ld  green = %ld   blue = %ld ",hexFormatColor,(long)red,(long)green,(long)blue);
//        if ([dict objectForKey:@"r"]) {
//            [dict setObject:@(red) forKey:@"r"];
//        }
//        if ([dict objectForKey:@"g"]) {
//            [dict setObject:@(green) forKey:@"g"];
//        }
//        if ([dict objectForKey:@"b"]) {
//            [dict setObject:@(blue) forKey:@"b"];
//        }
//    }
//    NSLog(@"思澈平台 颜色和位置改之后:%@",dict);
//}

- (NSArray *)convertColorToRGB:(UIColor *)color {
    NSInteger numComponents = CGColorGetNumberOfComponents(color.CGColor);
    NSArray *array = nil;
    if (numComponents == 4) {
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        array = @[@((int)(components[0] * 255)),
                  @((int)(components[1] * 255)),
                  @((int)(components[2] * 255))];
    }
    return array;
}

- (UIImage *)cacheDialScreenshotImage:(NSString *)filePath{
    UIImage *img = [self getDialScreenshotImg];
    NSLog(@"cacheDialScreenshotImage : %@-%@", filePath, img);
    [UIImagePNGRepresentation(img) writeToFile:filePath atomically:YES];
    
    return img;
}

- (UIImage *)getDialScreenshotImg{
    UIViewController*currentViewController  = [WallpaperFileLibManager getIDOCurrentVC];
    UIGraphicsBeginImageContextWithOptions([UIScreen mainScreen].bounds.size, currentViewController.view.opaque, 0);
    [currentViewController.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    IDOWatchScreenInfoModel *modelScreen = [IDOWatchScreenInfoModel currentModel];
    if (modelScreen.width > 0 && modelScreen.height > 0) {
        return [self scaleToSize:image size:CGSizeMake(modelScreen.width, modelScreen.height)];
    }
    return image;
}

//修改图片为指定的大小
- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    NSLog(@"scaleToSize %@", NSStringFromCGSize(size));
    
    UIGraphicsBeginImageContext(size);
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

- (UIImage *)scaleImage:(UIImage *)image size:(CGSize)size {
    if (image.size.width == size.width && image.size.height == size.height) {
        return image;
    }
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0.0, size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    CGContextDrawImage(context, CGRectMake(0, 0, size.width, size.height), image.CGImage);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


- (void)writeFile:(id)fileContent filePath:(NSString*)filePath{
    if ([fileContent isKindOfClass:[NSArray class]]) {
        //数组写文件
    }
    if ([fileContent isKindOfClass:[NSDictionary class]]) {
        //字典写文件
        NSDictionary *dictFile = (NSDictionary*)fileContent;
        
        NSString *fileStr = [self DataTOjsonString:dictFile];
        
        NSError *error ;
        
        [fileStr writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
        
        if (error) {
            NSLog(@"%@",error);
        }
    }
}
-(NSString*)DataTOjsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

- (void)copyItemAtPath:(NSString *)itemAtPath
      withFirmwareName:(NSString *)firmwareName
           withZipName:(NSString *)zipName
         withImageName:(NSString *)imageName{
    if ([imageName length] <= 0 ||
        ![[NSFileManager defaultManager] fileExistsAtPath:itemAtPath]) {
        return;
    }
    NSString *bgPath = [NSString stringWithFormat:@"%@/%@/%@",[WallpaperFileLibManager dialZipRootPath:firmwareName], zipName, imageName];
    NSError *error = nil;
    BOOL res = [[NSFileManager defaultManager] removeItemAtPath:bgPath error:&error];
    
    NSLog(@"Watch:删除背景图片 %@, error: %@", @(res), [error debugDescription]);
    
    [[NSFileManager defaultManager] copyItemAtPath:itemAtPath toPath:bgPath error:&error];
    
    NSLog(@"Watch:拷贝背景图片 %@, error: %@", @(res), [error debugDescription]);
    
}

- (NSString *)hexFormatColor:(NSString *)hexColor{
    NSString *tmpStr = [hexColor stringByReplacingOccurrencesOfString:@"#" withString:@"0xFF"];
    
    return tmpStr;
}

- (void)updateForRect:(CGRect)rect withDict:(NSMutableDictionary *)dict{
    if (CGRectIsEmpty(rect)) {
        return;
    }
    if ([dict objectForKey:@"x"]) {
        [dict setObject:@(rect.origin.x) forKey:@"x"];
    }
    if ([dict objectForKey:@"y"]) {
        [dict setObject:@(rect.origin.y) forKey:@"y"];
    }
    if ([dict objectForKey:@"w"]) {
        [dict setObject:@(rect.size.width) forKey:@"w"];
    }
    if ([dict objectForKey:@"h"]) {
        [dict setObject:@(rect.size.height) forKey:@"h"];
    }
}

- (void)addForRect:(CGRect)rect withDict:(NSMutableDictionary *)dict{
    if (CGRectIsEmpty(rect)) {
        return;
    }
    [dict setObject:@(rect.origin.x) forKey:@"x"];
    [dict setObject:@(rect.origin.y) forKey:@"y"];
    [dict setObject:@(rect.size.width) forKey:@"w"];
    [dict setObject:@(rect.size.height) forKey:@"h"];
}

#pragma mark - nsstring 转 字典
- (NSDictionary*)stringToDictionary:(NSString*)jsonStr{
    NSData *stringData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    id json = [NSJSONSerialization JSONObjectWithData:stringData options:0 error:nil];
    return json;
}

#pragma mark - Set & Get

- (void)setTimeSelectedColorIndex:(NSInteger)selectColorIndex{
    _timeSelectedColorIndex = selectColorIndex;
    
    self.timeSelectedColorHex = self.stringColorArray[_timeSelectedColorIndex];
}

- (void)setFuncSelectedColorIndex:(NSInteger)funcSelectedColorIndex{
    _funcSelectedColorIndex = funcSelectedColorIndex;
    
    self.funcSelectedColorHex = self.stringColorArray[funcSelectedColorIndex];
}

- (NSMutableArray*)colorDataSoureArray{
    if (!_colorDataSoureArray) {
        if (IDOkIsWidgetWallpaper) {
            _colorDataSoureArray = [NSMutableArray arrayWithArray:@[WC_COLOR(@"#FFFFFF"),WC_COLOR(@"#BFA8FF"),WC_COLOR(@"#FF3333"),WC_COLOR(@"#826F60"),WC_COLOR(@"#FF8542"),WC_COLOR(@"#5CA4AC"),WC_COLOR(@"#7DC498"),WC_COLOR(@"#4694FF"),WC_COLOR(@"#4C68BE"),WC_COLOR(@"#718B83"),WC_COLOR(@"#B4C21D"),WC_COLOR(@"#CC8A89"),WC_COLOR(@"#FFD508"),WC_COLOR(@"#FDF19F"),WC_COLOR(@"#FFE0BF"),WC_COLOR(@"#C4DAE9")]];
        }else{
            _colorDataSoureArray = [NSMutableArray arrayWithArray:@[WC_COLOR(@"#FFFFFF"),WC_COLOR(@"#000000"),WC_COLOR(@"#FC1E58"),WC_COLOR(@"#FF9501"),WC_COLOR(@"#0091FF"),WC_COLOR(@"#44D7B6")]];
        }
        
    }
    return _colorDataSoureArray;
}

- (NSMutableArray*)stringColorArray{
    if (!_stringColorArray) {
        if (IDOkIsWidgetWallpaper) {
            _stringColorArray = [NSMutableArray arrayWithArray:@[@"#FFFFFF",@"#BFA8FF",@"#FF3333",@"#826F60",@"#FF8542",@"#5CA4AC",@"#7DC498",@"#4694FF",@"#4C68BE",@"#718B83",@"#B4C21D",@"#CC8A89",@"#FFD508",@"#FDF19F",@"#FFE0BF",@"#C4DAE9"]];
        }else{
            _stringColorArray = [NSMutableArray arrayWithArray:@[@"#FFFFFF",@"#000000",@"#FC1E58",@"#FF9501",@"#0091FF",@"#44D7B6"]];
        }
    }
    return _stringColorArray;
}

- (NSArray *)imageLocationArray{
    if (!_imageLocationArray) {
        _imageLocationArray = @[@"main_spindex_Cricket59",@"main_spindex_Elliptical56",@"main_spindex_Fitness9",@"main_spindex_Hiking_4"];
    }
    return _imageLocationArray;
}

- (NSArray<NewDialJsonFuncListLibModel *> *)funcList{
    if (!_funcList) {
        _funcList = [NewDialJsonFuncListLibModel getWallperDialDefaultsFuncs];
    }
    return _funcList;
}
-(void)setTimeSelectedColorHex:(NSString *)timeSelectedColorHex
{
    _timeSelectedColorHex = timeSelectedColorHex;
}

/// 删除表盘
/// @param dialName 表盘名字
/// @param block 结果回调
- (void)deleteDial:(NSString *)dialName block:(void(^_Nullable)(NSInteger errorCode))block {
    if (!dialName || [dialName length] <=0) {
        block(0);
        return;
    }
    IDOWatchDialInfoItemModel *dialModel = [[IDOWatchDialInfoItemModel alloc] init];
    
    dialName = [dialName stringByReplacingOccurrencesOfString:@".zip" withString:@""];
    dialName = [dialName stringByReplacingOccurrencesOfString:@".watch" withString:@""];
    NSString *fileName = dialName;
    IDOGetDeviceInfoBluetoothModel * data = [IDOGetDeviceInfoBluetoothModel currentModel];
    if (data.platform == 99 || data.platform == 98) { //思澈平台升级
        fileName = [NSString stringWithFormat:@"%@.watch",dialName];
    }else{
        if (![dialName hasSuffix:@".iwf"]) {
            fileName = [NSString stringWithFormat:@"%@.iwf",dialName];
        }
    }
    
    dialModel.fileName = fileName;
    dialModel.operate = 2;
    
    NSLog(@"Watch:准备删除表盘协议：%@", fileName);
    //先判断功能表-做判断条件是否使用v3状态
    dispatch_async(dispatch_get_main_queue(), ^{
        
        initWatchDialManager().setCurrentDial(^(int errorCode) {
            NSLog(@"Watch:删除表盘协议：%@",  [IDOErrorCodeToStr errorCodeToStr:errorCode]);
            if (block) {
                block(errorCode);
            }
        }, dialModel);
    });
}

/// 设置当前表盘
/// @param dialName 表盘名字
/// @param block 结果回调
- (void)setCurrentDial:(NSString *)dialName block:(void(^_Nullable)(NSInteger errorCode))block {
    if ([dialName length] <= 0) {
        if (block) {
            block(10001);
        }
        return;
    }
    dialName = [dialName stringByReplacingOccurrencesOfString:@".zip" withString:@""];
    dialName = [dialName stringByReplacingOccurrencesOfString:@".watch" withString:@""];
    NSString *fileName = dialName;
    IDOGetDeviceInfoBluetoothModel * data = [IDOGetDeviceInfoBluetoothModel currentModel];
    if (data.platform == 99 || data.platform == 98) { //思澈平台升级
        fileName =  [dialName containsString:@"local"] ? dialName : [NSString stringWithFormat:@"%@.watch",dialName];
    }else{
        fileName =  [dialName containsString:@"local"] ? dialName : [NSString stringWithFormat:@"%@.iwf",dialName];
        
    }
    NSLog(@"Watch:设置当前表盘：%@", fileName);
    IDOWatchDialInfoItemModel *dialModel = [[IDOWatchDialInfoItemModel alloc] init];
    dialModel.fileName = fileName;
    dialModel.operate = 1;
    
    //去除原先设置自定义表盘的接口
    
    dispatch_async(dispatch_get_main_queue(), ^{
        initWatchDialManager().setCurrentDial(^(int errorCode) {
            if (block) {
                block(errorCode);
            }
        }, dialModel);
    });
    
    
    
}


@end
