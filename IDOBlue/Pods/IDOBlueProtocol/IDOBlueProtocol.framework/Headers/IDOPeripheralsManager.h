//
//  IDOPeripheralsManager.h
//  IDOBlueProtocol
//
//  Created by huangkunhe on 2022/9/26.
//  Copyright © 2022 何东阳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IDOBlueProtocol/IDOPeripheralsInfoModel.h>

NS_ASSUME_NONNULL_BEGIN

@protocol IDOPeripheralsManagerDelegate <NSObject>

//固件外设信息返回
- (void)getPeripheralsInfoData:(IDOPeripheralsInfoModel *)model
                      errorCode:(int)errorCode;

//操作发送固件外设信息成功失败回调
//operateType=> 1:app通过指令下发保存的外设信息给固件；2:app下发绑定设备列表；3:app下发体脂秤model映射表
- (void)operatePeripheralsCompleteWithErrorCode:(int)errorCode
                         operateType:(int)operateType;
@end


@interface IDOPeripheralsManager : NSObject

//单例
+ (instancetype)shareInstance;

//代理对象
@property (nonatomic,weak)id<IDOPeripheralsManagerDelegate> delegate;

//获取固件外设信息
+ (BOOL)getPeripheralsInfoData;

//app通过指令下发保存的外设信息给固件
+ (BOOL)sendPeripheralsInfoData:(IDOPeripheralsSetDataModel *)models;

//app下发绑定设备列表
+ (BOOL)sendBindDeviceInfoData:(IDOPeripheralsBindModel *)models;

//app下发体脂秤model映射表
+ (BOOL)sendScalesModelMapTableData:(IDOPeripheralsMapTableModel *)models;

@end

NS_ASSUME_NONNULL_END
