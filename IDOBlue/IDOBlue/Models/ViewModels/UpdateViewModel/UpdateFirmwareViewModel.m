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
#import "GetEncryptionCodeViewModel.h"

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
        [self getViewWillDisappearCallback];
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
    
    TextViewCellModel * model3 = [[TextViewCellModel alloc]init];
    model3.typeStr = @"oneTextView";
    model3.data    = @[self.logStr ?: @""];
    model3.textViewCallback = self.textViewCallback;
    model3.isShowLine = YES;
    model3.cellHeight = [UIScreen mainScreen].bounds.size.height / 2 - 20;
    model3.cellClass  = [OneTextViewTableViewCell class];
    
    LabelCellModel * model4 = [[LabelCellModel alloc]init];
    model4.typeStr = @"oneLabel";
    model4.data = @[@"0"];
    model4.cellHeight = 100.0f;
    model4.cellClass  = [OneLabelTableViewCell class];
    model4.modelClass = [NSNull class];
    model4.fontSize   = 50;
    model4.isShowLine = YES;
    model4.isCenter   = YES;

    if ([IDOUpdateFirmwareManager shareInstance].updateType == IDO_NORDIC_PLATFORM_TYPE) {
        LabelCellModel * model2 = [[LabelCellModel alloc]init];
        model2.typeStr = @"oneLabel";
        model2.data    = @[[NSString stringWithFormat:@"Type : %@",fileType]];
        model2.cellHeight = 45.0f;
        model2.isShowLine = YES;
        model2.labelSelectCallback = self.labelSelectCallback;
        model2.cellClass  = [OneLabelTableViewCell class];
        model2.modelClass = [NSNull class];
        self.cellModels = @[model2,model1,model3,model4];
    }else {
        self.cellModels = @[model1,model3,model4];
    }
}

- (void)startTimer
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(startTimer) object:nil];
    LabelCellModel * cellModel = [self.cellModels lastObject];
    NSInteger count = [[cellModel.data lastObject] integerValue];
    count = count + 1;
    cellModel.data = @[[NSString stringWithFormat:@"%ld",(long)count]];
    FuncViewController * funcVC = (FuncViewController *)[IDODemoUtility getCurrentVC];
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:self.cellModels.count - 1 inSection:0];
    [funcVC.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    [self performSelector:@selector(startTimer) withObject:nil afterDelay:1];
}

- (void)getViewWillDisappearCallback
{
    __weak typeof(self) weakSelf = self;
    self.viewWillDisappearCallback = ^(UIViewController *viewController) {
        __strong typeof(self) strongSelf = weakSelf;
        [NSObject cancelPreviousPerformRequestsWithTarget:strongSelf selector:@selector(startTimer) object:nil];
    };
}

- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.threeButtonCallback = ^(NSInteger index, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
      FuncViewController * funcVC = (FuncViewController *)[IDODemoUtility getCurrentVC];
        if (index == 0) {
            NSInteger modeType = [[NSUserDefaults standardUserDefaults]integerForKey:PRODUCTION_MODE_KEY];
            if (modeType == 0) {
                [funcVC.navigationController popViewControllerAnimated:YES];
                return;
            }
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
        }else if (index == 1) {
            if (IDO_BLUE_ENGINE.managerEngine.isConnected) {
                 [funcVC showToastWithText:lang(@"device connected not need reconnected")];
                return;
            }
            LabelCellModel * cellModel = [strongSelf.cellModels lastObject];
            cellModel.data = @[@"0"];
            NSIndexPath * indexPath = [NSIndexPath indexPathForRow:strongSelf.cellModels.count - 1 inSection:0];
            [funcVC.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            [IDOBluetoothManager startScan];
        }else if (index == 2) {
            [IDOUpdateFirmwareManager startUpdate];
            [strongSelf startTimer];
        }
    };
}

- (void)getLabelSelectCallback
{
    __weak typeof(self) weakSelf = self;
    self.labelSelectCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * vc = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [vc.tableView indexPathForCell:tableViewCell];
        if (indexPath.row == 0) {
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
        }
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
    NSURL * url = [NSURL URLWithString:path];
    NSString * lastPathComponent = @"";
    if (!url) {
        lastPathComponent = [[path componentsSeparatedByString:@"/"] lastObject]?:@"";
    }else {
        lastPathComponent = url.lastPathComponent;
    }
    NSData * data = [NSData dataWithContentsOfFile:self.filePath];
    NSString * dataSize = [NSString stringWithFormat:@"%ld bytes",(long)data.length];
    NSString * nameStr = [@"Name : "stringByAppendingString:lastPathComponent];
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
        [NSObject cancelPreviousPerformRequestsWithTarget:self
                                                 selector:@selector(startTimer)
                                                   object:nil];
    }else if (state == IDO_UPDATE_START_RECONECT_DEVICE) { //进入ota 重连设备
        funcVC.statusLabel.text = [NSString stringWithFormat:@"%@...",lang(@"reconnect")];
    }else if (state != IDO_UPDATE_START_INIT
              && state != IDO_UPDATE_COMPLETED){
        funcVC.statusLabel.text = lang(@"update...");
    }
}

- (void)updateManager:(IDOUpdateFirmwareManager *)manager updateError:(NSError *)error
{
    if (error.code == 3) {
        [IDOFoundationCommand getFuncTableCommand:nil];
    }
    FuncViewController * funcVC = (FuncViewController *)[IDODemoUtility getCurrentVC];
    funcVC.statusLabel.text = lang(@"update failed");
    [funcVC showToastWithText:lang(@"update failed")];
    NSString * errorStr = [NSString stringWithFormat:@"%@\n",error.domain];
    [self addMessageText:errorStr];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(startTimer) object:nil];
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

- (IDO_REALTK_UPDATE_TYPE)selectRealtkTypeWithUpdateManager:(IDOUpdateFirmwareManager *_Nullable)manager
                                             supportOtaMode:(BOOL)isOtaMode
                                          supportSilentMode:(BOOL)isSilentMode
{
    return IDO_NORMAL_MODE_UPDATE_TYPE;
}

- (IDO_DATA_FILE_TRAN_TYPE)selectFileTranTypeUpdateManager:(IDOUpdateFirmwareManager *_Nullable)manager
{
    return IDO_DATA_FILE_TRAN_DIAL_TYPE;
}

- (IDO_DATA_TRAN_COMPRESSION_TYPE)fileTranCompressionTypeUpdateManager:(IDOUpdateFirmwareManager *)manager
{
    return IDO_DATA_TRAN_COMPRESSION_FASTLZ_TYPE;
}

- (NSString * _Nullable)fileTranNameUpdateManager:(IDOUpdateFirmwareManager *_Nullable)manager
{
    return @".fw";
}

- (NSInteger)setTransferNumberPacketsUpdateManager:(IDOUpdateFirmwareManager *)manager
{
    return 10;
}

@end
