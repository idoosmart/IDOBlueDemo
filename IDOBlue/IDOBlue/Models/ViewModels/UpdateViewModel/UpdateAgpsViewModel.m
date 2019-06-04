//
//  UpdateAgpsViewModel.m
//  IDOBlue
//
//  Created by apple on 2018/10/4.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "UpdateAgpsViewModel.h"
#import "FileViewModel.h"
#import "FuncCellModel.h"
#import "EmpltyCellModel.h"
#import "TextViewCellModel.h"
#import "FuncViewController.h"
#import "EmptyTableViewCell.h"
#import "OneButtonTableViewCell.h"
#import "OneTextViewTableViewCell.h"

@interface UpdateAgpsViewModel()
@property (nonatomic,copy) NSString * logStr;
@property (nonatomic,strong) UITextView * textView;
@property (nonatomic,strong) NSString * filePath;
@property (nonatomic,assign) NSInteger theLength;
@property (nonatomic,copy)void(^textViewCallback)(UITextView * textView);
@property (nonatomic,copy)void(^labelSelectCallback)(UIViewController * viewController,NSString * titleStr);
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation UpdateAgpsViewModel

- (void)dealloc
{
   [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.rightButtonTitle = lang(@"selected AGPS file");
        self.isRightButton = YES;
        self.rightButton   = @selector(actionButton:);
        [self getButtonCallback];
        [self getTextViewCallback];
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
    vc.title = lang(@"selected AGPS file");
    [[IDODemoUtility getCurrentVC].navigationController pushViewController:vc animated:YES];
}

- (void)selectFileNotice:(NSNotification*)notice
{
    NSString * filePath = [[NSUserDefaults standardUserDefaults]objectForKey:AGPS_FILE_PATH_KEY];
    NSString * infoStr = [self selectedFileWithFilePath:filePath];
    [self addMessageText:infoStr];
}

- (void)getCellModels
{
    NSString * filePath = [[NSUserDefaults standardUserDefaults]objectForKey:AGPS_FILE_PATH_KEY];
    self.logStr = [self selectedFileWithFilePath:filePath];
    
    FuncCellModel * model1 = [[FuncCellModel alloc]init];
    model1.typeStr = @"oneButton";
    model1.data    = @[lang(@"AGPS update")];
    model1.cellHeight = 70.0f;
    model1.buttconCallback = self.buttconCallback;
    model1.cellClass  = [OneButtonTableViewCell class];
    
    TextViewCellModel * model2 = [[TextViewCellModel alloc]init];
    model2.typeStr = @"oneTextView";
    model2.data    = @[self.logStr ?: @""];
    model2.textViewCallback = self.textViewCallback;
    model2.cellHeight = [UIScreen mainScreen].bounds.size.height / 2 - 20;
    model2.cellClass  = [OneTextViewTableViewCell class];
    
    self.cellModels = @[model1,model2];
}

- (NSString *)selectedFileWithFilePath:(NSString *)filePath
{
    if (filePath.length == 0) return @"";
    NSInteger fileMode  = [[[NSUserDefaults standardUserDefaults]objectForKey:FILE_MODE_KEY] integerValue];
    NSString * fileName = @"";
    NSString * path = @"";
    if (fileMode == 0) { // bundle
        NSString * mainPath = [NSBundle mainBundle].bundlePath;
        path = [mainPath stringByAppendingPathComponent:@"Agps"];
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
    NSData * data = [NSData dataWithContentsOfFile:filePath];
    NSString * dataSize = [NSString stringWithFormat:@"%ld bytes",(long)data.length];
    NSString * nameStr = [@"Name : "stringByAppendingString:fileName];
    NSString * sizeStr = [@"Size : "stringByAppendingString:dataSize];
    NSString * typeStr = [@"Type : "stringByAppendingString:@"AGPS File"];
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

- (void)computationTime
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(computationTime) object:nil];
    self.theLength ++;
    [self performSelector:@selector(computationTime) withObject:nil afterDelay:1.0];
}

- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        if (!IDO_BLUE_ENGINE.managerEngine.isConnected)return ;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        strongSelf.theLength = 0;
        [strongSelf computationTime];
        //agps文件启动传输
        [IDOFoundationCommand getGpsStatusCommand:^(int errorCode, IDOGetGpsStatusBluetoothModel * _Nullable data) {
            if (data.gpsRunStatus == 0) {
                [IDOUpdateAgpsManager updateAgpsWithPath:strongSelf.filePath isSetParam:YES prepareCallback:^(int errorCode) {
                    if (errorCode == 0) {
                        [funcVC showLoadingWithMessage:lang(@"file ready for transfer...")];
                        [strongSelf addMessageText:@"agps file is prepare transmission"];
                        [IDOUpdateAgpsManager startUpdate];
                    }else {
                        [NSObject cancelPreviousPerformRequestsWithTarget:strongSelf selector:@selector(computationTime) object:nil];
                        [funcVC showToastWithText:lang(@"file does not exist")];
                        [strongSelf addMessageText:@"agps file is no exist"];
                    }
                }];
                //agps文件传输完成，启动写入
                [IDOUpdateAgpsManager updateAgpsTransmissionComplete:^(int errorCode) {
                    __strong typeof(self) strongSelf = weakSelf;
                    if(errorCode == 0) {
                        [funcVC showLoadingWithMessage:lang(@"file write...")];
                        [strongSelf addMessageText:@"agps file writing..."];
                    }else {
                        [funcVC showToastWithText:lang(@"file transfer failed")];
                        [strongSelf addMessageText:@"agps file transmission failed"];
                        [NSObject cancelPreviousPerformRequestsWithTarget:strongSelf selector:@selector(computationTime) object:nil];
                    }
                } writeComplete:^(int errorCode) {//写入文件成功
                    if (errorCode == 0) {
                        [funcVC showToastWithText:lang(@"file write success")];
                        [strongSelf addMessageText:@"agps file write sucess"];
                        [strongSelf addMessageText:[NSString stringWithFormat:@"agps file time of update : %ld",(long)strongSelf.theLength]];
                        [NSObject cancelPreviousPerformRequestsWithTarget:strongSelf selector:@selector(computationTime) object:nil];
                    }else {
                        [funcVC showToastWithText:lang(@"file write failed")];
                        [strongSelf addMessageText:@"agps file write failed"];
                        [NSObject cancelPreviousPerformRequestsWithTarget:strongSelf selector:@selector(computationTime) object:nil];
                    }
                }];
                //agps文件传输进度
                [IDOUpdateAgpsManager updateAgpsProgressCallback:^(int progress) {
                    [funcVC showUpdateProgress:progress/100.0f];
                }];
            }
        }];
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



@end
