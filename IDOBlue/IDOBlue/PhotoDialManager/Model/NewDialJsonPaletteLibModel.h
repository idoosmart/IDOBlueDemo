//
//  NewDialJsonPaletteLibModel.h
//  IDOBlue
//
//  Created by cyf on 2025/2/25.
//  Copyright © 2025 hedongyang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - 调色板的对象

@interface NewDialJsonPaletteLibModel: NSObject

@property (nonatomic,   copy) NSString *num;//类型

@property (nonatomic,   copy) NSString *colors;//图标

@property (nonatomic, assign) NSInteger index;//索引

@end


NS_ASSUME_NONNULL_END
