//
//  MusicInfoViewModel.m
//  IDOBlue
//
//  Created by huangkunhe on 2021/9/27.
//  Copyright © 2021 hedongyang. All rights reserved.
//

#import "MusicInfoViewModel.h"
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


@interface MusicInfoViewModel ()

@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^switchCallback)(UIViewController * viewController,UISwitch * onSwitch,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^textFeildCallback)(UIViewController * viewController,UITextField * textField,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^textFeildDidEditCallback)(UIViewController * viewController,UITextField * textField,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^labelSelectCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic, copy)NSArray * notifyStateArray;
@property (nonatomic,strong) UITextField * textField1;
@property (nonatomic,strong) UITextField * textField2;
@property (nonatomic,strong) UITextField * textField3;
@property (nonatomic,strong) UITextField * textField4;
@end

@implementation MusicInfoViewModel

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        [self getTextFeildDidEditCallback];
        [self getButtonCallback];
        [self getCellModels];
    }
    
    return self;
}

- (IDOMusicFileModel *)musicItemModel
{
    if (!_musicItemModel) {
         _musicItemModel = [[IDOMusicFileModel alloc] init];
    }
    return _musicItemModel;
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
        }else if (indexPath.row == 2) {
            strongSelf.textField3 = textField;
        }else {
            strongSelf.textField4 = textField;
        }
        TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
        textFieldModel.data = @[textField.text];
    };
}


- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        strongSelf.musicItemModel.musicName = strongSelf.textField1.text?:@"";
        strongSelf.musicItemModel.singerName = strongSelf.textField2.text?:@"";
        strongSelf.musicItemModel.musicId = [strongSelf.textField3.text integerValue];
        strongSelf.musicItemModel.musicMemory = [strongSelf.textField4.text integerValue];
        if (strongSelf.addMusicFileItemModelmComplete) {
            strongSelf.addMusicFileItemModelmComplete(YES, strongSelf.musicItemModel);
            [funcVC.navigationController popViewControllerAnimated:YES];
        }
    };
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    
    TextFieldCellModel * model10 = [[TextFieldCellModel alloc]init];
    model10.typeStr = @"oneTextField";
    model10.titleStr = lang(@"musicName");
    model10.data = @[self.musicItemModel.musicName ?self.musicItemModel.musicName:@""];
    model10.cellHeight = 70.0f;
    model10.cellClass = [OneTextFieldTableViewCell class];
    model10.modelClass = [NSNull class];
    model10.isShowLine = YES;
    model10.isShowKeyboard = YES;
    model10.textFeildCallback  = self.textFeildDidEditCallback;
    [cellModels addObject:model10];
    
    TextFieldCellModel * model11 = [[TextFieldCellModel alloc]init];
    model11.typeStr = @"oneTextField";
    model11.titleStr = lang(@"singerName");
    model11.data = @[self.musicItemModel.singerName ?self.musicItemModel.singerName:@""];
    model11.cellHeight = 70.0f;
    model11.cellClass = [OneTextFieldTableViewCell class];
    model11.modelClass = [NSNull class];
    model11.isShowLine = YES;
    model11.isShowKeyboard = YES;
    model11.textFeildCallback  = self.textFeildDidEditCallback;
    [cellModels addObject:model11];
    
    TextFieldCellModel * model12 = [[TextFieldCellModel alloc]init];
    model12.typeStr = @"oneTextField";
    model12.titleStr = lang(@"musicId");
    model12.data = @[@(self.musicItemModel.musicId)];
    model12.cellHeight = 70.0f;
    model12.cellClass = [OneTextFieldTableViewCell class];
    model12.modelClass = [NSNull class];
    model12.isShowLine = YES;
    model12.isShowKeyboard = YES;
    model12.keyType = UIKeyboardTypeNumberPad;
    model12.textFeildCallback  = self.textFeildDidEditCallback;
    [cellModels addObject:model12];
    
    TextFieldCellModel * model13 = [[TextFieldCellModel alloc]init];
    model13.typeStr = @"oneTextField";
    model13.titleStr = lang(@"musicMemory");
    model13.data = @[@(self.musicItemModel.musicMemory)];
    model13.cellHeight = 70.0f;
    model13.cellClass = [OneTextFieldTableViewCell class];
    model13.modelClass = [NSNull class];
    model13.isShowLine = YES;
    model13.isShowKeyboard = YES;
    model13.keyType = UIKeyboardTypeNumberPad;
    model13.textFeildCallback  = self.textFeildDidEditCallback;
    [cellModels addObject:model13];

    FuncCellModel * model9 = [[FuncCellModel alloc]init];
    model9.typeStr = @"oneButton";
    model9.data = @[lang(@"setup")];
    model9.cellHeight = 70.0f;
    model9.cellClass = [OneButtonTableViewCell class];
    model9.modelClass = [NSNull class];
    model9.isShowLine = YES;
    model9.buttconCallback = self.buttconCallback;
    [cellModels addObject:model9];
    
    self.cellModels = cellModels;
}


@end
