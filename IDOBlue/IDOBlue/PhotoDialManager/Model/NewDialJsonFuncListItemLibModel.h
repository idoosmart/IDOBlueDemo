//
//  NewDialJsonFuncListItemLibModel.h
//  IDOBlue
//
//  Created by cyf on 2025/2/24.
//  Copyright © 2025 hedongyang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewDialJsonFuncListItemLibModel: NSObject


@property (nonatomic,   copy) NSString *type;//类型

@property (nonatomic,   copy) NSString *icon;//图标

//功能组件
@property (nonatomic, copy) NSString* widget;

//照片表盘 选择的功能组件
@property (nonatomic, assign) NSUInteger widgetType;


@property (nonatomic,   copy) NSString *contentStr;//如果显示文字时的内容

//功能表盘 只支持部分按钮 根据defaultFuncs顺序的索引判断
@property (nonatomic, strong) NSArray<NSNumber *> *supportFuncsIndexs;

+ (NSString *)getWidgetImageNameFromFuncListItem:(NSInteger)widgetType;

+ (NSString *)getTypeNameWithType:(NSString *)typeName;

+ (NSString *)convertWidgetTypeToFuncListItem:(NSInteger)widgetType;

+ (NSInteger)convertToWidgetTypeFromTypeName:(NSString *)typeName;

- (NSString *)getTypeName;

@end

NS_ASSUME_NONNULL_END
