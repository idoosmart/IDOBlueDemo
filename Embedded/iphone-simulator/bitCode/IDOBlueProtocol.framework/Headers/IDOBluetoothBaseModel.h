//
//  IDOBluetoothInfo.h
//  VeryfitSDK
//
//  Created by hedongyang on 2018/6/13.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDOBluetoothBaseModel : NSObject

@property (copy,readonly,nonatomic,nullable) NSArray<NSString *>  * originColumnNames;
@property (copy,readonly,nonatomic,nullable) NSArray<NSString *>  * columnNames;
@property (copy,readonly,nonatomic,nullable) NSArray<NSString *>  * columnTypes;

@property (nonatomic,assign) NSInteger pk;

@property (nonatomic,copy,nullable) NSString * macAddr;
@property (nonatomic,copy,nullable) NSString * uuidStr;
@property (nonatomic,copy,nullable) NSString * deviceId;
@property (nonatomic,copy,nullable) NSString * version;
@property (nonatomic,copy,nullable) NSString * deviceName;
@property (nonatomic,copy,nullable) NSString * userId;
@property (nonatomic,assign) NSInteger migrationState;

/**
 * @brief 数据引擎为model赋值 | Assigned to the model
 */
- (void)assignment;

/**
 * @brief model创建表 | Create a table
 * @return  是 或 否 | yes or no
 */
- (BOOL)createTable;

/**
 * @brief model 单个数据存储 | Single data storage
 * @return  是 或 否 | yes or no
 */
- (BOOL)save;

/**
 * @brief model 单个数据更新 | Single data update
 * @return  是 或 否 | yes or no
 */
- (BOOL)update;

/**
 * @brief model 单个数据存储或更新 | Single data storage or update
 * @return  是 或 否 | yes or no
 */
- (BOOL)saveOrUpdate;

/**
 * @brief  model 单个数据删除 (*不建议使用) | Model single data deletion (*Not recommended)
 * @return  是 或 否 | yes or no
 */
- (BOOL)del;

/**
 * @brief model 通过Mac地址查询单个数据 多用于蓝牙设置查询
 * The model queries individual data by Mac address, which is mostly used for bluetooth setting query
 * @return 根据设备ID 查询获取最后一个model 不存在会初始化一个新的对象
 * Getting the last model based on the device ID query does not initialize a new object
 */
+ (IDOBluetoothBaseModel *_Nullable)queryCurrentModel;

/**
 * @brief 自定义查询语句 | Custom query statements
 * @param sqlStr 查询语句 | Database query for example @"WHERE mac_addr = '%@'"
 * @return model 集合 | Array
 */
+ (NSArray <IDOBluetoothBaseModel *>*_Nullable)queryModelsWithSqlStr:(NSString *_Nullable)sqlStr;

/**
 * @brief 自定义删除语句 | Custom delete statement
 * @param sqlStr 删除语句 | Delete sqlStr for example @"WHERE mac_addr = '%@'"
 * @return yes or no
 */
+ (BOOL)deleteModelsWithSqlStr:(NSString *_Nullable)sqlStr;

/**
 * @brief 批量存储或更新model | Bulk store or update models
 * @param models model 集合 | Array
 * @return 是 或 否 | yes or no
 */

+ (BOOL)saveOrUpdateModels:(NSArray <IDOBluetoothBaseModel *>*_Nullable)models;

/**
 * @brief 批量存储model | Bulk store  models
 * @param models model 集合 | Array
 * @return 是 或 否 | yes or no
 */
+ (BOOL)saveModels:(NSArray <IDOBluetoothBaseModel *>*_Nullable)models;

/**
 * @brief 批量删除model (*不建议使用) | Delete models in bulk (*Not recommended)
 * @param models model 集合 | Array
 * @return 是 或 否 | yes or no
 */
+ (BOOL)deleteModels:(NSArray <IDOBluetoothBaseModel *>*_Nullable)models;

/**
 * @brief 删除对应的数据库表数据 (*不建议使用) | Delete the corresponding database table data (*Not recommended)
 * @return 是 或 否 | yes or no
 */
+ (BOOL)deleteCurrentTable;

@end
