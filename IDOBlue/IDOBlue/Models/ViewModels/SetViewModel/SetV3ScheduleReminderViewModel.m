//
//  SetActivitySwitchViewModel.m
//  IDOBlue
//
//  Created by xiongjie on 2021/8/13.
//  Copyright © 2021 hedongyang. All rights reserved.
//

#import "SetV3ScheduleReminderViewModel.h"
#import "TextFieldCellModel.h"
#import "OneTextFieldTableViewCell.h"
#import "TwoTextFieldTableViewCell.h"
#import "EmpltyCellModel.h"
#import "EmptyTableViewCell.h"
#import "FuncCellModel.h"
#import "OneButtonTableViewCell.h"
#import "FuncViewController.h"
#import "SetV3ScheduleRemindItemViewModel.h"
#import "LabelCellModel.h"
#import "OneLabelTableViewCell.h"

@interface SetV3ScheduleReminderViewModel()
/**
 设置日程提醒
 */
@property (nonatomic,strong) IDOSetV3ScheduleReminderModel * scheduleReminderModel;

@property (nonatomic,strong) NSMutableArray<IDOSetRemindItemModel *> * items;

/**
 操作数组
 */
@property (nonatomic,strong) NSArray * opArray;

@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^addbuttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^textFeildCallback)(UIViewController * viewController,UITextField * textField,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^textFeildDidEditCallback)(UIViewController * viewController,UITextField * textField,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^labelSelectCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);

@end

@implementation SetV3ScheduleReminderViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getTextFieldCallback];
        [self getTextFeildDidEditCallback];
        [self getAddButtonCallback];
        [self getButtonCallback];
        [self getLabelCallback];
        [self getCellModels];
       
    }
    return self;
}

- (NSMutableArray <IDOSetRemindItemModel *>*)items
{
    if (!_items)
    {
        _items = [NSMutableArray new];
        [_items addObjectsFromArray:self.scheduleReminderModel.items];
    }
    return _items;
}


- (NSArray *)opArray
{
    if (!_opArray)
    {
        _opArray = @[lang(@"invalid state"),lang(@"add"),lang(@"delete"),lang(@"select"),lang(@"update")];
    }
    return _opArray;
}




- (IDOSetV3ScheduleReminderModel *)scheduleReminderModel
{
    if (!_scheduleReminderModel)
    {
        _scheduleReminderModel = [IDOSetV3ScheduleReminderModel currentModel];
    }
    return _scheduleReminderModel;
}



- (void)getButtonCallback
{
    if (self.scheduleReminderModel.items.count < 0 ) {
        FuncViewController * funcVC = (FuncViewController *)[IDODemoUtility getCurrentVC];
        [funcVC showToastWithText:lang(@"add schedule")];
    }
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        //NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];

        [funcVC showLoadingWithMessage:lang(@"set data...")];
        strongSelf.scheduleReminderModel.num = strongSelf.items.count;
        strongSelf.scheduleReminderModel.items = [strongSelf.items copy];
        
        [IDOFoundationCommand setScheduleReminderCommand:strongSelf.scheduleReminderModel
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

- (void)getAddButtonCallback
{
    if (self.scheduleReminderModel.items.count > 5 ) {
        FuncViewController * funcVC = (FuncViewController *)[IDODemoUtility getCurrentVC];
        [funcVC showToastWithText:@"more than 5"];
    }
    __weak typeof(self) weakSelf = self;
    self.addbuttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVc = (FuncViewController *)viewController;
        FuncViewController * newFuncVc = [FuncViewController new];
        SetV3ScheduleRemindItemViewModel * setModel = [SetV3ScheduleRemindItemViewModel new];
        setModel.remindItemModel = nil;
        void(^addRemindItemComplete)(BOOL isSuccess,IDOSetRemindItemModel * itemModel) =^(BOOL isSuccess,IDOSetRemindItemModel * itemModel) {
            if (isSuccess) {
                [strongSelf.items addObject:itemModel];
                [strongSelf getCellModels];
                [funcVc reloadData];
            }
        };
        setModel.addRemindItemComplete = addRemindItemComplete;
        newFuncVc.model = setModel;
        newFuncVc.title = lang(@"add schedule");
        [viewController.navigationController pushViewController:newFuncVc animated:YES];
    };
}

- (void)getTextFieldCallback
{
    __weak typeof(self) weakSelf = self;
    self.textFeildCallback = ^(UIViewController *viewController, UITextField *textField, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        
        
        TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
        if(textFieldModel.index == 0) {
            funcVC.pickerView.pickerArray = strongSelf.opArray;
            funcVC.pickerView.currentIndex = [strongSelf.opArray containsObject:textField.text] ? [strongSelf.opArray indexOfObject:textField.text] : 0 ;
            [funcVC.pickerView show];
            funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
                textField.text = selectStr;
                textFieldModel.data = @[selectStr];
                [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                strongSelf.scheduleReminderModel.operate  = [strongSelf.opArray containsObject:selectStr] ? [strongSelf.opArray indexOfObject:selectStr] : 0 ;
                
            };
        }
       
    };
}

- (void)getLabelCallback
{
    __weak typeof(self) weakSelf = self;
    self.labelSelectCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        IDOSetRemindItemModel* itemModel  = [strongSelf.items objectAtIndex:indexPath.row - 2];
        FuncViewController * newFuncVc = [FuncViewController new];
        SetV3ScheduleRemindItemViewModel * setModel = [SetV3ScheduleRemindItemViewModel new];
        setModel.remindItemModel= itemModel;
        void(^addRemindItemComplete)(BOOL isSuccess,IDOSetRemindItemModel *itemModel) =^(BOOL isSuccess,IDOSetRemindItemModel *itemModel) {
            if (isSuccess) {
                [strongSelf getCellModels];
                [funcVC reloadData];
            }
        };
        setModel.addRemindItemComplete  = addRemindItemComplete;
        newFuncVc.model = setModel;
        [viewController.navigationController pushViewController:newFuncVc animated:YES];
    };
}

- (void)getTextFeildDidEditCallback {
    __weak typeof(self) weakSelf = self;
    self.textFeildDidEditCallback = ^(UIViewController *viewController, UITextField *textField, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        if (indexPath.row == 1)
        {
            TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
            strongSelf.scheduleReminderModel.scVersion = [textField.text integerValue];
            textFieldModel.data = @[@(strongSelf.scheduleReminderModel.scVersion)];
        }
    };
}


- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    
    //操作类型 0:无效,1:增, 2:删, 3:查,4:改
    TextFieldCellModel * model1 = [[TextFieldCellModel alloc] init];
    model1.typeStr = @"oneTextField";
    model1.titleStr = lang(@"operation");
    model1.data = @[self.opArray[self.scheduleReminderModel.operate]];;
    model1.cellHeight = 70.0f;
    model1.cellClass = [OneTextFieldTableViewCell class];
    model1.modelClass = [NSNull class];
    model1.isShowLine = YES;
    model1.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model1];
    
    TextFieldCellModel * model2 = [[TextFieldCellModel alloc] init];
    model2.typeStr = @"oneTextField";
    model2.titleStr = lang(@"version num");
    model2.data = @[@(self.scheduleReminderModel.scVersion)];
    model2.cellHeight = 70.0f;
    model2.cellClass = [OneTextFieldTableViewCell class];
    model2.modelClass = [NSNull class];
    model2.isShowLine = YES;
    model2.isShowKeyboard = YES;
    model2.keyType = UIKeyboardTypeNumberPad;
    model2.textFeildDidEditCallback = self.textFeildDidEditCallback;
    [cellModels addObject:model2];
    
    int index = 0;
    for (IDOSetRemindItemModel * item in self.items) {
        
        LabelCellModel * model = [[LabelCellModel alloc]init];
        model.typeStr = @"oneLabel";
        NSString * cityStr = [NSString stringWithFormat:@"%ld : %@",(long)item.remindId,item.title];
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
    
    EmpltyCellModel * model3 = [[EmpltyCellModel alloc]init];
    model3.typeStr = @"empty";
    model3.cellHeight = 30.0f;
    model3.isShowLine = YES;
    model3.cellClass  = [EmptyTableViewCell class];
    [cellModels addObject:model3];
    
    FuncCellModel * model8 = [[FuncCellModel alloc]init];
    model8.typeStr = @"oneButton";
    model8.data = @[lang(@"add schedule")];
    model8.cellHeight = 70.0f;
    model8.cellClass = [OneButtonTableViewCell class];
    model8.modelClass = [NSNull class];
    model8.isShowLine = YES;
    model8.buttconCallback = self.addbuttconCallback;
    [cellModels addObject:model8];
    
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
    
//    // 设置日程提醒
//    NSMutableArray * itemArray = [NSMutableArray arrayWithCapacity:0];
//    IDOSetRemindItemModel * itemModel = [[IDOSetRemindItemModel alloc] init];
//    itemModel.remindId = 110;
//    itemModel.year = 2021;
//    itemModel.month = 10;
//    itemModel.day = 10;
//    itemModel.hour = 10;
//    itemModel.minute = 10;
//    itemModel.second = 10;
//    itemModel.repeat = @[@(1),@(2)];
//    itemModel.nowDayRemindType = 1;
//    itemModel.state = 2;
//    itemModel.title = @"标题";
//    itemModel.note = @"注意";
//
//    [itemArray addObject:itemModel];
//    
//    self.scheduleReminderModel.items = itemArray;
    
    self.cellModels = cellModels;
}


@end
