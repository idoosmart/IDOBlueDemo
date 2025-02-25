//
//  ZipArchive.h
//  IDOBlue
//
//  Created by cyf on 2025/2/25.
//  Copyright © 2025 hedongyang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSZipArchive : NSObject

+ (BOOL)createZipFileAtPath:(NSString *)path withContentsOfDirectory:(NSString *)directoryPath;

+ (void)unzipFileAtPath:(NSString *)path
          toDestination:(NSString *)destination
        progressHandler:(void (^)(double progress))progressHandler
      completionHandler:(void (^)(NSString *path, BOOL succeeded, NSError * _Nullable error))completionHandlder;
@end

NS_ASSUME_NONNULL_END
