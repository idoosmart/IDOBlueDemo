//
//  NewDialJsonFuncLibModel.h
//  IDOBlue
//
//  Created by cyf on 2025/2/24.
//  Copyright © 2025 hedongyang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
#pragma mark - 功能表的对象
@class NewDialJsonFuncListLibModel;
@class NewDialJsonStylesFuncsLibModel;
@class NewDialJsonFuncListItemLibModel;
@interface NewDialJsonFuncLibModel: NSObject

///是否支持根据选中的颜色 子功能项button 来渲染前景色
@property (nonatomic, assign) BOOL canChangeColor;


@property (nonatomic,   copy) NSString *name;//名字 备用

@property (nonatomic,   copy) NSString *version;//功能表版本  备用

//0 不支持，1 支持
@property (nonatomic, assign) BOOL isSupportClose;//是否支持关闭按钮

@property (nonatomic, strong) NSArray<NewDialJsonFuncListLibModel *>  *list;

@property (nonatomic, strong) NSArray<NewDialJsonStylesFuncsLibModel *> *defaultFuncs;

- (NewDialJsonFuncListItemLibModel *)getFuncsLibModelWithName:(NSString *)funcName;

@end
NS_ASSUME_NONNULL_END
