//
//  IDOSyncHRVDataModel.h
//  IDOBlueProtocol
//
//  Created by huangkunhe on 2023/3/28.
//  Copyright © 2023 何东阳. All rights reserved.
//

#if __has_include(<IDOBlueProtocol/IDOBlueProtocol.h>)
#else
#import "IDOBluetoothBaseModel.h"
#endif

NS_ASSUME_NONNULL_BEGIN
@interface IDOSyncHRVDataItemModel : IDOBluetoothBaseModel
/**
 偏移量
 */
@property (nonatomic,assign) NSInteger minuteOffset;
/**
 数值
 */
@property (nonatomic,assign) NSInteger hrvVal;

@end

@interface IDOSyncHRVDataModel : IDOBluetoothBaseModel
/**
 年份
 */
@property (nonatomic,assign) NSInteger year;
/**
 月份
 */
@property (nonatomic,assign) NSInteger month;
/**
 日期
 */
@property (nonatomic,assign) NSInteger day;
/**
 起始时间 单位秒，基于0点的偏移
 */
@property (nonatomic,assign) NSInteger startTime;
/**
 数据量
 */
@property (nonatomic,copy) NSString * dataSize;
/**
 日期时间戳
 */
@property (nonatomic,copy) NSString * dateStr;
/**
 个数
 */
@property (nonatomic,assign) NSInteger itemsCount;

/**
 IDOSyncHRVDataItemModel items
 */
@property (nonatomic,copy) NSArray <IDOSyncHRVDataItemModel *>* items;

/**
 * 将json数据转模型数据 | Convert json data to model data
 * @param jsonString  数据
 */
+(IDOSyncHRVDataModel*)hrvDataJsonStringToObjectModel:(NSString*)jsonString;

@end

NS_ASSUME_NONNULL_END

