//
//  NewDialJsonAppLibModel.h
//  IDOBlue
//
//  Created by cyf on 2025/2/25.
//  Copyright © 2025 hedongyang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface NewDialJsonAppLibModel: NSObject

@property (nonatomic, assign) NSInteger bpp;

@property (nonatomic,   copy) NSString *name;

///拷贝功能表的功能图标的 图片后缀
@property (nonatomic,   copy) NSString *format;

///功能表盘支持动态更换预览图 2.1.6
@property (nonatomic, assign) NSInteger replacePreview;

@end


NS_ASSUME_NONNULL_END
