//
//  QueryActivityDetailViewModel.m
//  IDOBlue
//
//  Created by 何东阳 on 2019/3/14.
//  Copyright © 2019年 hedongyang. All rights reserved.
//

#import "QueryActivityDetailViewModel.h"
#import "TextViewCellModel.h"
#import "OneTextViewTableViewCell.h"
#import "IDODemoUtility.h"
#import "NSObject+ModelToDic.h"

@interface QueryActivityDetailViewModel()
@property (nonatomic,strong) UITextView * textView;
@property (nonatomic,copy)void(^textViewCallback)(UITextView * textView);
@end

@implementation QueryActivityDetailViewModel
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
    TextViewCellModel * model1 = [[TextViewCellModel alloc]init];
    model1.typeStr = @"oneTextView";
    model1.textViewCallback = self.textViewCallback;
    model1.cellHeight = [IDODemoUtility getCurrentVC].view.frame.size.height - 40;
    model1.cellClass  = [OneTextViewTableViewCell class];
    self.cellModels = @[model1];
}

- (void)getTextViewCallback
{
    __weak typeof(self) weakSelf = self;
    self.textViewCallback = ^(UITextView *textView) {
        __strong typeof(self) strongSelf = weakSelf;
        strongSelf.textView = textView;
        strongSelf.textView.text = [NSString stringWithFormat:@"%@",strongSelf.activityModel.dicFromObject];
    };
}

- (void)setActivityModel:(IDOBluetoothBaseModel *)activityModel
{
    _activityModel = activityModel;
    self.textView.text = [NSString stringWithFormat:@"%@",activityModel.dicFromObject];
}

@end
