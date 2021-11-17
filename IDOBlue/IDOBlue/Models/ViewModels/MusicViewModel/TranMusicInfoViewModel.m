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
@property (nonatomic,strong) NSMutableArray <IDOMusicFileTransferModel *>* models;
@property (nonatomic,strong) UITextField * textField1;
@property (nonatomic,strong) UITextField * textField2;
@property (nonatomic,strong) UITextField * textField3;
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
        self.rightButtonTitle = lang(@"selected music file");
        self.isRightButton = YES;
        self.rightButton   = @selector(actionButton:);
        [self getTextFeildCallback];
        [self getButtonCallback];
        [self getTextViewCallback];
        [self getCellModels];
        [[NSNotificationCenter defaultCenter]addObserver:self
                                                selector:@selector(selectFileNotice:)
                                                    name:@"idoDemoSelectFileNotice"
                                                  object:nil];
        [IDOMusicFileManager shareInstance].delegate = self;
    }
    return self;
}
- (NSMutableArray <IDOMusicFileTransferModel *>*)models
{
    if (!_models) {
         _models = [NSMutableArray new];
    }
    return _models;
}

- (void)actionButton:(UIButton *)sender
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
    NSString * infoStr = [self selectedFileWithFilePath:filePath];
    [self addMessageText:infoStr];
}

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
    model2.titleStr = lang(@"music name");
    model2.data = @[@""];
    model2.cellHeight = 70.0f;
    model2.cellClass = [OneTextFieldTableViewCell class];
    model2.modelClass = [NSNull class];
    model2.isShowLine = YES;
    model2.isShowKeyboard = YES;
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
    
    TextFieldCellModel * model4 = [[TextFieldCellModel alloc]init];
    model4.typeStr = @"oneTextField";
    model4.titleStr = lang(@"music id");
    model4.data = @[@(0)];
    model4.cellHeight = 70.0f;
    model4.cellClass = [OneTextFieldTableViewCell class];
    model4.modelClass = [NSNull class];
    model4.isShowLine = YES;
    model4.isShowKeyboard = YES;
    model4.keyType = UIKeyboardTypeNumberPad;
    model4.textFeildCallback  = self.textFeildCallback;
    
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
    
    self.cellModels = @[model2,model3,model4,model1,model6,model5];
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
    NSString * typeStr = [@"Type : "stringByAppendingString:@"music File"];
    NSString * fileStr = [NSString stringWithFormat:@"%@\n%@\n%@",nameStr,sizeStr,typeStr];
    IDOMusicFileTransferModel * model = [IDOMusicFileTransferModel new];
    model.fileName = [fileName copy];
    model.filePath = [path copy];
    model.musicId  = [self.textField3.text integerValue];
    model.singerName = self.textField2.text?:@"";
    model.musicName  = self.textField1.text?:@"";
    model.musicMemory = data.length;
    [self.models addObject:model];
    fileStr = [fileStr stringByAppendingFormat:@"\n%@",model.dicFromObject];
    return fileStr;
}

- (void)addMessageText:(NSString *)message
{
    self.logStr = [NSString stringWithFormat:@"%@\n\n%@",self.textView.text,message];
    TextViewCellModel * model = [self.cellModels lastObject];
    model.data = @[self.logStr?:@""];
    self.textView.text = self.logStr;
    [self.textView scrollRangeToVisible:NSMakeRange(self.textView.text.length,1)];
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
            [IDOMusicFileManager shareInstance].models = strongSelf.models;
            if ([[IDOMusicFileManager shareInstance] startTransfer]) {
                [funcVC showLoadingWithMessage:[NSString stringWithFormat:@"%@...",lang(@"transfer music file")]];
            }else {
                [funcVC showToastWithText:lang(@"transfer music file failed")];
            }
        }else {
            [[IDOMusicFileManager shareInstance] stopTransfer];
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
        }else if (indexPath.row == 1) {
            strongSelf.textField2 = textField;
        }else if (indexPath.row == 2) {
            strongSelf.textField3 = textField;
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

- (void)musicFileTransferComplete:(int)errorCode {
    FuncViewController * funcVC = (FuncViewController *)[IDODemoUtility getCurrentVC];
    if (errorCode == 0) {
        [funcVC showToastWithText:lang(@"transfer music file success")];
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

- (void)getMusicFileInfoReplyModel:(IDOMusicInfoModel *)model
                         errorCode:(int)errorCode
{
    FuncViewController * funcVC = (FuncViewController *)[IDODemoUtility getCurrentVC];
    if (errorCode == 0) {
        [funcVC showToastWithText:lang(@"get music list info success")];
        NSDictionary * dic = model.dicFromObject;
        self.textView.text = [NSString stringWithFormat:@"%@",dic];
    }else if (errorCode == 6) {
        [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
    }else {
        [funcVC showToastWithText:lang(@"get music list info failed")];
    }
}

@end
