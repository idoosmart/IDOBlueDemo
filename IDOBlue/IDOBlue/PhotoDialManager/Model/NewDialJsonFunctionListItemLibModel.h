//
//  NewDialJsonFunctionListItemLibModel.h
//  IDOBlue
//
//  Created by cyf on 2025/2/24.
//  Copyright © 2025 hedongyang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewDialJsonFunctionListItemLibModel: NSObject

@property (nonatomic,   copy) NSString *widget;

@property (nonatomic,   copy) NSString *type;

@property (nonatomic,   copy) NSString *font;

@property (nonatomic, assign) NSUInteger fontnum;

@property (nonatomic, assign) BOOL support_color_set;

@property (nonatomic,   copy) NSString *bg;

@property (nonatomic,   copy) NSString *align;

@end

NS_ASSUME_NONNULL_END
