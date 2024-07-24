//
//  IDOScManager.h
//  IDOBlueProtocol
//
//  Created by chenhuili on 2023/10/19.
//  Copyright © 2023 何东阳. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IDOScManager : NSObject
/**
 * 制作思澈表盘文件
 * filePath:  传入素材路径, 制作成功后文件的路径为传入的filePath
 * @return 错误码，0成功 非0失败 -1: 没有控件 -2: json文件加载失败
 */

+ (int)getMakeSiFliWatchDialWithFilePath:(NSString *)filePath;

@end

NS_ASSUME_NONNULL_END
