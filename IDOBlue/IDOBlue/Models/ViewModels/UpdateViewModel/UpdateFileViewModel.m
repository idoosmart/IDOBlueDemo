//
//  UpdateFileViewModel.m
//  IDOBlue
//
//  Created by huangkunhe on 2022/10/9.
//  Copyright © 2022 hedongyang. All rights reserved.
//

#import "UpdateFileViewModel.h"
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

@interface UpdateFileViewModel()
@property (nonatomic,copy) NSString * logStr;
@property (nonatomic,strong) UITextView * textView;
@property (nonatomic,strong) NSString * filePath;
@property (nonatomic,strong) NSString * fileName;
@property (nonatomic,copy)void(^textViewCallback)(UITextView * textView);
@property (nonatomic,copy)void(^labelSelectCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation UpdateFileViewModel

- (void)dealloc
{
   [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.rightButtonTitle = lang(@"selected agps file");
        self.isRightButton = YES;
        self.rightButton   = @selector(actionButton:);
        [self getViewWillDisappearCallback];
        [self getButtonCallback];
        [self getTextViewCallback];
        [self getLabelSelectCallback];
        [self getCellModels];
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
    fileModel.type = 1;
    vc.model = fileModel;
    vc.title = lang(@"selected agps file");
    [[IDODemoUtility getCurrentVC].navigationController pushViewController:vc animated:YES];
}

- (void)selectFileNotice:(NSNotification*)notice
{
    NSString * filePath = [[NSUserDefaults standardUserDefaults]objectForKey:TRAN_FILE_PATH_KEY];
    NSString * infoStr = [self selectedFileWithFilePath:filePath];
    [self addMessageText:infoStr];
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
    
    FuncCellModel * model1 = [[FuncCellModel alloc]init];
    model1.typeStr = @"oneButton";
    model1.data    = @[lang(@"file update")];
    model1.cellHeight = 70.0f;
    model1.buttconCallback = self.buttconCallback;
    model1.cellClass  = [OneButtonTableViewCell class];
    
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
    
    self.cellModels = @[model4,model1,model2,model3];
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

- (NSString *)selectedFileWithFilePath:(NSString *)filePath
{
    if (filePath.length == 0) return @"";
    NSInteger fileMode  = [[[NSUserDefaults standardUserDefaults]objectForKey:FILE_MODE_KEY] integerValue];
    NSString * fileName = @"";
    NSString * path = @"";
    if (fileMode == 0) { // bundle
        NSString * mainPath = [NSBundle mainBundle].bundlePath;
        path = [mainPath stringByAppendingPathComponent:@"Files"];
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
    self.fileName = lastPathComponent;
    NSData * data = [NSData dataWithContentsOfFile:self.filePath];
    NSString * dataSize = [NSString stringWithFormat:@"%ld bytes",(long)data.length];
    NSString * nameStr = [@"Name : "stringByAppendingString:lastPathComponent];
    NSString * sizeStr = [@"Size : "stringByAppendingString:dataSize];
    NSString * fileType = [self.filePath lastPathComponent];
    NSString * typeStr = [@"Type : "stringByAppendingString:[fileType pathExtension]];
    NSString * fileStr = [NSString stringWithFormat:@"%@\n%@\n%@",nameStr,sizeStr,typeStr];
    return fileStr;
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
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        if (!IDO_BLUE_ENGINE.managerEngine.isConnected)return ;
        FuncViewController * funcVC = (FuncViewController *)viewController;
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

- (void)updateAgpsWithVc:(FuncViewController *)funcVC
{
    [self startTimer];
    
    NSString * fileType = [self.filePath lastPathComponent];
    NSString*names = [NSString stringWithFormat:@".%@",[fileType pathExtension]];
    
    if (names.length <= 0) {
        [funcVC showToastWithText:lang(@"selected agps file")];
    }
    [funcVC showLoadingWithMessage:[NSString stringWithFormat:@"%@...",lang(@"file update")]];
    initTransferManager().transferType = IDO_DATA_FILE_TRAN_DIAL_TYPE;
    initTransferManager().compressionType = IDO_DATA_TRAN_COMPRESSION_NO_USE_TYPE;
    initTransferManager().isSetConnectParam = YES;
    initTransferManager().isQueryWriteState = YES;
    initTransferManager().fileName = names;
    initTransferManager().filePath = self.filePath;
    
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
    }).addWrite(^(int errorCode) {
        __strong typeof(self) strongSelf = weakSelf;
        [NSObject cancelPreviousPerformRequestsWithTarget:strongSelf selector:@selector(startTimer) object:nil];
        strongSelf.textView.text = [NSString stringWithFormat:@"%@\n%@\n\n",strongSelf.textView.text,[IDOErrorCodeToStr errorCodeToStr:errorCode]];
        [funcVC showToastWithText:lang(@"write complete")];
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

