//
//  DialJsonTimeWidgetLibModel.h
//  IDOBlue
//
//  Created by cyf on 2025/2/25.
//  Copyright © 2025 hedongyang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DialJsonTimeWidgetLibModel: NSObject

@property (nonatomic, copy) NSString* widget;

@property (nonatomic, copy) NSString* type;

@property (nonatomic, copy) NSString* font;

@property (nonatomic, assign) int fontnum;

@property (nonatomic, assign) int x;

@property (nonatomic, assign) int y;

@property (nonatomic, assign) int w;

@property (nonatomic, assign) int h;

@end

NS_ASSUME_NONNULL_END
