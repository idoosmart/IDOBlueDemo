//
//  ZipArchive.m
//  IDOBlue
//
//  Created by cyf on 2025/2/25.
//  Copyright © 2025 hedongyang. All rights reserved.
//

#import "SSZipArchive.h"
#import "IDOBlue-Swift.h"

@implementation SSZipArchive

+ (BOOL)createZipFileAtPath:(NSString *)path withContentsOfDirectory:(NSString *)directoryPath{
    
   BOOL isSuccess = [ZipHelper createZipFileAtPath:path withContentsOfDirectory:directoryPath keepParentDirectory:YES compressionLevel:9];
    return isSuccess;
}

+ (void)unzipFileAtPath:(NSString *)path
          toDestination:(NSString *)destination
        progressHandler:(void (^)(double progress))progressHandler
      completionHandler:(void (^)(NSString *path, BOOL succeeded, NSError * _Nullable error))completionHandler
{
    [ZipHelper unzipFile:[NSURL URLWithString:path] destination:[NSURL URLWithString:destination] progress:^(double progress) {
        if(progressHandler) {progressHandler(progress);}
    } fileOutputHandler:^(NSURL * url) {
        if(completionHandler) {completionHandler(url.lastPathComponent,YES,nil);}
    }];
}

@end
