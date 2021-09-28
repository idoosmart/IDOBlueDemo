//
//  SetSyncContactViewModel.m
//  IDOBlue
//
//  Created by xiongjie on 2021/8/14.
//  Copyright © 2021 hedongyang. All rights reserved.
//

#import "SetSyncContactViewModel.h"
#import "TextFieldCellModel.h"
#import "OneTextFieldTableViewCell.h"
#import "TwoTextFieldTableViewCell.h"
#import "EmpltyCellModel.h"
#import "EmptyTableViewCell.h"
#import "FuncCellModel.h"
#import "OneButtonTableViewCell.h"
#import "FuncViewController.h"
#import "LabelCellModel.h"
#import "OneLabelTableViewCell.h"
#import "SetContactItemViewModel.h"

@interface SetSyncContactViewModel()


@property (nonatomic,strong) IDOSetSyncContactModel *syncContactModel;
@property (nonatomic,strong) NSMutableArray<IDOSetContactItemModel *> * items;
@property (nonatomic,strong) NSArray * opArray;

@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^addbuttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^textFeildCallback)(UIViewController * viewController,UITextField * textField,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^textFeildDidEditCallback)(UIViewController * viewController,UITextField * textField,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^labelSelectCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);

@end


@implementation SetSyncContactViewModel


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getButtonCallback];
        [self getLabelCallback];
        [self getAddButtonCallback];
        [self getCellModels];
       
    }
    return self;
}

- (IDOSetSyncContactModel *)syncContactModel
{
    if (!_syncContactModel)
    {
        _syncContactModel = [IDOSetSyncContactModel currentModel];
//        _syncContactModel.operat = 1;
    }
    return _syncContactModel;
}

- (NSMutableArray <IDOSetContactItemModel *>*)items
{
    if (!_items)
    {
        _items = [NSMutableArray new];
        [_items addObjectsFromArray:self.syncContactModel.items];
    }
    return _items;
}


//- (NSArray *)opArray
//{
//    if (!_opArray)
//    {
//        // 操作 0：无效； 1： 设置， 2：查询
//        _opArray = @[lang(@"invalid state"),lang(@"setup"),lang(@"select")];
//    }
//    return _opArray;
//}

- (void)getLabelCallback
{
    __weak typeof(self) weakSelf = self;
    self.labelSelectCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        IDOSetContactItemModel* itemModel  = [strongSelf.items objectAtIndex:indexPath.row - 2];
        FuncViewController * newFuncVc = [FuncViewController new];
        SetContactItemViewModel * setModel = [SetContactItemViewModel new];
        setModel.contactItemModel= itemModel;
        void(^addContactItemComplete)(BOOL isSuccess,IDOSetContactItemModel *itemModel) =^(BOOL isSuccess,IDOSetContactItemModel *itemModel) {
            if (isSuccess) {
                [strongSelf getCellModels];
                [funcVC reloadData];
            }
        };
        setModel.addContactItemComplete = addContactItemComplete;
        newFuncVc.model = setModel;
        [viewController.navigationController pushViewController:newFuncVc animated:YES];
    };
}

- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        //NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];

        //[funcVC showLoadingWithMessage:@"同步协议蓝牙通话常用联系人..."];

        BOOL falg = YES;
        
        if (falg)
        {
            if (strongSelf.syncContactModel.items.count < 0 ) {
                FuncViewController * funcVC = (FuncViewController *)[IDODemoUtility getCurrentVC];
                [funcVC showToastWithText:lang(@"please add contact")];
            }
            [funcVC showLoadingWithMessage:lang(@"set data...")];
            strongSelf.syncContactModel.items = [strongSelf.items copy];
            strongSelf.syncContactModel.itemsNum = strongSelf.items.count;
            [IDOFoundationCommand setSyncContactCommand:strongSelf.syncContactModel
                                              callback:^(int errorCode) {
                if(errorCode == 0) {
                    [funcVC showToastWithText:lang(@"setup success")];
                }else if (errorCode == 6) {
                    [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
                }else {
                    [funcVC showToastWithText:lang(@"setup failed")];
                }
            }];
        }
        else
        {
            [IDOFoundationCommand getContactDataCommand:^(int errorCode, IDOSetSyncContactModel * _Nullable data) {

            }];
        }
    };
}

- (void)getAddButtonCallback
{
    
    __weak typeof(self) weakSelf = self;
    self.addbuttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVc = (FuncViewController *)viewController;
        FuncViewController * newFuncVc = [FuncViewController new];
        SetContactItemViewModel * setModel = [SetContactItemViewModel new];
        setModel.contactItemModel = nil;
        void(^addContactItemComplete)(BOOL isSuccess,IDOSetContactItemModel *itemModel) =^(BOOL isSuccess,IDOSetContactItemModel *itemModel) {
            if (isSuccess) {
                [strongSelf.items addObject:itemModel];
                [strongSelf getCellModels];
                [funcVc reloadData];
            }
        };
        setModel.addContactItemComplete = addContactItemComplete;
        newFuncVc.model = setModel;
        newFuncVc.title = lang(@"add contact");
        [viewController.navigationController pushViewController:newFuncVc animated:YES];
    };
}


- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    
//    //操作类型 0:无效,1:增, 2:删, 3:查,4:改
//    TextFieldCellModel * model1 = [[TextFieldCellModel alloc] init];
//    model1.typeStr = @"oneTextField";
//    model1.titleStr = @"操作" ;
//    model1.data = @[self.opArray[self.syncContactModel.operat]];;
//    model1.cellHeight = 70.0f;
//    model1.cellClass = [OneTextFieldTableViewCell class];
//    model1.modelClass = [NSNull class];
//    model1.isShowLine = YES;
//    model1.textFeildCallback = self.textFeildCallback;
//    [cellModels addObject:model1];
    
    TextFieldCellModel * model2 = [[TextFieldCellModel alloc] init];
    model2.typeStr = @"oneTextField";
    model2.titleStr = lang(@"version num");
    model2.data = @[@(self.syncContactModel.conVersion)];
    model2.cellHeight = 70.0f;
    model2.cellClass = [OneTextFieldTableViewCell class];
    model2.modelClass = [NSNull class];
    model2.isShowLine = YES;
    model2.isShowKeyboard = YES;
    model2.keyType = UIKeyboardTypeNumberPad;
    model2.textFeildDidEditCallback = self.textFeildDidEditCallback;
    [cellModels addObject:model2];
    
    int index = 0;
    for (IDOSetContactItemModel * item in self.items) {
        
        LabelCellModel * model = [[LabelCellModel alloc]init];
        model.typeStr = @"oneLabel";
        NSString * name = [NSString stringWithFormat:@"%@:%@",item.name,item.phone];
        model.data = @[name];
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
    
    EmpltyCellModel * model6 = [[EmpltyCellModel alloc]init];
    model6.typeStr = @"empty";
    model6.cellHeight = 30.0f;
    model6.isShowLine = YES;
    model6.cellClass  = [EmptyTableViewCell class];
    [cellModels addObject:model6];
    
    FuncCellModel * model7 = [[FuncCellModel alloc]init];
    model7.typeStr = @"oneButton";
    model7.data = @[lang(@"please add contact")];
    model7.cellHeight = 70.0f;
    model7.cellClass = [OneButtonTableViewCell class];
    model7.modelClass = [NSNull class];
    model7.isShowLine = YES;
    model7.buttconCallback = self.addbuttconCallback;
    [cellModels addObject:model7];
    
    EmpltyCellModel * model8 = [[EmpltyCellModel alloc]init];
    model8.typeStr = @"empty";
    model8.cellHeight = 30.0f;
    model8.isShowLine = YES;
    model8.cellClass  = [EmptyTableViewCell class];
    [cellModels addObject:model8];
    
    FuncCellModel * model9 = [[FuncCellModel alloc]init];
    model9.typeStr = @"oneButton";
    model9.data = @[lang(@"setup")];
    model9.cellHeight = 70.0f;
    model9.cellClass = [OneButtonTableViewCell class];
    model9.modelClass = [NSNull class];
    model9.isShowLine = YES;
    model9.buttconCallback = self.buttconCallback;
    [cellModels addObject:model9];
    
//    // 常用联系人
//    NSMutableArray * itemArray = [NSMutableArray arrayWithCapacity:0];
//
//    self.syncContactModel = [IDOSetSyncContactModel currentModel];
//
//    IDOSetContactItemModel * itemModel = [[IDOSetContactItemModel alloc] init];
//    itemModel.phone = @"13548442589";
//    itemModel.name = @"zhang";
//    [itemArray addObject:itemModel];
//
//    self.syncContactModel.items = itemArray;
//    self.syncContactModel.conVersion = 1;
//    self.syncContactModel.itemsNum = 1;
//    self.syncContactModel.operat = 1;
    
    self.cellModels = cellModels;
}


@end
