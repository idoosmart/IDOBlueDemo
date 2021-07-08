//
//  IDOWatchDialInfoModel.h
//  IDOBluetoothInternal
//
//  Created by 何东阳 on 2019/8/21.
//  Copyright © 2019 何东阳. All rights reserved.
//

#if __has_include(<IDOBlueProtocol/IDOBlueProtocol.h>)
#else
#import "IDOBluetoothBaseModel.h"
#endif

@interface IDOWatchScreenInfoModel : IDOBluetoothBaseModel
/**
 表盘家族名称 | family name
 */
@property (nonatomic,copy) NSString * familyName;
/**
 宽度 | width
 */
@property (nonatomic,assign) NSInteger width;
/**
 高度 | height
 */
@property (nonatomic,assign) NSInteger height;
/**
 颜色格式 | color format
 */
@property (nonatomic,assign) NSInteger colorFormat;
/**
 尺寸 * 100 | size * 100
 */
@property (nonatomic,assign) NSInteger size;

/**
 压缩块大小 | block size
 */
@property (nonatomic,assign) NSInteger blockSize;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOWatchScreenInfoModel
 */
+ (IDOWatchScreenInfoModel *)currentModel;

@end

@interface IDOWatchDialInfoItemModel : IDOBluetoothBaseModel
/**
 表盘名称（唯一标示） | file name (only sign)
 */
@property (nonatomic,copy) NSString * fileName;

/**
 * 操作 0x00:查询正在使用表盘 0x01:设置表盘 0x02:删除表盘
 * Operation 0x00: query is using the dial 0x01: set the dial 0x02: delete the dial
 */
@property (nonatomic,assign) NSInteger operate;

@end


@interface IDOWatchDialInfoModel : IDOBluetoothBaseModel
/**
 * 文件个数
 * file count
 */
@property (nonatomic,assign) NSInteger fileCount;
/**
 * 剩余空间 KB
 * remaining Space
 */
@property (nonatomic,assign) NSInteger remainingSpace DEPRECATED_MSG_ATTRIBUTE("this attribute is discarded");

/**
 * 可用文件个数
 * available files count
 */
@property (nonatomic,assign) NSInteger availableCount;

/**
 * 文件版本号
 * file version
 */
@property (nonatomic,assign) NSInteger fileVersion;

/**
 * 单个文件最大size  KB
 * file max size
 */
@property (nonatomic,assign) NSInteger fileMaxSize;
/**
 *  当前设置的表盘名称
 *  name of the dial currently set
*/
@property (nonatomic,copy) NSString * currentDialName;
/**
 * 当前手表所有表盘信息
 * Current bracelet all dial information
 */
@property (nonatomic,strong) NSArray <IDOWatchDialInfoItemModel *>* dialArray;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOWatchDialInfoModel
 */
+ (IDOWatchDialInfoModel *)currentModel;

@end

#pragma mark ======= v3 watch dial info Command =======

@interface IDOV3WatchDialInfoItemModel : IDOWatchDialInfoItemModel

/**
 * 1：普通表盘； 2：壁纸表盘； 3：云表盘
 * 1: Normal dial; 2: Wallpaper dial; 3: Cloud dial
 */
@property (nonatomic,assign) NSInteger type;

/**
 * 当前的表盘版本号 云表盘起作用
 * watch version
 */
@property (nonatomic,assign) NSInteger watchVersion;

@end


@interface IDOV3WatchDialInfoModel : IDOBluetoothBaseModel
/**
 * 本地表盘的总个数
 * local watch number
 */
@property (nonatomic,assign) NSInteger localWatchNum;
/**
 * 云端表盘的总个数
 * cloud watch number
 */
@property (nonatomic,assign) NSInteger cloudWatchNum;
/**
 * 壁纸表盘的总个数
 * wallpaper watch number
 */
@property (nonatomic,assign) NSInteger wallpaperWatchNum;
/**
 * 云端表盘的已经使用个数
 * used cloud watch number
 */
@property (nonatomic,assign) NSInteger useCloudWatchNum;
/**
 * 壁纸表盘的已经使用个数
 * used wallpaper watch number
 */
@property (nonatomic,assign) NSInteger useWallpaperWatchNum;

/**
 *  当前设置的表盘名称
 *  current watch name
*/
@property (nonatomic,copy) NSString * currentWatchName;

/**
 * 框架版本号 从1开始
 * watch frame version
 */
@property (nonatomic,assign) NSInteger watchFrameVersion;

/**
 * 单个文件最大size  KB
 * file max size
 */
@property (nonatomic,assign) NSInteger fileMaxSize;

/**
 * 当前手表所有表盘数量
 * watch list number
 */
@property (nonatomic,assign) NSInteger watchListNum;

/**
 * 当前手表所有表盘信息
 * Current bracelet all dial information
 */
@property (nonatomic,strong) NSArray <IDOV3WatchDialInfoItemModel *>* dialArray;

/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOWatchDialInfoModel
 */
+ (IDOV3WatchDialInfoModel *)currentModel;

@end


#pragma mark ======= v3 wallpaper dial info Command =======

@interface IDOV3WallpaperDialInfoModel : IDOBluetoothBaseModel
/**
 *操作 0x00:查询, 0x01:设置, 0x02: 删除壁纸表盘
 *Operation 0x00: query, 0x01: set, 0x02: delete wallpaper dial
 */
@property (nonatomic,assign) NSInteger operate;
/**
 *0:无效 1:表盘（上左）参考九宫格 2:表盘（上中）3:表盘（上右) 4:表盘（中左）
 *5:表盘（中中）6:表盘（中右）7:表盘（下左）8:表盘（下中）9:表盘（下右)
 *0: Invalid 1: Dial (upper left) refer to Jiugongge 2: Dial (upper center) 3: Dial (upper right) 4: Dial (middle left)
 *5: Dial (middle left) 6: Dial (middle right) 7: Dial (Bottom left) 8: dial (bottom middle) 9: dial (bottom right)
 */
@property (nonatomic,assign) NSInteger location;
/**
 *0:全部显示 1:隐藏子控件(图标和数字)
 *0: Show all 1: Hide sub-controls (icons and numbers)
 */
@property (nonatomic,assign) NSInteger hideType;
/**
 *0:无效 1:星期/日期 2:步数 3:距离 4:卡路里 5:心率 6:电量
 *1: Day of the week/date 2: Number of steps 3: Distance 4: Calories 5: Heart rate 6: Battery
 */
@property (nonatomic,assign) NSInteger widgetType;
/**
 *白色: #FFFFFF 黑色:#000000 红色:#FC1E58 棕色:#FF9501 天蓝色:#0091FF 青绿色:#44D7B6
 *White: #FFFFFF Black: #000000 Red: #FC1E58 Brown: #FF9501 Sky blue: #0091FF Turquoise: #44D7B6
 */
@property (nonatomic,copy) NSString * timeColor;
/**
 *白色: #FFFFFF 黑色:#000000 红色:#FC1E58 棕色:#FF9501 天蓝色:#0091FF 青绿色:#44D7B6
 *White: #FFFFFF Black: #000000 Red: #FC1E58 Brown: #FF9501 Sky blue: #0091FF Turquoise: #44D7B6
 */
@property (nonatomic,copy) NSString * widgetIconColor;
/**
 *白色: #FFFFFF 黑色:#000000 红色:#FC1E58 棕色:#FF9501 天蓝色:#0091FF 青绿色:#44D7B6
 *White: #FFFFFF Black: #000000 Red: #FC1E58 Brown: #FF9501 Sky blue: #0091FF Turquoise: #44D7B6
 */
@property (nonatomic,copy) NSString * widgetNumColor;
/**
 * @brief 查询数据库,如果查询不到初始化新的model对象
 * Query the database, if the query does not initialize a new model object
 * @return IDOV3WallpaperDialInfoModel
 */
+ (IDOV3WallpaperDialInfoModel *)currentModel;

@end
