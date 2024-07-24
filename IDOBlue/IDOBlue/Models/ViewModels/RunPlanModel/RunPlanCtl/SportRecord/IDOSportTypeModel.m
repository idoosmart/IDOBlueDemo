//
//  IDOSportTypeModel.m
//  IDOVFResources
//
//  Created by Warp on 2022/3/1.
//

#import "IDOSportTypeModel.h"
#import "YYModel.h"

@interface IDOSportTypeManager()

@property (nonatomic, readwrite, strong) NSArray<IDOSportTypeModel *> *allSportList;

//appKey : listIndex
@property (nonatomic, readwrite, strong) NSDictionary<NSNumber *, NSNumber *> *allSportDict;

/**
 运动计划的运动类型数组
 */
@property (nonatomic, readwrite, strong) NSArray<IDOSportTypeModel *> *planSportList;

//运动计划类型:对应的运动计划模型
@property (nonatomic, readwrite, strong) NSDictionary<NSString *, IDOSportTypeModel *> *allPlanSportDict;

@end

@implementation IDOSportTypeManager


+ (instancetype)sharedInstance{
    static IDOSportTypeManager *_shared = nil;
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _shared = [[IDOSportTypeManager alloc]init];
//        [_shared refershDataSource:@"SportTypeList"];
        [_shared refershPlanDataSource:@"SportPlanTypeList"];
    }) ;
    return _shared;
}

- (void)refershPlanDataSource:(NSString *)jsonName{
    
    NSArray *list = [self getAllSportTypes:jsonName];
    list = [list sortedArrayUsingComparator:^NSComparisonResult(IDOSportTypeModel *obj1, IDOSportTypeModel * obj2) {
        return obj1.appType > obj2.appType;
    }];
    self.planSportList = list;
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [list enumerateObjectsUsingBlock:^(IDOSportTypeModel *obj1, NSUInteger idx, BOOL * _Nonnull stop) {
        [dict setObject:obj1 forKey:@(obj1.appType).stringValue];
    }];
    self.allPlanSportDict = dict;
    
}

- (void)refershDataSource:(NSString *)jsonName{
    NSArray *list = [self getAllSportTypes:jsonName];
    list = [list sortedArrayUsingComparator:^NSComparisonResult(IDOSportTypeModel *obj1, IDOSportTypeModel * obj2) {
        return obj1.appType > obj2.appType;
    }];
    self.allSportList = list;
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [list enumerateObjectsUsingBlock:^(IDOSportTypeModel *obj1, NSUInteger idx, BOOL * _Nonnull stop) {
        [dict setObject:@(idx) forKey:@(obj1.appType)];
    }];
    self.allSportDict = dict;
}

- (NSArray<IDOSportTypeModel *> *)getAllSportTypes:(NSString *)jsonName{
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:jsonName ofType:@"json"];
    NSError *error = nil;
    NSData  *jsonData = [NSData dataWithContentsOfFile:jsonPath options:NSDataReadingMappedIfSafe error:&error];
//    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

    if (!error) {
        //数据解压成功
        NSArray *items = [NSArray yy_modelArrayWithClass:[IDOSportTypeModel class] json:jsonData];
        return items;
    }else{
        NSLog(@"读取json%@", error);
    }
    return [NSArray array];
}


//根据apptype 筛选Model类
- (IDOSportTypeModel *)sportModelForType:(IDOAllSportType)type{
    if (!self.allSportDict) {
        return nil;
    }
    NSInteger index = [[self.allSportDict objectForKey:@(type)] integerValue];
    if (index < 0 || index > [self.allSportList count]) {
        return nil;
    }
    IDOSportTypeModel *item = self.allSportList[index];
    return item;
}

//获取某种主类型的Models
- (NSArray<IDOSportTypeModel *> *)sportModelsForMainType:(IDOAllSportMainType)mainType{
    if (!self.allSportList || self.allSportList.count <= 0) {
        return nil;
    }
    NSMutableArray *list = [NSMutableArray array];
    for (IDOSportTypeModel *item in self.allSportList) {
        if (item.mainType == mainType) {
            [list addObject:item];
        }
    }
    return list;
}

- (IDOSportTypeModel *)planSportModelForActType:(IDOPlanSportType)actType{
    if (actType == 0) {
        return nil;
    }
    
    if (!self.allPlanSportDict) {//如果不存在有数据，则重新去加载数据
        [self refershPlanDataSource:@"SportPlanTypeList"];
    }
    
    IDOSportTypeModel *item = [self.allPlanSportDict objectForKey:@(actType).stringValue];
    
    
    
    return item;
}

@end

@implementation IDOSportTypeModel

- (UIImage *)sportIconForTemplateMode{
    return [self sportIconForTemplateMode:IDOSportIconStyleDefault];
}

- (UIImage *)sportIconForTemplateMode:(IDOSportIconStyle)iconStyle{
    NSAssert(self.pngName.length > 0, @"图片名为空");
    NSString *folder;
    if (self.planName.length > 0 && ![self.planName containsString:@"null"]) {
        folder = @"allSportPngs";
    }else{
        switch (iconStyle) {
            case IDOSportIconStyleSecond:
                folder = @"allSportPngs/second";
                break;
            default:
                folder = @"allSportPngs/default";
                break;
        }
    }
    
    UIImage *img = [UIImage imageNamed:self.pngName];
    return img;
}

@end
