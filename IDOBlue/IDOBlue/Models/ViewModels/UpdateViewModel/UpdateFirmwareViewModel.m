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

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isRightButton = YES;
        self.rightButton   = @selector(actionButton:);
        [self getButtonCallback];
        [self getLabelSelectCallback];
        [self getTextViewCallback];
        [self getCellModels];
        [IDOUpdateFirmwareManager shareInstance].delegate = self;
    }
    return self;
}

- (void)actionButton:(UIButton *)sender
{
    FuncViewController * vc = [[FuncViewController alloc]init];
    FileViewModel * fileModel = [FileViewModel new];
    fileModel.type = 0;
    __weak typeof(self) weakSelf = self;
    fileModel.viewWillDisappearCallback = ^(UIViewController *viewController) {
        __strong typeof(self) strongSelf = weakSelf;
        NSString * filePath = [[NSUserDefaults standardUserDefaults]objectForKey:FIRMWARE_FILE_PATH_KEY];
        NSString * infoStr = [strongSelf getCuttentFirmwareFileInfo:filePath];
        [strongSelf addMessageText:infoStr];
    };
    vc.model = fileModel;
    vc.title = @"选择固件";
    [[IDODemoUtility getCurrentVC].navigationController pushViewController:vc animated:YES];
}

- (void)getCellModels
{
    NSString * filePath = [[NSUserDefaults standardUserDefaults]objectForKey:FIRMWARE_FILE_PATH_KEY];
    self.logStr = [self getCuttentFirmwareFileInfo:filePath];
    
    NSString * fileType = [[NSUserDefaults standardUserDefaults]objectForKey:FIRMWARE_FILE_TYPE_KEY];
    if (!fileType) fileType = @"Application";
    
    TabCellModel * model1 = [[TabCellModel alloc]init];
    model1.typeStr = @"threeButton";
    model1.data = @[@"退出升级",@"重新连接",@"固件升级"];
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
            [funcVC showLoadingWithMessage:@"退出升级..."];
            [IDOFoundationCommand mandatoryUnbindingCommand:^(int errorCode) {
                if (errorCode == 0) {
                    [funcVC showToastWithText:@"退出成功"];
                    ScanViewController * scanVC  = [[ScanViewController alloc]init];
                    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:scanVC];
                    [UIApplication sharedApplication].delegate.window.rootViewController = nav;
                }else {
                    [funcVC showToastWithText:@"退出失败"];
                }
            }];
        }else if (index == 1) {
            if (IDO_BLUE_ENGINE.managerEngine.isConnected) {
                 [funcVC showToastWithText:@"设备已连接无需再重连"];
                return;
            }
            [IDOBluetoothManager startScan];
        }else if (index == 2) {
            if (!IDO_BLUE_ENGINE.managerEngine.isConnected)return;
            [funcVC showLoadingWithMessage:@"进入升级..."];
            [IDOUpdateFirmwareManager startUpdate];
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
        funcVc.title = @"固件包类型";
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
    NSURL * fileUrl = [NSURL URLWithString:filePath];
    NSInteger type = [[NSUserDefaults standardUserDefaults]integerForKey:PRODUCTION_MODE_KEY];
    NSString * path = nil;
    if(type == 0) {
        NSString * docsdir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) lastObject];
        path = [docsdir stringByAppendingPathComponent:@"Firmwares"];
    }else {
        NSString * filePath = [NSBundle mainBundle].bundlePath;
        path = [filePath stringByAppendingPathComponent:@"Firmwares"];
    }
    filePath = [path stringByAppendingPathComponent:fileUrl.lastPathComponent];
    self.filePath = filePath;
    
    NSData * data = [NSData dataWithContentsOfFile:filePath];
    NSString * dataSize = [NSString stringWithFormat:@"%ld bytes",(long)data.length];
    NSString * nameStr = [@"Name : "stringByAppendingString:fileUrl.lastPathComponent];
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
        funcVC.statusLabel.text = @"升级成功";
        [funcVC showToastWithText:@"升级成功"];
        if (!__IDO_BIND__) {
            [IDOFoundationCommand mandatoryUnbindingCommand:^(int errorCode) {
                if (errorCode == 0) {
                    ScanViewController * scanVC  = [[ScanViewController alloc]init];
                    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:scanVC];
                    [UIApplication sharedApplication].delegate.window.rootViewController = nav;
                }
            }];
        }
    }else {
       funcVC.statusLabel.text = @"升级中...";
    }
}

- (void)updateManager:(IDOUpdateFirmwareManager *)manager updateError:(NSError *)error
{
    FuncViewController * funcVC = (FuncViewController *)[IDODemoUtility getCurrentVC];
    funcVC.statusLabel.text = @"升级失败";
    [funcVC showToastWithText:@"升级失败"];
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
