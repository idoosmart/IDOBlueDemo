//
//  IDOBPManager.h
//  IDOBlueProtocol
//
//  Created by hedongyang on 2022/7/27.
//  Copyright © 2022 何东阳. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 血压校准状态类型
 */
typedef NS_ENUM(NSInteger, IDO_BP_CALIBRATION_STATUS_CODE) {
    //血压校准完成成功
    IDO_BP_CALIBRATION_COMPLETE_SUCCESS = 0,
    //固件血压校准失败(固件退出测量界面/检测失败/未佩戴)
    IDO_BP_CALIBRATION_FAILED = 1,
    //开始获取特性向量信息
    IDO_BP_CALIBRATION_GET_PROPERTY_VECTOR_INFO = 2,
    //获取特性向量信息失败
    IDO_BP_CALIBRATION_GET_PROPERTY_VECTOR_INFO_FAILED = 3,
    //没有特性向量信息
    IDO_BP_CALIBRATION_NO_PROPERTY_VECTOR_INFO = 4,
    //开始操作校准成功
    IDO_BP_CALIBRATION_OPERATE_START_SUCCESS = 5,
    //开始操作校准失败
    IDO_BP_CALIBRATION_OPERATE_START_FAILED = 6,
    //停止操作校准成功
    IDO_BP_CALIBRATION_OPERATE_STOP_SUCCESS = 7,
    //停止操作校准失败
    IDO_BP_CALIBRATION_OPERATE_STOP_FAILED = 8
};

/**
 * 血压校准操作类型
 */
typedef NS_ENUM(NSInteger, IDO_BP_CALIBRATION_OPERATE) {
    //血压校准开始
    IDO_BP_CALIBRATION_OPERATE_START = 1,
    //血压校准停止
    IDO_BP_CALIBRATION_OPERATE_STOP = 2,
    //获取特性向量信息
    IDO_BP_CALIBRATION_OPERATE_GET_VECTOR_INFO = 3
};

NS_ASSUME_NONNULL_BEGIN

@protocol IDOBPManagerDelegate <NSObject>
/**
 血压校准状态回调
 */
- (void)bloodPressureCalibrationStatus:(IDO_BP_CALIBRATION_STATUS_CODE)statusCode;
/**
 特性向量信息回调和原始数据存放路径回调
 */
- (void)bloodPressureCalibrationVectorInfo:(NSDictionary *)vectorInfo
                                  filePath:(NSString *)filePath;
@end

@interface IDOBPManager : NSObject
//代理对象
@property (nonatomic,assign) id<IDOBPManagerDelegate> delegate;
//操作类型
@property (nonatomic,assign,readonly) IDO_BP_CALIBRATION_OPERATE operateType;
//血压校准原始数据文件存放路径
@property (nonatomic,copy,readonly) NSString * filePath;
//是否支持新血压校准功能
@property (nonatomic,assign,readonly) BOOL supportBloodPressureCalibration;
//单例对象
+ (instancetype)shareInstance;
//操作血压校准
+ (void)operateBloodPressureCalibration:(IDO_BP_CALIBRATION_OPERATE)operate;

@end

NS_ASSUME_NONNULL_END
