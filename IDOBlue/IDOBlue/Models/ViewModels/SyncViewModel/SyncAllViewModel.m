//
//  SyncAllViewModel.m
//  IDOBlue
//
//  Created by apple on 2018/10/4.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "SyncAllViewModel.h"
#import "FuncCellModel.h"
#import "OneButtonTableViewCell.h"
#import "TextViewCellModel.h"
#import "OneTextViewTableViewCell.h"
#import "IDODemoUtility.h"
#import "FuncViewController.h"
#import "NSObject+DemoToDic.h"

@interface SyncAllViewModel()
@property (nonatomic,assign) BOOL firstBind;
@property (nonatomic,strong) UITextView * textView;
@property (nonatomic,copy)void(^textViewCallback)(UITextView * textView);
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation SyncAllViewModel

- (void)dealloc
{
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.firstBind = YES;
        [self getButtonCallback];
        [self getTextViewCallback];
        [self getCellModels];
    }
    return self;
}

- (void)getTextViewCallback
{
    __weak typeof(self) weakSelf = self;
    self.textViewCallback = ^(UITextView *textView) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)[IDODemoUtility getCurrentVC];
        funcVC.tableView.scrollEnabled = NO;
        strongSelf.textView = textView;
    };
}

+ (NSString *)getStateCode:(IDO_SYNC_COMPLETE_STATUS)stateCode
{
    if (stateCode == IDO_SYNC_CONFIG_COMPLETE) {
        return @"IDO_SYNC_CONFIG_COMPLETE";
    }else if (stateCode == IDO_SYNC_CONFIG_COMPLETE_EXCEPTION) {
        return @"IDO_SYNC_CONFIG_COMPLETE_EXCEPTION";
    }else if (stateCode == IDO_SYNC_HEALTH_COMPLETE) {
        return @"IDO_SYNC_HEALTH_COMPLETE";
    }else if (stateCode == IDO_SYNC_HEALTH_COMPLETE_EXCEPTION) {
        return @"IDO_SYNC_HEALTH_COMPLETE_EXCEPTION";
    }else if (stateCode == IDO_SYNC_V3_HEALTH_COMPLETE) {
        return @"IDO_SYNC_V3_HEALTH_COMPLETE";
    }else if (stateCode == IDO_SYNC_V3_HEALTH_COMPLETE_EXCEPTION) {
        return @"IDO_SYNC_V3_HEALTH_COMPLETE_EXCEPTION";
    }else if (stateCode == IDO_SYNC_ACTIVITY_COMPLETE) {
        return @"IDO_SYNC_ACTIVITY_COMPLETE";
    }else if (stateCode == IDO_SYNC_ACTIVITY_COMPLETE_EXCEPTION) {
        return @"IDO_SYNC_ACTIVITY_COMPLETE_EXCEPTION";
    }else if (stateCode == IDO_SYNC_GPS_COMPLETE) {
        return @"IDO_SYNC_GPS_COMPLETE";
    }else if (stateCode == IDO_SYNC_GPS_COMPLETE_EXCEPTION) {
        return @"IDO_SYNC_GPS_COMPLETE_EXCEPTION";
    }else if (stateCode == IDO_SYNC_GLOBAL_COMPLETE) {
        return @"IDO_SYNC_GLOBAL_COMPLETE";
    }
    return @"";
}

- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        if (!IDO_BLUE_ENGINE.managerEngine.isConnected)return;
        [funcVC showLoadingWithMessage:lang(@"sync data...")];
        [IDOSyncManager deleteSyncFlag];
        initSyncManager().wantToSyncType = IDO_WANT_TO_SYNC_CONFIG_ITEM_TYPE | IDO_WANT_TO_SYNC_HEALTH_ITEM_TYPE
        | IDO_WANT_TO_SYNC_ACTIVITY_ITEM_TYPE | IDO_WANT_TO_SYNC_GPS_ITEM_TYPE;
        initSyncManager().addSyncConfigInitData(^NSArray<IDOBluetoothBaseModel *> * _Nullable(IDO_SYNC_CONFIG_DATA_TYPE type) {
            
                if (type == IDO_SYNC_SET_SPORT_MODE_SELECT_TYPE) {
                IDOSetSportShortcutInfoBluetoothModel *sportModel = [IDOSetSportShortcutInfoBluetoothModel currentModel];
                sportModel.isWalk = YES;
                sportModel.isRun = YES;
                sportModel.isByBike = YES;
                
                sportModel.isOnFoot = NO;
                sportModel.isSwim = NO;
                sportModel.isMountainClimbing = NO;
                sportModel.isBadminton = NO;
                sportModel.isOther = NO;
                sportModel.isFitness = NO;
                sportModel.isSpinning = NO;
                sportModel.isEllipsoid = NO;
                sportModel.isTreadmill = NO;
                sportModel.isSitUp = NO;
                sportModel.isPushUp = NO;
                sportModel.isDumbbell = NO;
                sportModel.isWeightlifting = NO;
                sportModel.isBodybuildingExercise = NO;
                sportModel.isYoga = NO;
                sportModel.isRopeSkipping = NO;
                sportModel.isTableTennis = NO;
                sportModel.isBasketball = NO;
                sportModel.isFootball = NO;
                sportModel.isVolleyball = NO;
                sportModel.isTennis = NO;
                sportModel.isGolf = NO;
                sportModel.isBaseball = NO;
                sportModel.isSkiing = NO;
                sportModel.isRollerSkating = NO;
                sportModel.isDance = NO;
                IDOGetDeviceFuncBluetoothModel * funcTable = [IDOBluetoothEngine shareInstance].managerEngine.funcTableModel;
                if (funcTable.funcTable19Model.gps) {
                    sportModel.isOnFoot = YES;
                    sportModel.isMountainClimbing = YES;
                    sportModel.isBadminton = YES;
                    sportModel.isFitness = YES;
                    sportModel.isSpinning = YES;
                }else{
                    if (funcTable.sportShowCount == 8) {
                        sportModel.isOnFoot = YES;
                        sportModel.isTreadmill = YES;
                        sportModel.isFitness = YES;
                        sportModel.isBasketball = YES;
                        sportModel.isBadminton = YES;
                    }
                    else if(funcTable.sportShowCount == 4){
                        sportModel.isFitness = YES;
                    }
                }
                 return @[sportModel];
                }
                else if (type == IDO_SYNC_SET_SPORT_MODE_SORT_TYPE) {
                    IDOSetSportSortingInfoBluetoothModel * model = [IDOSetSportSortingInfoBluetoothModel currentModel];
                    if (model.sportSortingItems.count > 0) { //如果发现items的数据个数大于0,说明用户设置过运动排序
                        return @[model];
                    }
                    IDOSetSportSortingItemModel * item1 = [[IDOSetSportSortingItemModel alloc]init];
                    item1.index = 1;
                    item1.type = 1;
                    IDOSetSportSortingItemModel * item2 = [[IDOSetSportSortingItemModel alloc]init];
                    item2.index = 2;
                    item2.type = 2;
                    IDOSetSportSortingItemModel * item3 = [[IDOSetSportSortingItemModel alloc]init];
                    item3.index = 3;
                    item3.type = 3;
                    IDOSetSportSortingItemModel * item4 = [[IDOSetSportSortingItemModel alloc]init];
                    item4.index = 4;
                    item4.type = 4;
                    model.sportSortingItems = @[item1,item2,item3,item4];
                    model.allNum = model.sportSortingItems.count;
                    return @[model];
                }
                return @[];
        });
        initSyncManager().addSyncComplete(^(IDO_SYNC_COMPLETE_STATUS stateCode) {
            if (stateCode == IDO_SYNC_CONFIG_COMPLETE) {
                weakSelf.firstBind = NO;
                //advice “firstBind” save NSUserDefaults
            }
            NSString * newLogStr = [NSString stringWithFormat:@"%@\n\n%@",strongSelf.textView.text,[SyncAllViewModel getStateCode:stateCode]];
            TextViewCellModel * model = [strongSelf.cellModels firstObject];
            model.data = @[newLogStr?:@""];
            strongSelf.textView.text = newLogStr;
            if (stateCode == IDO_SYNC_GLOBAL_COMPLETE) {
                [funcVC showToastWithText:lang(@"sync data complete")];
            }
        }).addSyncProgess(^(IDO_CURRENT_SYNC_TYPE type, float progress) {
            [funcVC showSyncProgress:progress];
        }).addSyncFailed(^(int errorCode) {
            NSString * newLogStr = [NSString stringWithFormat:@"%@\n\n%@",strongSelf.textView.text,[IDOErrorCodeToStr errorCodeToStr:errorCode]];
            TextViewCellModel * model = [strongSelf.cellModels firstObject];
            model.data = @[newLogStr?:@""];
            strongSelf.textView.text = newLogStr;
            [funcVC showToastWithText:lang(@"sync data failed")];
        }).addSyncSwim(^(NSString * jsonStr){
            //this command is only used for debugging
            IDOSyncSwimmingDataInfoBluetoothModel*swimmodel = [IDOSyncSwimDataModel swimmingDataJsonStringToObjectModel:jsonStr];
            
            NSString * newLogStr = [NSString stringWithFormat:@"%@\n\n%@",strongSelf.textView.text,jsonStr];
            TextViewCellModel * model = [strongSelf.cellModels firstObject];
            model.data = @[newLogStr?:@""];
            strongSelf.textView.text = newLogStr;
        }).addSyncHeartRate(^(NSString * jsonStr){
            //this command is only used for debugging
            IDOSyncSecHrDataInfoBluetoothModel *hrDatamodel = [IDOSyncHeartRateDataModel hearRateSecondDataJsonStringToObjectModel:jsonStr];

            NSString * newLogStr = [NSString stringWithFormat:@"%@\n\n%@",strongSelf.textView.text,jsonStr];
            TextViewCellModel * model = [strongSelf.cellModels firstObject];
            model.data = @[newLogStr?:@""];
            strongSelf.textView.text = newLogStr;
        }).addSyncBloodOxygen(^(NSString * jsonStr){
            //this command is only used for debugging
            IDOSyncBloodOxygenDataInfoBluetoothModel*boxmodel = [IDOSyncSpo2DataModel bloodOxygenDataJsonStringToObjectModel:jsonStr];
            
            NSString * newLogStr = [NSString stringWithFormat:@"%@\n\n%@",strongSelf.textView.text,jsonStr];
            TextViewCellModel * model = [strongSelf.cellModels firstObject];
            model.data = @[newLogStr?:@""];
            strongSelf.textView.text = newLogStr;
        }).addSyncBp(^(NSString * jsonStr){
            //this command is only used for debugging
            IDOSyncV3BpDataModel*bpmodel = [IDOSyncV3BpDataModel v3BloodbPressureDataJsonStringToObjectModel:jsonStr];
            
            NSString * newLogStr = [NSString stringWithFormat:@"%@\n\n%@",strongSelf.textView.text,jsonStr];
            TextViewCellModel * model = [strongSelf.cellModels firstObject];
            model.data = @[newLogStr?:@""];
            strongSelf.textView.text = newLogStr;
        }).addSyncSleep(^(NSString * jsonStr){
            //this command is only used for debugging
            IDOSyncV3SleepDataInfoBluetoothModel*sleepmodel = [IDOSyncV3SleepDataModel v3SleepDataJsonStringToObjectModel:jsonStr];
            
            NSString * newLogStr = [NSString stringWithFormat:@"%@\n\n%@",strongSelf.textView.text,jsonStr];
            TextViewCellModel * model = [strongSelf.cellModels firstObject];
            model.data = @[newLogStr?:@""];
            strongSelf.textView.text = newLogStr;
        }).addSyncGps(^(NSString * jsonStr){
            //this command is only used for debugging
            IDOSyncV3GpsDataInfoBluetoothModel*gpsmodel = [IDOSyncV3GpsDataModel v3GpsDataJsonStringToObjectModel:jsonStr];

            NSString * newLogStr = [NSString stringWithFormat:@"%@\n\n%@",strongSelf.textView.text,jsonStr];
            TextViewCellModel * model = [strongSelf.cellModels firstObject];
            model.data = @[newLogStr?:@""];
            strongSelf.textView.text = newLogStr;
        }).addSyncSport(^(NSString * jsonStr){
            //this command is only used for debugging
            IDOSyncV3SportDataInfoBluetoothModel*sportmodel = [IDOSyncV3SportDataModel v3SportDataJsonStringToObjectModel:jsonStr];
            
            NSString * newLogStr = [NSString stringWithFormat:@"%@\n\n%@",strongSelf.textView.text,jsonStr];
            TextViewCellModel * model = [strongSelf.cellModels firstObject];
            model.data = @[newLogStr?:@""];
            strongSelf.textView.text = newLogStr;
        }).addSyncPressure(^(NSString * jsonStr){
            //this command is only used for debugging
            IDOSyncPressureDataInfoBluetoothModel*pressuremodel = [IDOSyncPressureDataModel pressureDataJsonStringToObjectModel:jsonStr];
            
            NSString * newLogStr = [NSString stringWithFormat:@"%@\n\n%@",strongSelf.textView.text,jsonStr];
            TextViewCellModel * model = [strongSelf.cellModels firstObject];
            model.data = @[newLogStr?:@""];
            strongSelf.textView.text = newLogStr;
        }).addSyncActivity(^(NSString * jsonStr){
            //this command is only used for debugging
            IDOSyncV3ActivityDataInfoBluetoothModel*activitymodel = [IDOSyncV3ActivityDataModel v3ActivityDataJsonStringToObjectModel:jsonStr];
            
            NSString * newLogStr = [NSString stringWithFormat:@"%@\n\n%@",strongSelf.textView.text,jsonStr];
            TextViewCellModel * model = [strongSelf.cellModels firstObject];
            model.data = @[newLogStr?:@""];
            strongSelf.textView.text = newLogStr;
        }).addSyncConfig(^(NSString * logStr){
            //this command is only used for debugging
            NSString * newLogStr = [NSString stringWithFormat:@"%@\n\n%@",strongSelf.textView.text,logStr];
            TextViewCellModel * model = [strongSelf.cellModels firstObject];
            model.data = @[newLogStr?:@""];
            strongSelf.textView.text = newLogStr;
        }).mandatorySyncConfig(initSyncManager().isNeedSyncConfig); //第一次绑定时设置YES,其他时候设置为No
        [IDOSyncManager startSync];
    };
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    FuncCellModel * model = [[FuncCellModel alloc]init];
    model.typeStr = @"oneButton";
    model.data = @[lang(@"all data sync")];
    model.cellHeight = 70.0f;
    model.cellClass = [OneButtonTableViewCell class];
    model.modelClass = [NSNull class];
    model.isShowLine = YES;
    model.buttconCallback = self.buttconCallback;
    [cellModels addObject:model];
    
    TextViewCellModel * model2 = [[TextViewCellModel alloc]init];
    model2.typeStr = @"oneTextView";
    model2.cellHeight = [IDODemoUtility getCurrentVC].view.bounds.size.height-110;
    model2.cellClass  = [OneTextViewTableViewCell class];
    model2.textViewCallback = self.textViewCallback;
    [cellModels addObject:model2];
    
    self.cellModels = cellModels;
}
@end
