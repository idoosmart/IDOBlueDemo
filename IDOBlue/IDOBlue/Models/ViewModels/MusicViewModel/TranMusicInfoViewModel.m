//
//  TranMusicInfoViewModel.m
//  IDOBlue
//
//  Created by huangkunhe on 2021/9/27.
//  Copyright © 2021 hedongyang. All rights reserved.
//

#import "TranMusicInfoViewModel.h"
#import "FileViewModel.h"
#import "NSObject+DemoToDic.h"
#import "FuncCellModel.h"
#import "EmpltyCellModel.h"
#import "TextFieldCellModel.h"
#import "TextViewCellModel.h"
#import "FuncViewController.h"
#import "EmptyTableViewCell.h"
#import "OneButtonTableViewCell.h"
#import "OneTextViewTableViewCell.h"
#import "OneTextFieldTableViewCell.h"

@interface TranMusicInfoViewModel()<IDOMusicFileManagerDelegate>
@property (nonatomic,copy) NSString * logStr;
@property (nonatomic,strong) UITextView * textView;
@property (nonatomic,strong) NSString * filePath;
@property (nonatomic,copy)void(^textViewCallback)(UITextView * textView);
@property (nonatomic,copy)void(^labelSelectCallback)(UIViewController * viewController,NSString * titleStr);
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^textFeildCallback)(UIViewController * viewController,UITextField * textField,UITableViewCell * tableViewCell);
@property (nonatomic,strong) UITextField * textField1;
@property (nonatomic,strong) UITextField * textField2;
@property (nonatomic,strong) UITextField * textField3;

@property (nonatomic,strong)IDOMusicFileTransferModel * currentMusicModel;
@end

@implementation TranMusicInfoViewModel
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.rightButtonTitle = lang(@"clear log display");
        self.isRightButton = YES;
        self.rightButton   = @selector(clearMusicInfoAction);
        [self getTextFeildCallback];
        [self getButtonCallback];
        [self getTextViewCallback];
        [self getCellModels];
        [[NSNotificationCenter defaultCenter]addObserver:self
                                                selector:@selector(selectFileNotice:)
                                                    name:@"idoDemoSelectFileNotice"
                                                  object:nil];
        [IDOMusicFileManager shareInstance].delegate = self;
        
        //get music info: Get the largest music id
        [self getMusicInfo];
    }
    return self;
}
#pragma mark clear music info log
-(void)clearMusicInfoAction{
    self.textView.text = @"";
}

#pragma mark selected music file
- (void)selectedMusicAction
{
    FuncViewController * vc = [[FuncViewController alloc]init];
    FileViewModel * fileModel = [FileViewModel new];
    fileModel.type = 1;
    vc.model = fileModel;
    vc.title = lang(@"selected music file");
    [[IDODemoUtility getCurrentVC].navigationController pushViewController:vc animated:YES];
}

- (void)selectFileNotice:(NSNotification*)notice
{
    NSString * filePath = [[NSUserDefaults standardUserDefaults]objectForKey:TRAN_FILE_PATH_KEY];
    [self selectedFileWithFilePath:filePath];
}
- (void)addMessageText:(NSString *)message
{
    self.logStr = [NSString stringWithFormat:@"%@\n\n%@",self.textView.text,message];
    TextViewCellModel * model = [self.cellModels lastObject];
    model.data = @[self.logStr?:@""];
    self.textView.text = self.logStr;
    [self.textView scrollRangeToVisible:NSMakeRange(self.textView.text.length,1)];
}

- (void)selectedFileWithFilePath:(NSString *)filePath
{
    if (filePath.length == 0) return;
    NSInteger fileMode  = [[[NSUserDefaults standardUserDefaults]objectForKey:FILE_MODE_KEY] integerValue];
    NSString * fileName = @"";
    NSString * path = @"";
    if (fileMode == 0) { // bundle
        NSString * mainPath = [NSBundle mainBundle].bundlePath;
        path = [mainPath stringByAppendingPathComponent:@"Files"];
        fileName = filePath.lastPathComponent;
        path = [path stringByAppendingPathComponent:fileName];
    }else { // sandbox
        path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) lastObject];
        NSRange range = [filePath rangeOfString:@"Documents"];
        if (range.location != NSNotFound) {
            fileName = [filePath substringFromIndex:range.location + range.length + 1];
            path = [path stringByAppendingPathComponent: fileName];
        }
    }
    self.filePath = path;
    NSData * data = [NSData dataWithContentsOfFile:self.filePath];
    NSString * dataSize = [NSString stringWithFormat:@"%ld bytes",(long)data.length];
    NSString * nameStr = [@"Name : "stringByAppendingString:fileName];
    NSString * sizeStr = [@"Size : "stringByAppendingString:dataSize];
    NSString * typeStr = [@"Type : "stringByAppendingString:@"music File"];
    NSString * fileStr = [NSString stringWithFormat:@"%@\n%@\n%@",nameStr,sizeStr,typeStr];
    
    
    self.textField1.text = [fileName copy];;
    self.currentMusicModel.fileName = [fileName copy];
    self.currentMusicModel.filePath = [path copy];
    self.currentMusicModel.musicName  = [fileName copy];
    self.currentMusicModel.musicMemory = data.length;
}

#pragma mark init view
- (void)getCellModels
{
    FuncCellModel * model1 = [[FuncCellModel alloc]init];
    model1.typeStr = @"oneButton";
    model1.data    = @[lang(@"start transfer music file")];
    model1.cellHeight = 70.0f;
    model1.index = 0;
    model1.buttconCallback = self.buttconCallback;
    model1.cellClass  = [OneButtonTableViewCell class];
    
    TextFieldCellModel * model2 = [[TextFieldCellModel alloc]init];
    model2.typeStr = @"oneTextField";
    model2.titleStr = lang(@"selected music file");
    model2.data = @[@""];
    model2.placeholders = @[lang(@"selected agps file")];
    model2.cellHeight = 70.0f;
    model2.cellClass = [OneTextFieldTableViewCell class];
    model2.modelClass = [NSNull class];
    model2.isShowLine = YES;
    model2.textFeildCallback  = self.textFeildCallback;
        
    
    TextFieldCellModel * model3 = [[TextFieldCellModel alloc]init];
    model3.typeStr = @"oneTextField";
    model3.titleStr = lang(@"singer name");
    model3.data = @[@""];
    model3.cellHeight = 70.0f;
    model3.cellClass = [OneTextFieldTableViewCell class];
    model3.modelClass = [NSNull class];
    model3.isShowLine = YES;
    model3.isShowKeyboard = YES;
    model3.textFeildCallback  = self.textFeildCallback;
        
    TextViewCellModel * model5 = [[TextViewCellModel alloc]init];
    model5.typeStr = @"oneTextView";
    model5.data    = @[self.logStr ?: @""];
    model5.textViewCallback = self.textViewCallback;
    model5.cellHeight = [UIScreen mainScreen].bounds.size.height / 2 - 20;
    model5.cellClass  = [OneTextViewTableViewCell class];
    
    FuncCellModel * model6 = [[FuncCellModel alloc]init];
    model6.typeStr = @"oneButton";
    model6.data    = @[lang(@"stop transfer music file")];
    model6.cellHeight = 70.0f;
    model6.index = 1;
    model6.buttconCallback = self.buttconCallback;
    model6.cellClass  = [OneButtonTableViewCell class];
    
    FuncCellModel * model7 = [[FuncCellModel alloc]init];
    model7.typeStr = @"oneButton";
    model7.data    = @[lang(@"get music info")];
    model7.cellHeight = 70.0f;
    model7.index = 2;
    model7.buttconCallback = self.buttconCallback;
    model7.cellClass  = [OneButtonTableViewCell class];
    
    self.cellModels = @[model2,model3,model7,model1,model6,model5];
}

- (IDOMusicFileTransferModel *)currentMusicModel{
    if (!_currentMusicModel) {
        _currentMusicModel = [IDOMusicFileTransferModel new];
        _currentMusicModel.musicId = 1;//default
    }
    return _currentMusicModel;
}

-(void)getMusicInfo{
    [IDOMusicFileManager getMusicInfo];
}

- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        if (!IDO_BLUE_ENGINE.managerEngine.isConnected)return ;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath =  [funcVC.tableView indexPathForCell:tableViewCell];
        BaseCellModel * model = [strongSelf.cellModels objectAtIndex:indexPath.row];
        if (model.index == 0) {
            if (strongSelf.currentMusicModel.singerName.length <= 0) {
                NSString*errorMsg = [NSString stringWithFormat:@"%@ == nil",lang(@"singer name")];
                [funcVC showToastWithText:errorMsg];
            }else if (strongSelf.currentMusicModel.musicName.length <= 0 || strongSelf.currentMusicModel.musicId <= 0) {
                [funcVC showToastWithText:lang(@"selected music file")];
            }else{
                [IDOMusicFileManager shareInstance].models = @[strongSelf.currentMusicModel];
                if ([[IDOMusicFileManager shareInstance] startTransfer]) {
                    [funcVC showLoadingWithMessage:[NSString stringWithFormat:@"%@...",lang(@"transfer music file")]];
                }else {
                    [funcVC showToastWithText:lang(@"transfer music file failed")];
                }
            }
        }else  if (model.index == 1) {
            [[IDOMusicFileManager shareInstance] stopTransfer];
        }else{
            [funcVC showLoadingWithMessage:[NSString stringWithFormat:@"%@...",lang(@"get music list info")]];
            [strongSelf getMusicInfo];
        }
        
    };
}

- (void)getTextFeildCallback {
    __weak typeof(self) weakSelf = self;
    self.textFeildCallback = ^(UIViewController *viewController, UITextField *textField, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVC.tableView indexPathForCell:tableViewCell];
        if (indexPath.row == 0) {
            strongSelf.textField1 = textField;
            [strongSelf selectedMusicAction];
        }else if (indexPath.row == 1) {
            strongSelf.textField2 = textField;
            strongSelf.currentMusicModel.singerName = textField.text;
        }
        
        TextFieldCellModel * textFieldModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
        textFieldModel.data = @[textField.text];
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

//获取音乐信息回调数据
#pragma  mark Get music information callback data
- (void)getMusicFileInfoReplyModel:(IDOMusicInfoModel *)model
                         errorCode:(int)errorCode
{
    FuncViewController * funcVC = (FuncViewController *)[IDODemoUtility getCurrentVC];
    if (errorCode == 0) {
        [funcVC showToastWithText:lang(@"get music list info success")];
        if (model.musicItems.count > 0) {
            for (IDOMusicFileModel *musicfileModel in model.musicItems) {
                if (musicfileModel.musicId > self.currentMusicModel.musicId) {
                    //Cache maximum id
                    self.currentMusicModel.musicId = musicfileModel.musicId + 1;
                }
            }
        }
        NSDictionary * dic = model.dicFromObject;
        self.textView.text = [NSString stringWithFormat:@"%@",dic];
    }else if (errorCode == 6) {
        [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
    }else {
        [funcVC showToastWithText:lang(@"get music list info failed")];
    }
}


- (void)oneOfMusicFileStartCorrectSamplingRate
{
    FuncViewController * funcVC = (FuncViewController *)[IDODemoUtility getCurrentVC];
    [funcVC showLoadingWithMessage:lang(@"start modifying the MP3 sample rate")];
}

- (void)oneOfMusicFileEndCorrectSamplingRate
{
    FuncViewController * funcVC = (FuncViewController *)[IDODemoUtility getCurrentVC];
    [funcVC showToastWithText:lang(@"finish modifying the mp3 sample rate")];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [funcVC showLoadingWithMessage:[NSString stringWithFormat:@"%@...",lang(@"transfer music file")]];
    });
}

- (void)musicFileTransferComplete:(int)errorCode {
    FuncViewController * funcVC = (FuncViewController *)[IDODemoUtility getCurrentVC];
    if (errorCode == 0) {
        [funcVC showToastWithText:lang(@"Successfully transferred music, updated the latest music list information")];
        [self getMusicInfo];
    }else if (errorCode == 6) {
        [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
    }else {
        [funcVC showToastWithText:lang(@"transfer music file failed")];
    }
}

- (void)musicFileTransferProgress:(float)progress {
    FuncViewController * funcVC = (FuncViewController *)[IDODemoUtility getCurrentVC];
    [funcVC showSyncProgress:progress];
}



@end
