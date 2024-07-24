//
//  GetDefaultLanguageViewModel.m
//  IDOBlue
//
//  Created by hedongyang on 2020/4/3.
//  Copyright © 2020 hedongyang. All rights reserved.
//

#import "GetDefaultLanguageViewModel.h"
#import "FuncCellModel.h"
#import "OneButtonTableViewCell.h"
#import "TextViewCellModel.h"
#import "OneTextViewTableViewCell.h"
#import "IDODemoUtility.h"
#import "FuncViewController.h"
#import "NSObject+DemoToDic.h"

@interface GetDefaultLanguageViewModel()
@property (nonatomic,strong) UITextView * textView;
@property (nonatomic,copy)void(^textViewCallback)(UITextView * textView);
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation GetDefaultLanguageViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getButtonCallback];
        [self getTextViewCallback];
        [self getCellModels];
    }
    return self;
}

- (void)getTextViewCallback
{
    __weak typeof(self) weakSelf = self;
    self.textViewCallback = ^(UITextView *textView) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)[IDODemoUtility getCurrentVC];
        funcVC.tableView.scrollEnabled = NO;
        strongSelf.textView = textView;
    };
}

- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        [funcVC showLoadingWithMessage:[NSString stringWithFormat:@"%@...",lang(@"get default language")]];
        
        if (__IDO_FUNCTABLE__.funcTable31Model.v3GetLangLib) {
            [IDOFoundationCommand getV3LangLibListCommand:^(int errorCode, IDOGetV3LangLibListModel * _Nullable data) {
                if (errorCode == 0) {
                    [funcVC showToastWithText:lang(@"get default language success")];
                    strongSelf.textView.text = [NSString stringWithFormat:@"%@",data.dicFromObject];
                }else if (errorCode == 6) {
                    [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
                }else {
                    [funcVC showToastWithText:lang(@"get default language failed")];
                }
            }];
            
            return;
        }else{
            [IDOFoundationCommand getDefaultLanguageCommand:^(int errorCode, IDOGetDownLanguageBluetoothModel * _Nullable data) {
                if (errorCode == 0) {
                    [funcVC showToastWithText:lang(@"get default language success")];
                    strongSelf.textView.text = [NSString stringWithFormat:@"%@",data.dicFromObject];
                }else if (errorCode == 6) {
                    [funcVC showToastWithText:lang(@"feature is not supported on the current device")];
                }else {
                    [funcVC showToastWithText:lang(@"get default language failed")];
                }
            }];
        }
        
//        if (__IDO_FUNCTABLE__.funcTable26Model.downloadLanguage) {
            
            
//        }
        
        
    };
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    FuncCellModel * model = [[FuncCellModel alloc]init];
    model.typeStr = @"oneButton";
    model.data = @[lang(@"get default language")];
    model.cellHeight = 70.0f;
    model.cellClass = [OneButtonTableViewCell class];
    model.modelClass = [NSNull class];
    model.isShowLine = YES;
    model.buttconCallback = self.buttconCallback;
    [cellModels addObject:model];
    
    TextViewCellModel * model2 = [[TextViewCellModel alloc]init];
    model2.typeStr = @"oneTextView";
    model2.cellHeight = [IDODemoUtility getCurrentVC].view.bounds.size.height-110;
    model2.cellClass  = [OneTextViewTableViewCell class];
    model2.textViewCallback = self.textViewCallback;
    IDOGetDownLanguageBluetoothModel * langModel = [IDOGetDownLanguageBluetoothModel currentModel];
    NSString * str = [NSString stringWithFormat:@"%@",langModel.dicFromObject];
    model2.data = @[str];
    [cellModels addObject:model2];
    
    self.cellModels = cellModels;
}

@end
