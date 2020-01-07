//
//  UpdateViewModel.m
//  IDOBluetoothDemo
//
//  Created by apple on 2018/9/16.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "UpdateFirmwareViewModel.h"
#import "FileViewModel.h"
#import "TabCellModel.h"
#import "LabelCellModel.h"
#import "TextViewCellModel.h"
#import "FuncViewController.h"
#import "OneLabelTableViewCell.h"
#import "ThreeButtonTableViewCell.h"
#import "OneTextViewTableViewCell.h"
#import "ScanViewController.h"
#import "FirmwareTypeViewModel.h"
#import "OneLabelTableViewCell.h"

@interface UpdateFirmwareViewModel()<IDOUpdateManagerDelegate>
@property (nonatomic,copy) NSString * logStr;
@property (nonatomic,strong) UITextView * textView;
@property (nonatomic,strong) NSString * filePath;
@property (nonatomic,copy)void(^textViewCallback)(UITextView * textView);
@property (nonatomic,copy)void(^labelSelectCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^threeButtonCallback)(NSInteger index,UITableViewCell * tableViewCell);;
@end

@implementation UpdateFirmwareViewModel

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.rightButtonTitle = lang(@"selected firmware");
        self.isRightButton = YES;
        self.rightButton   = @selector(actionButton:);
        [self getViewWillAppearCallback];
        [self getButtonCallback];
        [self getLabelSelectCallback];
        [self getTextViewCallback];
        [self getCellModels];
        [IDOUpdateFirmwareManager shareInstance].delegate = self;
        [[NSNotificationCenter defaultCenter]addObserver:self
                                                selector:@selector(selectFileNotice:)
                                                    name:@"idoDemoSelectFileNotice"
                                                  object:nil];
    }
    return self;
}

- (void)actionButton:(UIButton *)sender
{
    FuncViewController * vc = [[FuncViewController alloc]init];
    FileViewModel * fileModel = [FileViewModel new];
    fileModel.type = 0;
    vc.model = fileModel;
    vc.title = lang(@"selected firmware");
    [[IDODemoUtility getCurrentVC].navigationController pushViewController:vc animated:YES];
}

- (void)selectFileNotice:(NSNotification*)notice
{
    NSString * filePath = [[NSUserDefaults standardUserDefaults]objectForKey:FIRMWARE_FILE_PATH_KEY];
    NSString * infoStr = [self getCuttentFirmwareFileInfo:filePath];
    [self addMessageText:infoStr];
}

- (void)getViewWillAppearCallback
{
    self.viewWillAppearCallback = ^(UIViewController *viewController) {
        NSInteger modeType = [[NSUserDefaults standardUserDefaults]integerForKey:PRODUCTION_MODE_KEY];
        if (modeType == 1) {
            viewController.navigationItem.hidesBackButton = YES;
        }
    };
}

- (void)getCellModels
{
    NSString * filePath = [[NSUserDefaults standardUserDefaults]objectForKey:FIRMWARE_FILE_PATH_KEY];
    self.logStr = [self getCuttentFirmwareFileInfo:filePath];
    
    NSString * fileType = [[NSUserDefaults standardUserDefaults]objectForKey:FIRMWARE_FILE_TYPE_KEY];
    if (!fileType) fileType = @"Application";
    
    TabCellModel * model1 = [[TabCellModel alloc]init];
    model1.typeStr = @"threeButton";
    model1.data = @[lang(@"exit update"),lang(@"reconnect"),lang(@"firmware update")];
    model1.selectIndexs = @[[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES]];
    model1.cellHeight = 70.0f;
    model1.isShowLine = YES;
    model1.cellClass = [ThreeButtonTableViewCell class];
    model1.modelClass = [NSNull class];
    model1.threeButtonCallback = self.threeButtonCallback;

    LabelCellModel * model2 = [[LabelCellModel alloc]init];
    model2.typeStr = @"oneLabel";
    model2.data    = @[[NSString stringWithFormat:@"Type : %@",fileType]];
    model2.cellHeight = 45.0f;
    model2.isShowLine = YES;
    model2.labelSelectCallback = self.labelSelectCallback;
    model2.cellClass  = [OneLabelTableViewCell class];
    model2.modelClass = [NSNull class];
    
    TextViewCellModel * model3 = [[TextViewCellModel alloc]init];
    model3.typeStr = @"oneTextView";
    model3.data    = @[self.logStr ?: @""];
    model3.textViewCallback = self.textViewCallback;
    model3.isShowLine = YES;
    model3.cellHeight = [UIScreen mainScreen].bounds.size.height / 2 - 20;
    model3.cellClass  = [OneTextViewTableViewCell class];
    
    self.cellModels = @[model2,model1,model3];
}

- (void)getButtonCallback
{
    self.threeButtonCallback = ^(NSInteger index, UITableViewCell *tableViewCell) {
      FuncViewController * funcVC = (FuncViewController *)[IDODemoUtility getCurrentVC];
        if (index == 0) {
            [funcVC showLoadingWithMessage:lang(@"exit update...")];
            [IDOFoundationCommand mandatoryUnbindingCommand:^(int errorCode) {
                if (errorCode == 0) {
                    [funcVC showToastWithText:lang(@"exit success")];
                    ScanViewController * scanVC  = [[ScanViewController alloc]init];
                    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:scanVC];
                    [UIApplication sharedApplication].delegate.window.rootViewController = nav;
                }else {
                    [funcVC showToastWithText:lang(@"exit failed")];
                }
            }];
        }else if (index == 1) {
            if (IDO_BLUE_ENGINE.managerEngine.isConnected) {
                 [funcVC showToastWithText:lang(@"device connected not need reconnected")];
                return;
            }
            [IDOBluetoothManager startScan];
        }else if (index == 2) {
            if (   !IDO_BLUE_ENGINE.managerEngine.isConnected
                &&  [IDOUpdateFirmwareManager shareInstance].updateType != IDO_REALTK_PLATFORM_TYPE)return;
            if ([IDOUpdateFirmwareManager shareInstance].updateType == IDO_REALTK_PLATFORM_TYPE) {
                NSInteger modeType = [[NSUserDefaults standardUserDefaults]integerForKey:PRODUCTION_MODE_KEY];
                if (modeType == 1) { //升级模式
                    [IDOFoundationCommand getDeviceInfoCommand:^(int errorCode, IDOGetDeviceInfoBluetoothModel * _Nullable data) {
                        if (errorCode == 0) {
                            [IDOFoundationCommand getOtaAuthInfoCommand:^(int errorCode, int stateCode) {
                                if (errorCode == 0 && stateCode == 0) {
                                    [funcVC showLoadingWithMessage:lang(@"enter update...")];
                                    [IDOUpdateFirmwareManager startUpdate];
                                }
                            }];
                        }else {
                            [funcVC showToastWithText:lang(@"get device information failed")];
                        }
                    }];
                }else { //普通模式
                    [IDOFoundationCommand getOtaAuthInfoCommand:^(int errorCode, int stateCode) {
                        if (errorCode == 0 && stateCode == 0) {
                            [funcVC showLoadingWithMessage:lang(@"enter update...")];
                            [IDOUpdateFirmwareManager startUpdate];
                        }else if (errorCode == 6) {
                            [funcVC showToastWithText:lang(@"get device information")];
                        }
                    }];
                }
            }else {
                [funcVC showLoadingWithMessage:lang(@"enter update...")];
                [IDOUpdateFirmwareManager startUpdate];
            }
        }
    };
}

- (void)getLabelSelectCallback
{
    __weak typeof(self) weakSelf = self;
    self.labelSelectCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVc = [[FuncViewController alloc]init];
        FirmwareTypeViewModel * typeModel = [FirmwareTypeViewModel new];
        typeModel.viewWillDisappearCallback = ^(UIViewController *viewController) {
            OneLabelTableViewCell * cell = (OneLabelTableViewCell *)tableViewCell;
            NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            LabelCellModel * labelModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
            NSString * fileType = [[NSUserDefaults standardUserDefaults]objectForKey:FIRMWARE_FILE_TYPE_KEY];
            if (!fileType) fileType = @"Application";
            labelModel.data = @[[NSString stringWithFormat:@"Type : %@",fileType]];
            cell.title.text = [NSString stringWithFormat:@"Type : %@",fileType];
        };
        funcVc.model = typeModel;
        funcVc.title = lang(@"firmware type");
        [viewController.navigationController pushViewController:funcVc animated:YES];
    };
}

- (void)getTextViewCallback
{
    __weak typeof(self) weakSelf = self;
    self.textViewCallback = ^(UITextView *textView) {
        __strong typeof(self) strongSelf = weakSelf;
        strongSelf.textView = textView;
    };
}

- (NSString *)getCuttentFirmwareFileInfo:(NSString *)filePath
{
    if (filePath.length == 0) return @"";
    NSInteger fileMode  = [[[NSUserDefaults standardUserDefaults]objectForKey:FILE_MODE_KEY] integerValue];
    NSString * fileName = @"";
    NSString * path     = @"";
    if (fileMode == 0) { // bundle
        NSString * mainPath = [NSBundle mainBundle].bundlePath;
        path = [mainPath stringByAppendingPathComponent:@"Firmwares"];
        NSURL * fileUrl = [NSURL URLWithString:filePath];
        fileName = fileUrl.lastPathComponent;
        path = [path stringByAppendingPathComponent:fileName];
    }else { // sandbox
        path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) lastObject];
        NSRange range = [filePath rangeOfString:@"Documents"];
        if (range.location != NSNotFound) {
           fileName = [filePath substringFromIndex:range.location + range.length];
           path = [path stringByAppendingPathComponent: fileName];
        }
    }
    
    self.filePath = path;
    
    NSData * data = [NSData dataWithContentsOfFile:self.filePath];
    NSString * dataSize = [NSString stringWithFormat:@"%ld bytes",(long)data.length];
    NSString * nameStr = [@"Name : "stringByAppendingString:fileName];
    NSString * sizeStr = [@"Size : "stringByAppendingString:dataSize];
    NSString * fileType = [[NSUserDefaults standardUserDefaults]objectForKey:FIRMWARE_FILE_TYPE_KEY];
    if (!fileType) fileType = @"Application";
    NSString * typeStr = [@"Type : "stringByAppendingString:fileType];
    NSString * fileStr = [NSString stringWithFormat:@"%@\n%@\n%@",nameStr,sizeStr,typeStr];
    return fileStr;
}

- (void)addMessageText:(NSString *)message
{
    self.logStr = [NSString stringWithFormat:@"%@\n\n%@",self.textView.text,message];
    self.textView.text = self.logStr;
    [self.textView scrollRangeToVisible:NSMakeRange(self.textView.text.length, 1)];
}

#pragma mark ======================== IDOUpdateMangerDelegate===================================
- (NSString *)currentPackagePathWithUpdateManager:(IDOUpdateFirmwareManager *)manager
{
    return self.filePath;
}

- (void)updateManager:(IDOUpdateFirmwareManager *)manager
                state:(IDO_UPDATE_STATE)state
{
    FuncViewController * funcVC = (FuncViewController *)[IDODemoUtility getCurrentVC];
    if (state == IDO_UPDATE_COMPLETED) {
        funcVC.statusLabel.text = lang(@"update success");
        [funcVC showToastWithText:lang(@"update success")];
        int mode = (int)[[NSUserDefaults standardUserDefaults]integerForKey:PRODUCTION_MODE_KEY];
        if (!__IDO_BIND__ || mode == 1) {
            [IDOFoundationCommand mandatoryUnbindingCommand:^(int errorCode) {
                if (errorCode == 0) {
                    ScanViewController * scanVC  = [[ScanViewController alloc]init];
                    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:scanVC];
                    [UIApplication sharedApplication].delegate.window.rootViewController = nav;
                }
            }];
        }
    }else {
       funcVC.statusLabel.text = lang(@"update...");
    }
}

- (void)updateManager:(IDOUpdateFirmwareManager *)manager updateError:(NSError *)error
{
    FuncViewController * funcVC = (FuncViewController *)[IDODemoUtility getCurrentVC];
    funcVC.statusLabel.text = lang(@"update failed");
    [funcVC showToastWithText:lang(@"update failed")];
    NSString * errorStr = [NSString stringWithFormat:@"%@\n",error.domain];
    [self addMessageText:errorStr];
}

- (void)updateManager:(IDOUpdateFirmwareManager *)manager
             progress:(float)progress
              message:(NSString *)message
{
    if (progress > 0) {
        FuncViewController * funcVC = (FuncViewController *)[IDODemoUtility getCurrentVC];
        [funcVC showUpdateProgress:progress];
    }else {
        [self addMessageText:message?:@""];
    }
}

/********此方法可以忽略*********/
- (IDO_UPDATE_DFU_FIRMWARE_TYPE)selectDfuFirmwareTypeWithUpdateManager:(IDOUpdateFirmwareManager * _Nullable)manager {
    NSString * fileType = [[NSUserDefaults standardUserDefaults]objectForKey:FIRMWARE_FILE_TYPE_KEY];
    if (!fileType) fileType = @"Application";
    IDO_UPDATE_DFU_FIRMWARE_TYPE type = IDO_DFU_FIRMWARE_APPLICATION_TYPE;
    if (![fileType isEqualToString:@"Application"]) {
        type = [self.pickerDataModel.firmwareTypes indexOfObject:fileType] + 1;
    }
    return type;
}


@end
