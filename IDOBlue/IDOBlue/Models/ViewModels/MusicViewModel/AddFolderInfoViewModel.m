//
//  AddFolderInfoViewModel.m
//  IDOBlue
//
//  Created by huangkunhe on 2021/9/27.
//  Copyright © 2021 hedongyang. All rights reserved.
//

#import "AddFolderInfoViewModel.h"
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
#import "FolderInfoViewModel.h"

@interface AddFolderInfoViewModel()<IDOMusicFileManagerDelegate>

@property (nonatomic,strong) NSMutableArray<IDOMusicDirectoryModel *> * folderItems;
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^addbuttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^textFeildCallback)(UIViewController * viewController,UITextField * textField,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^textFeildDidEditCallback)(UIViewController * viewController,UITextField * textField,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^labelSelectCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);

@end

@implementation AddFolderInfoViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getButtonCallback];
        [self getAddButtonCallback];
        [self getLabelCallback];
        [self getCellModels];
        [self initMusic];
    }
    return self;
}
-(void)initMusic
{
    [IDOMusicFileManager shareInstance].delegate = self;
}


- (NSMutableArray <IDOMusicDirectoryModel *>*)folderItems
{
    if (!_folderItems)
    {
        _folderItems = [NSMutableArray new];
    }
    return _folderItems;
}


- (void)getLabelCallback
{
   
}


- (void)getAddButtonCallback
{
    
    __weak typeof(self) weakSelf = self;
    self.addbuttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVc = (FuncViewController *)viewController;
        FuncViewController * newFuncVc = [FuncViewController new];
        FolderInfoViewModel * setModel = [FolderInfoViewModel new];
        setModel.musicDirectoryModel = nil;
        void(^addMusicDirectoryItemModelmComplete)(BOOL isSuccess,IDOMusicDirectoryModel *itemModel) =^(BOOL isSuccess,IDOMusicDirectoryModel *itemModel) {
            if (isSuccess) {
                [strongSelf.folderItems addObject:itemModel];
                [strongSelf getCellModels];
                [funcVc reloadData];
            }
        };
        setModel.addMusicDirectoryItemModelmComplete = addMusicDirectoryItemModelmComplete;
        newFuncVc.model = setModel;
        newFuncVc.title = lang(@"add folder info");
        [viewController.navigationController pushViewController:newFuncVc animated:YES];
    };
}

- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        [funcVC showLoadingWithMessage:lang(@"set data...")];
        [IDOMusicFileManager addMusicFiles:[strongSelf.folderItems copy]];
    };
}


- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    
    int index = 0;
    for (IDOMusicDirectoryModel * item in self.folderItems) {
        
        LabelCellModel * model = [[LabelCellModel alloc]init];
        model.typeStr = @"oneLabel";
        NSString * name = [NSString stringWithFormat:@"%@",item.folderName];
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
    model7.data = @[lang(@"add folder info")];
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
    
    
    self.cellModels = cellModels;
}

//获取音乐信息回调数据
- (void)getMusicFileInfoReplyModel:(IDOMusicInfoModel *)model
                         errorCode:(int)errorCode
{
    
}

- (void)musicFileTransferComplete:(int)errorCode {
    
}


- (void)musicFileTransferProgress:(float)progress {
    
}


- (void)operatMusicFileReplyErrorCode:(int)errorCode {
    FuncViewController * funcVC = (FuncViewController *)[IDODemoUtility getCurrentVC];
    if (errorCode == 0) {
        [funcVC showToastWithText:lang(@"set info success")];
    }
    else if (errorCode == 6) {
        [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
    }else {
        [funcVC showToastWithText:lang(@"set info failed")];
    }
}

@end
