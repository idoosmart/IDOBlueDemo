//
//  SetFolderInfoViewModel.m
//  IDOBlue
//
//  Created by huangkunhe on 2021/9/27.
//  Copyright © 2021 hedongyang. All rights reserved.
//

#import "SetFolderInfoViewModel.h"
#import "LabelCellModel.h"
#import "OneLabelTableViewCell.h"
#import "FuncViewController.h"
#import "EmpltyCellModel.h"
#import "EmptyTableViewCell.h"

@interface SetFolderInfoViewModel()<IDOMusicFileManagerDelegate>
@property (nonatomic,strong) NSArray * allfolderInfo;
@property (nonatomic,copy)void(^labelSelectCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation SetFolderInfoViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getLabelCallback];
        [self getDelectCellCallback];
        [self getCellModels];
        [self initMusic];
    }
    return self;
}

-(void)initMusic
{
    [IDOMusicFileManager shareInstance].delegate = self;
}


- (NSArray *)allfolderInfo
{
    if (!_allfolderInfo) {
         _allfolderInfo = [IDOMusicInfoModel currentModel].folderItems;
    }
    return _allfolderInfo;
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    self.allfolderInfo = nil;
    for (int i = 0; i < self.allfolderInfo.count; i++) {
        IDOMusicDirectoryModel * folderModel = [self.allfolderInfo objectAtIndex:i];
        LabelCellModel * model = [[LabelCellModel alloc]init];
        model.typeStr = @"oneLabel";
        model.data    = @[folderModel.folderName?:@""];
        model.cellHeight = 70.0f;
        model.cellClass  = [OneLabelTableViewCell class];
        model.modelClass = [NSNull class];
        model.isDelete = YES;
        model.isShowLine = YES;
        model.labelSelectCallback = self.labelSelectCallback;
        [cellModels addObject:model];
    }
    
    self.cellModels = cellModels;
}

- (void)getLabelCallback
{
   
}

- (void)getDelectCellCallback
{
    __weak typeof(self) weakSelf = self;
    self.delectCellCallback = ^(UIViewController *viewController, NSIndexPath *indexPath) {
          __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVc = (FuncViewController *)viewController;
        IDOMusicDirectoryModel * model = strongSelf.allfolderInfo[indexPath.row];
        [IDOMusicFileManager deleteMusicFolders:@[model]];
        [funcVc showLoadingWithMessage:[NSString stringWithFormat:@"%@...",lang(@"delete current folder")]];
    };
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

//获取音乐信息回调数据
- (void)getMusicFileInfoReplyModel:(IDOMusicInfoModel *)model
                         errorCode:(int)errorCode
{
    FuncViewController * funcVC = (FuncViewController *)[IDODemoUtility getCurrentVC];
    if (errorCode == 0) {
        [funcVC showToastWithText:lang(@"get list info success")];
        [self getCellModels];
        [funcVC reloadData];
    }else if (errorCode == 6) {
        [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
    }else {
        [funcVC showToastWithText:lang(@"get list info failed")];
    }
}

@end
