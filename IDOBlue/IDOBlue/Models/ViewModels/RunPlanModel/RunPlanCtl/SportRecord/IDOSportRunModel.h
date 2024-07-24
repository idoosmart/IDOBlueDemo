//
//  IDOSportRunModel.h
//  AFNetworking
//
//  Created by mac2019 on 2022/5/24.
//

#import <Foundation/Foundation.h>
#import <IDOBluetooth/IDOBluetooth.h>
#import <IDOBlueUpdate/IDOBlueUpdate.h>
#import <IDOBlueProtocol/IDOBlueProtocol.h>
#import "IDOSportSettingModel.h"
#import "IDOCoreSportRecordModel.h"
#import "IDOSRailModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface IDOSportRunModel : NSObject

+ (NSDate *)getRecoverTime:(NSInteger)recoverTime;

+ (IDOCoreSportRecordModel *)exchangeToResource:(IDODataExchangeModel *)exchageModel
                                     timestamp:(NSInteger)timestamp
                                        target:(IDOSportSettingModel *)targetModel
                                      hrValues:(NSArray  *)hrValues
                                     sourceType:(IDOSportSourceType)sourceType
                                     railArray:(NSArray <IDOSRailModel *>*)railArray
                                   kmPaceArray:(NSMutableArray *)kmPaceArray
                                 milePaceArray:(NSMutableArray *)milePaceArray
                                    stepsArray:(NSMutableArray *)stepsArray
                                         userId:(NSString *)userId;


/**
 把跑步换的数据转成业务数据库
 */
+ (IDOCoreSportRecordModel *)v3_exchangeModelToResource:(IDOV3DataExchangeModel *)exchageModel
                                              timestamp:(NSInteger)timestamp
                                               hrValues:(NSArray  *)hrValues
                                             sourceType:(IDOSportSourceType)sourceType
                                              railArray:(NSArray <IDOSRailModel *>*)railArray
                                                 userId:(NSString *)userId;




@end

NS_ASSUME_NONNULL_END
