//
//  UpdateSportIconViewModel.m
//  IDOBlue
//
//  Created by hedongyang on 2021/11/11.
//  Copyright © 2021 hedongyang. All rights reserved.
//

#import "UpdateSportIconViewModel.h"
#import "FuncViewController.h"
#import "FuncCellModel.h"
#import "FileViewModel.h"
#import "OneButtonTableViewCell.h"
#import "TextFieldCellModel.h"
#import "OneTextFieldTableViewCell.h"
#import "TextViewCellModel.h"
#import "OneTextViewTableViewCell.h"
#import "NSObject+DemoToDic.h"

@interface UpdateSportIconViewModel ()<IDOSportIconManagerDelegate>
@property (nonatomic,copy) NSString * logStr;
@property (nonatomic,strong) UITextView * textView;
@property (nonatomic,strong) NSString * filePath;
@property (nonatomic,strong) NSString * fileName;
@property (nonatomic,strong) NSMutableArray <IDOSportIconModel *>* models;
@property (nonatomic,copy)void(^textViewCallback)(UITextView * textView);
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation UpdateSportIconViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getTextViewCallback];
        [self getButtonCallback];
        [self getCellModels];
        [IDOSportIconManager shareInstance].delegate = self;
        self.rightButtonTitle = lang(@"selected agps file");
        self.isRightButton = YES;
        self.rightButton   = @selector(actionButton:);
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

- (NSMutableArray <IDOSportIconModel *>*)models
{
    if (!_models) {
         _models = [NSMutableArray new];
    }
    return _models;
}

- (void)selectFileNotice:(NSNotification*)notice
{
    NSString * filePath = [[NSUserDefaults standardUserDefaults]objectForKey:TRAN_FILE_PATH_KEY];
    NSString * infoStr = [self selectedFileWithFilePath:filePath];
    [self addMessageText:infoStr];
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
    NSString * typeStr = [@"Type : "stringByAppendingString:@"photo type"];
    NSString * fileStr = [NSString stringWithFormat:@"%@\n%@\n%@",nameStr,sizeStr,typeStr];
    IDOSportIconModel * model = [IDOSportIconModel new];
    model.filePath = [path copy];
    NSInteger type = 0;
    NSRange range1 = [lastPathComponent rangeOfString:@"_"];
    NSRange range2 = [lastPathComponent rangeOfString:@"."];
    if (range1.location != NSNotFound && range2.location != NSNotFound) {
        NSString * type_str = [lastPathComponent substringWithRange:NSMakeRange(range1.location + 1,(range2.location - (range1.location + 1)))];
        type = [type_str integerValue];
    }
    BOOL isMotion = [lastPathComponent rangeOfString:@"motion_"].location != NSNotFound;
    BOOL isBig = [lastPathComponent rangeOfString:@"60_"].location != NSNotFound;
    model.iconType = isMotion ? 3 : (isBig ? 2 : 1);
    model.sportType = type;
    model.iconNum = isMotion ? 20 : 1;
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
    [self.textView scrollRangeToVisible:NSMakeRange(self.textView.text.length, 1)];
}


- (void)handleIconLogMessage:(NSString *)message
{
    self.logStr = [NSString stringWithFormat:@"%@\n\n%@",self.textView.text,message];
    TextViewCellModel * model = [self.cellModels lastObject];
    model.data = @[self.logStr?:@""];
    self.textView.text = self.logStr;
    [self.textView scrollRangeToVisible:NSMakeRange(self.textView.text.length,1)];
}

- (void)getCellModels
{
    TextViewCellModel * model1 = [[TextViewCellModel alloc]init];
    model1.typeStr = @"oneTextView";
    model1.data    = @[@""];
    model1.textViewCallback = self.textViewCallback;
    model1.cellHeight = [UIScreen mainScreen].bounds.size.height / 2 - 20;
    model1.cellClass  = [OneTextViewTableViewCell class];
    
    FuncCellModel * model6 = [[FuncCellModel alloc]init];
    model6.typeStr = @"oneButton";
    model6.data = @[lang(@"start transfer icon file")];
    model6.cellHeight = 70.0f;
    model6.cellClass = [OneButtonTableViewCell class];
    model6.modelClass = [NSNull class];
    model6.isShowLine = YES;
    model6.buttconCallback = self.buttconCallback;
    
    self.cellModels = @[model6,model1];
}

- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        NSIndexPath * indexPath =  [funcVC.tableView indexPathForCell:tableViewCell];
        BaseCellModel * model = [strongSelf.cellModels objectAtIndex:indexPath.row];
        if (model.index == 0) {
            if (!__IDO_FUNCTABLE__.funcTable35Model.notifyIconAdaptive) {
                [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
                return;
            }
            [IDOSportIconManager shareInstance].iconModels = strongSelf.models;
            [funcVC showLoadingWithMessage:[NSString stringWithFormat:@"%@...",lang(@"transfer icon file")]];
            [[IDOSportIconManager shareInstance] startTransfer];
        }
    };
}

- (void)sportIconTransferProgress:(float)progress
{
    FuncViewController * funcVC = (FuncViewController *)[IDODemoUtility getCurrentVC];
    [funcVC showSyncProgress:progress];
}

- (void)sportIconTransferComplete:(int)errorCode
                          message:(NSString *)message
{
    NSLog(@"message === %@",message);
    FuncViewController * funcVC = (FuncViewController *)[IDODemoUtility getCurrentVC];
    if (errorCode == 0) {
        [funcVC showToastWithText:lang(@"transfer icon file success")];
    }else {
        [funcVC showToastWithText:lang(@"transfer icon file failed")];
    }
}

- (nonnull NSString *)getPathWithSportIconSize:(CGSize)size
                                     iconModel:(nonnull IDOSportIconModel *)model
{
    /**
     Determine whether the size of the current picture is the same according to the returned size,
     if not, crop the original picture, if it is the same, return the current address directly
     */
    return model.filePath;
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
