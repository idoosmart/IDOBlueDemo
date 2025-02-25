//
//  IDOWallpaperCloudLibModel.m
//  IDOBlueProtocol
//
//  Created by huangkunhe on 2023/2/7.
//  Copyright © 2023 何东阳. All rights reserved.
//

//#import "WallpaperCloudLibModel.h"
//#import "WallpaperFileLibManager.h"
#import "WallpaperCloudLibModel.h"
#import "YYModel.h"
#import "NewDialJsonSelectedLibModel.h"
#import "NewDialJsonBackgroundLibModel.h"
#import "NewDialJsonFuncLibModel.h"
#import "NewDialJsonClockLibModel.h"
#import "NewDialJsonStylesListLibModel.h"
#import "NewDialJsonPaletteLibModel.h"
#import "NewDialJsonLocationLibModel.h"
#import "NewDialJsonFunctionListLibModel.h"
#import "DialJsonTimeListLibModel.h"
#import "NewDialJsonAppLibModel.h"
#import "NewDialJsonCountTimerLibModel.h"
#import "NewDialWallpaperLibModel.h"
#import "NewDialJsonFuncListLibModel.h"
#import "NewDialJsonFuncListItemLibModel.h"
#import "NewDialJsonStylesFuncsLibModel.h"
#import "WallpaperFileLibManager.h"

@implementation WallpaperCloudLibModel

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{
        @"time_widget_list": [DialJsonTimeListLibModel class],
        @"function_list": [NewDialJsonFunctionListLibModel class],
        @"funcInfo": [NewDialJsonFuncLibModel class],
        @"styles": [NewDialJsonStylesListLibModel class],
        @"palettes": [NewDialJsonPaletteLibModel class],
        @"select": [NewDialJsonSelectedLibModel class],
        @"backgrounds": [NewDialJsonBackgroundLibModel class],
        @"locations": [NewDialJsonLocationLibModel class],
        @"app": [NewDialJsonAppLibModel class],
        @"counterTimers": [NewDialJsonCountTimerLibModel class],
        @"cloudWallpaper": [NewDialWallpaperLibModel class],
    };
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    if (![dic objectForKey:@"imagegroupsize"]) {
        return YES;
    }
    NSDictionary *sizeDict = [dic valueForKey:@"imagegroupsize"];

    if (![sizeDict isKindOfClass:[NSDictionary class]]){
        return NO;
    }else{
        CGFloat width = [[sizeDict valueForKey:@"width"] floatValue];
        CGFloat height = [[sizeDict valueForKey:@"height"] floatValue];
        _imagegroupsize = CGSizeMake(width, height);
    }
    
    return YES;
}

- (BOOL)modelCustomTransformToDictionary:(NSMutableDictionary *)dic{
    dic[@"imagegroupsize"] =@{@"width": [@(_imagegroupsize.width) stringValue], @"height": [@(_imagegroupsize.height) stringValue]};
    return YES;
}

///获取所有的功能表
- (NSArray<NewDialJsonFuncListLibModel *> *)getAllFunction:(NSInteger)funcIndex{
    NSArray *filterList;
    if (funcIndex >= 0) {
        NSMutableArray *tmpFilterList = [NSMutableArray array];
        
        for (NewDialJsonFuncListLibModel *LibModel in self.funcInfo.list) {
            NewDialJsonFuncListLibModel *copyLibModel = [LibModel copy];
            NSMutableArray *itemList = [NSMutableArray array];
            for (NewDialJsonFuncListItemLibModel *item in copyLibModel.items) {
                if (!item.supportFuncsIndexs ||
                    [item.supportFuncsIndexs containsObject:@(funcIndex)]) {
                    [itemList addObject:item];
                }
            }
            copyLibModel.items = itemList;
            if ([itemList count] > 0) {
                [tmpFilterList addObject:copyLibModel];
            }
        }
        filterList = tmpFilterList;
    }else{
        filterList = self.funcInfo.list;
    }
    

    if (!self.funcInfo.isSupportClose) {
        //不支持关闭按钮
        return filterList;
    }
    
    NewDialJsonFuncListLibModel *closeShowObj = [[NewDialJsonFuncListLibModel alloc] init];
    closeShowObj.type = kDefaultCloseFuncKey;
    
    NewDialJsonFuncListItemLibModel *itemObj = [[NewDialJsonFuncListItemLibModel alloc] init];
    itemObj.type = kDefaultCloseFuncItemKey;
    closeShowObj.items = @[itemObj];
    
    NSMutableArray *list = [filterList mutableCopy];
    [list insertObject:closeShowObj atIndex:0];
    
    return list;
}

- (NSArray *)getStyleImages{
    NSMutableArray *list = [NSMutableArray array];
    for (NewDialJsonStylesListLibModel *obj in self.styles) {
        if (obj.images.count > 0) {
            [list addObject:[obj.images componentsJoinedByString:@"*"]];
        }
    }
    return list;
}

- (NSArray *)getBackgroundImages{
    NSMutableArray *list = [NSMutableArray array];
    for (NewDialJsonBackgroundLibModel *obj in self.backgrounds) {
        [list addObject:obj.image];
    }
    return list;
}

- (NSArray *)getAllColors{
    NSMutableArray *list = [NSMutableArray array];
    for (NSDictionary *obj in self.colors) {
        [list addObject:[obj valueForKey:@"color"]];
    }
    return list;
}

///获取所有的样式表的颜色
- (NSArray *)getAllPalettesColors{
    NSMutableArray *list = [NSMutableArray array];
    for (NewDialJsonPaletteLibModel *obj in self.palettes) {
        [list addObject:obj.colors];
    }
    return list;
}

- (NSString *)getSelectedFuncContentString{
    NSMutableArray *list = [NSMutableArray array];
    if ([self.select.function count] > 0) {
        [self.select.function enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *showStr = [NewDialJsonFuncListItemLibModel getTypeNameWithType:obj];
            if (showStr.length > 0) {
                [list addObject:showStr];
            }
        }];
        return [list componentsJoinedByString:@"、"];
    }else{
        [self.funcInfo.defaultFuncs enumerateObjectsUsingBlock:^(NewDialJsonStylesFuncsLibModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *showStr = [NewDialJsonFuncListItemLibModel getTypeNameWithType:obj.funcType];
            if (showStr.length > 0) {
                [list addObject:showStr];
            }
        }];
        return [list componentsJoinedByString:@"、"];
    }

}


- (NewDialJsonBackgroundLibModel *)getBackgroundForName:(NSString *)bgName{
    for (NewDialJsonBackgroundLibModel *obj in self.backgrounds) {
        if ([obj.image isEqualToString:bgName]) {
            return obj;
        }
    }
    return nil;
}

- (NewDialJsonFuncListItemLibModel *)getFuncListItemForName:(NSString *)funcType{
    NSArray<NewDialJsonFuncListLibModel *> *allFuncs = self.funcInfo.list;
    return [WallpaperCloudLibModel getFuncListItemForName:funcType fromFuncsList:allFuncs];
}

+ (NewDialJsonFuncListItemLibModel *)getFuncListItemForName:(NSString *)funcType
                                           fromFuncsList:(NSArray<NewDialJsonFuncListLibModel *> *)funcList{
    //查询section
    for (NSInteger section = 0; section < funcList.count; section++) {
        NewDialJsonFuncListLibModel * obj = funcList[section];
        //查询row
        for (NSInteger row = 0; row < obj.items.count; row++) {
            NewDialJsonFuncListItemLibModel * itemObj = obj.items[row];
            if ([itemObj.type isEqualToString:funcType]) {
                return itemObj;
            }
        }
    }
    return nil;
}


- (NewDialJsonStylesListLibModel *)getStyleForName:(NSString *)styleName{
    for (NewDialJsonStylesListLibModel *obj in self.styles) {
        if ([obj.name isEqualToString:styleName]) {
            return obj;
        }
    }
    return nil;
}

///获取功能表盘的图片存储路径
+ (NSString *)getFuncDialImagePath:(NSString *)dialZipName
                     withImageName:(NSString *)imageName{
    NSString *filePath = [NSString stringWithFormat:@"%@/images/%@",[WallpaperFileLibManager dialZipRootPath:dialZipName], imageName];
    return filePath;
}

///获取自定义表盘的图片存储路径 2.0以前
+ (NSString *)getCustomDialImagePath:(NSString *)dialZipName
                       withImageName:(NSString *)imageName{
    NSString *filePath =  [NSString stringWithFormat:@"%@/app/%@",[WallpaperFileLibManager dialZipRootPath:dialZipName], imageName];
    return filePath;
}



- (NSDictionary *)getSelectedFuncIndexPath{
//    NSString *selectStyle = self.select.style;
    NSArray *selectFuncs = self.select.function;
    
//    __block IDODialJsonStylesListLibModel *currentStyleObj = nil;
//    [self.styles enumerateObjectsUsingBlock:^(IDODialJsonStylesListLibModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        if ([obj.name isEqualToString:selectStyle]) {
//            currentStyleObj = obj;
//            *stop = YES;
//        }
//    }];
//    if (!currentStyleObj) {
//        return nil;
//    }

    NSInteger count = self.funcInfo.defaultFuncs.count;
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:count];
    
    for (NSInteger i = 0; i < count; i++) {
        NSString *typeStr;
        
        //某个角标已被选择，不为默认值
        if (selectFuncs.count > i && [selectFuncs[i] length] > 0) {
            typeStr = selectFuncs[i];
        }else{
            //某个角标未修改，还为默认的功能图标
            NewDialJsonStylesFuncsLibModel *LibModel = self.funcInfo.defaultFuncs[i];
            typeStr = LibModel.funcType;
        }
        
        NSIndexPath *indexPath = [WallpaperCloudLibModel getSelectFunAtIndexInFuncList:typeStr dataSource:[self getAllFunction:-1]];
        if (indexPath) {
            [dict setObject:indexPath forKey:@(i)];
        }
    }
    return dict;
}

///查询某一个功能表在 总表的位置
+ (NSIndexPath *)getSelectFunAtIndexInFuncList:(NSString *)type
                                    dataSource:(NSArray<NewDialJsonFuncListLibModel *> *)datasource{
    if ([type length] <= 0 || datasource.count <= 0) {
        return nil;
    }
    
    //本地添加了一个 关闭显示的功能 重新获取数组
    NSArray<NewDialJsonFuncListLibModel *> *allFuncs = datasource;
    //查询section
    for (NSInteger section = 0; section < allFuncs.count; section++) {
        NewDialJsonFuncListLibModel * obj = allFuncs[section];
        //查询row
        for (NSInteger row = 0; row < obj.items.count; row++) {
            NewDialJsonFuncListItemLibModel * itemObj = obj.items[row];
            if ([itemObj.type isEqualToString:type]) {
                NSLog(@"检测到功能%@ section:%@, row:%@", type, @(section), @(row));
                return [NSIndexPath indexPathForRow:row inSection:section];
            }
        }
    }
    return nil;
}

///根据select对象中的属性，查找在background中的位置
- (NSInteger)getSelectedBackgroundIndex{
    NSString *str = _select.selectBG;
    if (str.length <= 0 || _backgrounds.count <= 0) {
        return -1;
    }
    for (NSInteger i = 0; i < _backgrounds.count; i++) {
        NewDialJsonBackgroundLibModel *obj = _backgrounds[i];
        if ([obj.image isEqualToString:str]) {
            return i;
        }
    }
    return -1;
}

///根据select对象中的属性，查找在styles中的位置
- (NSInteger)getSelectedStyleIndex{
    NSString *str = _select.style;
    if (str.length <= 0 || _styles.count <= 0) {
        return -1;
    }
    for (NSInteger i = 0; i < _styles.count; i++) {
        NewDialJsonStylesListLibModel *styleObj = _styles[i];
        if ([styleObj.name isEqualToString:str]) {
            return i;
        }
    }
    return -1;
}

- (NSString *)getSelectedColorHex{
    NSString *colorHexs;
    if (self.palettes.count > 0 &&
        self.select.paletteIndex >= 0 &&
        self.select.paletteIndex < self.palettes.count) {
        NewDialJsonPaletteLibModel *paletteObj = self.palettes[self.select.paletteIndex];
        if (paletteObj && paletteObj.colors.length > 0) {
            colorHexs = paletteObj.colors;
        }
    }else if (self.colors.count > 0&&
              self.select.color >= 0 &&
              self.select.color < self.colors.count){
        NSDictionary *colorDict = self.colors[self.select.color];
        if (colorDict && [colorDict objectForKey:@"color"]) {
            colorHexs = [colorDict objectForKey:@"color"];
        }

    }
    return colorHexs;
}


///获取选中照片表盘时间功能位置
- (NewDialJsonLocationLibModel *)getSelectedLocation{
    for (NSInteger i = 0; i < _locations.count; i++) {
        NewDialJsonLocationLibModel *obj = _locations[i];
        if (obj.type == _select.timeFuncLocation) {
            return obj;
        }
    }
    return nil;
}

- (NewDialJsonSelectedLibModel *)select{
    if (!_select) {
        _select = [[NewDialJsonSelectedLibModel alloc] init];
    }
    return _select;
}

@end
