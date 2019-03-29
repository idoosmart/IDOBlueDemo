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
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.rightButtonTitle = @"选择AGPS文件";
        self.isRightButton = YES;
        self.rightButton   = @selector(actionButton:);
        [self getButtonCallback];
        [self getTextViewCallback];
        [self getCellModels];
    }
    return self;
}

- (void)actionButton:(UIButton *)sender
{
    FuncViewController * vc = [[FuncViewController alloc]init];
    FileViewModel * fileModel = [FileViewModel new];
    fileModel.type = 1;
    __weak typeof(self) weakSelf = self;
    fileModel.viewWillDisappearCallback = ^(UIViewController *viewController) {
        __strong typeof(self) strongSelf = weakSelf;
        NSString * filePath = [[NSUserDefaults standardUserDefaults]objectForKey:AGPS_FILE_PATH_KEY];
        NSString * infoStr = [strongSelf selectedFileWithFilePath:filePath];
        [strongSelf addMessageText:infoStr];
    };
    vc.model = fileModel;
    vc.title = @"选择AGPS文件";
    [[IDODemoUtility getCurrentVC].navigationController pushViewController:vc animated:YES];
}

- (void)getCellModels
{
    NSString * filePath = [[NSUserDefaults standardUserDefaults]objectForKey:AGPS_FILE_PATH_KEY];
    self.logStr = [self selectedFileWithFilePath:filePath];
    
    FuncCellModel * model1 = [[FuncCellModel alloc]init];
    model1.typeStr = @"oneButton";
    model1.data    = @[@"AGPS更新"];
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
    
    NSURL * fileUrl = [NSURL URLWithString:filePath];
    NSString * fileName = [fileUrl lastPathComponent];
    NSString * path = [[NSBundle mainBundle].bundlePath stringByAppendingPathComponent:@"Agps"];
    filePath = [path stringByAppendingPathComponent:fileName];
    self.filePath = filePath;
    NSData * data = [NSData dataWithContentsOfFile:filePath];
    
    NSString * dataSize = [NSString stringWithFormat:@"%ld bytes",(long)data.length];
    NSString * nameStr = [@"Name : "stringByAppendingString:fileUrl.lastPathComponent];
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
                [IDOUpdateAgpsManager updateAgpsWithPath:strongSelf.filePath prepareCallback:^(int errorCode) {
                    if (errorCode == 0) {
                        [funcVC showLoadingWithMessage:@"文件准备传输..."];
                        [strongSelf addMessageText:@"agps file is prepare transmission"];
                        [IDOUpdateAgpsManager startUpdate];
                    }else {
                        [NSObject cancelPreviousPerformRequestsWithTarget:strongSelf selector:@selector(computationTime) object:nil];
                        [funcVC showToastWithText:@"文件不存在"];
                        [strongSelf addMessageText:@"agps file is no exist"];
                    }
                }];
                //agps文件传输完成，启动写入
                [IDOUpdateAgpsManager updateAgpsTransmissionComplete:^(int errorCode) {
                    __strong typeof(self) strongSelf = weakSelf;
                    if(errorCode == 0) {
                        [funcVC showLoadingWithMessage:@"文件写入..."];
                        [strongSelf addMessageText:@"agps file writing..."];
                    }else {
                        [funcVC showToastWithText:@"文件传输失败"];
                        [strongSelf addMessageText:@"agps file transmission failed"];
                        [NSObject cancelPreviousPerformRequestsWithTarget:strongSelf selector:@selector(computationTime) object:nil];
                    }
                } writeComplete:^(int errorCode) {//写入文件成功
                    if (errorCode == 0) {
                        [funcVC showToastWithText:@"文件写入成功"];
                        [strongSelf addMessageText:@"agps file write sucess"];
                        [strongSelf addMessageText:[NSString stringWithFormat:@"agps file time of update : %ld",strongSelf.theLength]];
                        [NSObject cancelPreviousPerformRequestsWithTarget:strongSelf selector:@selector(computationTime) object:nil];
                    }else {
                        [funcVC showToastWithText:@"文件写入失败"];
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
