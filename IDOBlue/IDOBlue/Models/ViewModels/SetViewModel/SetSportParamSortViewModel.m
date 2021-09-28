//
//  SetSportParamSortViewModel.m
//  IDOBlue
//
//  Created by xiongjie on 2021/8/13.
//  Copyright © 2021 hedongyang. All rights reserved.
//

#import "SetSportParamSortViewModel.h"
#import "TextFieldCellModel.h"
#import "OneTextFieldTableViewCell.h"
#import "TwoTextFieldTableViewCell.h"
#import "EmpltyCellModel.h"
#import "EmptyTableViewCell.h"
#import "FuncCellModel.h"
#import "OneButtonTableViewCell.h"
#import "FuncViewController.h"



@interface SetSportParamSortViewModel()

@property (nonatomic,strong) IDOSetSportParameterSortModel *sportParamSortModel;

/**
 操作数组
 */
@property (nonatomic,strong) NSArray * opArray;

@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^textFeildCallback)(UIViewController * viewController,UITextField * textField,UITableViewCell * tableViewCell);


@end


@implementation SetSportParamSortViewModel


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getTextFieldCallback];
        [self getButtonCallback];
        [self getCellModels];
    }
    return self;
}

//- (NSArray *)opArray
//{
//    if (!_opArray)
//    {
//        _opArray = @[@"无效",@"查询",@"设置"];
//    }
//    return _opArray;
//}

- (IDOSetSportParameterSortModel *)sportParamSortModel
{
    if (!_sportParamSortModel)
    {
        _sportParamSortModel = [IDOSetSportParameterSortModel currentModel];
    }
    return _sportParamSortModel;
}


- (void)getTextFieldCallback
{
    __weak typeof(self) weakSelf = self;
    self.textFeildCallback = ^(UIViewController *viewController, UITextField *textField, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
        NSArray * dataArray = [NSArray array];
        dataArray = strongSelf.pickerDataModel.tenArray;
        funcVC.pickerView.pickerArray = dataArray;
        funcVC.pickerView.currentIndex = [dataArray containsObject:@([textField.text intValue])] ?
        [dataArray indexOfObject:@([textField.text intValue])] : 0 ;
        [funcVC.pickerView show];
        funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
            textField.text = selectStr;
            textFieldModel.data = @[@([selectStr integerValue])];
            [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            if (textFieldModel.index == 0) {
                strongSelf.sportParamSortModel.sportType  = [selectStr integerValue];
            }else if (textFieldModel.index == 1) {
                strongSelf.sportParamSortModel.currentIndex  = [selectStr integerValue];
            }
        };
    };
}


- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        //NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];

        [funcVC showLoadingWithMessage:lang(@"set data...")];
        
        [IDOFoundationCommand setSportParameterSortCommand:strongSelf.sportParamSortModel
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


- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    
    TextFieldCellModel * model2 = [[TextFieldCellModel alloc] init];
    model2.typeStr = @"oneTextField";
    model2.titleStr = lang(@"sport type");
    model2.data = @[@(self.sportParamSortModel.sportType)];
    model2.cellHeight = 70.0f;
    model2.cellClass = [OneTextFieldTableViewCell class];
    model2.modelClass = [NSNull class];
    model2.isShowLine = YES;
    model2.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model2];
    
    TextFieldCellModel * model3 = [[TextFieldCellModel alloc] init];
    model3.typeStr = @"oneTextField";
    model3.titleStr = lang(@"current sport index");
    model3.data = @[@(self.sportParamSortModel.currentIndex)];
    model3.cellHeight = 70.0f;
    model3.cellClass = [OneTextFieldTableViewCell class];
    model3.modelClass = [NSNull class];
    model3.isShowLine = YES;
    model3.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model3];
    
    EmpltyCellModel * model6 = [[EmpltyCellModel alloc]init];
    model6.typeStr = @"empty";
    model6.cellHeight = 30.0f;
    model6.isShowLine = YES;
    model6.cellClass  = [EmptyTableViewCell class];
    [cellModels addObject:model6];
    
    FuncCellModel * model7 = [[FuncCellModel alloc]init];
    model7.typeStr = @"oneButton";
    model7.data = @[lang(@"setup")];
    model7.cellHeight = 70.0f;
    model7.cellClass = [OneButtonTableViewCell class];
    model7.modelClass = [NSNull class];
    model7.isShowLine = YES;
    model7.buttconCallback = self.buttconCallback;
    [cellModels addObject:model7];
    
    // 运动子项排序枚举列表
    NSMutableArray * itemArray = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < 3; i ++)
    {
        [itemArray addObject:@(i)];
    }
    self.sportParamSortModel.items = itemArray;
    
    self.cellModels = cellModels;
}



@end
