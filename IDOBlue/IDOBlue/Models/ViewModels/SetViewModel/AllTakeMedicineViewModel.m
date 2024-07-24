//
//  AllTakeMedicineViewModel.m
//  IDOBlue
//
//  Created by hedongyang on 2022/8/1.
//  Copyright © 2022 hedongyang. All rights reserved.
//

#import "AllTakeMedicineViewModel.h"
#import "FuncViewController.h"
#import "EmpltyCellModel.h"
#import "FuncCellModel.h"
#import "LabelCellModel.h"
#import "EmptyTableViewCell.h"
#import "OneButtonTableViewCell.h"
#import "OneLabelTableViewCell.h"
#import "SetTakeMedicineViewModel.h"

@interface AllTakeMedicineViewModel ()
@property (nonatomic,strong) IDOSetTakingMedicineReminderModel * currentModel;
@property (nonatomic,copy)void(^labelSelectCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation AllTakeMedicineViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getButtonCallback];
        [self getLabelCallback];
        [self getDelectCellCallback];
        [self getCellModels];
    }
    return self;
}

- (IDOSetTakingMedicineReminderModel *)currentModel
{
    if (!_currentModel) {
         _currentModel = [IDOSetTakingMedicineReminderModel currentModel];
    }
    return _currentModel;
}

- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        FuncCellModel * cellModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
        if (cellModel.index == 0) {
            FuncViewController * newFuncVc = [FuncViewController new];
            SetTakeMedicineViewModel * takeMedicine = [[SetTakeMedicineViewModel alloc]init];
            takeMedicine.isAdd = YES;
            void(^addReminderTimeComplete)(IDOSetTakingMedicineReminderItemModel * item) = ^(IDOSetTakingMedicineReminderItemModel * item) {
                NSMutableArray * newItems = [NSMutableArray arrayWithArray:strongSelf.currentModel.items];
                [newItems addObject:item];
                strongSelf.currentModel.items = newItems;
                [strongSelf getCellModels];
                [funcVC reloadData];
            };
            takeMedicine.addReminderTimeComplete = addReminderTimeComplete;
            newFuncVc.model = takeMedicine;
            newFuncVc.title = lang(@"编辑服药提醒");
            [viewController.navigationController pushViewController:newFuncVc animated:YES];
        }else {
            if (self.currentModel.items.count == 0) {
                [funcVC showToastWithText:lang(@"请添加服药记录")];
                return;
            }
            [funcVC showLoadingWithMessage:[NSString stringWithFormat:@"%@...",lang(@"setup")]];
            [IDOFoundationCommand setTakingMedicineReminderCommand:strongSelf.currentModel
                                                          callback:^(float progress) {
                
            } complete:^(int errorCode) {
                if(errorCode == 0) {
                    [funcVC showToastWithText:lang(@"setup success")];
                }else if (errorCode == 6) {
                    [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
                }else {
                    [funcVC showToastWithText:lang(@"setup failed")];
                }
            }];
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
        IDOSetTakingMedicineReminderItemModel * itemModel  = [strongSelf.currentModel.items objectAtIndex:indexPath.row];
        FuncViewController * newFuncVc = [FuncViewController new];
        SetTakeMedicineViewModel * takeMedicine = [[SetTakeMedicineViewModel alloc]initWithModel:itemModel];
        takeMedicine.isAdd = NO;
        void(^editReminderTimeComplete)(IDOSetTakingMedicineReminderItemModel * item) = ^(IDOSetTakingMedicineReminderItemModel * item) {
            [strongSelf getCellModels];
            [funcVC reloadData];
        };
        takeMedicine.editReminderTimeComplete = editReminderTimeComplete;
        newFuncVc.model = takeMedicine;
        newFuncVc.title = [NSString stringWithFormat:@"%@(%ld)",lang(@"编辑服药提醒"),(long)itemModel.medicineId];
        [viewController.navigationController pushViewController:newFuncVc animated:YES];
    };
}

- (void)getDelectCellCallback
{
    __weak typeof(self) weakSelf = self;
    self.delectCellCallback = ^(UIViewController *viewController, NSIndexPath *indexPath) {
          __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        LabelCellModel * cellModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
        NSMutableArray * newItems = [NSMutableArray arrayWithArray:strongSelf.currentModel.items];
        [newItems removeObjectAtIndex:cellModel.index];
        strongSelf.currentModel.items = newItems;
        [strongSelf getCellModels];
        [funcVC reloadData];
    };
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    int index = 0;
    for (IDOSetTakingMedicineReminderItemModel * item in self.currentModel.items) {
        LabelCellModel * model = [[LabelCellModel alloc]init];
        model.typeStr = @"oneLabel";
        NSString * alarmStr = [NSString stringWithFormat:@"%@ %ld \n%@ %02ld:%02ld \n%@ %@",lang(@"服药提醒"),(long)item.medicineId,lang(@"time"),
                               (long)item.startHour,(long)item.startMinute,lang(@"repeat"),
                               [self weeksStrWithRepeats:item.repeat]];
        model.data = @[alarmStr];
        model.cellHeight = 80.0f;
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
    model1.data    = @[lang(@"添加服药提醒")];
    model1.cellHeight = 70.0f;
    model1.cellClass = [OneButtonTableViewCell class];
    model1.modelClass = [NSNull class];
    model1.isShowLine = YES;
    model1.index = 0;
    model1.buttconCallback = self.buttconCallback;
    [cellModels addObject:model1];
    
    FuncCellModel * model2 = [[FuncCellModel alloc]init];
    model2.typeStr = @"oneButton";
    model2.data    = @[lang(@"设置服药提醒")];
    model2.cellHeight = 70.0f;
    model2.cellClass = [OneButtonTableViewCell class];
    model2.modelClass = [NSNull class];
    model2.isShowLine = YES;
    model2.index = 1;
    model2.buttconCallback = self.buttconCallback;
    [cellModels addObject:model2];
    self.cellModels = cellModels;
}

- (NSString *)weeksStrWithRepeats:(NSArray *)repeat
{
    NSString * str = [NSString string];
    for (int i = 0;i<repeat.count; i++) {
        BOOL isRepeat = [[repeat objectAtIndex:i] boolValue];
        if (isRepeat) {
            NSString * weekDayStr = self.pickerDataModel.weekArray[i];
            str = [str stringByAppendingString:[NSString stringWithFormat:@"%@%@",weekDayStr,(i == repeat.count - 1)?@"":@"|"]];
        }
    }
    return str;
}
@end
