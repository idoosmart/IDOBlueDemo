//
//  NewDialJsonCountTimerLibModel.h
//  IDOBlue
//
//  Created by cyf on 2025/2/25.
//  Copyright © 2025 hedongyang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewDialJsonCountTimerLibModel: NSObject

//@(1), @(3), @(5), @(10), @(30), @(60)
@property (nonatomic, strong) NSArray<NSNumber *> *timers;

//默认的索引 如上示例 index2对应值是5
@property (nonatomic, assign) NSInteger defaultIndex;

//倒计时图标的位置
@property (nonatomic, assign) CGRect location;

@property (nonatomic, assign) CGFloat cornerRadius;//圆角大小

@property (nonatomic, assign) CGFloat fontSize;

@property (nonatomic,   copy) NSString *textColor;

@end

NS_ASSUME_NONNULL_END
