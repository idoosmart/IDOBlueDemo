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
} IDOGpsUpgradeType;
NS_ASSUME_NONNULL_BEGIN

@interface IDOGpsManager : NSObject

+ (IDOGpsManager *)shareInstance;

/**
 * 制作EPO文件（AGPS） （三合一）| Make GPS（AGPS） files (three in one)
 * filePath:  素材路径, 也是输出文件的路径
 *
 * 制作成功后的文件名是：EPO.DAT
 * 取模图片的格式 为1024
 * @return 制作成功后文件的路径（文件名是EPO.DAT），若失败，则返回为nil；
 *
 */

+ (NSString *)getMakeGpsZipFileWithFilePath:(NSString *)filePath;

/** 功能表（functable）：__IDO_FUNCTABLE__.funcTable34Model.supportAirohaGpsChip
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

@end

NS_ASSUME_NONNULL_END
