//
//  AppDataInterchangeModel.m
//  IDOBlue
//
//  Created by hedongyang on 2018/10/10.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "AppDataInterchangeModel.h"
#import "FileViewModel.h"
#import "FuncCellModel.h"
#import "EmpltyCellModel.h"
#import "TextViewCellModel.h"
#import "FuncViewController.h"
#import "EmptyTableViewCell.h"
#import "OneButtonTableViewCell.h"
#import "OneTextViewTableViewCell.h"
#import "TextFieldCellModel.h"
#import "OneTextFieldTableViewCell.h"
#import "TwoTextFieldTableViewCell.h"
#import "NSObject+DemoToDic.h"


@interface AppDataInterchangeModel()
@property (nonatomic,strong) UITextView * textView;
@property (nonatomic,strong) IDODataExchangeModel * dataModel;
@property (nonatomic,copy)void(^textViewCallback)(UITextView * textView);
@property (nonatomic,copy)void(^textFeildCallback)(UIViewController * viewController,UITextField * textField,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation AppDataInterchangeModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getButtonCallback];
        [self getTextFieldCallback];
        [self getTextViewCallback];
        [self listenBlueControl];
        [self getCellModels];
    }
    return self;
}

- (IDODataExchangeModel *)dataModel
{
    if (!_dataModel) {
        _dataModel = [IDODataExchangeModel new];
    }
    return _dataModel;
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    TextViewCellModel * model8 = [[TextViewCellModel alloc]init];
    model8.typeStr = @"oneTextView";
    model8.textViewCallback = self.textViewCallback;
    model8.isShowLine = YES;
    model8.cellHeight = [UIScreen mainScreen].bounds.size.height / 2 - 20;
    model8.cellClass  = [OneTextViewTableViewCell class];
    [cellModels addObject:model8];
    
    EmpltyCellModel * model7 = [[EmpltyCellModel alloc]init];
    model7.typeStr = @"empty";
    model7.cellHeight = 30.0f;
    model7.isShowLine = YES;
    model7.cellClass  = [EmptyTableViewCell class];
    [cellModels addObject:model7];
    
    FuncCellModel * model1 = [[FuncCellModel alloc]init];
    model1.typeStr = @"oneButton";
    model1.data    = @[lang(@"app start activity")];
    model1.cellHeight = 70.0f;
    model1.isShowLine = YES;
    model1.index = 0;
    model1.buttconCallback = self.buttconCallback;
    model1.cellClass  = [OneButtonTableViewCell class];
    [cellModels addObject:model1];
    
    FuncCellModel * model2 = [[FuncCellModel alloc]init];
    model2.typeStr = @"oneButton";
    model2.data    = @[lang(@"app suspended activity")];
    model2.cellHeight = 70.0f;
    model2.isShowLine = YES;
    model2.index = 1;
    model2.buttconCallback = self.buttconCallback;
    model2.cellClass  = [OneButtonTableViewCell class];
    [cellModels addObject:model2];
    
    FuncCellModel * model3 = [[FuncCellModel alloc]init];
    model3.typeStr = @"oneButton";
    model3.data    = @[lang(@"app restore activity")];
    model3.cellHeight = 70.0f;
    model3.isShowLine = YES;
    model3.index = 2;
    model3.buttconCallback = self.buttconCallback;
    model3.cellClass  = [OneButtonTableViewCell class];
    [cellModels addObject:model3];
    
    FuncCellModel * model4 = [[FuncCellModel alloc]init];
    model4.typeStr = @"oneButton";
    model4.data    = @[lang(@"app stop activity")];
    model4.cellHeight = 70.0f;
    model4.isShowLine = YES;
    model4.index = 3;
    model4.buttconCallback = self.buttconCallback;
    model4.cellClass  = [OneButtonTableViewCell class];
    [cellModels addObject:model4];
    
    FuncCellModel * model10 = [[FuncCellModel alloc]init];
    model10.typeStr = @"oneButton";
    model10.data    = @[lang(@"app activity send data")];
    model10.cellHeight = 70.0f;
    model10.isShowLine = YES;
    model10.index = 4;
    model10.buttconCallback = self.buttconCallback;
    model10.cellClass  = [OneButtonTableViewCell class];
    [cellModels addObject:model10];
    
    TextFieldCellModel * model5 = [[TextFieldCellModel alloc]init];
    model5.typeStr = @"oneTextField";
    model5.titleStr = lang(@"activity type:");
    model5.data = @[self.pickerDataModel.sportTypes[0]];
    model5.cellHeight = 70.0f;
    model5.cellClass = [OneTextFieldTableViewCell class];
    model5.modelClass = [NSNull class];
    model5.index = 0;
    model5.isShowLine = YES;
    model5.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model5];
    
    TextFieldCellModel * model6 = [[TextFieldCellModel alloc]init];
    model6.typeStr = @"oneTextField";
    model6.titleStr = lang(@"target unit:");
    model6.data = @[self.pickerDataModel.targetTypes[0]];
    model6.cellHeight = 70.0f;
    model6.cellClass = [OneTextFieldTableViewCell class];
    model6.modelClass = [NSNull class];
    model6.isShowLine = YES;
    model6.index = 1;
    model6.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model6];
    
    TextFieldCellModel * model9 = [[TextFieldCellModel alloc]init];
    model9.typeStr = @"oneTextField";
    model9.titleStr = lang(@"target value:");
    model9.data = @[@(0)];
    model9.cellHeight = 70.0f;
    model9.cellClass = [OneTextFieldTableViewCell class];
    model9.modelClass = [NSNull class];
    model9.isShowLine = YES;
    model9.index = 2;
    model9.textFeildCallback = self.textFeildCallback;
    [cellModels addObject:model9];
    
    self.cellModels = cellModels;
}

- (void)getTextFieldCallback
{
    __weak typeof(self) weakSelf = self;
    self.textFeildCallback = ^(UIViewController *viewController, UITextField *textField, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        TextFieldCellModel * model = [strongSelf.cellModels objectAtIndex:indexPath.row];
        if (model.index == 0) {
            funcVC.pickerView.pickerArray = strongSelf.pickerDataModel.sportTypes;
            funcVC.pickerView.currentIndex = [strongSelf.pickerDataModel.sportTypes containsObject:textField.text] ?
            [strongSelf.pickerDataModel.sportTypes indexOfObject:textField.text] : 1 ;
            [funcVC.pickerView show];
            funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
                textField.text = selectStr;
                model.data = @[selectStr];
                strongSelf.dataModel.sportType  = [strongSelf.pickerDataModel.sportTypes containsObject:textField.text] ?
                ([strongSelf.pickerDataModel.sportTypes indexOfObject:textField.text] + 1) : 1;
            };
        }else if (model.index == 1) {
            funcVC.pickerView.pickerArray = strongSelf.pickerDataModel.targetTypes;
            funcVC.pickerView.currentIndex = [strongSelf.pickerDataModel.targetTypes containsObject:textField.text] ?
            [strongSelf.pickerDataModel.targetTypes indexOfObject:textField.text] : 0 ;
            [funcVC.pickerView show];
            funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
                textField.text = selectStr;
                model.data = @[selectStr];
                strongSelf.dataModel.targetType  = [strongSelf.pickerDataModel.targetTypes containsObject:textField.text] ?
                [strongSelf.pickerDataModel.targetTypes indexOfObject:textField.text] : 0 ;
            };
        }else if (model.index == 2) {
            NSArray * pickerArray = [NSArray array];
            if (strongSelf.dataModel.targetType == 0) {
                pickerArray = strongSelf.pickerDataModel.hundredArray;
            }else if (strongSelf.dataModel.targetType == 1) {
                pickerArray = strongSelf.pickerDataModel.hundredArray;
            }else if (strongSelf.dataModel.targetType == 2) {
                pickerArray = strongSelf.pickerDataModel.tenThousandArray;
            }else if (strongSelf.dataModel.targetType == 3) {
                pickerArray = strongSelf.pickerDataModel.thousandArray;
            }else if (strongSelf.dataModel.targetType == 4) {
                pickerArray = strongSelf.pickerDataModel.hundredArray;
            }
            funcVC.pickerView.pickerArray = pickerArray;
            funcVC.pickerView.currentIndex = [pickerArray containsObject:@([textField.text integerValue])] ? [pickerArray indexOfObject:@([textField.text integerValue])] : 0 ;
            [funcVC.pickerView show];
            funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
                textField.text = selectStr;
                model.data = @[@([selectStr integerValue])];
                strongSelf.dataModel.targetValue  = [selectStr integerValue];
            };
        }
    };
}

- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        if (!IDO_BLUE_ENGINE.managerEngine.isConnected)return ;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        TextFieldCellModel * model = [strongSelf.cellModels objectAtIndex:indexPath.row];
        if (model.index == 0) {
            IDOSetTimeInfoBluetoothModel * timeModel = [IDOSetTimeInfoBluetoothModel currentModel];
            strongSelf.dataModel.day    = timeModel.day;
            strongSelf.dataModel.hour   = timeModel.hour;
            strongSelf.dataModel.minute = timeModel.minute;
            strongSelf.dataModel.second = timeModel.second;
            [funcVC showLoadingWithMessage:lang(@"app start activity...")];
            [IDOFoundationCommand appStartSportCommand:strongSelf.dataModel
                                         startCallback:^(IDODataExchangeModel * _Nullable model, int errorCode) {
                 __strong typeof(self) strongSelf = weakSelf;
                 [strongSelf addMessageText:[NSString stringWithFormat:@"%@:\n%@\n\n",lang(@"app start activity"),model.dicFromObject]];
                 if (errorCode == 0 && model.retCode == 0) {
                     [funcVC showToastWithText:lang(@"app start activity success")];
                 }else if (model.retCode == 2) {
                     [funcVC showToastWithText:lang(@"device low power")];
                 }else {
                     [funcVC showToastWithText:lang(@"app start activity failed")];
                 }
            }];
        }else if (model.index == 1) {
            [funcVC showLoadingWithMessage:lang(@"app suspended activity...")];
            [IDOFoundationCommand appPauseSportCommand:strongSelf.dataModel
                                         pauseCallback:^(IDODataExchangeModel * _Nullable model, int errorCode) {
                 __strong typeof(self) strongSelf = weakSelf;
                 [strongSelf addMessageText:[NSString stringWithFormat:@"%@:\n%@\n\n",lang(@"app suspended activity"),strongSelf.dataModel.dicFromObject]];
                 if (errorCode == 0 && model.retCode == 0) {
                     [funcVC showToastWithText:lang(@"app suspended activity success")];
                 }else if (model.retCode == 2) {
                     [funcVC showToastWithText:lang(@"device low power")];
                 }else {
                     [funcVC showToastWithText:lang(@"app suspended activity failed")];
                 }
            }];
        }else if (model.index == 2) {
            [funcVC showLoadingWithMessage:lang(@"app restore activity...")];
            [IDOFoundationCommand appRestoreSportCommand:strongSelf.dataModel
                                      appRestoreCallback:^(IDODataExchangeModel * _Nullable model, int errorCode) {
                __strong typeof(self) strongSelf = weakSelf;
                strongSelf.dataModel = model;
                [strongSelf addMessageText:[NSString stringWithFormat:@"%@:\n%@\n\n",lang(@"app restore activity"),strongSelf.dataModel.dicFromObject]];
                if (errorCode == 0 && model.retCode == 0) {
                    [funcVC showToastWithText:lang(@"app restore activity success")];
                }else if (model.retCode == 2) {
                    [funcVC showToastWithText:lang(@"device low power")];
                }else {
                    [funcVC showToastWithText:lang(@"app restore activity failed")];
                }
            }];
        }else if (model.index == 3) {
            [funcVC showLoadingWithMessage:lang(@"app stop activity...")];
            strongSelf.dataModel.durations = arc4random()%100;
            strongSelf.dataModel.calories  = arc4random()%1000;
            strongSelf.dataModel.distance  = arc4random()%50000;
            strongSelf.dataModel.isSave = YES;
            [IDOFoundationCommand appEndSportCommand:strongSelf.dataModel
                                    appEndcallback:^(IDODataExchangeModel * _Nullable model, int errorCode) {
                __strong typeof(self) strongSelf = weakSelf;
                [strongSelf addMessageText:[NSString stringWithFormat:@"app运动停止:\n%@\n\n",model.dicFromObject]];
                if (errorCode == 0 && model.retCode == 0) {
                    [funcVC showToastWithText:lang(@"app stop activity success")];
                }else if (model.retCode == 2) {
                    [funcVC showToastWithText:lang(@"device low power")];
                }else {
                    [funcVC showToastWithText:lang(@"app stop activity failed")];
                }
            }];
        }else if (model.index == 4) {
            [funcVC showLoadingWithMessage:lang(@"send data...")];
            strongSelf.dataModel.durations = arc4random()%5;
            strongSelf.dataModel.calories  = arc4random()%1000;
            strongSelf.dataModel.distance  = arc4random()%50000;
            strongSelf.dataModel.status    = 0;
            [IDOFoundationCommand appIngSportCommand:strongSelf.dataModel
                                      appIngCallback:^(IDODataExchangeModel * _Nullable model, int errorCode) {
                __strong typeof(self) strongSelf = weakSelf;
                [strongSelf addMessageText:[NSString stringWithFormat:@"%@:\n%@\n\n",lang(@"app activity send data"),model.dicFromObject]];
                if (errorCode == 0 && model.retCode == 0) {
                    [funcVC showToastWithText:lang(@"send data success")];
                }else if (model.retCode == 2) {
                    [funcVC showToastWithText:lang(@"device low power")];
                }else {
                    [funcVC showToastWithText:lang(@"send data failed")];
                }
            }];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                __strong typeof(self) strongSelf = weakSelf;
                [IDOFoundationCommand getEndV3ActivityDataCommand:strongSelf.dataModel
                                                         callback:^(IDODataExchangeModel * _Nullable model, int errorCode) {
                    
                }];
            });
        }
    };
}

- (void)listenBlueControl
{
    __weak typeof(self) weakSelf = self;
    self.dataModel.errorCode = 0;
    [IDOFoundationCommand appBlePauseReplyCommand:self.dataModel
                              appBlePauseCallback:^(IDODataExchangeModel * _Nullable model, int errorCode) {
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf addMessageText:[NSString stringWithFormat:@"%@:\n%@\n\n",lang(@"bracelet suspended activity"),model.dicFromObject]];
    }];
    
    [IDOFoundationCommand appBleRestoreReplyCommand:self.dataModel
                              appBleRestoreCallback:^(IDODataExchangeModel * _Nullable model, int errorCode) {
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf addMessageText:[NSString stringWithFormat:@"%@:\n%@\n\n",lang(@"bracelet restore activity"),model.dicFromObject]];
    }];
    
    [IDOFoundationCommand appBleEndReplyCommand:self.dataModel
                              appBleEndCallback:^(IDODataExchangeModel * _Nullable model, int errorCode) {
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf addMessageText:[NSString stringWithFormat:@"%@:\n%@\n\n",lang(@"bracelet stop activity"),model.dicFromObject]];
    }];
    
}

- (void)getTextViewCallback
{
    __weak typeof(self) weakSelf = self;
    self.textViewCallback = ^(UITextView *textView) {
        __strong typeof(self) strongSelf = weakSelf;
        strongSelf.textView = textView;
    };
}

- (void)addMessageText:(NSString *)message
{
    message = [NSString stringWithFormat:@"%@\n%@",self.textView.text,message];
    TextViewCellModel * model = [self.cellModels firstObject];
    model.data = @[message?:@""];
    self.textView.text = message;
    [self.textView scrollRangeToVisible:NSMakeRange(self.textView.text.length, 1)];
}

@end
