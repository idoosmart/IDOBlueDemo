//
//  AllWorldTimeViewModel.m
//  IDOBlue
//
//  Created by huangkunhe on 2021/9/3.
//  Copyright © 2021 hedongyang. All rights reserved.
//

#import "AllWorldTimeViewModel.h"
#import "FuncViewController.h"
#import "EmpltyCellModel.h"
#import "FuncCellModel.h"
#import "LabelCellModel.h"
#import "EmptyTableViewCell.h"
#import "OneButtonTableViewCell.h"
#import "OneLabelTableViewCell.h"
#import "SetWorldTimeViewModel.h"
#import "TextFieldCellModel.h"
#import "OneTextFieldTableViewCell.h"


@interface AllWorldTimeViewModel()
@property (nonatomic,strong) IDOSetV3WorldTimeModel * V3WorldTimeModel;

@property (nonatomic,strong) NSMutableArray<IDOSetV3WorldTimeItemModel *>* items;

@property (nonatomic,copy)void(^labelSelectCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^setbuttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^textFeildDidEditCallback)(UIViewController * viewController,UITextField * textField,UITableViewCell * tableViewCell);
@end

@implementation AllWorldTimeViewModel


- (void)dealloc
{
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getButtonCallback];
        [self getSetButtonCallback];
        [self getLabelCallback];
        [self getDelectCellCallback];
        [self getCellModels];
    }
    return self;
}

- (IDOSetV3WorldTimeModel *)V3WorldTimeModel
{
    if (!_V3WorldTimeModel)
    {
        _V3WorldTimeModel = [IDOSetV3WorldTimeModel currentModel];
        IDOSetV3WorldTimeItemModel * item1 = [IDOSetV3WorldTimeItemModel new];
        item1.cityId = 31;
        item1.cityName = @"Beijing";
        item1.cityNameLen = 7;
        item1.latitude = 3990;
        item1.latitudeFlag = 1;
        item1.longitude = 11640;
        item1.longitudeFlag = 1;
        item1.minuteOffset = 480;
        item1.sunriseHour = 5;
        item1.sunriseMin = 41;
        item1.sunsetHour = 18;
        item1.sunsetMin = 49;
        IDOSetV3WorldTimeItemModel * item2 = [IDOSetV3WorldTimeItemModel new];
        item2.cityId = 148;
        item2.cityName = @"London";
        item2.cityNameLen = 6;
        item2.latitude = 5150;
        item2.latitudeFlag = 1;
        item2.longitude = 12;
        item2.longitudeFlag = 2;
        item2.minuteOffset = 60;
        item2.sunriseHour = 13;
        item2.sunriseMin = 10;
        item2.sunsetHour = 2;
        item2.sunsetMin = 51;
        IDOSetV3WorldTimeItemModel * item3 = [IDOSetV3WorldTimeItemModel new];
        item3.cityId = 197;
        item3.cityName = @"New York";
        item3.cityNameLen = 8;
        item3.latitude = 4071;
        item3.latitudeFlag = 1;
        item3.longitude = 7400;
        item3.longitudeFlag = 2;
        item3.minuteOffset = -240;
        item3.sunriseHour = 18;
        item3.sunriseMin = 21;
        item3.sunsetHour = 7;
        item3.sunsetMin = 32;
        IDOSetV3WorldTimeItemModel * item4 = [IDOSetV3WorldTimeItemModel new];
        item4.cityId = 295;
        item4.cityName = @"Tokyo";
        item4.cityNameLen = 5;
        item4.latitude = 3567;
        item4.latitudeFlag = 1;
        item4.longitude = 13965;
        item4.longitudeFlag = 1;
        item4.minuteOffset = 540;
        item4.sunriseHour = 4;
        item4.sunriseMin = 12;
        item4.sunsetHour = 17;
        item4.sunsetMin = 11;
        IDOSetV3WorldTimeItemModel * item5 = [IDOSetV3WorldTimeItemModel new];
        item5.cityId = 4;
        item5.cityName = @"Addis Ababa";
        item5.cityNameLen = 11;
        item5.latitude = 898;
        item5.latitudeFlag = 1;
        item5.longitude = 3875;
        item5.longitudeFlag = 1;
        item5.minuteOffset = 180;
        item5.sunriseHour = 11;
        item5.sunriseMin = 16;
        item5.sunsetHour = 23;
        item5.sunsetMin = 34;
        _V3WorldTimeModel.items = @[item1,item2,item3,item4,item5];
        _V3WorldTimeModel.itemsNum = 5;
    }
    return _V3WorldTimeModel;
}

- (NSMutableArray <IDOSetV3WorldTimeItemModel *>*)items
{
    if (!_items)
    {
        _items = [NSMutableArray new];
        [_items addObjectsFromArray:self.V3WorldTimeModel.items];
    }
    return _items;
}


- (void)getButtonCallback
{
    if (self.items.count > 10 ) {
        FuncViewController * funcVC = (FuncViewController *)[IDODemoUtility getCurrentVC];
        [funcVC showToastWithText:lang(@"can not more than 10 time")];
    }
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVc = (FuncViewController *)viewController;
        FuncViewController * newFuncVc = [FuncViewController new];
        SetWorldTimeViewModel * setModel = [SetWorldTimeViewModel new];
        setModel.timeItemModel = nil;
        void(^addWorldTimeComplete)(BOOL isSuccess,IDOSetV3WorldTimeItemModel * itemModel) =^(BOOL isSuccess,IDOSetV3WorldTimeItemModel * itemModel) {
            if (isSuccess) {
                [strongSelf.items addObject:itemModel];
                [strongSelf getCellModels];
                [funcVc reloadData];
            }
        };
        setModel.addWorldTimeComplete = addWorldTimeComplete;
        newFuncVc.model = setModel;
        newFuncVc.title = lang(@"add world time");
        [viewController.navigationController pushViewController:newFuncVc animated:YES];
    };
}

- (void)getSetButtonCallback
{
    if (self.items.count < 0 ) {
        FuncViewController * funcVC = (FuncViewController *)[IDODemoUtility getCurrentVC];
        [funcVC showToastWithText:lang(@"please add world time")];
    }
    __weak typeof(self) weakSelf = self;
    self.setbuttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        [funcVC showLoadingWithMessage:[NSString stringWithFormat:@"%@...",lang(@"setup")]];
        strongSelf.V3WorldTimeModel.items = [strongSelf.items copy];
        strongSelf.V3WorldTimeModel.itemsNum = strongSelf.items.count;
        [IDOFoundationCommand setWorldTimeCommand:strongSelf.V3WorldTimeModel
                                           callback:^(int errorCode) {
            if(errorCode == 0) {
                [funcVC showToastWithText:lang(@"setup success")];
            }else if (errorCode == 6) {
                [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
            }else {
                [funcVC showToastWithText:lang(@"setup failed")];
            }
        }];
        
    };
}


- (void)getLabelCallback
{
    __weak typeof(self) weakSelf = self;
    self.labelSelectCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        IDOSetV3WorldTimeItemModel * itemModel  = [strongSelf.items objectAtIndex:indexPath.row];
        FuncViewController * newFuncVc = [FuncViewController new];
        SetWorldTimeViewModel *setViewModel = [SetWorldTimeViewModel new];
        setViewModel.timeItemModel = itemModel;
        void(^addWorldTimeComplete)(BOOL isSuccess,IDOSetV3WorldTimeItemModel * itemModel) =^(BOOL isSuccess,IDOSetV3WorldTimeItemModel * itemModel) {
            if (isSuccess) {
                [strongSelf getCellModels];
                [funcVC reloadData];
            }
        };
        setViewModel.addWorldTimeComplete  = addWorldTimeComplete;
        newFuncVc.model = setViewModel;
        [viewController.navigationController pushViewController:newFuncVc animated:YES];
    };
}

- (void)getTextFeildDidEditCallback {
    
    __weak typeof(self) weakSelf = self;
    self.textFeildDidEditCallback = ^(UIViewController *viewController, UITextField *textField, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        strongSelf.V3WorldTimeModel.worldVersion = [textField.text integerValue];
        TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
        textFieldModel.data = @[@(strongSelf.V3WorldTimeModel.worldVersion)];

    };
}



- (void)getDelectCellCallback
{
    __weak typeof(self) weakSelf = self;
    self.delectCellCallback = ^(UIViewController *viewController, NSIndexPath *indexPath) {
          __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        IDOSetV3WorldTimeItemModel * itemModel  = [strongSelf.items objectAtIndex:indexPath.row];
        [strongSelf.items removeObject:itemModel];
        [strongSelf getCellModels];
        [funcVC reloadData];

    };
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    int index = 0;
    for (IDOSetV3WorldTimeItemModel * item in self.items) {
            LabelCellModel * model = [[LabelCellModel alloc]init];
            model.typeStr = @"oneLabel";
            NSString * cityStr = [NSString stringWithFormat:@"%ld : %@",(long)item.cityId,item.cityName];
            model.data = @[cityStr];
            model.cellHeight = 40.0f;
            model.cellClass  = [OneLabelTableViewCell class];
            model.modelClass = [NSNull class];
            model.labelSelectCallback = self.labelSelectCallback;
            model.index = index;
            model.isShowLine = YES;
            model.isDelete   = YES;
            [cellModels addObject:model];
        
        index ++;
    }
    
    if (cellModels.count > 0) {
        EmpltyCellModel * model = [[EmpltyCellModel alloc]init];
        model.typeStr = @"empty";
        model.cellHeight = 30.0f;
        model.isShowLine = YES;
        model.cellClass  = [EmptyTableViewCell class];
        [cellModels addObject:model];
    }
    FuncCellModel * model1 = [[FuncCellModel alloc]init];
    model1.typeStr = @"oneButton";
    model1.data    = @[lang(@"add world time")];
    model1.cellHeight = 70.0f;
    model1.cellClass = [OneButtonTableViewCell class];
    model1.modelClass = [NSNull class];
    model1.isShowLine = YES;
    model1.buttconCallback = self.buttconCallback;
    [cellModels addObject:model1];
    self.cellModels = cellModels;
    
    TextFieldCellModel * model100 = [[TextFieldCellModel alloc]init];
    model100.typeStr = @"oneTextField";
    model100.titleStr = lang(@"version num");
    model100.data = @[@(self.V3WorldTimeModel.worldVersion)];
    model100.cellHeight = 70.0f;
    model100.cellClass = [OneTextFieldTableViewCell class];
    model100.modelClass = [NSNull class];
    model100.isShowLine = YES;
    model100.isShowKeyboard = YES;
    model100.keyType = UIKeyboardTypeNumberPad;
    model100.textFeildDidEditCallback = self.textFeildDidEditCallback;
    [cellModels addObject:model100];
    
    FuncCellModel * model101 = [[FuncCellModel alloc]init];
    model101.typeStr = @"oneButton";
    model101.data = @[@"setup"];
    model101.cellHeight = 70.0f;
    model101.cellClass = [OneButtonTableViewCell class];
    model101.modelClass = [NSNull class];
    model101.isShowLine = YES;
    model101.buttconCallback = self.setbuttconCallback;
    [cellModels addObject:model101];
}


@end
