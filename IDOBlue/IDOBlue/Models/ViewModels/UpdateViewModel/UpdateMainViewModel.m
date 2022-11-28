//
//  UpdateMainViewModel.m
//  IDOBlue
//
//  Created by apple on 2018/10/4.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "UpdateMainViewModel.h"
#import "FuncCellModel.h"
#import "OneButtonTableViewCell.h"
#import "FuncViewController.h"
#import "UpdateFirmwareViewModel.h"
#import "UpdateAgpsViewModel.h"
#import "UpdatePhotoViewModel.h"
#import "UpdateMessageIconViewModel.h"
#import "UpdateSportIconViewModel.h"
#import "UpateContactViewModel.h"
#import "ScanViewController.h"
#import "UpdateFileViewModel.h"

@interface UpdateMainViewModel()
@property (nonatomic,strong) NSArray * buttonTitles;
@property (nonatomic,strong) NSArray * modelClasss;
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation UpdateMainViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        NSInteger modeType = [[NSUserDefaults standardUserDefaults]integerForKey:PRODUCTION_MODE_KEY];
        if (modeType == 1) {
            self.isLeftButton = YES;
            self.leftButtonTitle = lang(@"exit update");
            self.leftButton = @selector(exitUpdate);
        }
        [self getButtonCallback];
        [self getCellModels];
    }
    return self;
}

- (void)exitUpdate
{
    FuncViewController * funcVC = (FuncViewController *)[IDODemoUtility getCurrentVC];
    [funcVC showLoadingWithMessage:lang(@"exit update...")];
    [IDOFoundationCommand mandatoryUnbindingCommand:^(int errorCode, NSString * _Nullable undindMacAddr) {
        if (errorCode == 0) {
            [funcVC showToastWithText:lang(@"exit success")];
            ScanViewController * scanVC  = [[ScanViewController alloc]init];
            UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:scanVC];
            [UIApplication sharedApplication].delegate.window.rootViewController = nav;
        }else {
            [funcVC showToastWithText:lang(@"exit failed")];
        }
    }];
}

- (NSArray *)buttonTitles
{
    if (!_buttonTitles) {
        _buttonTitles = @[@[lang(@"nordic update")],@[lang(@"realtk update")],
                          @[lang(@"apollo update")],@[lang(@"word update")],
                          @[lang(@"agps update")],@[lang(@"file update")],@[lang(@"contact update")],
                          @[lang(@"photo update")],@[lang(@"update message icon")],
                          @[lang(@"update sport icon")]];
    }
    return _buttonTitles;
}

- (NSArray *)modelClasss
{
    if (!_modelClasss) {
        _modelClasss = @[[UpdateFirmwareViewModel class],[UpdateFirmwareViewModel class],
                         [UpdateFirmwareViewModel class],[UpdateFirmwareViewModel class],
                         [UpdateAgpsViewModel class],[UpdateFileViewModel class],[UpateContactViewModel class],
                         [UpdatePhotoViewModel class],[UpdateMessageIconViewModel class],
                         [UpdateSportIconViewModel class]];
    }
    return _modelClasss;
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    for (int i = 0; i < self.buttonTitles.count; i++) {
        NSArray * data = [self.buttonTitles objectAtIndex:i];
        FuncCellModel * model = [[FuncCellModel alloc]init];
        model.typeStr = @"oneButton";
        model.data    = data;
        model.cellHeight = 70.0f;
        model.cellClass  = [OneButtonTableViewCell class];
        model.modelClass = self.modelClasss[i];
        model.buttconCallback = self.buttconCallback;
        [cellModels addObject:model];
    }
    self.cellModels = cellModels;
}

- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVc = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVc.tableView indexPathForCell:tableViewCell];
        BaseCellModel * model = [strongSelf.cellModels objectAtIndex:indexPath.row];
        if ([NSStringFromClass(model.modelClass)isEqualToString:@"NSNull"])return;
        FuncViewController * newFuncVc = [FuncViewController new];
        BaseViewModel * viewModel = [model.modelClass new];
        if ([viewModel isKindOfClass:[UpdateFirmwareViewModel class]]) {
            UpdateFirmwareViewModel * firmwareModel = (UpdateFirmwareViewModel *)viewModel;
            firmwareModel.platformType = indexPath.row;
        }
        newFuncVc.model = viewModel;
        newFuncVc.title = [model.data firstObject];
        [funcVc.navigationController pushViewController:newFuncVc animated:YES];
    };
}
@end
