//
//  IDOWallpaperCloudManager.h
//  IDOBlueProtocol
//
//  Created by huangkunhe on 2023/2/7.
//  Copyright © 2023 何东阳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <IDOBlueProtocol/IDOWallpaperCloudLibModel.h>

typedef enum : NSUInteger {
    IDOWCInstallFaceLogUnknown = 0,  //未知
    IDOWCInstallFaceLogDownLoad,     //1 下载
    IDOWCInstallFaceLogEnterUpgrade, //2 进入升级模式
    IDOWCInstallFaceLogUpgradIng,    //3 进入进度大于0的升级界面
    IDOWCInstallFaceLogUpgradeSucc,  //4 升级成功
    IDOWCInstallFaceLogUpgradeFail,  //5 失败
    IDOWCInstallFaceLogUpgradeFail_IrregularImageSize,  //6 图片尺寸不合规
} IDOWCInstallFaceLog;
NS_ASSUME_NONNULL_BEGIN

@interface IDOWallpaperCloudManager : UIView

//读取的json 云照片表盘
//Read json cloud photo dial
@property (nonatomic , strong) IDOWallpaperCloudLibModel *dialJsonObj;

@property (nonatomic, strong) IDONewDialInstallLibModel  *installModel;

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
@property (nonatomic,assign)NSInteger selectLocationIndex;

//是否是修改壁纸表盘颜色值
//Whether to modify the wallpaper dial color value
@property (nonatomic,assign)BOOL    setWallpaperColor;

//需要传输给固件的颜色
//Color to be transferred to firmware
@property (nonatomic,strong)NSMutableArray *stringColorArray;

//位置的image name
//Image name of the location
@property (nonatomic,strong)NSArray *imageLocationArray;

@property (nonatomic,strong)UIImage  *selectImage;

//展示可选择的颜色值
//Show selectable color values
@property (nonatomic,strong)NSMutableArray *colorDataSoureArray;

///照片表盘支持的全部功能
///All functions supported by the photo dial
@property (nonatomic,strong) NSArray <IDONewDialJsonFuncListLibModel *> *funcList;

///解压固件的压缩包,并且制作表盘文件
///Decompress the compressed package of the firmware and make the dial file
- (void)unZipFirmwareWithReplaceBgImage:(UIImage *)bgImage
     withPreviewSetImage:(UIImage *)previewSetImage
     withFirmwareName:(NSString *)firmwareName
          withZipName:(NSString *)dialName
             callback:(void (^)(IDOWCInstallFaceLog status, NSString* wallpaperZipPath))callback;

@end

NS_ASSUME_NONNULL_END
