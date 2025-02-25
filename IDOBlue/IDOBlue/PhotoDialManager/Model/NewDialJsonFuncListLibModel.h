//
//  NewDialJsonFuncListLibModel.h
//  IDOBlue
//
//  Created by cyf on 2025/2/24.
//  Copyright © 2025 hedongyang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class NewDialJsonFuncListItemLibModel;

@interface NewDialJsonFuncListLibModel: NSObject

@property (nonatomic,   copy) NSString *type;//类型

@property (nonatomic, strong) NSArray<NewDialJsonFuncListItemLibModel *> *items;

- (NSString *)getTypeName;

+ (NSArray <NewDialJsonFuncListLibModel *>*)getWallperDialDefaultsFuncs;

@end

NS_ASSUME_NONNULL_END
