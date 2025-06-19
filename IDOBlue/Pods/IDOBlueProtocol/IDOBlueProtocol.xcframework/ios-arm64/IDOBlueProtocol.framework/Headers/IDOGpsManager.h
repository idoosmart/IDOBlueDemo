//
//  IDOGpsManager.h
//  IDOBlueProtocol
//
//  Created by huangkunhe on 2022/8/31.
//  Copyright © 2022 何东阳. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum : NSUInteger {
    IDOGpsUpgradeTypeFail,  //失败
    IDOGpsUpgradeTypeSucc,  //成功
    IDOGpsUpgradeTypeUnSupport,  //不支持此功能
    IDOGpsUpgradeTypeUpdating,  //更新中
} IDOGpsUpgradeType;

NS_ASSUME_NONNULL_BEGIN

@protocol IDOGpsManagerDelegate <NSObject>
/**
 设置热启动参数
 Setting hot start parameters
 */
- (IDOGetHotStartParamBluetoothModel*)setHotStartParam;

@end

@interface IDOGpsManager : NSObject

//gps操作代理对象 | gps operation proxy object
@property (nonatomic,weak)id<IDOGpsManagerDelegate> delegate;

/**
 开关打开，每个24小时更新一次GPS EPO 文件 ，默认关闭 | The switch is turned on and the GPS EPO file is updated every 24 hours. The switch is turned off by default
 */
@property (nonatomic,assign) BOOL isOpenAutoUpdate;


+ (IDOGpsManager *)shareInstance;


/// 强制更新GPS EPO | Forced update GPS EPO
- (void)forceUpdateGpsInfo;
/**
 * 制作GPS文件
 * filePath:  素材路径, 也是输出文件的路径
 *
 * 制作成功后的文件名是：EPO.DAT
 * 取模图片的格式 为1024
 * @return 制作成功后文件的路径（文件名是EPO.DAT），若失败，则返回为nil；
 *
 */
+ (NSString *)getMakeGpsZipFileWithFilePath:(NSString *)filePath;

/**
 * 下载EPO文件 | Download EPO file
 * @param callback ( status, epoFileFolder )
 *
 */
-(void)downLoadEPOFile:(void (^)(IDOGpsUpgradeType status, NSString* epoFileFolder))callback;

/**
 * 检查EPO文件是否需要更新 | Check whether the EPO file needs to be updated
 */
- (BOOL)startCheckoutOnlineAgpsEPOIsNeedUpdate;

/**
 * 升级完EPO文件后，需要更新一下升级的时间 | After upgrading the EPO file, you need to update the upgrade time
 */
- (void)updateAgpsEPOFileUpdateTimeNow;

/**
 * epo 更新时间复位
 */
- (void)resetEPOFileUpdateTime;

@end

NS_ASSUME_NONNULL_END
