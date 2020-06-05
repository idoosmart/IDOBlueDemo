//
//  IDOSClassModel.h
//  IDOSmartUIKit
//
//  Created by 鲁鲁骁 on 2019/12/26.
//  Copyright © 2019 农大浒. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IDOSClassModel : NSObject
@property (nonatomic,strong) NSString *areacode; // 地区编号

@property (nonatomic,strong) NSString *areaname; // 地区名称

@property (nonatomic,strong) NSString *datalevel; //数据级别：1省，2市，3区县

@property (nonatomic,strong) NSString *parentcode; //上级地区编号
@end

NS_ASSUME_NONNULL_END
