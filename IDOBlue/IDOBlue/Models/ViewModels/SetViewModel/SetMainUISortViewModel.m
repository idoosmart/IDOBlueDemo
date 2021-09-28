//
//  SetMainUISortViewModel.m
//  IDOBlue
//
//  Created by xiongjie on 2021/8/14.
//  Copyright © 2021 hedongyang. All rights reserved.
//

#import "SetMainUISortViewModel.h"
#import "TextFieldCellModel.h"
#import "OneTextFieldTableViewCell.h"
#import "TwoTextFieldTableViewCell.h"
#import "EmpltyCellModel.h"
#import "EmptyTableViewCell.h"
#import "FuncCellModel.h"
#import "OneButtonTableViewCell.h"
#import "FuncViewController.h"

@interface SetMainUISortViewModel()

@property (nonatomic,strong) IDOMainInterfaceSortModel *mainSortModel;

@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^textFeildCallback)(UIViewController * viewController,UITextField * textField,UITableViewCell * tableViewCell);

@end

@implementation SetMainUISortViewModel


- (instancetype)init
{
    self = [super init];
    if (self) {
        //[self getTextFieldCallback];
        [self getButtonCallback];
        [self getCellModels];
    }
    return self;
}


- (IDOMainInterfaceSortModel *)mainSortModel
{
    if (!_mainSortModel)
    {
        _mainSortModel = [IDOMainInterfaceSortModel currentModel];
    }
    return _mainSortModel;
}


- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        //NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        [funcVC showLoadingWithMessage:@"设置中..."];
        [IDOFoundationCommand setMainUiSortCommand:strongSelf.mainSortModel
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
    
    
    EmpltyCellModel * model6 = [[EmpltyCellModel alloc]init];
    model6.typeStr = @"empty";
    model6.cellHeight = 30.0f;
    model6.isShowLine = YES;
    model6.cellClass  = [EmptyTableViewCell class];
    [cellModels addObject:model6];
    
    
    FuncCellModel * model7 = [[FuncCellModel alloc]init];
    model7.typeStr = @"oneButton";
    model7.data = @[lang(@"set main interface sort")];
    model7.cellHeight = 70.0f;
    model7.cellClass = [OneButtonTableViewCell class];
    model7.modelClass = [NSNull class];
    model7.isShowLine = YES;
    model7.buttconCallback = self.buttconCallback;
    [cellModels addObject:model7];
    
    
    // 设置主界面控件排序
    NSMutableArray * itemArray = [NSMutableArray arrayWithCapacity:0];
    IDOMainInterfaceItemModel * itemModel = [[IDOMainInterfaceItemModel alloc] init];
    itemModel.locationX = 110;
    itemModel.locationY = 30;
    itemModel.sizeType = 1;
    itemModel.widgetsType = 1;
    [itemArray addObject:itemModel];
    
    
    self.mainSortModel.items = itemArray;
    self.cellModels = cellModels;
}



@end
