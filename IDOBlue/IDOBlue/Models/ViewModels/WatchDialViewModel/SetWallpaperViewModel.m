//
//  SetWallpaperViewModel.m
//  IDOBlue
//
//  Created by hedongyang on 2021/5/20.
//  Copyright © 2021 hedongyang. All rights reserved.
//

#import "SetWallpaperViewModel.h"
#import "TextFieldCellModel.h"
#import "UpdatePhotoViewModel.h"
#import "OneTextFieldTableViewCell.h"
#import "FuncViewController.h"
#import "FuncCellModel.h"
#import "TextViewCellModel.h"
#import "NSObject+DemoToDic.h"
#import "OneTextViewTableViewCell.h"
#import "OneButtonTableViewCell.h"

@interface SetWallpaperViewModel ()
@property (nonatomic,strong) IDOV3WallpaperDialInfoModel * wallpaperModel;
@property (nonatomic,strong) NSArray * titleArray;
@property (nonatomic,strong) NSArray * dataArray;
@property (nonatomic,strong) UITextView * textView;
@property (nonatomic,copy)void(^textViewCallback)(UITextView * textView);
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^textFeildCallback)(UIViewController * viewController,UITextField * textField,UITableViewCell * tableViewCell);
@end

@implementation SetWallpaperViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.titleArray = @[lang(@"display position"),lang(@"hidden display"),lang(@"icon type"),lang(@"time color"),lang(@"widget icon type"),lang(@"widget number type")];
        NSString * locStr = self.pickerDataModel.wallpaperLoc[self.wallpaperModel.location];
        NSString * hideStr = self.pickerDataModel.hideType[self.wallpaperModel.hideType];
        NSString * widgetStr = self.pickerDataModel.widgetType[self.wallpaperModel.widgetType];
        self.dataArray = @[locStr,hideStr,widgetStr,self.wallpaperModel.timeColor?:@"#FFFFFF",
                           self.wallpaperModel.widgetIconColor?:@"#FFFFFF",self.wallpaperModel.widgetNumColor?:@"#FFFFFF"];
        [self getTextViewCallback];
        [self getButtonCallback];
        [self getTextFieldCallback];
        [self getCellModels];
    }
    return self;
}

- (IDOV3WallpaperDialInfoModel *)wallpaperModel
{
    if (!_wallpaperModel) {
         _wallpaperModel = [IDOV3WallpaperDialInfoModel currentModel];
    }
    return _wallpaperModel;
}

- (void)getCellModels
{
    
    NSMutableArray * cellModels = [NSMutableArray array];
    for (int i = 0; i < 6; i++) {
        TextFieldCellModel * model = [[TextFieldCellModel alloc]init];
        model.typeStr  = @"oneTextField";
        model.titleStr = self.titleArray[i]?:@"";
        model.data = @[self.dataArray[i]?:@""];
        model.cellHeight = 70.0f;
        model.cellClass  = [OneTextFieldTableViewCell class];
        model.modelClass = [NSNull class];
        model.textFeildCallback = self.textFeildCallback;
        model.isShowLine = YES;
        [cellModels addObject:model];
    }
    
    FuncCellModel * model = [[FuncCellModel alloc]init];
    model.typeStr = @"oneButton";
    model.data    = @[lang(@"set wallpaper parameters")];
    model.cellHeight = 70.0f;
    model.cellClass  = [OneButtonTableViewCell class];
    model.buttconCallback = self.buttconCallback;
    [cellModels addObject:model];
    
    FuncCellModel * model1 = [[FuncCellModel alloc]init];
    model1.typeStr = @"oneButton";
    model1.data    = @[lang(@"delete the wallpaper dial")];
    model1.cellHeight = 70.0f;
    model1.cellClass  = [OneButtonTableViewCell class];
    model1.buttconCallback = self.buttconCallback;
    [cellModels addObject:model1];
    
    FuncCellModel * model2 = [[FuncCellModel alloc]init];
    model2.typeStr = @"oneButton";
    model2.data    = @[lang(@"transfer the wallpaper dial")];
    model2.cellHeight = 70.0f;
    model2.cellClass  = [OneButtonTableViewCell class];
    model2.buttconCallback = self.buttconCallback;
    [cellModels addObject:model2];
    
    FuncCellModel * model3 = [[FuncCellModel alloc]init];
    model3.typeStr = @"oneButton";
    model3.data    = @[lang(@"get wallpaper dial info")];
    model3.cellHeight = 70.0f;
    model3.cellClass  = [OneButtonTableViewCell class];
    model3.buttconCallback = self.buttconCallback;
    [cellModels addObject:model3];
    
    TextViewCellModel * model4 = [[TextViewCellModel alloc]init];
    model4.typeStr = @"oneTextView";
    model4.cellHeight = 220;
    model4.cellClass  = [OneTextViewTableViewCell class];
    model4.textViewCallback = self.textViewCallback;
    model4.data = @[@""];
    [cellModels addObject:model4];
    
    self.cellModels = cellModels;
}

- (void)getTextViewCallback
{
    __weak typeof(self) weakSelf = self;
    self.textViewCallback = ^(UITextView *textView) {
        __strong typeof(self) strongSelf = weakSelf;
        strongSelf.textView = textView;
    };
}

- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVc = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVc.tableView indexPathForCell:tableViewCell];
        if (indexPath.row == 6) {
            [funcVc showLoadingWithMessage:[NSString stringWithFormat:@"%@...",lang(@"set wallpaper parameters")]];
            strongSelf.wallpaperModel.operate = 0x01;
            initWatchDialManager().setWallpaperDialInfo(^(int errorCode) {
                if (errorCode == 0) {
                    [funcVc showToastWithText:lang(@"set wallpaper parameters success")];
                }else if (errorCode == 6) {
                    [funcVc showToastWithText:lang(@"feature is not supported on the current device")];
                }else {
                    [funcVc showToastWithText:lang(@"set wallpaper parameters failed")];
                }
            }, strongSelf.wallpaperModel);
        }else if (indexPath.row == 7) {
            [funcVc showLoadingWithMessage:[NSString stringWithFormat:@"%@...",lang(@"delete the wallpaper dial")]];
            strongSelf.wallpaperModel.operate = 0x02;
            initWatchDialManager().setWallpaperDialInfo(^(int errorCode) {
                if (errorCode == 0) {
                    [funcVc showToastWithText:lang(@"delete the wallpaper dial success")];
                }else if (errorCode == 6) {
                    [funcVc showToastWithText:lang(@"feature is not supported on the current device")];
                }else {
                    [funcVc showToastWithText:lang(@"delete the wallpaper dial failed")];
                }
            }, strongSelf.wallpaperModel);
        }else if (indexPath.row == 8) {
            FuncViewController * newFuncVc = [FuncViewController new];
            newFuncVc.model = [UpdatePhotoViewModel new];
            newFuncVc.title = lang(@"transfer the wallpaper dial");
            [funcVc.navigationController pushViewController:newFuncVc animated:YES];
        }else if (indexPath.row == 9) {
            [funcVc showLoadingWithMessage:[NSString stringWithFormat:@"%@...",lang(@"get wallpaper dial info")]];
            initWatchDialManager().getWallpaperDialInfo(^(IDOV3WallpaperDialInfoModel * _Nullable model, int errorCode) {
                if (errorCode == 0) {
                    [funcVc showToastWithText:lang(@"get wallpaper dial info success")];
                    NSDictionary * dic = model.dicFromObject;
                    strongSelf.textView.text = [NSString stringWithFormat:@"%@",dic];
                }else if (errorCode == 6) {
                    [funcVc showToastWithText:lang(@"feature is not supported on the current device")];
                }else {
                    [funcVc showToastWithText:lang(@"get wallpaper dial info failed")];
                }
            });
        }
    };
}

- (void)getTextFieldCallback
{
    __weak typeof(self) weakSelf = self;
    self.textFeildCallback = ^(UIViewController *viewController, UITextField *textField, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        if(indexPath.row == 0) {
            TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
            funcVC.pickerView.pickerArray  = strongSelf.pickerDataModel.wallpaperLoc;
            funcVC.pickerView.currentIndex = [strongSelf.pickerDataModel.wallpaperLoc containsObject:textField.text] ?
            [strongSelf.pickerDataModel.wallpaperLoc indexOfObject:textField.text] : 0 ;
            [funcVC.pickerView show];
            funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
                textField.text = selectStr;
                textFieldModel.data = @[selectStr?:@""];
                [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                strongSelf.wallpaperModel.location = [strongSelf.pickerDataModel.wallpaperLoc containsObject:selectStr];
            };
        }else if (indexPath.row == 1) {
            TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
            funcVC.pickerView.pickerArray  = strongSelf.pickerDataModel.hideType;
            funcVC.pickerView.currentIndex = [strongSelf.pickerDataModel.hideType containsObject:textField.text] ?
            [strongSelf.pickerDataModel.hideType indexOfObject:textField.text] : 0 ;
            [funcVC.pickerView show];
            funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
                textField.text = selectStr;
                textFieldModel.data = @[selectStr?:@""];
                [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                strongSelf.wallpaperModel.hideType = [strongSelf.pickerDataModel.hideType containsObject:selectStr];
            };
        }else if (indexPath.row == 2) {
            TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
            funcVC.pickerView.pickerArray  = strongSelf.pickerDataModel.widgetType;
            funcVC.pickerView.currentIndex = [strongSelf.pickerDataModel.widgetType containsObject:textField.text] ?
            [strongSelf.pickerDataModel.widgetType indexOfObject:textField.text] : 0 ;
            [funcVC.pickerView show];
            funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
                textField.text = selectStr;
                textFieldModel.data = @[selectStr?:@""];
                [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                strongSelf.wallpaperModel.widgetType = [strongSelf.pickerDataModel.widgetType containsObject:selectStr];
            };
        }else if (indexPath.row == 3) {
            TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
            funcVC.pickerView.pickerArray  = strongSelf.pickerDataModel.widgetColor;
            funcVC.pickerView.currentIndex = [strongSelf.pickerDataModel.widgetColor containsObject:textField.text] ?
            [strongSelf.pickerDataModel.widgetColor indexOfObject:textField.text] : 0 ;
            [funcVC.pickerView show];
            funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
                textField.text = selectStr;
                textFieldModel.data = @[selectStr?:@""];
                [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                strongSelf.wallpaperModel.timeColor = selectStr;
            };
        }else if (indexPath.row == 4) {
            TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
            funcVC.pickerView.pickerArray  = strongSelf.pickerDataModel.widgetColor;
            funcVC.pickerView.currentIndex = [strongSelf.pickerDataModel.widgetColor containsObject:textField.text] ?
            [strongSelf.pickerDataModel.widgetColor indexOfObject:textField.text] : 0 ;
            [funcVC.pickerView show];
            funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
                textField.text = selectStr;
                textFieldModel.data = @[selectStr?:@""];
                [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                strongSelf.wallpaperModel.widgetIconColor = selectStr;
            };
        }else if (indexPath.row == 5) {
            TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
            funcVC.pickerView.pickerArray  = strongSelf.pickerDataModel.widgetColor;
            funcVC.pickerView.currentIndex = [strongSelf.pickerDataModel.widgetColor containsObject:textField.text] ?
            [strongSelf.pickerDataModel.widgetColor indexOfObject:textField.text] : 0 ;
            [funcVC.pickerView show];
            funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
                textField.text = selectStr;
                textFieldModel.data = @[selectStr?:@""];
                [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                strongSelf.wallpaperModel.widgetNumColor = selectStr;
            };
        }
    };
}

@end
