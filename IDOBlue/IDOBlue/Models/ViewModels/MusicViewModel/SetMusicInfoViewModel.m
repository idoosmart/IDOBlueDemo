//
//  SetMusicInfoViewModel.m
//  IDOBlue
//
//  Created by huangkunhe on 2021/9/27.
//  Copyright © 2021 hedongyang. All rights reserved.
//

#import "SetMusicInfoViewModel.h"
#import "LabelCellModel.h"
#import "OneLabelTableViewCell.h"
#import "FuncViewController.h"
#import "EmpltyCellModel.h"
#import "EmptyTableViewCell.h"

@interface SetMusicInfoViewModel()<IDOMusicFileManagerDelegate>
@property (nonatomic,strong) NSArray * allMusicInfo;
@property (nonatomic,copy)void(^labelSelectCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation SetMusicInfoViewModel

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

- (void)actionButton:(UIButton *)sender
{
    FuncViewController * vc = [[FuncViewController alloc]init];
    [[IDODemoUtility getCurrentVC].navigationController pushViewController:vc animated:YES];
}


- (NSArray *)allMusicInfo
{
    if (!_allMusicInfo) {
        _allMusicInfo = [IDOMusicInfoModel currentModel].musicItems;
    }
    return _allMusicInfo;
}

-(void)initMusic
{
    [IDOMusicFileManager shareInstance].delegate = self;
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    self.allMusicInfo = nil;
    for (int i = 0; i < self.allMusicInfo.count; i++) {
        IDOMusicFileModel * musicModel = [self.allMusicInfo objectAtIndex:i];
        LabelCellModel * model = [[LabelCellModel alloc]init];
        model.typeStr = @"oneLabel";
        model.data    = @[musicModel.musicName?:@""];
        model.cellHeight = 70.0f;
        model.cellClass  = [OneLabelTableViewCell class];
        model.modelClass = [NSNull class];
        model.isDelete = YES;
        model.isShowLine = YES;
        model.labelSelectCallback = self.labelSelectCallback;
        [cellModels addObject:model];
    }
    EmpltyCellModel * model3 = [[EmpltyCellModel alloc]init];
    model3.typeStr = @"empty";
    model3.cellHeight = 30.0f;
    model3.isShowLine = YES;
    model3.cellClass  = [EmptyTableViewCell class];
    [cellModels addObject:model3];
    
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
        IDOMusicFileModel * model = strongSelf.allMusicInfo[indexPath.row];
        [IDOMusicFileManager deleteMusicFiles:@[model]];
        [funcVc showLoadingWithMessage:[NSString stringWithFormat:@"%@...",lang(@"delete current music")]];
        
    };
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
