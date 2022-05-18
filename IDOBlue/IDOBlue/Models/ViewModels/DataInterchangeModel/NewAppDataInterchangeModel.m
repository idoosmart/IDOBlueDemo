//
//  NewAppDataInterchangeModel.m
//  IDOBlue
//
//  Created by hedongyang on 2018/10/10.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "NewAppDataInterchangeModel.h"
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


@interface NewAppDataInterchangeModel()<IDODataExchangeManagerDelegate>
@property (nonatomic,strong) UITextView * textView;
@property (nonatomic,strong) IDOAppStartExchangeModel * dataModel;
@property (nonatomic,copy)void(^textViewCallback)(UITextView * textView);
@property (nonatomic,copy)void(^textFeildCallback)(UIViewController * viewController,UITextField * textField,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation NewAppDataInterchangeModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getButtonCallback];
        [self getTextFieldCallback];
        [self getTextViewCallback];
        [self listenBlueControl];
        [self getCellModels];
        [self initExchange];
    }
    return self;
}

- (void)initExchange
{
    [IDODataExchangeManager shareInstance].delegate = self;
}

- (IDOAppStartExchangeModel *)dataModel
{
    if (!_dataModel) {
        _dataModel = [IDOAppStartExchangeModel new];
        _dataModel.sportType = 48;
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
                if ([selectStr isEqualToString:lang(@"outdoor running")]) {
                    strongSelf.dataModel.sportType = 48;
                    return;
                }
                if ([selectStr isEqualToString:lang(@"outdoor walking")]) {
                    strongSelf.dataModel.sportType = 52;
                    return;
                }
                if ([selectStr isEqualToString:lang(@"outdoor cycling")]) {
                    strongSelf.dataModel.sportType = 50;
                    return;
                }
                if ([selectStr isEqualToString:lang(@"outdoor play")]) {
                    strongSelf.dataModel.sportType = 193;
                    return;
                }
                if ([selectStr isEqualToString:lang(@"other activity")]) {
                    strongSelf.dataModel.sportType = 194;
                    return;
                }
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
            //start sport
            IDOSetTimeInfoBluetoothModel * timeModel = [IDOSetTimeInfoBluetoothModel currentModel];
            IDOAppStartExchangeModel * model = [[IDOAppStartExchangeModel alloc]init];
            model.day = timeModel.day;
            model.hour = timeModel.hour;
            model.minute = timeModel.minute;
            model.second = timeModel.second;
            model.targetType = strongSelf.dataModel.targetType;
            model.targetValue = strongSelf.dataModel.targetValue;
            model.sportType = strongSelf.dataModel.sportType;
            model.forceStart = 1;
            
            strongSelf.dataModel.day = timeModel.day;
            strongSelf.dataModel.hour = timeModel.hour;
            strongSelf.dataModel.minute = timeModel.minute;
            strongSelf.dataModel.second = timeModel.second;
            
            [IDODataExchangeManager appStartSportCommandWithModel:model error:nil];

        }else if (model.index == 1) {
            //pause sport
            [IDODataExchangeManager appPauseSportCommandWithModel:strongSelf.dataModel error:nil];
            
        }else if (model.index == 2) {
            //restore sport
            [IDODataExchangeManager appRestoreSportCommandWithModel:strongSelf.dataModel error:nil];
            
        }else if (model.index == 3) {
            //end sport
            IDOAppEndExchangeModel * model = [[IDOAppEndExchangeModel alloc]init];
            model.day = strongSelf.dataModel.day;
            model.hour = strongSelf.dataModel.hour;
            model.minute = strongSelf.dataModel.minute;
            model.second = strongSelf.dataModel.second;
            model.distance = 10000;
            model.calories = 1000;
            model.step = 15000;
            model.isSave = YES;
            [IDODataExchangeManager appEndSportCommandWithModel:model error:nil];
        }else if (model.index == 4) {
            //ing sport
            if ([IDODataExchangeManager shareInstance].isV3ActivityExchange) {
                IDOV3AppIngDataExchangeModel * model = [[IDOV3AppIngDataExchangeModel alloc]init];
                model.day = strongSelf.dataModel.day;
                model.hour = strongSelf.dataModel.hour;
                model.minute = strongSelf.dataModel.minute;
                model.second = strongSelf.dataModel.second;
                model.distance = 10000;
                model.calories = 1000;
                model.durations = 200;
                model.signalFlag = 1;
                model.realTimeSpeed = 0;
                [IDODataExchangeManager v3_appIngSportCommandWithModel:model error:nil];
            }else {
                IDOV2AppIngDataExchangeModel * model = [[IDOV2AppIngDataExchangeModel alloc]init];
                model.day = strongSelf.dataModel.day;
                model.hour = strongSelf.dataModel.hour;
                model.minute = strongSelf.dataModel.minute;
                model.second = strongSelf.dataModel.second;
                model.distance = 10000;
                model.calories = 1000;
                model.durations = 200;
                model.flag = 0;
                [IDODataExchangeManager v2_appIngSportCommandWithModel:model error:nil];
            }
        }
    };
}

- (void)listenBlueControl
{
   
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

- (void)appPauseSportReplyWithModel:(nonnull IDOAppPauseReplyExchangeModel *)model
                          errorCode:(int)errorCode {
    if (errorCode != 0) return;
    NSLog(@"appPauseSportReplyWithModel:%@",model.dicFromObject);
    NSString * message = @"";
    if ([IDODataExchangeManager shareInstance].isV3ActivityExchange) {
        message = [NSString stringWithFormat:@"app pause sport : %@",[IDODataExchangeManager shareInstance].v3Model.dicFromObject];
    }else{
        message = [NSString stringWithFormat:@"app pause sport : %@",[IDODataExchangeManager shareInstance].v2Model.dicFromObject];
    }
    [self addMessageText:message];
}

- (void)appRestoreSportReplyWithModel:(nonnull IDOAppRestoreReplyExchangeModel *)model
                            errorCode:(int)errorCode {
    if (errorCode != 0) return;
    NSLog(@"appRestoreSportReplyWithModel:%@",model.dicFromObject);
    NSString * message = @"";
    if ([IDODataExchangeManager shareInstance].isV3ActivityExchange) {
        message = [NSString stringWithFormat:@"app restore sport : %@",[IDODataExchangeManager shareInstance].v3Model.dicFromObject];
    }else {
        message = [NSString stringWithFormat:@"app restore sport : %@",[IDODataExchangeManager shareInstance].v2Model.dicFromObject];
    }
    [self addMessageText:message];
}

- (void)appStartSportReplyWithModel:(nonnull IDOAppStartReplyExchangeModel *)model
                          errorCode:(int)errorCode {
    if (errorCode != 0) return;
    NSLog(@"appStartSportReplyWithModel:%@",model.dicFromObject);
    NSString * message = @"";
    if ([IDODataExchangeManager shareInstance].isV3ActivityExchange) {
        message = [NSString stringWithFormat:@"app start sport : %@",[IDODataExchangeManager shareInstance].v3Model.dicFromObject];
    }else {
        message = [NSString stringWithFormat:@"app start sport : %@",[IDODataExchangeManager shareInstance].v2Model.dicFromObject];
    }
    [self addMessageText:message];
}

- (void)bleEndAppSportWithModel:(nonnull IDOBleEndExchangeModel *)model
                      errorCode:(int)errorCode {
    if (errorCode != 0) return;
    NSLog(@"bleEndAppSportWithModel:%@",model.dicFromObject);
    NSString * message = @"";
    if ([IDODataExchangeManager shareInstance].isV3ActivityExchange) {
        message = [NSString stringWithFormat:@"app end sport : %@",[IDODataExchangeManager shareInstance].v3Model.dicFromObject];
    }else {
        message = [NSString stringWithFormat:@"app end sport : %@",[IDODataExchangeManager shareInstance].v2Model.dicFromObject];
    }
    [self addMessageText:message];
}

- (void)blePauseAppSportWithModel:(nonnull IDONewDataExchangeModel *)model
                        errorCode:(int)errorCode {
    if (errorCode != 0) return;
    NSLog(@"blePauseAppSportWithModel:%@",model.dicFromObject);
    NSString * message = @"";
    if ([IDODataExchangeManager shareInstance].isV3ActivityExchange) {
        message = [NSString stringWithFormat:@"ble pause sport : %@",[IDODataExchangeManager shareInstance].v3Model.dicFromObject];
    }else {
        message = [NSString stringWithFormat:@"ble pause sport : %@",[IDODataExchangeManager shareInstance].v2Model.dicFromObject];
    }
    [self addMessageText:message];
}

- (void)bleRestoreAppSportWithModel:(nonnull IDONewDataExchangeModel *)model
                          errorCode:(int)errorCode {
    if (errorCode != 0) return;
    NSLog(@"bleRestoreAppSportWithModel:%@",model.dicFromObject);
    NSString * message = @"";
    if ([IDODataExchangeManager shareInstance].isV3ActivityExchange) {
        message = [NSString stringWithFormat:@"ble restore sport : %@",[IDODataExchangeManager shareInstance].v3Model.dicFromObject];
    }else {
        message = [NSString stringWithFormat:@"ble restore sport : %@",[IDODataExchangeManager shareInstance].v2Model.dicFromObject];
    }
    [self addMessageText:message];
}

- (void)v2_appEndSportReplyWithModel:(nonnull IDOAppEndReplyExchangeModel *)model
                           errorCode:(int)errorCode {
    if (errorCode != 0) return;
    NSLog(@"v2_appEndSportReplyWithModel:%@",model.dicFromObject);
    NSString * message = @"";
    if ([IDODataExchangeManager shareInstance].isV3ActivityExchange) {
        message = [NSString stringWithFormat:@"v2 app end sport : %@",[IDODataExchangeManager shareInstance].v3Model.dicFromObject];
    }else {
        message = [NSString stringWithFormat:@"v2 app end sport : %@",[IDODataExchangeManager shareInstance].v2Model.dicFromObject];
    }
    [self addMessageText:message];
}

- (void)v2_appIngSportReplyWithModel:(nonnull IDOV2AppIngReplyExchangeModel *)model
                           errorCode:(int)errorCode {
    if (errorCode != 0) return;
    NSLog(@"v2_appIngSportReplyWithModel:%@",model.dicFromObject);
    NSString * message = @"";
    if ([IDODataExchangeManager shareInstance].isV3ActivityExchange) {
        message = [NSString stringWithFormat:@"v2 app ing sport : %@",[IDODataExchangeManager shareInstance].v3Model.dicFromObject];
    }else {
        message = [NSString stringWithFormat:@"v2 app ing sport : %@",[IDODataExchangeManager shareInstance].v2Model.dicFromObject];
    }
    [self addMessageText:message];
}

- (void)v3_appEndSportReplyWithModel:(nonnull IDOV3SportEndDataExchangeModel *)model
                           errorCode:(int)errorCode {
    if (errorCode != 0) return;
    NSLog(@"v3_appEndSportReplyWithModel:%@",model.dicFromObject);
    NSString * message = @"";
    if ([IDODataExchangeManager shareInstance].isV3ActivityExchange) {
        message = [NSString stringWithFormat:@"v3 app end sport : %@",[IDODataExchangeManager shareInstance].v3Model.dicFromObject];
    }else {
        message = [NSString stringWithFormat:@"v3 app end sport : %@",[IDODataExchangeManager shareInstance].v2Model.dicFromObject];
    }
    [self addMessageText:message];
}

- (void)v3_appIngSportReplyWithModel:(nonnull IDOV3AppIngReplyExchangeModel *)model
                           errorCode:(int)errorCode {
    if (errorCode != 0) return;
    NSLog(@"v3_appIngSportReplyWithModel:%@",model.dicFromObject);
    NSString * message = @"";
    if ([IDODataExchangeManager shareInstance].isV3ActivityExchange) {
        message = [NSString stringWithFormat:@"v3 app ing sport : %@",[IDODataExchangeManager shareInstance].v3Model.dicFromObject];
    }else {
        message = [NSString stringWithFormat:@"v3 app ing sport : %@",[IDODataExchangeManager shareInstance].v2Model.dicFromObject];
    }
    [self addMessageText:message];
}

- (void)v3_appSportHrReplyWithModel:(nonnull IDOHrDataExchangeModel *)model
                          errorCode:(int)errorCode {
    if (errorCode != 0) return;
    NSLog(@"v3_appSportHrReplyWithModel:%@",model.dicFromObject);
    NSString * message = @"";
    if ([IDODataExchangeManager shareInstance].isV3ActivityExchange) {
        message = [NSString stringWithFormat:@"v3 app hr sport : %@",[IDODataExchangeManager shareInstance].v3Model.dicFromObject];
    }else {
        message = [NSString stringWithFormat:@"v3 app hr sport : %@",[IDODataExchangeManager shareInstance].v2Model.dicFromObject];
    }
    [self addMessageText:message];
}

@end
