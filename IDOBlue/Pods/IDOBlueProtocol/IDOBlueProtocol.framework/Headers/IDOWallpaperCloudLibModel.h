//
//  IDOWallpaperCloudLibModel.h
//  IDOBlueProtocol
//
//  Created by huangkunhe on 2023/2/7.
//  Copyright © 2023 何东阳. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IDONewDialJsonSelectedLibModel;

@class IDONewDialJsonBackgroundLibModel;
@class IDONewDialJsonClockLibModel;

//支持的功能表
@class IDONewDialJsonFuncLibModel;
@class IDONewDialJsonFuncListLibModel;
@class IDONewDialJsonFuncListItemLibModel;

//样式表
@class IDONewDialJsonStylesListLibModel;
@class IDONewDialJsonStylesFuncsLibModel;

//调色板
@class IDONewDialJsonPaletteLibModel;

@class IDONewDialJsonLocationLibModel;

@class IDONewDialJsonAppLibModel;

@class IDONewDialJsonCountTimerLibModel;

@class IDONewDialWallpaperLibModel;

@class IDONewDialJsonFunctionListLibModel;

@class IDODialJsonTimeListLibModel;
@class IDODialJsonTimeWidgetLibModel;

@interface IDOWallpaperCloudLibModel : NSObject

@property (nonatomic, copy)NSString *dialZipName;//表盘包名称

@property (nonatomic, copy)NSString *version;//表盘版本

@property (nonatomic,strong)NSNumber *dailType;//表盘类型

@property (nonatomic,strong)NSDictionary *dialpreview;//头部显示的预览图

@property (nonatomic,strong)NSArray *dialStyle;//表盘样式图

@property (nonatomic,strong)IDONewDialJsonSelectedLibModel *select;//默认选中的样式图；

@property (nonatomic,strong)NSArray<NSDictionary *>    *colors;//颜色值

@property (nonatomic,strong)NSArray *stylemodul;//

@property (nonatomic,strong)NSDictionary *outFile;//与固件相关的字段

///表盘的bg的大小
@property (nonatomic, assign) CGSize     imageBgsize;

///表盘的preview的大小
@property (nonatomic, assign) CGSize     imagePreviewize;


@property (nonatomic, assign) CGSize     imagegroupsize;

@property (nonatomic,strong)NSArray<IDONewDialJsonBackgroundLibModel *> *backgrounds;//背景图

@property (nonatomic,strong)IDONewDialJsonFuncLibModel *funcInfo;//功能对象

@property (nonatomic,strong)IDONewDialJsonClockLibModel *clock;//功能对象

@property (nonatomic,strong)NSArray<IDONewDialJsonStylesListLibModel *> *styles;//样式表

@property (nonatomic,strong)NSArray<IDONewDialJsonPaletteLibModel *> *palettes;//调色板

@property (nonatomic,strong)NSArray<IDONewDialJsonLocationLibModel *> *locations;//样式表

@property (nonatomic, assign)NSInteger function_support;

@property (nonatomic, assign)NSInteger function_support_new;

@property (nonatomic,strong)NSArray<IDONewDialJsonFunctionListLibModel *> *function_list;

@property (nonatomic,strong)NSArray<IDODialJsonTimeListLibModel *> *time_widget_list;

/// 2.1.0 添加
@property (nonatomic,strong)IDONewDialJsonAppLibModel *app;//功能对象

/// 2.1.1 添加
@property (nonatomic,strong)NSArray<IDONewDialJsonCountTimerLibModel *> *counterTimers;//倒计时

///2.2.0 添加 壁纸云表盘的配置
@property (nonatomic,strong)IDONewDialWallpaperLibModel *cloudWallpaper;

///获取所有的功能表
- (NSArray<IDONewDialJsonFuncListLibModel *> *)getAllFunction:(NSInteger)funcIndex;

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
- (IDONewDialJsonStylesListLibModel *)getStyleForName:(NSString *)styleName;

///获取指定名字的背景对象
- (IDONewDialJsonBackgroundLibModel *)getBackgroundForName:(NSString *)bgName;

- (IDONewDialJsonFuncListItemLibModel *)getFuncListItemForName:(NSString *)funcType;

+ (IDONewDialJsonFuncListItemLibModel *)getFuncListItemForName:(NSString *)funcType
                                           fromFuncsList:(NSArray<IDONewDialJsonFuncListLibModel *> *)funcList;

///获取功能表盘的图片存储路径
+ (NSString *)getFuncDialImagePath:(NSString *)dialZipName
                     withImageName:(NSString *)imageName;

///获取自定久表盘的图片存储路径 2.0以前
+ (NSString *)getCustomDialImagePath:(NSString *)dialZipName
                       withImageName:(NSString *)imageName;


///根据Json表里的数据  获取选中的各个角标的在总功能表的位置
- (NSDictionary *)getSelectedFuncIndexPath;

+ (NSIndexPath *)getSelectFunAtIndexInFuncList:(NSString *)type
                                    dataSource:(NSArray<IDONewDialJsonFuncListLibModel *> *)datasource;

///根据select对象中的属性，查找在background中的位置 -1表示未查到
- (NSInteger)getSelectedBackgroundIndex;

///根据select对象中的属性，查找在styles中的位置 -1表示未查到
- (NSInteger)getSelectedStyleIndex;

///获取选中的颜色，优先获取调色板的数据
- (NSString *)getSelectedColorHex;

///获取选中照片表盘时间功能位置
- (IDONewDialJsonLocationLibModel *)getSelectedLocation;

@end

@interface IDONewDialJsonSelectedLibModel: NSObject

///样式图
@property (nonatomic,   copy) NSString *style;

///选中的背景图
@property (nonatomic,   copy) NSString *selectBG;

///颜色索引
@property (nonatomic, assign) NSInteger color;//索引

///表盘样式索引 旧的自定表盘用到
@property (nonatomic, assign) NSInteger dialStyle;//索引


///功能表 如果某一项为空 表示关闭显示
@property (nonatomic, strong) NSArray<NSString *>  *function;

///调色板
@property (nonatomic, assign) NSInteger  paletteIndex;

///选中的背景图
@property (nonatomic,   strong) NSString *worldClock;

///照片表盘的时间颜色
@property (nonatomic, assign) NSInteger timeColorIndex;

///照片表盘的时间颜色
@property (nonatomic, assign) NSInteger funcColorIndex;

///照片表盘的时间、功能的位置
@property (nonatomic, assign) NSInteger timeFuncLocation;

///功能的位置类型
@property (nonatomic, assign) NSInteger funcLocationType;

///功能的颜色
@property (nonatomic, copy) NSString*  funcBgColor;

///功能的颜色
@property (nonatomic, copy) NSString* funcFgColor;

///选中的倒计时的值
@property (nonatomic, strong) NSArray<NSNumber *>  *counterTimers;

@end

#pragma mark - 背景图的对象

@interface IDONewDialJsonBackgroundLibModel: NSObject

@property (nonatomic, assign) BOOL canChangeColor;//是否支持修改颜色

@property (nonatomic,   copy) NSString *image;//图片名

//默认的背景色
@property (nonatomic,   copy) NSString *backgroundColor;

//边框的颜色
@property (nonatomic, strong) NSString *borderColor;

//边框的宽度
@property (nonatomic, assign) CGFloat borderWidth;


//2.1.2 角标的颜色，和背景色绑定
@property (nonatomic, strong) NSString *funcTintColor;

@end


#pragma mark - 时间指针的对象

@interface IDONewDialJsonClockLibModel: NSObject

///是否支持根据选中的颜色 子功能项button 来渲染前景色
@property (nonatomic, assign) BOOL canChangeColor;//是否支持修改颜色

@property (nonatomic,   copy) NSString *image;//图片名

//时间的样式  0默认的时间  1世界时钟
@property (nonatomic, assign) NSInteger type;

///时间的位置
@property (nonatomic, assign) CGRect location;

///世界时钟的 定位城市名的位置， type=1时 有用
@property (nonatomic, assign) CGRect cityLocation;

@end



#pragma mark - 功能表的对象

@interface IDONewDialJsonFuncLibModel: NSObject

///是否支持根据选中的颜色 子功能项button 来渲染前景色
@property (nonatomic, assign) BOOL canChangeColor;


@property (nonatomic,   copy) NSString *name;//名字 备用

@property (nonatomic,   copy) NSString *version;//功能表版本  备用

//0 不支持，1 支持
@property (nonatomic, assign) BOOL isSupportClose;//是否支持关闭按钮

@property (nonatomic, strong) NSArray<IDONewDialJsonFuncListLibModel *>  *list;

@property (nonatomic, strong) NSArray<IDONewDialJsonStylesFuncsLibModel *> *defaultFuncs;

- (IDONewDialJsonFuncListItemLibModel *)getFuncsLibModelWithName:(NSString *)funcName;

@end




#define kDefaultCloseFuncKey        @"kDefaultCloseFuncKey"
#define kDefaultCloseFuncItemKey    @"kDefaultCloseFuncItemKey"

@interface IDONewDialJsonFunctionListItemLibModel: NSObject
@property (nonatomic,   copy) NSString *widget;
@property (nonatomic,   copy) NSString *type;
@property (nonatomic,   copy) NSString *font;
@property (nonatomic, assign) NSUInteger fontnum;
@property (nonatomic, assign) BOOL support_color_set;
@property (nonatomic,   copy) NSString *bg;
@property (nonatomic,   copy) NSString *align;
@end


@interface IDONewDialJsonFunctionListLibModel: NSObject
@property (nonatomic,   assign) int function;
@property (nonatomic,   copy) NSString *name;
@property (nonatomic,   copy) NSString *small_icon;
@property (nonatomic, strong) NSArray<IDONewDialJsonFunctionListItemLibModel *> *item;
@end

@interface IDONewDialJsonFuncListLibModel: NSObject

@property (nonatomic,   copy) NSString *type;//类型

@property (nonatomic, strong) NSArray<IDONewDialJsonFuncListItemLibModel *> *items;

- (NSString *)getTypeName;

+ (NSArray <IDONewDialJsonFuncListLibModel *>*)getWallperDialDefaultsFuncs;

@end


@interface IDONewDialJsonFuncListItemLibModel: NSObject


@property (nonatomic,   copy) NSString *type;//类型

@property (nonatomic,   copy) NSString *icon;//图标

//功能组件
@property (nonatomic, copy) NSString* widget;

//照片表盘 选择的功能组件
@property (nonatomic, assign) NSUInteger widgetType;


@property (nonatomic,   copy) NSString *contentStr;//如果显示文字时的内容

//功能表盘 只支持部分按钮 根据defaultFuncs顺序的索引判断
@property (nonatomic, strong) NSArray<NSNumber *> *supportFuncsIndexs;

+ (NSString *)getWidgetImageNameFromFuncListItem:(NSInteger)widgetType;

+ (NSString *)getTypeNameWithType:(NSString *)typeName;

+ (NSString *)convertWidgetTypeToFuncListItem:(NSInteger)widgetType;

+ (NSInteger)convertToWidgetTypeFromTypeName:(NSString *)typeName;

- (NSString *)getTypeName;

@end


#pragma mark - 样式表的类型

@interface IDONewDialJsonStylesListLibModel: NSObject

///类型
@property (nonatomic,   copy) NSString *name;

///是否支持根据选中的颜色 子功能项button 来渲染前景色
@property (nonatomic, assign) BOOL canChangeColor;

///图片列表
@property (nonatomic, strong) NSArray<NSString *> *images;

//默认的背景色
@property (nonatomic,   copy) NSString *backgroundColor;

//边框的颜色
@property (nonatomic, strong) NSString *borderColor;

//边框的宽度
@property (nonatomic, assign) CGFloat borderWidth;

@end


@interface IDONewDialJsonStylesFuncsLibModel: NSObject

@property (nonatomic, assign) BOOL isClose;//是否关闭显示

@property (nonatomic,   copy) NSString *funcType;//类型

@property (nonatomic,   copy) NSString *funcIcon;//图标



@property (nonatomic, assign) CGRect location;//图标的位置

@property (nonatomic, assign) CGFloat cornerRadius;//圆角大小

//是否修改内容， 如果为YES，把功能名写入到固件的表盘文件中
@property (nonatomic, assign) BOOL modifyContent;

@property (nonatomic,   copy) NSString *contentStr;//如果显示文字时的内容

@end

#pragma mark - 调色板的对象

@interface IDONewDialJsonPaletteLibModel: NSObject

@property (nonatomic,   copy) NSString *num;//类型

@property (nonatomic,   copy) NSString *colors;//图标

@property (nonatomic, assign) NSInteger index;//索引

@end



#pragma mark - 照片表盘的位置
@interface IDONewDialJsonFunctionItemLibModel: NSObject
@property (nonatomic, copy) NSString* widget;
@property (nonatomic, copy) NSString* type;
@property (nonatomic, assign) CGRect coordinate;
@end


@interface IDONewDialJsonFunctionCoordinateLibModel: NSObject
@property (nonatomic, assign) NSInteger function;
@property (nonatomic, strong) NSArray<IDONewDialJsonFunctionItemLibModel *>  *item;
@end



@interface IDONewDialJsonLocationLibModel: NSObject

//3右上
@property (nonatomic, assign) NSInteger type;

@property (nonatomic, assign) CGRect time;

@property (nonatomic, assign) CGRect day;

@property (nonatomic, assign) CGRect week;

///功能
@property (nonatomic, assign) CGRect func;

///功能
@property (nonatomic, strong)NSArray<IDONewDialJsonFunctionCoordinateLibModel*> *function_coordinate;

@property (nonatomic, strong)NSArray<IDODialJsonTimeWidgetLibModel*> *time_widget;


@end


@interface IDONewDialJsonAppLibModel: NSObject

@property (nonatomic, assign) NSInteger bpp;

@property (nonatomic,   copy) NSString *name;

///拷贝功能表的功能图标的 图片后缀
@property (nonatomic,   copy) NSString *format;

///功能表盘支持动态更换预览图 2.1.6
@property (nonatomic, assign) NSInteger replacePreview;

@end

@interface IDONewDialJsonCountTimerLibModel: NSObject

//@(1), @(3), @(5), @(10), @(30), @(60)
@property (nonatomic, strong) NSArray<NSNumber *> *timers;

//默认的索引 如上示例 index2对应值是5
@property (nonatomic, assign) NSInteger defaultIndex;

//倒计时图标的位置
@property (nonatomic, assign) CGRect location;

@property (nonatomic, assign) CGFloat cornerRadius;//圆角大小

@property (nonatomic, assign) CGFloat fontSize;

@property (nonatomic,   copy) NSString *textColor;

@end

///照片云表盘LibModel  2.2.0添加
@interface IDONewDialWallpaperLibModel: NSObject

///是否支持功能 默认0不支持，  1：支持功能切换
@property (nonatomic, assign) BOOL  function_support;

///是否支持修改时间显示位置，默认0支持 1表盘不支持
@property (nonatomic, assign) BOOL  no_support_location;

///是否支持修改颜色，默认0支持 1表盘不支持
@property (nonatomic, assign) BOOL  no_support_colors;

@end


@interface IDONewDialInstallLibModel : NSObject

/// 表盘名字
@property(nonatomic, strong) NSString * dialName;

/// 表盘ID+

@property(nonatomic, strong) NSString * dialId;

/// 表盘固件名字
@property(nonatomic, strong) NSString * firmwareName;

/// 表盘图片的URL 路径
@property(nonatomic, strong) NSString * imageUrl;

/// 表盘包下载地址
@property(nonatomic, strong) NSString * linkUrl;

/// 表盘描述
@property(nonatomic, strong) NSString * dialInfo;

/// sid
@property(nonatomic, strong) NSString * sid;

/// 新增云表盘version
//@property(nonatomic ,strong) IDOVFWatchDialFaceVersion * otaFaceVersion;

#pragma mark - 表盘是否是收藏
///表盘是否是已收藏 2.0.0添加
@property(nonatomic, assign) BOOL collected;

//true表示上架，false表示下架 1.2.1版本添加
@property(nonatomic, assign) BOOL enabled;

//表盘类型
@property(nonatomic, copy) NSString *faceType;

/// 2.0.0添加 自定义常规类型 "CUSTOM_FUNCTION",:固定字段表示自定义功能类型  除自定义表盘外其他类型该字段为null
/// 2.1.8 CUSTOM_FIXED_PHOTO 照片固定表盘
@property(nonatomic, copy) NSString *customFaceType;

@end

@interface IDODialJsonTimeListLibModel: NSObject
@property (nonatomic,   assign) int fontnum;
@property (nonatomic,   copy) NSString *widget;
@property (nonatomic,   copy) NSString *type;
@property (nonatomic,   copy) NSString *font;
@end

@interface IDODialJsonTimeWidgetLibModel: NSObject
@property (nonatomic, copy) NSString* widget;
@property (nonatomic, copy) NSString* type;
@property (nonatomic, copy) NSString* font;
@property (nonatomic, assign) int fontnum;
@property (nonatomic, assign) int x;
@property (nonatomic, assign) int y;
@property (nonatomic, assign) int w;
@property (nonatomic, assign) int h;
@end

