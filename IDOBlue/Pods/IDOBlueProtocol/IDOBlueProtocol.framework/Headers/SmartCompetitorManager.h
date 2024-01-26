//
//  SmartCompetitorManager.h
//  IDOBlueProtocol
//
//  Created by huangkunhe on 2023/3/9.
//  Copyright © 2023 何东阳. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    IDOIsFPathType_Zip_Path,  //zip的文件
    IDOIsFPathType_Folder_Path,  //Folder的文件
} IDOIsFPathType;

NS_ASSUME_NONNULL_BEGIN

@interface SmartCompetitorManager : NSObject

+ (SmartCompetitorManager *)shareInstance;

/**
 * @brief 制作(ISF)文件,会在素材路径下生成.isf和.isf.lz(智能陪跑文件) | Make (ISF) files, and generate. isf and. isf.lz (intelligent running files) under the material path
 * @param filePath 素材路径 表盘包目录路径（zip原包） | Material path Table package directory path（zip）
 * @param isFPathType filePath文件的类型  | FilePath file type

 * @param savefilename 输出保存的文件名(xx.isf)  | Output saved file name (xx. isf)
 * @param fontFormat 取模图片的格式 | Format of mold image
 * @param blockSize 压缩块大小 1024/4096  | Compressed block size 1024/4096
 * @return 0成功 非0失败 | 0 success not 0 failure
*/
- (NSString *)getMakeIsFFileWithFilePath:(NSString *)filePath filePathType:(IDOIsFPathType)isFPathType saveFileName:(NSString *)savefilename fontFormat:(int)fontFormat blockSize:(int)blockSize;

/**
 *  删除文件 | remove Item At Path
*/
- (BOOL)removeItemAtPath:(NSString*)filepath;

/**
 * @param filePath 目录路径（zip原包） |  package directory path（zip）
 * @param folderName 新的文件包名  | New package name
 * @return 回调新的解压缩的文件路径 | Recall the new uncompressed file path （unzip）
*/
- (NSString *)getUnIsfZipFileWithFilePath:(NSString *)filePath newFolderName:(NSString*)folderName;

/**
 *  根路径 |  Root path
*/
- (NSString *)isfDirPath;

/**
 *  根路径文件名 |  Root path name
*/
- (NSString *)isfDirName;

@end

NS_ASSUME_NONNULL_END
