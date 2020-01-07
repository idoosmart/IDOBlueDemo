//
//  UpdateWordViewModel.m
//  IDOBlue
//
//  Created by 何东阳 on 2019/12/5.
//  Copyright © 2019 hedongyang. All rights reserved.
//

#import "UpdateWordViewModel.h"
#import "FileViewModel.h"
#import "FuncCellModel.h"
#import "EmpltyCellModel.h"
#import "TextViewCellModel.h"
#import "FuncViewController.h"
#import "EmptyTableViewCell.h"
#import "OneButtonTableViewCell.h"
#import "OneTextViewTableViewCell.h"

@interface UpdateWordViewModel()
@property (nonatomic,copy) NSString * logStr;
@property (nonatomic,strong) UITextView * textView;
@property (nonatomic,strong) NSString * filePath;
@property (nonatomic,copy)void(^textViewCallback)(UITextView * textView);
@property (nonatomic,copy)void(^labelSelectCallback)(UIViewController * viewController,NSString * titleStr);
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation UpdateWordViewModel

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
    vc.title = lang(@"selected agps file");
    [[IDODemoUtility getCurrentVC].navigationController pushViewController:vc animated:YES];
}

- (void)selectFileNotice:(NSNotification*)notice
{
    NSString * filePath = [[NSUserDefaults standardUserDefaults]objectForKey:TRAN_FILE_PATH_KEY];
    NSString * infoStr = [self selectedFileWithFilePath:filePath];
    [self addMessageText:infoStr];
}

- (void)getCellModels
{
    NSString * filePath = [[NSUserDefaults standardUserDefaults]objectForKey:TRAN_FILE_PATH_KEY];
    self.logStr = [self selectedFileWithFilePath:filePath];
    
    FuncCellModel * model1 = [[FuncCellModel alloc]init];
    model1.typeStr = @"oneButton";
    model1.data    = @[lang(@"word update")];
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
    NSData * data = [NSData dataWithContentsOfFile:self.filePath];
    NSString * dataSize = [NSString stringWithFormat:@"%ld bytes",(long)data.length];
    NSString * nameStr = [@"Name : "stringByAppendingString:fileName];
    NSString * sizeStr = [@"Size : "stringByAppendingString:dataSize];
    NSString * typeStr = [@"Type : "stringByAppendingString:@"word File"];
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
        [funcVC showLoadingWithMessage:[NSString stringWithFormat:@"%@...",lang(@"word update")]];
        initTransferManager().transferType = IDO_DATA_FILE_TRAN_WORD_TYPE;
        initTransferManager().fileName = @"";
        initTransferManager().filePath = strongSelf.filePath;
        initTransferManager().isResponse = [[NSUserDefaults standardUserDefaults]boolForKey:IS_RESPONSE_KEY];
        initTransferManager().isSetConnectParam = [[NSUserDefaults standardUserDefaults]boolForKey:IS_SET_CONNECT_PARAMSERS];
        initTransferManager().addDetection(^(int errorCode) {
            strongSelf.textView.text = [NSString stringWithFormat:@"%@\n%@\n\n",strongSelf.textView.text,[IDOErrorCodeToStr errorCodeToStr:errorCode]];
            [funcVC showToastWithText:lang(@"transfer complete")];
        }).addProgress(^(int progress) {
            [funcVC showSyncProgress:progress/100.0f];
        }).addTransfer(^(int errorCode) {
            strongSelf.textView.text = [NSString stringWithFormat:@"%@\n%@\n\n",strongSelf.textView.text,[IDOErrorCodeToStr errorCodeToStr:errorCode]];
            [funcVC showToastWithText:lang(@"transfer complete")];
        });
        [IDOTransferFileManager startTransfer];
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
