//
//  IDOGpsManager.h
//  IDOBlueProtocol
//
//  Created by huangkunhe on 2022/8/31.
//  Copyright © 2022 何东阳. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IDOGpsManager : NSObject


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

@end

NS_ASSUME_NONNULL_END
