//
//  UpdateEPOViewModel.m
//  IDOBlue
//
//  Created by huangkunhe on 2023/3/7.
//  Copyright © 2023 hedongyang. All rights reserved.
//

#import "UpdateEPOViewModel.h"
#import "FileViewModel.h"
#import "FuncCellModel.h"
#import "EmpltyCellModel.h"
#import "LabelCellModel.h"
#import "TextViewCellModel.h"
#import "FirmwareTypeViewModel.h"
#import "FuncViewController.h"
#import "EmptyTableViewCell.h"
#import "OneLabelTableViewCell.h"
#import "OneButtonTableViewCell.h"
#import "OneTextViewTableViewCell.h"

#define EPOUPDATETIME @"EPO_Update_Time"

@interface UpdateEPOViewModel()
@property (nonatomic,copy) NSString * logStr;
@property (nonatomic,strong) UITextView * textView;
@property (nonatomic,strong) NSString * filePathFolder;
@property (nonatomic,strong) NSString * fileName;
@property (nonatomic,strong) NSString * epofilePath;
@property (nonatomic,assign) NSInteger epofileDownSuc;

@property (nonatomic,copy)void(^textViewCallback)(UITextView * textView);
@property (nonatomic,copy)void(^labelSelectCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^buttconMakeFileCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^buttconDownloadFileCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);

@end

@implementation UpdateEPOViewModel

- (void)dealloc
{
   [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init
{
    self = [super init];
    if (self) {

        [self listenUpdateState];
        [self getViewWillDisappearCallback];
        [self getButtonCallback];
        [self getTextViewCallback];
        [self getLabelSelectCallback];
        [self getCellModels];
    }
    return self;
}

- (void)listenUpdateState
{
    __weak typeof(self) weakSelf = self;
    [IDOFoundationCommand listenStateChangeCommand:^(int errorCode, IDOControlDataUpdateModel * _Nullable model) {
        __strong typeof(self) strongSelf = weakSelf;
        if (errorCode == 0) {
            if (model.dataType == IDO_LISTEN_TYPE_UPDATE_EPO_FAIL) {
                FuncViewController * funcVC = (FuncViewController *)[IDODemoUtility getCurrentVC];
                [funcVC showToastWithText:lang(@"write complete fail")];
            }else if (model.dataType == IDO_LISTEN_TYPE_UPDATE_EPO_SUC) {
                FuncViewController * funcVC = (FuncViewController *)[IDODemoUtility getCurrentVC];
                [funcVC showToastWithText:lang(@"write complete suc")];
            };
        }
    }];
}


- (void)getViewWillDisappearCallback
{
    __weak typeof(self) weakSelf = self;
    self.viewWillDisappearCallback = ^(UIViewController *viewController) {
        __strong typeof(self) strongSelf = weakSelf;
        [NSObject cancelPreviousPerformRequestsWithTarget:strongSelf selector:@selector(startTimer) object:nil];
    };
}

- (void)getCellModels
{
    /*
    NSString * filePath = [[NSUserDefaults standardUserDefaults]objectForKey:TRAN_FILE_PATH_KEY];
    self.logStr = [self selectedFileWithFilePath:filePath];
    */
    
    NSString * fileType = @"online.ubx";
    [[NSUserDefaults standardUserDefaults]setValue:fileType forKey:FIRMWARE_FILE_TYPE_KEY];
    BOOL isOnline = [fileType isEqualToString: @"online.ubx"];
    LabelCellModel * model4 = [[LabelCellModel alloc]init];
    model4.typeStr = @"oneLabel";
//    model4.data    = @[[NSString stringWithFormat:@"Type : %@  [%@]",fileType,isOnline?@"online":@"offline"]];
    model4.cellHeight = 45.0f;
    model4.isShowLine = YES;
    model4.labelSelectCallback = self.labelSelectCallback;
    model4.cellClass  = [OneLabelTableViewCell class];
    model4.modelClass = [NSNull class];
    
    FuncCellModel * model6 = [[FuncCellModel alloc]init];
    model6.typeStr = @"oneButton";
    model6.data    = @[lang(@"download EPO file")];
    model6.cellHeight = 70.0f;
    model6.buttconCallback = self.buttconDownloadFileCallback;
    model6.cellClass  = [OneButtonTableViewCell class];
    
    FuncCellModel * model1 = [[FuncCellModel alloc]init];
    model1.typeStr = @"oneButton";
    model1.data    = @[lang(@"make EPO file (3->1)")];
    model1.cellHeight = 70.0f;
    model1.buttconCallback = self.buttconMakeFileCallback;
    model1.cellClass  = [OneButtonTableViewCell class];
    
    FuncCellModel * model5 = [[FuncCellModel alloc]init];
    model5.typeStr = @"oneButton";
    model5.data    = @[lang(@"file update")];
    model5.cellHeight = 70.0f;
    model5.buttconCallback = self.buttconCallback;
    model5.cellClass  = [OneButtonTableViewCell class];
    
    
    TextViewCellModel * model2 = [[TextViewCellModel alloc]init];
    model2.typeStr = @"oneTextView";
    model2.data    = @[self.logStr ?: @""];
    model2.textViewCallback = self.textViewCallback;
    model2.cellHeight = [UIScreen mainScreen].bounds.size.height / 2 - 20;
    model2.cellClass  = [OneTextViewTableViewCell class];
    
    LabelCellModel * model3 = [[LabelCellModel alloc]init];
    model3.typeStr = @"oneLabel";
    model3.data = @[@"0"];
    model3.cellHeight = 100.0f;
    model3.cellClass  = [OneLabelTableViewCell class];
    model3.modelClass = [NSNull class];
    model3.fontSize   = 50;
    model3.isShowLine = YES;
    model3.isCenter   = YES;
    
    self.cellModels = @[model4,model6,model1,model5,model2,model3];
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


- (void)addMessageText:(NSString *)message
{
    self.logStr = [NSString stringWithFormat:@"%@\n\n%@",self.textView.text,message];
    TextViewCellModel * model = [self.cellModels lastObject];
    model.data = @[self.logStr?:@""];
    self.textView.text = self.logStr;
    [self.textView scrollRangeToVisible:NSMakeRange(self.textView.text.length, 1)];
}


- (void)getButtonCallback
{
    
    __weak typeof(self) weakSelf = self;
    
    self.buttconDownloadFileCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        FuncViewController * funcVC = (FuncViewController *)viewController;
        if (!IDO_BLUE_ENGINE.managerEngine.isConnected)return ;
        
        IDOGpsManager*gpsManager = [IDOGpsManager shareInstance];
        
        if (!__IDO_FUNCTABLE__.funcTable34Model.supportAirohaGpsChip)
        {
            [funcVC showToastWithText:lang(@"Un support EPO update")];
            return;
        }
        
        if (![gpsManager startCheckoutOnlineAgpsEPOIsNeedUpdate]) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:lang(@"tip") message:lang(@"EPO files cannot be operated during this time period") preferredStyle:UIAlertControllerStyleAlert];

            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:lang(@"ok") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alertController addAction:cancelAction];
            [funcVC presentViewController:alertController animated:YES completion:nil];
            return;
        }
        
        [funcVC showLoadingWithMessage:lang(@"downloading")];

        [gpsManager downLoadEPOFile:^(IDOGpsUpgradeType status, NSString * _Nonnull epoFileFolder) {
            __strong typeof(self) strongSelf = weakSelf;
            dispatch_async(dispatch_get_main_queue(), ^{
                if (status == IDOGpsUpgradeTypeSucc) {
                    [funcVC showToastWithText:lang(@"download successfully")];
                    strongSelf.filePathFolder = epoFileFolder;
                    [strongSelf addMessageText:lang(@"download successfully")];
                }else{
                    [funcVC showToastWithText:lang(@"download failed")];
                    strongSelf.filePathFolder = nil;
                    [strongSelf addMessageText:lang(@"download failed")];
                }
            });
            
        }];
    };
    
    
    self.buttconMakeFileCallback= ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        if (!IDO_BLUE_ENGINE.managerEngine.isConnected)return ;
        if(self.filePathFolder.length <= 0){
            [funcVC showToastWithText:lang(@"download EPO file")];
            return;
        }

        strongSelf.epofilePath = [IDOGpsManager getMakeGpsZipFileWithFilePath:strongSelf.filePathFolder];

        if(strongSelf.epofilePath.length > 0){
            [strongSelf addMessageText:lang(@"make EPO successfully")];
            [funcVC showToastWithText:lang(@"make EPO successfully")];
        }else{
            [strongSelf addMessageText:lang(@"make EPO failed")];
            [funcVC showToastWithText:lang(@"make EPO failed")];
        }
                
    };
    
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        if (!IDO_BLUE_ENGINE.managerEngine.isConnected)return ;
        FuncViewController * funcVC = (FuncViewController *)viewController;

        if(strongSelf.epofilePath.length <= 0){
            [funcVC showToastWithText:lang(@"make EPO file (3->1)")];
            return;
        }
        [strongSelf updateAgpsWithVc:funcVC];
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
            typeModel.type = 2;
            typeModel.viewWillDisappearCallback = ^(UIViewController *viewController) {
                OneLabelTableViewCell * cell = (OneLabelTableViewCell *)tableViewCell;
                NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                LabelCellModel * labelModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
                NSString * fileType = [[NSUserDefaults standardUserDefaults]objectForKey:FIRMWARE_FILE_TYPE_KEY];
                if (!fileType) fileType = @"online.ubx";
                BOOL isOnline = [fileType isEqualToString: @"online.ubx"];
                labelModel.data = @[[NSString stringWithFormat:@"Type : %@  [%@]",fileType,isOnline?@"online":@"offline"]];
                cell.title.text = [NSString stringWithFormat:@"Type : %@  [%@]",fileType,isOnline?@"online":@"offline"];
            };
            funcVc.model = typeModel;
            funcVc.title = lang(@"agps update type");
            [viewController.navigationController pushViewController:funcVc animated:YES];
        }
    };
}

- (BOOL)startCheckoutOnlineAgpsIsUpdate{
   NSString*epoUpdateTime = [[NSUserDefaults standardUserDefaults] objectForKey:EPOUPDATETIME];
    if (epoUpdateTime.length <= 0) {
        return YES;
    }else{
        IDOSetTimeInfoBluetoothModel*timeinfo = [IDOSetTimeInfoBluetoothModel currentModel];
        NSInteger currentTimeStamp = timeinfo.timeStamp.integerValue;
        NSInteger timeInterval = currentTimeStamp - epoUpdateTime.integerValue;
        if (timeInterval >= 4*60*60 && !(timeinfo.hour >= 22 || timeinfo.hour <= 5)) {
            return YES;
        }else{
            return NO;
        }
    }
}

- (void)updateAgpsWithVc:(FuncViewController *)funcVC
{
    [self startTimer];
    
    NSString * fileType = [self.epofilePath lastPathComponent];
    NSString*names = [NSString stringWithFormat:@".%@",[fileType pathExtension]];
    
    if (names.length <= 0) {
        [funcVC showToastWithText:lang(@"download EPO file")];
        return;
    } else if (![fileType isEqualToString:@"EPO.DAT"]){
        [funcVC showToastWithText:lang(@"make EPO failed")];
        return;
    }
    
    [funcVC showLoadingWithMessage:[NSString stringWithFormat:@"%@...",lang(@"file update")]];
    initTransferManager().transferType = IDO_DATA_FILE_TRAN_AGPS_TYPE;
    initTransferManager().compressionType = IDO_DATA_TRAN_COMPRESSION_NO_USE_TYPE;
    initTransferManager().fileName = @"EPO.DAT";
    initTransferManager().isSetConnectParam = YES;
    initTransferManager().isQueryWriteState = NO;
    initTransferManager().filePath = self.epofilePath;
    
    __weak typeof(self) weakSelf = self;
    initTransferManager().addDetection(^(int errorCode) {
        __strong typeof(self) strongSelf = weakSelf;
        [NSObject cancelPreviousPerformRequestsWithTarget:strongSelf selector:@selector(startTimer) object:nil];
        strongSelf.textView.text = [NSString stringWithFormat:@"%@\n%@\n\n",strongSelf.textView.text,[IDOErrorCodeToStr errorCodeToStr:errorCode]];
        [funcVC showToastWithText:lang(@"transfer complete")];
    }).addProgress(^(int progress) {
        [funcVC showSyncProgress:progress/100.0f];
    }).addTransfer(^(int errorCode,int value) {
        __strong typeof(self) strongSelf = weakSelf;
        [NSObject cancelPreviousPerformRequestsWithTarget:strongSelf selector:@selector(startTimer) object:nil];
        strongSelf.textView.text = [NSString stringWithFormat:@"%@\n%@\n\n",strongSelf.textView.text,[IDOErrorCodeToStr errorCodeToStr:errorCode]];
        [funcVC showToastWithText:lang(@"transfer complete")];
        if (errorCode == 0) {
            strongSelf.filePathFolder = nil;
            [[IDOGpsManager shareInstance] updateAgpsEPOFileUpdateTimeNow];
        }
    });
    [IDOTransferFileManager startTransfer];
}



- (void)getTextViewCallback
{
    __weak typeof(self) weakSelf = self;
    self.textViewCallback = ^(UITextView *textView) {
        __strong typeof(self) strongSelf = weakSelf;
        strongSelf.textView = textView;
    };
}


@end
