//
//  NewDialJsonFunctionItemLibModel.h
//  IDOBlue
//
//  Created by cyf on 2025/2/25.
//  Copyright © 2025 hedongyang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - 照片表盘的位置
@interface NewDialJsonFunctionItemLibModel: NSObject

@property (nonatomic, copy) NSString* widget;
@property (nonatomic, copy) NSString* type;
@property (nonatomic, assign) CGRect coordinate;

@end


NS_ASSUME_NONNULL_END
