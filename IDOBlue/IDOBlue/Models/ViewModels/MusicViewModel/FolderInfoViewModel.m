//
//  FolderInfoViewModel.m
//  IDOBlue
//
//  Created by huangkunhe on 2021/9/27.
//  Copyright © 2021 hedongyang. All rights reserved.
//

#import "FolderInfoViewModel.h"
#import "SwitchCellModel.h"
#import "OneSwitchTableViewCell.h"
#import "TextFieldCellModel.h"
#import "TwoTextFieldTableViewCell.h"
#import "EmpltyCellModel.h"
#import "EmptyTableViewCell.h"
#import "FuncCellModel.h"
#import "OneButtonTableViewCell.h"
#import "OneTextFieldTableViewCell.h"
#import "ThreeTextFieldTableViewCell.h"
#import "FuncViewController.h"
#import "LabelCellModel.h"
#import "OneLabelTableViewCell.h"

@interface FolderInfoViewModel ()

@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^switchCallback)(UIViewController * viewController,UISwitch * onSwitch,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^textFeildCallback)(UIViewController * viewController,UITextField * textField,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^textFeildDidEditCallback)(UIViewController * viewController,UITextField * textField,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^labelSelectCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy) NSMutableArray<IDOMusicFileModel *> * allAarray;
@property (nonatomic,copy) NSMutableArray<IDOMusicFileModel *> * selectedArray;
@property (nonatomic,strong) UITextField * textField1;
@property (nonatomic,strong) UITextField * textField2;
@end

@implementation FolderInfoViewModel

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        [self getTextFeildDidEditCallback];
        [self getButtonCallback];
        [self getLabelCallback];
        [self getCellModels];
    }
    return self;
}

- (IDOMusicDirectoryModel *)musicDirectoryModel
{
    if (!_musicDirectoryModel) {
         _musicDirectoryModel = [[IDOMusicDirectoryModel alloc]init];
    }
    return _musicDirectoryModel;
}

- (NSMutableArray<IDOMusicFileModel *> *)allAarray
{
    if (!_allAarray)
    {
        NSArray * array = [IDOMusicInfoModel currentModel].musicItems;
        if (array.count > 0) {
            _allAarray = [NSMutableArray arrayWithArray:array];
        }else {
            _allAarray = [NSMutableArray array];
        }
    }
    return _allAarray;
}

- (NSMutableArray<IDOMusicFileModel *> *)selectedArray
{
    if (!_selectedArray) {
        _selectedArray = [NSMutableArray array];
    }
    return _selectedArray;
}

- (void)getTextFeildDidEditCallback {
    __weak typeof(self) weakSelf = self;
    self.textFeildDidEditCallback = ^(UIViewController *viewController, UITextField *textField, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        if (indexPath.row == 0) {
            strongSelf.textField1 = textField;
        }else if (indexPath.row == 1) {
            strongSelf.textField2 = textField;
        }
        TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
        textFieldModel.data = @[textField.text];
    };
}

- (void)getLabelCallback
{
    __weak typeof(self) weakSelf = self;
    self.labelSelectCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        LabelCellModel * labelModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
        if (labelModel.isMultiSelect)labelModel.isSelected = !labelModel.isSelected;
        if (labelModel.isSelected) {
            [strongSelf.selectedArray addObject:strongSelf.allAarray[labelModel.index]];
        }else{
            [strongSelf.selectedArray removeObject:strongSelf.allAarray[labelModel.index]];
        }
        [funcVC.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    };
}


- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        strongSelf.musicDirectoryModel.musicNum = strongSelf.selectedArray.count;
        NSMutableArray * array = [NSMutableArray array];
        for (IDOMusicFileModel * item in strongSelf.selectedArray) {
            [array addObject:@(item.musicId)];
        }
        strongSelf.musicDirectoryModel.musicIdArray = array;
        strongSelf.musicDirectoryModel.folderName = strongSelf.textField1.text;
        strongSelf.musicDirectoryModel.folderId = [strongSelf.textField2.text integerValue];
        if (strongSelf.addMusicDirectoryItemModelmComplete) {
            strongSelf.addMusicDirectoryItemModelmComplete(YES, strongSelf.musicDirectoryModel);
            [funcVC.navigationController popViewControllerAnimated:YES];
        }
    };
}


- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    
    TextFieldCellModel * model10 = [[TextFieldCellModel alloc]init];
    model10.typeStr = @"oneTextField";
    model10.titleStr = lang(@"folderName");
    model10.data = @[self.musicDirectoryModel.folderName ?self.musicDirectoryModel.folderName:@""];
    model10.cellHeight = 70.0f;
    model10.cellClass = [OneTextFieldTableViewCell class];
    model10.modelClass = [NSNull class];
    model10.isShowLine = YES;
    model10.isShowKeyboard = YES;
    model10.textFeildCallback  = self.textFeildDidEditCallback;
    [cellModels addObject:model10];
    
    TextFieldCellModel * model12 = [[TextFieldCellModel alloc]init];
    model12.typeStr = @"oneTextField";
    model12.titleStr = lang(@"folderId");
    model12.data = @[@(self.musicDirectoryModel.folderId)];
    model12.cellHeight = 70.0f;
    model12.cellClass = [OneTextFieldTableViewCell class];
    model12.modelClass = [NSNull class];
    model12.isShowLine = YES;
    model12.isShowKeyboard = YES;
    model12.keyType = UIKeyboardTypeNumberPad;
    model12.textFeildCallback  = self.textFeildDidEditCallback;
    [cellModels addObject:model12];
    
    for (int i = 0; i < self.allAarray.count; i++) {
        LabelCellModel * model = [[LabelCellModel alloc]init];
        model.typeStr = @"oneLabel";
        IDOMusicFileModel * item = self.allAarray[i];
        model.data = @[item.musicName?:@""];
        model.cellHeight = 40.0f;
        model.cellClass = [OneLabelTableViewCell class];
        model.modelClass = [NSNull class];
        model.labelSelectCallback = self.labelSelectCallback;
        model.isShowLine = YES;
        model.index = i;
        model.isMultiSelect = YES;
        model.isSelected = NO;
        [cellModels addObject:model];
    }
    
    FuncCellModel * model9 = [[FuncCellModel alloc]init];
    model9.typeStr = @"oneButton";
    model9.data = @[lang(@"add folder info")];
    model9.cellHeight = 70.0f;
    model9.cellClass = [OneButtonTableViewCell class];
    model9.modelClass = [NSNull class];
    model9.isShowLine = YES;
    model9.buttconCallback = self.buttconCallback;
    [cellModels addObject:model9];
    
    self.cellModels = cellModels;
}

@end
