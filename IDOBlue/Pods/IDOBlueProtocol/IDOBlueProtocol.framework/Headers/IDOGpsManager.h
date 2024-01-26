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

/**
 * EPO限制升级时间，一般是24小时，updateTime的单位是小事，默认 updateTime = 24hour，可以不使用
   | EPO limits the upgrade time, usually 24 hours. The unit of update time is a small matter, and the default update time is 24 hours, which can be omitted
 *
 */
@property (nonatomic,assign) int updateTime;


+ (IDOGpsManager *)shareInstance;

/**
 * 制作GPS文件  |  Creating GPS files
 * filePath:  素材路径, 也是输出文件的路径  |  The material path is also the path to the output file
 *
 * 制作成功后的文件名是：EPO.DAT  |  The file name after successful production is: EPO DAT
 * 取模图片的格式 为1024 | The format of the template image is 1024
 * @return 制作成功后文件的路径（文件名是EPO.DAT），若失败，则返回为nil；| The path to the file after successful creation (file name is EPO. DAT), if unsuccessful, returns nil;
 *
 */

+ (NSString *)getMakeGpsZipFileWithFilePath:(NSString *)filePath;

/**
 * 下载EPO文件 | Download EPO file
 *  功能表：__IDO_FUNCTABLE__.funcTable34Model.supportAirohaGpsChip
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
