//
//  IDOWallpaperCloudLibManager.h
//  IDOBlueProtocol
//
//  Created by chenhuili on 2024/1/22.
//  Copyright © 2024 何东阳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WallpaperCloudLibModel.h"

typedef enum : NSUInteger {
    WallpaperWCInstallFaceLogUnknown = 0,  //未知
    WallpaperWCInstallFaceLogDownLoad,     //1 下载 ｜ Download dial
    WallpaperWCInstallFaceLogEnterUpgrade, //2 进入升级模式 ｜ The dial is installed in upgrade mode
    WallpaperWCInstallFaceLogUpgradIng,    //3 进入进度大于0的升级界面 ｜ The dial is being installed
    WallpaperWCInstallFaceLogUpgradeSucc,  //4 升级成功 ｜ The dial is installed successfully
    WallpaperWCInstallFaceLogUpgradeFail,  //5 失败 ｜ Dial installation failed
    WallpaperWCInstallFaceLogUpgradeFail_IrregularImageSize,  //6 图片尺寸不合规
} WallpaperWCInstallFaceLog;
NS_ASSUME_NONNULL_BEGIN
@class WallpaperCloudLibModel;
@class NewDialInstallLibModel;
@class NewDialJsonFuncListLibModel;
@interface WallpaperCloudLibManager : UIView

//读取的json 云照片表盘
//Read json cloud photo dial
@property (nonatomic , strong) WallpaperCloudLibModel *dialJsonObj;

@property (nonatomic, strong) NewDialInstallLibModel  *installModel;

///照片表盘选择的功能
///Photo dial selection function
@property (nonatomic,strong) NSArray<NSString *> *funcSelectedTypes;

//需要传输给固件的颜色值
//Color value to be transferred to firmware
@property (nonatomic,copy) NSString *timeSelectedColorHex;

//时间的颜色索引
//Color index of time
@property (nonatomic,assign) NSInteger timeSelectedColorIndex;

//时间的颜色索引
//Color index of time
@property (nonatomic,assign) NSInteger funcSelectedColorIndex;

//需要传输给固件的颜色值
//Color value to be transferred to firmware
@property (nonatomic,strong) NSString *funcSelectedColorHex;

//选中的时间的位置
//Location of the selected time
@property (nonatomic,assign) NSInteger selectLocationIndex;

//是否是修改壁纸表盘颜色值
//Whether to modify the wallpaper dial color value
@property (nonatomic,assign) BOOL   setWallpaperColor;

//需要传输给固件的颜色
//Color to be transferred to firmware
@property (nonatomic,strong) NSMutableArray *stringColorArray;

//位置的image name
//Image name of the location
@property (nonatomic,strong) NSArray *imageLocationArray;

@property (nonatomic,strong) UIImage  *selectImage;

//展示可选择的颜色值
//Show selectable color values
@property (nonatomic,strong) NSMutableArray *colorDataSoureArray;

///照片表盘支持的全部功能
///All functions supported by the photo dial
@property (nonatomic,strong) NSArray <NewDialJsonFuncListLibModel *> *funcList;

///解压固件的压缩包,并且制作表盘文件
///Decompress the compressed package of the firmware and make the dial file
- (void)unZipFirmwareWithReplaceBgImage:(UIImage *)bgImage
     withPreviewSetImage:(UIImage *)previewSetImage
     withFirmwareName:(NSString *)firmwareName
          withZipName:(NSString *)dialName
             callback:(void (^)(WallpaperWCInstallFaceLog status, NSString* wallpaperZipPath,int progress))callback;

@end

NS_ASSUME_NONNULL_END

