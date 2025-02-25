//
//  NewDialJsonFuncLibModel.m
//  IDOBlue
//
//  Created by cyf on 2025/2/24.
//  Copyright © 2025 hedongyang. All rights reserved.
//

#import "NewDialJsonFuncLibModel.h"
#import "YYModel.h"
#import "NewDialJsonFuncListLibModel.h"
#import "NewDialJsonStylesFuncsLibModel.h"
#import "NewDialJsonFuncListItemLibModel.h"
#pragma mark - 功能表的对象

@implementation NewDialJsonFuncLibModel

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{
        @"list": [NewDialJsonFuncListLibModel class],
        @"defaultFuncs": [NewDialJsonStylesFuncsLibModel class],
    };
}

- (NewDialJsonFuncListItemLibModel *)getFuncsLibModelWithName:(NSString *)funcName{
    for (NSInteger i = 0; i < self.list.count; i++) {
        NewDialJsonFuncListLibModel *listObj = self.list[i];
        for (NSInteger j = 0; j < listObj.items.count; j++) {
            NewDialJsonFuncListItemLibModel *itemObj = listObj.items[j];
            if ([itemObj.type isEqualToString:funcName]) {
                return itemObj;
            }
        }
    }
    return nil;
}

@end
