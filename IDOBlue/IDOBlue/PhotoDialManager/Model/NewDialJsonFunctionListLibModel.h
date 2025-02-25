//
//  IDONewDialJsonFunctionListLibModel.h
//  IDOBlue
//
//  Created by cyf on 2025/2/24.
//  Copyright © 2025 hedongyang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NewDialJsonFunctionListItemLibModel;
NS_ASSUME_NONNULL_BEGIN

@interface NewDialJsonFunctionListLibModel: NSObject

@property (nonatomic,   assign) int function;

@property (nonatomic,   copy) NSString *name;

@property (nonatomic,   copy) NSString *small_icon;

@property (nonatomic, strong) NSArray<NewDialJsonFunctionListItemLibModel *> *item;

@end

NS_ASSUME_NONNULL_END
