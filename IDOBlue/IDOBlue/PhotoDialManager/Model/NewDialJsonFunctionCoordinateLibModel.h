//
//  NewDialJsonFunctionCoordinateLibModel.h
//  IDOBlue
//
//  Created by cyf on 2025/2/25.
//  Copyright © 2025 hedongyang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NewDialJsonFunctionItemLibModel;
NS_ASSUME_NONNULL_BEGIN

@interface NewDialJsonFunctionCoordinateLibModel: NSObject

@property (nonatomic, assign) NSInteger function;
@property (nonatomic, strong) NSArray<NewDialJsonFunctionItemLibModel *>  *item;

@end

NS_ASSUME_NONNULL_END
