//
//  SetNotfityViewModel.m
//  IDOBluetoothDemo
//
//  Created by hedongyang on 2018/9/26.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "SetNotfityViewModel.h"
#import "SwitchCellModel.h"
#import "OneSwitchTableViewCell.h"
#import "TextFieldCellModel.h"
#import "OneTextFieldTableViewCell.h"
#import "EmpltyCellModel.h"
#import "EmptyTableViewCell.h"
#import "FuncCellModel.h"
#import "OneButtonTableViewCell.h"
#import "FuncViewController.h"

@interface SetNotfityViewModel()
@property (nonatomic,strong)IDOSetNoticeInfoBuletoothModel * noticeModel;
@property (nonatomic,strong)IDOSetPairingInfoBuletoothModel * pairingModel;
@property (nonatomic,strong)NSArray * titleArray;
@property (nonatomic,strong)NSArray * dataArray;
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^switchCallback)(UIViewController * viewController,UISwitch * onSwitch,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^textFeildCallback)(UIViewController * viewController,UITextField * textField,UITableViewCell * tableViewCell);
@end

@implementation SetNotfityViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getSwitchCallback];
        [self getButtonCallback];
        [self getTextFieldCallback];
        [self getCellModels];
    }
    return self;
}

- (IDOSetNoticeInfoBuletoothModel *)noticeModel
{
    if (!_noticeModel) {
        _noticeModel = [IDOSetNoticeInfoBuletoothModel currentModel];
    }
    return _noticeModel;
}

- (IDOSetPairingInfoBuletoothModel *)pairingModel
{
    if (!_pairingModel) {
        _pairingModel = [IDOSetPairingInfoBuletoothModel currentModel];
    }
    return _pairingModel;
}

- (void)getSwitchCallback
{
    __weak typeof(self) weakSelf = self;
    self.switchCallback = ^(UIViewController *viewController, UISwitch *onSwitch, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        SwitchCellModel * switchCellModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
        BOOL isSupport = YES;
        if (switchCellModel.index == 0) {
            strongSelf.noticeModel.isOnChild = onSwitch.isOn;
        }else if (switchCellModel.index == 2) {
            if (__IDO_FUNCTABLE__.funcTable7Model.calling) {
                strongSelf.noticeModel.isOnCall = onSwitch.isOn;
            }else {
                isSupport = NO;
            }
        }else if (switchCellModel.index == 3) {
            if (__IDO_FUNCTABLE__.funcTable8Model.message) {
                strongSelf.noticeModel.isOnSms   = onSwitch.isOn;
            }else {
               isSupport = NO;
            }
        }else if (switchCellModel.index == 4) {
            if (__IDO_FUNCTABLE__.funcTable8Model.email) {
                strongSelf.noticeModel.isOnEmail = onSwitch.isOn;
            }else {
              isSupport = NO;
            }
        }else if (switchCellModel.index == 5) {
            if (__IDO_FUNCTABLE__.funcTable8Model.weixin) {
                strongSelf.noticeModel.isOnWeChat = onSwitch.isOn;
            }else {
               isSupport = NO;
            }
        }else if (switchCellModel.index == 6) {
            if (__IDO_FUNCTABLE__.funcTable8Model.qq) {
                strongSelf.noticeModel.isOnQq = onSwitch.isOn;
            }else {
               isSupport = NO;
            }
        }else if (switchCellModel.index == 7) {
            if (__IDO_FUNCTABLE__.funcTable8Model.sinaWeibo) {
                strongSelf.noticeModel.isOnWeibo = onSwitch.isOn;
            }else {
               isSupport = NO;
            }
        }else if (switchCellModel.index == 8) {
            if (__IDO_FUNCTABLE__.funcTable8Model.facebook) {
                strongSelf.noticeModel.isOnFaceBook = onSwitch.isOn;
            }else {
               isSupport = NO;
            }
        }else if (switchCellModel.index == 9) {
            if (__IDO_FUNCTABLE__.funcTable8Model.twitter) {
                strongSelf.noticeModel.isOnTwitter = onSwitch.isOn;
            }else {
                isSupport = NO;
            }
        }else if (switchCellModel.index == 10) {
            if (__IDO_FUNCTABLE__.funcTable9Model.whatsapp) {
                strongSelf.noticeModel.isOnWhatsapp = onSwitch.isOn;
            }else {
               isSupport = NO;
            }
        }else if (switchCellModel.index == 11) {
            if (__IDO_FUNCTABLE__.funcTable9Model.messengre) {
                strongSelf.noticeModel.isOnMessenger = onSwitch.isOn;
            }else {
                isSupport = NO;
            }
        }else if (switchCellModel.index == 12) {
            if (__IDO_FUNCTABLE__.funcTable9Model.instagram) {
                strongSelf.noticeModel.isOnInstagram = onSwitch.isOn;
            }else {
               isSupport = NO;
            }
        }else if (switchCellModel.index == 13) {
            if (__IDO_FUNCTABLE__.funcTable9Model.linkedIn) {
                strongSelf.noticeModel.isOnLinkedIn = onSwitch.isOn;
            }else {
               isSupport = NO;
            }
        }else if (switchCellModel.index == 14) {
            if (__IDO_FUNCTABLE__.funcTable9Model.calendar) {
                strongSelf.noticeModel.isOnCalendar = onSwitch.isOn;
            }else {
                isSupport = NO;
            }
        }else if (switchCellModel.index == 15) {
            if (__IDO_FUNCTABLE__.funcTable9Model.skype) {
                strongSelf.noticeModel.isOnSkype = onSwitch.isOn;
            }else {
                isSupport = NO;
            }
        }else if (switchCellModel.index == 16) {
            if (__IDO_FUNCTABLE__.funcTable9Model.alarmClock) {
                strongSelf.noticeModel.isOnAlarm = onSwitch.isOn;
            }else {
                isSupport = NO;
            }
        }else if (switchCellModel.index == 18) {
            if (__IDO_FUNCTABLE__.funcTable10Model.vkontakte) {
                strongSelf.noticeModel.isOnVkontakte = onSwitch.isOn;
            }else {
                isSupport = NO;
            }
        }else if (switchCellModel.index == 19) {
            if (__IDO_FUNCTABLE__.funcTable10Model.line) {
                strongSelf.noticeModel.isOnLine = onSwitch.isOn;
            }else {
                isSupport = NO;
            }
        }else if (switchCellModel.index == 20) {
            if (__IDO_FUNCTABLE__.funcTable10Model.viber) {
                strongSelf.noticeModel.isOnViber = onSwitch.isOn;
            }else {
                isSupport = NO;
            }
        }else if (switchCellModel.index == 21) {
            if (__IDO_FUNCTABLE__.funcTable10Model.kakaoTalk) {
                strongSelf.noticeModel.isOnKakaoTalk = onSwitch.isOn;
            }else {
               isSupport = NO;
            }
        }else if (switchCellModel.index == 22) {
            if (__IDO_FUNCTABLE__.funcTable10Model.gmail) {
                strongSelf.noticeModel.isOnGmail = onSwitch.isOn;
            }else {
               isSupport = NO;
            }
        }else if (switchCellModel.index == 23) {
            if (__IDO_FUNCTABLE__.funcTable10Model.outlook) {
                strongSelf.noticeModel.isOnOutlook = onSwitch.isOn;
            }else {
                isSupport = NO;
            }
        }else if (switchCellModel.index == 24) {
            if (__IDO_FUNCTABLE__.funcTable10Model.snapchat) {
                strongSelf.noticeModel.isOnSnapchat = onSwitch.isOn;
            }else {
               isSupport = NO;
            }
        }else if (switchCellModel.index == 25) {
            if (__IDO_FUNCTABLE__.funcTable10Model.telegram) {
                strongSelf.noticeModel.isOnTelegram = onSwitch.isOn;
            }else {
               isSupport = NO;
            }
        }else if (switchCellModel.index == 26) {
            if (__IDO_FUNCTABLE__.funcTable21Model.chatwork) {
                strongSelf.noticeModel.isOnChatwork = onSwitch.isOn;
            }else {
                isSupport = NO;
            }
        }else if (switchCellModel.index == 27) {
            if (__IDO_FUNCTABLE__.funcTable21Model.slack) {
                strongSelf.noticeModel.isOnSlack = onSwitch.isOn;
            }else {
                isSupport = NO;
            }
        }else if (switchCellModel.index == 28) {
            if (__IDO_FUNCTABLE__.funcTable21Model.yahooMail) {
                strongSelf.noticeModel.isOnYahooMail = onSwitch.isOn;
            }else {
                isSupport = NO;
            }
        }else if (switchCellModel.index == 29) {
            if (__IDO_FUNCTABLE__.funcTable21Model.tumblr) {
                strongSelf.noticeModel.isOnTumblr = onSwitch.isOn;
            }else {
                isSupport = NO;
            }
        }else if (switchCellModel.index == 30) {
            if (__IDO_FUNCTABLE__.funcTable21Model.youtube) {
                strongSelf.noticeModel.isOnYoutube = onSwitch.isOn;
            }else {
                isSupport = NO;
            }
        }else if (switchCellModel.index == 31) {
            if (__IDO_FUNCTABLE__.funcTable21Model.yahooPinterest) {
                strongSelf.noticeModel.isOnYahooPinterest = onSwitch.isOn;
            }else {
                isSupport = NO;
            }
        }else if (switchCellModel.index == 32) {
            if (__IDO_FUNCTABLE__.funcTable21Model.keep) {
                strongSelf.noticeModel.isOnKeep = onSwitch.isOn;
            }else {
                isSupport = NO;
            }
        }else if (switchCellModel.index == 33) {
            if (__IDO_FUNCTABLE__.funcTable32Model.tiktok) {
                strongSelf.noticeModel.isOnTikTok = onSwitch.isOn;
            }else {
                isSupport = NO;
            }
        }else if (switchCellModel.index == 34) {
            if (__IDO_FUNCTABLE__.funcTable33Model.netflix) {
                strongSelf.noticeModel.isOnNetflix = onSwitch.isOn;
            }else {
                isSupport = NO;
            }
        }else if (switchCellModel.index == 35) {
            if (__IDO_FUNCTABLE__.funcTable33Model.gpay) {
                strongSelf.noticeModel.isOnGpay = onSwitch.isOn;
            }else {
                isSupport = NO;
            }
        }else if (switchCellModel.index == 36) {
            if (__IDO_FUNCTABLE__.funcTable33Model.phonpe) {
                strongSelf.noticeModel.isOnPhonpe = onSwitch.isOn;
            }else {
                isSupport = NO;
            }
        }else if (switchCellModel.index == 37) {
            if (__IDO_FUNCTABLE__.funcTable33Model.swiggy) {
                strongSelf.noticeModel.isOnSwiggy = onSwitch.isOn;
            }else {
                isSupport = NO;
            }
        }else if (switchCellModel.index == 38) {
            if (__IDO_FUNCTABLE__.funcTable33Model.zomato) {
                strongSelf.noticeModel.isOnZomato = onSwitch.isOn;
            }else {
                isSupport = NO;
            }
        }else if (switchCellModel.index == 39) {
            if (__IDO_FUNCTABLE__.funcTable33Model.makeMyTrip) {
                strongSelf.noticeModel.isOnMakeMyTrip = onSwitch.isOn;
            }else {
                isSupport = NO;
            }
        }else if (switchCellModel.index == 40) {
            if (__IDO_FUNCTABLE__.funcTable33Model.jioTv) {
                strongSelf.noticeModel.isOnJioTv = onSwitch.isOn;
            }else {
                isSupport = NO;
            }
        }else if (switchCellModel.index == 41) {
            if (__IDO_FUNCTABLE__.funcTable33Model.microsoft) {
                strongSelf.noticeModel.isOnMicrosoft = onSwitch.isOn;
            }else {
                isSupport = NO;
            }
        }else if (switchCellModel.index == 42) {
            if (__IDO_FUNCTABLE__.funcTable33Model.whatsappBusiness) {
                strongSelf.noticeModel.isOnWhatsAppBusiness = onSwitch.isOn;
            }else {
                isSupport = NO;
            }
        }else if (switchCellModel.index == 43) {
            if (__IDO_FUNCTABLE__.funcTable33Model.nioseFit) {
                strongSelf.noticeModel.isOnNioseFit = onSwitch.isOn;
            }else {
                isSupport = NO;
            }
        }else if (switchCellModel.index == 44) {
            if (__IDO_FUNCTABLE__.funcTable33Model.missedCall) {
                strongSelf.noticeModel.isOnDidNotCall = onSwitch.isOn;
            }else {
                isSupport = NO;
            }
        }else if (switchCellModel.index == 45) {
            if (__IDO_FUNCTABLE__.funcTable33Model.mattersRemind) {
                strongSelf.noticeModel.isOnMattersRemind = onSwitch.isOn;
            }else {
                isSupport = NO;
            }
        }else if (switchCellModel.index == 46) {
            if (__IDO_FUNCTABLE__.funcTable33Model.uber) {
                strongSelf.noticeModel.isOnUber = onSwitch.isOn;
            }else {
                isSupport = NO;
            }
        }else if (switchCellModel.index == 47) {
            if (__IDO_FUNCTABLE__.funcTable33Model.ola) {
                strongSelf.noticeModel.isOnOla = onSwitch.isOn;
            }else {
                isSupport = NO;
            }
        }else if (switchCellModel.index == 48) {
            if (__IDO_FUNCTABLE__.funcTable33Model.ytmusic) {
                strongSelf.noticeModel.isOnYtMusic = onSwitch.isOn;
            }else {
                isSupport = NO;
            }
        }else if (switchCellModel.index == 49) {
            if (__IDO_FUNCTABLE__.funcTable33Model.googleMeet) {
                strongSelf.noticeModel.isOnGoogleMeet = onSwitch.isOn;
            }else {
                isSupport = NO;
            }
        }else if (switchCellModel.index == 50) {
            if (__IDO_FUNCTABLE__.funcTable33Model.mormaiiSmartwatch) {
                strongSelf.noticeModel.isOnMormaiiSmartwatch = onSwitch.isOn;
            }else {
                isSupport = NO;
            }
        }else if (switchCellModel.index == 51) {
            if (__IDO_FUNCTABLE__.funcTable33Model.technosConnect) {
                strongSelf.noticeModel.isOnTechnosConnect = onSwitch.isOn;
            }else {
                isSupport = NO;
            }
        }else if (switchCellModel.index == 52) {
            if (__IDO_FUNCTABLE__.funcTable33Model.enioei) {
                strongSelf.noticeModel.isOnEnioei = onSwitch.isOn;
            }else {
                isSupport = NO;
            }
        }else if (switchCellModel.index == 53) {
            if (__IDO_FUNCTABLE__.funcTable33Model.aliexpress) {
                strongSelf.noticeModel.isOnAliexpress = onSwitch.isOn;
            }else {
                isSupport = NO;
            }
        }else if (switchCellModel.index == 54) {
            if (__IDO_FUNCTABLE__.funcTable33Model.shopee) {
                strongSelf.noticeModel.isOnShopee = onSwitch.isOn;
            }else {
                isSupport = NO;
            }
        }else if (switchCellModel.index == 55) {
            if (__IDO_FUNCTABLE__.funcTable33Model.teams) {
                strongSelf.noticeModel.isOnTeams = onSwitch.isOn;
            }else {
                isSupport = NO;
            }
        }else if (switchCellModel.index == 56) {
            if (__IDO_FUNCTABLE__.funcTable33Model.support99Taxi) {
                strongSelf.noticeModel.isOn99Taxi = onSwitch.isOn;
            }else {
                isSupport = NO;
            }
        }else if (switchCellModel.index == 57) {
            if (__IDO_FUNCTABLE__.funcTable33Model.uberEats) {
                strongSelf.noticeModel.isOnUberEats = onSwitch.isOn;
            }else {
                isSupport = NO;
            }
        }else if (switchCellModel.index == 58) {
            if (__IDO_FUNCTABLE__.funcTable33Model.lFood) {
                strongSelf.noticeModel.isOnLfood = onSwitch.isOn;
            }else {
                isSupport = NO;
            }
        }else if (switchCellModel.index == 59) {
            if (__IDO_FUNCTABLE__.funcTable33Model.rappi) {
                strongSelf.noticeModel.isOnRappi = onSwitch.isOn;
            }else {
                isSupport = NO;
            }
        }else if (switchCellModel.index == 60) {
            if (__IDO_FUNCTABLE__.funcTable33Model.mercadoLivre) {
                strongSelf.noticeModel.isOnMercadoLivre = onSwitch.isOn;
            }else {
                isSupport = NO;
            }
        }else if (switchCellModel.index == 61) {
            if (__IDO_FUNCTABLE__.funcTable33Model.magalu) {
                strongSelf.noticeModel.isOnMagalu = onSwitch.isOn;
            }else {
                isSupport = NO;
            }
        }else if (switchCellModel.index == 62) {
            if (__IDO_FUNCTABLE__.funcTable33Model.americanas) {
                strongSelf.noticeModel.isOnAmericanas = onSwitch.isOn;
            }else {
                isSupport = NO;
            }
        }else if (switchCellModel.index == 63) {
            if (__IDO_FUNCTABLE__.funcTable33Model.yahoo) {
                strongSelf.noticeModel.isOnYahoo = onSwitch.isOn;
            }else {
                isSupport = NO;
            }
        }
        if (!isSupport){
            [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
            switchCellModel.data = @[@(NO)];
            [funcVC.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }else {
            switchCellModel.data = @[@(onSwitch.isOn)];
        }
    };
}

- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        [funcVC showLoadingWithMessage:lang(@"set notice switch...")];
        strongSelf.noticeModel.isOnDidNotCall = YES;
        [IDOFoundationCommand setSwitchNoticeCommand:strongSelf.noticeModel
                                            callback:^(BOOL isNeedDisconnect, int stateCode) {
            [funcVC showLoadingWithMessage:lang(@"set notice switch...")];
        } complete:^(int errorCode) {
            if(errorCode == 0) {
                [funcVC showToastWithText:lang(@"set notice switch success")];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [IDOFoundationCommand getNoticeStatusCommand:^(int errorCode, IDOSetNoticeInfoBuletoothModel * _Nullable data) {
                        if(errorCode == 0) {
                            strongSelf.pairingModel = [IDOSetPairingInfoBuletoothModel currentModel];
                            [strongSelf getCellModels];
                            [funcVC reloadData];
                        }
                    }];
                });
            }else if (errorCode == 6) {
                [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
            }else {
                [funcVC showToastWithText:lang(@"set notice switch failed")];
            }
        }];
    };
}

- (void)getTextFieldCallback
{
    __weak typeof(self) weakSelf = self;
    self.textFeildCallback = ^(UIViewController *viewController, UITextField *textField, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
        funcVC.pickerView.pickerArray = strongSelf.pickerDataModel.tenArray;
        funcVC.pickerView.currentIndex = [strongSelf.pickerDataModel.tenArray containsObject:@([textField.text intValue])] ?
        [strongSelf.pickerDataModel.tenArray indexOfObject:@([textField.text intValue])] : 0 ;
        [funcVC.pickerView show];
        funcVC.pickerView.pickerViewCallback = ^(NSString *selectStr) {
            textField.text = selectStr;
            textFieldModel.data = @[@([selectStr integerValue])];
            [[(FuncViewController *)viewController tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            strongSelf.noticeModel.callDelay  = [selectStr integerValue];
        };
    };
}

- (NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = @[@[@(self.noticeModel.isOnChild),@(self.noticeModel.callDelay),
                         @(self.noticeModel.isOnCall)],@[@(self.noticeModel.isOnSms),
                         @(self.noticeModel.isOnEmail),@(self.noticeModel.isOnWeChat),
                         @(self.noticeModel.isOnQq),@(self.noticeModel.isOnWeibo),
                         @(self.noticeModel.isOnFaceBook),@(self.noticeModel.isOnTwitter)],
                         @[@(self.noticeModel.isOnWhatsapp),@(self.noticeModel.isOnMessenger),
                         @(self.noticeModel.isOnInstagram),@(self.noticeModel.isOnLinkedIn),
                         @(self.noticeModel.isOnCalendar),@(self.noticeModel.isOnSkype),
                         @(self.noticeModel.isOnAlarm),@(self.noticeModel.isOnPokeman)],
                       @[@(self.noticeModel.isOnVkontakte),@(self.noticeModel.isOnLine),
                         @(self.noticeModel.isOnViber),@(self.noticeModel.isOnKakaoTalk),
                         @(self.noticeModel.isOnGmail),@(self.noticeModel.isOnOutlook),
                         @(self.noticeModel.isOnSnapchat),@(self.noticeModel.isOnTelegram)],
                       @[@(self.noticeModel.isOnChatwork),@(self.noticeModel.isOnSlack),
                         @(self.noticeModel.isOnYahooMail),@(self.noticeModel.isOnTumblr),
                         @(self.noticeModel.isOnYoutube),@(self.noticeModel.isOnYahooPinterest),
                         @(self.noticeModel.isOnKeep),@(self.noticeModel.isOnTikTok)],
                       @[@(self.noticeModel.isOnRedbus),@(self.noticeModel.isOnDailyhunt),
                       @(self.noticeModel.isOnHotstar),@(self.noticeModel.isOnInshorts),
                       @(self.noticeModel.isOnPaytm),@(self.noticeModel.isOnAmazon),
                       @(self.noticeModel.isOnFlipkart),@(self.noticeModel.isOnPrime)],
                       @[@(self.noticeModel.isOnNetflix),@(self.noticeModel.isOnGpay),
                       @(self.noticeModel.isOnPhonpe),@(self.noticeModel.isOnSwiggy),
                       @(self.noticeModel.isOnZomato),@(self.noticeModel.isOnMakeMyTrip),
                       @(self.noticeModel.isOnJioTv),@(self.noticeModel.isOnMicrosoft)],
                        @[@(self.noticeModel.isOnWhatsAppBusiness),@(self.noticeModel.isOnNioseFit),
                        @(self.noticeModel.isOnDidNotCall),@(self.noticeModel.isOnMattersRemind),
                        @(self.noticeModel.isOnUber),@(self.noticeModel.isOnOla),
                        @(self.noticeModel.isOnYtMusic),@(self.noticeModel.isOnGoogleMeet),
                        @(self.noticeModel.isOnMormaiiSmartwatch)],
                        @[@(self.noticeModel.isOnTechnosConnect),@(self.noticeModel.isOnEnioei),
                          @(self.noticeModel.isOnAliexpress),@(self.noticeModel.isOnShopee),
                        @(self.noticeModel.isOnTeams),@(self.noticeModel.isOn99Taxi),
                        @(self.noticeModel.isOnUberEats),@(self.noticeModel.isOnLfood)],
                        @[@(self.noticeModel.isOnRappi),@(self.noticeModel.isOnMercadoLivre),
                        @(self.noticeModel.isOnMagalu),@(self.noticeModel.isOnAmericanas),
                        @(self.noticeModel.isOnYahoo)]];
    }
    return _dataArray;
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    if (!self.pairingModel.isPairing) {
        FuncCellModel * model = [[FuncCellModel alloc]init];
        model.typeStr = @"oneButton";
        model.data = @[lang(@"first pairing bluetooth")];
        model.cellHeight = 70.0f;
        model.cellClass = [OneButtonTableViewCell class];
        model.modelClass = [NSNull class];
        model.isShowLine = YES;
        model.buttconCallback = self.buttconCallback;
        [cellModels addObject:model];
    }else {
        NSInteger index = 0;
        for (int i = 0; i < self.pickerDataModel.notifyTitleArray.count; i++) {
            NSArray * array1 = [self.pickerDataModel.notifyTitleArray objectAtIndex:i];
            NSArray * array2 = [self.dataArray objectAtIndex:i];
            for (int j = 0; j < array1.count; j++) {
                NSString * titleStr = [array1 objectAtIndex:j];
                NSInteger data = [[array2 objectAtIndex:j] integerValue];
                if (i == 0 && j == 1) {
                    TextFieldCellModel * model = [[TextFieldCellModel alloc]init];
                    model.typeStr = @"oneTextField";
                    model.titleStr = titleStr;
                    model.data = @[@(data)];
                    model.cellHeight = 60.0f;
                    model.cellClass = [OneTextFieldTableViewCell class];
                    model.modelClass = [NSNull class];
                    model.isShowLine = YES;
                    model.index = index;
                    model.textFeildCallback = self.textFeildCallback;
                    [cellModels addObject:model];
                }else {
                    SwitchCellModel * model = [[SwitchCellModel alloc]init];
                    model.typeStr = @"oneSwitch";
                    model.titleStr = titleStr;
                    model.data = @[@(data)];
                    model.cellHeight = 60.0f;
                    model.cellClass = [OneSwitchTableViewCell class];
                    model.modelClass = [NSNull class];
                    model.isShowLine = YES;
                    model.index = index;
                    model.switchCallback = self.switchCallback;
                    [cellModels addObject:model];
                }
                index ++ ;
            }
            EmpltyCellModel * model = [[EmpltyCellModel alloc]init];
            model.typeStr = @"empty";
            model.cellHeight = 30.0f;
            model.isShowLine = YES;
            model.cellClass  = [EmptyTableViewCell class];
            [cellModels addObject:model];
        }
        
        FuncCellModel * model = [[FuncCellModel alloc]init];
        model.typeStr = @"oneButton";
        model.data = @[lang(@"set notice switch button")];
        model.cellHeight = 70.0f;
        model.cellClass = [OneButtonTableViewCell class];
        model.modelClass = [NSNull class];
        model.isShowLine = YES;
        model.buttconCallback = self.buttconCallback;
        [cellModels addObject:model];
    }
    self.cellModels = cellModels;
}

@end
