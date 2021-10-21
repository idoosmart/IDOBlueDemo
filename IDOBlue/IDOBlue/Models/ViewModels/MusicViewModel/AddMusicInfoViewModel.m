//
//  AddMusicInfoViewModel.m
//  IDOBlue
//
//  Created by huangkunhe on 2021/9/27.
//  Copyright © 2021 hedongyang. All rights reserved.
//

#import "AddMusicInfoViewModel.h"
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
#import "MusicInfoViewModel.h"

@interface AddMusicInfoViewModel()<IDOMusicFileManagerDelegate>

@property (nonatomic,strong) NSMutableArray<IDOMusicFileModel *> * musicItems;
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^addbuttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^textFeildCallback)(UIViewController * viewController,UITextField * textField,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^textFeildDidEditCallback)(UIViewController * viewController,UITextField * textField,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^labelSelectCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);

@end

@implementation AddMusicInfoViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getButtonCallback];
        [self getAddButtonCallback];
        [self getCellModels];
        [self initMusic];
    }
    return self;
}

-(void)initMusic
{
    [IDOMusicFileManager shareInstance].delegate = self;
}

- (NSMutableArray <IDOMusicFileModel *>*)musicItems
{
    if (!_musicItems){
         _musicItems = [NSMutableArray new];
    }
    return _musicItems;
}

- (void)getAddButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.addbuttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVc = (FuncViewController *)viewController;
        FuncViewController * newFuncVc = [FuncViewController new];
        MusicInfoViewModel * setModel = [MusicInfoViewModel new];
        setModel.musicItemModel = nil;
        void(^addMusicFileItemModelmComplete)(BOOL isSuccess,IDOMusicFileModel *itemModel) =^(BOOL isSuccess,IDOMusicFileModel *itemModel) {
            if (isSuccess) {
                [strongSelf.musicItems addObject:itemModel];
                [strongSelf getCellModels];
                [funcVc reloadData];
            }
        };
        setModel.addMusicFileItemModelmComplete = addMusicFileItemModelmComplete;
        newFuncVc.model = setModel;
        newFuncVc.title = lang(@"add music info");
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
        IDOMusicFileModel * model = strongSelf.musicItems.lastObject;
    };
}


- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    
    int index = 0;
    for (IDOMusicFileModel * item in self.musicItems) {
        LabelCellModel * model = [[LabelCellModel alloc]init];
        model.typeStr = @"oneLabel";
        NSString * name = [NSString stringWithFormat:@"%@",item.musicName];
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
    
    if (self.musicItems.count > 0) {
        EmpltyCellModel * model6 = [[EmpltyCellModel alloc]init];
        model6.typeStr = @"empty";
        model6.cellHeight = 30.0f;
        model6.isShowLine = YES;
        model6.cellClass  = [EmptyTableViewCell class];
        [cellModels addObject:model6];
    }
    
    FuncCellModel * model7 = [[FuncCellModel alloc]init];
    model7.typeStr = @"oneButton";
    model7.data = @[lang(@"add music info")];
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

- (void)operatMusicFileReplyErrorCode:(int)errorCode {
    FuncViewController * funcVC = (FuncViewController *)[IDODemoUtility getCurrentVC];
    if (errorCode == 0) {
        [funcVC showToastWithText:lang(@"set info success")];
        [IDOMusicFileManager getMusicInfo];
    }else if (errorCode == 6) {
        [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
    }else {
        [funcVC showToastWithText:lang(@"set info failed")];
    }
}

@end
