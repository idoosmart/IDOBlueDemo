//
//  SetLostViewModel.m
//  IDOBluetoothDemo
//
//  Created by hedongyang on 2018/9/25.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "SetPreventLostViewModel.h"
#import "FuncViewController.h"
#import "EmpltyCellModel.h"
#import "FuncCellModel.h"
#import "LabelCellModel.h"
#import "EmptyTableViewCell.h"
#import "OneButtonTableViewCell.h"
#import "OneLabelTableViewCell.h"

@interface SetPreventLostViewModel()
@property (nonatomic,strong) IDOSetPreventLostInfoBuletoothModel * preventLostModel;
@end

@implementation SetPreventLostViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getSwitchCallback];
        [self getButtonCallback];
        [self getCellModels];
    }
    return self;
}

- (IDOSetPreventLostInfoBuletoothModel *)preventLostModel
{
    if (!_preventLostModel) {
        _preventLostModel = [IDOSetPreventLostInfoBuletoothModel currentModel];
    }
    return _preventLostModel;
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    LabelCellModel * model1 = [[LabelCellModel alloc]init];
    model1.typeStr = @"oneLabel";
    model1.data = @[@"不防丢"];
    model1.cellHeight = 70.0f;
    model1.CellClass = [OneLabelTableViewCell class];
    model1.modelClass = [NSNull class];
    model1.isShowLine = YES;
    model1.isSelection = YES;
    [cellModels addObject:model1];
    
    LabelCellModel * model2 = [[LabelCellModel alloc]init];
    model2.typeStr = @"oneLabel";
    model2.data = @[@"近距离防丢"];
    model2.cellHeight = 70.0f;
    model2.CellClass = [OneLabelTableViewCell class];
    model2.modelClass = [NSNull class];
    model2.isShowLine = YES;
    model2.isSelection = YES;
    [cellModels addObject:model2];
    
    LabelCellModel * model3 = [[LabelCellModel alloc]init];
    model3.typeStr = @"oneLabel";
    model3.data = @[@"中距离防丢"];
    model3.cellHeight = 70.0f;
    model3.CellClass = [OneLabelTableViewCell class];
    model3.modelClass = [NSNull class];
    model3.isShowLine = YES;
    model3.isSelection = YES;
    [cellModels addObject:model3];
    
    LabelCellModel * model4 = [[LabelCellModel alloc]init];
    model4.typeStr = @"oneLabel";
    model4.data = @[@"远距离防丢"];
    model4.cellHeight = 70.0f;
    model4.CellClass = [OneLabelTableViewCell class];
    model4.modelClass = [NSNull class];
    model4.isShowLine = YES;
    model4.isSelection = YES;
    [cellModels addObject:model4];
    
    self.cellModels = cellModels;
}

- (void)getSwitchCallback
{

}

- (void)getButtonCallback
{
   
}
@end
