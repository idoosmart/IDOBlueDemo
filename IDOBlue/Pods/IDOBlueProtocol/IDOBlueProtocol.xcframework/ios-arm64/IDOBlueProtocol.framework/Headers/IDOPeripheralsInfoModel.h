//
//  IDOPeripheralsInfoModel.h
//  IDOBlueProtocol
//
//  Created by huangkunhe on 2022/9/26.
//  Copyright © 2022 何东阳. All rights reserved.
//

#import <IDOBlueProtocol/IDOBluetoothBaseModel.h>

NS_ASSUME_NONNULL_BEGIN

//数据基础信息
@interface IDOPeripheralsBaseModel : NSObject
/**
 距离1970的偏移 单位秒
 */
@property (nonatomic,assign) NSInteger timeStamp;

@property (nonatomic,assign) NSInteger deviceType;
/**
 用于标识称的型号
 */
@property (nonatomic,copy) NSString* deviceModelId;
/**
 用于标识称的编号
 */
@property (nonatomic,copy) NSString* mac;

@end


//体脂秤外设信息详情个数
@interface IDObfInfoModel : NSObject
/**
 数据基础信息
 */
@property (nonatomic,strong) IDOPeripheralsBaseModel *peripheralsBaseModel;

/**
 体重单位 0:kg 1:lb 2:st 3:st+lb（kg两位小数、lb一位小数、st两位小数、st+lb xx:xx.x ）
 */
@property (nonatomic,assign) NSInteger weightUnit;
/**
 体重
 */
@property (nonatomic,assign) NSInteger weight;
/**
 用于标识称的型号 YKB内部型号
 */
@property (nonatomic,copy) NSString* modelId;
/**
 厂家数据标识 app根据该数组算出体脂率 然后通过指令下发体脂率数据给固件
 */
@property (nonatomic,copy) NSString* hmac;

@end

//卷尺外设信息详情
@interface IDOTapelineInfoModel : NSObject
//数据基础信息
@property (nonatomic,strong) IDOPeripheralsBaseModel *peripheralsBaseModel;
@property (nonatomic,assign) NSInteger tapelineUnit;//卷尺单位 0:cm 1:inch
@property (nonatomic,assign) NSInteger whr;//腰臀比
@property (nonatomic,assign) NSInteger sizeNeck;//颈
@property (nonatomic,assign) NSInteger sizeShoulder;//肩
@property (nonatomic,assign) NSInteger sizeLeftArm;//左臂
@property (nonatomic,assign) NSInteger sizeRightArm;//右臂
@property (nonatomic,assign) NSInteger sizeChest;//胸部
@property (nonatomic,assign) NSInteger sizeLoin;//腰部
@property (nonatomic,assign) NSInteger sizeAbdomen;//腹部
@property (nonatomic,assign) NSInteger sizeHip;//臀部
@property (nonatomic,assign) NSInteger sizeLeftThigh;//左大腿
@property (nonatomic,assign) NSInteger sizeRightThigh;//右大腿
@property (nonatomic,assign) NSInteger sizeLeftShin;//左小腿
@property (nonatomic,assign) NSInteger sizeRightShin; //右小腿
@end

//血压计外设信息
@interface IDOTurgoscopeInfoModel : NSObject
//数据基础信息
@property (nonatomic,strong) IDOPeripheralsBaseModel *peripheralsBaseModel;
@property (nonatomic,assign) NSInteger sbp;//收缩压
@property (nonatomic,assign) NSInteger dbp;//舒张压
@end

//营养秤外设信息
@interface IDONsInfoModel : NSObject
//数据基础信息
@property (nonatomic,strong) IDOPeripheralsBaseModel *peripheralsBaseModel;
@property (nonatomic,assign) NSInteger cal; //卡路里
@property (nonatomic,assign) NSInteger protein;//蛋白质
@property (nonatomic,assign) NSInteger carbohydrates;//碳水化合物
@property (nonatomic,assign) NSInteger totalSugar;//总糖分
@property (nonatomic,assign) NSInteger dietaryFiber;//膳食纤维
@property (nonatomic,assign) NSInteger totalFat;//总脂肪
@property (nonatomic,assign) NSInteger microelementCa;//钙元素
@property (nonatomic,assign) NSInteger microelementFe;//铁元素
@property (nonatomic,assign) NSInteger microelementMag;//镁元素
@property (nonatomic,assign) NSInteger microelementP;//磷元素
@property (nonatomic,assign) NSInteger microelementK;//钾元素
@property (nonatomic,assign) NSInteger microelementNa;//钠元素
@property (nonatomic,assign) NSInteger microelementZn;//锌元素
@property (nonatomic,assign) NSInteger microelementCu;//铜元素
@property (nonatomic,assign) NSInteger microelementMn;//锰元素
@property (nonatomic,assign) NSInteger microelementSe;//硒元素
@property (nonatomic,assign) NSInteger vitaminA; //维生素a
@property (nonatomic,assign) NSInteger vitaminE; //维生素e
@property (nonatomic,assign) NSInteger vitaminC; //维生素c
@property (nonatomic,assign) NSInteger vitaminD; //维生素d
@property (nonatomic,assign) NSInteger vitaminB6; //维生素b6
@property (nonatomic,assign) NSInteger vitaminB12;//维生素b12
@property (nonatomic,assign) NSInteger niacin;//烟酸
@property (nonatomic,assign) NSInteger cholesterol;//胆固醇
@property (nonatomic,assign) NSInteger prepalin;//视黄醇
@end

//绊绳结构
@interface IDORstumbleInfoModel : NSObject
@property (nonatomic,assign) NSInteger jumpNums;    //单次连跳个数
@property (nonatomic,assign) NSInteger costTime;    //单次连跳时长
@end

//跳绳外设信息
@interface IDORsInfoModel : NSObject
//数据基础信息
@property (nonatomic,strong) IDOPeripheralsBaseModel *peripheralsBaseModel;
@property (nonatomic,copy) NSArray<IDORstumbleInfoModel *> * rstumbleInfoItems;
@property (nonatomic,assign) NSInteger costTime;         //跳绳时长
@property (nonatomic,assign) NSInteger jumpNums;         //跳绳个数
@property (nonatomic,assign) NSInteger avgSpeed;         //平均速度 个数/分钟  分钟从秒数算四舍五入
@property (nonatomic,assign) NSInteger fastSpeed;        //最快速度
@property (nonatomic,assign) NSInteger stumbleNums;      //绊绳次数
@property (nonatomic,assign) NSInteger maxCotinuousJump; //最大连跳次数
@property (nonatomic,assign) NSInteger cal;              //消耗卡路卡
@property (nonatomic,assign) NSInteger motionType;       // 运动类型: 1 自由跳 2 倒计时 3倒计数
@end

//跑步机外设信息(暂不开发)
@interface IDORmInfoModel : NSObject
//数据基础信息
@property (nonatomic,strong) IDOPeripheralsBaseModel *peripheralsBaseModel;
@property (nonatomic,assign) NSInteger mileageUnit; // 跑步里程 0:km 1:m
@property (nonatomic,assign) NSInteger mileage;  //里程数
@property (nonatomic,assign) NSInteger burnCal; //消耗的卡路里
@end


@interface IDOPeripheralsInfoModel : IDOBluetoothBaseModel

//体脂秤外设信息详情个数
@property (nonatomic,assign) NSInteger bfInfoNum;

//卷尺外设信息详情个数
@property (nonatomic,assign) NSInteger tapelineInfoNum;

//血压计外设信息详情个数
@property (nonatomic,assign) NSInteger turgosecopeInfoNum;

//营养秤外设信息详情个数
@property (nonatomic,assign) NSInteger nsInfoNum;

//跳绳外设信息详情个数
@property (nonatomic,assign) NSInteger rsInfoNum;

//跑步机外设信息详情个数
@property (nonatomic,assign) NSInteger rmInfoNum;

/**
 体脂秤外设信息详情 集合
 */
@property (nonatomic,copy) NSArray<IDObfInfoModel *> * bfInfoItems;
/**
 卷尺外设信息详情 集合
 */
@property (nonatomic,copy) NSArray<IDOTapelineInfoModel *> * tapelineInfoItems;
/**
 血压计外设信息 集合
 */
@property (nonatomic,copy) NSArray<IDOTurgoscopeInfoModel *> * turgoscopeInfoItems;
/**
 营养秤外设信息 集合
 */
@property (nonatomic,copy) NSArray<IDONsInfoModel *> * nsInfoItems;
/**
 跳绳外设信息 集合
 */
@property (nonatomic,copy) NSArray<IDORsInfoModel *> * rsInfoItems;
/**
 跳绳外设信息 集合
 */
@property (nonatomic,copy) NSArray<IDORmInfoModel *> * rmInfoItems;
@end


#pragma send Data app下发外设信息卡片给固件
//******************************************* send Data *******************************
//头部
@interface IDOPeripheralsSetHeadModel : NSObject
@property (nonatomic,assign) NSInteger cardInfoNum;//卡片信息个数, 如：绑定了三张卡片，这里传3
@end

//外设卡片信息
@interface IDOPeripheralsDeviceDataModel : NSObject
@property (nonatomic,assign) NSInteger timeStamp;   // 距离1970年的偏移 单位秒
/*
 //在数据类型是体重的时候，0:无效 1:kg 2:lb 3:st 4:lb+s
 //在数据类型是长度的时候，0:无效 1:cm 2:inch
 //在数据类型是里程的时候，0:无效 1:km 2:m
 */
@property (nonatomic,assign) NSInteger dataUnit;     // 根据数据数据类型变化
@property (nonatomic,assign) NSInteger dataScale;    // 0:不放大 1:放大10倍  2:放大100倍  3:缩小10倍  4:缩小100倍
@property (nonatomic,assign) NSInteger dataType;    // 数据类型 如：0:体重 1:体脂率，详细见底部表
@property (nonatomic,assign) NSInteger dataValue;   // 数值
@property (nonatomic,assign) NSInteger deviceType;   // 设备类型见表 1体重秤 2体脂秤 预留
@property (nonatomic,copy)   NSString* mac;          //用于标识称的编号,长度12
@end

//用户信息信息
@interface IDOPeripheralsUserModel : NSObject
@property (nonatomic,assign) NSInteger gender;  //性别 1:男 0:女 -1:未选填性别
@property (nonatomic,assign) NSInteger height; //身高 以cm为单位的数值，放大10倍传输
@property (nonatomic,assign) NSInteger weight;//体重 以kg为单位的数值，放大100倍传输
@property (nonatomic,assign) NSInteger personType;//运动员模式 "0"非运动员 "1"运动员
@property (nonatomic,assign) NSInteger weightUnit;//体重单位 1:kg, 2:lb, 3:st+lb, 4:st 跟随单位设置指令的单位下发
@property (nonatomic,assign) NSInteger heightUnit;//身高单位 0:cm, 1:inch 跟随单位设置指令的单位下发
@end

@interface IDOPeripheralsSetDataModel : NSObject
@property (nonatomic,assign) NSInteger version; //协议版本号 从1开始
@property (nonatomic,strong) IDOPeripheralsSetHeadModel* headmodel;
@property (nonatomic,strong) IDOPeripheralsUserModel* userModel;
@property (nonatomic,copy) NSArray<IDOPeripheralsDeviceDataModel *> * deviceInfoItems;
@end


#pragma bind Data app下发绑定设备列表
//******************************************* bind Data *******************************
@interface IDOPeripheralsBindItemModel : NSObject
@property (nonatomic,copy) NSString* mac; //12个字符，即6个字节
@property (nonatomic,copy) NSString* deviceModelId;//40个字符，即20个字节
@end

@interface IDOPeripheralsBindModel : NSObject
@property (nonatomic,assign) NSInteger version; //协议版本号 从1开始
@property (nonatomic,assign) NSInteger deviceTableNum; //绑定设备个数
@property (nonatomic,copy) NSArray<IDOPeripheralsBindItemModel *> * deviceTableItems;
@end

#pragma MapTable Data app下发体脂秤model映射表
//******************************************* MapTable Data *******************************
@interface IDOPeripheralsMapTableItemModel : NSObject
@property (nonatomic,copy) NSString* modelId; //4个字符，即2个字节 (SIZE_MODEL_ID)
@property (nonatomic,copy) NSString* deviceId;//150个字符，即75个字节 (MAX_LEN_DEVICE_ID)
@end

@interface IDOPeripheralsMapTableModel : NSObject
@property (nonatomic,assign) NSInteger version; //协议版本号 从1开始
@property (nonatomic,assign) NSInteger tableNum; //映射内容详情个数
@property (nonatomic,copy) NSArray<IDOPeripheralsMapTableItemModel *> * mapTableItems;
@end

NS_ASSUME_NONNULL_END
