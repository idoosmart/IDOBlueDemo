//
//  NewDialInstallLibModel.m
//  IDOBlue
//
//  Created by cyf on 2025/2/25.
//  Copyright © 2025 hedongyang. All rights reserved.
//

#import "NewDialInstallLibModel.h"
#import "YYModel.h"

@implementation NewDialInstallLibModel

- (instancetype)init{
    self = [super init];
    if (self) {
        self.enabled = YES;
    }
    return self;
}

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    return @{
        @"dialInfo": @[@"description", @"dialInfo"],
    };
}

@end
