//
//  ShowLogViewModel.m
//  IDOBlue
//
//  Created by hedongyang on 2018/9/30.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "ShowLogViewModel.h"
#import "OneTextViewTableViewCell.h"
#import "TextViewCellModel.h"
#import "IDODemoUtility.h"
#import "FuncViewController.h"

@interface ShowLogViewModel()<UITextViewDelegate,UIScrollViewDelegate>
@property (nonatomic,strong) UITextView * textView;
@property (nonatomic,copy)void(^textViewCallback)(UITextView * textView);
@property (nonatomic,strong) NSFileHandle * fileHandle;
@property (nonatomic,assign) NSInteger fileSize;
@end

@implementation ShowLogViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getTextViewCallback];
        [self getCellModels];
    }
    return self;
}

- (void)getCellModels
{
    TextViewCellModel * model = [[TextViewCellModel alloc]init];
    model.typeStr = @"oneTextView";
    model.cellHeight = [IDODemoUtility getCurrentVC].view.bounds.size.height-40;
    model.cellClass  = [OneTextViewTableViewCell class];
    model.textViewCallback = self.textViewCallback;
    self.cellModels = @[model];
}

- (void)getTextViewCallback
{
    __weak typeof(self) weakSelf = self;
    self.textViewCallback = ^(UITextView *textView) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)[IDODemoUtility getCurrentVC];
        funcVC.tableView.scrollEnabled = NO;
        strongSelf.textView = textView;
        strongSelf.textView.delegate = strongSelf;
    };
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y + scrollView.frame.size.height >= scrollView.contentSize.height) {
        unsigned long long offset = self.fileHandle.offsetInFile;
        if (offset >= self.fileSize)return;
        [self.fileHandle seekToFileOffset:offset];
        NSData * data = nil;
        if (offset + 5000 <= self.fileSize) {
            data = [self.fileHandle readDataOfLength:5000];
        }else {
            data = [self.fileHandle readDataToEndOfFile];
        }
        NSString * str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        self.textView.text = [self.textView.text stringByAppendingString:str];
    }
}

- (void)setFilePath:(NSString *)filePath
{
    _filePath = filePath;
    NSFileManager * manager = [NSFileManager defaultManager];
    NSDictionary * dic = [manager fileAttributesAtPath:_filePath traverseLink: NO] ;
    self.fileSize = [[dic valueForKey:NSFileSize] integerValue];
    self.fileHandle = [NSFileHandle fileHandleForReadingAtPath:_filePath];
    NSData * data = nil;
    if (self.fileSize >= 5000) {
        data = [self.fileHandle readDataOfLength:5000];
    }else {
        data = [self.fileHandle readDataToEndOfFile];
    }
    NSString * str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    TextViewCellModel * model = [self.cellModels firstObject];
    model.data = @[str?:@""];
    FuncViewController * funcVc = (FuncViewController *)[IDODemoUtility getCurrentVC];
    [funcVc reloadData];
}

@end
