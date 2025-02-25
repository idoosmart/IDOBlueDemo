//
//  IDOWallpaperCloudLibModel.h
//  IDOBlueProtocol
//
//  Created by huangkunhe on 2023/2/7.
//  Copyright © 2023 何东阳. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kDefaultCloseFuncKey        @"kDefaultCloseFuncKey"
#define kDefaultCloseFuncItemKey    @"kDefaultCloseFuncItemKey"

@class NewDialJsonSelectedLibModel;
@class NewDialJsonBackgroundLibModel;
@class NewDialJsonFuncLibModel;
@class NewDialJsonClockLibModel;
@class NewDialJsonStylesListLibModel;
@class NewDialJsonPaletteLibModel;
@class NewDialJsonLocationLibModel;
@class NewDialJsonFunctionListLibModel;
@class DialJsonTimeListLibModel;
@class NewDialJsonAppLibModel;
@class NewDialJsonCountTimerLibModel;
@class NewDialWallpaperLibModel;
@class NewDialJsonFuncListLibModel;
@class NewDialJsonFuncListItemLibModel;

@interface WallpaperCloudLibModel : NSObject

@property (nonatomic, copy) NSString *dialZipName;//表盘包名称

@property (nonatomic, copy) NSString *version;//表盘版本

@property (nonatomic,strong) NSNumber *dailType;//表盘类型

@property (nonatomic,strong) NSDictionary *dialpreview;//头部显示的预览图

@property (nonatomic,strong) NSArray *dialStyle;//表盘样式图

@property (nonatomic,strong) NewDialJsonSelectedLibModel *select;//默认选中的样式图；

@property (nonatomic,strong) NSArray<NSDictionary *>    *colors;//颜色值

@property (nonatomic,strong) NSArray *stylemodul;//

@property (nonatomic,strong) NSDictionary *outFile;//与固件相关的字段

///表盘的bg的大小
@property (nonatomic, assign) CGSize imageBgsize;

///表盘的preview的大小
@property (nonatomic, assign) CGSize imagePreviewize;


@property (nonatomic, assign) CGSize imagegroupsize;

@property (nonatomic,strong) NSArray<NewDialJsonBackgroundLibModel *> *backgrounds;//背景图

@property (nonatomic,strong) NewDialJsonFuncLibModel *funcInfo;//功能对象

@property (nonatomic,strong) NewDialJsonClockLibModel *clock;//功能对象

@property (nonatomic,strong) NSArray<NewDialJsonStylesListLibModel *> *styles;//样式表

@property (nonatomic,strong) NSArray<NewDialJsonPaletteLibModel *> *palettes;//调色板

@property (nonatomic,strong) NSArray<NewDialJsonLocationLibModel *> *locations;//样式表

@property (nonatomic, assign) NSInteger function_support;

@property (nonatomic, assign) NSInteger function_support_new;

@property (nonatomic,strong) NSArray<NewDialJsonFunctionListLibModel *> *function_list;

@property (nonatomic,strong) NSArray<DialJsonTimeListLibModel *> *time_widget_list;

/// 2.1.0 添加
@property (nonatomic,strong) NewDialJsonAppLibModel *app;//功能对象

/// 2.1.1 添加
@property (nonatomic,strong) NSArray<NewDialJsonCountTimerLibModel *> *counterTimers;//倒计时

///2.2.0 添加 壁纸云表盘的配置
@property (nonatomic,strong) NewDialWallpaperLibModel *cloudWallpaper;

@property (nonatomic,assign) CGFloat previewRadius; ;// GTX12 新增

///是否允许圆角
@property (nonatomic,assign) BOOL previewIsNeedBorder;

///边框颜色
@property (nonatomic,strong) NSString *previewBorderColor;

///边框线宽
@property (nonatomic,assign) CGFloat previewBorderWidth;

///圆角大小
@property (nonatomic,assign) CGFloat previewBorderRadius;

///获取所有的功能表
- (NSArray<NewDialJsonFuncListLibModel *> *)getAllFunction:(NSInteger)funcIndex;

///获取所有的样式表的图片
- (NSArray *)getStyleImages;

///获取所有的样式表的背景图
- (NSArray *)getBackgroundImages;

///获取所有的样式表的颜色
- (NSArray *)getAllColors;

///获取所有的样式表的颜色
- (NSArray *)getAllPalettesColors;

- (NSString *)getSelectedFuncContentString;

///获取指定名字的样式对象
- (NewDialJsonStylesListLibModel *)getStyleForName:(NSString *)styleName;

///获取指定名字的背景对象
- (NewDialJsonBackgroundLibModel *)getBackgroundForName:(NSString *)bgName;

- (NewDialJsonFuncListItemLibModel *)getFuncListItemForName:(NSString *)funcType;

+ (NewDialJsonFuncListItemLibModel *)getFuncListItemForName:(NSString *)funcType
                                           fromFuncsList:(NSArray<NewDialJsonFuncListLibModel *> *)funcList;

///获取功能表盘的图片存储路径
+ (NSString *)getFuncDialImagePath:(NSString *)dialZipName
                     withImageName:(NSString *)imageName;

///获取自定久表盘的图片存储路径 2.0以前
+ (NSString *)getCustomDialImagePath:(NSString *)dialZipName
                       withImageName:(NSString *)imageName;


///根据Json表里的数据  获取选中的各个角标的在总功能表的位置
- (NSDictionary *)getSelectedFuncIndexPath;

+ (NSIndexPath *)getSelectFunAtIndexInFuncList:(NSString *)type
                                    dataSource:(NSArray<NewDialJsonFuncListLibModel *> *)datasource;

///根据select对象中的属性，查找在background中的位置 -1表示未查到
- (NSInteger)getSelectedBackgroundIndex;

///根据select对象中的属性，查找在styles中的位置 -1表示未查到
- (NSInteger)getSelectedStyleIndex;

///获取选中的颜色，优先获取调色板的数据
- (NSString *)getSelectedColorHex;

///获取选中照片表盘时间功能位置
- (NewDialJsonLocationLibModel *)getSelectedLocation;

@end
