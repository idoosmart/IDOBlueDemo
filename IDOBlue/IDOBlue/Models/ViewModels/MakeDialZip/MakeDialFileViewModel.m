//
//  MakeDialZipFile.m
//  IDOBlue
//
//  Created by hedongyang on 2021/6/2.
//  Copyright © 2021 hedongyang. All rights reserved.
//

#import "MakeDialFileViewModel.h"
#import "FileViewModel.h"
#import "LabelCellModel.h"
#import "FuncCellModel.h"
#import "EmpltyCellModel.h"
#import "FuncViewController.h"
#import "OneLabelTableViewCell.h"
#import "OneButtonTableViewCell.h"
#import "EmptyTableViewCell.h"

@interface MakeDialFileViewModel ()
@property (nonatomic,strong) NSMutableArray * fileItems;
@property (nonatomic,copy) NSString * filePath;
@end

@implementation MakeDialFileViewModel

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:SANDBOX_FILE_PATH_KEY];
        self.rightButtonTitle = lang(@"selected firmware");
        self.isRightButton = YES;
        self.rightButton   = @selector(actionButton:);
        [[NSNotificationCenter defaultCenter]addObserver:self
                                                selector:@selector(selectFileNotice:)
                                                    name:@"idoDemoSelectFileNotice"
                                                  object:nil];
        [self getCellModels];
    }
    return self;
}

- (NSMutableArray *)fileItems
{
    if (!_fileItems) {
        _fileItems = [NSMutableArray array];
    }
    return _fileItems;
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    for (int i = 0; i < self.fileItems.count; i++) {
        LabelCellModel * model = [[LabelCellModel alloc]init];
        model.typeStr = @"oneLabel";
        model.data = @[self.fileItems[i]];
        model.cellHeight = 70.0f;
        model.cellClass = [OneLabelTableViewCell class];
        model.modelClass = [NSNull class];
        model.isShowLine = YES;
        [cellModels addObject:model];
    }
    self.cellModels = cellModels;
}


- (void)selectFileNotice:(NSNotification *)notification
{
    BOOL isDir = NO;
    [self.fileItems removeAllObjects];
    self.filePath = [[NSUserDefaults standardUserDefaults]objectForKey:SANDBOX_FILE_PATH_KEY];
    [[NSFileManager defaultManager] fileExistsAtPath:self.filePath isDirectory:&isDir];
    if (isDir) {
        NSArray * fileList =  [[NSFileManager defaultManager] contentsOfDirectoryAtPath:self.filePath error:nil];
        [self.fileItems addObjectsFromArray:fileList];
    }else {
        NSURL * url = [NSURL URLWithString:self.filePath];
        [self.fileItems addObject:url.lastPathComponent];
    }
    [self getCellModels];
    FuncViewController * vc = (FuncViewController *)[IDODemoUtility getCurrentVC];
    [vc reloadData];
}

- (void)actionButton:(id)sender
{
    FuncViewController * vc = [[FuncViewController alloc]init];
    FileViewModel * fileModel = [FileViewModel new];
    fileModel.isCanSelectDir = YES;
    fileModel.type = 2;
    vc.model = fileModel;
    vc.title = lang(@"selected firmware");
    [[IDODemoUtility getCurrentVC].navigationController pushViewController:vc animated:YES];
}



@end
