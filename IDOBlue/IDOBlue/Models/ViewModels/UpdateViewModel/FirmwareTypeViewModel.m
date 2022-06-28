//
//  FirmwareTypeViewModel.m
//  IDOBlue
//
//  Created by 何东阳 on 2018/10/31.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "FirmwareTypeViewModel.h"
#import "LabelCellModel.h"
#import "OneLabelTableViewCell.h"
#import "FuncViewController.h"

@interface FirmwareTypeViewModel()
@property (nonatomic,copy)void(^labelSelectCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation FirmwareTypeViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getLabelSelectCallback];
    }
    return self;
}

- (void)setType:(NSInteger)type
{
    _type = type;
    [self getCellModels];
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    if (_type == 0) {
        for (NSString * title in self.pickerDataModel.firmwareTypes) {
            NSString * fileType = [[NSUserDefaults standardUserDefaults]objectForKey:FIRMWARE_FILE_TYPE_KEY];
            if (!fileType) fileType = @"Application";
            LabelCellModel * model1 = [[LabelCellModel alloc]init];
            model1.typeStr = @"oneLabel";
            model1.data    = @[title];
            model1.cellHeight = 45.0f;
            model1.isShowLine = YES;
            model1.isSelected = [fileType isEqualToString: title];
            model1.cellClass  = [OneLabelTableViewCell class];
            model1.labelSelectCallback = self.labelSelectCallback;
            model1.modelClass = [NSNull class];
            [cellModels addObject:model1];
        }
    }else if(_type == 1){
        for (NSString * title in self.pickerDataModel.updateFileTypes) {
            NSString * fileType = [[NSUserDefaults standardUserDefaults]objectForKey:FIRMWARE_FILE_TYPE_KEY];
            if (!fileType) fileType = @".fw";
            LabelCellModel * model1 = [[LabelCellModel alloc]init];
            model1.typeStr = @"oneLabel";
            model1.data    = @[title];
            model1.cellHeight = 45.0f;
            model1.isShowLine = YES;
            model1.isSelected = [fileType isEqualToString: title];
            model1.cellClass  = [OneLabelTableViewCell class];
            model1.labelSelectCallback = self.labelSelectCallback;
            model1.modelClass = [NSNull class];
            [cellModels addObject:model1];
        }
    }else {
        for (NSString * title in self.pickerDataModel.agpsUpdateTypes) {
            NSString * fileType = [[NSUserDefaults standardUserDefaults]objectForKey:FIRMWARE_FILE_TYPE_KEY];
            if (!fileType) fileType = @"online.ubx";
            LabelCellModel * model1 = [[LabelCellModel alloc]init];
            model1.typeStr = @"oneLabel";
            model1.data    = @[title];
            model1.cellHeight = 45.0f;
            model1.isShowLine = YES;
            model1.isSelected = [fileType isEqualToString: title];
            model1.cellClass  = [OneLabelTableViewCell class];
            model1.labelSelectCallback = self.labelSelectCallback;
            model1.modelClass = [NSNull class];
            [cellModels addObject:model1];
        }
    }
    
    self.cellModels = cellModels;
}

- (void)getLabelSelectCallback
{
    __weak typeof(self) weakSelf = self;
    self.labelSelectCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        LabelCellModel * cellModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
        NSString * typeStr = [cellModel.data firstObject];
        [[NSUserDefaults standardUserDefaults] setValue:typeStr forKey:FIRMWARE_FILE_TYPE_KEY];
        [funcVC.navigationController popViewControllerAnimated:YES];
    };
}

@end
