//
//  SetWorldTimeViewModel.m
//  IDOBlue
//
//  Created by xiongjie on 2021/8/11.
//  Copyright © 2021 hedongyang. All rights reserved.
//

#import "SetWorldTimeViewModel.h"
#import "FuncViewController.h"
#import "EmpltyCellModel.h"
#import "EmptyTableViewCell.h"
#import "FuncCellModel.h"
#import "OneButtonTableViewCell.h"
#import "LabelCellModel.h"
#import "OneLabelTableViewCell.h"
#import "IDODemoUtility.h"
#import "IDOPGSun.h"

@interface SetWorldTimeViewModel()
@property (nonatomic,strong) NSArray * wordTimeArray;
@property (nonatomic,strong) NSMutableArray * noSelectTimeModes;
@property (nonatomic,strong) NSMutableArray * selectTimeModes;
@property (nonatomic,strong) IDOSetV3WorldTimeModel * wordTimeModel;
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^labelSelectCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);

@end

@implementation SetWorldTimeViewModel


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self getViewWillDisappearCallback];
        [self getWordTimeInfo];
        [self getLabelCallback];
        [self getCellModels];
    }
    
    return self;
}

- (void)getViewWillDisappearCallback
{
    __weak typeof(self) weakSelf = self;
    self.viewWillDisappearCallback = ^(UIViewController *viewController) {
        __strong typeof(self) strongSelf = weakSelf;
        if (strongSelf.addWorldTimeComplete) {
            strongSelf.addWorldTimeComplete(YES,strongSelf.wordTimeModel.items.mutableCopy);
        }
    };
}

- (IDOSetV3WorldTimeModel *)wordTimeModel
{
    if(!_wordTimeModel) {
        _wordTimeModel = [IDOSetV3WorldTimeModel currentModel];
    }
    return _wordTimeModel;
}

- (NSMutableArray *)noSelectTimeModes
{
    if(!_noSelectTimeModes) {
        _noSelectTimeModes = [NSMutableArray array];
    }
    return _noSelectTimeModes;
}

- (NSMutableArray *)selectTimeModes
{
    if(!_selectTimeModes) {
        _selectTimeModes = [NSMutableArray array];
    }
    return _selectTimeModes;
}

- (void)getWordTimeInfo
{
    NSString * mainPath = [NSBundle mainBundle].bundlePath;
    NSString * path = [mainPath stringByAppendingPathComponent:@"Files"];
    NSString * filePath = [path stringByAppendingPathComponent:@"world_time.json"];
    NSData * data = [NSData dataWithContentsOfFile:filePath];
    self.wordTimeArray = [NSJSONSerialization JSONObjectWithData:data
                                    options:NSJSONReadingAllowFragments | NSJSONReadingMutableLeaves | NSJSONReadingMutableContainers
                                      error:nil];
}

- (void)getSortTimeModes
{
    [self.selectTimeModes removeAllObjects];
    [self.noSelectTimeModes removeAllObjects];
    for (NSDictionary * dic in self.wordTimeArray) {
        NSInteger cityId  = [[dic valueForKey:@"city_id"] integerValue];
        NSString * enName = [dic valueForKey:@"en_area"]?:@"";
        NSString * chName = [dic valueForKey:@"ch_area"]?:@"";
        NSString * latitude = [dic valueForKey:@"latitude"]?:@"";
        NSString * longitude = [dic valueForKey:@"longitude"]?:@"";
        NSString * timeZone = [dic valueForKey:@"timeZone"]?:@"";
        NSString * cityName = [NSString stringWithFormat:@"%@(%@)",enName,chName];
        IDOSetV3WorldTimeItemModel * model = [self getCurrentModeItemWithId:cityId];
        if (model) {
            [self.selectTimeModes addObject:@{@"title":cityName,
                                              @"isSelected":@(1),
                                              @"latitude":latitude,
                                              @"longitude":longitude,
                                              @"cityId":@(model.cityId),
                                              @"timeZone":timeZone
                                            }];
        }else {
            [self.noSelectTimeModes addObject:@{@"title":cityName,
                                                @"isSelected":@(0),
                                                @"latitude":latitude,
                                                @"longitude":longitude,
                                                @"cityId":@(cityId),
                                                @"timeZone":timeZone
                                              }];
        }
    }
}

- (IDOSetV3WorldTimeItemModel *)getCurrentModeItemWithId:(NSInteger)cityId
{
    for (IDOSetV3WorldTimeItemModel * model in self.wordTimeModel.items) {
        if (model.cityId == cityId) {
            return model;
        }
    }
    return nil;
}

- (void)getLabelCallback
{
    __weak typeof(self) weakSelf = self;
    self.labelSelectCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        [funcVC.tableView setEditing:YES animated:YES];
        funcVC.navigationItem.rightBarButtonItem.title = lang(@"complete");
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        LabelCellModel * labelModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
        NSDictionary * dic = strongSelf.noSelectTimeModes[labelModel.index];
        NSMutableArray * timeItems = [NSMutableArray arrayWithArray:strongSelf.wordTimeModel.items];
        IDOSetV3WorldTimeItemModel * item = [IDOSetV3WorldTimeItemModel new];
        item.cityId = [[dic valueForKey:@"cityId"] integerValue];
        NSString * timeZone = [dic valueForKey:@"timeZone"]?:@"";
        item.minuteOffset = [IDODemoUtility getZeroTimeWithZone:timeZone]/60;
        NSString * cityName = [dic valueForKey:@"title"];
        item.cityName = cityName;
        item.cityNameLen = cityName.length;
        NSString * latitude = [dic valueForKey:@"latitude"];
        NSString * longitude = [dic valueForKey:@"longitude"];
        IDOPGSun * sun = [[IDOPGSun alloc]init];
        NSDictionary * dic1 = [sun sun:[longitude doubleValue] withLat:[latitude doubleValue]];
        NSString * sunriseStr = [dic1 valueForKey:@"sunrise"];
        NSString * sunsetStr = [dic1 valueForKey:@"sunset"];
        NSArray * array1 = [sunriseStr componentsSeparatedByString:@":"];
        NSArray * array2 = [sunsetStr componentsSeparatedByString:@":"];
        item.sunriseHour = [array1.firstObject integerValue];
        item.sunriseMin = [array1.lastObject integerValue];
        item.sunsetHour = [array2.firstObject integerValue];
        item.sunsetMin = [array2.lastObject integerValue];
        BOOL flag1 = [[dic valueForKey:@"latitude"] rangeOfString:@"-"].location != NSNotFound;
        BOOL flag2 = [[dic valueForKey:@"longitude"] rangeOfString:@"-"].location != NSNotFound;
        NSInteger latitudeFlag = flag1 ? 2 : 1;
        NSInteger longitudeFlag = flag2 ? 2 : 1;
        item.latitudeFlag = latitudeFlag;
        item.longitudeFlag = longitudeFlag;
        NSInteger latitudeValue = [latitude doubleValue]*100;
        NSInteger longitudeValue = [longitude doubleValue]*100;
        item.latitude = latitudeValue;
        item.longitude = longitudeValue;
        [timeItems addObject:item];
        strongSelf.wordTimeModel.items = timeItems;
        [strongSelf getCellModels];
        [funcVC reloadData];
    };
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    [self getSortTimeModes];
    for (NSDictionary * dic in self.selectTimeModes) {
        NSString * title = [dic valueForKey: @"title"];
        LabelCellModel * model = [[LabelCellModel alloc]init];
        model.typeStr = @"oneLabel";
        model.data = @[title];
        model.cellHeight = 60.0f;
        model.cellClass = [OneLabelTableViewCell class];
        model.modelClass = [NSNull class];
        model.isShowLine = YES;
        model.isSelected = YES;
        [cellModels addObject:model];
    }
    
    if (cellModels.count > 0) {
        EmpltyCellModel * model2 = [[EmpltyCellModel alloc]init];
        model2.typeStr = @"empty";
        model2.cellHeight = 30.0f;
        model2.isShowLine = YES;
        model2.cellClass  = [EmptyTableViewCell class];
        [cellModels addObject:model2];
    }
    
    int index = 0;
    for (NSDictionary * dic in self.noSelectTimeModes) {
        NSString * title = [dic valueForKey: @"title"];
        LabelCellModel * model = [[LabelCellModel alloc]init];
        model.typeStr = @"oneLabel";
        model.data = @[title];
        model.cellHeight = 60.0f;
        model.cellClass = [OneLabelTableViewCell class];
        model.modelClass = [NSNull class];
        model.isShowLine = YES;
        model.index = index;
        model.labelSelectCallback = self.labelSelectCallback;
        [cellModels addObject:model];
        index ++;
    }
    self.cellModels = cellModels;
}

@end
