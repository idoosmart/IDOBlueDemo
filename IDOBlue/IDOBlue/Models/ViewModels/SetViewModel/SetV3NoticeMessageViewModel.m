//
//  SetV3NoticeMessageViewModel.m
//  IDOBlue
//
//  Created by xiongjie on 2021/8/14.
//  Copyright © 2021 hedongyang. All rights reserved.
//

#import "SetV3NoticeMessageViewModel.h"
#import "TextFieldCellModel.h"
#import "OneTextFieldTableViewCell.h"
#import "TwoTextFieldTableViewCell.h"
#import "EmpltyCellModel.h"
#import "EmptyTableViewCell.h"
#import "FuncCellModel.h"
#import "OneButtonTableViewCell.h"
#import "FuncViewController.h"
#import "SetAppNotifyStateItemViewModel.h"
#import "LabelCellModel.h"
#import "OneLabelTableViewCell.h"


@interface SetV3NoticeMessageViewModel()

@property (nonatomic,strong) IDOSetV3NotifyStateModel *v3NoticeMsgStateModel;

@property (nonatomic,strong) NSMutableArray<IDOSetAppNotifyStateItemModel *> * items;
@property (nonatomic,strong) NSArray * opArray;

@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^addbuttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^textFeildCallback)(UIViewController * viewController,UITextField * textField,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^textFeildDidEditCallback)(UIViewController * viewController,UITextField * textField,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^labelSelectCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);

@end

@implementation SetV3NoticeMessageViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getButtonCallback];
        [self getAddButtonCallback];
        [self getLabelCallback];
        [self getCellModels];
    }
    return self;
}

- (IDOSetV3NotifyStateModel *)v3NoticeMsgStateModel
{
    if (!_v3NoticeMsgStateModel)
    {
        _v3NoticeMsgStateModel = [IDOSetV3NotifyStateModel currentModel];
        if(_v3NoticeMsgStateModel.operat < 1) {
            _v3NoticeMsgStateModel.operat = 1;
        }
        
    }
    return _v3NoticeMsgStateModel;
}

- (NSMutableArray <IDOSetAppNotifyStateItemModel *>*)items
{
    if (!_items)
    {
        _items = [NSMutableArray new];
        [_items addObjectsFromArray:self.v3NoticeMsgStateModel.items];
    }
    return _items;
}

- (NSArray *)opArray
{
    if (!_opArray)
    {
        //1：增加； 2：修改;  3:获取查询
        _opArray = @[lang(@"add"),lang(@"update"),lang(@"select")];
    }
    return _opArray;
}

- (void)getLabelCallback
{
    __weak typeof(self) weakSelf = self;
    self.labelSelectCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        IDOSetAppNotifyStateItemModel* itemModel  = [strongSelf.items objectAtIndex:indexPath.row - 2];
        FuncViewController * newFuncVc = [FuncViewController new];
        SetAppNotifyStateItemViewModel * setModel = [SetAppNotifyStateItemViewModel new];
        setModel.stateItemModel= itemModel;
        void(^addAppNotifyStateItemModelmComplete)(BOOL isSuccess,IDOSetAppNotifyStateItemModel *itemModel) =^(BOOL isSuccess,IDOSetAppNotifyStateItemModel *itemModel) {
            if (isSuccess) {
                [strongSelf getCellModels];
                [funcVC reloadData];
            }
        };
        setModel.addAppNotifyStateItemModelmComplete = addAppNotifyStateItemModelmComplete;
        newFuncVc.model = setModel;
        [viewController.navigationController pushViewController:newFuncVc animated:YES];
    };
}



- (void)getAddButtonCallback
{
    
    __weak typeof(self) weakSelf = self;
    self.addbuttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVc = (FuncViewController *)viewController;
        FuncViewController * newFuncVc = [FuncViewController new];
        SetAppNotifyStateItemViewModel * setModel = [SetAppNotifyStateItemViewModel new];
        setModel.stateItemModel = nil;
        void(^addAppNotifyStateItemModelmComplete)(BOOL isSuccess,IDOSetAppNotifyStateItemModel *itemModel) =^(BOOL isSuccess,IDOSetAppNotifyStateItemModel *itemModel) {
            if (isSuccess) {
                [strongSelf.items addObject:itemModel];
                [strongSelf getCellModels];
                [funcVc reloadData];
            }
        };
        setModel.addAppNotifyStateItemModelmComplete = addAppNotifyStateItemModelmComplete;
        newFuncVc.model = setModel;
        newFuncVc.title = lang(@"add app notify");
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
        
        [funcVC showLoadingWithMessage:lang(@"set data...")];
        strongSelf.v3NoticeMsgStateModel.items = [strongSelf.items copy];
        strongSelf.v3NoticeMsgStateModel.itemsNum = strongSelf.items.count;
        strongSelf.v3NoticeMsgStateModel.nowSendIndex = strongSelf.items.count;
        strongSelf.v3NoticeMsgStateModel.allSendNum = strongSelf.items.count;
        [IDOFoundationCommand setMessageNoticeStateCommand:strongSelf.v3NoticeMsgStateModel
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
    
    //操作类型 0:无效,1:增, 2:删, 3:查,4:改
    TextFieldCellModel * model1 = [[TextFieldCellModel alloc] init];
    model1.typeStr = @"oneTextField";
    model1.titleStr = lang(@"operation");
    model1.data = @[self.opArray[self.v3NoticeMsgStateModel.operat - 1]];;
    model1.cellHeight = 70.0f;
    model1.cellClass = [OneTextFieldTableViewCell class];
    model1.modelClass = [NSNull class];
    model1.isShowLine = YES;
    model1.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model1];
    
    TextFieldCellModel * model2 = [[TextFieldCellModel alloc] init];
    model2.typeStr = @"oneTextField";
    model2.titleStr = lang(@"version num");
    model2.data = @[@(self.v3NoticeMsgStateModel.msgVersion)];
    model2.cellHeight = 70.0f;
    model2.cellClass = [OneTextFieldTableViewCell class];
    model2.modelClass = [NSNull class];
    model2.isShowLine = YES;
    model2.isShowKeyboard = YES;
    model2.keyType = UIKeyboardTypeNumberPad;
    model2.textFeildDidEditCallback = self.textFeildDidEditCallback;
    [cellModels addObject:model2];
    
    int index = 0;
    for (IDOSetAppNotifyStateItemModel * item in self.items) {
        
        LabelCellModel * model = [[LabelCellModel alloc]init];
        model.typeStr = @"oneLabel";
        NSString * name = [NSString stringWithFormat:@"%@",@(item.evtType)];
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
    model7.data = @[lang(@"add app notify")];
    model7.cellHeight = 70.0f;
    model7.cellClass = [OneButtonTableViewCell class];
    model7.modelClass = [NSNull class];
    model7.isShowLine = YES;
    model7.buttconCallback = self.addbuttconCallback;
    [cellModels addObject:model7];
    
    FuncCellModel * model8 = [[FuncCellModel alloc]init];
    model8.typeStr = @"oneButton";
    model8.data = @[lang(@"setup")];
    model8.cellHeight = 70.0f;
    model8.cellClass = [OneButtonTableViewCell class];
    model8.modelClass = [NSNull class];
    model8.isShowLine = YES;
    model8.buttconCallback = self.buttconCallback;
    [cellModels addObject:model8];
    
//    // 添加通知事件
//    NSMutableArray * itemArray = [NSMutableArray arrayWithCapacity:0];
//    for (int i = 0; i < 3; i ++)
//    {
//        IDOSetAppNotifyStateItemModel * itemModel = [[IDOSetAppNotifyStateItemModel alloc] init];
//        itemModel.evtType = 1;
//        itemModel.notifyState = 1;
//        [itemArray addObject:itemModel];
//    }
//    self.v3NoticeMsgStateModel.items = itemArray;
    
    self.cellModels = cellModels;
}



@end
